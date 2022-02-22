Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD64BFD87
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiBVPwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 10:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiBVPwM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 10:52:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B226556;
        Tue, 22 Feb 2022 07:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44FEBB81B34;
        Tue, 22 Feb 2022 15:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D692C340EB;
        Tue, 22 Feb 2022 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645545103;
        bh=ibc5rga4Qgkj4YzNPZsYsQvQMb2RWiIyhTS6gczaEvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/EXd14UCZu7M1pOcQqTFUWdMU8L2a++W225JKEb8mQQ1vfiasJXmUGYGLF/e9A1N
         P1cb8aLWwWG55PCY24FMTS6ngbzEFcQ4u+1FZe6t6jWSxLYX2t33ubaQdnlckHHznr
         4bMeZxS1moIrbxgzC4p4flWZ403jubNwHdUeo/EbkzGChYi8fntM1TTmCup1oQH8jl
         p0TQ6B3mxvygQeCnbwu8XOXH0me7DPWziftIz2OfLmevmLglpktKAjx1AwGpT/L6kT
         GUZnrgGjLoO9k9UM7E9DfFfzWmNwurVTdrRPxEbE0UwZsCJWvqtznCTY8/6VnwcRb9
         J5A7kn98v4VRg==
Received: by pali.im (Postfix)
        id 52AAEFDB; Tue, 22 Feb 2022 16:51:42 +0100 (CET)
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
Subject: [PATCH v4 08/12] PCI: mvebu: Use child_ops API
Date:   Tue, 22 Feb 2022 16:50:26 +0100
Message-Id: <20220222155030.988-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222155030.988-1-pali@kernel.org>
References: <20220222155030.988-1-pali@kernel.org>
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

Split struct pci_ops between ops and child_ops. Member ops is used for
accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops for
accessing real PCIe cards.

There is no need to mix these two struct pci_ops into one as PCI core code
already provides separate callbacks via bridge->ops and bridge->child_ops.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 77 ++++++++++++++++--------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1cf5c02499cd..1ae7718a2e3e 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -294,11 +294,25 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	mvebu_writel(port, mask, PCIE_MASK_OFF);
 }
 
-static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
-				 struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 *val)
+static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
+						    struct pci_bus *bus,
+						    int devfn);
+
+static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+				    int size, u32 *val)
 {
-	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
+	struct mvebu_pcie *pcie = bus->sysdata;
+	struct mvebu_pcie_port *port;
+	void __iomem *conf_data;
+
+	port = mvebu_pcie_find_port(pcie, bus, devfn);
+	if (!port)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!mvebu_pcie_link_up(port))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	conf_data = port->base + PCIE_CONF_DATA_OFF;
 
 	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
 		     PCIE_CONF_ADDR_OFF);
@@ -314,18 +328,27 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 		*val = readl_relaxed(conf_data);
 		break;
 	default:
-		*val = 0xffffffff;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
-				 struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 val)
+static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
+				    int where, int size, u32 val)
 {
-	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
+	struct mvebu_pcie *pcie = bus->sysdata;
+	struct mvebu_pcie_port *port;
+	void __iomem *conf_data;
+
+	port = mvebu_pcie_find_port(pcie, bus, devfn);
+	if (!port)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!mvebu_pcie_link_up(port))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	conf_data = port->base + PCIE_CONF_DATA_OFF;
 
 	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
 		     PCIE_CONF_ADDR_OFF);
@@ -347,6 +370,11 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static struct pci_ops mvebu_pcie_child_ops = {
+	.read = mvebu_pcie_child_rd_conf,
+	.write = mvebu_pcie_child_wr_conf,
+};
+
 /*
  * Remove windows, starting from the largest ones to the smallest
  * ones.
@@ -862,25 +890,12 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 {
 	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
-	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
 	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return pci_bridge_emul_conf_write(&port->bridge, where,
-						  size, val);
-
-	if (!mvebu_pcie_link_up(port))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Access the real PCIe interface */
-	ret = mvebu_pcie_hw_wr_conf(port, bus, devfn,
-				    where, size, val);
-
-	return ret;
+	return pci_bridge_emul_conf_write(&port->bridge, where, size, val);
 }
 
 /* PCI configuration space read function */
@@ -889,25 +904,12 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 {
 	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
-	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
 	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return pci_bridge_emul_conf_read(&port->bridge, where,
-						 size, val);
-
-	if (!mvebu_pcie_link_up(port))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Access the real PCIe interface */
-	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
-				    where, size, val);
-
-	return ret;
+	return pci_bridge_emul_conf_read(&port->bridge, where, size, val);
 }
 
 static struct pci_ops mvebu_pcie_ops = {
@@ -1416,6 +1418,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	bridge->sysdata = pcie;
 	bridge->ops = &mvebu_pcie_ops;
+	bridge->child_ops = &mvebu_pcie_child_ops;
 	bridge->align_resource = mvebu_pcie_align_resource;
 	bridge->map_irq = mvebu_pcie_map_irq;
 
-- 
2.20.1

