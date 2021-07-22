Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0722E3D2F25
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhGVUtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 16:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhGVUtC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 16:49:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B2760E8F;
        Thu, 22 Jul 2021 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626989377;
        bh=4jqIwftB8QisJXWGSPJ0If22UZlDrJUNrwHxBUaRVCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hC4lDdYw+PN5SpuNdN/en3tTRWApgc38vpxETRbo6AChyYrzBTRmJ7r4fxXh0pxnv
         qZHE32rQVt55ik/dHPyC6qInDKzH7Dk4Id2FP5gD4wEmdoI0vQO378VuNv3qxqGf8D
         lbuWqxjn87W++iiM+WoUxwhTAaVRUl08/4vOspisITLL96j9UvDJwWWZh0doTFsrfZ
         FICWoXI4M1HcP9iZC5OBWItLlJManEgZt8jAg0GdRNUHuaJx2Cj9qu2xosHCYrDtD3
         QpyaSg4nV+5K3yFT7Zw7nepcW21cAuFhjiNOc82+Ek449iiVQyiF33Awx3tqzHx+ZF
         ytyRA1nndJ1tw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/9] PCI/VGA: Remove empty vga_arb_device_card_gone()
Date:   Thu, 22 Jul 2021 16:29:15 -0500
Message-Id: <20210722212920.347118-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722212920.347118-1-helgaas@kernel.org>
References: <20210722212920.347118-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

vga_arb_device_card_gone() has always been empty.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vgaarb.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index e4153ab70481..c984c76b3fd7 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -104,8 +104,6 @@ static int vga_str_to_iostate(char *buf, int str_size, int *io_state)
 /* this is only used a cookie - it should not be dereferenced */
 static struct pci_dev *vga_default;
 
-static void vga_arb_device_card_gone(struct pci_dev *pdev);
-
 /* Find somebody in our list */
 static struct vga_device *vgadev_find(struct pci_dev *pdev)
 {
@@ -741,10 +739,6 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 	/* Remove entry from list */
 	list_del(&vgadev->list);
 	vga_count--;
-	/* Notify userland driver that the device is gone so it discards
-	 * it's copies of the pci_dev pointer
-	 */
-	vga_arb_device_card_gone(pdev);
 
 	/* Wake up all possible waiters */
 	wake_up_all(&vga_wait_queue);
@@ -994,9 +988,7 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 	if (lbuf == NULL)
 		return -ENOMEM;
 
-	/* Shields against vga_arb_device_card_gone (pci_dev going
-	 * away), and allows access to vga list
-	 */
+	/* Protects vga_list */
 	spin_lock_irqsave(&vga_lock, flags);
 
 	/* If we are targeting the default, use it */
@@ -1013,8 +1005,6 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 		/* Wow, it's not in the list, that shouldn't happen,
 		 * let's fix us up and return invalid card
 		 */
-		if (pdev == priv->target)
-			vga_arb_device_card_gone(pdev);
 		spin_unlock_irqrestore(&vga_lock, flags);
 		len = sprintf(lbuf, "invalid");
 		goto done;
@@ -1358,10 +1348,6 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static void vga_arb_device_card_gone(struct pci_dev *pdev)
-{
-}
-
 /*
  * callback any registered clients to let them know we have a
  * change in VGA cards
-- 
2.25.1

