Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54324CBE4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgHUDzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45465 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgHUDzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:13 -0400
Received: by mail-io1-f65.google.com with SMTP id u126so451928iod.12;
        Thu, 20 Aug 2020 20:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWe/hGwQkMqkRgfmf3CKztYtr/mVIP4aBkGHJDTxqi8=;
        b=BpCGu8UZb2A6pC5Ws2lrjA8S8ULqQzFxLMsY/+XxHK644TLSue9uVYTRpCI7C+yo53
         9sHsSs02DiVq5yt4p1tA+fxjyZFqMsUXug1aXuzmQbn8eSkXOhMRZzYryyqmsTewxP/z
         IY6EZ54MfoVmTdABSb7ggB6PzEVsGxtOzB0hXzswskoSp0jZ20r2nw0/fY0WF9wCuuWg
         0dO9atALUc9weQ7flEPjDexJhy6hbknoH0HoYTWYulcs0LGkWYNuwO1z4wmaR/vyhShm
         tBXq78L6ao+pARnTAI50McykVv2xvbjOgx+ELUAMgiyzhvpj7y5uSLqBTzB9HDccFd8h
         oaeg==
X-Gm-Message-State: AOAM531xgzPUS2wUZol+17y9V4C5AaXAthvTKQiCNnUZ5gk0QzlFi+SS
        BW1StcZ3FDdSXbhUAatFng==
X-Google-Smtp-Source: ABdhPJx50jcI3UQ9zpFKWNK4wLbfs5QeqO/cNtsCvlwq+y2ijT3aunqglLB1Z5kaXzxkIBmgGxKWaw==
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr824983jat.109.1597982111917;
        Thu, 20 Aug 2020 20:55:11 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:11 -0700 (PDT)
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
Subject: [PATCH v2 10/40] PCI: dwc: exynos: Use pci_ops for root config space accessors
Date:   Thu, 20 Aug 2020 21:53:50 -0600
Message-Id: <20200821035420.380495-11-robh@kernel.org>
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
buses, convert the Samsung Exynos driver to use the standard pci_ops for
root bus config accesses.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-exynos.c | 45 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 8d82c43ae299..242683cde04a 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -336,32 +336,37 @@ static void exynos_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 	exynos_pcie_sideband_dbi_w_mode(ep, false);
 }
 
-static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-				u32 *val)
+static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	exynos_pcie_sideband_dbi_r_mode(ep, true);
-	ret = dw_pcie_read(pci->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_r_mode(ep, false);
-	return ret;
+	if (PCI_SLOT(devfn)) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	*val = dw_pcie_read_dbi(pci, where, size);
+	return PCIBIOS_SUCCESSFUL;
 }
 
-static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
-				u32 val)
+static int exynos_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	exynos_pcie_sideband_dbi_w_mode(ep, true);
-	ret = dw_pcie_write(pci->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_w_mode(ep, false);
-	return ret;
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dw_pcie_write_dbi(pci, where, size, val);
+	return PCIBIOS_SUCCESSFUL;
 }
 
+static struct pci_ops exynos_pci_ops = {
+	.read = exynos_pcie_rd_own_conf,
+	.write = exynos_pcie_wr_own_conf,
+};
+
 static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
@@ -379,6 +384,8 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 
+	pp->bridge->ops = &exynos_pci_ops;
+
 	exynos_pcie_establish_link(ep);
 	exynos_pcie_enable_interrupts(ep);
 
@@ -386,8 +393,6 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
-	.rd_own_conf = exynos_pcie_rd_own_conf,
-	.wr_own_conf = exynos_pcie_wr_own_conf,
 	.host_init = exynos_pcie_host_init,
 };
 
-- 
2.25.1

