Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1762C24CC09
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHUDzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36520 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgHUDzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:32 -0400
Received: by mail-io1-f68.google.com with SMTP id t15so483525iob.3;
        Thu, 20 Aug 2020 20:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFXUpgtvn+rwMzgxFaofhzgT1ZGHQN0vFhCrA/SPcm0=;
        b=t8F5UOE8Al852FXiT/4yrOQEdAZz2OaPTncJITnuDx6ilkdZWlFk5VmXzF1u9brXY2
         oyeplWQtZDpcAm2JDDzg8YxE+9ghjaYziVDOaNbw5Bpkvdi0059piWfd3Fhc5nq2RuLY
         zexZrkrZvSzurkX9jEG6b2yVi+P7r2EFyS3dvTIZSFc7RS5EuAvx0FmkRa3M7na0jcXT
         oVaLv6DG3I5e43J9HAqyBdMLgPS2ZUBjgiEjxcU24AvalUkuvGAxxfk3/lpS8BLYWCP+
         ylZal9vZWq3D2w5rsDEtBNqP5U3PkBNkzdbl4HH+uXm/OX/LAOFQpFOI1/rb8Cg1RDXp
         f/CA==
X-Gm-Message-State: AOAM531mAUWvZE2HYRaq1jCN9H02c4h/j5p6yxgzIn8WpfsNYWuIsgmE
        6zmT3PLFCzJep1jFeaf85w==
X-Google-Smtp-Source: ABdhPJz9Cz36+anjfd85YKbaf2q062W+zrGMwvr+OxCyKKkArm368LLNcvPDR62l3V/N8uzBXYzXxw==
X-Received: by 2002:a05:6602:13d3:: with SMTP id o19mr929935iov.32.1597982131299;
        Thu, 20 Aug 2020 20:55:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:30 -0700 (PDT)
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
Subject: [PATCH v2 17/40] PCI: dwc: Remove root_bus pointer
Date:   Thu, 20 Aug 2020 21:53:57 -0600
Message-Id: <20200821035420.380495-18-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_host_bridge struct already has a pointer to its pci_bus, so
let's convert the one user to use the bridge struct and remove the
private 'root_bus' pointer.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++--
 drivers/pci/controller/dwc/pcie-designware.h      | 1 -
 drivers/pci/controller/dwc/pcie-tegra194.c        | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 42b13a7a7383..0f348b951ec3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -448,8 +448,8 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
 void dw_pcie_host_deinit(struct pcie_port *pp)
 {
-	pci_stop_root_bus(pp->root_bus);
-	pci_remove_root_bus(pp->root_bus);
+	pci_stop_root_bus(pp->bridge->bus);
+	pci_remove_root_bus(pp->bridge->bus);
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
 		dw_pcie_free_msi(pp);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6cd61892f24f..78243909d2c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -192,7 +192,6 @@ struct pcie_port {
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
-	struct pci_bus		*root_bus;
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b723c9f3ece4..a5dce56b3b7a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1264,9 +1264,9 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 	 * 5.2 Link State Power Management (Page #428).
 	 */
 
-	list_for_each_entry(child, &pp->root_bus->children, node) {
+	list_for_each_entry(child, &pp->bridge->bus->children, node) {
 		/* Bring downstream devices to D0 if they are not already in */
-		if (child->parent == pp->root_bus) {
+		if (child->parent == pp->bridge->bus) {
 			root_bus = child;
 			break;
 		}
-- 
2.25.1

