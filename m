Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3745FF05
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355010AbhK0OKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355188AbhK0OIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:08:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BFC06175A
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so25097655wrw.10
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLTcBBwy7YHZ2X9xSjL5bSGEmUeuhLcPaF3Mc27FjR0=;
        b=CD1PcZxrYYF5I03owDQZyotwNtSVYIN5K4cFtWugCRR9FfkM3/+iEztYXrIvbO3OJ+
         3XADlv2cj5rohjhAaXSCsMdd6o07W+OfMj4ehX57UN3A7xigobRqKwhbjXxvkJtsqolr
         hMavvcQyyZQe51kv//4kuu4lttAfpnAc/HimNwIwN/fB+JESyOF4kWHuS47+eM8fOrAd
         oKxyE6fcVA7f36Ce+IIFosXC79j4ooXJkJoilxT3c6IYThfEyo028143rfzdKaYKM6EW
         tzoSnNaOxQ53HHDfOks1b1dEAl7iwW7yU6vkIBGzhYy6jZh3zqPHT8ZGxjvV6JU5s7v5
         bSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLTcBBwy7YHZ2X9xSjL5bSGEmUeuhLcPaF3Mc27FjR0=;
        b=fNiZ4eRjpvO5DnbM1dosBkhLegsxnPVGn5PnKBS8H77/Ml33eluZxg87wH5S2tW8O7
         +AlW7lY0nLkqYIYe5+33hCTy/4rZ4F3Q8w9eoD65giCM/dAkoGkZHWJti7PW6oMy/Uzg
         VP/ChJEyubXx10i2u5IwFwTnhHnHq7ovizMpvoIsc9uV82cpwtiQlCMiHeUosnSLFcpS
         MeR0EfJRiPkzIIGgO6jJ35fA9bcjCX+U6uKtO0KWI7LpEFNv7Pzv38I3XCgkPCeh8eAh
         UUp866LyFABnjjtVxm8YFKFMdkUo7siWGHHHlzuA0l/eIcvrgHvE4tOo0D7ylKJWnI5t
         vQGg==
X-Gm-Message-State: AOAM5313TYsHbvfK37tBM+J2i8qM6/c1dq6p9Kv3HbRbC6xJaFO+q882
        GjjdVSHGpJ+3GQitMOzQqExSuLLyY5++Hw==
X-Google-Smtp-Source: ABdhPJzjiENciugziWhh+LsqwKJBGrGvLI23P/jZ8Cflb9VSFVHFjdJ8S2kyHuMsQePn9IbSo1/rKg==
X-Received: by 2002:adf:8b99:: with SMTP id o25mr21149658wra.389.1638021903872;
        Sat, 27 Nov 2021 06:05:03 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id w7sm8447071wru.51.2021.11.27.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:05:03 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 4/6] PCI: tegra194: Rename struct tegra_pcie_dw to tegra194_pcie
Date:   Sat, 27 Nov 2021 15:04:41 +0100
Message-Id: <45bfb86470586f137e52256c7a8f34c597fbe99e.1638021831.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638021831.git.ffclaire1224@gmail.com>
References: <cover.1638021831.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename struct tegra_pcie_dw to tegra194_pcie to match the convention of
<driver>_pcie. No functional change intended.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 120 ++++++++++-----------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 904976913081..9e4f140f8aff 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -245,7 +245,7 @@ static const unsigned int pcie_gen_freq[] = {
 	GEN4_CORE_CLK_FREQ
 };
 
