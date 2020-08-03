Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB723AF26
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgHCVCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34380 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHCVCE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:04 -0400
Received: by mail-io1-f68.google.com with SMTP id q75so31850951iod.1;
        Mon, 03 Aug 2020 14:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBszrZoR6KfV8PIUJ9TAD0pOH/WhVXS7vLHSzuibxQI=;
        b=ffSv2U+0W36NH6O2luIDvOWR8rQ5f6KQdv6yLauVEdpvgY9XDZhwMtgtSk9Qr6oui1
         1Bibbh+6z+H2lu5/iPlIvTbwmYFWGJVMjaLaIDtpx3L/FO3F/+mF2bH5nQTBjmF5+s/K
         x5OK63at196Y6YSe5F6D/m/+gr9R9vDEHBvq+XU6kf4Fai7CCrBD5443gdy/cIPNbJEK
         fur2ALfcEFlhml8TR5JcWWTGftorAJPr185dHYAboKts7WHUNh2i93H+3dWCGrTkO6g9
         avkQMcv7x7T/BRIgHFKfYpkaxXrFbQZoHEb9tTL34POm1+PInluifixn0xTDhl28nSwO
         cCzg==
X-Gm-Message-State: AOAM5333mMj0LTHl4gN2XVM98/xarue34ziXkGv/LQwjIgiDho8ywhYV
        +JTrlIFgLBl0IFUjJ7eW9Q==
X-Google-Smtp-Source: ABdhPJwRuSSPOninoBNPo5aHkonSJpYI9fAmTlwclA+BVNVifs96k/azUtlQrFpO1XKMGj3SdjN9iw==
X-Received: by 2002:a02:c735:: with SMTP id h21mr1877476jao.90.1596488523308;
        Mon, 03 Aug 2020 14:02:03 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:02 -0700 (PDT)
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
Subject: [RFC 17/27] PCI: dwc: Remove root_bus pointer
Date:   Mon,  3 Aug 2020 15:01:06 -0600
Message-Id: <20200803210116.3132633-18-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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
index dc336163104a..9528c8b1c9ab 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -459,8 +459,8 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
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
index 10d22269254a..67aac6fdca24 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -193,7 +193,6 @@ struct pcie_port {
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
-	struct pci_bus		*root_bus;
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 52bb145c42d1..c567c9c09ff6 100644
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

