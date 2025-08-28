Return-Path: <linux-pci+bounces-35005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F9B39D38
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7A97BDE44
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC830F80A;
	Thu, 28 Aug 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTaHD5sc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E423A9A0;
	Thu, 28 Aug 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383939; cv=none; b=JUSOMVdX6lLh7F0MHLzNaSbehKw72TgWJOJkbF3ntaLtOnC9BrXBN7W5qaKeuAp1c1OB05z9niFoVpGWXoob3cWrv3/tn5mg3mKwLlNPkodeyojqByRr/YpxRv4S6u92abABZJt0zyPNVefvAn0mdAmJrFtlapOrxpYufymn1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383939; c=relaxed/simple;
	bh=8XkDUHEI81AMaOII2j2nixGtBB1Sy2s+g+XRsmVbal0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmbgIK4ja/Fs68hOOmIiaoZIbNnnd3JxOB/JfXK5l0fMTzprZ5+J+pJs4bcsvWDwFNB0nc9f0jpgprvYTIzLvckXNQqgKA+sI0ydcOHXh/zuNvgJnHIwhD9/us7lfmFLSeWD4Bt4J2u2q3aF7Csak+jfJ7A03/5Jxwp52uhZKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTaHD5sc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso5675775e9.0;
        Thu, 28 Aug 2025 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756383936; x=1756988736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJhXsEN4Q2OnvFn5r5d6ITdNmPJSOFLb4TThxFWXwmY=;
        b=jTaHD5scP+JfyInLdhK0J1vdV4Thhw41ktxOf/QHA2FB7YNYhOYl9iuXdgkZrnvrzY
         BKKRfY4guT37vplwmi4GcAT+hf4LZ1jufC9CNyIHdUzMlgERfT3gTXJoJskW8jcPhQp7
         uG4H0sOTB2Zmrdi1Whdn4/iDuxrrtSpcOhXBiA/Xa6gW55jepLV/9MIWZwRyf1N16jGb
         cgckicfPYG6p63PlJPJ3xqOwo12tBiQ+0lwN6+U06wOZVQa+bu8ve8zf7j2LFCwMfJYa
         mw9WhmzaryzZoldpcrswCBLFyVWybqL7s4v5xrST3Llzv6YpFD7B7c2MmUmznexTtaS9
         WjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383936; x=1756988736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJhXsEN4Q2OnvFn5r5d6ITdNmPJSOFLb4TThxFWXwmY=;
        b=rKZAKsZn1CVboWkcEAG1opd4aLZrayeHy1M37IaNHlsyL1PAcN4EFVS87/IRDMWK2v
         h7BbV1p8icGi8pD37pvsBe6RfIWdCa3YmfqbCxU6V8uvmPG1/s1xWdft286BEmDK0Csq
         5UKRwcdgCJW8m17NX/O7mz3f6cqS9X5rsnPIBAWd4+SRHN1WKKYJJpFUJIJcNs3iBCGe
         yoQQmCcq2imiU9VZKMdEoeTh9pCpcNAooitrD2ZcMMpdUm6j3mxpcSujKyW/Qi+cvXUg
         uCCv7D1RErFCpkOmZ5zxw2MenB6v9POlhFxH5K+fldx6NWoYukLbCqFVPSCdfgj0kh/p
         E1HA==
X-Forwarded-Encrypted: i=1; AJvYcCVrOeRUyWIt+k0tKAFmRWF0ELs9JQ2vbd8EZ+1ymWlTDCAMlrJcvU4YweMxvrAGTpunz7LJipXYWbrWv6k=@vger.kernel.org, AJvYcCWW9s5JysodRzJj40VwyFh5cKnhuRVRFw9LgK5C7rOpntSopLIVcEl1snhTg5znEtQSv6DBILtg3a5D@vger.kernel.org
X-Gm-Message-State: AOJu0YymLsEx7FC7jGK6whMI5XvglTwJzrdF9WuLWEzjdOvZbe4DMxQS
	skLNJ9Y6MAxGxdqaepkWr2e0srNA6f0+zWG8VtlurEhCNJwEAI6mrY3/
