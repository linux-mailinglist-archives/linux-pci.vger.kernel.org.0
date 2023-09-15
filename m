Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBD7A2310
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjIOP6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjIOP6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:58:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF2310D9;
        Fri, 15 Sep 2023 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793489; x=1726329489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uR4i/gIbbK6SHWtcyQkP8PIO6l0TtlX19XHq+hlBpKI=;
  b=dbu8SjSx/PMiiHlw8dHRyfmd45ZXia+xuMqq4He70Q71k17UG3jqy7TT
   RFjYw2nFG6GW6GNbTFyGOP5a5pCp9IiosBjPfIf3H6AUZ/s+qOasd4CLA
   2LI8h7E4AjNqy5z3Teh8WIKp+GB+FcMMs3MGD1ehldUwdpmA7vUk7whhf
   3ZBNf5mkuU31R5h/GdQyUDoG/QzgOKcFC7qb6lTPilTSqJVGh0uj6Vw+y
   V8OEhZapaT65Q2p204cqtiXrsxBlbr6nONfHloFFmdju6Ekh5HVl7NmqQ
   8vVt324ACEIs3Q8HIln5/bWks3Ybfc2hHbWVjqUaie+2t6o4mUsNx/aWL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369594615"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369594615"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745036692"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="745036692"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/7] PCI/ASPM: Use FIELD_GET/PREP() to access PCIe capability fields
Date:   Fri, 15 Sep 2023 18:57:47 +0300
Message-Id: <20230915155752.84640-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
References: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace open-coded variants to access PCIe capability registers fields
with FIELD_GET/PREP().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

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
-- 
2.30.2

