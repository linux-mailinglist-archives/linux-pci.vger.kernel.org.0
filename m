Return-Path: <linux-pci+bounces-1425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254681EDE1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AAB2837EC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B79B24B2F;
	Wed, 27 Dec 2023 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="MOd4VX03";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="nkoVJRgO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A052940A
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3A0D9C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670377; bh=Qgf3HY9Q/npWtHJ8zz2bI8mQD5n++N9iMXdOnjtXbJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MOd4VX03Vt1OzP8VhUYhClq5O6avM53NESMS2VDfjNQIxnWxdf4R9f0fgqyB56lOe
	 gh2byAM7jDMlLDq/Md39EULYj371I2nBfuV0O+tDjJT2PN6+COQMDpEtC6rpHfyopG
	 B4XhfSdnCiXeZLczWA+a6lLGyS7M3DPtxpBo3MMSXjOLhse5Z8nWmXnR+hBD2J7x/i
	 pG+WRs7eOURqpnxRgIU54zDIeucvdKMpsWxAML2MjR7b33c8ZyuNdRlLWaX1hhOaMC
	 bo6CzsoPGphUZ73ZkPSzGn+8pXX9LaKBtsbDSKny/8XYtC9U8wylyHNb8hIZ4VGv6t
	 RJ4rYs8nyeYwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670377; bh=Qgf3HY9Q/npWtHJ8zz2bI8mQD5n++N9iMXdOnjtXbJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=nkoVJRgOIMKXnGiQZ9dgMtgJYG1POI+78z1rd53HQ2IICe9vXxUMDZX1PcG0jWzOX
	 qQa1Tvna+y8hCm4edOFmHUrw3arDZNglEnj+xHeE09NNw9TgTE0Mgt1j2Y48Ku5fgP
	 Gz9kKVpdqxD3IGvIvIEpyxpKmnaIFp3vP/shH0Z4k7jsezvgWFfu38P4u/h7igs4bX
	 yCR/1Av7/L6WQ0AUtR0aH/8kctTHKeXd7AGPGaNGTnySLkaYVargxGTi0lHwbh4NV3
	 rxXja24wslK0fsvUOweJ8Kn8mB0XXxGKhvQqMr+edLNcGgg6T/r+CkMXR6M6Tu3sRo
	 +WwYVrv7xIleQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 10/15] pciutils-pcilmr: Add support for unique hardware quirks
Date: Wed, 27 Dec 2023 14:44:59 +0500
Message-ID: <20231227094504.32257-11-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Make it possible to change receiver margining parameters depending on
current hardware specificity.

In our tests Intel Ice Lake CPUs RC ports reported
MaxVoltageOffset = 50 (RxA), which led to results several times bigger
than the results of the hardware debugger.
Looks like in Intel Sapphire Rapids this was fixed, these CPU RC ports
report MaxVoltageOffset = 12 (RxA). To solve the problem it was decided
to hardcode Volt Offset to 12 (120 mV) for Ice Lake RC ports.

In the case of margining a specific link, only information about
Downstream and Upstream ports should be sufficient to decide whether to
use quirks, so the feature was implemented based on a list of devices
(vendor - device - revision triples), whose problems are known.

Back to Ice Lake ports, according to Integrators List on the pci-sig site,
the list of possible RC ports of Ice Lake Xeon's includes at least three
more options (with ids 347B/C/D) besides the one used in this commit, but
we don't have such processors to check the relevance of the MaxVoltageOffset
problem for these ports.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h        |  6 ++++++
 lmr/margin.c     | 16 ++++++++++++++++
 lmr/margin_hw.c  | 24 +++++++++++++++++++++++-
 lmr/margin_log.c | 16 ++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/lmr/lmr.h b/lmr/lmr.h
index d35b8ae..bb188fc 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -21,6 +21,8 @@
 #define MARGIN_TIM_RECOMMEND 30
 #define MARGIN_VOLT_MIN      50
 
