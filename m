Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91E647C200
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhLUO4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38112 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbhLUO4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79036B81734;
        Tue, 21 Dec 2021 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8733CC36AFC;
        Tue, 21 Dec 2021 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098608;
        bh=rDql2jTgdjUK7vxWWT90TbqSpfdmGCwQYg2uMRYgxk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JL5FYR4sMP/bh/ow18GHbvdUQXmwddzhZGO+eaP89DdwPZQO+RwnxLN6PmUJv0CJp
         6KDDeldkyYxYqoDNFpDsota9248R5dciFsBMs1TFCWgbPoHcfyVtzLgLhEtIyadFnb
         qTHm+RE9yA2KqecqmeOp7y5Aha2hwpkcba0uEh4SVUFT9PjC6emw+1rMlxfn70sk7F
         uY2hPVdQCoF+wHK2FVJyj/IDqKlsQwmLPX4QAWQzVy5XAovXHeVf2jlbF4zdIaMn3z
         3aHUsyE7BwnBfpGCNPLBITWf7gy3bnj/LpwQj0p2fL+D4OGpna3hIdQTymT/erMRMO
         uXBPp/V7z7UFw==
Received: by pali.im (Postfix)
        id 28DF92A9D; Tue, 21 Dec 2021 15:18:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] PCI: mvebu: Set PCI_BRIDGE_EMUL_NO_IO_FORWARD when IO is unsupported
Date:   Tue, 21 Dec 2021 15:14:51 +0100
Message-Id: <20211221141455.30011-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This will make PCI bridge to return zeros when accessing IO base and limit
registers, as required by PCIe base specification.

This allows to remove adhoc checks around mvebu_pcie_handle_iobase_change()
function for unsupported IO ranges. PCI_BRIDGE_EMUL_NO_IO_FORWARD ensures
that there will be no non-zeros write to IO registers when IO is not
supported.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 016f709b3067..551f55af5226 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -438,12 +438,6 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 		return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
 					     &desired, &port->iowin);
 
-	if (!mvebu_has_ioport(port)) {
-		dev_WARN(&port->pcie->pdev->dev,
-			 "Attempt to set IO when IO is disabled\n");
-		return -EOPNOTSUPP;
-	}
-
 	/*
 	 * We read the PCI-to-PCI bridge emulated registers, and
 	 * calculate the base address and size of the address decoding
@@ -599,24 +593,18 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_COMMAND:
-		if (!mvebu_has_ioport(port)) {
-			conf->command = cpu_to_le16(
-				le16_to_cpu(conf->command) & ~PCI_COMMAND_IO);
-			new &= ~PCI_COMMAND_IO;
-		}
-
 		mvebu_writel(port, new, PCIE_CMD_OFF);
 		break;
 
 	case PCI_IO_BASE:
-		if ((mask & 0xffff) && mvebu_pcie_handle_iobase_change(port)) {
+		if ((mask & 0xffff) && mvebu_has_ioport(port) &&
+		    mvebu_pcie_handle_iobase_change(port)) {
 			/* On error disable IO range */
 			conf->iobase &= ~0xf0;
 			conf->iolimit &= ~0xf0;
+			conf->iobase |= 0xf0;
 			conf->iobaseupper = cpu_to_le16(0x0000);
 			conf->iolimitupper = cpu_to_le16(0x0000);
-			if (mvebu_has_ioport(port))
-				conf->iobase |= 0xf0;
 		}
 		break;
 
@@ -630,14 +618,14 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_IO_BASE_UPPER16:
-		if (mvebu_pcie_handle_iobase_change(port)) {
+		if (mvebu_has_ioport(port) &&
+		    mvebu_pcie_handle_iobase_change(port)) {
 			/* On error disable IO range */
 			conf->iobase &= ~0xf0;
 			conf->iolimit &= ~0xf0;
+			conf->iobase |= 0xf0;
 			conf->iobaseupper = cpu_to_le16(0x0000);
 			conf->iolimitupper = cpu_to_le16(0x0000);
-			if (mvebu_has_ioport(port))
-				conf->iobase |= 0xf0;
 		}
 		break;
 
@@ -722,6 +710,7 @@ static const struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
  */
 static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 {
+	unsigned int bridge_flags = PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD;
 	struct pci_bridge_emul *bridge = &port->bridge;
 	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP);
 	u8 pcie_cap_ver = ((pcie_cap >> 16) & PCI_EXP_FLAGS_VERS);
@@ -735,6 +724,8 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 		/* We support 32 bits I/O addressing */
 		bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
 		bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
+	} else {
+		bridge_flags |= PCI_BRIDGE_EMUL_NO_IO_FORWARD;
 	}
 
 	/*
@@ -747,7 +738,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
 
-	return pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD);
+	return pci_bridge_emul_init(bridge, bridge_flags);
 }
 
 static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
-- 
2.20.1

