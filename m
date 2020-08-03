Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4575523AF24
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgHCVCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45964 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHCVCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:02 -0400
Received: by mail-il1-f194.google.com with SMTP id f68so10457680ilh.12;
        Mon, 03 Aug 2020 14:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aVzUrW/b+OR7PsyqkF7d3uV9W2kuObPvJUPmZOvAKM=;
        b=L5i6A4KQ9QUbLbttgLwwy/EyNetA5PHd8XPe6orXHFuIEjmU0DyNWHMrrTTZLyuc/3
         HAESAL6lnpFVYomVOkkynlTU0yjh22VHQNSMPgzGySzeP+1UNyqp8hQkRUpfSHcs5SQm
         cg/kAeNL3EETnfYQdZrOqPE5DuKaYY+Ax+bfFd1unVrE67fqiBP7pf3pE5bH1ehtSvfl
         /yrODqXKyDzkFRRMsKsdq8vqGAXjTfYWXUVlSbFYMIB6Joxkar+aF+cQOzNIEgl6qAif
         vUPSxeoGWkuh7QiPRHBMJceSiR8QSUNeYVu+aQFnHwmorIku+4fioOLeVGtAlY05eci2
         vGTQ==
X-Gm-Message-State: AOAM532OQTuwBdZDCOc4x8WYphrzUUHl6avW+/rWmzj/80Z2Pm65V6kX
        XNELdnCiAN65Z3cl21X7vw==
X-Google-Smtp-Source: ABdhPJzvMiwNh6mYspCSiLag2A19Z5Dkvf/eGkppl3qfixJbFF7IVuurRzwNE2IrpB0eB0YCgBL/0A==
X-Received: by 2002:a92:c883:: with SMTP id w3mr1144796ilo.2.1596488521305;
        Mon, 03 Aug 2020 14:02:01 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:00 -0700 (PDT)
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
Subject: [RFC 16/27] PCI: dwc: Convert to use pci_host_probe()
Date:   Mon,  3 Aug 2020 15:01:05 -0600
Message-Id: <20200803210116.3132633-17-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that there are no more .scan_bus() callbacks, we can remove it and just
use pci_host_probe().

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 21 +++----------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e9778f8ee955..dc336163104a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -300,7 +300,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
-	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
 	int ret;
@@ -447,23 +446,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret)
-		goto err_free_msi;
-
-	pp->root_bus = bridge->bus;
-
-	if (pp->ops->scan_bus)
-		pp->ops->scan_bus(pp);
-
-	pci_bus_size_bridges(pp->root_bus);
-	pci_bus_assign_resources(pp->root_bus);
-
-	list_for_each_entry(child, &pp->root_bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(pp->root_bus);
-	return 0;
+	ret = pci_host_probe(bridge);
+	if (!ret)
+		return 0;
 
 err_free_msi:
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 28e7ad3eb89f..10d22269254a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -161,7 +161,6 @@ enum dw_pcie_device_mode {
 
 struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
-	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
 };
-- 
2.25.1

