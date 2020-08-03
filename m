Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA623AEEB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgHCVBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:34 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44506 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgHCVBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:32 -0400
Received: by mail-il1-f196.google.com with SMTP id j9so28944215ilc.11;
        Mon, 03 Aug 2020 14:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQL3A7dHzz+gC5njEctrBiMEIqtA+XjXrb2o208g3Ks=;
        b=F7YBgQRbZju55J1lslO3ZYYUq/hG4N8wTHAwZU2uIZn8/wbItJEPFW7cgXc/wG+XfX
         h0WHNqI1RTLpyW656CwcisHE7Q+Q4x8mW2n84ZwgibfSrfEBeh6zm2gmmWlakCDUtgEx
         avkG/p9QCgev92l5nTcWtt14O1h+Elp5VWTer/gNDWmJQlxbloZGCMUvdStxhzeqXlpS
         LSjbamKWn3SX7BPFb8J11Gzdtulr3dRD/Qp0FqS50o17Sqf7h5MtlxvR1BWPEFbhy8cp
         PyoI8WMbk9WKubwvcXdA1h7tHii6zExHwmSoD9wS9iFe7js/PGcKdtTMbtf+5I5DxpEU
         1XCg==
X-Gm-Message-State: AOAM533sflnPRlLher4tSnqpk1k4OBCcobnTMHudfrIOl+9Q6YddgPbV
        fiUxMbrLl0V74dU6/sv1wQ==
X-Google-Smtp-Source: ABdhPJzftW92R17dfbV7F93wEn6AsKYKgSXK+D8yX+DoZOz9nVGWzXcp3oJtQO05/bk7IoPLrTUNQg==
X-Received: by 2002:a92:d7cb:: with SMTP id g11mr1303449ilq.89.1596488491153;
        Mon, 03 Aug 2020 14:01:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:30 -0700 (PDT)
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
Subject: [RFC 05/27] PCI: dwc: al: Use pci_ops for child config space accessors
Date:   Mon,  3 Aug 2020 15:00:54 -0600
Message-Id: <20200803210116.3132633-6-robh@kernel.org>
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
index 270868f3859a..5c5763f14485 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -222,14 +222,15 @@ static inline void al_pcie_target_bus_set(struct al_pcie *pcie,
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
@@ -245,52 +246,14 @@ static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
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
@@ -344,6 +307,8 @@ static int al_pcie_host_init(struct pcie_port *pp)
 	struct al_pcie *pcie = to_al_pcie(pci);
 	int rc;
 
+	pp->bridge->child_ops = &al_child_pci_ops;
+
 	rc = al_pcie_rev_id_get(pcie, &pcie->controller_rev_id);
 	if (rc)
 		return rc;
@@ -358,8 +323,6 @@ static int al_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops al_pcie_host_ops = {
-	.rd_other_conf = al_pcie_rd_other_conf,
-	.wr_other_conf = al_pcie_wr_other_conf,
 	.host_init = al_pcie_host_init,
 };
 
-- 
2.25.1

