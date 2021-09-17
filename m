Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D75F40F8E2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhIQNOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhIQNOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 09:14:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51DC061574;
        Fri, 17 Sep 2021 06:13:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bb10so6186843plb.2;
        Fri, 17 Sep 2021 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FBrHkdDFgDeUY2FRSkRFiuVQWo8Nzcqn0H3oAosMn+Y=;
        b=CaFzcNRN+EwQKT2wXl8c22D1LVotGKKNPTsVr1ej+Rxi7LQcYfYAyOBThVt7FTJpji
         IQAV25UGx0R1Rc4zgdCN4lEk5nXDKfdbPoAHpNOnE8ktmJlzHu8eEEoSZVo7am2bsyRb
         f50sRDgS4dpE0fHlkR2QoJ4O8L+xSkbE0/vkmeO3CYEwuJguNwpQhkG8GS+6X4yDzbhp
         QuE0u3LUnTFwVJEYe2wSq2aOxOmht9lGppbY5OADxXB35PoE+79DrDpuxEeoTC9gZMKm
         5S5YNRJNTpNkoG34NdU170cI71gSdzTzTw6ss/yE3Zp3PtcPt5qz57i18kisgoLeS2bS
         zZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FBrHkdDFgDeUY2FRSkRFiuVQWo8Nzcqn0H3oAosMn+Y=;
        b=CE3qtq5VWvP8//aVl/wD+D2PFQNkP9KecbKVZYIqceitwmt4Qon3rd2bPhrUvAfxbW
         MASR8+NowlUSmgMh0L/VZkupRdxeapoLAFEeW6f82DIZ/lNbHJxuD0BF1qwEA7pFYHKQ
         3CI5YaDacJL9nr5FYxnsdgFp4NiC0VxlMs7Z/UpvG8uRZNGPaw0Ydupi5SCsDIkADUXC
         tZmtOL6VUVt6DaHBOVBUaOTUOQEO6cYtyLRAxBDYxQSD2gSxXKofcu150u78kiEuo+9U
         MDFJtRf8dwfSvv/7CxAlMJCTTxTV45MpB6uoK73wLvlhII9mRSbu888zZl9VjDEi7cnI
         E1Rg==
X-Gm-Message-State: AOAM531dZkHV1y+uL7NM5I1OeNoC1hGJdejZbp7Qusa0cvWj+hc84Rug
        sg2i5AaKTbtv9kn79VI7StE=
X-Google-Smtp-Source: ABdhPJyORjFEmh2uPdBOkkqFvUoP1WkFrNw/7pajnErIP+FfkjquvjZTh7MgyDGv24bzVIkKGmFPgg==
X-Received: by 2002:a17:902:760b:b0:13b:122:5ff0 with SMTP id k11-20020a170902760b00b0013b01225ff0mr9496008pll.22.1631884407845;
        Fri, 17 Sep 2021 06:13:27 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id e11sm6363901pfn.49.2021.09.17.06.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 06:13:27 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     helgaas@kernel.org, kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI: vmd: Assign a number to each VMD controller
Date:   Fri, 17 Sep 2021 21:13:24 +0800
Message-Id: <1631884404-24141-1-git-send-email-brookxu.cn@gmail.com>
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
v4: remove out label.
v3: update subject line.
v2: update commit message.

 drivers/pci/controller/vmd.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e3fcdfe..feaab36 100644
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
@@ -779,18 +783,32 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
+	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
+	if (vmd->instance < 0)
+		return vmd->instance;
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
@@ -799,11 +817,16 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
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
+	return err;
 }
 
 static void vmd_cleanup_srcu(struct vmd_dev *vmd)
@@ -824,6 +847,8 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
+	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	kfree(vmd->name);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -848,7 +873,7 @@ static int vmd_resume(struct device *dev)
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

