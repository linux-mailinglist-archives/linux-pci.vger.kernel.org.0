Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8894945C96A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347987AbhKXQD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347878AbhKXQD0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81F9D60FD9;
        Wed, 24 Nov 2021 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637769616;
        bh=ArtNvzE+psmU/gFxekKOSdkmYfer+DLZ0e8FJLGFcY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu2lhBK9zBMxn4d2wL7e1a/FasX4fF50xZhzzfyuGowTjoW1BTirRXXMZeDcKG0+A
         3Jdz+K1sZMNdCd0WjhdAYcZBd0yMEo8iJ2KRLqwRnHNS9hpBr6xxgVXgerIQIOpRAx
         TZFScNowTT8ZY3iq79IH+nUhByhkVeYucs5ruhfVlcWhOQvF561yKsQiu2UrOPjyQL
         V7hJi8v/J0SRFymhSvx9owosFhmaoVRaNQmFYAxe3YsDXAUsRXmi2sqJMUTk3t9rEi
         LSxj7CF0Z0kNVQMQQPA4Fnocj01RyVOOgKn6lNLXDPEwJg/tzQvwJoIf47k3lGRxiK
         XD84kpARi+dGg==
Received: by pali.im (Postfix)
        id 4419856D; Wed, 24 Nov 2021 17:00:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] PCI: pci-bridge-emul: Correctly set PCIe capabilities
Date:   Wed, 24 Nov 2021 16:59:43 +0100
Message-Id: <20211124155944.1290-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Older mvebu hardware provides PCIe Capability structure only in version 1.
New mvebu and aardvark hardware provides it in version 2. So do not force
version to 2 in pci_bridge_emul_init() and rather allow drivers to set
correct version. Drivers need to set version in pcie_conf.cap field without
overwriting PCI_CAP_LIST_ID register. Both drivers (mvebu and aardvark) do
not provide slot support yet, so do not set PCI_EXP_FLAGS_SLOT flag.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 drivers/pci/controller/pci-mvebu.c    | 8 ++++++++
 drivers/pci/pci-bridge-emul.c         | 5 +----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c5300d49807a..62fc55f2ed40 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -881,7 +881,6 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
-	case PCI_CAP_LIST_ID:
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
 		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
@@ -962,6 +961,9 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	/* Support interrupt A for MSI feature */
 	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
 
+	/* Aardvark HW provides PCIe Capability structure in version 2 */
+	bridge->pcie_conf.cap = cpu_to_le16(2);
+
 	/* Indicates supports for Completion Retry Status */
 	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
 
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index e0e50af8ced4..06f06085beba 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -584,6 +584,8 @@ static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
 static void mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 {
 	struct pci_bridge_emul *bridge = &port->bridge;
+	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP);
+	u8 pcie_cap_ver = ((pcie_cap >> 16) & PCI_EXP_FLAGS_VERS);
 
 	bridge->conf.vendor = PCI_VENDOR_ID_MARVELL;
 	bridge->conf.device = mvebu_readl(port, PCIE_DEV_ID_OFF) >> 16;
@@ -596,6 +598,12 @@ static void mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 		bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
 	}
 
+	/*
+	 * Older mvebu hardware provides PCIe Capability structure only in
+	 * version 1. New hardware provides it in version 2.
+	 */
+	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver);
+
 	bridge->has_pcie = true;
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 9a348f99641b..6c75dc296984 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -340,10 +340,7 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 	if (bridge->has_pcie) {
 		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
 		bridge->pcie_conf.cap_id = PCI_CAP_ID_EXP;
-		/* Set PCIe v2, root port, slot support */
-		bridge->pcie_conf.cap =
-			cpu_to_le16(PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
-				    PCI_EXP_FLAGS_SLOT);
+		bridge->pcie_conf.cap |= cpu_to_le16(PCI_EXP_TYPE_ROOT_PORT << 4);
 		bridge->pcie_cap_regs_behavior =
 			kmemdup(pcie_cap_regs_behavior,
 				sizeof(pcie_cap_regs_behavior),
-- 
2.20.1

