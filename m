Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1711230C70D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhBBRJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 12:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhBBRI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 12:08:29 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9954BC061573
        for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2021 09:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N/Uytk6Qcbpaw+g/Kiaz2W4wEi/9oYZXivr262Qvivc=; b=j9bj6gNmkOjJetPNsRjntxTe+D
        XJ+/juU7VMdpVOCxsPpbkhyo3OwSrMW5ZcLjfpMocfae+CM+q6J4rVvTnd86Yaikt8ZdjSSLUzT4+
        AJSq9Kqvh5Xb++RvzUf5w3SmLV7a+aiTI1wfEKuL3bcGmOu5KB5h3O6SSvHC8VrjlRGm6Zs+U9Ewf
        7lQHsZub6YPc3vOGTE10aLGKVkIAgcYfKCXeYR/2MrAnbdURA+F56GZnYzUyB+DTMsbPDZVAFL4Im
        BQONOs8R3NpUSie9oHaanSiiv+xSONQZnAQSSNzh3KTMeQs2kwLGbe77aS0r5S4/dZ15z3Y6TT0XW
        RhQI1iKQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52090 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1l6z9W-0004dy-U1; Tue, 02 Feb 2021 17:07:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1l6z9W-0006Re-MQ; Tue, 02 Feb 2021 17:07:46 +0000
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Pali Roh__r <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pci-bridge-emul: fix array overruns, improve safety
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1l6z9W-0006Re-MQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 02 Feb 2021 17:07:46 +0000
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We allow up to PCI_EXP_SLTSTA2 registers to be accessed, but the
PCIe behaviour (pcie_cap_regs_behavior) array only covers up to
PCI_EXP_RTSTA. Expand this array to avoid walking off the end of it.

Do the same for pci_regs_behavior for consistency, and add a
BUILD_BUG_ON() to also check the bridge->conf structure size.

Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pci/pci-bridge-emul.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 139869d50eb2..fdaf86a888b7 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -21,8 +21,9 @@
 #include "pci-bridge-emul.h"
 
 #define PCI_BRIDGE_CONF_END	PCI_STD_HEADER_SIZEOF
+#define PCI_CAP_PCIE_SIZEOF	(PCI_EXP_SLTSTA2 + 2)
 #define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
-#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_EXP_SLTSTA2 + 2)
+#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_CAP_PCIE_SIZEOF)
 
 /**
  * struct pci_bridge_reg_behavior - register bits behaviors
@@ -46,7 +47,8 @@ struct pci_bridge_reg_behavior {
 	u32 w1c;
 };
 
-static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
+static const
+struct pci_bridge_reg_behavior pci_regs_behavior[PCI_STD_HEADER_SIZEOF / 4] = {
 	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
 	[PCI_COMMAND / 4] = {
 		.rw = (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
@@ -164,7 +166,8 @@ static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	},
 };
 
-static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
+static const
+struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] = {
 	[PCI_CAP_LIST_ID / 4] = {
 		/*
 		 * Capability ID, Next Capability Pointer and
@@ -260,6 +263,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 			 unsigned int flags)
 {
+	BUILD_BUG_ON(sizeof(bridge->conf) != PCI_BRIDGE_CONF_END);
+
 	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
 	bridge->conf.cache_line_size = 0x10;
-- 
2.20.1

