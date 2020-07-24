Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32C22D1E4
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 00:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgGXWmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 18:42:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44009 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgGXWmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 18:42:08 -0400
Received: by mail-io1-f68.google.com with SMTP id k23so11339890iom.10
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2020 15:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zcvJBovB8AUcA2S2qVmpOJhLHT3y3NQcUC4jkiOmF6g=;
        b=K+svyMEuExgjY7AIpBiyaghetCpXxbB9BECXs6Lh7emA4j8XH3+Klk1q8t/dSSVyg3
         IuqzZ15YLOtCzYQ0NdMSsyuDBIGDZin2EmyHc+Mc/MBN2qvftdUxujNFO03rLpjBLMsg
         HSFVwiELivI6fz5ETmxB7Ov5e0dgL5Bh020lHB6wmowmXDRgUz0pKGdpjbAq6ucb3GFt
         Dn+y+WkoTOWVbIfPT7J2BTzJHVO59ZHsh9Jzxp06ptJTHcKyrckVa20wNQqRdDNCF1B4
         cjqrvf/OIbpu33Fz4HV+2+LjsVy+YbgUV3x5yJNoc9vrjUcdzwZXBr9opSkoseXlnbNV
         ZLPQ==
X-Gm-Message-State: AOAM532OJbCLM4hwVfbI2TVmHJWpUF6cILYoCA2F0UBGdvA+s0CEZNP4
        g5AJ/yT9o3r2Wbx7ipQXs4js4HCNoQ==
X-Google-Smtp-Source: ABdhPJxchmYpI2YRGcLJYu3bEUkPFNdStBZPY2F+DMahS52zSBb1NAFmWiUZfgqBdtgHZjDl4jvspg==
X-Received: by 2002:a5e:8408:: with SMTP id h8mr1738695ioj.137.1595630526421;
        Fri, 24 Jul 2020 15:42:06 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id c67sm4037335iof.16.2020.07.24.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 15:42:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: dwc: hisi: Remove non-ECAM HiSilicon hip05/hip06 driver
