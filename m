Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87929D3F1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgJ1VsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:48:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44256 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgJ1VsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:48:09 -0400
Received: by mail-yb1-f194.google.com with SMTP id i186so419003ybc.11;
        Wed, 28 Oct 2020 14:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQyia8yFxJFo/T6o8CYQ5VyHneaAbbvX2dVIUGSCMQQ=;
        b=qUGMbXLSvcyZKOG2c/+DT12PnvCwgP6OZxFqmDd1YjhFbjSuadK8+M05fstw1SKCzh
         rdd65bpC51NX3YnqTGOyAKw5B1diqXr8QjQc2qFG2M5290tD1GlG5DnCM1xg+bc2m+FS
         Ln40ESRenNL2tTqlAW/vm7WbkpifZSHCIu7ksNds1cSGEhcIZk/7QqdZQrb/9nIYZ+JU
         qP29Rv4X3dsp6gYSko+i36/XUu3ixejAqPDfkayBdUPBVhDNT4UNj60INQvTa4Igr0y1
         aaAhuwQ2h+Rac0KMWB5kV4H3Bj6KTtMWiNzGqJOeuFcpTH6PNs7WKnmHozM9I/aGdRTJ
         g0gg==
X-Gm-Message-State: AOAM532zL97D1xE3hz1Cwx9fSHUZBzFVDCQGhe4psIerMOjs2zIlMZ88
        91u3yeTF6GBY7tZ62Pwa2Wex6ucA0A==
X-Google-Smtp-Source: ABdhPJw2Fi0abZoXS4t0yH9eCkAEgtoxTCLjdD+B6EjQnzh8DitGWJBXxEHGCCo7AWLp1zCE4fxuXQ==
X-Received: by 2002:a9d:685a:: with SMTP id c26mr883050oto.40.1603918014866;
        Wed, 28 Oct 2020 13:46:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:46:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 02/13] PCI: dwc/intel-gw: Move ATU offset out of driver match data
Date:   Wed, 28 Oct 2020 15:46:35 -0500
Message-Id: <20201028204646.356535-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ATU offset should be a register range in DT called 'atu', not driver
match data. Any future platforms with a different ATU offset should add
it to their DT.

This is also in preparation to do DBI resource setup in the core DWC
code, so let's move setting atu_base later in intel_pcie_rc_setup().

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 5650cb78acba..77ef88333115 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -58,7 +58,6 @@
 
 struct intel_pcie_soc {
 	unsigned int	pcie_ver;
-	unsigned int	pcie_atu_offset;
 	u32		num_viewport;
 };
 
@@ -155,11 +154,15 @@ static void intel_pcie_init_n_fts(struct dw_pcie *pci)
 
 static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
 {
+	struct dw_pcie *pci = &lpp->pci;
+
+	pci->atu_base = pci->dbi_base + 0xC0000;
+
 	intel_pcie_ltssm_disable(lpp);
 	intel_pcie_link_setup(lpp);
-	intel_pcie_init_n_fts(&lpp->pci);
-	dw_pcie_setup_rc(&lpp->pci.pp);
-	dw_pcie_upconfig_setup(&lpp->pci);
+	intel_pcie_init_n_fts(pci);
+	dw_pcie_setup_rc(&pci->pp);
+	dw_pcie_upconfig_setup(pci);
 }
 
 static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
@@ -425,7 +428,6 @@ static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
 
 static const struct intel_pcie_soc pcie_data = {
 	.pcie_ver =		0x520A,
-	.pcie_atu_offset =	0xC0000,
 	.num_viewport =		3,
 };
 
@@ -461,7 +463,6 @@ static int intel_pcie_probe(struct platform_device *pdev)
 
 	pci->ops = &intel_pcie_ops;
 	pci->version = data->pcie_ver;
-	pci->atu_base = pci->dbi_base + data->pcie_atu_offset;
 	pp->ops = &intel_pcie_dw_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
2.25.1

