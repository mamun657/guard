const {
  initializeTestEnvironment,
  assertSucceeds,
  assertFails,
} = require('@firebase/rules-unit-testing');
const {
  doc,
  getDoc,
  setDoc,
  updateDoc,
  deleteDoc,
  Timestamp,
  writeBatch,
} = require('firebase/firestore');
const fs = require('fs');

const projectId = 'guard-ab0d3';
const owner = { uid: 'owner-1' };
const viewer = { uid: 'viewer-1' };
const stranger = { uid: 'stranger-1' };
const invitationId = 'INVITE1';
const devicePath = 'users/owner-1/devices/device-1';
const locationPath = `${devicePath}/location/current`;
const grantPath = `${devicePath}/approvedViewers/viewer-1`;
const requestPath = `familyInvitations/${invitationId}/requests/viewer-1`;
const incomingPath = `${devicePath}/incomingRequests/viewer-1`;
const indexPath = 'familyViewerAccess/viewer-1/grants/owner-1__device-1';

function location(capturedAt = Timestamp.fromMillis(1700000000000)) {
  return {
    ownerUid: 'owner-1',
    deviceId: 'device-1',
    latitude: 23.8,
    longitude: 90.4,
    accuracy: 10,
    capturedAt,
    syncedAt: Timestamp.now(),
    batteryLevel: 80,
    isCharging: false,
    sharingSessionId: 'session-1',
  };
}

async function seed(env) {
  await env.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await setDoc(doc(db, devicePath), {
      ownerUid: 'owner-1',
      deviceId: 'device-1',
      nickname: 'My Device',
      sharingState: 'stopped',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    });
    await setDoc(doc(db, `familyInvitations/${invitationId}`), {
      ownerUid: 'owner-1',
      ownerDisplayName: 'Owner',
      deviceId: 'device-1',
      deviceNickname: 'My Device',
      status: 'open',
      requestedCapabilities: ['viewLocation', 'viewBattery'],
      createdAt: Timestamp.now(),
      expiresAt: Timestamp.fromMillis(Date.now() + 3600000),
    });
  });
}

