Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1A48554D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbiAEPDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:03:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55242 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiAEPC6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:02:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D074AB81BAA;
        Wed,  5 Jan 2022 15:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628E4C36AE3;
        Wed,  5 Jan 2022 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641394975;
        bh=a6auHCW+ic8+PezBDokk6QACr1ciBtOMQMlDuFxtZwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uORkDIOC/C0YKuZY3x//JxXXm4OQkvs9hlJo3LKcYXyOpRkfMkLl8GL0erYBPBQWB
         nA6sCxS9EbvNhtMY9smoTKJrUUfOvqBCSuJ2d9LODvL17RsYPweId593ynHzypNkfE
         SjWn9H8Oki6w11bDBicXtiydFXc9rllU2eOlwU7yrLn67Zc/EOFEo9m9+b6jWcUygV
         MBXzWgZYqhPzme0yTsHQ2l9TRQuL4J5XQwyOskNmLrhIT6AYm+ILC7mqrZd4aa7/71
         ul/KdOyV5ou04I3xLXc3bzBzpO9IZgkSZB34VGvn3HVhi6yinC9U9X+y6io34IKPfX
         FitYLE7FUB11A==
Received: by pali.im (Postfix)
        id 1BEF682A; Wed,  5 Jan 2022 16:02:55 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/11] PCI: mvebu: Correctly configure x1/x4 mode
Date:   Wed,  5 Jan 2022 16:02:33 +0100
Message-Id: <20220105150239.9628-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105150239.9628-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If x1/x4 mode is not set correctly then link with endpoint card is not
established.

Use DTS property 'num-lanes' to deteriminate x1/x4 mode.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a075ba26cff1..0f2ec0a17874 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -93,6 +93,7 @@ struct mvebu_pcie_port {
 	void __iomem *base;
 	u32 port;
 	u32 lane;
+	bool is_x4;
 	int devfn;
 	unsigned int mem_target;
 	unsigned int mem_attr;
@@ -233,13 +234,25 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, cmd, dev_rev, mask;
+	u32 ctrl, lnkcap, cmd, dev_rev, mask;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
 	ctrl |= PCIE_CTRL_RC_MODE;
 	mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
 
+	/*
+	 * Set Maximum Link Width to X1 or X4 in Root Port's PCIe Link
+	 * Capability register. This register is defined by PCIe specification
+	 * as read-only but this mvebu controller has it as read-write and must
+	 * be set to number of SerDes PCIe lanes (1 or 4). If this register is
+	 * not set correctly then link with endpoint card is not established.
+	 */
+	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
+	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
+	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
+	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
+
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
 	cmd = mvebu_readl(port, PCIE_CMD_OFF);
 	cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
@@ -986,6 +999,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	struct device *dev = &pcie->pdev->dev;
 	enum of_gpio_flags flags;
 	int reset_gpio, ret;
+	u32 num_lanes;
 
 	port->pcie = pcie;
 
@@ -998,6 +1012,9 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	if (of_property_read_u32(child, "marvell,pcie-lane", &port->lane))
 		port->lane = 0;
 
+	if (!of_property_read_u32(child, "num-lanes", &num_lanes) && num_lanes == 4)
+		port->is_x4 = true;
+
 	port->name = devm_kasprintf(dev, GFP_KERNEL, "pcie%d.%d", port->port,
 				    port->lane);
 	if (!port->name) {
-- 
2.20.1

