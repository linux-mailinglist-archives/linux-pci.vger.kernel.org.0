Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CC24CC6B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHUD4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40645 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHUD4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:51 -0400
Received: by mail-io1-f65.google.com with SMTP id b17so473964ion.7;
        Thu, 20 Aug 2020 20:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCTy6HIJ0siuoHKEt9Jh+dIb5CfTt4PsBCEo/LAgIko=;
        b=bBpK6RHH/BilT5575kb8qgza9KTBvGs3P9jlIEcQDi1FlZrfzhzfEjd4a5qfbBwK4J
         pjnGfr/lF+BJ68GipQqT9680ZgZClQ2P9AzLsgPpnMmiACIBCTSX6O48fSHCk+HSmZAQ
         d3J2Y0sd3vuCHPYVA3XnXXN7o4KqhTCtqD+DX3B+FDKNZ/6a5ZlP1Xvd2Oqt4VsMWP/h
         zhmCqzLKgu4CZomH5kGBvJ58tY8mDP7Ps7wTQYWxprp1pR3ZSM6hBm8VRjHL49s8wSlZ
         3Rafn+171xGftQMAc0g62nZ2CpeZgkcH+iwO+PeJgb5XMHXWfIuqF4+zrU0Du3NPNMxY
         9dtQ==
X-Gm-Message-State: AOAM533VuCijUqfyGDUlNTkTgPuwmSffpqhnDh0yVD/NzXHUyY9RMu3C
        h1ZBo0xTokZamr95E/0Y1Q==
X-Google-Smtp-Source: ABdhPJyVQS4lKmzqeroBIofceYh0j4/zV6pM1lp4Q23N44EPxrVFx8K/P5ZHYh9Xho/IbnSww4WCyw==
X-Received: by 2002:a05:6638:1393:: with SMTP id w19mr823225jad.113.1597982209493;
        Thu, 20 Aug 2020 20:56:49 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:48 -0700 (PDT)
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
Subject: [PATCH v2 37/40] PCI: dwc/intel-gw: Move getting PCI_CAP_ID_EXP offset to intel_pcie_link_setup()
Date:   Thu, 20 Aug 2020 21:54:17 -0600
Message-Id: <20200821035420.380495-38-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI_CAP_ID_EXP offset is only needed by intel_pcie_link_setup(), so
let's retrieve it there and avoid storing the offset.

Cc: Dilip Kota <eswara.kota@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 6b102197a1b6..807e1fa1bd6f 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -72,7 +72,6 @@ struct intel_pcie_port {
 	struct clk		*core_clk;
 	struct reset_control	*core_rst;
 	struct phy		*phy;
-	u8			pcie_cap_ofst;
 };
 
 static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
@@ -132,7 +131,7 @@ static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
 static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
 {
 	u32 val;
-	u8 offset = lpp->pcie_cap_ofst;
+	u8 offset = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
 
 	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCAP);
 	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
@@ -328,7 +327,6 @@ static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
 
 static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 {
-	struct device *dev = lpp->pci.dev;
 	int ret;
 
 	intel_pcie_core_rst_assert(lpp);
@@ -346,17 +344,6 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 		goto clk_err;
 	}
 
-	if (!lpp->pcie_cap_ofst) {
-		ret = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
-		if (!ret) {
-			ret = -ENXIO;
-			dev_err(dev, "Invalid PCIe capability offset\n");
-			goto app_init_err;
-		}
-
-		lpp->pcie_cap_ofst = ret;
-	}
-
 	intel_pcie_rc_setup(lpp);
 	ret = intel_pcie_app_logic_setup(lpp);
 	if (ret)
-- 
2.25.1

