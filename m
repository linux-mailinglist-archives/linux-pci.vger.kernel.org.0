Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC823AEFF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgHCVBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38453 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgHCVBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:40 -0400
Received: by mail-io1-f65.google.com with SMTP id l1so39992207ioh.5;
        Mon, 03 Aug 2020 14:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqMmmSdRu2mAJmxJVyfdC1UZDoCNddnAHqJmdw3g1qc=;
        b=kbh/gROR243Odr5WjQNkYijTi8E5dG08IEnI96YhEKNcfAGLtuYLyJD1JIRTiIuD0C
         CfFzzGHJYBQxl7NtxACRGHxHO0sOfZwFL167qVqyRcbBrSFw9zEOWgHb7TxkkWSyWk5G
         b8K7uRWRjjoyk2uZpkzEJUtnNr3MX7nuIplrbGhqz6mUJLZYc7DQ7XtZM68w9SrFezSr
         hbP5INOFlox0Rl4cvwNaBQZY0vZs177aSvGv0RKb4rHjYNNvz7CS1LZEFL1kafsRIJYK
         SmUUfCjyDTmSG6752X7d0p2IJnkLPj3LjBXD4mud6wmTi5yj+x/77dbQ/mTXnk8qGTc5
         O9sg==
X-Gm-Message-State: AOAM531wschz0usaKytMHCOCSv7M8xmzDRoMrxgVay8bT4/i59DHRriV
        u4TH1w3/rP2v4lnXeqcu1g==
X-Google-Smtp-Source: ABdhPJw7+kSjYhGRYEIhQk6tNLudHqZmYvJC/9LNtA8wCqiPqZlbDpGdf2cy3RCei6R9SOjDM6lY5w==
X-Received: by 2002:a5e:930b:: with SMTP id k11mr1852419iom.30.1596488499811;
        Mon, 03 Aug 2020 14:01:39 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:39 -0700 (PDT)
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
Subject: [RFC 09/27] PCI: dwc: kirin: Use pci_ops for root config space accessors
Date:   Mon,  3 Aug 2020 15:00:58 -0600
Message-Id: <20200803210116.3132633-10-robh@kernel.org>
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
index c19617a912bd..1680dc72b416 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -335,34 +335,37 @@ static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
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
@@ -428,6 +431,8 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
 
 static int kirin_pcie_host_init(struct pcie_port *pp)
 {
+	pp->bridge->ops = &kirin_pci_ops;
+
 	kirin_pcie_establish_link(pp);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
@@ -443,8 +448,6 @@ static const struct dw_pcie_ops kirin_dw_pcie_ops = {
 };
 
 static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
-	.rd_own_conf = kirin_pcie_rd_own_conf,
-	.wr_own_conf = kirin_pcie_wr_own_conf,
 	.host_init = kirin_pcie_host_init,
 };
 
-- 
2.25.1

