Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD1E4075E3
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhIKJiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 05:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235481AbhIKJiK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Sep 2021 05:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 463EA61153;
        Sat, 11 Sep 2021 09:36:54 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH V5 08/11] PCI/VGA: Remove empty vga_arb_device_card_gone()
Date:   Sat, 11 Sep 2021 17:30:53 +0800
Message-Id: <20210911093056.1555274-9-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210911093056.1555274-1-chenhuacai@loongson.cn>
References: <20210911093056.1555274-1-chenhuacai@loongson.cn>
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
index 5a008d190ed8..1a829cbacbc8 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -122,8 +122,6 @@ static int vga_str_to_iostate(char *buf, int str_size, int *io_state)
 /* this is only used a cookie - it should not be dereferenced */
 static struct pci_dev *vga_default;
 
-static void vga_arb_device_card_gone(struct pci_dev *pdev);
-
 /* Find somebody in our list */
 static struct vga_device *vgadev_find(struct pci_dev *pdev)
 {
@@ -825,10 +823,6 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 	/* Remove entry from list */
 	list_del(&vgadev->list);
 	vga_count--;
-	/* Notify userland driver that the device is gone so it discards
-	 * it's copies of the pci_dev pointer
-	 */
-	vga_arb_device_card_gone(pdev);
 
 	/* Wake up all possible waiters */
 	wake_up_all(&vga_wait_queue);
@@ -1078,9 +1072,7 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 	if (lbuf == NULL)
 		return -ENOMEM;
 
-	/* Shields against vga_arb_device_card_gone (pci_dev going
-	 * away), and allows access to vga list
-	 */
+	/* Protects vga_list */
 	spin_lock_irqsave(&vga_lock, flags);
 
 	/* If we are targeting the default, use it */
@@ -1097,8 +1089,6 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 		/* Wow, it's not in the list, that shouldn't happen,
 		 * let's fix us up and return invalid card
 		 */
-		if (pdev == priv->target)
-			vga_arb_device_card_gone(pdev);
 		spin_unlock_irqrestore(&vga_lock, flags);
 		len = sprintf(lbuf, "invalid");
 		goto done;
@@ -1442,10 +1432,6 @@ static int vga_arb_release(struct inode *inode, struct file *file)
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
2.27.0

