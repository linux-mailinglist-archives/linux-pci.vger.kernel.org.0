Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7994E24CBEA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHUDzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43520 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgHUDzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:16 -0400
Received: by mail-il1-f196.google.com with SMTP id e11so322313ils.10;
        Thu, 20 Aug 2020 20:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKmjK2jvfVRVb7Er4EDpjePrGGwdJv1IZniABBvajKY=;
        b=P87jnFYiuIUP3O2+G+N5QosBB6WdZtMFIn5uucttO9xflP/RhJIcYP7s4aFdqqIfme
         FSFx/fcrmLfVQEouGqx6Vs5BcnNjg3VHppuNlKXVJmSubVZX5iO8kKGIli0j8Z3KC4hY
         LwnllTU/qMAAgYPGhXsZF4V8qR2297Fh1OPu3gqdQ8tar2AMTiVXM7WEH4SQJ2N8unlz
         6trSoaFQ96fKUuVADLvEtJeBfPXjvyWYrKgt+o9cGpz9BmQRh4Kg/CdYKpFw3dV6kNq0
         ByGP/kEY+H/sorSZ18E3mf5q04bap52yR8mCF2T3Efy4fko0b29Dz1CEmjf5iPnWRZ7z
         9PSw==
X-Gm-Message-State: AOAM531oSvb+wguZvIyZwUHAn1YWfRWAcOQAWQpfm4g8UIP8Br7SCYW2
        Fb8h4N880jAies9SUisX1g==
X-Google-Smtp-Source: ABdhPJyFyuPqncuoqZ1fAZCdBINxVRQghyiJl0ptgs9OL2HhJzv6JYxxzj1pcCD8hN6EHRc1CXmRqQ==
X-Received: by 2002:a05:6e02:14c2:: with SMTP id o2mr1027045ilk.54.1597982114575;
        Thu, 20 Aug 2020 20:55:14 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:14 -0700 (PDT)
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
Subject: [PATCH v2 11/40] PCI: dwc: histb: Use pci_ops for root config space accessors
Date:   Thu, 20 Aug 2020 21:53:51 -0600
Message-Id: <20200821035420.380495-12-robh@kernel.org>
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
buses, convert the HiSilicon histb driver to use the standard pci_ops
for root bus config accesses.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-histb.c | 41 ++++++++++++++-----------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 2a2835746077..af1deae2b15d 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -122,32 +122,37 @@ static void histb_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 	histb_pcie_dbi_w_mode(&pci->pp, false);
 }
 
-static int histb_pcie_rd_own_conf(struct pcie_port *pp, int where,
-				  int size, u32 *val)
+static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	histb_pcie_dbi_r_mode(pp, true);
-	ret = dw_pcie_read(pci->dbi_base + where, size, val);
-	histb_pcie_dbi_r_mode(pp, false);
+	if (PCI_SLOT(devfn)) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
 
-	return ret;
+	*val = dw_pcie_read_dbi(pci, where, size);
+	return PCIBIOS_SUCCESSFUL;
 }
 
-static int histb_pcie_wr_own_conf(struct pcie_port *pp, int where,
-				  int size, u32 val)
+static int histb_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	histb_pcie_dbi_w_mode(pp, true);
-	ret = dw_pcie_write(pci->dbi_base + where, size, val);
-	histb_pcie_dbi_w_mode(pp, false);
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return ret;
+	dw_pcie_write_dbi(pci, where, size, val);
+	return PCIBIOS_SUCCESSFUL;
 }
 
+static struct pci_ops histb_pci_ops = {
+	.read = histb_pcie_rd_own_conf,
+	.write = histb_pcie_wr_own_conf,
+};
+
 static int histb_pcie_link_up(struct dw_pcie *pci)
 {
 	struct histb_pcie *hipcie = to_histb_pcie(pci);
@@ -194,6 +199,8 @@ static int histb_pcie_establish_link(struct pcie_port *pp)
 
 static int histb_pcie_host_init(struct pcie_port *pp)
 {
+	pp->bridge->ops = &histb_pci_ops;
+
 	histb_pcie_establish_link(pp);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
@@ -203,8 +210,6 @@ static int histb_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops histb_pcie_host_ops = {
-	.rd_own_conf = histb_pcie_rd_own_conf,
-	.wr_own_conf = histb_pcie_wr_own_conf,
 	.host_init = histb_pcie_host_init,
 };
 
-- 
2.25.1

