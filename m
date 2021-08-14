Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D23EC351
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 16:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhHNOfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbhHNOfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 10:35:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A151C061764;
        Sat, 14 Aug 2021 07:34:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so20414059pjb.0;
        Sat, 14 Aug 2021 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lFF36gbCyatR/DJSKWHXWEEf9HF0HTS77nNO2TP05JU=;
        b=PfauWsjDBY1uZTEP6u1n6JfMsJ6DqV1GX/c8iQ4osN4mt2NalhEZxZMR8UEXxuVOft
         RZ1gZuLfPoEOqmwlQ28Fy+fJtAIS/E7iYDWuMh+FaaL2MpQJHi/xA4HjEh8AYVmGKMXz
         hcPbtIU2OXn7zX2IwBILZEiw1IFApqUOhrQGQgVIEAzxfgNBUCT0FvqS+As3NqOx/fIR
         0SPfQ+2Xj2FldmZqK7+JPfWn+KBolsiPlJhc9UDIST5jj9QEV/tVm/XWsuEuRS4GLqdM
         NLZkuLn3AoZ3yulxPJ6ecErVwnQby2U2yrFpzL+N82WpzTA0GL7fl1Vlccy4mqb+Tfp3
         ETQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lFF36gbCyatR/DJSKWHXWEEf9HF0HTS77nNO2TP05JU=;
        b=Su3kK/VhD9ldJSHoIdwE6nuVDNZ5HXrlexOPJMnw/eSBvf5xPO0DM1PGAWJHwJYP9+
         r2H3kFht1oMqX4JCu4qWYGOFnpzOhEXXktBHvoE5Faiwcx40uE9PSAjMS1Om/+BBd5x3
         UsQKBT58iPByIkTc2RCwLb4j6nR694Mb92gkiEis7SueVxMtGAPw65WTTZgEX9LTrYeC
         pvY3t2eGuPxM8s9/QQN81OE5VAhlrC7AtBCTe65cv0OB5WvmJyNtB1nRoXrPY4PR+W2J
         Ze80VQSJniKM3by6ctTNzcgY5qH2D5mohwI2Xcys2SqDUIlmhDMQRHhmras9AtmNfnC8
         cHwQ==
X-Gm-Message-State: AOAM531sfbuFwKWLeuQkyAwWpCIrcD19IiNnkUSTTCAEytSYLLS32q65
        X05Gk1+33MyspjqB4rg57PY=
X-Google-Smtp-Source: ABdhPJybPrYR3IiHkgFMynWstyRwZTszrb4BQld5sefdKGIyZPTJ00dOZRHIJk3iXv3buUFOWwAxXA==
X-Received: by 2002:a17:90a:ad07:: with SMTP id r7mr7777517pjq.110.1628951658988;
        Sat, 14 Aug 2021 07:34:18 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id v15sm5861437pff.105.2021.08.14.07.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Aug 2021 07:34:18 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: vmd: assign a number to each vmd controller
Date:   Sat, 14 Aug 2021 22:34:16 +0800
Message-Id: <1628951656-17148-1-git-send-email-brookxu.cn@gmail.com>
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

