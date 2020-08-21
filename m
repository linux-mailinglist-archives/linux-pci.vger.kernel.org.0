Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9847424CBD6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgHUDzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:00 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36651 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgHUDy7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:59 -0400
Received: by mail-il1-f196.google.com with SMTP id f75so52995ilh.3;
        Thu, 20 Aug 2020 20:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+ujdoKHStFeKJ1jXdR6XUfewUNSi1zr1kmdQR9ZccE=;
        b=oqOy4jiyaOBCquToZqd1lzi7DYKYDXqdGVPhSHgvAxNGsaZVNnzLG0wBF6UOCx1KZg
         unQcG9LS3CaRQip8hsTu+Nle/EpA6kEz5814DgLsXVGI8dZf+BTUnojO7HHU/ZH9IQgS
         jwJ0Wmzqbzq1ALhAxYOngMIxvJ61ly7l3dUokF5AwDBADrkCAQHUBnakk6bbClxlJPBh
         U92kI/RJKbox8B9By+5NZwZ+k6/5JCc1gLYqFyVfim7JnwT9bTGbFdI6GNWpYdWQ8r7z
         vCfbtqjKFUfo3EBilonXOP5zHUzr+Br4sh+Pq3hhuw3xuPQL65TU88I4zLSNgfZcchK/
         wsOQ==
X-Gm-Message-State: AOAM533SJkTYWdEbs9GXfX5H4FVxy0b5S8J2KtJKSlD0e/3F0xJaHO8y
        a/pC7I03t/vutG1H4phmag==
X-Google-Smtp-Source: ABdhPJyGcdTcGNrWfl7zrdoCxTOnwqbiPBd5WAuEJe+aUiQ1r9uwxw0SWXMbVHDQmShzNH/ZvrMlrw==
X-Received: by 2002:a92:914a:: with SMTP id t71mr959815ild.298.1597982098265;
        Thu, 20 Aug 2020 20:54:58 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:57 -0700 (PDT)
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
Subject: [PATCH v2 07/40] PCI: dwc: tegra: Use pci_ops for root config space accessors
Date:   Thu, 20 Aug 2020 21:53:47 -0600
Message-Id: <20200821035420.380495-8-robh@kernel.org>
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
buses, convert the Tegra driver to use the standard pci_ops for root
bus config accesses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 30 ++++++++++++----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 70498689d0c0..b723c9f3ece4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -568,42 +568,44 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int tegra_pcie_dw_rd_own_conf(struct pcie_port *pp, int where, int size,
-				     u32 *val)
+static int tegra_pcie_dw_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
+				     int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
 	/*
 	 * This is an endpoint mode specific register happen to appear even
 	 * when controller is operating in root port mode and system hangs
 	 * when it is accessed with link being in ASPM-L1 state.
 	 * So skip accessing it altogether
 	 */
-	if (where == PORT_LOGIC_MSIX_DOORBELL) {
+	if (!PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL) {
 		*val = 0x00000000;
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	return dw_pcie_read(pci->dbi_base + where, size, val);
+	return pci_generic_config_read(bus, devfn, where, size, val);
 }
 
-static int tegra_pcie_dw_wr_own_conf(struct pcie_port *pp, int where, int size,
-				     u32 val)
+static int tegra_pcie_dw_wr_own_conf(struct pci_bus *bus, u32 devfn, int where,
+				     int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
 	/*
 	 * This is an endpoint mode specific register happen to appear even
 	 * when controller is operating in root port mode and system hangs
 	 * when it is accessed with link being in ASPM-L1 state.
 	 * So skip accessing it altogether
 	 */
-	if (where == PORT_LOGIC_MSIX_DOORBELL)
+	if (!PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL)
 		return PCIBIOS_SUCCESSFUL;
 
-	return dw_pcie_write(pci->dbi_base + where, size, val);
+	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
+static struct pci_ops tegra_pci_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = tegra_pcie_dw_rd_own_conf,
+	.write = tegra_pcie_dw_wr_own_conf,
+};
+
 #if defined(CONFIG_PCIEASPM)
 static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 {
@@ -970,6 +972,8 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val, tmp, offset, speed;
 
+	pp->bridge->ops = &tegra_pci_ops;
+
 	tegra_pcie_prepare_host(pp);
 
 	if (dw_pcie_wait_for_link(pci)) {
@@ -1057,8 +1061,6 @@ static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 };
 
 static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
-	.rd_own_conf = tegra_pcie_dw_rd_own_conf,
-	.wr_own_conf = tegra_pcie_dw_wr_own_conf,
 	.host_init = tegra_pcie_dw_host_init,
 	.set_num_vectors = tegra_pcie_set_msi_vec_num,
 };
-- 
2.25.1

