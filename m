Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E8123AF35
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgHCVCM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46785 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbgHCVCL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:11 -0400
Received: by mail-io1-f66.google.com with SMTP id a5so24747179ioa.13;
        Mon, 03 Aug 2020 14:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMmKGLqxoIiv5nH6EL2xp/hSv/Gz0ReZ5qtRf7b9+lE=;
        b=OGoWRMwxyC0QG6kO81r6XWFPwqO1jIZDeKowVnEEw+v/njlDA32MwI2PfpR5UM7NUz
         mIlg7i/KzpeWjKgwQdvjfqFFsbzh+fdGnEPE1B3NfHnXM1AKSgiJ+WWXAiT/4s0kA2/E
         nFwL5+hzjmv2hZS0CQTVDvv2yRSfQPj0WerLc5iATxdWRjxuuB9cGr7ROtiJS8CJXXo0
         LpVgtKSGpOI57NCP67CeTANtvGUmYThU+rn4UW9uhG4DwRk7fB2oVRVYv6s0N3IjUfP8
         ymc/Ytpwu6aaKvJZ7y6T0vTROzBBx8XKaWbNNpZxVYNKgnTH1CXpaj5NtVvj4cq2/KBO
         anNg==
X-Gm-Message-State: AOAM532axCo+eTiu4iI1DhEnysoz/ZfUK+IuVm33WqnQMZOxBfRS9DhF
        WlCEoFplw5Ng7PGC2g9+yQ==
X-Google-Smtp-Source: ABdhPJxeiUiiXL4Rua4Fu69Vg+K0w1bnYWMxWGlLFPHzRqQHvNY5emITrazErXZ1fYfEY9jR9WKX5A==
X-Received: by 2002:a05:6638:1005:: with SMTP id r5mr1866400jab.116.1596488530148;
        Mon, 03 Aug 2020 14:02:10 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:09 -0700 (PDT)
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
Subject: [RFC 20/27] PCI: dwc/keystone: Drop duplicated 'num-viewport'
Date:   Mon,  3 Aug 2020 15:01:09 -0600
Message-Id: <20200803210116.3132633-21-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e9028c98d6c0..205754a6bc3c 100644
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
@@ -1352,12 +1350,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
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
@@ -1371,7 +1363,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			gpiod_set_value_cansleep(gpiod, 1);
 		}
 
-		ks_pcie->num_viewport = num_viewport;
 		pci->pp.ops = host_ops;
 		ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 		if (ret < 0)
-- 
2.25.1

