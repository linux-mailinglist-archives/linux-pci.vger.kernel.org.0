Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB796F6A13
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEDLfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDLfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:35:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF15F44B5;
        Thu,  4 May 2023 04:35:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 981BD66032D1;
        Thu,  4 May 2023 12:35:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683200117;
        bh=oYDe/VXfJGa+IBEXNZZL8Wjnx24xldbrD++GRNp7wf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSY9a5QIjnOdxPA/nZt/sT2nUHh81bauNVLFJmH9cSX+HGZD4TACaot8H0bR8D23L
         ySp40BxxMq+oXusx1z8QEq56Gcy6IwgsSYbl8bEpH/6dpRebt9lznmGBTTtk5NwX7t
         Q97j8u24JQfFH/K1/zSpXU+s4RP/+JZxhw8kwvCbM7UbgSaF4yGncb6JdbFCGJeyT4
         8e5GVRzCvv0KNWKK1hyjwS5jZjNxCCYUbkYdBMXSbjTqoFjyrBF0JuwESQRoU6weIn
         8ioIlSAUata3gYwRmFZLJMd1FKYksDMex1zYtBGsgfRQruvoPRAy3A1jJ15lIPheG4
         qcjCPyNSKplQQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     ryder.lee@mediatek.com
Cc:     jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PCI: mediatek-gen3: Stop acquiring spinlocks in {suspend,resume}_noirq
Date:   Thu,  4 May 2023 13:35:08 +0200
Message-Id: <20230504113509.184633-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
References: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In mtk_pcie_suspend_noirq() and mtk_pcie_resume_noirq() we are,
respectively, disabling and enabling generation of interrupts and
then saving and restoring the enabled interrupts register: since
we're using noirq PM callbacks, that can be safely done without
holding any spin lock.

That was noticed because of, and solves, the following issue:

<4>[   74.185982] ========================================================
<4>[   74.192629] WARNING: possible irq lock inversion dependency detected
<4>[   74.199276] 6.3.0-next-20230428+ #51 Tainted: G        W
<4>[   74.205664] --------------------------------------------------------
<4>[   74.212309] systemd-sleep/809 just changed the state of lock:
<4>[   74.218347] ffff65a5c34c65a0 (&pcie->irq_lock){+...}-{2:2}, at: mtk_pcie_resume+0x50/0xa8
<4>[   74.226870] but this lock was taken by another, HARDIRQ-safe lock in the past:
<4>[   74.234389]  (&irq_desc_lock_class){-.-.}-{2:2}
<4>[   74.234409]
<4>[   74.234409]
<4>[   74.234409] and interrupts could create inverse lock ordering between them.
<4>[   74.234409]
<4>[   74.251704]
<4>[   74.251704] other info that might help us debug this:
<4>[   74.258785]  Possible interrupt unsafe locking scenario:
<4>[   74.258785]
<4>[   74.266126]        CPU0                    CPU1
<4>[   74.270942]        ----                    ----
<4>[   74.275758]   lock(&pcie->irq_lock);
<4>[   74.279627]                                local_irq_disable();
<4>[   74.285836]                                lock(&irq_desc_lock_class);
<4>[   74.292667]                                lock(&pcie->irq_lock);
<4>[   74.299061]   <Interrupt>
<4>[   74.301960]     lock(&irq_desc_lock_class);
<4>[   74.306438]
<4>[   74.306438]  *** DEADLOCK ***

Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b8612ce5f4d0..52f52ca5db71 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -963,8 +963,6 @@ static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 
-	raw_spin_lock(&pcie->irq_lock);
-
 	pcie->saved_irq_state = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
 
 	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
@@ -973,16 +971,12 @@ static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
 		msi_set->saved_irq_state = readl_relaxed(msi_set->base +
 					   PCIE_MSI_SET_ENABLE_OFFSET);
 	}
-
-	raw_spin_unlock(&pcie->irq_lock);
 }
 
 static void mtk_pcie_irq_restore(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 
-	raw_spin_lock(&pcie->irq_lock);
-
 	writel_relaxed(pcie->saved_irq_state, pcie->base + PCIE_INT_ENABLE_REG);
 
 	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
@@ -991,8 +985,6 @@ static void mtk_pcie_irq_restore(struct mtk_gen3_pcie *pcie)
 		writel_relaxed(msi_set->saved_irq_state,
 			       msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
 	}
-
-	raw_spin_unlock(&pcie->irq_lock);
 }
 
 static int mtk_pcie_turn_off_link(struct mtk_gen3_pcie *pcie)
-- 
2.40.1

