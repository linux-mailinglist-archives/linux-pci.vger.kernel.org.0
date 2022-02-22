Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414794BF67E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiBVKrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 05:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiBVKrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 05:47:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028DA9A74;
        Tue, 22 Feb 2022 02:46:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDB6CB81984;
        Tue, 22 Feb 2022 10:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC72C340E8;
        Tue, 22 Feb 2022 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645526808;
        bh=a6auHCW+ic8+PezBDokk6QACr1ciBtOMQMlDuFxtZwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdORQZkf1sA+Do35Z0N+wjedFIvyRHrJAoDnk1PXBxIgou2LKWoF88SEDnJzKwXWN
         6ahYQWpPYzNuX/nUHhFLfa0CDbhxUCl+FedS4z6Iof96LhDYpLxO3bkx8PZfYykn4U
         viT3pdje3LeIIYydjdMa77NwFrTVgDgVuSUNuhZ3Rxe5sqS9Tbfjo0r7mFc3bg/1B8
         RA45l1whnNsLu4JKCMAUGOBLLupuaxsWa8MVS1CenwXMSwHnDkDzJkCL1k8WJ8zqwq
         g6k33zD8am6ZQyW/Fqolf80LIVW4129aduYN9W1+PtZj1U57thJiM+3/BS9+u1VuCd
         PpJbZonGNmFCA==
Received: by pali.im (Postfix)
        id 376C9FDB; Tue, 22 Feb 2022 11:46:48 +0100 (CET)
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
Subject: [PATCH v3 05/12] PCI: mvebu: Correctly configure x1/x4 mode
Date:   Tue, 22 Feb 2022 11:46:18 +0100
Message-Id: <20220222104625.28461-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222104625.28461-1-pali@kernel.org>
References: <20220222104625.28461-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

