Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC56D1347AD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAHQWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 11:22:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41508 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgAHQWU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 11:22:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so4004085wrw.8;
        Wed, 08 Jan 2020 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODaX559DYZQ5jG17ZD0Jht7ZAL/OGgTYKjWij2mcvHw=;
        b=SN8I4LDVAVL8y9BXQ0H2/VIRPKZ4pj7UbUDDpAjTvNrkfJjnn1RuRpO5rWLKhD7oOC
         /1ObIdTWl1srl5OcDm2fDGJgaEf5sf2bQ8b7VAPMWv6e6g34c5JuYgjoaR3z6Gb6tK5d
         QYPvx0h4Re7NmBHXbauQRqPcRib5Ik0efiAYJmDBwi7sqGS2uJJeiVV4Ze0WeZIDKbgi
         gOF2kc/SmkROq1+RLqZv/05VW47LR+XFaO8hEgMZwTo2Aqg15GTYMr+7CxfxgFJqq/Ve
         WC5R8TDtqRYVnOi11C8Mehp9EQIabPG0ae8EjAnq97rGoQlzdELkymdECL/pM1bGcMXA
         r+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODaX559DYZQ5jG17ZD0Jht7ZAL/OGgTYKjWij2mcvHw=;
        b=LESHRM7sVQVScn2Mw3kepWtaLH8SxYgwNxhBHLG+6KTYXxWIixisIBz9XEIKUutbEJ
         eVoK+igaXK6O/HVmBMMK1Y7dESVF3TfuK6sYFv5pyrGMZh3GZ5itN1Hmc+37Y/9Ksxc/
         dq0A/0zj/3FCVDDXdb0aO41CdWPNfMBZb7flyKYzxAAj+mZ1znTwyYmkSkpna2uxIdJU
         VdKGfMZB5aSvK7CvhchMXcipHJhuxsso9cKTvLLsAYsm4OaM3YfJPzLB68y3McbySqa0
         NZtjvDi2RJBm7vvQDvAopQuZbDxl71Lbbh8l0EkCJYDGzKcheoB/46aPmEbq4kipNM5a
         GI+w==
X-Gm-Message-State: APjAAAVEW0Pek2nxmCcIrhjsT1bWdy+bZLdZxP/0xpY26KOt5jBc3jHI
        aIOmgB9Jwnmcj3M42mQ279w=
X-Google-Smtp-Source: APXvYqxf+enIMf0Y/iDiwLEhEapRXnRvp6fwvUI+WLZ1d0Iml+PcUp5i1+gx6z2jITXLJUojFxuKCw==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr5297996wrt.208.1578500537526;
        Wed, 08 Jan 2020 08:22:17 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:2811:8b65:294e:fa09])
        by smtp.gmail.com with ESMTPSA id q3sm5112180wrn.33.2020.01.08.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:22:17 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v3 3/6] PCI: endpoint: Add support to handle multiple base for mapping outbound memory
Date:   Wed,  8 Jan 2020 16:22:08 +0000
Message-Id: <20200108162211.22358-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

R-Car PCIe controller has support to map multiple memory regions for
mapping the outbound memory in local system also the controller limits
single allocation for each region (that is, once a chunk is used from the
region it cannot be used to allocate a new one). This features inspires to
add support for handling multiple memory bases in endpoint framework.

With this patch pci_epc_mem_init() now accepts multiple regions, also
page_size for each memory region is passed during initialization so as
to handle single allocation for each region by setting the page_size to
window_size.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  12 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  31 ++-
 drivers/pci/controller/pcie-rockchip-ep.c     |  14 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  29 +--
 drivers/pci/endpoint/pci-epc-core.c           |   7 +-
 drivers/pci/endpoint/pci-epc-mem.c            | 199 ++++++++++++++----
 include/linux/pci-epc.h                       |  46 ++--
 7 files changed, 245 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c173dad67d1..239f27358f1d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -143,7 +143,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
 }
 
 static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
-				 u64 pci_addr, size_t size)
+				 int window, u64 pci_addr, size_t size)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -401,9 +401,11 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	struct device *dev = ep->pcie.dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	struct pci_epc_mem_window mem_window;
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct resource *res;
 	struct pci_epc *epc;
+	int window;
 	int ret;
 
 	pcie->is_rc = false;
@@ -449,15 +451,17 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
 		epc->max_functions = 1;
 
