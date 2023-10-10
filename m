Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C834C7C41C7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjJJUox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbjJJUov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:44:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B075A7;
        Tue, 10 Oct 2023 13:44:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F7EC433CA;
        Tue, 10 Oct 2023 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970689;
        bh=NrMDXaeQR98E6Ubw4ieg4ii/aUeCyXW8gwNQ1Gvx2NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac/Bhj4h1bZ7zbplnlz/rL7kzcfZVGbjnhdZP0X/Ngws02Y5w2uY7VQTo316/susZ
         n16TuDvf5x7dj3kQ7Q41nbE6znR6eO9VYPslfaNfw8eX7AgYUbSS4CcAcgNRwWLmZM
         eduPBhP5vSWtvi9o5so9I8LHm+JBI2hD7giJL+vqgGQs6Bjd5igDjGpdrgZeYNR5kg
         8zbVtcXCuw+k1rTPGLllo7zSRtjxJHIUEpMB2mbV176h/vuPLEQlR05irLvtO8R1rs
         bTz7KMr0/Nf66UjH3//HLUE4+aV6bVEuqwnk3rl/86Gl9j3cM+wZrOisgHPoaLlPNp
         PJ7b9U9uPOK6Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 03/10] PCI/ASPM: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:29 -0500
Message-Id: <20231010204436.1000644-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
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

From: Bjorn Helgaas <bhelgaas@google.com>

Add #defines for T_POWER_ON in the L1 PM Substates Capability and use
FIELD_PREP() and FIELD_GET() when possible.  These remove the need for
explicit shifts.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c       | 31 ++++++++++++++++++-------------
 include/uapi/linux/pci_regs.h |  2 ++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1bf630059264..06f175d8dee5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -7,6 +7,7 @@
  * Copyright (C) Shaohua Li (shaohua.li@intel.com)
  */
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -267,7 +268,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 /* Convert L0s latency encoding to ns */
 static u32 calc_l0s_latency(u32 lnkcap)
 {
-	u32 encoding = (lnkcap & PCI_EXP_LNKCAP_L0SEL) >> 12;
+	u32 encoding = FIELD_GET(PCI_EXP_LNKCAP_L0SEL, lnkcap);
 
 	if (encoding == 0x7)
 		return (5 * 1000);	/* > 4us */
@@ -285,7 +286,7 @@ static u32 calc_l0s_acceptable(u32 encoding)
 /* Convert L1 latency encoding to ns */
 static u32 calc_l1_latency(u32 lnkcap)
 {
-	u32 encoding = (lnkcap & PCI_EXP_LNKCAP_L1EL) >> 15;
+	u32 encoding = FIELD_GET(PCI_EXP_LNKCAP_L1EL, lnkcap);
 
 	if (encoding == 0x7)
 		return (65 * 1000);	/* > 64us */
@@ -371,11 +372,11 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	link = endpoint->bus->self->link_state;
 
 	/* Calculate endpoint L0s acceptable latency */
-	encoding = (endpoint->devcap & PCI_EXP_DEVCAP_L0S) >> 6;
+	encoding = FIELD_GET(PCI_EXP_DEVCAP_L0S, endpoint->devcap);
 	acceptable_l0s = calc_l0s_acceptable(encoding);
 
 	/* Calculate endpoint L1 acceptable latency */
-	encoding = (endpoint->devcap & PCI_EXP_DEVCAP_L1) >> 9;
+	encoding = FIELD_GET(PCI_EXP_DEVCAP_L1, endpoint->devcap);
 	acceptable_l1 = calc_l1_acceptable(encoding);
 
 	while (link) {
@@ -446,22 +447,24 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	u32 pl1_2_enables, cl1_2_enables;
 
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
-	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
-	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
+	val1 = FIELD_GET(PCI_L1SS_CAP_CM_RESTORE_TIME, parent_l1ss_cap);
+	val2 = FIELD_GET(PCI_L1SS_CAP_CM_RESTORE_TIME, child_l1ss_cap);
 	t_common_mode = max(val1, val2);
 
 	/* Choose the greater of the two Port T_POWER_ON times */
-	val1   = (parent_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
-	scale1 = (parent_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
-	val2   = (child_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
-	scale2 = (child_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
+	val1   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, parent_l1ss_cap);
+	scale1 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, parent_l1ss_cap);
+	val2   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, child_l1ss_cap);
+	scale2 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, child_l1ss_cap);
 
 	if (calc_l12_pwron(parent, scale1, val1) >
 	    calc_l12_pwron(child, scale2, val2)) {
-		ctl2 |= scale1 | (val1 << 3);
+		ctl2 |= FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_SCALE, scale1) |
+			FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_VALUE, val1);
 		t_power_on = calc_l12_pwron(parent, scale1, val1);
 	} else {
-		ctl2 |= scale2 | (val2 << 3);
+		ctl2 |= FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_SCALE, scale2) |
+			FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_VALUE, val2);
 		t_power_on = calc_l12_pwron(child, scale2, val2);
 	}
 
@@ -477,7 +480,9 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
-	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
+	ctl1 |= FIELD_PREP(PCI_L1SS_CTL1_CM_RESTORE_TIME, t_common_mode) |
+		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_VALUE, value) |
+		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_SCALE, scale);
 
 	/* Some broken devices only support dword access to L1 SS */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d96493..34bf037993f3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1088,6 +1088,8 @@
 #define  PCI_L1SS_CTL1_LTR_L12_TH_VALUE	0x03ff0000  /* LTR_L1.2_THRESHOLD_Value */
 #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
 #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
+#define  PCI_L1SS_CTL2_T_PWR_ON_SCALE   0x00000003  /* T_POWER_ON Scale */
+#define  PCI_L1SS_CTL2_T_PWR_ON_VALUE   0x000000f8  /* T_POWER_ON Value */
 
 /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
 #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
-- 
2.34.1

