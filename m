Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4045FF1D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbhK0OTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbhK0ORv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0514FC0613F6
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d9so4283543wrw.4
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84sRKjOIcFLH6yEzmszwRjwTc0G3wDfY0PEvqFwFO18=;
        b=nWtf/e9B3LbshM6kF/N1B5iXbLnVLwodrIRSUG3BetQ2oWLPNoB+6z7k5BLonYuIFu
         5LAeiyegX1fWfFC0voIqGZDZVRIWxnjIneWRFpZpeCSj5/BnX3FnHJp73bUQH2JXTBi7
         t27N4FWBqfZ7C/2JZG6/0iQNuWWd+Uv4uTx6VKKLio9m5JEni9tv/4nPhXSVrlWbB7Qi
         6ggOQ+igfNJw0jJFYzsfKyKnEZO7R38k8+6pOi5V3OFT6vUB94+8pRL2qdo51phrXptf
         8TjLqF7oET91RQZGUjPfarHLijan6dtyyGMuKkBQfJmRZLlwYsdDnQsQxXE5RfVP1RDT
         GyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84sRKjOIcFLH6yEzmszwRjwTc0G3wDfY0PEvqFwFO18=;
        b=umzyxYnBJTW9NncleocemOglgOpBDMmLaHIOqx2Dab3JAeRA+exn1im3yudn6Z26Sa
         kwg8XcoXQYhiOVBJ9z5ueWdGIGekKyoN5xCLiE5WqmfsSrqy5oAap67CaG/P328LUy0p
         gUt3M+bZMuMl2TRCqUfnxHNqwyGHUfHo+Ggr1cOj+8icbGyFVaEI/38Q7++8WvzOgUxb
         osnnSkSJNHzoZDNOkBOpv17N4/OtE7cLnhriJDx8MN5FCMg9VN0rn3PQYh1lc5BzElae
         UhD6rhWdRqS12NYmXBi3LndUTX0q9kyYaI58kB4A9lylAWWLku2G62V3Ytajoec9aqXk
         kwhw==
X-Gm-Message-State: AOAM531wEVHPELT4TMAQ2MFPyfBss69THz9OHfW21nm5ucdmm52cBDjl
        oGK2683WNKw+XsPlXiNlap3L6hqF/k17tw==
X-Google-Smtp-Source: ABdhPJwiTNCPDP5xYLP9PBXCTB6DVav9naFFAZZ8T0W/YgVbk98OPvlGPMfhB7nIhwLTsSWQsY6MWg==
X-Received: by 2002:a05:6000:15c8:: with SMTP id y8mr21890085wry.55.1638022302516;
        Sat, 27 Nov 2021 06:11:42 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:42 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 10/13] PCI: v3-semi: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:18 +0100
Message-Id: <c520f6acf78ee69dd4fb87804aba384c77e76f87.1638022049.git.ffclaire1224@gmail.com>
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
struct v3_pci, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-v3-semi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 154a5398633c..96b486650667 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -236,7 +236,7 @@
 #define INTEGRATOR_SC_LBFCODE_OFFSET	0x24
 
 struct v3_pci {
-	struct device *dev;
+	struct platform_device *pdev;
 	void __iomem *base;
 	void __iomem *config_base;
 	u32 config_mem;
@@ -438,7 +438,7 @@ static struct pci_ops v3_pci_ops = {
 static irqreturn_t v3_irq(int irq, void *data)
 {
 	struct v3_pci *v3 = data;
-	struct device *dev = v3->dev;
+	struct device *dev = &v3->pdev->dev;
 	u32 status;
 
 	status = readw(v3->base + V3_PCI_STAT);
@@ -481,12 +481,13 @@ static irqreturn_t v3_irq(int irq, void *data)
 
 static int v3_integrator_init(struct v3_pci *v3)
 {
+	struct device *dev = &v3->pdev->dev;
 	unsigned int val;
 
 	v3->map =
 		syscon_regmap_lookup_by_compatible("arm,integrator-ap-syscon");
 	if (IS_ERR(v3->map)) {
-		dev_err(v3->dev, "no syscon\n");
+		dev_err(dev, "no syscon\n");
 		return -ENODEV;
 	}
 
@@ -511,7 +512,7 @@ static int v3_integrator_init(struct v3_pci *v3)
 			 readb(v3->base + V3_MAIL_DATA) != 0x55);
 	}
 
-	dev_info(v3->dev, "initialized PCI V3 Integrator/AP integration\n");
+	dev_info(dev, "initialized PCI V3 Integrator/AP integration\n");
 
 	return 0;
 }
@@ -520,7 +521,7 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
 				 struct pci_host_bridge *host,
 				 struct resource_entry *win)
 {
-	struct device *dev = v3->dev;
+	struct device *dev = &v3->pdev->dev;
 	struct resource *mem;
 	struct resource *io;
 
@@ -598,7 +599,7 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
 				   struct resource_entry *entry,
 				   u32 *pci_base, u32 *pci_map)
 {
-	struct device *dev = v3->dev;
+	struct device *dev = &v3->pdev->dev;
 	u64 cpu_addr = entry->res->start;
 	u64 cpu_end = entry->res->end;
 	u64 pci_end = cpu_end - entry->offset;
@@ -656,7 +657,7 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
 		val |= V3_LB_BASE_ADR_SIZE_2GB;
 		break;
 	default:
-		dev_err(v3->dev, "illegal dma memory chunk size\n");
+		dev_err(dev, "illegal dma memory chunk size\n");
 		return -EINVAL;
 	}
 	val |= V3_PCI_MAP_M_REG_EN | V3_PCI_MAP_M_ENABLE;
@@ -676,7 +677,7 @@ static int v3_pci_parse_map_dma_ranges(struct v3_pci *v3,
 				       struct device_node *np)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(v3);
-	struct device *dev = v3->dev;
+	struct device *dev = &v3->pdev->dev;
 	struct resource_entry *entry;
 	int i = 0;
 
@@ -723,7 +724,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	host->ops = &v3_pci_ops;
 	v3 = pci_host_bridge_priv(host);
 	host->sysdata = v3;
-	v3->dev = dev;
+	v3->pdev = pdev;
 
 	/* Get and enable host clock */
 	clk = devm_clk_get(dev, NULL);
-- 
2.25.1

