Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23C3E3BE0
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhHHRUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 13:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHRUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 13:20:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191D5C061760
        for <linux-pci@vger.kernel.org>; Sun,  8 Aug 2021 10:20:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f5so2404884wrm.13
        for <linux-pci@vger.kernel.org>; Sun, 08 Aug 2021 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65E1bA4oCNTLY3YGhSWBcoGT7k6EVcPa7tZb07l1a80=;
        b=G3aJVEkRRex0jYOsfYHT46CO1UrOiFtenAdWwUdYgQD4ZyPoekAmB+7QKo5tUVfZes
         0GDq3KATYolCD/ieEG2gXx5iQvgqx8ZXTdFhrNu6AVTzCfRLxnOwBkP7cFruiQ18IvAn
         3/PtbJHeVQgc45mzAGAM/2jp3iNwpqz5qc8FEX85sQ3EfobsiYpFtOUpUxLHHVOIbxRS
         /U6aD8M3ZA4ZFDVnA4S1Q9YxerG9EjPZRK1uRo9kLIH3C9lzXWNzjEeVW+dOu1DKW6/R
         94ke4VXtTIJkr3WgarvNP/o2RiM6CKjzphz3nKMwnFCAR6m4cP5IfC5LzORZrh0LDgNu
         rJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65E1bA4oCNTLY3YGhSWBcoGT7k6EVcPa7tZb07l1a80=;
        b=pLUr/lyVLkk2E4xhw8Ve1wf4rzV4yCmWiRgtkgfBnQV1IemP4rqbc/GleOGnZ2x4xh
         gWL+QaaQjaNmuCL/577LfzSCIaXyNcP90XqXvgAU9PbBGMGNJN7lygLF+Q2hgGZ9fshA
         Fz7gTC/nYajKeqzRDkLfUPhLadsJToNY4eUD7Wmwv84Z+EFfRyVr2XjaC4zuRqthqc3D
         LwvWrRQvpLYAliVGUZmNTbEws+E6ZejBdiVaUap69AOjPzw2imH4zf1mEBrkgoKbzy0C
         eVpDFjTk9zNeBYb6Zv9TjCiajhTyuIMQihm3X0q0hvPjrbSIF5Cmubg5y8gvWa81f35H
         Vjvg==
X-Gm-Message-State: AOAM530yIQGahDreYFpinZOcQ7kFyUIq2i2myaX0u06IKBYEM3tRSpfZ
        e5Aqp9varPHhBsKsHGG/4yLUgQdOlQSd8A==
X-Google-Smtp-Source: ABdhPJy6/tn9lPwY1GkBZvpSEJeCdmbMx3fdFY4125sBeCN6GWwq0Px/QA2tmjX1YiJ//327UXcrbQ==
X-Received: by 2002:a5d:58da:: with SMTP id o26mr1747858wrf.140.1628443208507;
        Sun, 08 Aug 2021 10:20:08 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:7101:8b48:5eab:cb5f? (p200300ea8f10c20071018b485eabcb5f.dip0.t-ipconnect.de. [2003:ea:8f10:c200:7101:8b48:5eab:cb5f])
        by smtp.googlemail.com with ESMTPSA id z5sm18062757wmp.26.2021.08.08.10.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:20:08 -0700 (PDT)
Subject: [PATCH 2/6] PCI/VPD: Remove struct pci_vpd_ops
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Message-ID: <b2532a41-df8b-860f-461f-d5c066c819d0@gmail.com>
Date:   Sun, 8 Aug 2021 19:20:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Code can be significantly simplified by removing struct pci_vpd_ops and
avoiding the indirect calls.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 90 ++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index e87f299ee..6a0d617b2 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -13,13 +13,7 @@
 
 /* VPD access through PCI 2.2+ VPD capability */
 
-struct pci_vpd_ops {
-	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-};
-
 struct pci_vpd {
-	const struct pci_vpd_ops *ops;
 	struct mutex	lock;
 	unsigned int	len;
 	u8		cap;
@@ -123,11 +117,16 @@ static int pci_vpd_wait(struct pci_dev *dev, bool set)
 static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			    void *arg)
 {
-	struct pci_vpd *vpd = dev->vpd;
+	struct pci_vpd *vpd;
 	int ret = 0;
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
+	if (!dev || !dev->vpd)
+		return -ENODEV;
+
+	vpd = dev->vpd;
+
 	if (pos < 0)
 		return -EINVAL;
 
@@ -189,11 +188,16 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 			     const void *arg)
 {
-	struct pci_vpd *vpd = dev->vpd;
+	struct pci_vpd *vpd;
 	const u8 *buf = arg;
 	loff_t end = pos + count;
 	int ret = 0;
 
+	if (!dev || !dev->vpd)
+		return -ENODEV;
+
+	vpd = dev->vpd;
+
 	if (pos < 0 || (pos & 3) || (count & 3))
 		return -EINVAL;
 
@@ -238,44 +242,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	return ret ? ret : count;
 }
 
-static const struct pci_vpd_ops pci_vpd_ops = {
-	.read = pci_vpd_read,
-	.write = pci_vpd_write,
-};
-
-static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
-			       void *arg)
-{
-	struct pci_dev *tdev = pci_get_func0_dev(dev);
-	ssize_t ret;
-
-	if (!tdev)
-		return -ENODEV;
-
-	ret = pci_read_vpd(tdev, pos, count, arg);
-	pci_dev_put(tdev);
-	return ret;
-}
-
-static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
-				const void *arg)
-{
-	struct pci_dev *tdev = pci_get_func0_dev(dev);
-	ssize_t ret;
-
-	if (!tdev)
-		return -ENODEV;
-
-	ret = pci_write_vpd(tdev, pos, count, arg);
-	pci_dev_put(tdev);
-	return ret;
-}
-
-static const struct pci_vpd_ops pci_vpd_f0_ops = {
-	.read = pci_vpd_f0_read,
-	.write = pci_vpd_f0_write,
-};
-
 void pci_vpd_init(struct pci_dev *dev)
 {
 	struct pci_vpd *vpd;
@@ -290,10 +256,6 @@ void pci_vpd_init(struct pci_dev *dev)
 		return;
 
 	vpd->len = PCI_VPD_MAX_SIZE;
-	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
-		vpd->ops = &pci_vpd_f0_ops;
-	else
-		vpd->ops = &pci_vpd_ops;
 	mutex_init(&vpd->lock);
 	vpd->cap = cap;
 	vpd->valid = 0;
@@ -388,9 +350,17 @@ EXPORT_SYMBOL_GPL(pci_vpd_find_info_keyword);
  */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
 {
-	if (!dev->vpd || !dev->vpd->ops)
-		return -ENODEV;
-	return dev->vpd->ops->read(dev, pos, count, buf);
+	ssize_t ret;
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
+		dev = pci_get_func0_dev(dev);
+		ret = pci_vpd_read(dev, pos, count, buf);
+		pci_dev_put(dev);
+	} else {
+		ret = pci_vpd_read(dev, pos, count, buf);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(pci_read_vpd);
 
@@ -403,9 +373,17 @@ EXPORT_SYMBOL(pci_read_vpd);
  */
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
 {
-	if (!dev->vpd || !dev->vpd->ops)
-		return -ENODEV;
-	return dev->vpd->ops->write(dev, pos, count, buf);
+	ssize_t ret;
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
+		dev = pci_get_func0_dev(dev);
+		ret = pci_vpd_write(dev, pos, count, buf);
+		pci_dev_put(dev);
+	} else {
+		ret = pci_vpd_write(dev, pos, count, buf);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(pci_write_vpd);
 
-- 
2.32.0


