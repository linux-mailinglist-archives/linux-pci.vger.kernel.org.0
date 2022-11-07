Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52E620093
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiKGVLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiKGVKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:10:42 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D60EF2F01D;
        Mon,  7 Nov 2022 13:07:34 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0F84CE0EC3;
        Mon,  7 Nov 2022 23:50:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=y2bf1BWKKwVBNU57SfjxLIaMy7aGjOfbhd5OgbFdg78=; b=lAW80hz6D+GH
        eR5WS1z3CDjBmps067DpnMrVHt28BxgMzEhpaEqA4utaH/b4AADldLDQpoHuPWak
        PzqfyCZHEYyrDayL86RZSn3A30ilJpyBZhpjd+8GmzGAhNmtrEdygNEWG/dcfUAE
        Pqv3kG+IXyC2j+hBalKhrnIVGGbtD2Q=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EC4FFE0E1D;
        Mon,  7 Nov 2022 23:50:30 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:30 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 15/20] PCI: dwc: Introduce dma-ranges property support for RC-host
Date:   Mon, 7 Nov 2022 23:49:29 +0300
Message-ID: <20221107204934.32655-16-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
property has the same format as the "ranges" property. The only difference
is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
property. Even though the DW PCIe controllers are normally equipped with
the internal Address Translation Unit which inbound and outbound tables
can be used to implement both properties semantics, it was surprising for
me to discover that the host-related part of the DW PCIe driver currently
supports the "ranges" property only while the "dma-ranges" windows are
just ignored. Having the "dma-ranges" supported in the driver would be
very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
mapping and require a customized PCIe memory layout. So let's fix that by
introducing the "dma-ranges" property support.

First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
dw_pcie_prog_ep_inbound_atu() and create a new version of the
dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for the
RC and EP controllers respectively in the same way as it has been
developed for the outbound ATU setup methods.

Secondly aside with the memory window index and type the new
dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
and size as its arguments. These parameters define the PCIe and CPU memory
ranges which will be used to setup the respective inbound ATU mapping. The
passed parameters need to be verified against the ATU ranges constraints
in the same way as it is done for the outbound ranges.

Finally the DMA-ranges detected for the PCIe controller need to be
converted to the inbound ATU entries during the host controller
initialization procedure. It will be done in the framework of the
dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
need to disable all the inbound ATU entries in order to prevent unexpected
PCIe TLPs translations defined by some third party software like
bootloaders.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---

Changelog v3:
- Drop inbound iATU window size alignment constraint. (@Manivannan)
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
 .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
 drivers/pci/controller/dwc/pcie-designware.c  | 56 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
 4 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 83ddb190292e..237bb01d7852 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -171,8 +171,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
-				       cpu_addr, bar);
+	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
+					  cpu_addr, bar);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37d4033..ea923c25e12d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -643,12 +643,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	/*
-	 * Ensure all outbound windows are disabled before proceeding with
-	 * the MEM/IO ranges setups.
+	 * Ensure all out/inbound windows are disabled before proceeding with
+	 * the MEM/IO (dma-)ranges setups.
 	 */
 	for (i = 0; i < pci->num_ob_windows; i++)
 		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
 
+	for (i = 0; i < pci->num_ib_windows; i++)
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -685,9 +688,32 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	if (pci->num_ob_windows <= i)
-		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
+		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	i = 0;
+	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
+		if (resource_type(entry->res) != IORESOURCE_MEM)
+			continue;
+
+		if (pci->num_ib_windows <= i)
+			break;
+
+		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
+					       entry->res->start,
+					       entry->res->start - entry->offset,
+					       resource_size(entry->res));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set DMA range %pr\n",
+				entry->res);
+			return ret;
+		}
+	}
+
+	if (pci->num_ib_windows <= i)
+		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
+			 pci->num_ib_windows);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c6725c519a47..ca830ee794a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -393,8 +393,60 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
 	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
 }
 
-int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-			     int type, u64 cpu_addr, u8 bar)
+int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
+			     u64 cpu_addr, u64 pci_addr, u64 size)
+{
+	u64 limit_addr = pci_addr + size - 1;
+	u32 retries, val;
+
+	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+		return -EINVAL;
+	}
+
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_BASE,
+			      lower_32_bits(pci_addr));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_BASE,
+			      upper_32_bits(pci_addr));
+
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LIMIT,
+			      lower_32_bits(limit_addr));
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_LIMIT,
+				      upper_32_bits(limit_addr));
+
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(cpu_addr));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(cpu_addr));
+
+	val = type;
+	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
+	    dw_pcie_ver_is_ge(pci, 460A))
+		val |= PCIE_ATU_INCREASE_REGION_SIZE;
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+
+	/*
+	 * Make sure ATU enable takes effect before any subsequent config
+	 * and I/O accesses.
+	 */
+	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
+		val = dw_pcie_readl_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2);
+		if (val & PCIE_ATU_ENABLE)
+			return 0;
+
+		mdelay(LINK_WAIT_IATU);
+	}
+
+	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
+
+	return -ETIMEDOUT;
+}
+
+int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
+				int type, u64 cpu_addr, u8 bar)
 {
 	u32 retries, val;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a871ae7eb59e..37801bbce854 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -346,8 +346,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			      u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-			     int type, u64 cpu_addr, u8 bar);
+int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
+			     u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
+				int type, u64 cpu_addr, u8 bar);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
-- 
2.38.0


