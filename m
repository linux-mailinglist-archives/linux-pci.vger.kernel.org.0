Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319E137FF8B
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 22:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhEMVAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhEMVAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 17:00:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A14C061574
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:59:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 8so839555wmc.5
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G8Z0UQqtafs8h1p+WkxnF/FQBX1MA7dX49CozQ6F0fA=;
        b=ogQ0IQ9IaDuGbCbjOZhZcEf72zbdhOANFaDWjcHdHsOLLJ9SDCtrR9TZIEX7gMV95m
         36WEDSmSJjBzS+2b8JQBtFaKVGw9sppC219cqLuQllX//gGQGOPPf9+N0eUrdu0qtPuy
         K3y8Buk3vpi9lNgYkINiMkRm7l8gxSMXKLc2Hx4VMcfBcHEmc/IE59CxybtUf30TKWVM
         t6jyrWGQIr4/ISfLyvBuqDOoUp53U/cHo1bofS1I3Cl4mwxvABXonuAbC5ii9Gse5U7c
         ygSrKEDcXxTPFxVhExWT3bd5Hn20Od2B2qzzICqTJPcRIsC8SKFsQyUwgUPGPfP1c0d3
         Lj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G8Z0UQqtafs8h1p+WkxnF/FQBX1MA7dX49CozQ6F0fA=;
        b=qOjD7ohhJiCXqoFXGR8vfdFxXDzRGOAiWyj1i/4koRAFKEpBoN2DArXikUlOHjCX2i
         PraEhf3lL3wfPRk/DUyuJD6Iu0J7MyUuyeV70gzRm/+gV1lbtRVPbb1fTsVeTQdrTq0/
         s+pPuGsK3UZmVGxJKsrwh7Mvr41aVFTHVneeB7RizzUZKOblGkX9OjzuQtvwQ4YIOosM
         2+dcgni2TSdshHxIEQpfdhTJ8egJiBTqElUkM/jCPvNizHZI7NST++xkOSVq4T8WEQEN
         PyIkOWp/FPVX9Dt/zY9NztmRmI1PoSigVqTpUPy7nBplILK1yo+56aHsotSevojOS3h3
         4XXg==
X-Gm-Message-State: AOAM530XTcSieR5CQ3dItErhX4t2BoF2mr2GD26hrnJu1DYtN6MOSwon
        1fH1rBIrC/kfirdjx4nOT9gYFzY4AnQoxw==
X-Google-Smtp-Source: ABdhPJxUDrlOuipoeFvke2BQF26lGOlnxPtgPd3LjlRDwIqvcpZhFwkc2Z6fM+zSGdIOlWT2ZR1mOg==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr5593390wmk.90.1620939547292;
        Thu, 13 May 2021 13:59:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:dc15:2d50:47c3:384f? (p200300ea8f384600dc152d5047c3384f.dip0.t-ipconnect.de. [2003:ea:8f38:4600:dc15:2d50:47c3:384f])
        by smtp.googlemail.com with ESMTPSA id 136sm1858456wmb.7.2021.05.13.13.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:59:06 -0700 (PDT)
Subject: [PATCH 1/5] PCI/VPD: Refactor pci_vpd_size
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Message-ID: <1cdda5f1-e1ea-af9f-cfbe-952b7d37e246@gmail.com>
Date:   Thu, 13 May 2021 22:58:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The only Short Resource Data Type tag is the end tag. This allows to
remove the generic SRDT tag handling and the code be significantly
simplified.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 46 ++++++++++++----------------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 26bf7c877..ecdce170f 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -73,50 +73,28 @@ EXPORT_SYMBOL(pci_write_vpd);
 static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 {
 	size_t off = 0;
-	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
+	u8 header[3];	/* 1 byte tag, 2 bytes length */
 
 	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
-		unsigned char tag;
-
 		if (!header[0] && !off) {
 			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
 			return 0;
 		}
 
-		if (header[0] & PCI_VPD_LRDT) {
-			/* Large Resource Data Type Tag */
-			tag = pci_vpd_lrdt_tag(header);
-			/* Only read length from known tag items */
-			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
-			    (tag == PCI_VPD_LTIN_RO_DATA) ||
-			    (tag == PCI_VPD_LTIN_RW_DATA)) {
-				if (pci_read_vpd(dev, off+1, 2,
-						 &header[1]) != 2) {
-					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
-						 tag, off + 1);
-					return 0;
-				}
-				off += PCI_VPD_LRDT_TAG_SIZE +
-					pci_vpd_lrdt_size(header);
-			}
-		} else {
-			/* Short Resource Data Type Tag */
-			off += PCI_VPD_SRDT_TAG_SIZE +
-				pci_vpd_srdt_size(header);
-			tag = pci_vpd_srdt_tag(header);
-		}
-
-		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
-			return off;
+		if (header[0] == PCI_VPD_SRDT_END)
+			return off + PCI_VPD_SRDT_TAG_SIZE;
 
-		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
-		    (tag != PCI_VPD_LTIN_RO_DATA) &&
-		    (tag != PCI_VPD_LTIN_RW_DATA)) {
-			pci_warn(dev, "invalid %s VPD tag %02x at offset %zu",
-				 (header[0] & PCI_VPD_LRDT) ? "large" : "short",
-				 tag, off);
+		if (header[0] != PCI_VPD_LRDT_ID_STRING &&
+		    header[0] != PCI_VPD_LRDT_RO_DATA &&
+		    header[0] != PCI_VPD_LRDT_RW_DATA) {
+			pci_warn(dev, "invalid VPD tag %02x at offset %zu", header[0], off);
 			return 0;
 		}
+
+		if (pci_read_vpd(dev, off + 1, 2, header + 1) != 2)
+			return 0;
+
+		off += PCI_VPD_LRDT_TAG_SIZE + pci_vpd_lrdt_size(header);
 	}
 	return 0;
 }
-- 
2.31.1


