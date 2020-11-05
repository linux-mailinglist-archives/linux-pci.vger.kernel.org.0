Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6502A889F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgKEVMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:13 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40137 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id m143so3167556oig.7;
        Thu, 05 Nov 2020 13:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=filRJgUUpNg3BFNBbT3tnd3VlWQezqy+w4AFR3K9UD4=;
        b=Pn3zsW4AmAFO934ZHuKQvOoq7H3W6MJsJINXyw0DDkZkeRqAAzcnjkFFSdfB7BGi9r
         XSSyNqHCVUIyF+pI99sLOesUNObeQHZNzsPCecwLx3/FIl2u4SIe5RzJ/FT1MVe2txeH
         VIcMMJT8+yX1+r6T48mWjg48giM0LLgV1IAfO8UMxIIzg4GEjcaNr5YwN2w1mn3t7Wnl
         JNYRnOmP/Vo8I0+A07/e0ZqazVd/CmyGWDlClbrSl/ixYl+ZDXnahm5TyrLxvIWXmhgc
         CFANItigkVdBV7rg0gdsBwgq3hjAqoaVyeqUGkzx7RvkrRO4HRnl+6NkqbCXQg+lvNgS
         PEkA==
X-Gm-Message-State: AOAM530Gmt6Av1Aa8NqM9vdAQzrRmjjacP3FyS/OCaqjfn68imkoC65W
        UcljOd23xnL0ro89gld6ShJmGI9OMWpm
X-Google-Smtp-Source: ABdhPJyauuJZJ/SW6Y68VbH03EiHItvDAxi4Fg6QsoELxtMemcS/6e19MR9KR/9KluB6UJD/iVrAnA==
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr827427oid.114.1604610731701;
        Thu, 05 Nov 2020 13:12:11 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:11 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 07/16] PCI: dwc: Drop the .set_num_vectors() host op
Date:   Thu,  5 Nov 2020 15:11:50 -0600
Message-Id: <20201105211159.1814485-8-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's no reason for the .set_num_vectors() host op. Drivers needing a
non-default value can just initialize pcie_port.num_vectors directly.

Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 19 ++++---------------
 .../pci/controller/dwc/pcie-designware-plat.c |  7 +------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 drivers/pci/controller/dwc/pcie-tegra194.c    |  7 +------
 4 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 265a48f1a0ae..1bd6a9762426 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -365,22 +365,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
 	if (pci_msi_enabled()) {
-		/*
-		 * If a specific SoC driver needs to change the
-		 * default number of vectors, it needs to implement
-		 * the set_num_vectors callback.
-		 */
-		if (!pp->ops->set_num_vectors) {
+		if (!pp->num_vectors) {
 			pp->num_vectors = MSI_DEF_NUM_VECTORS;
-		} else {
-			pp->ops->set_num_vectors(pp);
-
-			if (pp->num_vectors > MAX_MSI_IRQS ||
-			    pp->num_vectors == 0) {
-				dev_err(dev,
-					"Invalid number of vectors\n");
-				return -EINVAL;
-			}
+		} else if (pp->num_vectors > MAX_MSI_IRQS) {
+			dev_err(dev, "Invalid number of vectors\n");
+			return -EINVAL;
 		}
 
 		if (!pp->ops->msi_host_init) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 562a05e07b1d..13fede1d4157 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -44,14 +44,8 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static void dw_plat_set_num_vectors(struct pcie_port *pp)
-{
-	pp->num_vectors = MAX_MSI_IRQS;
-}
-
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
-	.set_num_vectors = dw_plat_set_num_vectors,
 };
 
 static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
@@ -128,6 +122,7 @@ static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
 			return pp->msi_irq;
 	}
 
+	pp->num_vectors = MAX_MSI_IRQS;
 	pp->ops = &dw_plat_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ed19c34dd0fe..96382dcb2859 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -171,7 +171,6 @@ enum dw_pcie_device_mode {
 
 struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
-	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f8fca6794282..5e2841f58700 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -990,11 +990,6 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static void tegra_pcie_set_msi_vec_num(struct pcie_port *pp)
-{
-	pp->num_vectors = MAX_MSI_IRQS;
-}
-
 static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
@@ -1019,7 +1014,6 @@ static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 
 static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
 	.host_init = tegra_pcie_dw_host_init,
-	.set_num_vectors = tegra_pcie_set_msi_vec_num,
 };
 
 static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
@@ -1995,6 +1989,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pci->n_fts[1] = FTS_VAL;
 
 	pp = &pci->pp;
+	pp->num_vectors = MAX_MSI_IRQS;
 	pcie->dev = &pdev->dev;
 	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
-- 
2.25.1

