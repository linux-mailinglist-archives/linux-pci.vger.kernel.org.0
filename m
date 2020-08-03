Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6323AF2B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgHCVCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:08 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38541 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHCVCH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:07 -0400
Received: by mail-il1-f194.google.com with SMTP id 77so3880456ilc.5;
        Mon, 03 Aug 2020 14:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUz+R+tsBr+VP4t6lLVIS/60DtpOg9mXVRA50yAPEow=;
        b=LP4EQuwh8Xj3f4ySgVjcu4Y6D6rZtxq/xrustadAh7YEWME8WMtPQzLNwjK/MMpu0g
         n4TGcoFi08806zPBAbb9TlpJ6dtoVRjA5WPM7sVyGe9Jv4EJqHIMBkcZ1k1kOgXlDLwF
         T5WeaeWy0WcJAqTYVI8ERYBzJBZeRvy3ASxc90toFCcznXRMJWQFD0YGy53DC+O6/iMy
         huNHIbztY2WQK5hxxQKr0NYQ3Ud7ki9KVVREjJvanW2bfpBnXDKY3wBvIIIWVcoJNLVv
         1mYmWFjB4ixG/snRzQHlOBImvo1sntKZJ2Z7xq+Kl3UIcc0zp/sMU/V6foJg4flviUG6
         KsbA==
X-Gm-Message-State: AOAM531bA2Kkivz5C6JtsAYTAQhJybW8a/ya4As1vyxNmY9Oz4DxYuvZ
        WEWcJ4KBUUq2v77UDK/Huw==
X-Google-Smtp-Source: ABdhPJxQRC2hDazWRnHx6HVUyG/OxIUURk6yYbgjpKPr1lZXzY4+auLTp11NjAtvPj4c/6iBYyYg8Q==
X-Received: by 2002:a05:6e02:14cf:: with SMTP id o15mr1329621ilk.239.1596488525559;
        Mon, 03 Aug 2020 14:02:05 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 18/27] PCI: dwc: Remove storing of PCI resources
Date:   Mon,  3 Aug 2020 15:01:07 -0600
Message-Id: <20200803210116.3132633-19-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI bridge resources are stored in pci_host_bridge.windows, so
there's no need to store them in a DWC specific struct. There's also no
need to parse the resources and store them a 2nd time as they are mainly
used for one time setup of iATU windows.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Chocron <jonnyc@amazon.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c     |  8 +++--
 drivers/pci/controller/dwc/pcie-al.c          |  7 +++--
 .../pci/controller/dwc/pcie-designware-host.c | 29 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  6 ----
 4 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 17271b21fb7d..bdf4fe1fc822 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -400,10 +400,14 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
-	u64 start = pp->mem->start;
-	u64 end = pp->mem->end;
+	u64 start, end;
+	struct resource *mem;
 	int i;
 
+	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
+	start = mem->start;
+	end = mem->end;
+
 	/* Disable BARs for inbound access */
 	ks_pcie_set_dbi_mode(ks_pcie);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 5c5763f14485..72bf1777f264 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -265,6 +265,7 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	u8 secondary_bus;
 	u32 cfg_control;
 	u32 reg;
+	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
 
 	target_bus_cfg = &pcie->target_bus_cfg;
 
@@ -278,13 +279,13 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	target_bus_cfg->ecam_mask = ecam_bus_mask;
 	/* This portion is taken from the cfg_target_bus reg */
 	target_bus_cfg->reg_mask = ~target_bus_cfg->ecam_mask;
-	target_bus_cfg->reg_val = pp->busn->start & target_bus_cfg->reg_mask;
+	target_bus_cfg->reg_val = bus->start & target_bus_cfg->reg_mask;
 
 	al_pcie_target_bus_set(pcie, target_bus_cfg->reg_val,
 			       target_bus_cfg->reg_mask);
 
-	secondary_bus = pp->busn->start + 1;
-	subordinate_bus = pp->busn->end;
+	secondary_bus = bus->start + 1;
+	subordinate_bus = bus->end;
 
 	/* Set the valid values of secondary and subordinate buses */
 	cfg_control_offset = AXI_BASE_OFFSET + pcie->reg_offsets.ob_ctrl +
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9528c8b1c9ab..a981e9de81d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -331,17 +331,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	resource_list_for_each_entry(win, &bridge->windows) {
 		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
-			pp->io = win->res;
-			pp->io->name = "I/O";
-			pp->io_size = resource_size(pp->io);
-			pp->io_bus_addr = pp->io->start - win->offset;
-			pp->io_base = pci_pio_to_address(pp->io->start);
-			break;
-		case IORESOURCE_MEM:
-			pp->mem = win->res;
-			pp->mem->name = "MEM";
-			pp->mem_size = resource_size(pp->mem);
-			pp->mem_bus_addr = pp->mem->start - win->offset;
+			pp->io_size = resource_size(win->res);
+			pp->io_bus_addr = win->res->start - win->offset;
+			pp->io_base = pci_pio_to_address(win->res->start);
 			break;
 		case 0:
 			pp->cfg = win->res;
@@ -350,9 +342,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->cfg0_base = pp->cfg->start;
 			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
 			break;
-		case IORESOURCE_BUS:
-			pp->busn = win->res;
-			break;
 		}
 	}
 
@@ -366,8 +355,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	pp->mem_base = pp->mem->start;
-
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
@@ -438,8 +425,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			goto err_free_msi;
 	}
 
-	pp->root_bus_nr = pp->busn->start;
-
 	bridge->dev.parent = dev;
 	bridge->sysdata = pp;
 	bridge->busnr = pp->root_bus_nr;
@@ -623,9 +608,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * ATU, so we should not program the ATU here.
 	 */
 	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
+		struct resource_entry *entry =
+			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-					  pp->mem_bus_addr, pp->mem_size);
+					  PCIE_ATU_TYPE_MEM, entry->res->start,
+					  entry->res->start - entry->offset,
+					  resource_size(entry->res));
 		if (pci->num_viewport > 2)
 			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
 						  PCIE_ATU_TYPE_IO, pp->io_base,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 67aac6fdca24..3d552ec8a850 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -176,13 +176,7 @@ struct pcie_port {
 	resource_size_t		io_base;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
-	u64			mem_base;
-	phys_addr_t		mem_bus_addr;
-	u32			mem_size;
 	struct resource		*cfg;
-	struct resource		*io;
-	struct resource		*mem;
-	struct resource		*busn;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
 	int			msi_irq;
-- 
2.25.1