-	ret = pci_epc_mem_init(epc, pcie->mem_res->start,
-			       resource_size(pcie->mem_res));
+	mem_window.phys_base = pcie->mem_res->start;
+	mem_window.size = resource_size(pcie->mem_res);
+	mem_window.page_size = PAGE_SIZE;
+	ret = pci_epc_mem_init(epc, &mem_window, 1);
 	if (ret < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
 		goto err_init;
 	}
 
 	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
-						  SZ_128K);
+						  &window, SZ_128K);
 	if (!ep->irq_cpu_addr) {
 		dev_err(dev, "failed to reserve memory space for MSI\n");
 		ret = -ENOMEM;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3dd2e2697294..3375874facd3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -195,7 +195,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
 }
 
 static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
-			       phys_addr_t addr,
+			       phys_addr_t addr, int window,
 			       u64 pci_addr, size_t size)
 {
 	int ret;
@@ -367,6 +367,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	unsigned int aligned_offset;
 	u16 msg_ctrl, msg_data;
 	u32 msg_addr_lower, msg_addr_upper, reg;
+	int window = PCI_EPC_DEFAULT_WINDOW;
 	u64 msg_addr;
 	bool has_upper;
 	int ret;
@@ -390,11 +391,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		reg = ep->msi_cap + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_readw_dbi(pci, reg);
 	}
-	aligned_offset = msg_addr_lower & (epc->mem->page_size - 1);
+	aligned_offset = msg_addr_lower & (epc->mem[window]->page_size - 1);
 	msg_addr = ((u64)msg_addr_upper) << 32 |
 			(msg_addr_lower & ~aligned_offset);
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
-				  epc->mem->page_size);
+	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, window,
+				  msg_addr, epc->mem[window]->page_size);
 	if (ret)
 		return ret;
 
@@ -416,6 +417,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	u32 reg, msg_data, vec_ctrl;
 	u64 tbl_addr, msg_addr, reg_u64;
 	void __iomem *msix_tbl;
+	int window = PCI_EPC_DEFAULT_WINDOW;
 	int ret;
 
 	reg = ep->msix_cap + PCI_MSIX_TABLE;
@@ -452,8 +454,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EPERM;
 	}
 
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
-				  epc->mem->page_size);
+	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, window,
+				  msg_addr, epc->mem[window]->page_size);
 	if (ret)
 		return ret;
 
@@ -466,10 +468,11 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
+	int window = PCI_EPC_DEFAULT_WINDOW;
 	struct pci_epc *epc = ep->epc;
 
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
-			      epc->mem->page_size);
+			      epc->mem[window]->page_size);
 
 	pci_epc_mem_exit(epc);
 }
@@ -499,9 +502,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	u32 reg;
 	void *addr;
 	u8 hdr_type;
+	int window;
 	unsigned int nbars;
 	unsigned int offset;
 	struct pci_epc *epc;
+	size_t msi_page_size;
+	struct pci_epc_mem_window mem_window;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
@@ -574,15 +580,18 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	ret = __pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
-				 ep->page_size);
+	mem_window.phys_base = ep->phys_base;
+	mem_window.size = ep->addr_size;
+	mem_window.page_size = ep->page_size;
+	ret = __pci_epc_mem_init(epc, &mem_window, 1);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize address space\n");
 		return ret;
 	}
 
-	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
-					     epc->mem->page_size);
+	msi_page_size = epc->mem[PCI_EPC_DEFAULT_WINDOW]->page_size;
+	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys, &window,
+					     msi_page_size);
 	if (!ep->msi_mem) {
 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d743b0a48988..6c46bed43335 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -256,8 +256,8 @@ static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
 }
 
 static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
-				     phys_addr_t addr, u64 pci_addr,
-				     size_t size)
+				     phys_addr_t addr, int window,
+				     u64 pci_addr, size_t size)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *pcie = &ep->rockchip;
@@ -562,11 +562,13 @@ static const struct of_device_id rockchip_pcie_ep_of_match[] = {
 
 static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 {
+	struct pci_epc_mem_window mem_window;
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie_ep *ep;
 	struct rockchip_pcie *rockchip;
 	struct pci_epc *epc;
 	size_t max_regions;
+	int window;
 	int err;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
@@ -614,15 +616,17 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
-	err = pci_epc_mem_init(epc, rockchip->mem_res->start,
-			       resource_size(rockchip->mem_res));
+	mem_window.phys_base = rockchip->mem_res->start;
+	mem_window.size = resource_size(rockchip->mem_res);
+	mem_window.page_size = PAGE_SIZE;
+	err = pci_epc_mem_init(epc, &mem_window, 1);
 	if (err < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
 		goto err_uninit_port;
 	}
 
 	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
-						  SZ_128K);
+						  &window, SZ_128K);
 	if (!ep->irq_cpu_addr) {
 		dev_err(dev, "failed to reserve memory space for MSI\n");
 		err = -ENOMEM;
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 5d74f81ddfe4..475228011703 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -84,8 +84,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	int window;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
+	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr,
+					  &window, reg->size);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -93,15 +95,16 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, window,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		goto err_src_addr;
 	}
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
+	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr,
+					  &window, reg->size);
 	if (!dst_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -109,8 +112,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_src_map_addr;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, window,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -146,8 +149,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	int window;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, &window, reg->size);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -155,8 +159,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, window,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -193,13 +197,14 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	void __iomem *dst_addr;
 	void *buf;
 	phys_addr_t phys_addr;
