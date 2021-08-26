Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F53F8E54
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhHZS7U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbhHZS7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 14:59:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068DC061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2820299wml.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yaTVSk0QhQ6Q3ONwqkunR+ld3cwrqWOmizyChyPBFII=;
        b=tsPjGzAFLWYbqWizpcH1yoD5Dpefts9e9RGZTGryEiRHVyy2k9NRomV098jjPgtfSR
         vWWEGIx9plSpLk1DhBsd1DiO+ZMoNcr1LFqV7VcdM/aBKWIXbKeF71gyFnib4eewTV6A
         gXp2d0tFJohtvNZBSQX2dgJkzIHfxw01cMKp34B0mbNSSOrOnmmubg5newyIWSjxux+Y
         jRstsWSCGjn2ABmKNOeCmMXTevO08Sdhb/A3wa6CENu0y1veMNUqPfpa3SSbqt1CIdMs
         LXacSM2fK9lNvQRfxB//NcR/gRDDn6+s1gSdJ3s8oQso92zHFknpxoZDc7IavfUNvI3R
         rckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yaTVSk0QhQ6Q3ONwqkunR+ld3cwrqWOmizyChyPBFII=;
        b=QL/8fDX++OGLS/npsTRW8ulu/gqw6ITEULMdjUpxicnFrMuCm1l6nuToWj7miVasxt
         a95J5RG9dlMZ1WJP9vIIrsxX1so1/wdQ+NxrW8KKmfdMdrOHTcikKIFuW3UvLRwP1cVD
         iJGWFPKHsg+/czpbM3GXGET4YodulYUJFWega3zBou/qExM0/daItjX4NLxn71syQfH5
         LlJRVKN2LXXE4E8VdJRjVos9D9J7w6z7yPjpCNT7WpKvjdmgpWCh8v0T+tfhg8/usQ2S
         qxzD1DVFeGRDzfMdTbzugp4O2v1ucUKTEzcLGBxMcQN6VEjE5Z8hrMTeBiRUkKsJoPX4
         8B3w==
X-Gm-Message-State: AOAM530ikwIxyEQiGg4c1fSMvfUmleMq2nRBZi815gfSIdofCAXIQahg
        DQRlnqEWOR5QDCRX03rRtANpWyZc2iqQGA==
X-Google-Smtp-Source: ABdhPJy5SATVXejtebcdAHyUIxrVx+lZhEgH1TUTSkdIPPrq2xzFuUIkzbmUAEOctC/EelRcZs920g==
X-Received: by 2002:a1c:491:: with SMTP id 139mr6366079wme.137.1630004307056;
        Thu, 26 Aug 2021 11:58:27 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2? (p200300ea8f084500b5d8a3dcf88fcae2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2])
        by smtp.googlemail.com with ESMTPSA id n4sm3773167wri.78.2021.08.26.11.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:58:26 -0700 (PDT)
Subject: [PATCH 3/7] PCI/VPD: Include post-processing in pci_vpd_find_tag()
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Message-ID: <fb15393f-d3b2-e140-2643-570d3abd7382@gmail.com>
Date:   Thu, 26 Aug 2021 20:55:07 +0200
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

Move pci_vpd_find_tag() post-processing from pci_vpd_find_ro_info_keyword()
to pci_vpd_find_tag(). This simplifies function pci_vpd_find_id_string()
that will be added in a subsequent patch.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 0e7a5e8a8..b7bf014cc 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -296,16 +296,25 @@ void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
 }
 EXPORT_SYMBOL_GPL(pci_vpd_alloc);
 
-static int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt)
+static int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt, unsigned int *size)
 {
 	int i = 0;
 
 	/* look for LRDT tags only, end tag is the only SRDT tag */
 	while (i + PCI_VPD_LRDT_TAG_SIZE <= len && buf[i] & PCI_VPD_LRDT) {
-		if (buf[i] == rdt)
+		unsigned int lrdt_len = pci_vpd_lrdt_size(buf + i);
+		u8 tag = buf[i];
+
+		i += PCI_VPD_LRDT_TAG_SIZE;
+		if (tag == rdt) {
+			if (i + lrdt_len > len)
+				lrdt_len = len - i;
+			if (size)
+				*size = lrdt_len;
 			return i;
+		}
 
-		i += PCI_VPD_LRDT_TAG_SIZE + pci_vpd_lrdt_size(buf + i);
+		i += lrdt_len;
 	}
 
 	return -ENOENT;
@@ -384,16 +393,10 @@ int pci_vpd_find_ro_info_keyword(const void *buf, unsigned int len,
 	int ro_start, infokw_start;
 	unsigned int ro_len, infokw_size;
 
-	ro_start = pci_vpd_find_tag(buf, len, PCI_VPD_LRDT_RO_DATA);
+	ro_start = pci_vpd_find_tag(buf, len, PCI_VPD_LRDT_RO_DATA, &ro_len);
 	if (ro_start < 0)
 		return ro_start;
 
-	ro_len = pci_vpd_lrdt_size(buf + ro_start);
-	ro_start += PCI_VPD_LRDT_TAG_SIZE;
-
-	if (ro_start + ro_len > len)
-		ro_len = len - ro_start;
-
 	infokw_start = pci_vpd_find_info_keyword(buf, ro_start, ro_len, kw);
 	if (infokw_start < 0)
 		return infokw_start;
-- 
2.33.0