-struct tegra_pcie_dw {
+struct tegra194_pcie {
 	struct device *dev;
 	struct resource *appl_res;
 	struct resource *dbi_res;
@@ -293,18 +293,18 @@ struct tegra_pcie_dw_of_data {
 	enum dw_pcie_device_mode mode;
 };
 
-static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
+static inline struct tegra194_pcie *to_tegra_pcie(struct dw_pcie *pci)
 {
-	return container_of(pci, struct tegra_pcie_dw, pci);
+	return container_of(pci, struct tegra194_pcie, pci);
 }
 
-static inline void appl_writel(struct tegra_pcie_dw *pcie, const u32 value,
+static inline void appl_writel(struct tegra194_pcie *pcie, const u32 value,
 			       const u32 reg)
 {
 	writel_relaxed(value, pcie->appl_base + reg);
 }
 
-static inline u32 appl_readl(struct tegra_pcie_dw *pcie, const u32 reg)
+static inline u32 appl_readl(struct tegra194_pcie *pcie, const u32 reg)
 {
 	return readl_relaxed(pcie->appl_base + reg);
 }
@@ -316,7 +316,7 @@ struct tegra_pcie_soc {
 static void apply_bad_link_workaround(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	u32 current_link_width;
 	u16 val;
 
@@ -349,7 +349,7 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
 
 static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 {
-	struct tegra_pcie_dw *pcie = arg;
+	struct tegra194_pcie *pcie = arg;
 	struct dw_pcie *pci = &pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	u32 val, tmp;
@@ -420,7 +420,7 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
+static void pex_ep_event_hot_rst_done(struct tegra194_pcie *pcie)
 {
 	u32 val;
 
@@ -448,7 +448,7 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
 
 static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 {
-	struct tegra_pcie_dw *pcie = arg;
+	struct tegra194_pcie *pcie = arg;
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val, speed;
 
@@ -494,7 +494,7 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 {
-	struct tegra_pcie_dw *pcie = arg;
+	struct tegra194_pcie *pcie = arg;
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
 	u32 status_l0, status_l1, link_status;
@@ -594,7 +594,7 @@ static const u32 event_cntr_data_offset[] = {
 	0x1dc
 };
 
-static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
+static void disable_aspm_l11(struct tegra194_pcie *pcie)
 {
 	u32 val;
 
@@ -603,7 +603,7 @@ static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
 }
 
-static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
+static void disable_aspm_l12(struct tegra194_pcie *pcie)
 {
 	u32 val;
 
@@ -612,7 +612,7 @@ static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
 }
 
-static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
+static inline u32 event_counter_prog(struct tegra194_pcie *pcie, u32 event)
 {
 	u32 val;
 
@@ -629,7 +629,7 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 
 static int aspm_state_cnt(struct seq_file *s, void *data)
 {
-	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)
+	struct tegra194_pcie *pcie = (struct tegra194_pcie *)
 				     dev_get_drvdata(s->private);
 	u32 val;
 
@@ -660,7 +660,7 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 	return 0;
 }
 
-static void init_host_aspm(struct tegra_pcie_dw *pcie)
+static void init_host_aspm(struct tegra194_pcie *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val;
@@ -688,22 +688,22 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
 
-static void init_debugfs(struct tegra_pcie_dw *pcie)
+static void init_debugfs(struct tegra194_pcie *pcie)
 {
 	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
 				    aspm_state_cnt);
 }
 #else
-static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
-static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
-static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
-static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
+static inline void disable_aspm_l12(struct tegra194_pcie *pcie) { return; }
+static inline void disable_aspm_l11(struct tegra194_pcie *pcie) { return; }
+static inline void init_host_aspm(struct tegra194_pcie *pcie) { return; }
+static inline void init_debugfs(struct tegra194_pcie *pcie) { return; }
 #endif
 
 static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	u32 val;
 	u16 val_w;
 
@@ -741,7 +741,7 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 static void tegra_pcie_enable_legacy_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	u32 val;
 
 	/* Enable legacy interrupt generation */
@@ -762,7 +762,7 @@ static void tegra_pcie_enable_legacy_interrupts(struct pcie_port *pp)
 static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	u32 val;
 
 	/* Enable MSI interrupt generation */
@@ -775,7 +775,7 @@ static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
 static void tegra_pcie_enable_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 
 	/* Clear interrupt statuses before enabling interrupts */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
@@ -800,7 +800,7 @@ static void tegra_pcie_enable_interrupts(struct pcie_port *pp)
 		tegra_pcie_enable_msi_interrupts(pp);
 }
 
-static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
+static void config_gen3_gen4_eq_presets(struct tegra194_pcie *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val, offset, i;
@@ -856,7 +856,7 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	u32 val;
 
 	pp->bridge->ops = &tegra_pci_ops;
@@ -917,7 +917,7 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 {
 	u32 val, offset, speed, tmp;
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	struct pcie_port *pp = &pci->pp;
 	bool retry = true;
 
@@ -1000,7 +1000,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 
 static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
 {
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
@@ -1008,7 +1008,7 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
 
 static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 
 	disable_irq(pcie->pex_rst_irq);
 }
@@ -1023,7 +1023,7 @@ static const struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
 	.host_init = tegra_pcie_dw_host_init,
 };
 
-static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_disable_phy(struct tegra194_pcie *pcie)
 {
 	unsigned int phy_count = pcie->phy_count;
 
@@ -1033,7 +1033,7 @@ static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
 	}
 }
 
-static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_enable_phy(struct tegra194_pcie *pcie)
 {
 	unsigned int i;
 	int ret;
@@ -1060,7 +1060,7 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 	return ret;
 }
 
-static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_dw_parse_dt(struct tegra194_pcie *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
@@ -1156,7 +1156,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	return 0;
 }
 
-static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
+static int tegra_pcie_bpmp_set_ctrl_state(struct tegra194_pcie *pcie,
 					  bool enable)
 {
 	struct mrq_uphy_response resp;
@@ -1184,7 +1184,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	return tegra_bpmp_transfer(pcie->bpmp, &msg);
 }
 
-static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
+static int tegra_pcie_bpmp_set_pll_state(struct tegra194_pcie *pcie,
 					 bool enable)
 {
 	struct mrq_uphy_response resp;
@@ -1212,7 +1212,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	return tegra_bpmp_transfer(pcie->bpmp, &msg);
 }
 
-static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_downstream_dev_to_D0(struct tegra194_pcie *pcie)
 {
 	struct pcie_port *pp = &pcie->pci.pp;
 	struct pci_bus *child, *root_bus = NULL;
@@ -1250,7 +1250,7 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 	}
 }
 
-static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_get_slot_regulators(struct tegra194_pcie *pcie)
 {
 	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
 	if (IS_ERR(pcie->slot_ctl_3v3)) {
@@ -1271,7 +1271,7 @@ static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
 	return 0;
 }
 
-static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_enable_slot_regulators(struct tegra194_pcie *pcie)
 {
 	int ret;
 
@@ -1309,7 +1309,7 @@ static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
 	return ret;
 }
 
-static void tegra_pcie_disable_slot_regulators(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_disable_slot_regulators(struct tegra194_pcie *pcie)
 {
 	if (pcie->slot_ctl_12v)
 		regulator_disable(pcie->slot_ctl_12v);
@@ -1317,7 +1317,7 @@ static void tegra_pcie_disable_slot_regulators(struct tegra_pcie_dw *pcie)
 		regulator_disable(pcie->slot_ctl_3v3);
 }
 
-static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
+static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 					bool en_hw_hot_rst)
 {
 	int ret;
@@ -1414,7 +1414,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	return ret;
 }
 
-static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_unconfig_controller(struct tegra194_pcie *pcie)
 {
 	int ret;
 
@@ -1442,7 +1442,7 @@ static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
 			pcie->cid, ret);
 }
 
-static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_init_controller(struct tegra194_pcie *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -1467,7 +1467,7 @@ static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 	return ret;
 }
 
-static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_try_link_l2(struct tegra194_pcie *pcie)
 {
 	u32 val;
 
@@ -1483,7 +1483,7 @@ static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 				 1, PME_ACK_TIMEOUT);
 }
 
-static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_dw_pme_turnoff(struct tegra194_pcie *pcie)
 {
 	u32 data;
 	int err;
@@ -1545,7 +1545,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 	appl_writel(pcie, data, APPL_PINMUX);
 }
 
-static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_deinit_controller(struct tegra194_pcie *pcie)
 {
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
@@ -1553,7 +1553,7 @@ static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 	tegra_pcie_unconfig_controller(pcie);
 }
 
-static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_config_rp(struct tegra194_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	char *name;
@@ -1605,7 +1605,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 	return ret;
 }
 
-static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
+static void pex_ep_event_pex_rst_assert(struct tegra194_pcie *pcie)
 {
 	u32 val;
 	int ret;
@@ -1644,7 +1644,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
 }
 
-static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
+static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_ep *ep = &pci->ep;
@@ -1809,7 +1809,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 {
-	struct tegra_pcie_dw *pcie = arg;
+	struct tegra194_pcie *pcie = arg;
 
 	if (gpiod_get_value(pcie->pex_rst_gpiod))
 		pex_ep_event_pex_rst_assert(pcie);
@@ -1819,7 +1819,7 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
+static int tegra_pcie_ep_raise_legacy_irq(struct tegra194_pcie *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
 	if (irq > 1)
@@ -1831,7 +1831,7 @@ static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
 	return 0;
 }
 
-static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
+static int tegra_pcie_ep_raise_msi_irq(struct tegra194_pcie *pcie, u16 irq)
 {
 	if (unlikely(irq > 31))
 		return -EINVAL;
@@ -1841,7 +1841,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 	return 0;
 }
 
-static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
+static int tegra_pcie_ep_raise_msix_irq(struct tegra194_pcie *pcie, u16 irq)
 {
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
@@ -1855,7 +1855,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				   u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
@@ -1896,7 +1896,7 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.get_features = tegra_pcie_ep_get_features,
 };
 
-static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
+static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
 				struct platform_device *pdev)
 {
 	struct dw_pcie *pci = &pcie->pci;
@@ -1962,7 +1962,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	const struct tegra_pcie_dw_of_data *data;
 	struct device *dev = &pdev->dev;
 	struct resource *atu_dma_res;
-	struct tegra_pcie_dw *pcie;
+	struct tegra194_pcie *pcie;
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct phy **phys;
@@ -2148,7 +2148,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 static int tegra_pcie_dw_remove(struct platform_device *pdev)
 {
-	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct tegra194_pcie *pcie = platform_get_drvdata(pdev);
 
 	if (!pcie->link_state)
 		return 0;
@@ -2166,7 +2166,7 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 
 static int tegra_pcie_dw_suspend_late(struct device *dev)
 {
-	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
 	u32 val;
 
 	if (!pcie->link_state)
@@ -2184,7 +2184,7 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 
 static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
-	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
 
 	if (!pcie->link_state)
 		return 0;
@@ -2201,7 +2201,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 
 static int tegra_pcie_dw_resume_noirq(struct device *dev)
 {
-	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
 	if (!pcie->link_state)
@@ -2236,7 +2236,7 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 
 static int tegra_pcie_dw_resume_early(struct device *dev)
 {
-	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
 	u32 val;
 
 	if (pcie->mode == DW_PCIE_EP_TYPE) {
@@ -2261,7 +2261,7 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 
 static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 {
-	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct tegra194_pcie *pcie = platform_get_drvdata(pdev);
 
 	if (!pcie->link_state)
 		return;
-- 
2.25.1

