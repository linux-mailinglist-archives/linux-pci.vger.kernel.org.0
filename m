Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAF23AEEF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgHCVBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:36 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40929 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgHCVBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:34 -0400
Received: by mail-il1-f195.google.com with SMTP id x1so12026155ilp.7;
        Mon, 03 Aug 2020 14:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enkj1hpfF2DRae6tMsmNr00vC0nnMrJ8ecK1LKopnys=;
        b=rQn1t+BOENmRWvmbHYrQf3zlPXqpa/lIcaiBI45L63nvwN1Hk5EFBK1wnEIhVnzJLs
         GtegczRiLxzQ+MWNgA9d7fmKcCg/p2cz4tD+ez+O1QUo9zCAxOB9aaPt+YblWm+TtWX0
         1hUA7my7iKW8cyTw3Kki5X0wwPbQ+RJTV2+lArmdqOflhcuGZ8PUhsRWtuV5WkFsHF9/
         AC8mP2sVTmP7eBT+lLTZ6HKU0oCBiUUkrbNoxMEefk0ak/tUGF6ccWg12A4a30k/9HFa
         lkfiP8ggjOeeSpg32rHIr5q1QeCX5NMH/b3ujQfcqUK3JsYdSUwnoJy3relZ040Yzqw1
         HRjA==
X-Gm-Message-State: AOAM533rOodk6idYvR7l4IbEwNCCo2GO10BSeYOD6a/r70TmD1LVle3Q
        iN49JDpO7PG5sG8gr/7QJw==
X-Google-Smtp-Source: ABdhPJzWPzbp0GjA/fWrdCLZshRyk6S65JBCKe+YdG5gw5OjbQ3+gG0tLzeJjdOPlVejehxqb5N9Qg==
X-Received: by 2002:a92:d2c8:: with SMTP id w8mr1409855ilg.38.1596488493349;
        Mon, 03 Aug 2020 14:01:33 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:32 -0700 (PDT)
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
Subject: [RFC 06/27] PCI: dwc: keystone: Use pci_ops for config space accessors
Date:   Mon,  3 Aug 2020 15:00:55 -0600
Message-Id: <20200803210116.3132633-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 40 ++++++++++-------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 790679fdfa48..df1194d186bc 100644
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
-	if (bus->parent->number != pp->root_bus_nr)
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

