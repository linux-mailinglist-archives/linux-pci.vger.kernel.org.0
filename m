Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A273F8E53
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbhHZS7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbhHZS7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 14:59:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFEC061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2820225wml.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=89DC8UIwgUAhYfezfzSWjndtlwDLSH0xk/3M1k/C10k=;
        b=op8JGbpIkaULBEiDKqmih0ZG4ySkHJANbjWCUU1leEbThFo2cEEy/+EG/81y4Eus6v
         Wc7uBQrpk4aunFeQTvJKgZZxo3nVJJkhM7L5qYjRPwLVcrolPQvqLgfdTAWnno1N7z2b
         QkswVDgW6AeEnCSI4sfZmQx4r2BGsP6DZ9R7qguTlWOTmoX9RdOb21hYwn1GQc9BVEQy
         HV+3BULmufnZpw4VAzU01IfVxckUQ7CW2gXNdMC/3d7epwZoUMoLfCDIf/FTlzD9CeL7
         OhK98dq/ejOFQIh3opmqdua5M6scVcnEUIXuIt4zr8sCcwNMM/aZdpugU1i3cC+mQ1eP
         6DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=89DC8UIwgUAhYfezfzSWjndtlwDLSH0xk/3M1k/C10k=;
        b=Uhjov/KsNEec0DD1LYhnNpCAXxrRyovxze9YUxH4jn2+HpNMaZFC34zTJPXlUghDru
         R05u8eY4EMZRNcZnnEM6uEWBHES+XpNk7tqFQlGnvZAq7wBHsZHqr0PFyDIUhsjZ5BaD
         xVn5+j41zeev55o+DRfJVG2kdD9BTITteln0HaC3+IjAV1E6ofZVjiQhkHdC18pu9JDU
         CmsMnLB47UwWhCHEtuYSk2oSfMgtUZSWotZAN+65292hMco2RSJKoWRUXn5XsocSsWmo
         4///yR4X/xPAXj3MYgbiIeje2fmlzfIsbldcSR9TCKtaWCoO+RRvRSgUB70wMK6CYxg0
         9r9A==
X-Gm-Message-State: AOAM532wsnPmze8oPDKa2J+/gPwF7WZqrbpBbX77M4gFvwmlHmtNDExD
        33VPd7RzjvOL71oD0KVavHKJ/kshzYd/Yw==
X-Google-Smtp-Source: ABdhPJzcpA4cJIbg9HIKDhyEE46cx/cJeJzTYqymm0mLTGBjYOOfY9BLmRQq5kQVyhsJVIl5v2o7cw==
X-Received: by 2002:a05:600c:3795:: with SMTP id o21mr13881774wmr.130.1630004303767;
        Thu, 26 Aug 2021 11:58:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2? (p200300ea8f084500b5d8a3dcf88fcae2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2])
        by smtp.googlemail.com with ESMTPSA id e2sm4652060wrq.56.2021.08.26.11.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:58:23 -0700 (PDT)
Subject: [PATCH 2/7] PCI/VPD: Stop exporting pci_vpd_find_info_keyword()
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Message-ID: <96ca2a56-383e-9b61-9cba-4f1e5611dc15@gmail.com>
Date:   Thu, 26 Aug 2021 20:54:23 +0200
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
 include/linux/pci.h | 13 -------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 5726fbb7a..0e7a5e8a8 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -311,7 +311,7 @@ static int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt)
 	return -ENOENT;
 }
 
-int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
+static int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 			      unsigned int len, const char *kw)
 {
 	int i;
@@ -327,7 +327,6 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 
 	return -ENOENT;
 }
-EXPORT_SYMBOL_GPL(pci_vpd_find_info_keyword);
 
 /**
  * pci_read_vpd - Read one entry from Vital Product Data
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c0260884..0d6c45b1b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2350,19 +2350,6 @@ static inline u8 pci_vpd_info_field_size(const u8 *info_field)
  */
 void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size);
 
-/**
- * pci_vpd_find_info_keyword - Locates an information field keyword in the VPD
- * @buf: Pointer to buffered vpd data
- * @off: The offset into the buffer at which to begin the search
- * @len: The length of the buffer area, relative to off, in which to search
- * @kw: The keyword to search for
- *
- * Returns the index where the information field keyword was found or
- * -ENOENT otherwise.
- */
-int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
-			      unsigned int len, const char *kw);
-
 /**
  * pci_vpd_find_ro_info_keyword - Locate info field keyword in VPD RO section
  * @buf: Pointer to buffered VPD data
-- 
2.33.0


