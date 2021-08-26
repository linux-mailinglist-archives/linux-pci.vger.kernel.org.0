Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA63F8E58
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbhHZS70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbhHZS70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 14:59:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862EFC061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so2810492wms.4
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ugqNyqO4ZaYf6LRNQ26pXfGl/Wn1pUnTjjCEE2HWxhA=;
        b=qyilxcZcPDHYU77TYVNUeDtH4I1KaGQipwVaxj8Gwuu1x28h0eYyoelG+UUdqMqhdA
         W6fbUWNe/i14xCSxeNg+CmiQ92RostdsfTy754X2+wRTgm42MIQlVYmj+TvchclsLQv9
         cP+FgXcFKY6/2oLrODHruL7n5jFKvOhurdfprd7WSDnmdL17H3Oj4GfvzWDERXiHy7eP
         Azblnd+oe4B4c5EZL43ZeBNDHXWyBIUztGzMT6EV73Oy0Fg+pk/jaKgJF69fbuOkaaNh
         Jd2eSXwsunaQ5p83Hx2HwJHxvYtomyTAf6jIy1RfPcvfGHTxrjDlzzyu2uxBCIH68Rzg
         R7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ugqNyqO4ZaYf6LRNQ26pXfGl/Wn1pUnTjjCEE2HWxhA=;
        b=n5p4e3lUdI9GNBig95l92mkniO30Zx8KpgVgvOwdfb0RUNt3ygL2H22iQydxA5agJh
         DEqTaUHjdOonptFPUFhW5EXO3arDtj/Q+Csoww2gLm2VWLI+nU4wPjgMVSlPxzxyhSJT
         IUl4X7RnGC6H1jPJyZEjq+QohHamQefgOWpME0kNcYC0/C4EqeV4+PiuGnkz49QfIZcp
         OhF1oir11FzdAZu5eQgb57DLxMh6XKOnrD+xW2HdyBWg+Zl2nDmYpeW5SW7obkB32FMQ
         HeUkPtZu0+5LRK3mc6L08AeCOcXXSeAZrVDzu6cxE5DkT2FX6dWjX5kTWvbdHPTSebtG
         c0Sw==
X-Gm-Message-State: AOAM532GDeReCZI2/n1BGnaUgXahbqr9RgLfIy/aJHE3ZYl8HJxB5PD+
        c4eY9XX0IUQ+40M7lvOQH6MUd4XzKFiUMQ==
X-Google-Smtp-Source: ABdhPJybT1h/OzeepzWee9ulPTXZXgvuuamn3RUCHvAYMfQC5+9lw6v+y79I5kegM2fQHb5gXDrHdA==
X-Received: by 2002:a05:600c:4309:: with SMTP id p9mr5146395wme.174.1630004316857;
        Thu, 26 Aug 2021 11:58:36 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2? (p200300ea8f084500b5d8a3dcf88fcae2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2])
        by smtp.googlemail.com with ESMTPSA id w14sm3862769wrt.23.2021.08.26.11.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:58:36 -0700 (PDT)
Subject: [PATCH 6/7] PCI/VPD: Clean up public VPD defines and inline functions
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Message-ID: <d33e06bf-bc5e-ece7-bf35-7245ae224d1b@gmail.com>
Date:   Thu, 26 Aug 2021 20:57:01 +0200
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

After recent introduction of new VPD API functions and user migration
these defines and inline functions aren't used outside VPD core any
longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c   | 26 +++++++++++++++++
 include/linux/pci.h | 69 ---------------------------------------------
 2 files changed, 26 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 79712b3d1..ff600dff4 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -11,6 +11,32 @@
 #include <linux/sched/signal.h>
 #include "pci.h"
 
