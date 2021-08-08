Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1123E3BE9
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhHHRYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhHHRYW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 13:24:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B0C061760
        for <linux-pci@vger.kernel.org>; Sun,  8 Aug 2021 10:24:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso12796041wmq.3
        for <linux-pci@vger.kernel.org>; Sun, 08 Aug 2021 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZrGMfIn9duZHrgPrZQrczeNxCd3FMunAZEVzb7ncRw8=;
        b=X505X68eKtrt/V1b6m9riXb/Y8VXIMWJLl4HV21l2Bctqm0/2fEm/udq5XLfBt4idf
         pTyvvXFABpoW7INAlzpYYQAqijO1FL26LI1d1DnJDUtwDJ11MLu8bee01ZfuJiEFcm/m
         v+7DiR1jIcTk/IIsUS+n1o8JerJziD/TTWNe4ywUwPa2QJIbdZfH0FCeoSFCllVdkHBZ
         nLYKrAjhgyyCxDyNwXwQcmq/YTUAO/0NJYnfs5Z+WXU7mB/8s0zMV7yDmm4iOcjKKj98
         b3S6nAAACp9DIy8MaMjiKCqQWBmaDnaONk8pv2onP3ipoKaW02gyAK6uBobBtzltg3D+
         Vy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZrGMfIn9duZHrgPrZQrczeNxCd3FMunAZEVzb7ncRw8=;
        b=TICkE9l8ntAHvVqmMATtlMdFlGQ7+wBkfScP4JLQkMZNrwqYTejG8XYWupWabQJLvs
         tL8vKu8Bdk0bwUXHNNI6BL/mL2Mqiy6Kk1E7yITWvg38b4cYIlMi6rIuhEBSIcWmf89I
         jEp6TN0SYj7uJTJrSFl6F8nlUuePIsy5eVoZ+cl03NSmniiXS9mq14pDnldIBpbEuSXJ
         ilgG13kmXmNTeRSCabCzk8vceLXzy+6f3Fj0N2dVm12qDpbWoK3CQ5KZXbgY4D67/EOH
         rm5rnVqPf2hAsQfONwZwRh1Mg+VU2yosSkN2SVtZ7fjETk0ZI6TryH6X0gdJmkkWHmOW
         IZ9g==
X-Gm-Message-State: AOAM530mo+WM9o6knGhOXKQPmXLXLyJqWH3HQJwqx9CemLLj/BPm+y7V
        6mfaYZ5MWO4nqmI7uBbYuCBg2Itm4PY10w==
X-Google-Smtp-Source: ABdhPJxroo1sm7PMDrM/DUUtIqoOi65iFlLLuzjbQrhJxMPWQbtrBSpbdD3dPqBhIL4JZkKU0te2qg==
X-Received: by 2002:a05:600c:198f:: with SMTP id t15mr6978828wmq.76.1628443440634;
        Sun, 08 Aug 2021 10:24:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:7101:8b48:5eab:cb5f? (p200300ea8f10c20071018b485eabcb5f.dip0.t-ipconnect.de. [2003:ea:8f10:c200:7101:8b48:5eab:cb5f])
        by smtp.googlemail.com with ESMTPSA id c15sm16977316wrw.93.2021.08.08.10.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:24:00 -0700 (PDT)
Subject: [PATCH 6/6] PCI/VPD: Treat invalid VPD like no VPD capability
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Message-ID: <6a02b204-4ed2-4553-c3b2-eacf9554fa8d@gmail.com>
Date:   Sun, 8 Aug 2021 19:23:57 +0200
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

Exporting sysfs files that can't be accessed doesn't make much sense.
Therefore, if either a quirk or the dynamic size calculation result
in VPD being marked as invalid, treat this like device has no VPD
capability. One consequence is that vpd sysfs file is not visible.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 9187ba496..58a3aa6a4 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -125,9 +125,6 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0)
 		return -EINVAL;
 
-	if (vpd->len == PCI_VPD_SZ_INVALID)
-		return -EIO;
-
 	if (pos > vpd->len)
 		return 0;
 
@@ -189,9 +186,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0 || (pos & 3) || (count & 3))
 		return -EINVAL;
 
-	if (vpd->len == PCI_VPD_SZ_INVALID)
-		return -EIO;
-
 	if (end > vpd->len)
 		return -EINVAL;
 
@@ -232,6 +226,9 @@ void pci_vpd_init(struct pci_dev *dev)
 
 	if (!dev->vpd.len)
 		dev->vpd.len = pci_vpd_size(dev);
+
+	if (dev->vpd.len == PCI_VPD_SZ_INVALID)
+		dev->vpd.cap = 0;
 }
 
 static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
-- 
2.32.0


