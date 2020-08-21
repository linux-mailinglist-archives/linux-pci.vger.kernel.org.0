Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CABF24CC10
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgHUDzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39187 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgHUDzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:36 -0400
Received: by mail-io1-f67.google.com with SMTP id z17so472143ioi.6;
        Thu, 20 Aug 2020 20:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKpGw8g9D5lHlv+L/0NA+T2uMSN3NzGKbKBvpN5Q0n8=;
        b=f94QpEQ+HfIPhd7j++Hsnx+WgrNxWfsA/OWOY1ak4PPUyEXY9lF4EuGu90WBzH1Q+5
         TEGMrKA/tw3T2GbWHgPNj1LuAtsOzMejCShkeApjdJsAWdh5BUrIoxeTeme6Z0a49xi1
         GMpMSqdxvPWvKdl6ZXixI7agV8Qk29izD2PQA24N0AtSEVOkeUeAcetAUCQSmja0qqnO
         7QGtvqyQzWOoq76/14v8juQlqUsZrM5t7kqOmCmsp3QtehsHxaDKFVtTMlj/LGPqa+jp
         xi+YSnioZ1i7fuGwz9jHDFh8cQ/tlTRasN7nakLsnDlExaFNb9H28dFe4ExLQW+L0O1T
         O3sw==
X-Gm-Message-State: AOAM5320EklHljuBzh6su6Phbq8WQ7tPHyUyZTx6BPvFdLqfjPJId3K6
        IJEZ4gq88iW5mJBMnPYcgA==
X-Google-Smtp-Source: ABdhPJzgDa9u0O0PJtKD/ofc2cFRYs9BPDlw6P3AZyp/m2IdJb2DAE7XQ/zQT2je6A6aqXleqjKPAQ==
X-Received: by 2002:a05:6638:1356:: with SMTP id u22mr993038jad.110.1597982135158;
        Thu, 20 Aug 2020 20:55:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 18/40] PCI: dwc: Remove storing of PCI resources
Date:   Thu, 20 Aug 2020 21:53:58 -0600
Message-Id: <20200821035420.380495-19-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
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
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c     |  8 ++++--
 drivers/pci/controller/dwc/pcie-al.c          |  7 ++---
 .../pci/controller/dwc/pcie-designware-host.c | 27 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  |  6 -----
 4 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index fd000384fd2a..d306914a1f93 100644
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
index 59e33d3a8380..f973fbca90cf 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -260,6 +260,7 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	u8 secondary_bus;
 	u32 cfg_control;
 	u32 reg;
+	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
 
 	target_bus_cfg = &pcie->target_bus_cfg;
 
@@ -273,13 +274,13 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
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
index 0f348b951ec3..1e42345922d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -326,17 +326,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -345,9 +337,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->cfg0_base = pp->cfg->start;
 			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
 			break;
-		case IORESOURCE_BUS:
-			pp->busn = win->res;
-			break;
 		}
 	}
 
@@ -361,8 +350,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	pp->mem_base = pp->mem->start;
-
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
@@ -601,9 +588,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
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
index 78243909d2c5..50225bf6a2b5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -175,13 +175,7 @@ struct pcie_port {
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