+#define PCI_VPD_LRDT_TAG_SIZE		3
+#define PCI_VPD_SRDT_LEN_MASK		0x07
+#define PCI_VPD_SRDT_TAG_SIZE		1
+#define PCI_VPD_STIN_END		0x0f
+#define PCI_VPD_INFO_FLD_HDR_SIZE	3
+
+static u16 pci_vpd_lrdt_size(const u8 *lrdt)
+{
+	return (u16)lrdt[1] + ((u16)lrdt[2] << 8);
+}
+
+static u8 pci_vpd_srdt_tag(const u8 *srdt)
+{
+	return *srdt >> 3;
+}
+
+static u8 pci_vpd_srdt_size(const u8 *srdt)
+{
+	return *srdt & PCI_VPD_SRDT_LEN_MASK;
+}
+
+static u8 pci_vpd_info_field_size(const u8 *info_field)
+{
+	return info_field[2];
+}
+
 /* VPD access through PCI 2.2+ VPD capability */
 
 static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f83930562..2106bfd0a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2266,81 +2266,12 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask);
 #define PCI_VPD_LRDT_RO_DATA		PCI_VPD_LRDT_ID(PCI_VPD_LTIN_RO_DATA)
 #define PCI_VPD_LRDT_RW_DATA		PCI_VPD_LRDT_ID(PCI_VPD_LTIN_RW_DATA)
 
-/* Small Resource Data Type Tag Item Names */
-#define PCI_VPD_STIN_END		0x0f	/* End */
-
-#define PCI_VPD_SRDT_END		(PCI_VPD_STIN_END << 3)
-
-#define PCI_VPD_SRDT_TIN_MASK		0x78
-#define PCI_VPD_SRDT_LEN_MASK		0x07
-#define PCI_VPD_LRDT_TIN_MASK		0x7f
-
-#define PCI_VPD_LRDT_TAG_SIZE		3
-#define PCI_VPD_SRDT_TAG_SIZE		1
-
-#define PCI_VPD_INFO_FLD_HDR_SIZE	3
-
 #define PCI_VPD_RO_KEYWORD_PARTNO	"PN"
 #define PCI_VPD_RO_KEYWORD_SERIALNO	"SN"
 #define PCI_VPD_RO_KEYWORD_MFR_ID	"MN"
 #define PCI_VPD_RO_KEYWORD_VENDOR0	"V0"
 #define PCI_VPD_RO_KEYWORD_CHKSUM	"RV"
 
-/**
- * pci_vpd_lrdt_size - Extracts the Large Resource Data Type length
- * @lrdt: Pointer to the beginning of the Large Resource Data Type tag
- *
- * Returns the extracted Large Resource Data Type length.
- */
-static inline u16 pci_vpd_lrdt_size(const u8 *lrdt)
-{
-	return (u16)lrdt[1] + ((u16)lrdt[2] << 8);
-}
-
-/**
- * pci_vpd_lrdt_tag - Extracts the Large Resource Data Type Tag Item
- * @lrdt: Pointer to the beginning of the Large Resource Data Type tag
- *
- * Returns the extracted Large Resource Data Type Tag item.
- */
-static inline u16 pci_vpd_lrdt_tag(const u8 *lrdt)
-{
-	return (u16)(lrdt[0] & PCI_VPD_LRDT_TIN_MASK);
-}
-
-/**
- * pci_vpd_srdt_size - Extracts the Small Resource Data Type length
- * @srdt: Pointer to the beginning of the Small Resource Data Type tag
- *
- * Returns the extracted Small Resource Data Type length.
- */
-static inline u8 pci_vpd_srdt_size(const u8 *srdt)
-{
-	return (*srdt) & PCI_VPD_SRDT_LEN_MASK;
-}
-
-/**
- * pci_vpd_srdt_tag - Extracts the Small Resource Data Type Tag Item
- * @srdt: Pointer to the beginning of the Small Resource Data Type tag
- *
- * Returns the extracted Small Resource Data Type Tag Item.
- */
-static inline u8 pci_vpd_srdt_tag(const u8 *srdt)
-{
-	return ((*srdt) & PCI_VPD_SRDT_TIN_MASK) >> 3;
-}
-
-/**
- * pci_vpd_info_field_size - Extracts the information field length
- * @info_field: Pointer to the beginning of an information field header
- *
- * Returns the extracted information field length.
- */
-static inline u8 pci_vpd_info_field_size(const u8 *info_field)
-{
-	return info_field[2];
-}
-
 /**
  * pci_vpd_alloc - Allocate buffer and read VPD into it
  * @dev: PCI device
-- 
2.33.0


