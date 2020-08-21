Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1278724CC61
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHUD4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:45 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35202 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHUD4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:42 -0400
Received: by mail-il1-f194.google.com with SMTP id q14so350139ilm.2;
        Thu, 20 Aug 2020 20:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSKItnmqVV47WYr/7qcDpqZpoV+iUC1CCrqmTczKz5k=;
        b=D+r1skipKFuhZRSfES8dKqELn45OEdApLWtobFWqsfyIu7SoTz7Rc3ONGLGCAb/VmF
         yKcVi46oliWQFFh96KM5d8Qtl3C5AcDc7IbRiGut+XO0K1ssdRurKqFuxBeYbYeynHa2
         XdFPMw6HvMobwyG55ClkbICXhLtpRdoi3W+4lVtUlCZ7Ihbaa27mVrxBK5sqfa/XAVn0
         SFP9KbYa38EeqmAleJcpI2C0zWcbfehg0HQsljV0kahFUp/Pdr8TAzdR3/nRxp+zFTBt
         iUUH1DhxXiqjFWB3FZmQWBPcfSSmMCbIEXucAiRliq+KCfWzsiF58pMD7zUH/moVCLzp
         hqTg==
X-Gm-Message-State: AOAM533+Px7ZqjoTvIv9bOGhdjAv4MDM2AJK9KhFjrVWZnjl5G2j9zov
        WtT0bLwXmIdmgx0J5AMyLw==
X-Google-Smtp-Source: ABdhPJwGnC0NoaFAIgP3xC50Zxq28Km7ugxrs/Tj/1VjtdqN24aNRru4eyCFf0FvELFPS5zN67Hmig==
X-Received: by 2002:a92:1b85:: with SMTP id f5mr984799ill.308.1597982201268;
        Thu, 20 Aug 2020 20:56:41 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:40 -0700 (PDT)
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
Subject: [PATCH v2 35/40] PCI: dwc: Set PORT_LINK_DLL_LINK_EN in common setup code
Date:   Thu, 20 Aug 2020 21:54:15 -0600
Message-Id: <20200821035420.380495-36-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel driver is the only one to set PORT_LINK_DLL_LINK_EN. The
default value is set and it seems pretty certain that enabling link
initialization is always required. Maybe it could just be dropped from
the Intel driver, but lets move setting it into the common code to be
sure.

Cc: Dilip Kota <eswara.kota@linux.intel.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 1 +
 drivers/pci/controller/dwc/pcie-intel-gw.c   | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 448f62f2e6ea..61e1faba15bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -553,6 +553,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_FAST_LINK_MODE;
+	val |= PORT_LINK_DLL_LINK_EN;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
 	ret = of_property_read_u32(np, "num-lanes", &pci->num_lanes);
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 2c0d32ffb828..d15e49b8df2a 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -164,10 +164,6 @@ static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
 	val = FIELD_PREP(PORT_AFR_N_FTS_MASK, lpp->n_fts) |
 	       FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, lpp->n_fts);
 	pcie_rc_cfg_wr_mask(lpp, PCIE_PORT_AFR, mask, val);
-
-	/* Port Link Control Register */
-	pcie_rc_cfg_wr_mask(lpp, PCIE_PORT_LINK_CONTROL, PORT_LINK_DLL_LINK_EN,
-			    PORT_LINK_DLL_LINK_EN);
 }
 
 static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
-- 
2.25.1