async function run() {
  const env = await initializeTestEnvironment({
    projectId,
    firestore: { rules: fs.readFileSync('firestore.rules', 'utf8') },
  });
  try {
    await env.clearFirestore();
    await seed(env);
    const ownerDb = env.authenticatedContext(owner.uid).firestore();
    const viewerDb = env.authenticatedContext(viewer.uid).firestore();
    const strangerDb = env.authenticatedContext(stranger.uid).firestore();

    await assertSucceeds(setDoc(doc(ownerDb, 'users/owner-1'), {
      displayName: 'Owner',
      email: 'owner@example.com',
      phoneNumber: '',
      authProvider: 'email',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    }));
    await assertSucceeds(updateDoc(doc(ownerDb, 'users/owner-1'), {
      displayName: 'Updated Owner',
      updatedAt: Timestamp.now(),
    }));
    await assertFails(updateDoc(doc(viewerDb, 'users/owner-1'), {
      authProvider: 'admin',
    }));
    await assertFails(updateDoc(doc(ownerDb, 'users/owner-1'), {
      authProvider: 'admin',
    }));

    await assertFails(getDoc(doc(viewerDb, locationPath)));
    await assertSucceeds(updateDoc(doc(ownerDb, devicePath), {
      sharingState: 'active',
      updatedAt: Timestamp.now(),
    }));
    await assertSucceeds(setDoc(doc(ownerDb, locationPath), location()));
    await assertFails(setDoc(doc(ownerDb, locationPath), {
      ...location(),
      latitude: 200,
    }));
    await assertFails(setDoc(doc(ownerDb, locationPath), {
      ...location(),
      capturedAt: '2024-01-01T00:00:00.000Z',
    }));
    await assertFails(updateDoc(doc(ownerDb, locationPath), {
      latitude: 23.81,
      capturedAt: Timestamp.fromMillis(1600000000000),
    }));

    const requestPayload = {
      viewerUid: 'viewer-1',
      ownerUid: 'owner-1',
      invitationId,
      viewerDisplayName: 'Viewer',
      viewerEmail: 'viewer@example.com',
      relationship: 'friend',
      requestedCapabilities: ['viewLocation', 'viewBattery'],
      status: 'pending',
      requestedAt: Timestamp.now(),
    };
    const incomingPayload = {
      ...requestPayload,
      deviceId: 'device-1',
    };
    await assertFails(setDoc(doc(viewerDb, incomingPath), requestPayload));
    await assertFails(setDoc(doc(ownerDb, `familyInvitations/${invitationId}/requests/owner-1`), {
      ...requestPayload,
      viewerUid: 'owner-1',
      ownerUid: 'owner-1',
    }));
    const acceptBatch = writeBatch(viewerDb);
    acceptBatch.set(doc(viewerDb, requestPath), requestPayload);
    acceptBatch.set(doc(viewerDb, incomingPath), incomingPayload);
    await assertSucceeds(acceptBatch.commit());
    const duplicateBatch = writeBatch(viewerDb);
    duplicateBatch.set(doc(viewerDb, requestPath), requestPayload);
    duplicateBatch.set(doc(viewerDb, incomingPath), incomingPayload);
    await assertFails(duplicateBatch.commit());
    await assertFails(updateDoc(doc(viewerDb, requestPath), {
      ownerUid: 'stranger-1',
    }));
    await assertFails(setDoc(doc(viewerDb, `familyInvitations/${invitationId}/requests/viewer-2`), {
      viewerUid: 'viewer-2',
      ownerUid: 'owner-1',
      invitationId,
      requestedCapabilities: ['viewLocation'],
      status: 'pending',
      requestedAt: Timestamp.now(),
    }));

    await assertSucceeds(setDoc(doc(ownerDb, grantPath), {
      viewerUid: 'viewer-1',
      ownerUid: 'owner-1',
      deviceId: 'device-1',
      invitationId,
      active: true,
      relationship: 'friend',
      viewerDisplayName: 'Viewer',
      viewerEmail: 'viewer@example.com',
      grantedAt: Timestamp.now(),
    }));
    await assertSucceeds(updateDoc(doc(ownerDb, requestPath), {
      status: 'approved',
      approvedAt: Timestamp.now(),
    }));
    await assertSucceeds(updateDoc(doc(ownerDb, incomingPath), {
      status: 'approved',
      approvedAt: Timestamp.now(),
    }));
    await assertSucceeds(setDoc(doc(ownerDb, indexPath), {
      ownerUid: 'owner-1',
      deviceId: 'device-1',
      ownerDisplayName: 'Owner',
      relationship: 'friend',
      grantedAt: Timestamp.now(),
    }));
    await assertSucceeds(updateDoc(doc(viewerDb, indexPath), {
      alias: 'Dad',
    }));
    await assertFails(updateDoc(doc(strangerDb, indexPath), {
      alias: 'Not Dad',
    }));
    await assertFails(updateDoc(doc(viewerDb, indexPath), {
      ownerUid: 'stranger-1',
    }));
    await assertFails(setDoc(doc(ownerDb, 'familyViewerAccess/viewer-1/grants/fake'), {
      ownerUid: 'owner-1',
      deviceId: 'device-1',
      ownerDisplayName: 'Owner',
      relationship: 'friend',
      grantedAt: Timestamp.now(),
    }));
    await assertFails(setDoc(doc(strangerDb, indexPath), {
      ownerUid: 'owner-1',
      deviceId: 'device-1',
      ownerDisplayName: 'Owner',
      relationship: 'friend',
      grantedAt: Timestamp.now(),
    }));

    await assertSucceeds(getDoc(doc(viewerDb, locationPath)));
    await assertSucceeds(updateDoc(doc(ownerDb, devicePath), {
      sharingState: 'paused',
      updatedAt: Timestamp.now(),
    }));
    await assertSucceeds(getDoc(doc(viewerDb, locationPath)));
    await assertSucceeds(updateDoc(doc(ownerDb, devicePath), {
      sharingState: 'stopped',
      updatedAt: Timestamp.now(),
    }));
    await assertFails(getDoc(doc(viewerDb, locationPath)));
    await assertSucceeds(updateDoc(doc(ownerDb, devicePath), {
      sharingState: 'active',
      updatedAt: Timestamp.now(),
    }));
    await assertSucceeds(deleteDoc(doc(viewerDb, grantPath)));
    await assertSucceeds(deleteDoc(doc(viewerDb, indexPath)));
    await assertFails(getDoc(doc(viewerDb, locationPath)));
    await env.withSecurityRulesDisabled(async (context) => {
      const db = context.firestore();
      await setDoc(doc(db, grantPath), {
        viewerUid: 'viewer-1',
        ownerUid: 'owner-1',
        deviceId: 'device-1',
        invitationId,
        active: true,
        relationship: 'friend',
        viewerDisplayName: 'Viewer',
        viewerEmail: 'viewer@example.com',
        grantedAt: Timestamp.now(),
      });
      await setDoc(doc(db, indexPath), {
        ownerUid: 'owner-1',
        deviceId: 'device-1',
        ownerDisplayName: 'Owner',
        relationship: 'friend',
        grantedAt: Timestamp.now(),
      });
    });
    await assertSucceeds(deleteDoc(doc(ownerDb, grantPath)));
    await assertFails(getDoc(doc(viewerDb, locationPath)));
    await assertFails(getDoc(doc(strangerDb, locationPath)));

    console.log('Firestore rules authorization tests passed.');
  } finally {
    await env.cleanup();
  }
}

run().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