X-Gm-Gg: ASbGncv09dNanFVy0rntztEIwA/VCsU/XMRnd9233odPtmC3Z+uFwrPFsO/EYsBFkaJ
	Nt2HlEAFd5c64b9xWx6SKloP0kOpCjOIzB22LIwWEQSR6MOkGihck8JMpCwRr/68s4FVh92zH5+
	1+VqGH9do3NC6Jl5zJ3KY1M4aLnzRJY8J+DSpwkxAyxw9/6mzPxvVvBstIwIL/i0e6rrPk35A98
	E40OO1T4trQsRUj0mkPErWZqDzyg57y6/kEnu8GJW2DOBiBBtXEf7aMg5bHXOLOf51SrkHS9KAG
	AgD5lOYhlZPP0OppR+buxlwvkE/qJcKgEDVoCqM44S4hrfByrld0k4rFD9HBdebrxNum7eHJ6zv
	JrqQbas7IR1YH2wlRYVU=
X-Google-Smtp-Source: AGHT+IGHWM3XiS6zwR6fakBXh4xaK81UnW/w5K7B0co+OWvrA9Bv5i8oMLzCixpqBaDqRf3hr0ZwOA==
X-Received: by 2002:a05:600c:4715:b0:458:f70d:ebd7 with SMTP id 5b1f17b1804b1-45b517c2f25mr188117125e9.20.1756383935370;
        Thu, 28 Aug 2025 05:25:35 -0700 (PDT)
Received: from pc.. ([102.208.164.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm72240625e9.14.2025.08.28.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:25:34 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: bhelgaas@google.com
Cc: julia.lawall@inria.fr,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] PCI/VGA: Replace manual locks with lock guards
Date: Thu, 28 Aug 2025 15:25:24 +0300
Message-ID: <20250828122524.1233749-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from explicit lock/unlock pairs to scoped lock guards.
This simplifies error handling and improves code readability.

Generated-by: Coccinelle SmPL

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/pci/vgaarb.c | 87 ++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..6a00ee00e362 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -501,8 +501,6 @@ EXPORT_SYMBOL(vga_get);
 static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
 {
 	struct vga_device *vgadev;
-	unsigned long flags;
-	int rc = 0;
 
 	vga_check_first_use();
 
@@ -511,17 +509,13 @@ static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
 		pdev = vga_default_device();
 	if (pdev == NULL)
 		return 0;
-	spin_lock_irqsave(&vga_lock, flags);
+	guard(spinlock_irqsave)(&vga_lock);
 	vgadev = vgadev_find(pdev);
-	if (vgadev == NULL) {
-		rc = -ENODEV;
-		goto bail;
-	}
+	if (vgadev == NULL)
+		return -ENODEV;
 	if (__vga_tryget(vgadev, rsrc))
-		rc = -EBUSY;
-bail:
-	spin_unlock_irqrestore(&vga_lock, flags);
-	return rc;
+		return -EBUSY;
+	return 0;
 }
 
 /**
@@ -537,20 +531,17 @@ static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
 void vga_put(struct pci_dev *pdev, unsigned int rsrc)
 {
 	struct vga_device *vgadev;
-	unsigned long flags;
 
 	/* The caller should check for this, but let's be sure */
 	if (pdev == NULL)
 		pdev = vga_default_device();
 	if (pdev == NULL)
 		return;
-	spin_lock_irqsave(&vga_lock, flags);
+	guard(spinlock_irqsave)(&vga_lock);
 	vgadev = vgadev_find(pdev);
 	if (vgadev == NULL)
-		goto bail;
+		return;
 	__vga_put(vgadev, rsrc);
-bail:
-	spin_unlock_irqrestore(&vga_lock, flags);
 }
 EXPORT_SYMBOL(vga_put);
 
