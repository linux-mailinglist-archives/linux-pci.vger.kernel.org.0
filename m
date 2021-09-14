Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF040B59A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 19:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhINRJN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhINRJM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 13:09:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95BC061574;
        Tue, 14 Sep 2021 10:07:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so20617323wra.8;
        Tue, 14 Sep 2021 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UEz8abuPWgyHSc+A93wlQX9A3Gl7VlEueJS0Qvs3JhU=;
        b=UTLBfvPvMZ+1dXSf5Y7P3VdtVRAXwLs7UG++gYy18zK3Uxok9w8j5CvTbxdqbGiSnJ
         mQpzQ5YWS0TQuZrzq+L3BvwX4DduZ2JGlzFqv2w+Z3dCKZ6jZjo3vbruDIwv1NsN3Fp7
         bnsDhHAkWc7XbgTBIlee24+8cqosxslJOrxfKoYPNMBVdx5haDuoiu32fGwYOGz1YuoN
         Grm1pplnHyU2ehU+liSPzZ9WFZa5hwrDPM72rKvkURd74Cg5tuww0gW9YFYgqqhuqyR1
         pQ1eUZHYlHsBEy1rfSuPfKyYKvQAzpApw16FkGujQBgkQ0BLGfY/yW5ERA32OGJpM+te
         MYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UEz8abuPWgyHSc+A93wlQX9A3Gl7VlEueJS0Qvs3JhU=;
        b=HRlgG2S/GdCUrg3CsdNo845MLri92CRHDjFmaC3FYDruaVvfZKfNvUcIS/tbUiDej5
         eU+46Vd3ay8b8aIrTnYOiAdTurOhIA9KAC7p0IjGsL9CDhP/JZo6NJM48bWI8aYdm4TG
         8akjxqa2Ag8RPV+AzVCQiAS5dFzXpwVEeuAfcUDv/5hBeTp+NusmMJGDPPlN3xEoouxd
         bCaDr0oYrFEPInlkUg++sGG4LZwBAcfVwnrVuDaxm6RK5g/J4Tf1ZX6HcvMvgAfyOAsx
         IJ/XNTn+nlMdO7rRvSs8i3zaWqaRT7dh3TPC2FloFirRizqZbTRWVqGrn76BOYypTQrK
         a5MQ==
X-Gm-Message-State: AOAM530+YTlIV/+BmWA3U5cNCWfrM2b3/sVISZ202R5Imn08pkupbOVH
        BbEnztcsIs/4mMU0dua1rBv4uqysfEI=
X-Google-Smtp-Source: ABdhPJzzw234WDCAkyBTw+u+dKm5PzYtjHHsekK3mqvBJ3z3Vs7smt7E2sYvLhZIdg9w5NWAmHiDMA==
X-Received: by 2002:adf:c542:: with SMTP id s2mr227088wrf.374.1631639271918;
        Tue, 14 Sep 2021 10:07:51 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:c813:4da2:f58a:a1e2? (p200300ea8f084500c8134da2f58aa1e2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:c813:4da2:f58a:a1e2])
        by smtp.googlemail.com with ESMTPSA id j14sm11004462wrp.21.2021.09.14.10.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 10:07:51 -0700 (PDT)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210914112628.GA1412445@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Linux 5.15-rc1
