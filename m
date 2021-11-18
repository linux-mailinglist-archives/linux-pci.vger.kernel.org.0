Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258F445646F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 21:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhKRUt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhKRUt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 15:49:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EEC061574
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 12:46:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s13so14021726wrb.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=G3fZmKOo/J9cc206xBW7iBHSldwFZyhKfuaM71Z1/Po=;
        b=lOCJtpidvIM4AlQ3EMHZGPAANTVZBVsdwHtc5SoUUv4PbqZ9fi8FsnXE0N2geJ7WkQ
         cZ8DLqt2r8Td+QzbVfSS/cDdPjyuWpZyCl6OGxs5OkytV2x7iKauMuC+r5+fZ9c09JUc
         Wn1R6ELi3v/9a3VMyr5sSaEVlHSowOUa4ef7rm+GdskDLMe2nsILCAdD8xm3Vm20DFyL
         SwKgkBX4rf03erTr9wjIP0L1lqXN4iPL1wQZHiPUI/kHk6Q4cgaxbG8MvlksGp8T/5SR
         Z9ddfZDdo89rf61zzJ2tjxHpSKFAepe0oT3yYKy2RuP3mR8BKjsOzCnJ3hlbQ+kBcz17
         x05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=G3fZmKOo/J9cc206xBW7iBHSldwFZyhKfuaM71Z1/Po=;
        b=U2Jxvi91dzrzi3wVrKjudKx9d09ElxSZgUSrabyqC/0wbxyzHjmya04mB/9JYjA39F
         v2vAmzKFCyZUdWuX3wuTVJjV09SSt8BnMjoVJ8LNfSrVDPSUSjNoaG5AHLy+5MKPonIO
         vcoh5PnAJ23taSwhZoxuuQzy8MB1BrWSUMAwJbkXI9UEvL4N4i0iPNj05jm9TbrPBAs0
         QrLA9mZ+dQzlQxwLktUykzFrhVXjMpNnOfTFiUT7qmPjvtIwPOw7hzZrTFDM98Kjdeu1
         ReUr82fbVf7jMuujXTeM0A+K+EUTa5qLyNvLxJpKWlDojL98fIgpNECOt1O6cFDMQX+D
         CiDA==
X-Gm-Message-State: AOAM530EL4IewOvXpF06Oh9FoQu/unjIKhBw29qdR8Auq/7bABFKUS70
        8gt0tmxaDtpqpycX+u4Xh2uge5vs1Xg=
X-Google-Smtp-Source: ABdhPJzoiHFgHSEvZzzAUbA2bSRWZ80XIj6Jazd6EJGjfxvW/CWvlwFvvQBaqEjGmSuOmJhzwFV7Eg==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr534983wrv.106.1637268415167;
        Thu, 18 Nov 2021 12:46:55 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213? (p200300ea8f1a0f00fc8d4de8c1d19213.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213])
        by smtp.googlemail.com with ESMTPSA id d9sm827085wre.52.2021.11.18.12.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 12:46:54 -0800 (PST)
Message-ID: <bcc921e4-942c-b95c-ce9c-6d92f1bbba1e@gmail.com>
Date:   Thu, 18 Nov 2021 21:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Add simple VPD read cache
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VPD reads can be time-consuming operations, and when reading bytes
sequentially then worst-case we may read the same VPD dword four times.
Typically it happens in pci_vpd_size() already that the same VPD dword
is read more than once. Therefore let's add a simple read cache that
caches the last read VPD dword.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c   | 13 +++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 75e48df2e..2315e45f6 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -194,6 +194,11 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			break;
 		}
 
+		if (vpd->cached_offset == (pos & ~3)) {
+			val = vpd->cached_val;
+			goto process;
+		}
+
 		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						 pos & ~3);
 		if (ret < 0)
@@ -206,6 +211,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 		if (ret < 0)
 			break;
 
+		vpd->cached_val = val;
+		vpd->cached_offset = pos & ~3;
+process:
 		skip = pos & 3;
 		for (i = 0;  i < sizeof(u32); i++) {
 			if (i >= skip) {
@@ -242,6 +250,10 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 		return -EINTR;
 
 	while (pos < end) {
+		/* invalidate read cache */
+		if (vpd->cached_offset == pos)
+			vpd->cached_offset = -1;
+
 		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
 						  get_unaligned_le32(buf));
 		if (ret < 0)
@@ -270,6 +282,7 @@ void pci_vpd_init(struct pci_dev *dev)
 
 	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
 	mutex_init(&dev->vpd.lock);
+	dev->vpd.cached_offset = -1;
 }
 
 static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce..fb123c248 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -297,6 +297,8 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 struct pci_vpd {
 	struct mutex	lock;
 	unsigned int	len;
+	u32		cached_val;
+	int		cached_offset;
 	u8		cap;
 };
 
-- 
2.33.0