@@ -912,29 +903,20 @@ static void __vga_set_legacy_decoding(struct pci_dev *pdev,
 				      bool userspace)
 {
 	struct vga_device *vgadev;
-	unsigned long flags;
 
 	decodes &= VGA_RSRC_LEGACY_MASK;
 
-	spin_lock_irqsave(&vga_lock, flags);
+	guard(spinlock_irqsave)(&vga_lock);
 	vgadev = vgadev_find(pdev);
 	if (vgadev == NULL)
-		goto bail;
+		return;
 
 	/* Don't let userspace futz with kernel driver decodes */
 	if (userspace && vgadev->set_decode)
-		goto bail;
+		return;
 
 	/* Update the device decodes + counter */
 	vga_update_device_decodes(vgadev, decodes);
-
-	/*
-	 * XXX If somebody is going from "doesn't decode" to "decodes"
-	 * state here, additional care must be taken as we may have pending
-	 * ownership of non-legacy region.
-	 */
-bail:
-	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
 /**
@@ -981,14 +963,13 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
 int vga_client_register(struct pci_dev *pdev,
 		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
 {
-	unsigned long flags;
 	struct vga_device *vgadev;
 
-	spin_lock_irqsave(&vga_lock, flags);
-	vgadev = vgadev_find(pdev);
-	if (vgadev)
-		vgadev->set_decode = set_decode;
-	spin_unlock_irqrestore(&vga_lock, flags);
+	scoped_guard (spinlock_irqsave, &vga_lock) {
+		vgadev = vgadev_find(pdev);
+		if (vgadev)
+			vgadev->set_decode = set_decode;
+	}
 	if (!vgadev)
 		return -ENODEV;
 	return 0;
@@ -1411,7 +1392,6 @@ static __poll_t vga_arb_fpoll(struct file *file, poll_table *wait)
 static int vga_arb_open(struct inode *inode, struct file *file)
 {
 	struct vga_arb_private *priv;
-	unsigned long flags;
 
 	pr_debug("%s\n", __func__);
 
@@ -1421,9 +1401,8 @@ static int vga_arb_open(struct inode *inode, struct file *file)
 	spin_lock_init(&priv->lock);
 	file->private_data = priv;
 
-	spin_lock_irqsave(&vga_user_lock, flags);
-	list_add(&priv->list, &vga_user_list);
-	spin_unlock_irqrestore(&vga_user_lock, flags);
+	scoped_guard (spinlock_irqsave, &vga_user_lock)
+		list_add(&priv->list, &vga_user_list);
 
 	/* Set the client's lists of locks */
 	priv->target = vga_default_device(); /* Maybe this is still null! */
@@ -1438,25 +1417,25 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 {
 	struct vga_arb_private *priv = file->private_data;
 	struct vga_arb_user_card *uc;
-	unsigned long flags;
 	int i;
 
 	pr_debug("%s\n", __func__);
 
-	spin_lock_irqsave(&vga_user_lock, flags);
-	list_del(&priv->list);
-	for (i = 0; i < MAX_USER_CARDS; i++) {
-		uc = &priv->cards[i];
-		if (uc->pdev == NULL)
-			continue;
-		vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt == %d, uc->mem_cnt == %d\n",
-			uc->io_cnt, uc->mem_cnt);
-		while (uc->io_cnt--)
-			vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);
-		while (uc->mem_cnt--)
-			vga_put(uc->pdev, VGA_RSRC_LEGACY_MEM);
+	scoped_guard (spinlock_irqsave, &vga_user_lock) {
+		list_del(&priv->list);
+		for (i = 0; i < MAX_USER_CARDS; i++) {
+			uc = &priv->cards[i];
+			if (uc->pdev == NULL)
+				continue;
+			vgaarb_dbg(&uc->pdev->dev,
+				   "uc->io_cnt == %d, uc->mem_cnt == %d\n",
+				   uc->io_cnt, uc->mem_cnt);
+			while (uc->io_cnt--)
+				vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);
+			while (uc->mem_cnt--)
+				vga_put(uc->pdev, VGA_RSRC_LEGACY_MEM);
+		}
 	}
-	spin_unlock_irqrestore(&vga_user_lock, flags);
 
 	kfree(priv);
 
@@ -1470,7 +1449,6 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 static void vga_arbiter_notify_clients(void)
 {
 	struct vga_device *vgadev;
-	unsigned long flags;
 	unsigned int new_decodes;
 	bool new_state;
 
@@ -1479,7 +1457,7 @@ static void vga_arbiter_notify_clients(void)
 
 	new_state = (vga_count > 1) ? false : true;
 
-	spin_lock_irqsave(&vga_lock, flags);
+	guard(spinlock_irqsave)(&vga_lock);
 	list_for_each_entry(vgadev, &vga_list, list) {
 		if (vgadev->set_decode) {
 			new_decodes = vgadev->set_decode(vgadev->pdev,
@@ -1487,7 +1465,6 @@ static void vga_arbiter_notify_clients(void)
 			vga_update_device_decodes(vgadev, new_decodes);
 		}
 	}
-	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
 static int pci_notify(struct notifier_block *nb, unsigned long action,
-- 
2.43.0


