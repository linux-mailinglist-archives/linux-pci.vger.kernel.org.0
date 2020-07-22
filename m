Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33C228E05
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgGVCZh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37241 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgGVCZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:37 -0400
Received: by mail-io1-f67.google.com with SMTP id v6so878573iob.4;
        Tue, 21 Jul 2020 19:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oM4JjaIhGNUCsF1dxzKGJCBiD9UbSALjkOnB0iODMZ0=;
        b=uNIqJth6crKNt4PuptFzeo6+HZ0KWlCA/dyaulJ6/Zen2/gCqF4jg/NoAIzSEvnYE4
         dZW2sv8lnI8AWBJSatMP8t8sUCtvVEsB5jf09j9kBzEHBRFFYDq/luaUT5TgBhiZJc8k
         vEJKKC1rE92rvboTycosymw1ui9QQ7L0NgzeGAE5Vllvyjg1GeQa1SBD+o55CAEmthxQ
         WzJuLTRzeMnb6px0Eix8/cO2vv9h1Tb01xJdrkflmZL0fWAS9C0d4ylWlgDxieQZaoyg
         wO/3xm/o84HwxWq5PTWW9z8aWy+lUwd/2OwV4NBfs+XOS/bA0gyX8YqM7lroizMAZkue
         ahdg==
X-Gm-Message-State: AOAM5306jiIhyd0EqjgAG5MWzhTmlS7gkp5Ki81GLgQs4WS/Ou/79fVG
        BcxOE7HE9kYPihFjj7zVEw==
X-Google-Smtp-Source: ABdhPJyN6+/cwBD//NLJoPanWPRv1QX1UiE0Njw0SkNnxIvIn/rh3ZWXUAQJ+Zy79aKcLX73FfSj/A==
X-Received: by 2002:a92:cf51:: with SMTP id c17mr28985837ilr.122.1595384735554;
        Tue, 21 Jul 2020 19:25:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 05/19] PCI: designware: Use pci_is_root_bus() to check if bus is root bus
Date:   Tue, 21 Jul 2020 20:25:00 -0600
Message-Id: <20200722022514.1283916-6-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_is_root_bus() rather than tracking the root bus number to
determine if the bus is the root bus or not. This removes storing
duplicated data as well as the need for the host bridge driver to have
to care about the bus numbers in most cases.

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c          |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c      |  4 ++--
 .../pci/controller/dwc/pcie-designware-host.c  | 18 +++++++-----------
 drivers/pci/controller/dwc/pcie-designware.h   |  1 -
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8f08ae53f53e..9f1e4d9c008b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1269,7 +1269,7 @@ static void imx6_pcie_quirk(struct pci_dev *dev)
 	if (bus->dev.parent->parent->driver != &imx6_pcie_driver.driver)
 		return;
 
-	if (bus->number == pp->root_bus_nr) {
+	if (pci_is_root_bus(bus)) {
 		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 790679fdfa48..fcc3586c345b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -440,7 +440,7 @@ static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
 		CFG_FUNC(PCI_FUNC(devfn));
-	if (bus->parent->number != pp->root_bus_nr)
+	if (!pci_is_root_bus(bus->parent))
 		reg |= CFG_TYPE1;
 	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
 
@@ -457,7 +457,7 @@ static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
 		CFG_FUNC(PCI_FUNC(devfn));
-	if (bus->parent->number != pp->root_bus_nr)
+	if (!pci_is_root_bus(bus->parent))
 		reg |= CFG_TYPE1;
 	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 4a16306cec25..9e8a9cfc6d3a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -473,10 +473,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		goto err_free_msi;
 	}
 
-	pp->root_bus_nr = pp->busn->start;
-
 	bridge->sysdata = pp;
-	bridge->busnr = pp->root_bus_nr;
+	bridge->busnr = pp->busn->start;
 	bridge->ops = &dw_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
@@ -528,7 +526,7 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 
-	if (bus->parent->number == pp->root_bus_nr) {
+	if (pci_is_root_bus(bus->parent)) {
 		type = PCIE_ATU_TYPE_CFG0;
 		cpu_addr = pp->cfg0_base;
 		cfg_size = pp->cfg0_size;
@@ -584,13 +582,11 @@ static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	/* If there is no link, then there is no device */
-	if (bus->number != pp->root_bus_nr) {
+	if (!pci_is_root_bus(bus)) {
 		if (!dw_pcie_link_up(pci))
 			return 0;
-	}
-
-	/* Access only one slot on each root port */
-	if (bus->number == pp->root_bus_nr && dev > 0)
+	} else if (dev > 0)
+		/* Access only one slot on each root port */
 		return 0;
 
 	return 1;
@@ -606,7 +602,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	if (bus->number == pp->root_bus_nr)
+	if (pci_is_root_bus(bus))
 		return dw_pcie_rd_own_conf(pp, where, size, val);
 
 	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
@@ -620,7 +616,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (bus->number == pp->root_bus_nr)
+	if (pci_is_root_bus(bus))
 		return dw_pcie_wr_own_conf(pp, where, size, val);
 
 	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 656e00f8fbeb..fd2146298b58 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -173,7 +173,6 @@ struct dw_pcie_host_ops {
 };
 
 struct pcie_port {
-	u8			root_bus_nr;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
-- 
2.25.1

