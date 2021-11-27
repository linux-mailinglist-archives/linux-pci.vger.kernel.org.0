Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA745FF1C
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhK0OTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhK0ORv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527DBC0613F2
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 133so10513381wme.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i++CnfQul7tulbjn5Ada0LDULJ8HgeGM/trVrGjJFJQ=;
        b=JDG2eaBM7xt7oDxiP7tHPrpYdroCV22/iciUUmf+Lv3t5ESc9DBiPzqtn0dNv3gr1r
         Xbow4y2zMJ22NpBMiOX8hnCuH4ljA2veSmU48qFq/AZjT4aTVu5kq6XpI5gIFqK1wLOT
         NXq2FeB7XTmdX8H+2n5lb1pqSF5tL4Rv00AgUJqgLs71BKSzJoJqSqenxGf7uoqeNCFG
         ZErojsOrvuRmscUaJiH3ImZiCW2wdpBSkm830IMTurNpRg0yG7zkkafE42yNlX9uRNUJ
         g2MKa657GTOSqDVDKWzrpnXGuhOv3hU2khxkYlAwT6dRr0z0mXjTPjzrgf505nCDVApd
         bZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i++CnfQul7tulbjn5Ada0LDULJ8HgeGM/trVrGjJFJQ=;
        b=rTIxcfg63Sf4jnw0zHkf66hRXU9iI+6FHv+rtXf3hD1P+xslTinqcWXu+8MzTaOSsG
         RHi1Kpe0d5RtMF1wN2DTypEQyr6CQXKygaBPjxP6Urh3vH7hVlC48dfT8mvCLniDKm/4
         sdH4hyzZ2moKUg/qxf563L9i2lAqpq0qHJm4nvCr0lL6hbo2emjYKyB4I0AwWxLbOiu8
         KCRZwOQEzrUlCLDv1pDzaYxMgGwQ92O0csy88pv7mV2PH/wQEXmjMNDDbRCKhSQaDRef
         /swo8xdlJhRiQt8swwFcg1/peUsNPstIPJNYHRrDU9wVZSosythaq13n2VzEhAPYqJXc
         ks/Q==
X-Gm-Message-State: AOAM530nsXlK3meK6PQrtvAyoJac2KYWyehB0SZi7zRJ/KnjgjQOdWM8
        G6dfpNyngqT8WckmcbaBZwHziBp3NHcHTA==
X-Google-Smtp-Source: ABdhPJxnQfSJTSG39P3LAxqNbdYXXfrM26rfeDd0L9BJoklL7/7Xp+2+FrR4Rw+gcHo2e2wyWuGppQ==
X-Received: by 2002:a05:600c:4303:: with SMTP id p3mr23333159wme.128.1638022297841;
        Sat, 27 Nov 2021 06:11:37 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:37 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 07/13] PCI: mediatek-gen3: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:15 +0100
Message-Id: <301c798d4799fd2a941b49b7acab119c484d0744.1638022049.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638022048.git.ffclaire1224@gmail.com>
References: <cover.1638022048.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI controller struct contain "device *", while others contain
"platform_device *". Unify "device *dev" to "platform_device *pdev" in
struct mtk_pcie, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 36 ++++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 459fe88297b0..6e347be00b0d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -130,7 +130,7 @@ struct mtk_msi_set {
  * @msi_irq_in_use: bit map for assigned MSI IRQ
  */
 struct mtk_gen3_pcie {
-	struct device *dev;
+	struct platform_device *pdev;
 	void __iomem *base;
 	phys_addr_t reg_base;
 	struct reset_control *mac_reset;
@@ -213,11 +213,12 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 				    resource_size_t size,
 				    unsigned long type, int num)
 {
+	struct device *dev = &pcie->pdev->dev;
 	void __iomem *table;
 	u32 val;
 
 	if (num >= PCIE_MAX_TRANS_TABLES) {
-		dev_err(pcie->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
+		dev_err(dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
 			(unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
 		return -ENODEV;
 	}
@@ -275,6 +276,7 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 
 static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
 	struct resource_entry *entry;
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	unsigned int table_index = 0;
@@ -320,7 +322,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
 	if (err) {
 		val = readl_relaxed(pcie->base + PCIE_LTSSM_STATUS_REG);
-		dev_err(pcie->dev, "PCIe link down, ltssm reg val: %#x\n", val);
+		dev_err(dev, "PCIe link down, ltssm reg val: %#x\n", val);
 		return err;
 	}
 
@@ -352,7 +354,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		if (err)
 			return err;
 
-		dev_dbg(pcie->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
+		dev_dbg(dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
 			range_type, table_index, (unsigned long long)cpu_addr,
 			(unsigned long long)pci_addr, (unsigned long long)size);
 
@@ -397,6 +399,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
 	struct mtk_gen3_pcie *pcie = data->domain->host_data;
+	struct device *dev = &pcie->pdev->dev;
 	unsigned long hwirq;
 
 	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
@@ -404,7 +407,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_hi = upper_32_bits(msi_set->msg_addr);
 	msg->address_lo = lower_32_bits(msi_set->msg_addr);
 	msg->data = hwirq;
-	dev_dbg(pcie->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
+	dev_dbg(dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
 		hwirq, msg->address_hi, msg->address_lo, msg->data);
 }
 
@@ -575,7 +578,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 
 static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *intc_node, *node = dev->of_node;
 	int ret;
 
@@ -691,8 +694,8 @@ static void mtk_pcie_irq_handler(struct irq_desc *desc)
 
 static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	int err;
 
 	err = mtk_pcie_init_irq_domains(pcie);
@@ -710,8 +713,8 @@ static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
 
 static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	struct resource *regs;
 	int ret;
 
@@ -764,7 +767,7 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 
 static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	int err;
 
 	/* PHY power on and enable pipe clock */
@@ -811,10 +814,11 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 
 static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
 	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
-	pm_runtime_put_sync(pcie->dev);
-	pm_runtime_disable(pcie->dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 	reset_control_assert(pcie->mac_reset);
 
 	phy_power_off(pcie->phy);
@@ -865,7 +869,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(host);
 
-	pcie->dev = dev;
+	pcie->pdev = pdev;
 	platform_set_drvdata(pdev, pcie);
 
 	err = mtk_pcie_setup(pcie);
@@ -961,7 +965,7 @@ static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 	/* Trigger link to L2 state */
 	err = mtk_pcie_turn_off_link(pcie);
 	if (err) {
-		dev_err(pcie->dev, "cannot enter L2 state\n");
+		dev_err(dev, "cannot enter L2 state\n");
 		return err;
 	}
 
@@ -970,7 +974,7 @@ static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 	val |= PCIE_PE_RSTB;
 	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 
-	dev_dbg(pcie->dev, "entered L2 states successfully");
+	dev_dbg(dev, "entered L2 states successfully");
 
 	mtk_pcie_irq_save(pcie);
 	mtk_pcie_power_down(pcie);
-- 
2.25.1

