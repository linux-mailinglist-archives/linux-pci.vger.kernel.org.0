Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE66524CC17
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHUDzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34032 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgHUDzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:47 -0400
Received: by mail-io1-f65.google.com with SMTP id q75so487549iod.1;
        Thu, 20 Aug 2020 20:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kumZHZjUFIvX3SHWpXpEUET8g4KV80WJmK3nUIgHIRs=;
        b=HxDmadhYeFajdPlFRXn2/qt/K7VIXZGAiT4WNvrpnvZ8Trt++qgoQ2153ahtIu79dQ
         bYWIzy6qNEJxCjyKg2nwut1EFa/rapIv9ZMUsVsFl7CkChWwhdWsPo5N1elDGWq7QiiX
         LF7xokQUQF0HN+LzO9yvLZxTG3W4RkVVe2b26NI/TT7GntlWx1WBZDPlqs+ztzKtvrMQ
         IW8D3oAY2wAMKsV+NsdHCMhDpZdt8ChlayGKOqlA8qawxnRgTEH9W/i9pK62zuAorEZ0
         6XKY5Nu1m8nptGSwAZfhgSHxVjUkDJFORMTW63hxTUVDMk7kXXof4qWogjVEcGVuWiO1
         uA1Q==
X-Gm-Message-State: AOAM531k33gg70FRzq3ebbjqNOhe3yXebba+URIGpOPoyS4UDmHLESV5
        bGFh2kFYDxyceV08Bj0v0w==
X-Google-Smtp-Source: ABdhPJxRKUtV0n+dK2NRfpXEvZsHGODGBsP7rLd+TFntUVfJ0RA8JVZq7czdDNbyUGCiMPAKKGQyTA==
X-Received: by 2002:a05:6638:22c7:: with SMTP id j7mr840801jat.77.1597982145790;
        Thu, 20 Aug 2020 20:55:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:45 -0700 (PDT)
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
Subject: [PATCH v2 20/40] PCI: dwc/keystone: Drop duplicated 'num-viewport'
Date:   Thu, 20 Aug 2020 21:54:00 -0600
Message-Id: <20200821035420.380495-21-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DWC core driver already parses and stores the 'num-viewport' DT
property, so there is no need for the Keystone driver to store it.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 983069a4a561..0fe792f6c253 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -123,7 +123,6 @@ struct keystone_pcie {
 
 	int			msi_host_irq;
 	int			num_lanes;
-	u32			num_viewport;
 	struct phy		**phy;
 	struct device_link	**link;
 	struct			device_node *msi_intc_np;
@@ -397,9 +396,9 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
-	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
+	u32 num_viewport = pci->num_viewport;
 	u64 start, end;
 	struct resource *mem;
 	int i;
@@ -1199,7 +1198,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct resource *res;
 	unsigned int version;
 	void __iomem *base;
-	u32 num_viewport;
 	struct phy **phy;
 	int link_speed;
 	u32 num_lanes;
@@ -1349,12 +1347,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		ret = of_property_read_u32(np, "num-viewport", &num_viewport);
-		if (ret < 0) {
-			dev_err(dev, "unable to read *num-viewport* property\n");
-			goto err_get_sync;
-		}
-
 		/*
 		 * "Power Sequencing and Reset Signal Timings" table in
 		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 2.0
@@ -1368,7 +1360,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			gpiod_set_value_cansleep(gpiod, 1);
 		}
 
-		ks_pcie->num_viewport = num_viewport;
 		pci->pp.ops = host_ops;
 		ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 		if (ret < 0)
-- 
2.25.1

