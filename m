Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61463E3BE3
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhHHRV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHRV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 13:21:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00635C061760
        for <linux-pci@vger.kernel.org>; Sun,  8 Aug 2021 10:21:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso950849wmj.0
        for <linux-pci@vger.kernel.org>; Sun, 08 Aug 2021 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZ0CiqYvQd9POK26TIoWPQqNqHc6FZbED182og4oCLo=;
        b=u9kj9Mc45d4cFgKucX08N8JMBNkxG7E5oByUaW2CIipUn2tirDdECwBulYgGyqmHxj
         IG5v1SqiegjfQ/vszdJojbV8bJcF0EqfwXwraRAcRefEZYDINch75PNMCWXxoqHJHnWh
         kNfjE301ZGHzS9MeNbc5um92xApuYCPTFmkJuw0gtXdH2scce5RFmWAOSqFYW0meBWzy
         ekfukHOUmckZWLB0FVaHH056aNW7zr4Vr2ZjuB10vbszUQyxSjz9eR/FkeJNTVCc1Q6q
         CAxWJxEf8n4xLVX//FlWMUWT7cCY+o3xM1SOdVY2shi/NSTQt2h0e49beXrnPOnJq5Qo
         50Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZ0CiqYvQd9POK26TIoWPQqNqHc6FZbED182og4oCLo=;
        b=HC8t4B/ZiltyEoL9aWdzSC4991lPvy47S4jshXrJnrwi/SZ/FCsIFnWcaINgMyXp32
         VhRmbdgbci8rSKv3HDjrNySiLGe/Z2nsLahb5SMRsTwvEEhoQ5DbeP7s+9ZvlQ5wySbz
         mHSYBL9YNvImAhL7IohxtZCesqwBBE8C3pj/9ELOYHEib/x79nEDaU/nwMUJyouEoJek
         DPv87Omjhrx2fA290FoCitL1XGG8nhRbvVf2sH1bJCUpEOyMttLlyxYdEth4p5SpYgUU
         2v4E+Yj5JPBlMHoX93TxkuXBAx0YnGkRlvI+F9Du8/aPThBDRWqVHzied5kLg8yXMdC6
         Uw+g==
X-Gm-Message-State: AOAM530MsQ9FTT8yvNOnj+6NoJ1YzHQMTwvySiskniZ6+HmLjBBOFXhR
        Sl9fTOp5no7Z0QGFvFOovo1wiOEcBs7BAA==
X-Google-Smtp-Source: ABdhPJzcDDI9lypE8p18iusXE8qi1MZ3lHFnX5SlbtCokRKtEk8ZgViQ6con+n7zYqyBvaD1d2Qj+w==
X-Received: by 2002:a7b:c014:: with SMTP id c20mr12637397wmb.81.1628443265463;
        Sun, 08 Aug 2021 10:21:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:7101:8b48:5eab:cb5f? (p200300ea8f10c20071018b485eabcb5f.dip0.t-ipconnect.de. [2003:ea:8f10:c200:7101:8b48:5eab:cb5f])
        by smtp.googlemail.com with ESMTPSA id s2sm14818985wmh.46.2021.08.08.10.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:21:05 -0700 (PDT)
Subject: [PATCH 3/6] PCI/VPD: Remove member valid from struct pci_vpd
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Message-ID: <9f777bc7-5316-e1b8-e5d4-f9f609bdb5dd@gmail.com>
Date:   Sun, 8 Aug 2021 19:21:02 +0200
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

Instead of having a separate flag let's use vp->len != 0 as indicator that
VPD validity has been checked. Now vpd->len == PCI_VPD_SZ_INVALID is used
to indicate that VPD is invalid.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 6a0d617b2..d6c216caf 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -17,7 +17,6 @@ struct pci_vpd {
 	struct mutex	lock;
 	unsigned int	len;
 	u8		cap;
-	unsigned int	valid:1;
 };
 
 static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
@@ -25,7 +24,8 @@ static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
 	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 }
 
-#define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
+#define PCI_VPD_MAX_SIZE	(PCI_VPD_ADDR_MASK + 1)
+#define PCI_VPD_SZ_INVALID	UINT_MAX
 
 /**
  * pci_vpd_size - determine actual size of Vital Product Data
@@ -36,6 +36,9 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 	size_t off = 0;
 	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
 
+	/* Otherwise the following reads would fail. */
+	dev->vpd->len = PCI_VPD_MAX_SIZE;
+
 	while (pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
 		size_t size;
@@ -48,7 +51,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
 				pci_warn(dev, "failed VPD read at offset %zu\n",
 					 off + 1);
-				return off;
+				return off ?: PCI_VPD_SZ_INVALID;
 			}
 			size = pci_vpd_lrdt_size(header);
 			if (off + size > PCI_VPD_MAX_SIZE)
@@ -73,7 +76,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
 		 header[0], off, off == 0 ?
 		 "; assume missing optional EEPROM" : "");
-	return off;
+	return off ?: PCI_VPD_SZ_INVALID;
 }
 
 /*
@@ -130,12 +133,10 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0)
 		return -EINVAL;
 
-	if (!vpd->valid) {
-		vpd->valid = 1;
+	if (!vpd->len)
 		vpd->len = pci_vpd_size(dev);
-	}
 
-	if (vpd->len == 0)
+	if (vpd->len == PCI_VPD_SZ_INVALID)
 		return -EIO;
 
 	if (pos > vpd->len)
@@ -201,12 +202,10 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0 || (pos & 3) || (count & 3))
 		return -EINVAL;
 
-	if (!vpd->valid) {
-		vpd->valid = 1;
+	if (!vpd->len)
 		vpd->len = pci_vpd_size(dev);
-	}
 
-	if (vpd->len == 0)
+	if (vpd->len == PCI_VPD_SZ_INVALID)
 		return -EIO;
 
 	if (end > vpd->len)
@@ -255,10 +254,8 @@ void pci_vpd_init(struct pci_dev *dev)
 	if (!vpd)
 		return;
 
-	vpd->len = PCI_VPD_MAX_SIZE;
 	mutex_init(&vpd->lock);
 	vpd->cap = cap;
-	vpd->valid = 0;
 	dev->vpd = vpd;
 }
 
@@ -423,8 +420,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 static void quirk_blacklist_vpd(struct pci_dev *dev)
 {
 	if (dev->vpd) {
-		dev->vpd->len = 0;
-		dev->vpd->valid = 1;
+		dev->vpd->len = PCI_VPD_SZ_INVALID;
 		pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
 	}
 }
@@ -455,7 +451,6 @@ static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
 	if (!vpd || len == 0 || len > PCI_VPD_MAX_SIZE)
 		return;
 
-	vpd->valid = 1;
 	vpd->len = len;
 }
 
-- 
2.32.0


