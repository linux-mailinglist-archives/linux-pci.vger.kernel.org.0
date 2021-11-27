Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86545FF1E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355186AbhK0OTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbhK0ORv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCAC0613F3
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s13so25216406wrb.3
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8nFR1D3sjPQN1xzd4WfJBHS1L8Y0eUshfiPdageUB7U=;
        b=eth2+FlBt7PAEaAzBLfDtk19omNBuPAFTeUldR5wJqNHbiGMvtzOrpPpdHFe6FfDSm
         CHSo+zLZN7gZcvS8Z3dldwFgbqZxKjo+xC9vZ7qhNcfB9ZGb7syuGQfQHG2JefdBlKPv
         4YWc82vh98zI6aajCaM2w5lLAFXUyNZVQAAg5c/aIXUsR4SVy2u9kjD9HX86tBer7hdu
         UPoBaEx4/4PMe80v6pN6dFCt6QOYxDuJkLTYn1m6mP7JAdjquxxBtMkz+Chv1rjbOgXL
         SaMCC4QQwiZTD11ZICNbhYIPJltWvO8lmzQVI5Xt13Hhg92U8vMX8mPzwFB0obVztJ6s
         LawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8nFR1D3sjPQN1xzd4WfJBHS1L8Y0eUshfiPdageUB7U=;
        b=gC1YRNXtrMkKKGawWmerAViER7WlNUdwT2tW0pTPaztV1qPFHYPFECtqogSM1ZxK1K
         U8QsLKp9XCVidZEYL3cLqlar1RyveYjUK4iRJ5HhN8qqsT8tedpxTSJq7kfMaAhqnd7K
         x+4MuYquL7cvxroC3bJbsH3rxsjkpuIC017qGqLKntA5pVKPV+5kxTY1h/CtKsN2UB2p
         /ubuidDGX5HbhgTheO6ntm9DXuV+HfuyIcV5yl6qCboTcUy8jb/95woITIcV9/qehfwj
         ntp1e76n3JZ9Ce9n3UZx/ogQSIri7yxvtCfF+lXRCwYoLwa+WT3JALGslY97CZuVwOXD
         2KCQ==
X-Gm-Message-State: AOAM531xupN5nvyENVz9px5EzK9l86z1km0y79Ax3Sz5lUfivQG3Dz4L
        JrOeV9zA0mHdcrmqW0qIKuk=
X-Google-Smtp-Source: ABdhPJz//yrYPQcKROeJv2eNeRPsn8Niq0vV4pio23vG1xrTJs8W+z9NU3zepUp2DtDyfyO/UIzQxg==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr21324581wri.438.1638022299455;
        Sat, 27 Nov 2021 06:11:39 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:39 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 08/13] PCI: rcar-gen2: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:16 +0100
Message-Id: <758fc6c4dbd95b7bded954db3159fc8f962660c1.1638022049.git.ffclaire1224@gmail.com>
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
struct rcar_pci_priv, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-rcar-gen2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index afde4aa8f6dc..be24b08dfbaa 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -94,7 +94,7 @@
 #define RCAR_PCI_UNIT_REV_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x48)
 
 struct rcar_pci_priv {
-	struct device *dev;
+	struct platform_device *pdev;
 	void __iomem *reg;
 	struct resource mem_res;
 	struct resource *cfg_res;
@@ -133,7 +133,7 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 {
 	struct rcar_pci_priv *priv = pw;
-	struct device *dev = priv->dev;
+	struct device *dev = &priv->pdev->dev;
 	u32 status = ioread32(priv->reg + RCAR_PCI_INT_STATUS_REG);
 
 	if (status & RCAR_PCI_INT_ALLERRORS) {
@@ -150,7 +150,7 @@ static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 
 static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
 {
-	struct device *dev = priv->dev;
+	struct device *dev = &priv->pdev->dev;
 	int ret;
 	u32 val;
 
@@ -173,7 +173,7 @@ static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
 static void rcar_pci_setup(struct rcar_pci_priv *priv)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(priv);
-	struct device *dev = priv->dev;
+	struct device *dev = &priv->pdev->dev;
 	void __iomem *reg = priv->reg;
 	struct resource_entry *entry;
 	unsigned long window_size;
@@ -307,7 +307,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	priv->reg = reg;
-	priv->dev = dev;
+	priv->pdev = pdev;
 
 	if (priv->irq < 0) {
 		dev_err(dev, "no valid irq found\n");
-- 
2.25.1

