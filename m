Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4224CBD0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHUDy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:54:57 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36942 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgHUDyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:55 -0400
Received: by mail-il1-f196.google.com with SMTP id v2so340296ilq.4;
        Thu, 20 Aug 2020 20:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwCNR+WNDjfzqtdcC/li0ejBM2HfVilEnzsTLaeoEwU=;
        b=gp0cnml5Q3aKVQ1gKldNVuHR/6A8SuahGZ9s0lEd3Qj5jMO9Fqy3zYdhpO0SdvbmrO
         2fr3Nwp6YCcx7EMdZgx0L24WyLrYL4wcPWdxhXFiYwZCs8syf8nVcek1CfQqC3rPofCC
         MuwPez3sQ4ogeKxvFGIdJ5G2zB4WfJ2mGcbfkdsYQtjmM+oOijnMl/+ZNw4i9UhiR+Ht
         X2yBEdGLtTdjB2JLLZkuM2wdx8kAuKhKjSJ0AvxwfovDULB/tgPHuQTXt4r0IHlk+wPA
         KjU/lwR7oIMIwK4IHR/qCYhTvOxOchj4jAGDgOKi4fsSsHBj9YzIxjlIgvjQIg02r3LP
         oHPA==
X-Gm-Message-State: AOAM5310dkcYRGqEVSf2WPEG6qotjAaCPAddAcpJTw4w2cPUfoI07JAL
        oTck7Rmga40mTmo4KyDi+A==
X-Google-Smtp-Source: ABdhPJx9JqpO/DKRgSuplQvzG+Cjx878vVrB57+HcUISADbr28s+JIi8TW6C4IBYLo6NE77T526fqA==
X-Received: by 2002:a92:c9cb:: with SMTP id k11mr1025850ilq.194.1597982094261;
        Thu, 20 Aug 2020 20:54:54 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:53 -0700 (PDT)
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
Subject: [PATCH v2 06/40] PCI: dwc: keystone: Use pci_ops for config space accessors
Date:   Thu, 20 Aug 2020 21:53:46 -0600
Message-Id: <20200821035420.380495-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that DWC drivers can setup their own pci_ops for the root and child
buses, convert the TI Keystone driver to use the standard pci_ops for
config accesses.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 40 ++++++++++-------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c8c9d6a75f17..2b0906e1e0d3 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -430,10 +430,10 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 }
 
-static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 unsigned int devfn, int where, int size,
-				 u32 *val)
+static void __iomem *ks_pcie_other_map_bus(struct pci_bus *bus,
+					   unsigned int devfn, int where)
 {
+	struct pcie_port *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	u32 reg;
@@ -444,25 +444,14 @@ static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		reg |= CFG_TYPE1;
 	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
 
-	return dw_pcie_read(pp->va_cfg0_base + where, size, val);
+	return pp->va_cfg0_base + where;
 }
 
-static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 unsigned int devfn, int where, int size,
-				 u32 val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u32 reg;
-
-	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
-		CFG_FUNC(PCI_FUNC(devfn));
-	if (!pci_is_root_bus(bus->parent))
-		reg |= CFG_TYPE1;
-	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
-
-	return dw_pcie_write(pp->va_cfg0_base + where, size, val);
-}
+static struct pci_ops ks_child_pcie_ops = {
+	.map_bus = ks_pcie_other_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
 
 /**
  * ks_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
@@ -490,6 +479,12 @@ static void ks_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
 }
 
+static struct pci_ops ks_pcie_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
 /**
  * ks_pcie_link_up() - Check if link up
  */
@@ -807,6 +802,9 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	int ret;
 
+	pp->bridge->ops = &ks_pcie_ops;
+	pp->bridge->child_ops = &ks_child_pcie_ops;
+
 	ret = ks_pcie_config_legacy_irq(ks_pcie);
 	if (ret)
 		return ret;
@@ -842,8 +840,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops ks_pcie_host_ops = {
-	.rd_other_conf = ks_pcie_rd_other_conf,
-	.wr_other_conf = ks_pcie_wr_other_conf,
 	.host_init = ks_pcie_host_init,
 	.msi_host_init = ks_pcie_msi_host_init,
 	.scan_bus = ks_pcie_v3_65_scan_bus,
-- 
2.25.1

