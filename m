Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5079938C
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 02:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjIIAZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 20:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbjIIAZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 20:25:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFD268E;
        Fri,  8 Sep 2023 17:25:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3971BC4339A;
        Sat,  9 Sep 2023 00:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219062;
        bh=vI048ai7Tvc1XjNI9VEqtqCsulY5/lWzKTLlfFS1LU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Po3DBy/Apdiu+U+Qp+XdOtSyTEmTwa2svTWvJh3D/DvFbZtFduveZBw4r6jbvQTuB
         twva0rBEbl5ogOtxZNn24RTmJWilHIJlfkQZqAdM2MJSJ1IRkQHcozmVO5hmYxzJqP
         c0D+o0rKV1OWDxpllhGt7urIXMRi2WTHdETI4ZozuRKBWv2AM3A/wjOqtnNqeU56Ga
         m6uzd/6cIzSMRKxnsZLKrdlWUMfJk4RXa0vHU7axNgpLX1uxq2kN/nEaRHbPKRkusz
         /EqOaVOQN8SJlJPI6Ke0+y+EbRMM0stBuYClwmeX8yZRPIYKzkTuizT1kMZLy3cjou
         gjDGS2P/GStwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, tyreld@linux.ibm.com,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 6/6] PCI: rpaphp: Error out on busy status from get-sensor-state
Date:   Fri,  8 Sep 2023 20:24:05 -0400
Message-Id: <20230909002406.3578776-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002406.3578776-1-sashal@kernel.org>
References: <20230909002406.3578776-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mahesh Salgaonkar <mahesh@linux.ibm.com>

[ Upstream commit 77583f77ed9b1452ac62caebf09b2206da10bbf9 ]

When certain PHB HW failure causes pHyp to recover PHB, it marks the PE
state as temporarily unavailable until recovery is complete. This also
triggers an EEH handler in Linux which needs to notify drivers, and perform
recovery. But before notifying the driver about the PCI error it uses
get_adapter_status()->rpaphp_get_sensor_state()->rtas_call(get-sensor-state)
operation of the hotplug_slot to determine if the slot contains a device or
not. If the slot is empty, the recovery is skipped entirely.

eeh_event_handler()
  ->eeh_handle_normal_event()
    ->eeh_slot_presence_check()
      ->get_adapter_status()
        ->rpaphp_get_sensor_state()
          ->rtas_get_sensor()
            ->rtas_call(get-sensor-state)

However on certain PHB failures, the RTAS call rtas_call(get-sensor-state)
returns extended busy error (9902) until PHB is recovered by pHyp. Once PHB
is recovered, the rtas_call(get-sensor-state) returns success with correct
presence status. The RTAS call interface rtas_get_sensor() loops over the
RTAS call on extended delay return code (9902) until the return value is
either success (0) or error (-1). This causes the EEH handler to get stuck
for ~6 seconds before it could notify that the PCI error has been detected
and stop any active operations. Hence with running I/O traffic, during this
6 seconds, the network driver continues its operation and hits a timeout
(netdev watchdog).

------------
[52732.244731] DEBUG: ibm_read_slot_reset_state2()
[52732.244762] DEBUG: ret = 0, rets[0]=5, rets[1]=1, rets[2]=4000, rets[3]=>
[52732.244798] DEBUG: in eeh_slot_presence_check
[52732.244804] DEBUG: error state check
[52732.244807] DEBUG: Is slot hotpluggable
[52732.244810] DEBUG: hotpluggable ops ?
[52732.244953] DEBUG: Calling ops->get_adapter_status
[52732.244958] DEBUG: calling rpaphp_get_sensor_state
[52736.564262] ------------[ cut here ]------------
[52736.564299] NETDEV WATCHDOG: enP64p1s0f3 (tg3): transmit queue 0 timed o>
[52736.564324] WARNING: CPU: 1442 PID: 0 at net/sched/sch_generic.c:478 dev>
[...]
[52736.564505] NIP [c000000000c32368] dev_watchdog+0x438/0x440
[52736.564513] LR [c000000000c32364] dev_watchdog+0x434/0x440
------------

