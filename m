Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B08524CBE3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHUDzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40519 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgHUDzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:10 -0400
Received: by mail-io1-f66.google.com with SMTP id b17so471477ion.7;
        Thu, 20 Aug 2020 20:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFg1YpOXTjGvAAjYWr6Bj6FfzEbwYJGtjSsSCN/Mie0=;
        b=K4BrF9gWGQMoXEk/8uQ5gRsEVMScPBp/PSlrM7DqpJtl4g2GIgp3BH/p2rHEJK/+Nm
         Xil1fH+/kkJoRwhnlZbXZSeiSaQqogZKGYkJwQyBT4I1KcYKe8gQOdchkH7wW4cSAW85
         OxECeJrPVa5ZBEdaqHfFce93FH2bnSEPBYfPf4dWQNDiy4QBahOLp60pGkIXQ1HHhLHl
         TA3Nqf26f947eyV+zRlFXKvQvqcvEyXW8y5FOzu7dT4SqjlveS+Gxt15HuW9KVP/cwFK
         GRSE3mWMTI9K5Y5IeBAnw79nMl8soIbiks/V8UTQmGHDHpmtng95a6rZVFnbG6Xqo0x3
         X/jA==
X-Gm-Message-State: AOAM532A3XORi1U/nkBUOc5RU/O899pVfIwar/e6PQrLz57z8UwXygXP
        5815+dPygaIqHTCfhXVYeA==
X-Google-Smtp-Source: ABdhPJxYgLoP8TuODrHoVFznYdMs1PDoYAX/0YMmlaFkI6tCOH/kTSu793FCitBMJXoZOfNcnv5Smg==
X-Received: by 2002:a6b:dc0a:: with SMTP id s10mr898987ioc.18.1597982109347;
        Thu, 20 Aug 2020 20:55:09 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:08 -0700 (PDT)
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
Subject: [PATCH v2 09/40] PCI: dwc: kirin: Use pci_ops for root config space accessors
Date:   Thu, 20 Aug 2020 21:53:49 -0600
Message-Id: <20200821035420.380495-10-robh@kernel.org>
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
buses, convert the HiSilicon Kirin driver to use the standard pci_ops
for root bus config accesses.

Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 39 +++++++++++++------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index e496f51e0152..8a01ab0a4a65 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -330,34 +330,37 @@ static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
 	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL1_ADDR);
 }
 
-static int kirin_pcie_rd_own_conf(struct pcie_port *pp,
+static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	kirin_pcie_sideband_dbi_r_mode(kirin_pcie, true);
-	ret = dw_pcie_read(pci->dbi_base + where, size, val);
-	kirin_pcie_sideband_dbi_r_mode(kirin_pcie, false);
+	if (PCI_SLOT(devfn)) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
 
-	return ret;
+	*val = dw_pcie_read_dbi(pci, where, size);
+	return PCIBIOS_SUCCESSFUL;
 }
 
-static int kirin_pcie_wr_own_conf(struct pcie_port *pp,
+static int kirin_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	kirin_pcie_sideband_dbi_w_mode(kirin_pcie, true);
-	ret = dw_pcie_write(pci->dbi_base + where, size, val);
-	kirin_pcie_sideband_dbi_w_mode(kirin_pcie, false);
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return ret;
+	dw_pcie_write_dbi(pci, where, size, val);
+	return PCIBIOS_SUCCESSFUL;
 }
 
+static struct pci_ops kirin_pci_ops = {
+	.read = kirin_pcie_rd_own_conf,
+	.write = kirin_pcie_wr_own_conf,
+};
+
 static u32 kirin_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
 			       u32 reg, size_t size)
 {
@@ -423,6 +426,8 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
 
 static int kirin_pcie_host_init(struct pcie_port *pp)
 {
+	pp->bridge->ops = &kirin_pci_ops;
+
 	kirin_pcie_establish_link(pp);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
@@ -438,8 +443,6 @@ static const struct dw_pcie_ops kirin_dw_pcie_ops = {
 };
 
 static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
-	.rd_own_conf = kirin_pcie_rd_own_conf,
-	.wr_own_conf = kirin_pcie_wr_own_conf,
 	.host_init = kirin_pcie_host_init,
 };
 
-- 
2.25.1

