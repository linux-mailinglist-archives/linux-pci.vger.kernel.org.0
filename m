Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E265485CDE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiAFAH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:07:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41796 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbiAFAHZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 19:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8884E619AC;
        Thu,  6 Jan 2022 00:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B53C36AE9;
        Thu,  6 Jan 2022 00:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427645;
        bh=55uUY3DU+Al2f4mzQBUIMkBQgWRIn5Cls1b0nr4Zsds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cpr/yrL99ZdYakbjuuIPqsR7VcfQEPTQh03YhFahW91+yhZvch6yhAcXwyNS4tJw9
         oek6bTZG8KniYzf8v7ojV3Uf5lOnDAYxpbW5YA/poUJHRIK9hTFDUomzdgYyWC6xsg
         OjSrLXfpwx8e2qJQc8p8QgkVLuHv6+kU+3gngKsbBTqu0lA7ukvBoTbFvayflfEe97
         AiBSSURXAcoesWGbHdvYoGu0/rVP2cHt6E7m7TaR4XHj/FlQUsojRjE2dS6YP94/WA
         cKtjj92wliHJCDmi6DSTEDo2lP+dZDDUqaGLLWQic0VUvt1LHwTPf5CC/uW3HXLFuU
         xzij/ieJE0/6A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 07/10] vgaarb: Remove empty vga_arb_device_card_gone()
Date:   Wed,  5 Jan 2022 18:06:55 -0600
Message-Id: <20220106000658.243509-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106000658.243509-1-helgaas@kernel.org>
References: <20220106000658.243509-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

vga_arb_device_card_gone() has always been empty.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/vgaarb.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index ad548917e602..455cf048fae8 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -123,8 +123,6 @@ static int vga_str_to_iostate(char *buf, int str_size, int *io_state)
 /* this is only used a cookie - it should not be dereferenced */
 static struct pci_dev *vga_default;
 
-static void vga_arb_device_card_gone(struct pci_dev *pdev);
-
 /* Find somebody in our list */
 static struct vga_device *vgadev_find(struct pci_dev *pdev)
 {
@@ -878,10 +876,6 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 	/* Remove entry from list */
 	list_del(&vgadev->list);
 	vga_count--;
-	/* Notify userland driver that the device is gone so it discards
-	 * it's copies of the pci_dev pointer
-	 */
-	vga_arb_device_card_gone(pdev);
 
 	/* Wake up all possible waiters */
 	wake_up_all(&vga_wait_queue);
@@ -1131,9 +1125,7 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 	if (lbuf == NULL)
 		return -ENOMEM;
 
-	/* Shields against vga_arb_device_card_gone (pci_dev going
-	 * away), and allows access to vga list
-	 */
+	/* Protects vga_list */
 	spin_lock_irqsave(&vga_lock, flags);
 
 	/* If we are targeting the default, use it */
@@ -1150,8 +1142,6 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 		/* Wow, it's not in the list, that shouldn't happen,
 		 * let's fix us up and return invalid card
 		 */
-		if (pdev == priv->target)
-			vga_arb_device_card_gone(pdev);
 		spin_unlock_irqrestore(&vga_lock, flags);
 		len = sprintf(lbuf, "invalid");
 		goto done;
@@ -1495,10 +1485,6 @@ static int vga_arb_release(struct inode *inode, struct file *file)
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