On timeouts, network driver starts dumping debug information to console
(e.g bnx2 driver calls bnx2x_panic_dump()), and go into recovery path while
pHyp is still recovering the PHB. As part of recovery, the driver tries to
reset the device and it keeps failing since every PCI read/write returns
ff's. And when EEH recovery kicks-in, the driver is unable to recover the
device. This impacts the ssh connection and leads to the system being
inaccessible. To get the NIC working again it needs a reboot or re-assign
the I/O adapter from HMC.

[ 9531.168587] EEH: Beginning: 'slot_reset'
[ 9531.168601] PCI 0013:01:00.0#10000: EEH: Invoking bnx2x->slot_reset()
[...]
[ 9614.110094] bnx2x: [bnx2x_func_stop:9129(enP19p1s0f0)]FUNC_STOP ramrod failed. Running a dry transaction
[ 9614.110300] bnx2x: [bnx2x_igu_int_disable:902(enP19p1s0f0)]BUG! Proper val not read from IGU!
[ 9629.178067] bnx2x: [bnx2x_fw_command:3055(enP19p1s0f0)]FW failed to respond!
[ 9629.178085] bnx2x 0013:01:00.0 enP19p1s0f0: bc 7.10.4
[ 9629.178091] bnx2x: [bnx2x_fw_dump_lvl:789(enP19p1s0f0)]Cannot dump MCP info while in PCI error
[ 9644.241813] bnx2x: [bnx2x_io_slot_reset:14245(enP19p1s0f0)]IO slot reset --> driver unload
[...]
[ 9644.241819] PCI 0013:01:00.0#10000: EEH: bnx2x driver reports: 'disconnect'
[ 9644.241823] PCI 0013:01:00.1#10000: EEH: Invoking bnx2x->slot_reset()
[ 9644.241827] bnx2x: [bnx2x_io_slot_reset:14229(enP19p1s0f1)]IO slot reset initializing...
[ 9644.241916] bnx2x 0013:01:00.1: enabling device (0140 -> 0142)
[ 9644.258604] bnx2x: [bnx2x_io_slot_reset:14245(enP19p1s0f1)]IO slot reset --> driver unload
[ 9644.258612] PCI 0013:01:00.1#10000: EEH: bnx2x driver reports: 'disconnect'
[ 9644.258615] EEH: Finished:'slot_reset' with aggregate recovery state:'disconnect'
[ 9644.258620] EEH: Unable to recover from failure from PHB#13-PE#10000.
[ 9644.261811] EEH: Beginning: 'error_detected(permanent failure)'
[...]
[ 9644.261823] EEH: Finished:'error_detected(permanent failure)'

Hence, it becomes important to inform driver about the PCI error detection
as early as possible, so that driver is aware of PCI error and waits for
EEH handler's next action for successful recovery.

Current implementation uses rtas_get_sensor() API which blocks the slot
check state until RTAS call returns success. To avoid this, fix the PCI
hotplug driver (rpaphp) to return an error (-EBUSY) if the slot presence
state can not be detected immediately while PE is in EEH recovery state.
Change rpaphp_get_sensor_state() to invoke rtas_call(get-sensor-state)
directly only if the respective PE is in EEH recovery state, and take
actions based on RTAS return status. This way EEH handler will not be
blocked on rpaphp_get_sensor_state() and can immediately notify driver
about the PCI error and stop any active operations.

In normal cases (non-EEH case) rpaphp_get_sensor_state() will continue to
invoke rtas_get_sensor() as it was earlier with no change in existing
behavior.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/169235815601.193557.13989873835811325343.stgit@jupiter
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/rpaphp_pci.c | 85 ++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index beca61badeea4..5228d0044caa9 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -18,12 +18,92 @@
 #include "../pci.h"		/* for pci_add_new_bus */
 #include "rpaphp.h"
 
