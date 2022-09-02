Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4B5ABB4E
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIBXf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiIBXfx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF02DF4C4;
        Fri,  2 Sep 2022 16:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 357D461FCC;
        Fri,  2 Sep 2022 23:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B40EC433C1;
        Fri,  2 Sep 2022 23:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662161750;
        bh=+tv4zJBnBQ0b/SGi+DyVyUKXcJhST7fJ2n0JsNgjNls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keoxqNIFb+voGD+du+d+lR8fPs6T37tWH5gTTC+flpPuFDRXoghju5zJdy0Et7j2b
         m31+VKI1QDi//fwzEeclBtCYwo1s12zemZ4BlpEVaB1xtpHALHN4FyFGNdvp0TT+KD
         2O+o26mYUeLBUFcapKnwBkPalsgkkOSFFzr5Im3CKCDOqpw2E2FOqY+MVkENhrpL04
         PspuMWHr5HgV/WVqAkI40nNQ5h1pRs+CLi0J9luxtt7TYAqQokDk2oOpDNmc5778cz
         nbuX1F/N4umiq3maunuoj32A/KyZX+U8aD5sCFWOu3A0o59mPIYcBzu02Z+eG3Pb6w
         9GMDEiUik0LYg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/3] PCI/PTM: Implement pci_enable_ptm() for Root Ports, Switch Upstream Ports
Date:   Fri,  2 Sep 2022 18:35:42 -0500
Message-Id: <20220902233543.390890-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902233543.390890-1-helgaas@kernel.org>
References: <20220902233543.390890-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index b6a417247ce3..ad283818f37b 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -167,11 +167,11 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 	if (!pos)
 		return -EINVAL;
 
-	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
-	if (!(cap & PCI_PTM_CAP_REQ))
-		return -EINVAL;
-
 	/*
+	 * Root Ports and Switch Upstream Ports have been configured
+	 * by pci_ptm_init(), so preserve their PCI_PTM_CTRL_ROOT and
+	 * granularity.
+	 *
 	 * For a PCIe Endpoint, PTM is only useful if the endpoint can
 	 * issue PTM requests to upstream devices that have PTM enabled.
 	 *
@@ -179,19 +179,39 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 	 * device, so there must be some implementation-specific way to
 	 * associate the endpoint with a time source.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
+			ups = pci_upstream_bridge(dev);
+			if (!ups || !ups->ptm_enabled)
+				return -EINVAL;
+		}
+
+		pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
+		ctrl |= PCI_PTM_CTRL_ENABLE;
+	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
+		pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+		if (!(cap & PCI_PTM_CAP_REQ))
+			return -EINVAL;
+
 		ups = pci_upstream_bridge(dev);
 		if (!ups || !ups->ptm_enabled)
 			return -EINVAL;
 
 		dev->ptm_granularity = ups->ptm_granularity;
+		ctrl = PCI_PTM_CTRL_ENABLE;
+		ctrl |= dev->ptm_granularity << 8;
 	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
+		pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+		if (!(cap & PCI_PTM_CAP_REQ))
+			return -EINVAL;
+
 		dev->ptm_granularity = 0;
+		ctrl = PCI_PTM_CTRL_ENABLE;
+		ctrl |= dev->ptm_granularity << 8;
 	} else
 		return -EINVAL;
 
-	ctrl = PCI_PTM_CTRL_ENABLE;
-	ctrl |= dev->ptm_granularity << 8;
 	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
 
-- 
2.25.1

