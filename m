Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA524CC0F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHUDzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36985 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgHUDzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:43 -0400
Received: by mail-il1-f193.google.com with SMTP id v2so341296ilq.4;
        Thu, 20 Aug 2020 20:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXG25ws/U2dFzSa8lenT9wsjfRYOe4p4E3p8TazUipk=;
        b=hnWredGF/dQCwSHLuNpXYw9y/hBAobbyI6aHS2HE4geW8ypv2/DomFEp8FK63ZNx+W
         bKX3BAPVF3TDB9g3Isw5mkkeuYt+xX1rTKBpUS0ZmIRaBwDMQb6HyJ2PmR3yDzXLjMMW
         WeFWQBLkq+vnI2UUFeUAPx+aTDvvmIOyJVHi2XB+z+eUR/AFdTU5bqnSCBzEb0U+A9d6
         uKH/7jeHn8TTxU5iuuTRj69NFu6Ny37rooMJsfbOZ4qKZXkcn/mKd1Uvrf2OvZIkH7qP
         MKaha9qwRKXfDV9BYTnzAchGf64BlLM2G7Zu7803FfZcrhuRXNzG2Del3zXFDF9Yz6Kb
         L5Fw==
X-Gm-Message-State: AOAM530P00AC0otCM/fqm8fHlSl9qCBbhP+ZHI2LEImBBumLp9mNwjVc
        1FmWdfwWKXjdmUrlIWDr2w==
X-Google-Smtp-Source: ABdhPJyPe0dr4IHnAhl6FtaJqFQnHw5NBMTrbn3z8oh2Lsfgv2Dr4ChvLuAoznSpFjg6tMWAOIEZlw==
X-Received: by 2002:a92:6901:: with SMTP id e1mr1002002ilc.209.1597982140468;
        Thu, 20 Aug 2020 20:55:40 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:39 -0700 (PDT)
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
Subject: [PATCH v2 19/40] PCI: dwc: Simplify config space handling
Date:   Thu, 20 Aug 2020 21:53:59 -0600
Message-Id: <20200821035420.380495-20-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The config space is divided in half for type 0 and type 1 accesses, but
this is pointless as there's only one iATU window which is
reconfigured on each access.

The only platform doing something custom is TI Keystone (surprise!).
It does its own mapping of the config space to avoid spliting the
config space and never actually uses va_cfg1_base as it has its own
config space accessors. With the splitting removed, Keystone can use the
default mapping of config space.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix passing cfg0_base in dw_pcie_other_conf_map_bus
---
 drivers/pci/controller/dwc/pci-keystone.c     |  8 ---
 .../pci/controller/dwc/pcie-designware-host.c | 63 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 --
 3 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d306914a1f93..983069a4a561 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -873,16 +873,8 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pp->va_cfg0_base))
-		return PTR_ERR(pp->va_cfg0_base);
-
-	pp->va_cfg1_base = pp->va_cfg0_base;
-
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1e42345922d5..06f6cbefeb95 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -308,10 +308,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
-		pp->cfg0_size = resource_size(cfg_res) >> 1;
-		pp->cfg1_size = resource_size(cfg_res) >> 1;
+		pp->cfg0_size = resource_size(cfg_res);
 		pp->cfg0_base = cfg_res->start;
-		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
 		dev_err(dev, "Missing *config* reg space\n");
 	}
@@ -331,25 +329,22 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io_base = pci_pio_to_address(win->res->start);
 			break;
 		case 0:
-			pp->cfg = win->res;
-			pp->cfg0_size = resource_size(pp->cfg) >> 1;
-			pp->cfg1_size = resource_size(pp->cfg) >> 1;
-			pp->cfg0_base = pp->cfg->start;
-			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
+			dev_err(dev, "Missing *config* reg space\n");
+			pp->cfg0_size = resource_size(win->res);
+			pp->cfg0_base = win->res->start;
+			if (!pci->dbi_base) {
+				pci->dbi_base = devm_pci_remap_cfgspace(dev,
+								pp->cfg0_base,
+								pp->cfg0_size);
+				if (!pci->dbi_base) {
+					dev_err(dev, "Error with ioremap\n");
+					return -ENOMEM;
+				}
+			}
 			break;
 		}
 	}
 
-	if (!pci->dbi_base) {
-		pci->dbi_base = devm_pci_remap_cfgspace(dev,
-						pp->cfg->start,
-						resource_size(pp->cfg));
-		if (!pci->dbi_base) {
-			dev_err(dev, "Error with ioremap\n");
-			return -ENOMEM;
-		}
-	}
-
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
@@ -359,16 +354,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	if (!pp->va_cfg1_base) {
-		pp->va_cfg1_base = devm_pci_remap_cfgspace(dev,
-						pp->cfg1_base,
-						pp->cfg1_size);
-		if (!pp->va_cfg1_base) {
-			dev_err(dev, "Error with ioremap\n");
-			return -ENOMEM;
-		}
-	}
-
 	ret = of_property_read_u32(np, "num-viewport", &pci->num_viewport);
 	if (ret)
 		pci->num_viewport = 2;
@@ -446,32 +431,24 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 						unsigned int devfn, int where)
 {
 	int type;
-	u32 busdev, cfg_size;
-	u64 cpu_addr;
-	void __iomem *va_cfg_base;
+	u32 busdev;
 	struct pcie_port *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 
-	if (pci_is_root_bus(bus->parent)) {
+	if (pci_is_root_bus(bus->parent))
 		type = PCIE_ATU_TYPE_CFG0;
-		cpu_addr = pp->cfg0_base;
-		cfg_size = pp->cfg0_size;
-		va_cfg_base = pp->va_cfg0_base;
-	} else {
+	else
 		type = PCIE_ATU_TYPE_CFG1;
-		cpu_addr = pp->cfg1_base;
-		cfg_size = pp->cfg1_size;
-		va_cfg_base = pp->va_cfg1_base;
-	}
+
 
 	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-				  type, cpu_addr,
-				  busdev, cfg_size);
+				  type, pp->cfg0_base,
+				  busdev, pp->cfg0_size);
 
-	return va_cfg_base + where;
+	return pp->va_cfg0_base + where;
 }
 
 static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 50225bf6a2b5..7cc322f8596c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -169,13 +169,9 @@ struct pcie_port {
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
-	u64			cfg1_base;
-	void __iomem		*va_cfg1_base;
-	u32			cfg1_size;
 	resource_size_t		io_base;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
-	struct resource		*cfg;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
 	int			msi_irq;
-- 
2.25.1