+enum margin_hw { MARGIN_HW_DEFAULT, MARGIN_ICE_LAKE_RC };
+
 /* PCI Device wrapper for margining functions */
 struct margin_dev {
   struct pci_dev *dev;
@@ -29,6 +31,8 @@ struct margin_dev {
   u8 retimers_n;
   u8 link_speed;
 
+  enum margin_hw hw;
+
   /* Saved Device settings to restore after margining */
   u8 aspm;
   bool hasd; // Hardware Autonomous Speed Disable
@@ -209,6 +213,8 @@ void margin_log_receiver(struct margin_recv *recv);
 /* Margining in progress log */
 void margin_log_margining(struct margin_lanes_data arg);
 
+void margin_log_hw_quirks(struct margin_recv *recv);
+
 /* margin_results */
 
 void margin_results_print_brief(struct margin_results *results, u8 recvs_n);
diff --git a/lmr/margin.c b/lmr/margin.c
index 1f1fa2f..cc142fa 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -127,6 +127,20 @@ margin_report_cmd(struct margin_dev *dev, u8 lane, margin_cmd cmd, margin_cmd *r
          && margin_set_cmd(dev, lane, NO_COMMAND);
 }
 
+static void
+margin_apply_hw_quirks(struct margin_recv *recv)
+{
+  switch (recv->dev->hw)
+    {
+      case MARGIN_ICE_LAKE_RC:
+        if (recv->recvn == 1)
+          recv->params->volt_offset = 12;
+        break;
+      default:
+        break;
+    }
+}
+
 static bool
 read_params_internal(struct margin_dev *dev, u8 recvn, bool lane_reversal,
                      struct margin_params *params)
@@ -311,6 +325,8 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
 
   if (recv.parallel_lanes > params.max_lanes + 1)
     recv.parallel_lanes = params.max_lanes + 1;
+  margin_apply_hw_quirks(&recv);
+  margin_log_hw_quirks(&recv);
 
   results->tim_coef = (double)params.timing_offset / (double)params.timing_steps;
   results->volt_coef = (double)params.volt_offset / (double)params.volt_steps * 10.0;
diff --git a/lmr/margin_hw.c b/lmr/margin_hw.c
index c000132..fc427c8 100644
--- a/lmr/margin_hw.c
+++ b/lmr/margin_hw.c
@@ -10,6 +10,27 @@
 
 #include "lmr.h"
 
+static u16 special_hw[][4] =
+  // Vendor ID, Device ID, Revision ID, margin_hw
+  { { 0x8086, 0x347A, 0x4, MARGIN_ICE_LAKE_RC }, 
+    { 0xFFFF, 0, 0, MARGIN_HW_DEFAULT } 
+  };
+
+static enum margin_hw
+detect_unique_hw(struct pci_dev *dev)
+{
+  u16 vendor = pci_read_word(dev, PCI_VENDOR_ID);
+  u16 device = pci_read_word(dev, PCI_DEVICE_ID);
+  u8 revision = pci_read_byte(dev, PCI_REVISION_ID);
+
+  for (int i = 0; special_hw[i][0] != 0xFFFF; i++)
+    {
+      if (vendor == special_hw[i][0] && device == special_hw[i][1] && revision == special_hw[i][2])
+        return special_hw[i][3];
+    }
+  return MARGIN_HW_DEFAULT;
+}
+
 bool
 margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port)
 {
@@ -56,7 +77,8 @@ fill_dev_wrapper(struct pci_dev *dev)
         .retimers_n
         = (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_RETIMER))
           + (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_2RETIMERS)),
-        .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED) };
+        .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED),
+        .hw = detect_unique_hw(dev) };
   return res;
 }
 
diff --git a/lmr/margin_log.c b/lmr/margin_log.c
index 6833d1a..a93e07b 100644
--- a/lmr/margin_log.c
+++ b/lmr/margin_log.c
@@ -133,3 +133,19 @@ margin_log_margining(struct margin_lanes_data arg)
       fflush(stdout);
     }
 }
+
+void
+margin_log_hw_quirks(struct margin_recv *recv)
+{
+  switch (recv->dev->hw)
+    {
+      case MARGIN_ICE_LAKE_RC:
+        if (recv->recvn == 1)
+          margin_log("\nRx(A) is Intel Ice Lake RC port.\n"
+                     "Applying next quirks for margining process:\n"
+                     "  - Set MaxVoltageOffset to 12 (120 mV).\n");
+        break;
+      default:
+        break;
+    }
+}
-- 
2.34.1