+/*
+ * RTAS call get-sensor-state(DR_ENTITY_SENSE) return values as per PAPR:
+ * -- generic return codes ---
+ *    -1: Hardware Error
+ *    -2: RTAS_BUSY
+ *    -3: Invalid sensor. RTAS Parameter Error.
+ * -- rtas_get_sensor function specific return codes ---
+ * -9000: Need DR entity to be powered up and unisolated before RTAS call
+ * -9001: Need DR entity to be powered up, but not unisolated, before RTAS call
+ * -9002: DR entity unusable
+ *  990x: Extended delay - where x is a number in the range of 0-5
+ */
+#define RTAS_SLOT_UNISOLATED		-9000
+#define RTAS_SLOT_NOT_UNISOLATED	-9001
+#define RTAS_SLOT_NOT_USABLE		-9002
+
+static int rtas_get_sensor_errno(int rtas_rc)
+{
+	switch (rtas_rc) {
+	case 0:
+		/* Success case */
+		return 0;
+	case RTAS_SLOT_UNISOLATED:
+	case RTAS_SLOT_NOT_UNISOLATED:
+		return -EFAULT;
+	case RTAS_SLOT_NOT_USABLE:
+		return -ENODEV;
+	case RTAS_BUSY:
+	case RTAS_EXTENDED_DELAY_MIN...RTAS_EXTENDED_DELAY_MAX:
+		return -EBUSY;
+	default:
+		return rtas_error_rc(rtas_rc);
+	}
+}
+
+/*
+ * get_adapter_status() can be called by the EEH handler during EEH recovery.
+ * On certain PHB failures, the RTAS call rtas_call(get-sensor-state) returns
+ * extended busy error (9902) until PHB is recovered by pHyp. The RTAS call
+ * interface rtas_get_sensor() loops over the RTAS call on extended delay
+ * return code (9902) until the return value is either success (0) or error
+ * (-1). This causes the EEH handler to get stuck for ~6 seconds before it
+ * could notify that the PCI error has been detected and stop any active
+ * operations. This sometimes causes EEH recovery to fail. To avoid this issue,
+ * invoke rtas_call(get-sensor-state) directly if the respective PE is in EEH
+ * recovery state and return -EBUSY error based on RTAS return status. This
+ * will help the EEH handler to notify the driver about the PCI error
+ * immediately and successfully proceed with EEH recovery steps.
+ */
+
+static int __rpaphp_get_sensor_state(struct slot *slot, int *state)
+{
+	int rc;
+	int token = rtas_token("get-sensor-state");
+	struct pci_dn *pdn;
+	struct eeh_pe *pe;
+	struct pci_controller *phb = PCI_DN(slot->dn)->phb;
+
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return -ENOENT;
+
+	/*
+	 * Fallback to existing method for empty slot or PE isn't in EEH
+	 * recovery.
+	 */
+	pdn = list_first_entry_or_null(&PCI_DN(phb->dn)->child_list,
+					struct pci_dn, list);
+	if (!pdn)
+		goto fallback;
+
+	pe = eeh_dev_to_pe(pdn->edev);
+	if (pe && (pe->state & EEH_PE_RECOVERING)) {
+		rc = rtas_call(token, 2, 2, state, DR_ENTITY_SENSE,
+			       slot->index);
+		return rtas_get_sensor_errno(rc);
+	}
+fallback:
+	return rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
+}
+
 int rpaphp_get_sensor_state(struct slot *slot, int *state)
 {
 	int rc;
 	int setlevel;
 
-	rc = rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
+	rc = __rpaphp_get_sensor_state(slot, state);
 
 	if (rc < 0) {
 		if (rc == -EFAULT || rc == -EEXIST) {
@@ -39,8 +119,7 @@ int rpaphp_get_sensor_state(struct slot *slot, int *state)
 				dbg("%s: power on slot[%s] failed rc=%d.\n",
 				    __func__, slot->name, rc);
 			} else {
-				rc = rtas_get_sensor(DR_ENTITY_SENSE,
-						     slot->index, state);
+				rc = __rpaphp_get_sensor_state(slot, state);
 			}
 		} else if (rc == -ENODEV)
 			info("%s: slot is unusable\n", __func__);
-- 
2.40.1

