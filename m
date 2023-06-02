Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41D87200B2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjFBLtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjFBLtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61110D8;
        Fri,  2 Jun 2023 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706522; x=1717242522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/DLIxgNO8D6hBvJ4nGLI25s1QAbvWbyDz0yc5as0DVI=;
  b=A0Gy3gEwcSC9kGijvpU/AQI1PjGVIGNUrM6Y4M+hUsvvgwdTPXcF8KTn
   2w3AlqmRYjD04RzGFy6wJLsJuLaTtFcChUAkkBSsAOJciZjYNwp8uk529
   OY7hVGkKeiO8ivR5dRbPv9jvFjaOYB95zdyWDKjTSnLsxqOkaBSi+LH9v
   XnVfdw/lU0N+XjKPPltRSL+GlAx/Q2XiVi5VMNae8Cuj5it03Bht/6Q81
   rOoMylmzI+xKrbcFeFonQjf+NFHy+roqnO3n34dgfeqBgmytnuuE19ITA
   mu1Lw59ZKsQwfBIwGg5ncSsQd8rK73XbafVQU+5FIbNphUb21qs8wQrLK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279655"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819428"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819428"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 04/13] PCI/ASPM: Move L0S/L1/sub states mask calculation into a helper
Date:   Fri,  2 Jun 2023 14:47:41 +0300
Message-Id: <20230602114751.19671-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ASPM service driver does the same L0S / L1S / sub states allowed
calculation in __pci_disable_link_state() and
pci_set_default_link_state().

Create a helper to calculate the mask for the allowed states.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 50 +++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 33ee2b563a39..4727f73a2d0d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1081,6 +1081,27 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
 	return bridge->link_state;
 }
 
+static u8 pci_link_state_mask(int state)
+{
+	u8 result = 0;
+
+	if (state & PCIE_LINK_STATE_L0S)
+		result |= ASPM_STATE_L0S;
+	if (state & PCIE_LINK_STATE_L1)
+		/* L1 PM substates require L1 */
+		result |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+	if (state & PCIE_LINK_STATE_L1_1)
+		result |= ASPM_STATE_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		result |= ASPM_STATE_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		result |= ASPM_STATE_L1_1_PCIPM;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		result |= ASPM_STATE_L1_2_PCIPM;
+
+	return result;
+}
+
 static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
@@ -1110,19 +1131,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (sem)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_disable |= ASPM_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
-	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_disable |= ASPM_STATE_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_disable |= ASPM_STATE_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_1_PCIPM;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
+	link->aspm_disable |= pci_link_state_mask(state);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM)
@@ -1189,20 +1198,7 @@ int pci_set_default_link_state(struct pci_dev *pdev, int state)
 
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	link->aspm_default = 0;
-	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_default |= ASPM_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
-	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_default |= ASPM_STATE_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_default |= ASPM_STATE_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
+	link->aspm_default = pci_link_state_mask(state);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
-- 
2.30.2

