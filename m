Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2822845FF1A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhK0OTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbhK0ORs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0AAC0613ED
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso12792274wmr.4
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfPUljakp8BCPfOSBPOMugbLtY1riZZ9l3qqzRCJcvY=;
        b=FwvIoBqtoxl2vIPwkqxs6r86mmpOvx9ZChm6sS20fQObkP1MPpL+/YTTD4dlZVOgtJ
         ojOyApK8yB31habbl4rr2BZkT6eEN5AxkQNqt7I6BpVz8SiY7Le7jwygQcO6DHcU7Mut
         SJPOIvxfTlzYwq9+lhYaCHHQefXA6OMNiBpSzF+qygoKBsqqewmimKRkwIY63gRZujMQ
         xQR06JGuCVcOodwIrqgIO5cdfPfI3Th7MAqusC4UoQgP1gY4RLerHZAHwdqtn5eEIFQl
         gaT+IVreaMkwajeBnzOC+nzk09dMidFYnmLc8/xOd6sJL0M3sD0+DuKy/csQt6JXJBHM
         ragg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfPUljakp8BCPfOSBPOMugbLtY1riZZ9l3qqzRCJcvY=;
        b=Q/kR23yCKsyY9mNwzT3XMLWdT7tvMG8mJQx11bmJndssYuvHxno8zhZCPMwk5qVjOb
         AyuOWKcui4d5+kbVin4r/6NkBsBdc0AIKXpnV1oDB7MkVU3O+ZLsqap06q/kD3gmhkrd
         aOuVvCaqkennm1plb8YZlBwMTAcNJ/vNdz+g9F2h6Yi8y+DGT71UV8cJlvZ3tEATqTtm
         vEMScZBQCAcdStSp0dPAcSPDEQN2xYpl81dRXDqrB2zxHCIwp6ZFnw4Hf9SCyBMm8X7B
         vHaXugA2HLVwfm0WTG5H/zjTTRAO4VjFSXm7JXXf/jh4RzF+KHq+EnX+s+BIE8kPdb5g
         slLg==
X-Gm-Message-State: AOAM533gZrlGyb/CJg+cfihg8nA++4DA+HKPfT1Dt10NmIfBUehXerFm
        fiilKTNjz2Z22mrj8fR8l3346vd1VjSGPg==
X-Google-Smtp-Source: ABdhPJyx+UgMMKKuRuOZAcGh6gd+S54bg1M4zu6DmnDLrNhICwSxPzJJhiZbk8T41uFn/8OXKr0seA==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr22851290wmj.12.1638022293892;
        Sat, 27 Nov 2021 06:11:33 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:33 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 05/13] PCI: microchip: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:13 +0100
Message-Id: <d50d2c2c0d608f9431accb0028d7c49c833dd229.1638022049.git.ffclaire1224@gmail.com>
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
struct mc_port, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 329f930d17aa..34616546e862 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -263,8 +263,8 @@ struct mc_msi {
 };
 
 struct mc_port {
+	struct platform_device *pdev;
 	void __iomem *axi_base_addr;
-	struct device *dev;
 	struct irq_domain *intx_domain;
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
@@ -406,7 +406,7 @@ static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
 static void mc_handle_msi(struct irq_desc *desc)
 {
 	struct mc_port *port = irq_desc_get_handler_data(desc);
-	struct device *dev = port->dev;
+	struct device *dev = &port->pdev->dev;
 	struct mc_msi *msi = &port->msi;
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
@@ -450,7 +450,7 @@ static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_hi = upper_32_bits(addr);
 	msg->data = data->hwirq;
 
-	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
+	dev_dbg(&port->pdev->dev, "msi#%x address_hi %#x address_lo %#x\n",
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
 }
 
@@ -511,7 +511,7 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 	if (test_bit(d->hwirq, msi->used))
 		__clear_bit(d->hwirq, msi->used);
 	else
-		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
+		dev_err(&port->pdev->dev, "trying to free unused MSI%lu\n", d->hwirq);
 
 	mutex_unlock(&msi->lock);
 }
@@ -536,7 +536,7 @@ static struct msi_domain_info mc_msi_domain_info = {
 
 static int mc_allocate_msi_domains(struct mc_port *port)
 {
-	struct device *dev = port->dev;
+	struct device *dev = &port->pdev->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
 	struct mc_msi *msi = &port->msi;
 
@@ -563,7 +563,7 @@ static int mc_allocate_msi_domains(struct mc_port *port)
 static void mc_handle_intx(struct irq_desc *desc)
 {
 	struct mc_port *port = irq_desc_get_handler_data(desc);
-	struct device *dev = port->dev;
+	struct device *dev = &port->pdev->dev;
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	unsigned long status;
@@ -716,7 +716,7 @@ static u32 get_events(struct mc_port *port)
 static irqreturn_t mc_event_handler(int irq, void *dev_id)
 {
 	struct mc_port *port = dev_id;
-	struct device *dev = port->dev;
+	struct device *dev = &port->pdev->dev;
 	struct irq_data *data;
 
 	data = irq_domain_get_irq_data(port->event_domain, irq);
@@ -883,7 +883,7 @@ static int mc_pcie_init_clks(struct device *dev)
 
 static int mc_pcie_init_irq_domains(struct mc_port *port)
 {
-	struct device *dev = port->dev;
+	struct device *dev = &port->pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
 
@@ -995,7 +995,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
-	port->dev = dev;
+	port->pdev = pdev;
 
 	ret = mc_pcie_init_clks(dev);
 	if (ret) {
-- 
2.25.1