+	int window;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, &window, reg->size);
 	if (!dst_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -207,8 +212,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, window,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2091508c1620..289c266c2d90 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -358,13 +358,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
  * @epc: the EPC device on which address is allocated
  * @func_no: the endpoint function number in the EPC device
  * @phys_addr: physical address of the local system
+ * @window: index to the window region where PCI address will be mapped
  * @pci_addr: PCI address to which the physical address should be mapped
  * @size: the size of the allocation
  *
  * Invoke to map CPU address with PCI address.
  */
 int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
-		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
+		     phys_addr_t phys_addr, int window,
+		     u64 pci_addr, size_t size)
 {
 	int ret;
 	unsigned long flags;
@@ -376,7 +378,8 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 		return 0;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
+	ret = epc->ops->map_addr(epc, func_no, phys_addr,
+				 window, pci_addr, size);
 	spin_unlock_irqrestore(&epc->lock, flags);
 
 	return ret;
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index d2b174ce15de..f205f7819292 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -38,57 +38,77 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
 /**
  * __pci_epc_mem_init() - initialize the pci_epc_mem structure
  * @epc: the EPC device that invoked pci_epc_mem_init
- * @phys_base: the physical address of the base
- * @size: the size of the address space
- * @page_size: size of each page
+ * @windows: pointer to windows supported by the device
+ * @num_windows: number of windows device supports
  *
  * Invoke to initialize the pci_epc_mem structure used by the
  * endpoint functions to allocate mapped PCI address.
  */
-int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
-		       size_t page_size)
+int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
+		       int num_windows)
 {
-	int ret;
-	struct pci_epc_mem *mem;
-	unsigned long *bitmap;
+	struct pci_epc_mem *mem = NULL;
+	unsigned long *bitmap = NULL;
 	unsigned int page_shift;
-	int pages;
+	size_t page_size;
 	int bitmap_size;
+	int pages;
+	int ret;
+	int i;
 
-	if (page_size < PAGE_SIZE)
-		page_size = PAGE_SIZE;
+	epc->mem_windows = 0;
 
-	page_shift = ilog2(page_size);
-	pages = size >> page_shift;
-	bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
+	if (!windows)
+		return -EINVAL;
 
-	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
-	if (!mem) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (num_windows <= 0)
+		return -EINVAL;
 
-	bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!bitmap) {
-		ret = -ENOMEM;
-		goto err_mem;
-	}
+	epc->mem = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
+	if (!epc->mem)
+		return -EINVAL;
+
+	for (i = 0; i < num_windows; i++) {
+		page_size = windows[i].page_size;
+		if (page_size < PAGE_SIZE)
+			page_size = PAGE_SIZE;
+		page_shift = ilog2(page_size);
+		pages = windows[i].size >> page_shift;
+		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
+
+		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+		if (!mem) {
+			ret = -ENOMEM;
+			goto err_mem;
+		}
 
-	mem->bitmap = bitmap;
-	mem->phys_base = phys_base;
-	mem->page_size = page_size;
-	mem->pages = pages;
-	mem->size = size;
+		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+		if (!bitmap) {
+			ret = -ENOMEM;
+			goto err_mem;
+		}
 
-	epc->mem = mem;
+		mem->bitmap = bitmap;
+		mem->window.phys_base = windows[i].phys_base;
+		mem->page_size = page_size;
+		mem->pages = pages;
+		mem->window.size = windows[i].size;
+		mem->window.map_size = 0;
+
+		epc->mem[i] = mem;
+	}
+	epc->mem_windows = num_windows;
 
 	return 0;
 
 err_mem:
