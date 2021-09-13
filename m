Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC54408A0F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhIML04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhIML04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 07:26:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC93AC061574;
        Mon, 13 Sep 2021 04:25:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d18so5564418pll.11;
        Mon, 13 Sep 2021 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CVS3QmGjk4eY7kvmh+6J08F3fOLcHRlS/W30+bNz/bk=;
        b=STWH0WpycHkA23I8MfwoDjRNXjwWDk+O3Xzzdhs9aEgn+zRdO1nGXT7v70luo/gedc
         mQZSojeIlReTR1785w/488ghz/oYlnqjKGMM202GTg0RB93a5MQ/+uIEsk69jGuRWxjJ
         3jJ2pQW2TikzXUNnqPz/0Pl3rZFYfhVox56dxPVzCq91iaR2j0S7JyiVFgBAlygSAq7g
         V08orBFc12X5pknLDxPd84nfuDKRp7lnuWk3hXwnVuGgCxl2J3zfaKqaKZAnb/0SkFhF
         IdeGm+wt9FeG5W3dmLtamGPCcAA+gH4Oj0+UasHJUgYUydRymVOdESjdh9tU6UbyCI2K
         ryhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CVS3QmGjk4eY7kvmh+6J08F3fOLcHRlS/W30+bNz/bk=;
        b=qlh7s5ejnb/zYDLXf7MukpCOVuhATjL6Ftr57D+siz7fBpXvMgBi24FuvFqVyxQpj8
         2i9xXS60V9yGFg5yG/Nh0qyxJq5q1eIDfx2wrIDaw3Dj1neEpuUAgLN/BlC7kIHrWeqM
         vjicuRqiAuadu0mOkbbbSS6Qa2hwdVpprimZTraiNzN7RhnnWLVD6bwqUHr/a1u7Y3AE
         C27EihR+toHzk9hqyWfCEzrY+6v7cg9PlR8nIYA59j5Pnx94xfOz3IuHJpzW/SdjFX8B
         wD2s5swoTp7c63QsBsr9t1DbtUcglOmkvGFFheOykUZxL6touUUQLtLhI3eIyl/tdy6F
         XCiw==
X-Gm-Message-State: AOAM5331lmaado0fD1v/LWMiz9gFCFTpkUxpUZx/NBkXgHK6swW/J2+L
        hv/2xcBslIEbLXeqIwZQ6NtFRNZ+XM9jXQ==
X-Google-Smtp-Source: ABdhPJwg59LUmj1lGjCOmhNlAFRY9/k17SCO9/paUktKjvnplmzCfQw5mvJNguVkBK8/k56VfzisHg==
X-Received: by 2002:a17:90a:1d6:: with SMTP id 22mr9371574pjd.214.1631532340262;
        Mon, 13 Sep 2021 04:25:40 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id v17sm6627359pff.6.2021.09.13.04.25.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 04:25:39 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: vmd: assign a number to each vmd controller
Date:   Mon, 13 Sep 2021 19:25:37 +0800
Message-Id: <1631532337-12473-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

If the system has multiple vmd controllers, the current vmd driver
does not assign a number to each controller, so when analyzing the
interrupt through /proc/interrupt, the names of all controllers are
the same, which is not very convenient for problem analysis. Here,
try to assign a number to each vmd controller.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
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

