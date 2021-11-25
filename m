Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7045DA65
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351060AbhKYMxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353413AbhKYMvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7750D61139;
        Thu, 25 Nov 2021 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844399;
        bh=8IVaDVY9hPRIGDZRDN90aFjLyHB9vSl+f8YJ0WtixNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEwyH3uNfHbBqv91vf66yCBCcd+vPBv2NFDtCdRxmaEbxzVZFKfzIBhUntF7oCDHs
         RWeiQYola42948pTu9MtHMtmCjjnbtIzLzOsc1DEbKlKyU59CSjNTfUFCCgk2MXs9v
         N+Gsu7p45MG2E56JNfAfKxQ8Ed2BM7MaQ0bd3oqmAEoWgIOuS8C9/oGEpXfVkbpNrM
         82LYNbCfpkB+iMxy4atLGUUz1yhHeD7NkpLestOwtcg5+fBlRiI8kQkWtuDbXsd2Ww
         iWrUeHXCRyRqqowtQSyigEKU9rU7VVaT8hc5uYnmBKPMx3PW6AxPep/5c8rbaYvqlp
         gNeyoJIiHdjGQ==
Received: by pali.im (Postfix)
        id 57DC467E; Thu, 25 Nov 2021 13:46:36 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] PCI: mvebu: Fix support for bus mastering and PCI_COMMAND on emulated bridge
Date:   Thu, 25 Nov 2021 13:45:56 +0100
Message-Id: <20211125124605.25915-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCI specifications bits [0:2] of Command Register, this should
be by default disabled on reset. So explicitly disable these bits at early
beginning of driver initialization.

Also remove code which unconditionally enables all 3 bits and let kernel
code (via pci_set_master() function) to handle bus mastering of PCI Bridge
via emulated PCI_COMMAND on emulated bridge.

Adjust existing functions mvebu_pcie_handle_iobase_change() and
mvebu_pcie_handle_membase_change() to handle PCI_IO_BASE and PCI_MEM_BASE
registers correctly even when bus mastering on emulated bridge is disabled.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 52 ++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a3df352d440e..32694763e930 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -226,16 +226,14 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
 	u32 cmd, mask;
 
-	/* Point PCIe unit MBUS decode windows to DRAM space. */
-	mvebu_pcie_setup_wins(port);
-
-	/* Master + slave enable. */
+	/* Disable Root Bridge I/O space, memory space and bus mastering. */
 	cmd = mvebu_readl(port, PCIE_CMD_OFF);
-	cmd |= PCI_COMMAND_IO;
-	cmd |= PCI_COMMAND_MEMORY;
-	cmd |= PCI_COMMAND_MASTER;
+	cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 	mvebu_writel(port, cmd, PCIE_CMD_OFF);
 
+	/* Point PCIe unit MBUS decode windows to DRAM space. */
+	mvebu_pcie_setup_wins(port);
+
 	/* Enable interrupt lines A-D. */
 	mask = mvebu_readl(port, PCIE_MASK_OFF);
 	mask |= PCIE_MASK_ENABLE_INTS;
@@ -385,8 +383,7 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 	/* Are the new iobase/iolimit values invalid? */
 	if (conf->iolimit < conf->iobase ||
-	    conf->iolimitupper < conf->iobaseupper ||
-	    !(conf->command & PCI_COMMAND_IO)) {
+	    conf->iolimitupper < conf->iobaseupper) {
 		mvebu_pcie_set_window(port, port->io_target, port->io_attr,
 				      &desired, &port->iowin);
 		return;
@@ -423,8 +420,7 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
 
 	/* Are the new membase/memlimit values invalid? */
-	if (conf->memlimit < conf->membase ||
-	    !(conf->command & PCI_COMMAND_MEMORY)) {
+	if (conf->memlimit < conf->membase) {
 		mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
 				      &desired, &port->memwin);
 		return;
@@ -444,6 +440,24 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 			      &port->memwin);
 }
 
+static pci_bridge_emul_read_status_t
+mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
+				     int reg, u32 *value)
+{
+	struct mvebu_pcie_port *port = bridge->data;
+
+	switch (reg) {
+	case PCI_COMMAND:
+		*value = mvebu_readl(port, PCIE_CMD_OFF);
+		break;
+
+	default:
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+	}
+
+	return PCI_BRIDGE_EMUL_HANDLED;
+}
+
 static pci_bridge_emul_read_status_t
 mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 				     int reg, u32 *value)
@@ -498,17 +512,14 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_COMMAND:
-	{
-		if (!mvebu_has_ioport(port))
-			conf->command &= ~PCI_COMMAND_IO;
-
-		if ((old ^ new) & PCI_COMMAND_IO)
-			mvebu_pcie_handle_iobase_change(port);
-		if ((old ^ new) & PCI_COMMAND_MEMORY)
-			mvebu_pcie_handle_membase_change(port);
+		if (!mvebu_has_ioport(port)) {
+			conf->command = cpu_to_le16(
+				le16_to_cpu(conf->command) & ~PCI_COMMAND_IO);
+			new &= ~PCI_COMMAND_IO;
+		}
 
+		mvebu_writel(port, new, PCIE_CMD_OFF);
 		break;
-	}
 
 	case PCI_IO_BASE:
 		/*
@@ -575,6 +586,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 }
 
 static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
+	.read_base = mvebu_pci_bridge_emul_base_conf_read,
 	.write_base = mvebu_pci_bridge_emul_base_conf_write,
 	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
 	.write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,
-- 
2.20.1

