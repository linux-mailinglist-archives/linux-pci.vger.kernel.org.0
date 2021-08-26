Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B83F8E52
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhHZS7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243300AbhHZS7J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 14:59:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20983C061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so6660557wrp.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uCZOJy2EcDvwg3qkhxmtCMGfx1QF7c5X+D3+7xaUKBg=;
        b=uFeelsFHKrWg12PiaBmHSXX4R6ia7fo8QuplJKXDDPJ6AgNcSYFJxdXfkInlzQRmY+
         6v8r0JrMj8GhiGORsyRjG2AMbP5dbesexA5qlXb+r3+MBoXHE2tbK0/YNbg1TS6bZ4ra
         5RPkWKW3HerSsUqnM6TM6g10W96siyLZKIZ+HfgT2+AH8zCP5nYLVKClwVbricOcVqCc
         LSVVOINdTIv2QEnpS4mwk6IzbbhSa2L1kJqyBJJd78WfWqROzbq7eW/9UoV6yXQZ78eL
         CbcHO6XdBDRcr+VD+hrojN/2BDd1FnnNFriMsRL7istZkGsR5fl6YuWXrLwtIKAPbnJS
         i2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uCZOJy2EcDvwg3qkhxmtCMGfx1QF7c5X+D3+7xaUKBg=;
        b=HKa6dIlRwntCyAWrw/AxNWUqh7a20n1Y5nQ1kRRmQxPR4pmWC4a/OxZNHUcruCZBjP
         stQ6DMIBooEp/M6wwrQxb/UCS8e0CVSdYP1/+7GQ8uLEcJQIXHlaNSzwdHh2PM3Sp8bf
         qGkpnLJ+28DLxapr0mgEYbKT1FdyP+xcS2q2GLnhIuB+uyapo/9Q9Oy+eKLellJh0XtJ
         veRKXhuyK59XGh4qesoBnvcDM2fC+Fo3j8P1pmoOvUNeZLyVqy8Qpi7/sASsgF1px7ZW
         Yc5k1C5FZY0cyIM06c8V8go9wZCnROk8eRxTYLQapkpa64jsoQrxqsm+KG+tJlw6jnab
         6MfQ==
X-Gm-Message-State: AOAM532P6iTHybWGVVj0nvheQ7OyETxYIdRSF9tz6ChKUodaJwPuTn34
        EgDRxRUe3zj/9mJwlrSlnRLYxf2+IdjB4g==
X-Google-Smtp-Source: ABdhPJxd9rBPQ2070/NJ7peZnXbguSRGNWufOsrVGmV1/8OPC0+3r3cwRsXWNtir83nHMoTftljeUg==
X-Received: by 2002:adf:906c:: with SMTP id h99mr1268761wrh.8.1630004300429;
        Thu, 26 Aug 2021 11:58:20 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2? (p200300ea8f084500b5d8a3dcf88fcae2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2])
        by smtp.googlemail.com with ESMTPSA id p11sm3623512wma.16.2021.08.26.11.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:58:19 -0700 (PDT)
Subject: [PATCH 1/7] PCI/VPD: Stop exporting pci_vpd_find_tag()
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Message-ID: <71131eca-0502-7878-365f-30b6614161cf@gmail.com>
Date:   Thu, 26 Aug 2021 20:53:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the last users have been migrated to pci_vpd_find_ro_keyword()
we can stop exporting this function. It's still used in VPD core code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c   |  3 +--
 include/linux/pci.h | 11 -----------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 01e575947..5726fbb7a 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -296,7 +296,7 @@ void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
 }
 EXPORT_SYMBOL_GPL(pci_vpd_alloc);
 
-int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt)
+static int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt)
 {
 	int i = 0;
 
@@ -310,7 +310,6 @@ int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt)
 
 	return -ENOENT;
 }
-EXPORT_SYMBOL_GPL(pci_vpd_find_tag);
 
 int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 			      unsigned int len, const char *kw)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 76e3a9254..2c0260884 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2350,17 +2350,6 @@ static inline u8 pci_vpd_info_field_size(const u8 *info_field)
  */
 void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size);
 
-/**
- * pci_vpd_find_tag - Locates the Resource Data Type tag provided
- * @buf: Pointer to buffered vpd data
- * @len: The length of the vpd buffer
- * @rdt: The Resource Data Type to search for
- *
- * Returns the index where the Resource Data Type was found or
- * -ENOENT otherwise.
- */
-int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt);
-
 /**
  * pci_vpd_find_info_keyword - Locates an information field keyword in the VPD
  * @buf: Pointer to buffered vpd data
-- 
2.33.0


