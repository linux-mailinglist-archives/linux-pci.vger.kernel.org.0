Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB87E7649
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfJ1QdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38602 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id r14so2410533otn.5;
        Mon, 28 Oct 2019 09:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpXNezTP5UvZxbHA0+iXw/Wyg2v2rsj1FOMQAqAf0GA=;
        b=YSCbvu6Iw14o7dN6JJ6bXZLXrFQFFw1OW1a6+obZZHunlx7fqTolBGHvFO1jTpnDjW
         QFFEssGvGI9KwUBnrhCYPEJi1CxqcXDh7JRcfzM8/0XfbGJjokbK0A2fDQmlG95bwjGI
         h4efSEzxONGpss3LaRLJJDznPABFov28E2Y/k76Jm3b/jBWZf2zLHqyxXZ6dfD2fl3AR
         GYuHzZI81Y9YQdv25P0KTeTBAxdsA2wnm8Fon0z3El59/4nqF/IXsJnSo3Wp/UAIQU1o
         +u5OEWZNeMuu28q7DycIHLh0xsS73ar2jG1lFKxkmbe3CXHBG1ROz4U4UYWB5ihS4CO1
         QuEQ==
X-Gm-Message-State: APjAAAWyG9O/+5Z0NyES7K66UdQ1kZJ/WVo5XHeTXtoHzx1Ebbrk1fqK
        fIkg8SHJf8NmVQwG+nUY4g==
X-Google-Smtp-Source: APXvYqyZIopRAOsgl1zOiXPaW3NtAzvxCuMWMSKxbNh5hFsWDE5ZO6FPWFVruCMbxopnZvC3XLssnA==
X-Received: by 2002:a9d:66e:: with SMTP id 101mr14345496otn.51.1572280403122;
        Mon, 28 Oct 2019 09:33:23 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 09/25] PCI: mobiveil: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:40 -0500
Message-Id: <20191028163256.8004-10-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Mobiveil host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-mobiveil.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a45a6447b01d..4eab8624ce4d 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -140,7 +140,6 @@ struct mobiveil_msi {			/* MSI information */
 
 struct mobiveil_pcie {
 	struct platform_device *pdev;
-	struct list_head resources;
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	void __iomem *csr_axi_slave_base;	/* root port config base */
 	void __iomem *apb_csr_base;	/* MSI register base */
@@ -575,6 +574,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
 
@@ -631,7 +631,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
 
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &pcie->resources) {
+	resource_list_for_each_entry(win, &bridge->windows) {
 		if (resource_type(win->res) == IORESOURCE_MEM)
 			type = MEM_WINDOW_TYPE;
 		else if (resource_type(win->res) == IORESOURCE_IO)
@@ -857,7 +857,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct device *dev = &pdev->dev;
-	resource_size_t iobase;
 	int ret;
 
 	/* allocate the PCIe port */
@@ -875,11 +874,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	INIT_LIST_HEAD(&pcie->resources);
-
 	/* parse the host bridge base addresses from the device tree file */
-	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, &iobase);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return ret;
@@ -892,24 +888,19 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	ret = mobiveil_host_init(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to initialize host\n");
-		goto error;
+		return ret;
 	}
 
 	/* initialize the IRQ domains */
 	ret = mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
-		goto error;
+		return ret;
 	}
 
 	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
 
-	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
-	if (ret)
-		goto error;
-
 	/* Initialize bridge */
-	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_bus_nr;
@@ -920,13 +911,13 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	ret = mobiveil_bringup_link(pcie);
 	if (ret) {
 		dev_info(dev, "link bring-up failed\n");
-		goto error;
+		return ret;
 	}
 
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		return ret;
 
 	bus = bridge->bus;
 
@@ -936,9 +927,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	pci_bus_add_devices(bus);
 
 	return 0;
-error:
-	pci_free_resource_list(&pcie->resources);
-	return ret;
 }
 
 static const struct of_device_id mobiveil_pcie_of_match[] = {
-- 
2.20.1

