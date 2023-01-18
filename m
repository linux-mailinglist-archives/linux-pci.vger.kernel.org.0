Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C968B672CC7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 00:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjARXqv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 18:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjARXqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 18:46:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1311EAE;
        Wed, 18 Jan 2023 15:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CAC661831;
        Wed, 18 Jan 2023 23:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3A0C433D2;
        Wed, 18 Jan 2023 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674085606;
        bh=0HJ7zndpmL59E1qhUN1G/Y5OUoubJQBE2+NF00ZQWDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2znFTR65e+I9omNS0vAJqoZhJlqYKoZMtGiFVd57Hobfx0arrC426IAXe/SostkE
         R5GZv7bH/UhP0yEIgUNUV3gZHRoD+EMj/qawysGe60lVuTf9YFpfiYtZ6nS3peQDPJ
         LjJp+TwAdntD3hJu2/3GM5Xj1cdUwuZomBH+O1IItj73PQMXLVRYz18f37lettfgLb
         UQp5P2NSpNusxu6JdZc1e7H9dhfPTqdYY3+PdEunvxdmuuWq4XHVkQLBgvMOqTpSPE
         O6sUtddN4clXx6N2n4/bNehiL/Xqqee8nBzpIwFa2+bowW/W5NvOv32fIwlZ0/bmXH
         XZ/dIiVo3TlmA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/9] PCI/AER: Remove redundant Device Control Error Reporting Enable
Date:   Wed, 18 Jan 2023 17:46:04 -0600
Message-Id: <20230118234612.272916-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118234612.272916-1-helgaas@kernel.org>
References: <20230118234612.272916-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The following bits in the PCIe Device Control register enable sending of
ERR_COR, ERR_NONFATAL, or ERR_FATAL Messages (or reporting internally in
the case of Root Ports):

  Correctable Error Reporting Enable
  Non-Fatal Error Reporting Enable
  Fatal Error Reporting Enable
  Unsupported Request Reporting Enable

These enable bits are set by pci_enable_pcie_error_reporting(), and since
f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"), we
do that in this path during enumeration:

  pci_init_capabilities
    pci_aer_init
      pci_enable_pcie_error_reporting

Previously, the AER service driver also traversed the hierarchy when
claiming a Root Port, enabling error reporting for downstream devices, but
this is redundant.

Remove the code that enables this error reporting in the AER .probe() path.
Also remove similar code that disables error reporting in the AER .remove()
path.

Note that these Device Control Reporting Enable bits do not control
interrupt generation.  That's done by the similarly-named bits in the AER
Root Error Command register, which are still set by aer_probe() and cleared
by aer_remove(), since the AER service driver handles those interrupts.
See PCIe r6.0, sec 6.2.6.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/aer.c | 48 ------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 625f7b2cafe4..b7b69e0c778c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1224,42 +1224,6 @@ static irqreturn_t aer_irq(int irq, void *context)
 	return IRQ_WAKE_THREAD;
 }
 
-static int set_device_error_reporting(struct pci_dev *dev, void *data)
-{
-	bool enable = *((bool *)data);
-	int type = pci_pcie_type(dev);
-
-	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
-	    (type == PCI_EXP_TYPE_RC_EC) ||
-	    (type == PCI_EXP_TYPE_UPSTREAM) ||
-	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
-		if (enable)
-			pci_enable_pcie_error_reporting(dev);
-		else
-			pci_disable_pcie_error_reporting(dev);
-	}
-
-	return 0;
-}
-
-/**
- * set_downstream_devices_error_reporting - enable/disable the error reporting  bits on the root port and its downstream ports.
- * @dev: pointer to root port's pci_dev data structure
- * @enable: true = enable error reporting, false = disable error reporting.
- */
-static void set_downstream_devices_error_reporting(struct pci_dev *dev,
-						   bool enable)
-{
-	set_device_error_reporting(dev, &enable);
-
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
-		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
-	else if (dev->subordinate)
-		pci_walk_bus(dev->subordinate, set_device_error_reporting,
-			     &enable);
-
-}
-
 /**
  * aer_enable_rootport - enable Root Port's interrupts when receiving messages
  * @rpc: pointer to a Root Port data structure
@@ -1289,12 +1253,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
 
-	/*
-	 * Enable error reporting for the root port device and downstream port
-	 * devices.
-	 */
-	set_downstream_devices_error_reporting(pdev, true);
-
 	/* Enable Root Port's interrupt in response to error messages */
 	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1313,12 +1271,6 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	int aer = pdev->aer_cap;
 	u32 reg32;
 
-	/*
-	 * Disable error reporting for the root port device and downstream port
-	 * devices.
-	 */
-	set_downstream_devices_error_reporting(pdev, false);
-
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-- 
2.25.1

