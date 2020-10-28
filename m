Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3F329D4B5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgJ1VyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:54:04 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36927 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgJ1VyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:54:00 -0400
Received: by mail-yb1-f195.google.com with SMTP id h196so458980ybg.4;
        Wed, 28 Oct 2020 14:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLOvbaset6wV6Dn3/Arex7U+9set4P3J+tKjETLL1EM=;
        b=FlzEE+8jj9034mP19kbouTyE5SZhdL/H38ORSFswjKNWpKa3uIvJkRETe6hT6cMZYY
         FomEyKX9HME+zibbu5F+ru2ghkoZNkB1z1bIh8+wFgRLGhlOEGWKYXwS0Ie3HrU8r0Vc
         VgdLYNOV8MmE5VbNcBNe6BtQz80cQuWBOXOG4LXuyLvasbHRmrvkKpjQRDvqFvbfGge3
         /BhsN2NgA87XQ9xwjEvc0O10Y/b1OFVMaDyGVG0Zu51H3PGBcYLp+XyZ13vQ+3YGWKi2
         8NsO10YkJMxE8Ez+gk2yk5WKWcoq8PlKjZKWKI7HuRUksdJ2t+/LyXq6Ym2RYcSJEdrT
         HVyQ==
X-Gm-Message-State: AOAM531JCLYlX9vZWlsB3jwmMnlUmqkNi81K6cMy5pza4jXjm8VEMfiW
        1wexRoBGN6vvynS5GfoSy1jIhQVJdg==
X-Google-Smtp-Source: ABdhPJzwjKbq7JzT2KR7oH5ul6upvIjlNUB089dgKIfM3L82ah64mMOfdxaaYJTCvyPMxLN4/ugXrg==
X-Received: by 2002:a05:6830:1c71:: with SMTP id s17mr847498otg.29.1603918012278;
        Wed, 28 Oct 2020 13:46:52 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:46:51 -0700 (PDT)
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
Subject: [PATCH 01/13] PCI: dwc/imx6: Drop setting PCI_MSI_FLAGS_ENABLE
Date:   Wed, 28 Oct 2020 15:46:34 -0500
Message-Id: <20201028204646.356535-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No other host driver sets the PCI_MSI_FLAGS_ENABLE bit, so it must not
be necessary. If it is, a comment is needed.

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5cf1ef12fb9b..7dd137d62dca 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1002,7 +1002,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
-	u16 val;
 
 	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -1167,13 +1166,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (pci_msi_enabled()) {
-		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
-		val |= PCI_MSI_FLAGS_ENABLE;
-		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
-	}
-
 	return 0;
 }
 
-- 
2.25.1

