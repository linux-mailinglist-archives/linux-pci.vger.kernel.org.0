Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121CE40BCCC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 02:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhIOA7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 20:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhIOA7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 20:59:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9BEC061574;
        Tue, 14 Sep 2021 17:58:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f21so572279plb.4;
        Tue, 14 Sep 2021 17:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ubhlcucdy9Pz33RVR6Wd5vMG8MUxGmT2SBgmEMx3wXs=;
        b=ceXKfIk4CVccPV+QvN/0+ORKRaKKkU8802CcSsUIVWdKRFtmI7yJ3qn/+sdyqIqRdA
         +08JajJMDNuojU/HkJmRHM/GRhr1uhEzalfmP65HsVnZ0NDFIRlrh5LTYxGe4sUZs77z
         Tao4xcXOtVZfg9YP/6llynkbJvY4n2xnEBWKnQec+GVe4Gq+mbbCwvyGE61MUuw2Ykq1
         dukT5RcTwplAoFegftW+5ANVpK5Afqrbn2E+d2JWdCzpc8X/N+b0eIEQQiym95pH9Kwh
         ZC+FZciwADWuD0xS3LSNqP67AH6smIhkwjFMmWDCdO0iT1AWx/k3jWJIWlYQgX6MuJzo
         gF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ubhlcucdy9Pz33RVR6Wd5vMG8MUxGmT2SBgmEMx3wXs=;
        b=lgVblIm8FxfXRjsIQ/Fn6RYE2AKNni6VaDcMoqQwJnfjYNH3IHLw3ttYAP0LCGPjJM
         Tmke0xdn1jnax7QlCsDFnBore5oefrA5+jsG/mWIp7dFf1RfDGreNpjiwSTW7UBbEK1o
         CRW+jiYoN1/bWiLOVOiMYBfts1RWTGXWTEqZdE7Da6RGJoL802A/oJdcVHGv2kegvovF
         re1u6eK5QLNXUhnSTm5Q59zjPsSycntArinJsD+ueJHRW9v0nWaMLiX8pd6gDjQgJQuC
         9IjknjCCNOzaJQ8bUtXeykbCzoJnXHZn3rIlasUSgomHl23yXJwkJ6u2N/c720FCfvUO
         Z7tA==
X-Gm-Message-State: AOAM531Ub09OtEk3kol10wwTR/6eICpkDp2b1uDOkW4fFkwiFT4pRQL4
        WZ280MzjgQVVejOJW7dyHPY=
X-Google-Smtp-Source: ABdhPJyTWWkHEUiqG9ssT1IBLGgZGvuyabqkT3jAUPUWr0kL2LYuObeJdnNWx7z9qJ2+mfiQNX4oYw==
X-Received: by 2002:a17:90a:194a:: with SMTP id 10mr5057715pjh.221.1631667514995;
        Tue, 14 Sep 2021 17:58:34 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id h16sm11588176pfn.215.2021.09.14.17.58.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 17:58:34 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: vmd: assign a number to each VMD controller
Date:   Wed, 15 Sep 2021 08:58:32 +0800
Message-Id: <1631667512-14818-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

If the system has multiple VMD controllers, the driver does not assign
a number to each controller, so when analyzing the interrupt through
/proc/interrupts, the names of all controllers are the same, which is
not very convenient for problem analysis. Here, try to assign a number
to each VMD controller.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---

v2: Update the commit log.

 drivers/pci/controller/vmd.c | 58 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e3fcdfe..c334396 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -69,6 +69,8 @@ enum vmd_features {
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
+static DEFINE_IDA(vmd_instance_ida);
+
 /*
  * Lock for manipulating VMD IRQ lists.
  */
@@ -119,6 +121,8 @@ struct vmd_dev {
 	struct pci_bus		*bus;
 	u8			busn_start;
 	u8			first_vec;
+	char			*name;
+	int			instance;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -599,7 +603,7 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
 		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
 				       vmd_irq, IRQF_NO_THREAD,
-				       "vmd", &vmd->irqs[i]);
+				       vmd->name, &vmd->irqs[i]);
 		if (err)
 			return err;
 	}
@@ -769,28 +773,48 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned long features = (unsigned long) id->driver_data;
 	struct vmd_dev *vmd;
-	int err;
+	int err = 0;
 
-	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
-		return -ENOMEM;
+	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20)) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
-	if (!vmd)
-		return -ENOMEM;
+	if (!vmd) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	vmd->dev = dev;
+	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
+	if (vmd->instance < 0) {
+		err = vmd->instance;
+		goto out;
+	}
+
+	vmd->name = kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
+	if (!vmd->name) {
+		err = -ENOMEM;
+		goto out_release_instance;
+	}
+
 	err = pcim_enable_device(dev);
 	if (err < 0)
-		return err;
+		goto out_release_instance;
 
 	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
-	if (!vmd->cfgbar)
-		return -ENOMEM;
+	if (!vmd->cfgbar) {
+		err = -ENOMEM;
+		goto out_release_instance;
+	}
 
 	pci_set_master(dev);
 	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
-		return -ENODEV;
+	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32))) {
+		err = -ENODEV;
+		goto out_release_instance;
+	}
 
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
@@ -799,11 +823,17 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
-		return err;
+		goto out_release_instance;
 
 	dev_info(&vmd->dev->dev, "Bound to PCI domain %04x\n",
 		 vmd->sysdata.domain);
 	return 0;
+
+ out_release_instance:
+	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	kfree(vmd->name);
+ out:
+	return err;
 }
 
 static void vmd_cleanup_srcu(struct vmd_dev *vmd)
@@ -824,6 +854,8 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
+	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	kfree(vmd->name);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -848,7 +880,7 @@ static int vmd_resume(struct device *dev)
 	for (i = 0; i < vmd->msix_count; i++) {
 		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
 				       vmd_irq, IRQF_NO_THREAD,
-				       "vmd", &vmd->irqs[i]);
+				       vmd->name, &vmd->irqs[i]);
 		if (err)
 			return err;
 	}
-- 
1.8.3.1

