Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED83F23AEE2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgHCVB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38423 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgHCVB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:27 -0400
Received: by mail-io1-f66.google.com with SMTP id l1so39991437ioh.5;
        Mon, 03 Aug 2020 14:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijQ8ATU40Ukxf+vdFPpN/cTBNWQIy8LHFEwNkXuS7vE=;
        b=TtA3D50HOWjGSOYcI0fLq7MAUnDBSi++nGASm4Aoh/xGbxG+Nth6WBRpCcWzR9SZpJ
         zXFkOFhdk5CglhnIbRVhmHVnrTacwOWTsbwSRutc8x0VmJKmquUL+Gsix5cdpmcsFwQz
         k0+kaJQSrIPorGnuaRYv9orYBj9W0AYPkcJe7trNLYw/agEG2PAuWh4BjPBgOjPjVSg8
         Pwsc5AphA4aWpxRoxYG36XEP47a81vesf02tunJ5SNy+qKfpGxOeW++4gDyBA4TwHmyB
         Eq121ULzAvJ6cWj5psaqF7VRaLKEH/0fSCEaHlmY4VaVJYSKZO/gmO4qxftZGmUIOTff
         TY3w==
X-Gm-Message-State: AOAM532GpYjM3KbWCmeSb05lEiLzZCNVZwWkvEuYlBu6FitDnYc5T/Gp
        YmOiADsJm8DwexS5xjTDBQ==
X-Google-Smtp-Source: ABdhPJwDDB+OwHWjJuTy7sDEknkVzY4VCrs5f0YZ1QmljRmggfDq+USGhZLjxDletIoYITtztOCGKA==
X-Received: by 2002:a05:6638:2482:: with SMTP id x2mr1801792jat.55.1596488486266;
        Mon, 03 Aug 2020 14:01:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:25 -0700 (PDT)
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
Subject: [RFC 03/27] PCI: dwc: Allow overriding bridge pci_ops
Date:   Mon,  3 Aug 2020 15:00:52 -0600
Message-Id: <20200803210116.3132633-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to allow drivers to set their own root and child pci_ops
instead of using the DWC specific config space ops, we need to make
the pci_host_bridge pointer available and move setting the bridge->ops
and bridge->child_ops pointer to before the .host_init() hook.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 ++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6232aefbbdb4..7cd8c9528d4c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -344,6 +344,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
 
+	pp->bridge = bridge;
+
 	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
 					      &bridge->dma_ranges, NULL);
 	if (ret)
@@ -450,6 +452,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	/* Set default bus ops */
+	bridge->ops = &dw_pcie_ops;
+	bridge->child_ops = &dw_pcie_ops;
+
 	if (pp->ops->host_init) {
 		ret = pp->ops->host_init(pp);
 		if (ret)
@@ -461,7 +467,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->dev.parent = dev;
 	bridge->sysdata = pp;
 	bridge->busnr = pp->root_bus_nr;
-	bridge->ops = &dw_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
@@ -667,11 +672,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
 	/*
-	 * If the platform provides ->rd_other_conf, it means the platform
-	 * uses its own address translation component rather than ATU, so
-	 * we should not program the ATU here.
+	 * If the platform provides its own child bus config accesses, it means
+	 * the platform uses its own address translation component rather than
+	 * ATU, so we should not program the ATU here.
 	 */
-	if (!pp->ops->rd_other_conf) {
+	if (pp->bridge->child_ops == &dw_pcie_ops && !pp->ops->rd_other_conf) {
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 656e00f8fbeb..bad3cddab28e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -201,6 +201,7 @@ struct pcie_port {
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
 	struct pci_bus		*root_bus;
+	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
-- 
2.25.1

