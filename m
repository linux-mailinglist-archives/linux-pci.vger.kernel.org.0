Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7757624CC79
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHUD5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:57:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33190 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgHUD4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:53 -0400
Received: by mail-io1-f65.google.com with SMTP id g14so497662iom.0;
        Thu, 20 Aug 2020 20:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=by4oX7Q9EHMVJaM1a51OAzD7P0ljQOmX5mYz/PVurNU=;
        b=e9oRTBo+oi/goTO6LY21bODGrGLzrAEKxudNPPG14SPRS1I5nPkNLwx/kjI27q1PuL
         GqC76iVQcNNt9zPfMvIXwy6vhJPuKM4U3EWVmIPNWXiH2k/Ga9/F7cwVTSz3y4sGYqr7
         xHxLL4VTtpMuJI7kX3vp4MV+njwL/15J2rOT0phcK9g+6XHKtBxcr1nNFlRoc5jpslFl
         aRtB50rm8Z3Y9soSr12ayUCBtV77rQ1Ex94V3X6qwvSPbAHmA3wBFUMQqFJ8fcQOOAQI
         U4xzUXxk99jTGHwiVDrwRlcZrweNf7z36Bnwf/lhKnGV4Z6tMhvB5GEEdGt0TaoxZzU8
         Jilg==
X-Gm-Message-State: AOAM530+ZLWtEzfopPt473t9xjc+RWLy+zMfVETmVkxMpMgv4xisu/uj
        8E0mOSm+F4wM4J5qzDim1gCNDBGqjw==
X-Google-Smtp-Source: ABdhPJxM5kjSHd3L5b8T/on1Z1mm06cBCvBOTiUQ8rjsJmv63ck+8CPmCubjjHoxbemoW0uKPGWg4g==
X-Received: by 2002:a02:aa87:: with SMTP id u7mr925566jai.13.1597982212144;
        Thu, 20 Aug 2020 20:56:52 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:51 -0700 (PDT)
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
Subject: [PATCH v2 38/40] PCI: dwc/intel-gw: Drop unused max_width
Date:   Thu, 20 Aug 2020 21:54:18 -0600
Message-Id: <20200821035420.380495-39-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'max_width' is read, but never used, so let's remove it.

Cc: Dilip Kota <eswara.kota@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 807e1fa1bd6f..333f11561807 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -67,7 +67,6 @@ struct intel_pcie_port {
 	void __iomem		*app_base;
 	struct gpio_desc	*reset_gpio;
 	u32			rst_intrvl;
-	u32			max_width;
 	u32			n_fts;
 	struct clk		*core_clk;
 	struct reset_control	*core_rst;
@@ -133,9 +132,6 @@ static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
 	u32 val;
 	u8 offset = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
 
-	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCAP);
-	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
-
 	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCTL);
 
 	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
-- 
2.25.1

