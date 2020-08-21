Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FCB24CBCC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHUDyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:54:52 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39654 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgHUDyv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:51 -0400
Received: by mail-il1-f194.google.com with SMTP id f12so332444ils.6;
        Thu, 20 Aug 2020 20:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMrM+qtiSMWCUDEPdNKF+1qvSLxCjHol2qvMYIhg0lM=;
        b=AcNWZLwkR2qqoySNiha8Ic1wZs7fvSwe77loA8NTu3UoCcQpDMhxXi6MAc8sfSb+uA
         38fp8vyMqxQ9k8OJTCEeECNDiqTPPrtGmZYZuKgOnrSydrtRSYbzJ8xqt7vGg8scpFZ3
         1syb1IuZsjeAfAziYu7G5cOQFplnbEySg/i+CDNxke/XznAUXHhSwRRmd0efUwFypKKY
         NCHIKmXsQIFmjmBv3/wC9AjngL5Wza9AE2yhctV4ykyeFGuGCq3wprhMSinhk6qFy+RZ
         Xn/9D9y03Rp0OrgyBf4fmcEOQ1FMCShUw2Qgpudz+LE9JIk4jteiQuN+CdZckXAwInT/
         tC7g==
X-Gm-Message-State: AOAM531y7q3A4iun79OfdPchu7aSKK2giSoY6/bg24WmJ260blguF/bi
        1NModGkjXQWK3c7k88wfpQ==
X-Google-Smtp-Source: ABdhPJwv0XL0OXwwpZMdG6yLDwDy/CWX58TYS7rfLWejUwz7WvjOyk3gAOJ+/9+KkWqavfshCopL3A==
X-Received: by 2002:a92:b05:: with SMTP id b5mr1005648ilf.14.1597982089434;
        Thu, 20 Aug 2020 20:54:49 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:48 -0700 (PDT)
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
Subject: [PATCH v2 05/40] PCI: dwc: al: Use pci_ops for child config space accessors
Date:   Thu, 20 Aug 2020 21:53:45 -0600
Message-Id: <20200821035420.380495-6-robh@kernel.org>
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
buses, convert the Amazon driver to use the standard pci_ops for child
bus config accesses.

Cc: Jonathan Chocron <jonnyc@amazon.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-al.c | 63 ++++++----------------------
 1 file changed, 13 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index d57d4ee15848..59e33d3a8380 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -217,14 +217,15 @@ static inline void al_pcie_target_bus_set(struct al_pcie *pcie,
 				  reg);
 }
 
-static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
-					   unsigned int busnr,
-					   unsigned int devfn)
+static void __iomem *al_pcie_conf_addr_map_bus(struct pci_bus *bus,
+					       unsigned int devfn, int where)
 {
+	struct pcie_port *pp = bus->sysdata;
+	struct al_pcie *pcie = to_al_pcie(to_dw_pcie_from_pp(pp));
+	unsigned int busnr = bus->number;
 	struct al_pcie_target_bus_cfg *target_bus_cfg = &pcie->target_bus_cfg;
 	unsigned int busnr_ecam = busnr & target_bus_cfg->ecam_mask;
 	unsigned int busnr_reg = busnr & target_bus_cfg->reg_mask;
-	struct pcie_port *pp = &pcie->pci->pp;
 	void __iomem *pci_base_addr;
 
 	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
@@ -240,52 +241,14 @@ static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
 				       target_bus_cfg->reg_mask);
 	}
 
-	return pci_base_addr;
-}
-
-static int al_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 unsigned int devfn, int where, int size,
-				 u32 *val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct al_pcie *pcie = to_al_pcie(pci);
-	unsigned int busnr = bus->number;
-	void __iomem *pci_addr;
-	int rc;
-
-	pci_addr = al_pcie_conf_addr_map(pcie, busnr, devfn);
-
-	rc = dw_pcie_read(pci_addr + where, size, val);
-
-	dev_dbg(pci->dev, "%d-byte config read from %04x:%02x:%02x.%d offset 0x%x (pci_addr: 0x%px) - val:0x%x\n",
-		size, pci_domain_nr(bus), bus->number,
-		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
-		(pci_addr + where), *val);
-
-	return rc;
+	return pci_base_addr + where;
 }
 
-static int al_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 unsigned int devfn, int where, int size,
-				 u32 val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct al_pcie *pcie = to_al_pcie(pci);
-	unsigned int busnr = bus->number;
-	void __iomem *pci_addr;
-	int rc;
-
-	pci_addr = al_pcie_conf_addr_map(pcie, busnr, devfn);
-
-	rc = dw_pcie_write(pci_addr + where, size, val);
-
-	dev_dbg(pci->dev, "%d-byte config write to %04x:%02x:%02x.%d offset 0x%x (pci_addr: 0x%px) - val:0x%x\n",
-		size, pci_domain_nr(bus), bus->number,
-		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
-		(pci_addr + where), val);
-
-	return rc;
-}
+static struct pci_ops al_child_pci_ops = {
+	.map_bus = al_pcie_conf_addr_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
 
 static void al_pcie_config_prepare(struct al_pcie *pcie)
 {
@@ -339,6 +302,8 @@ static int al_pcie_host_init(struct pcie_port *pp)
 	struct al_pcie *pcie = to_al_pcie(pci);
 	int rc;
 
+	pp->bridge->child_ops = &al_child_pci_ops;
+
 	rc = al_pcie_rev_id_get(pcie, &pcie->controller_rev_id);
 	if (rc)
 		return rc;
@@ -353,8 +318,6 @@ static int al_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops al_pcie_host_ops = {
-	.rd_other_conf = al_pcie_rd_other_conf,
-	.wr_other_conf = al_pcie_wr_other_conf,
 	.host_init = al_pcie_host_init,
 };
 
-- 
2.25.1