Message-ID: <54bd54b9-3774-92a5-4193-5ccccd235572@gmail.com>
Date:   Tue, 14 Sep 2021 19:07:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914112628.GA1412445@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.09.2021 13:26, Bjorn Helgaas wrote:
> On Tue, Sep 14, 2021 at 08:21:46AM +0200, Heiner Kallweit wrote:
>> On 14.09.2021 01:46, Bjorn Helgaas wrote:
> 
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
>>>  /*
>>
>> Leaving the quirks in FIXUP_HEADER stage would have the advantage that for
>> blacklisted devices the vpd sysfs attribute isn't visibale. The needed
>> changes to the patch are minimal.
> 
> What do you have in mind?  The only thing I can think of would be to
> add a "pci_dev.no_vpd" bit.  "vpd.cap == 0" means the device has no
> VPD, and "vpd.len == 0" means we haven't determined the size yet.  All
> devices start off with vpd.cap == 0 and vpd.len == 0, so a
> FIXUP_HEADER quirk would have to set a sentinel value or some other
> bit.
> 
> Bjorn
> 

Why not leave vpd.len == PCI_VPD_SZ_INVALID as sentinel?

And one more question: Why do you move the "if (!vpd->cap)" check from
pci_vpd_read() to pci_read_vpd()? At a first glance I see no benefit.

Here comes my version. Your changes to pci_vpd_size() I left as-is.
I tested the positive case and it works as expected.


diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 25557b272..04b14c488 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -52,7 +52,7 @@ static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
  * pci_vpd_size - determine actual size of Vital Product Data
  * @dev:	pci device struct
  */
-static size_t pci_vpd_size(struct pci_dev *dev)
+static void pci_vpd_size(struct pci_dev *dev)
 {
 	size_t off = 0, size;
 	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
@@ -71,7 +71,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
 				pci_warn(dev, "failed VPD read at offset %zu\n",
 					 off + 1);
-				return off ?: PCI_VPD_SZ_INVALID;
+				goto finish;
 			}
 			size = pci_vpd_lrdt_size(header);
 			if (off + size > PCI_VPD_MAX_SIZE)
@@ -87,16 +87,19 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 
 			off += PCI_VPD_SRDT_TAG_SIZE + size;
 			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
-				return off;
+				goto finish;
 		}
 	}
-	return off;
+	goto finish;
 
 error:
 	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
 		 header[0], size, off, off == 0 ?
 		 "; assume missing optional EEPROM" : "");
-	return off ?: PCI_VPD_SZ_INVALID;
+finish:
+	dev->vpd.len = off;
+	if (off == 0)
+		dev->vpd.cap = 0;		/* No VPD at all */
 }
 
 /*
@@ -145,6 +148,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
+	if (vpd->len == 0 && vpd->cap)
+		pci_vpd_size(dev);
 	if (!vpd->cap)
 		return -ENODEV;
 
@@ -206,6 +211,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	int ret = 0;
 
+	if (vpd->len == 0 && vpd->cap)
+		pci_vpd_size(dev);
 	if (!vpd->cap)
 		return -ENODEV;
 
@@ -245,9 +252,6 @@ void pci_vpd_init(struct pci_dev *dev)
 	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
 	mutex_init(&dev->vpd.lock);
 
-	if (!dev->vpd.len)
-		dev->vpd.len = pci_vpd_size(dev);
-
 	if (dev->vpd.len == PCI_VPD_SZ_INVALID)
 		dev->vpd.cap = 0;
 }
@@ -294,25 +298,27 @@ const struct attribute_group pci_dev_vpd_attr_group = {
 
 void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
 {
-	unsigned int len = dev->vpd.len;
+	struct pci_vpd *vpd = &dev->vpd;
 	void *buf;
 	int cnt;
 
-	if (!dev->vpd.cap)
+	if (vpd->len == 0 && vpd->cap)
+		pci_vpd_size(dev);
+	if (!vpd->cap)
 		return ERR_PTR(-ENODEV);
 
-	buf = kmalloc(len, GFP_KERNEL);
+	buf = kmalloc(vpd->len, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	cnt = pci_read_vpd(dev, 0, len, buf);
-	if (cnt != len) {
+	cnt = pci_read_vpd(dev, 0, vpd->len, buf);
+	if (cnt != vpd->len) {
 		kfree(buf);
 		return ERR_PTR(-EIO);
 	}
 
 	if (size)
-		*size = len;
+		*size = vpd->len;
 
 	return buf;
 }
-- 
2.33.0




