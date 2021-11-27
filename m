Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40AB45FF1F
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbhK0OTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244833AbhK0ORv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C709C0613F4
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d24so25243170wra.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WH3xG1L5owcBHEeDadO3z6pf35kVBk/Y6uYjoG4FJf4=;
        b=ZSbtrDFXeuDOVTwsUKwLde8rWDPSgcemrF/FPu2b+CCojBiVm0uein5V8xzNiKQS1D
         Swgg5swMnTxeHQiS11xeAELJuLgiYiwFgXt0fj7WtFw6SrOhMJNnvG8WrpN32wb66DLH
         O3noccfLcdnFrac3RkwUgRHY/DZEuhAyhMRmBqzF3kzBqWAgz7wH7WvkB39VWdMiBfw3
         NIdgs/WP3TlIFUMys6gzifIQY6fFO3DD3X4jBUIlwBimtYX+mm0MlQMH87piVsLk2KCM
         mvmo2cm8xeKYR4L2h9F4gLLOABsmD+GCfYIyy9Gur8KntUcpHCzFAIZ1CUnM1NNWHf/j
         Vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WH3xG1L5owcBHEeDadO3z6pf35kVBk/Y6uYjoG4FJf4=;
        b=vBEP3ekaYy3lDnanF0rl7muj+zjF4YpxYfDTI5T8pFJDqQDFzPnJD+Ol8kAE5oDD75
         PPRPgtOFQDplS1etfO0axXVBQQy/TXdxyQtAONBb5uyPnidzMZgE8mksyTgigoNVP8Uk
         nOVDWPX/x2UgOePYzJ6Zkpk+VZAUAfIdj6SU2a5HXhiep6NnWugayeBpbuo4xdJmA4oR
         iCfJAUIuSQr976lJbgP7drzob26ntwpGqZZZQ29GBdFUYfNRxdCUvDNTHYbR6q4aEyhu
         XPPWfvLgHKNIm8sqU61fw3z/YMxA4x3tCJXjKkLa/mkNieb9C3leru5+6ihl3UTgmzQe
         x6iw==
X-Gm-Message-State: AOAM5311LPgF2+767LpxSCffEy9KvYuWDV0ybFbiw+MOf0cp5mN9QeNn
        7h1yp1noag9PAdf6MucnA4g=
X-Google-Smtp-Source: ABdhPJw5HbbPHWHrKeGbFQjSVuKGXv56zXScrTA2TBlQF+inKybmp3jLx2vyXp8UirBOq3Bddqvyew==
X-Received: by 2002:adf:e512:: with SMTP id j18mr21265037wrm.532.1638022300948;
        Sat, 27 Nov 2021 06:11:40 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:40 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 09/13] PCI: ftpci100: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:17 +0100
Message-Id: <0d49eb261d6cd7a69c98280a50f9db90e2e8fd75.1638022049.git.ffclaire1224@gmail.com>
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
struct faraday_pci, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-ftpci100.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 88980a44461d..64e4405ad0be 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -120,7 +120,7 @@ struct faraday_pci_variant {
 };
 
 struct faraday_pci {
-	struct device *dev;
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct irq_domain *irqdomain;
 	struct pci_bus *bus;
@@ -342,19 +342,20 @@ static const struct irq_domain_ops faraday_pci_irqdomain_ops = {
 
 static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 {
-	struct device_node *intc = of_get_next_child(p->dev->of_node, NULL);
+	struct device *dev = &p->pdev->dev;
+	struct device_node *intc = of_get_next_child(dev->of_node, NULL);
 	int irq;
 	int i;
 
 	if (!intc) {
-		dev_err(p->dev, "missing child interrupt-controller node\n");
+		dev_err(dev, "missing child interrupt-controller node\n");
 		return -EINVAL;
 	}
 
 	/* All PCI IRQs cascade off this one */
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
-		dev_err(p->dev, "failed to get parent IRQ\n");
+		dev_err(dev, "failed to get parent IRQ\n");
 		of_node_put(intc);
 		return irq ?: -EINVAL;
 	}
@@ -363,7 +364,7 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 					     &faraday_pci_irqdomain_ops, p);
 	of_node_put(intc);
 	if (!p->irqdomain) {
-		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
+		dev_err(dev, "failed to create Gemini PCI IRQ domain\n");
 		return -EINVAL;
 	}
 
@@ -377,7 +378,7 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 
 static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p)
 {
-	struct device *dev = p->dev;
+	struct device *dev = &p->pdev->dev;
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(p);
 	struct resource_entry *entry;
 	u32 confreg[3] = {
@@ -439,7 +440,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	host->ops = &faraday_pci_ops;
 	p = pci_host_bridge_priv(host);
 	host->sysdata = p;
-	p->dev = dev;
+	p->pdev = pdev;
 
 	/* Retrieve and enable optional clocks */
 	clk = devm_clk_get(dev, "PCLK");
-- 
2.25.1

