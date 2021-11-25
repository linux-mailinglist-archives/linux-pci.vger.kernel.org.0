Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C045DA62
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbhKYMxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353575AbhKYMvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 312CC610F9;
        Thu, 25 Nov 2021 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844401;
        bh=I22+rZTnzG+DDCPyUEnV19dYpz4cUH9W+Ns6gKnI/bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjVCqedx94OmhYlagOgMOGMSEpsMVcpvrjaii9/oLYfZ+dIP4NAKEhhvly67MOgJo
         fJUmifie6FJwo2wUCExn+EZ5MI11dPLKBQIUrhm/zhkwnl6OEZ8UMiX6q+zgb8UdKV
         t4Jv5i1cVtFsK+Kq/nrw58A0ABDbcxY9R4Thkvq4qNMOnOv+5QqAQLUKMUMHrtdRI1
         JNf3J6y21K2JNRS10MM0spUFI6P5Wib+7kZPvtFQDrCI5rnrqjW2PWY/GqXXPTJtUB
         eOl0XW5GwHXTiUU1O/Z67bJMpM/amWj1r+dk7j3n3P0Xz0hAMJWrivQh6eNA88KPQh
         LwLQjFtRvh+kQ==
Received: by pali.im (Postfix)
        id 8AD9767E; Thu, 25 Nov 2021 13:46:40 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] PCI: mvebu: Set PCI Bridge Class Code to PCI Bridge
Date:   Thu, 25 Nov 2021 13:46:00 +0100
Message-Id: <20211125124605.25915-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The default value of Class Code of this bridge corresponds to a Memory
controller, though. This is probably relict from the past when old
Marvell/Galileo PCI-based controllers were used as standalone PCI device
for connecting SDRAM or workaround for PCs with broken BIOS. Details are
in commit 36de23a4c5f0 ("MIPS: Cobalt: Explain GT64111 early PCI fixup").

Change the Class Code to correspond to a PCI Bridge.

Add comment explaining this change.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 017ae9f869ac..4edce441901c 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -225,7 +225,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, cmd, mask;
+	u32 ctrl, cmd, dev_rev, mask;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
@@ -237,6 +237,32 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 	mvebu_writel(port, cmd, PCIE_CMD_OFF);
 
+	/*
+	 * Change Class Code of PCI Bridge device to PCI Bridge (0x6004)
+	 * because default value is Memory controller (0x5080).
+	 *
+	 * Note that this mvebu PCI Bridge does not have compliant Type 1
+	 * Configuration Space. Header Type is reported as Type 0 and it
+	 * has format of Type 0 config space.
+	 *
+	 * Moreover Type 0 BAR registers (ranges 0x10 - 0x28 and 0x30 - 0x34)
+	 * have the same format in Marvell's specification as in PCIe
+	 * specification, but their meaning is totally different and they do
+	 * different things: they are aliased into internal mvebu registers
+	 * (e.g. PCIE_BAR_LO_OFF) and these should not be changed or
+	 * reconfigured by pci device drivers.
+	 *
+	 * Therefore driver uses emulation of PCI Bridge which emulates
+	 * access to configuration space via internal mvebu registers or
+	 * emulated configuration buffer. Driver access these PCI Bridge
+	 * directly for simplification, but these registers can be accessed
+	 * also via standard mvebu way for accessing PCI config space.
+	 */
+	dev_rev = mvebu_readl(port, PCIE_DEV_REV_OFF);
+	dev_rev &= ~0xffffff00;
+	dev_rev |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;
+	mvebu_writel(port, dev_rev, PCIE_DEV_REV_OFF);
+
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
-- 
2.20.1