Date:   Fri, 24 Jul 2020 16:42:04 -0600
Message-Id: <20200724224204.3249055-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The HiSilicon non-ECAM PCIe has been broken since March 2016 commit
7e57fd1444bf ("PCI: designware: Move Root Complex setup code to
dw_pcie_setup_rc()"). The reason is this commit moved the iATU setup code
from dw_pcie_host_init() to dw_pcie_setup_rc(), but the hisi driver never
calls dw_pcie_setup_rc(). The result is the PCI memory space is never
configured and the driver can't work. It's also clear it has an iATU as
the config space accesses use it.

There's also no dts file using either "hisilicon,hip05-pcie" or
"hisilicon,hip06-pcie".

Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-hisi.c | 219 -------------------------
 1 file changed, 219 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 0ad4e07dd4c2..5ca86796d43a 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -10,15 +10,10 @@
  */
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of_address.h>
-#include <linux/of_pci.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
-#include <linux/regmap.h>
 #include "../../pci.h"
 
 #if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
@@ -118,220 +113,6 @@ const struct pci_ecam_ops hisi_pcie_ops = {
 
 #ifdef CONFIG_PCI_HISI
 
-#include "pcie-designware.h"
-
-#define PCIE_SUBCTRL_SYS_STATE4_REG		0x6818
-#define PCIE_HIP06_CTRL_OFF			0x1000
-#define PCIE_SYS_STATE4				(PCIE_HIP06_CTRL_OFF + 0x31c)
-#define PCIE_LTSSM_LINKUP_STATE			0x11
-#define PCIE_LTSSM_STATE_MASK			0x3F
-
-#define to_hisi_pcie(x)	dev_get_drvdata((x)->dev)
-
-struct hisi_pcie;
-
-struct pcie_soc_ops {
-	int (*hisi_pcie_link_up)(struct hisi_pcie *hisi_pcie);
-};
-
-struct hisi_pcie {
-	struct dw_pcie *pci;
-	struct regmap *subctrl;
-	u32 port_id;
-	const struct pcie_soc_ops *soc_ops;
-};
-
-/* HipXX PCIe host only supports 32-bit config access */
-static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
-			      u32 *val)
-{
-	u32 reg;
-	u32 reg_val;
-	void *walker = &reg_val;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	walker += (where & 0x3);
-	reg = where & ~0x3;
-	reg_val = dw_pcie_readl_dbi(pci, reg);
-
-	if (size == 1)
-		*val = *(u8 __force *) walker;
-	else if (size == 2)
-		*val = *(u16 __force *) walker;
-	else if (size == 4)
-		*val = reg_val;
-	else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-/* HipXX PCIe host only supports 32-bit config access */
-static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
-				u32 val)
-{
-	u32 reg_val;
-	u32 reg;
-	void *walker = &reg_val;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	walker += (where & 0x3);
-	reg = where & ~0x3;
-	if (size == 4)
-		dw_pcie_writel_dbi(pci, reg, val);
-	else if (size == 2) {
-		reg_val = dw_pcie_readl_dbi(pci, reg);
-		*(u16 __force *) walker = val;
-		dw_pcie_writel_dbi(pci, reg, reg_val);
-	} else if (size == 1) {
-		reg_val = dw_pcie_readl_dbi(pci, reg);
-		*(u8 __force *) walker = val;
-		dw_pcie_writel_dbi(pci, reg, reg_val);
-	} else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
-{
-	u32 val;
-
-	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
-		    0x100 * hisi_pcie->port_id, &val);
-
-	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
-}
-
-static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
-{
-	struct dw_pcie *pci = hisi_pcie->pci;
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, PCIE_SYS_STATE4);
-
-	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
-}
-
-static int hisi_pcie_link_up(struct dw_pcie *pci)
-{
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pci);
-
-	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
-}
-
-static const struct dw_pcie_host_ops hisi_pcie_host_ops = {
-	.rd_own_conf = hisi_pcie_cfg_read,
-	.wr_own_conf = hisi_pcie_cfg_write,
-};
-
-static int hisi_add_pcie_port(struct hisi_pcie *hisi_pcie,
-			      struct platform_device *pdev)
-{
-	struct dw_pcie *pci = hisi_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = &pdev->dev;
-	int ret;
-	u32 port_id;
-
-	if (of_property_read_u32(dev->of_node, "port-id", &port_id)) {
-		dev_err(dev, "failed to read port-id\n");
-		return -EINVAL;
-	}
-	if (port_id > 3) {
-		dev_err(dev, "Invalid port-id: %d\n", port_id);
-		return -EINVAL;
-	}
-	hisi_pcie->port_id = port_id;
-
-	pp->ops = &hisi_pcie_host_ops;
-
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(dev, "failed to initialize host\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = hisi_pcie_link_up,
-};
-
-static int hisi_pcie_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct dw_pcie *pci;
-	struct hisi_pcie *hisi_pcie;
-	struct resource *reg;
-	int ret;
-
-	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
-	if (!hisi_pcie)
-		return -ENOMEM;
-
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
-		return -ENOMEM;
-
-	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
-
-	hisi_pcie->pci = pci;
-
-	hisi_pcie->soc_ops = of_device_get_match_data(dev);
-
-	hisi_pcie->subctrl =
-	    syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
-	if (IS_ERR(hisi_pcie->subctrl)) {
-		dev_err(dev, "cannot get subctrl base\n");
-		return PTR_ERR(hisi_pcie->subctrl);
-	}
-
-	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, reg);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-	platform_set_drvdata(pdev, hisi_pcie);
-
-	ret = hisi_add_pcie_port(hisi_pcie, pdev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static struct pcie_soc_ops hip05_ops = {
-		&hisi_pcie_link_up_hip05
-};
-
-static struct pcie_soc_ops hip06_ops = {
-		&hisi_pcie_link_up_hip06
-};
-
-static const struct of_device_id hisi_pcie_of_match[] = {
-	{
-			.compatible = "hisilicon,hip05-pcie",
-			.data	    = (void *) &hip05_ops,
-	},
-	{
-			.compatible = "hisilicon,hip06-pcie",
-			.data	    = (void *) &hip06_ops,
-	},
-	{},
-};
-
-static struct platform_driver hisi_pcie_driver = {
-	.probe  = hisi_pcie_probe,
-	.driver = {
-		   .name = "hisi-pcie",
-		   .of_match_table = hisi_pcie_of_match,
-		   .suppress_bind_attrs = true,
-	},
-};
-builtin_platform_driver(hisi_pcie_driver);
-
 static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
-- 
2.25.1

