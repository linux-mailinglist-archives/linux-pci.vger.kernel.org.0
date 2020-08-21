Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE81824CC36
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHUD4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34980 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHUD4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:15 -0400
Received: by mail-io1-f68.google.com with SMTP id s2so492644ioo.2;
        Thu, 20 Aug 2020 20:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5dhy5lfNiv2CBspsoOGjvk1pottUqD5VgIGcHG48iU=;
        b=rzsOgmesKbjjSYHh1O3FvI/AzNGetiWHCDm5FlhuyZBwbBo7NAJSNg0QmKlqxpHgQr
         sdUROTgt8MiXV0Uy2XA9xvh5TKgKN8J5neH0alHbdU80IK5fmdHPkrDQ+TL6EhJ0N7pe
         ORk7gEWWslsdtyW6YLQxc9NGzDdBItJgPiXGzfpnx9QqcmkwKm9to0tSdhGEH3vFf5Yp
         SBtV9eT1DJqw4aXoCcXPdKgecDl5dr/p9CWDybwmrM9f9D8Y9fUQ2V95ZcMfOeMOd0pv
         3BGGe9oUiGy4Np8XZc/I3kgp/d58mIQ28WK10WUYVSe/KREaFCQAw8gAg/KQ0ciwFflf
         RzbA==
X-Gm-Message-State: AOAM533F0cIRjUR6TRpFSInczZrVZ9WdXpVmA7Peubv/6y23uEkDwhY+
        inkLZ5UG5p+yAPdn+lbP0w==
X-Google-Smtp-Source: ABdhPJxzrVgFDfxvtmE+MBNV+SieBk2ccjoW678S5hB6PbaJ4gStjqTHhwpWyikffZyFaD36Hauq7Q==
X-Received: by 2002:a05:6638:bc2:: with SMTP id g2mr963413jad.21.1597982174122;
        Thu, 20 Aug 2020 20:56:14 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:13 -0700 (PDT)
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
Subject: [PATCH v2 26/40] PCI: dwc/meson: Drop unnecessary RC config space initialization
Date:   Thu, 20 Aug 2020 21:54:06 -0600
Message-Id: <20200821035420.380495-27-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The common Designware init already initializes the RC PCI_COMMAND, BAR0
and BAR1 registers.

The only difference here is the common code sets SERR. If clearing SERR
is what's desired, then the Meson driver should do that instead.

Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 96308743faf4..cca423e834e8 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -22,15 +22,6 @@
 
 #define to_meson_pcie(x) dev_get_drvdata((x)->dev)
 
-#define TYPE1_HDR_OFFSET		0x0
-#define PCIE_STATUS_COMMAND		(TYPE1_HDR_OFFSET + 0x04)
-#define PCI_IO_EN			BIT(0)
-#define PCI_MEM_SPACE_EN		BIT(1)
-#define PCI_BUS_MASTER_EN		BIT(2)
-
-#define PCIE_BASE_ADDR0			(TYPE1_HDR_OFFSET + 0x10)
-#define PCIE_BASE_ADDR1			(TYPE1_HDR_OFFSET + 0x14)
-
 #define PCIE_CAP_OFFSET			0x70
 #define PCIE_DEV_CTRL_DEV_STUS		(PCIE_CAP_OFFSET + 0x08)
 #define PCIE_CAP_MAX_PAYLOAD_MASK	GENMASK(7, 5)
@@ -275,9 +266,6 @@ static void meson_pcie_init_dw(struct meson_pcie *mp)
 	val = meson_cfg_readl(mp, PCIE_CFG0);
 	val |= APP_LTSSM_ENABLE;
 	meson_cfg_writel(mp, val, PCIE_CFG0);
-
-	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR0);
-	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR1);
 }
 
 static int meson_size_to_payload(struct meson_pcie *mp, int size)
@@ -325,13 +313,6 @@ static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
 }
 
-static inline void meson_enable_memory_space(struct meson_pcie *mp)
-{
-	/* Set the RC Bus Master, Memory Space and I/O Space enables */
-	meson_elb_writel(mp, PCI_IO_EN | PCI_MEM_SPACE_EN | PCI_BUS_MASTER_EN,
-			 PCIE_STATUS_COMMAND);
-}
-
 static int meson_pcie_establish_link(struct meson_pcie *mp)
 {
 	struct dw_pcie *pci = &mp->pci;
@@ -342,7 +323,6 @@ static int meson_pcie_establish_link(struct meson_pcie *mp)
 	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
 
 	dw_pcie_setup_rc(pp);
-	meson_enable_memory_space(mp);
 
 	meson_pcie_assert_reset(mp);
 
-- 
2.25.1

