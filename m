Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53C124CC2B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHUD4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33602 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgHUD4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:05 -0400
Received: by mail-il1-f195.google.com with SMTP id r13so354331iln.0;
        Thu, 20 Aug 2020 20:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83Z8Zqnh35ir8IvrFX4mU8ZovtxoSS674PF4/COyolw=;
        b=hc1Dkb/YBzEtbrGyn4i7i29pk+2bM+1yRZ7xKxXQJfXaYR7utSc9NYqgJiL7qAIs1J
         qwxlP9bzo378Aph4j9ZY7XKV7eFKa6kLZADl9dpvtSCvw/5HKwMiSOMeC9Hk3EKUl1h7
         Vslu9iZ6E1Va9G9y+H37PPnxHC9Fj22PY/vMcLdUx+pSVzTTY1qV5VFLDJLOz55rm4+j
         DL/gQE1qy54sgxNM1Bp4hBl/kjrpOw7IDhjsLbBz6XIOcxUmwePMbJmAXzbx6h7EFM84
         dGbIwdbDaM2yNvvtGltWOltjj+FMBq9savPF2BZrdt7Y0FowvDmnViVOgTJsqIWcy6yY
         4qJA==
X-Gm-Message-State: AOAM530u4Ho5lYy7U2yIC8GP5MgmlgmWkF7kmYlP9WCTBI8omziFkx91
        mARD8e2YjcnqPnDddFQMyA==
X-Google-Smtp-Source: ABdhPJxVmfmxBFQk5b4jolguEC5aoTpVw2YVZCKtqDd0bav8Td8Xfa3gvtoATcNAX6N1B9W6CughMg==
X-Received: by 2002:a92:ae06:: with SMTP id s6mr993827ilh.64.1597982163916;
        Thu, 20 Aug 2020 20:56:03 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:03 -0700 (PDT)
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
Subject: [PATCH v2 24/40] PCI: dwc: Ensure FAST_LINK_MODE is cleared
Date:   Thu, 20 Aug 2020 21:54:04 -0600
Message-Id: <20200821035420.380495-25-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"Fast Link Mode" is a simulation environment speed up setting which should
never be set and the default is not set. However some Amlogic platforms
have it set (by firmware presumably). See commit 87dccf09323f ("PCI:
amlogic: meson: Don't use FAST_LINK_MODE to set up link") for more
information. Let's clear it in core DWC code so we can drop some vendor
specific code.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 5 ++++-
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 14ac87fa21a2..ed5dadcbcb45 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -560,6 +560,9 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
 		"enabled" : "disabled");
 
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val &= ~PORT_LINK_FAST_LINK_MODE;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
 	ret = of_property_read_u32(np, "num-lanes", &pci->num_lanes);
 	if (!pci->num_lanes) {
@@ -568,7 +571,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	}
 
 	/* Set the number of lanes */
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val &= ~PORT_LINK_FAST_LINK_MODE;
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (pci->num_lanes) {
 	case 1:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 43d3729101c3..40c3766df096 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -36,6 +36,7 @@
 
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_DLL_LINK_EN		BIT(5)
+#define PORT_LINK_FAST_LINK_MODE	BIT(7)
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
 #define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
 #define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
-- 
2.25.1

