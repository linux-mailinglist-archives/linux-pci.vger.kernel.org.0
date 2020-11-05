Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AF2A8897
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgKEVMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33672 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732264AbgKEVMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:09 -0500
Received: by mail-oi1-f195.google.com with SMTP id k26so3197515oiw.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 13:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzJpgC50B1aEr5UEqZkrsDaDZthdlXtSVmgpDKQvfR0=;
        b=DJ6oZ1MmIIYsSqNNin0ZtFzVn8lBDHbuWlmL6L4lcVgUoM3eaelDzXfI4BwIVY0GLa
         ccet1oN3JSpwhZjoOI3t9Q84MOZnGRRljv+xJjJnopH0ZyqMmayHtuRM/cVHC/R+jEnT
         sQmAaJ7JG5znNsNqdlc6jA1nFrO9ctJWl9INeqgszEBQhzuwi1w+Hu7eBp76GndAXuKV
         pJxxScb+iyl1yCTF+l5/7GC+jQYtK4VORcQlEvoKiyxAY4VMSga0menNDJFo789se3fn
         UsKt5FyM0tGpGwJbWuFLzpAgW/+jOk1oWp34ddwO1CBjagB0j8aD9w7WaEDKZMpgqunn
         rowQ==
X-Gm-Message-State: AOAM531WkmfFBE0qKPnG/ZaF+gQAoWUR6gs7F8Voxv4Eib8hGvPn+T1p
        DllixK9mCQ0L1OqJ6PfC9EjJW2exZyPf
X-Google-Smtp-Source: ABdhPJxQDTx5VKxcCHmYR60h+s8CT7slb9CRXBkC6RHPnSV4CDrv8J8PImzVZWY9c4MdH5eXIUG72w==
X-Received: by 2002:aca:f1c6:: with SMTP id p189mr882003oih.18.1604610728217;
        Thu, 05 Nov 2020 13:12:08 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:07 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 04/16] PCI: dwc/intel-gw: Remove some unneeded function wrappers
Date:   Thu,  5 Nov 2020 15:11:47 -0600
Message-Id: <20201105211159.1814485-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove some of the pointless levels of functions that just wrap or group
a series of other functions.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 47 ++++++++--------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 88782653ed21..c562eb7454b1 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -152,19 +152,6 @@ static void intel_pcie_init_n_fts(struct dw_pcie *pci)
 	pci->n_fts[0] = PORT_AFR_N_FTS_GEN12_DFT;
 }
 
-static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
-{
-	struct dw_pcie *pci = &lpp->pci;
-
-	pci->atu_base = pci->dbi_base + 0xC0000;
-
-	intel_pcie_ltssm_disable(lpp);
-	intel_pcie_link_setup(lpp);
-	intel_pcie_init_n_fts(pci);
-	dw_pcie_setup_rc(&pci->pp);
-	dw_pcie_upconfig_setup(pci);
-}
-
 static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
 {
 	struct device *dev = lpp->pci.dev;
@@ -216,14 +203,6 @@ static void intel_pcie_device_rst_deassert(struct intel_pcie_port *lpp)
 	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
 }
 
-static int intel_pcie_app_logic_setup(struct intel_pcie_port *lpp)
-{
-	intel_pcie_device_rst_deassert(lpp);
-	intel_pcie_ltssm_enable(lpp);
-
-	return dw_pcie_wait_for_link(&lpp->pci);
-}
-
 static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
 {
 	pcie_app_wr(lpp, PCIE_APP_IRNEN, 0);
@@ -273,11 +252,6 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	return 0;
 }
 
-static void intel_pcie_deinit_phy(struct intel_pcie_port *lpp)
-{
-	phy_exit(lpp->phy);
-}
-
 static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
 {
 	u32 value;
@@ -314,6 +288,7 @@ static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
 static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 {
 	int ret;
+	struct dw_pcie *pci = &lpp->pci;
 
 	intel_pcie_core_rst_assert(lpp);
 	intel_pcie_device_rst_assert(lpp);
@@ -330,8 +305,18 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 		goto clk_err;
 	}
 
-	intel_pcie_rc_setup(lpp);
-	ret = intel_pcie_app_logic_setup(lpp);
+	pci->atu_base = pci->dbi_base + 0xC0000;
+
+	intel_pcie_ltssm_disable(lpp);
+	intel_pcie_link_setup(lpp);
+	intel_pcie_init_n_fts(pci);
+	dw_pcie_setup_rc(&pci->pp);
+	dw_pcie_upconfig_setup(pci);
+
+	intel_pcie_device_rst_deassert(lpp);
+	intel_pcie_ltssm_enable(lpp);
+
+	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
 		goto app_init_err;
 
@@ -345,7 +330,7 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 	clk_disable_unprepare(lpp->core_clk);
 clk_err:
 	intel_pcie_core_rst_assert(lpp);
-	intel_pcie_deinit_phy(lpp);
+	phy_exit(lpp->phy);
 
 	return ret;
 }
@@ -356,7 +341,7 @@ static void __intel_pcie_remove(struct intel_pcie_port *lpp)
 	intel_pcie_turn_off(lpp);
 	clk_disable_unprepare(lpp->core_clk);
 	intel_pcie_core_rst_assert(lpp);
-	intel_pcie_deinit_phy(lpp);
+	phy_exit(lpp->phy);
 }
 
 static int intel_pcie_remove(struct platform_device *pdev)
@@ -380,7 +365,7 @@ static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
-	intel_pcie_deinit_phy(lpp);
+	phy_exit(lpp->phy);
 	clk_disable_unprepare(lpp->core_clk);
 	return ret;
 }
-- 
2.25.1

