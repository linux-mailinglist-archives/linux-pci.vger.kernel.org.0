Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27A836346C
	for <lists+linux-pci@lfdr.de>; Sun, 18 Apr 2021 11:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhDRJUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Apr 2021 05:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDRJUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Apr 2021 05:20:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0273C06174A
        for <linux-pci@vger.kernel.org>; Sun, 18 Apr 2021 02:19:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m9so18123569wrx.3
        for <linux-pci@vger.kernel.org>; Sun, 18 Apr 2021 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=BWvoRrTC1jP7SxIYgCvLjmPjmsu8UJgnpGv71gwt7xY=;
        b=lqhT83qrptx6ENjRKS/q0hr8LvXGDSmT+kaRgiqE6D2mXR4oHJFGmuQ3uQMNvL9KBd
         q9TmfAjDPtgppN1VFFFdq12c8vjvcFQcta62yUY8BlT7QlKD7+AFwH6MBFNeMbkLPIqo
         Dx6M1LJfrZxiHLZxerrUH8fYQ6h7wZakCRVpYnf9TK59STE8lAw6bNE7L7Pd7BM3LVd4
         OgCwf+YurhQLwt0BjMSoYxkt7x9EVvH9qhrHW61ryuesohZkS9xhHCXj9yiRvmQj1P96
         4jkuuXavxmg/vFfPaM7s8iV4h4SUZ3fffPmf0WCsmHZTCIO7s0GO6B1VlukljIxn0kcJ
         5Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BWvoRrTC1jP7SxIYgCvLjmPjmsu8UJgnpGv71gwt7xY=;
        b=MlZzuNYSkg1xDW6M3Rw8mpsigxQzcYVGHWExq0J6HwRtwC7Ul4OITcKgfchSVIciTN
         6f1QK12GGHMhDlHhWODdY6aTs7hLV4C7qVVSPG5B+OpLam75E3N4xwGUQB+pYUcpuHxv
         IL8VBclepSjIeNK5h5IT1sF+w1Wupj3+WQHecxzZ4qJ5ONziCTIVZaXk6kJiLZZJh8O+
         Ap4ffpy30iUMvdN/q6LAm0UbRrDiBKm/4I3EP/S2KnhU7d1sjDCREOKPDgWW0QuleLRH
         GBMBzTfiINwdJOlY4keT8p7WtXnAIPTIe0rnT6r+ti6o/7fhorObKr19lFqoW6JERDpt
         wCIg==
X-Gm-Message-State: AOAM533yEJ0Rd4C0DIQ3IFMzaxMLUp+Aedmf9T7iiISbeRfHfns5wDD9
        ssNP0GkMAIC+87Ye43kSumVRlrHj+DpQtQ==
X-Google-Smtp-Source: ABdhPJy1JKjbvEZf8Oxfp18wNedIRxBsvitSuyc1RraCf5iZXIvoYDLZRahEvYWgRyO4JifTKU44ww==
X-Received: by 2002:adf:bc49:: with SMTP id a9mr8419086wrh.109.1618737579215;
        Sun, 18 Apr 2021 02:19:39 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:7049:2393:32ac:d22c? (p200300ea8f3846007049239332acd22c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:7049:2393:32ac:d22c])
        by smtp.googlemail.com with ESMTPSA id v7sm18512648wrs.2.2021.04.18.02.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 02:19:38 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Use unaligned access helper in pci_vpd_write
Message-ID: <79d337f4-25d6-9024-2cbd-63801cbd9992@gmail.com>
Date:   Sun, 18 Apr 2021 11:19:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use helper get_unaligned_le32() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 60573f27a..2888bb300 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/sched/signal.h>
+#include <asm/unaligned.h>
 #include "pci.h"
 
 /* VPD access through PCI 2.2+ VPD capability */
@@ -235,10 +236,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 }
 
 static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
-			     const void *arg)
+			     const void *buf)
 {
 	struct pci_vpd *vpd = dev->vpd;
-	const u8 *buf = arg;
 	loff_t end = pos + count;
 	int ret = 0;
 
@@ -264,14 +264,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 		goto out;
 
 	while (pos < end) {
-		u32 val;
-
-		val = *buf++;
-		val |= *buf++ << 8;
-		val |= *buf++ << 16;
-		val |= *buf++ << 24;
-
-		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA, val);
+		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
+						  get_unaligned_le32(buf));
 		if (ret < 0)
 			break;
 		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
@@ -286,6 +280,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 			break;
 
 		pos += sizeof(u32);
+		buf += sizeof(u32);
 	}
 out:
 	mutex_unlock(&vpd->lock);
-- 
2.31.1

