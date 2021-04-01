Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC0351CE8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhDASXA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbhDASPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 14:15:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16006C03114F
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 09:44:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so2483707wrd.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgXjFPEoVaKS4YN67IbL3DtnNePGHAFX/A1y+wQ+Nhw=;
        b=je19boQ1u0Vem3uvE5ckt396JTGv5v1CMLlH4c0OnvUrEftWESjKcJSLueNIMCMNmp
         92iOA4MnavdJpmP1GjsCBELLAoxftCVSIweIHq6IG+SUmP7TUJN5MzxaNlc8IcepOpR6
         Drtv2d0txSKaaiMG3d9egeDF+RViJitEWtm7wken0Fo+E3zvJAUS3W1VKTqK9mcMIf8y
         MFJYM0u2fVOzULMiTQyMvwgysqkk24LHRmxB742JoCkb4ZNLUu9v+D9vlPaZY1e4GvwA
         tu+Seh1OHL8E4N3xjk194iuTPTkWwBUxJNeJyo2tD308A51ukRSosd1F9MgjjAsVuCp/
         R4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgXjFPEoVaKS4YN67IbL3DtnNePGHAFX/A1y+wQ+Nhw=;
        b=MHFwsR/5KwOIfg5WMbvbnYRQVzu60HmW3MzGog3ViUVS7miW8pqMjwAx1hHrgdstXz
         /DSF8CeUlNoKc483NeVVxLza/qxilLBeSwl9cUTKI/r7rG3o87S3+xUlPlsMg2wGqtLu
         oZs6TBsPe7lwyo/bwDdqMdkSjwALVdYP5/1Lbs8Y2hu8XY9e7g4EbcnEn1Nnbp0xn1nD
         aq+f/e6LMP5BxyEao8okOkE/ddXuZChN0QfOVConVAGG0EvOHX2w2447eWkqTP6PC8vf
         WkRQvYDgwWG+ibeH4NIBvXBQ043mOlUH8SCJ4smu8mncF1J2sL+ycgdxVvtPJMNQGqFv
         eUPA==
X-Gm-Message-State: AOAM532cMhRt5fQKiqCXdQ+yvX5AxlvT5lAz1l/Wxi9x6NY0YCAMsXBa
        2fDZpJ6lS7cwvqlGwVh1pog7rgMsUIIrWg==
X-Google-Smtp-Source: ABdhPJxhGXXHDJNl/7F6ep81YKiWZmX5kPbn1VqqRG2VKNzfx+SJ6yMRaMnvW+N1bfijOpJxef09qA==
X-Received: by 2002:adf:e481:: with SMTP id i1mr11165085wrm.63.1617295478442;
        Thu, 01 Apr 2021 09:44:38 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:5544:e633:d47e:4b76? (p200300ea8f1fbb005544e633d47e4b76.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5544:e633:d47e:4b76])
        by smtp.googlemail.com with ESMTPSA id p12sm10524126wrx.28.2021.04.01.09.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:44:37 -0700 (PDT)
Subject: [PATCH 3/3] PCI/VPD: Improve and simplify pci_vpd_find_tag
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Message-ID: <3f63f06f-734f-8fff-9518-27fe1faf903d@gmail.com>
Date:   Thu, 1 Apr 2021 18:44:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only SRDT tag is the end tag, and no caller is interested in it.
This allows to remove all SRDT tag handling.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 5b80db02d..45f1d73f8 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -369,33 +369,14 @@ void pci_vpd_release(struct pci_dev *dev)
 
 int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt)
 {
-	int i;
-
-	for (i = 0; i < len; ) {
-		u8 val = buf[i];
-
-		if (val & PCI_VPD_LRDT) {
-			/* Don't return success of the tag isn't complete */
-			if (i + PCI_VPD_LRDT_TAG_SIZE > len)
-				break;
+	int i = 0;
 
-			if (val == rdt)
-				return i;
-
-			i += PCI_VPD_LRDT_TAG_SIZE +
-			     pci_vpd_lrdt_size(&buf[i]);
-		} else {
-			u8 tag = val & ~PCI_VPD_SRDT_LEN_MASK;
-
-			if (tag == rdt)
-				return i;
-
-			if (tag == PCI_VPD_SRDT_END)
-				break;
+	/* look for LRDT tags only, end tag is the only SRDT tag */
+	while (i + PCI_VPD_LRDT_TAG_SIZE <= len && buf[i] & PCI_VPD_LRDT) {
+		if (buf[i] == rdt)
+			return i;
 
-			i += PCI_VPD_SRDT_TAG_SIZE +
-			     pci_vpd_srdt_size(&buf[i]);
-		}
+		i += PCI_VPD_LRDT_TAG_SIZE + pci_vpd_lrdt_size(buf + i);
 	}
 
 	return -ENOENT;
-- 
2.31.1


