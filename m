Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1840BDFD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 05:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhIODJO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 23:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhIODJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 23:09:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C7C061762;
        Tue, 14 Sep 2021 20:07:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso1174374pjb.3;
        Tue, 14 Sep 2021 20:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UCwblvNT3ZcUz7Ev8zowTO/hTrrLiEljqD9fFd2v9eI=;
        b=eFwtvfthuxwStEM4MaPyJasv/63mtPflK/0aFLSWA7jPLBP/+ob4gdQb2d/pJ6z/BM
         IcwbmROAHG7fKrLFKQDob8q3pE4ZMvdqDYTseyMRjpo2OROlgS6STtk9pGEgNvLjk6f/
         cXxUV6YE0nrtg4YfUHHzNebJOo9F/K6aKwqo7hTUJzmEyNaRDRCriRPS3ubsvpSV34xM
         HjRYarNIDlJtR5hZKho7l0v70FUYwdTpDttl0xN+1xmIorlQ8Cps2VhKSSysJK9vlioq
         ojba0QkFnh56T9FJDES1pp3hC/Fnv7gupqrCw8JEvoPY2BMirr4gakORA251AH+bX1xU
         0Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UCwblvNT3ZcUz7Ev8zowTO/hTrrLiEljqD9fFd2v9eI=;
        b=jUu/WSaBqVIKgF6euHXQ5KlP1kSo5ZDs6NGYb0S2c+QrauRpvMKrVkT0abR1YcUDlo
         9DgeKrGEMAccrDZzKYVkH8xCnKnPTj6sI3Lr40ss5quxPe7Y18CLmO15OIFds5jkx9Hs
         0SsPzxn2iRk+u81X4BcCO1Zgl8ViyFXYhdJrHPshcnXo9Vzt3nhQm0USMsw19ONfKmcC
         Z1NULe/syEovH3FWAuLBE+1xQkCxLOWDaJIPJ9QnHFgvcxNfM2tLk5oSR2Ls8QiR8c3a
         C8BKADbJ45eyQr8du5I6DVu1bVuy+yiQT6rJegqe/mpd62nj+EyKzhmd39LFY66btdfw
         VaQA==
X-Gm-Message-State: AOAM532Ai7Mhu5D2XoNJnaz0+mPE5Zwss1yaKHs7PPb9W93Fs5syJHHx
        M3WvqWH5lNwTFZKBzMKgxrk=
X-Google-Smtp-Source: ABdhPJwWOwTcx8O1j9hUCGwNqd0TI+eqka62iUZFyeinCzK9V9MoGhzdE/JSfpOh05ye0FmQ+rnswA==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr5769785pjb.71.1631675275948;
        Tue, 14 Sep 2021 20:07:55 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id v7sm2795433pjg.34.2021.09.14.20.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 20:07:55 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: vmd: Assign a number to each VMD controller
Date:   Wed, 15 Sep 2021 11:07:53 +0800
Message-Id: <1631675273-1934-1-git-send-email-brookxu.cn@gmail.com>
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
---

v3: Update subject line.
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