-	kfree(mem);
+	for (; i >= 0; i--) {
+		kfree(mem->bitmap);
+		kfree(epc->mem[i]);
+	}
+	kfree(epc->mem);
 
-err:
-return ret;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
 
@@ -101,48 +121,127 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
  */
 void pci_epc_mem_exit(struct pci_epc *epc)
 {
-	struct pci_epc_mem *mem = epc->mem;
+	struct pci_epc_mem *mem;
+	int i;
+
+	if (!epc->mem_windows)
+		return;
+
+	for (i = 0; i <= epc->mem_windows; i++) {
+		mem = epc->mem[i];
+		kfree(mem->bitmap);
+		kfree(epc->mem[i]);
+	}
+	kfree(epc->mem);
 
 	epc->mem = NULL;
-	kfree(mem->bitmap);
-	kfree(mem);
+	epc->mem_windows = 0;
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
 
+static int pci_epc_find_best_fit_window(struct pci_epc *epc, size_t size)
+{
+	size_t window_least_size = 0;
+	int best_fit_window = -1;
+	struct pci_epc_mem *mem;
+	size_t actual_size;
+	size_t avail_size;
+	int i;
+
+	for (i = 0; i < epc->mem_windows; i++) {
+		mem = epc->mem[i];
+
+		actual_size = ALIGN(size, mem->page_size);
+		avail_size = mem->window.size - mem->window.map_size;
+
+		if (best_fit_window == -1) {
+			if (actual_size <= avail_size) {
+				best_fit_window = i;
+				window_least_size = mem->window.size;
+			}
+		} else {
+			if (actual_size <= avail_size &&
+			    mem->window.size < window_least_size) {
+				best_fit_window = i;
+				window_least_size = mem->window.size;
+			}
+		}
+	}
+
+	return best_fit_window;
+}
+
 /**
  * pci_epc_mem_alloc_addr() - allocate memory address from EPC addr space
  * @epc: the EPC device on which memory has to be allocated
  * @phys_addr: populate the allocated physical address here
+ * @window: populate the window here which will be used to map PCI address
  * @size: the size of the address space that has to be allocated
  *
  * Invoke to allocate memory address from the EPC address space. This
  * is usually done to map the remote RC address into the local system.
  */
 void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
-				     phys_addr_t *phys_addr, size_t size)
+				     phys_addr_t *phys_addr,
+				     int *window, size_t size)
 {
+	int best_fit = PCI_EPC_DEFAULT_WINDOW;
+	void __iomem *virt_addr = NULL;
+	struct pci_epc_mem *mem;
+	unsigned int page_shift;
 	int pageno;
-	void __iomem *virt_addr;
-	struct pci_epc_mem *mem = epc->mem;
-	unsigned int page_shift = ilog2(mem->page_size);
 	int order;
 
+	if (epc->mem_windows <= 0)
+		return NULL;
+
+	if (epc->mem_windows > 1) {
+		best_fit = pci_epc_find_best_fit_window(epc, size);
+		if (best_fit < 0)
+			return NULL;
+	}
+
+	mem = epc->mem[best_fit];
 	size = ALIGN(size, mem->page_size);
+	if (size > (mem->window.size - mem->window.map_size))
+		return NULL;
+	page_shift = ilog2(mem->page_size);
 	order = pci_epc_mem_get_order(mem, size);
 
 	pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
 	if (pageno < 0)
 		return NULL;
 
-	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
+	*phys_addr = mem->window.phys_base +
+		     ((phys_addr_t)pageno << page_shift);
 	virt_addr = ioremap(*phys_addr, size);
-	if (!virt_addr)
+	if (!virt_addr) {
 		bitmap_release_region(mem->bitmap, pageno, order);
+	} else {
+		mem->window.map_size += size;
+		*window = best_fit;
+	}
 
 	return virt_addr;
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
 
+static int pci_epc_get_matching_window(struct pci_epc *epc,
+				       phys_addr_t phys_addr)
+{
+	struct pci_epc_mem *mem;
+	int i;
+
+	for (i = 0; i < epc->mem_windows; i++) {
+		mem = epc->mem[i];
+
+		if (mem->window.phys_base == phys_addr)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 /**
  * pci_epc_mem_free_addr() - free the allocated memory address
  * @epc: the EPC device on which memory was allocated
@@ -155,16 +254,26 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size)
 {
+	struct pci_epc_mem *mem;
+	unsigned int page_shift;
+	int window = 0;
 	int pageno;
-	struct pci_epc_mem *mem = epc->mem;
-	unsigned int page_shift = ilog2(mem->page_size);
 	int order;
 
+	if (epc->mem_windows > 1) {
+		window = pci_epc_get_matching_window(epc, phys_addr);
+		if (window < 0)
+			return;
+	}
+
+	mem = epc->mem[window];
+	page_shift = ilog2(mem->page_size);
 	iounmap(virt_addr);
-	pageno = (phys_addr - mem->phys_base) >> page_shift;
+	pageno = (phys_addr - mem->window.phys_base) >> page_shift;
 	size = ALIGN(size, mem->page_size);
 	order = pci_epc_mem_get_order(mem, size);
 	bitmap_release_region(mem->bitmap, pageno, order);
+	mem->window.map_size -= size;
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 56f1846b9d39..89daafa0d19f 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -48,7 +48,8 @@ struct pci_epc_ops {
 	void	(*clear_bar)(struct pci_epc *epc, u8 func_no,
 			     struct pci_epf_bar *epf_bar);
 	int	(*map_addr)(struct pci_epc *epc, u8 func_no,
-			    phys_addr_t addr, u64 pci_addr, size_t size);
+			    phys_addr_t addr, int window,
+			    u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no,
 			      phys_addr_t addr);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
@@ -64,17 +65,31 @@ struct pci_epc_ops {
 	struct module *owner;
 };
 
+#define PCI_EPC_DEFAULT_WINDOW         0
+
+/**
+ * struct pci_epc_mem_window - address window of the endpoint controller
+ * @phys_base: physical base address of the PCI address window
+ * @size: the size of the PCI address window
+ * @map_size: size of allocated chunk in window
+ * @page_size: size of each page
+ */
+struct pci_epc_mem_window {
+	phys_addr_t	phys_base;
+	size_t		size;
+	size_t		map_size;
+	size_t		page_size;
+};
+
 /**
  * struct pci_epc_mem - address space of the endpoint controller
- * @phys_base: physical base address of the PCI address space
- * @size: the size of the PCI address space
+ * @window: address window of the endpoint controller
  * @bitmap: bitmap to manage the PCI address space
- * @pages: number of bits representing the address region
  * @page_size: size of each page
+ * @pages: number of bits representing the address region
  */
 struct pci_epc_mem {
-	phys_addr_t	phys_base;
-	size_t		size;
+	struct pci_epc_mem_window window;
 	unsigned long	*bitmap;
 	size_t		page_size;
 	int		pages;
@@ -85,7 +100,8 @@ struct pci_epc_mem {
  * @dev: PCI EPC device
  * @pci_epf: list of endpoint functions present in this EPC device
  * @ops: function pointers for performing endpoint operations
- * @mem: address space of the endpoint controller
+ * @mem: array of address space of the endpoint controller
+ * @mem_windows: number of windows supported by device
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
  * @lock: spinlock to protect pci_epc ops
@@ -94,7 +110,8 @@ struct pci_epc {
 	struct device			dev;
 	struct list_head		pci_epf;
 	const struct pci_epc_ops	*ops;
-	struct pci_epc_mem		*mem;
+	struct pci_epc_mem		**mem;
+	int				mem_windows;
 	u8				max_functions;
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
@@ -128,8 +145,8 @@ struct pci_epc_features {
 #define devm_pci_epc_create(dev, ops)    \
 		__devm_pci_epc_create((dev), (ops), THIS_MODULE)
 
-#define pci_epc_mem_init(epc, phys_addr, size)	\
-		__pci_epc_mem_init((epc), (phys_addr), (size), PAGE_SIZE)
+#define pci_epc_mem_init(epc, windows, num_windows)	\
+		__pci_epc_mem_init((epc), windows, num_windows)
 
 static inline void epc_set_drvdata(struct pci_epc *epc, void *data)
 {
@@ -159,7 +176,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 		       struct pci_epf_bar *epf_bar);
 int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
-		     phys_addr_t phys_addr,
+		     phys_addr_t phys_addr, int window,
 		     u64 pci_addr, size_t size);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr);
@@ -178,11 +195,12 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_addr, size_t size,
-		       size_t page_size);
+int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *window,
+		       int num_windows);
 void pci_epc_mem_exit(struct pci_epc *epc);
 void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
-				     phys_addr_t *phys_addr, size_t size);
+				     phys_addr_t *phys_addr,
+				     int *window, size_t size);
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size);
 #endif /* __LINUX_PCI_EPC_H */
-- 
2.20.1

