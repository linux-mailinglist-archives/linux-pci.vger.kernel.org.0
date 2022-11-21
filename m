Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92826326D1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKUOuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKUOsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:48:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D35D39EF;
        Mon, 21 Nov 2022 06:42:16 -0800 (PST)
Message-ID: <20221121140049.363858787@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WmdB2qfbbOZDzyPsz/NXt+XoJ1l6mf2vgeHiaNbEoMk=;
        b=3XdDjRAfvWJaoSFapB48hY3JPrLaN/Z7q4sEmU3KSFTXTFycWPRSkgiCbGNjPkuCqDf8Vn
        Z1AaTBpUaFzB4LKR8oIgRN20xnYFmsqV3kt2YF0VFNtPpZII5G/qYVnb1ioagvBSaYlzGP
        n389cx4FFDVw9vew4D6ur3DiIZi7y0fTvtNTxtdbAslCy+DFj9CcwtnsY8RcrfpLG00+6B
        vNQXlt+iLFj406UqJDWPuA5SMmN+W7xXOjTzF8cQ5rYVKpcnObLvPCbYolGRCWOYaq+YAs
        ufrdRiPyckN4LJddBGhbFnq8hy63WzypJX4hRk09L1q3ibFfNAjbUKWtPX3BVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WmdB2qfbbOZDzyPsz/NXt+XoJ1l6mf2vgeHiaNbEoMk=;
        b=4jBwfkJEKdyQ2OzLVskrhNL1aNHEnG09AdIvyb8YAtM+9AjlGulHq05MxUQ4vI0hVPu6lG
        rR6+bZPDs+0smpDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 17/40] irqchip: Convert all platform MSI users to the new API
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:49 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch all the users of the platform MSI domain over to invoke the new
interfaces which branch to the original platform MSI functions when the
irqdomain associated to the caller device does not yet provide MSI parent
functionality.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 drivers/dma/mv_xor_v2.c                     |    8 ++++----
 drivers/dma/qcom/hidma.c                    |    6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    5 +++--
 drivers/mailbox/bcm-flexrm-mailbox.c        |    8 ++++----
 drivers/perf/arm_smmuv3_pmu.c               |    4 ++--
 5 files changed, 16 insertions(+), 15 deletions(-)

--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -764,8 +764,8 @@ static int mv_xor_v2_probe(struct platfo
 			goto disable_reg_clk;
 	}
 
-	ret = platform_msi_domain_alloc_irqs(&pdev->dev, 1,
-					     mv_xor_v2_set_msi_msg);
+	ret = platform_device_ims_init_and_alloc_irqs(&pdev->dev, 1,
+						      mv_xor_v2_set_msi_msg);
 	if (ret)
 		goto disable_clk;
 
@@ -868,7 +868,7 @@ static int mv_xor_v2_probe(struct platfo
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 free_msi_irqs:
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_ims_free_irqs_all(&pdev->dev);
 disable_clk:
 	clk_disable_unprepare(xor_dev->clk);
 disable_reg_clk:
@@ -888,7 +888,7 @@ static int mv_xor_v2_remove(struct platf
 
 	devm_free_irq(&pdev->dev, xor_dev->irq, xor_dev);
 
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_ims_free_irqs_all(&pdev->dev);
 
 	tasklet_kill(&xor_dev->irq_tasklet);
 
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -697,7 +697,7 @@ static void hidma_free_msis(struct hidma
 			devm_free_irq(dev, virq, &dmadev->lldev);
 	}
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 #endif
 }
 
@@ -707,8 +707,8 @@ static int hidma_request_msi(struct hidm
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	int rc, i, virq;
 
-	rc = platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
-					    hidma_write_msi_msg);
+	rc = platform_device_ims_init_and_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
+						     hidma_write_msi_msg);
 	if (rc)
 		return rc;
 
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3122,7 +3122,8 @@ static int arm_smmu_update_gbpa(struct a
 static void arm_smmu_free_msis(void *data)
 {
 	struct device *dev = data;
-	platform_msi_domain_free_irqs(dev);
+
+	platform_device_ims_free_irqs_all(dev);
 }
 
 static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -3163,7 +3164,7 @@ static void arm_smmu_setup_msis(struct a
 	}
 
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
-	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
+	ret = platform_device_ims_init_and_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
 		return;
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1591,8 +1591,8 @@ static int flexrm_mbox_probe(struct plat
 	}
 
 	/* Allocate platform MSIs for each ring */
-	ret = platform_msi_domain_alloc_irqs(dev, mbox->num_rings,
-						flexrm_mbox_msi_write);
+	ret = platform_device_ims_init_and_alloc_irqs(dev, mbox->num_rings,
+						      flexrm_mbox_msi_write);
 	if (ret)
 		goto fail_destroy_cmpl_pool;
 
@@ -1645,7 +1645,7 @@ static int flexrm_mbox_probe(struct plat
 
 fail_free_debugfs_root:
 	debugfs_remove_recursive(mbox->root);
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 fail_destroy_cmpl_pool:
 	dma_pool_destroy(mbox->cmpl_pool);
 fail_destroy_bd_pool:
@@ -1661,7 +1661,7 @@ static int flexrm_mbox_remove(struct pla
 
 	debugfs_remove_recursive(mbox->root);
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 
 	dma_pool_destroy(mbox->cmpl_pool);
 	dma_pool_destroy(mbox->bd_pool);
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -685,7 +685,7 @@ static void smmu_pmu_free_msis(void *dat
 {
 	struct device *dev = data;
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 }
 
 static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -715,7 +715,7 @@ static void smmu_pmu_setup_msi(struct sm
 	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
 		return;
 
-	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
+	ret = platform_device_ims_init_and_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs\n");
 		return;

