Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B73E3BDE
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 19:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhHHRUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhHHRTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 13:19:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56282C061760
        for <linux-pci@vger.kernel.org>; Sun,  8 Aug 2021 10:19:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b13so18208802wrs.3
        for <linux-pci@vger.kernel.org>; Sun, 08 Aug 2021 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L8rDTmouG5tACcWkL3LAGSDRDzrjpaFRhkMDBNhwt3I=;
        b=O2aAk1rI01AR9M5PjOrMm4sGSD6/HQ2DxfK/c+UBt/4zAPuvux9tyB/4TODmVm95Ki
         0QGRJIu8MURakna/5CAiwUtgU27h9R2jYzeCzxisPD1jyFMDkDC3cuFVmkrFpfZdzfoZ
         vU1/KueHW57M3r6m2Sj4Zy5NRT8tDVcSow/u6AfR3+2gKnTsUuokLskXChOLh5HTESU6
         0ofRIzZDt9f4uCr4m9c7wDVCrVi0kyRFom8nyE+dDUB0Dtc68IT0pJfSXsu8Iz4Edznw
         eKRLrm/6XuGADhK0j+PFQmgxYKihNCnREhOwQddsleRiXFoEQN8luF3W6y+F+Viy84CB
         F8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L8rDTmouG5tACcWkL3LAGSDRDzrjpaFRhkMDBNhwt3I=;
        b=Ypyhv2My7mq9O9z8vd211VT77tGNNouP6eLis1vFEwgUCD94fc8zIoi2o2cBYVEvIG
         DkMqBTjOHV0iG6stf8M8wEk0EeZKfjw0CJG1Z2kGFRDzUYx+qomOjOZjy/p/rvW4s9z2
         n1iVSF/mFZZQMvUdjUXvJWwZLopC7oK1J7ca6fV5cz3F1UBOOciDfqEjHTqCJeJQFXgj
         LyydiHvdlHQ3O2FLnIfuikH10i2uf/XprQUMBpxr7tB930aBRFWT+QCwmJkeNq9pP384
         zs5uFZ6QwcVnwOBcExvAjnxR+pPp1OmSgw4yLn8hp2aVzVmi/xoyIQqRbcVsBqxw91sH
         ndUA==
X-Gm-Message-State: AOAM533jPmqsoXNYt1f68d7w785y24ycb5N7NWXz5qvrdqhYphYUV7ec
        T6Str6B3iQo1elJdAcFkd1HqOQC9AyZL4g==
X-Google-Smtp-Source: ABdhPJyPHHs6gT6W6W2LyUBuq3IGWdxbij4CaCZLj6m5v+dnEjYvtibfEE//rC+QBDkoN2UekUUnpA==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr20938663wru.343.1628443152261;
        Sun, 08 Aug 2021 10:19:12 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:7101:8b48:5eab:cb5f? (p200300ea8f10c20071018b485eabcb5f.dip0.t-ipconnect.de. [2003:ea:8f10:c200:7101:8b48:5eab:cb5f])
        by smtp.googlemail.com with ESMTPSA id g11sm17019619wrd.97.2021.08.08.10.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:19:11 -0700 (PDT)
Subject: [PATCH 1/6] PCI/VPD: Move pci_read/write_vpd in the code
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Message-ID: <89f0f5a2-293b-a017-fc67-a36473a792bf@gmail.com>
Date:   Sun, 8 Aug 2021 19:19:10 +0200
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

In preparation of subsequent patches move these two functions in the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 60 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 5e2e63809..e87f299ee 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -31,36 +31,6 @@ static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
 	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 }
 
-/**
- * pci_read_vpd - Read one entry from Vital Product Data
- * @dev:	pci device struct
- * @pos:	offset in vpd space
- * @count:	number of bytes to read
- * @buf:	pointer to where to store result
- */
-ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
-{
-	if (!dev->vpd || !dev->vpd->ops)
-		return -ENODEV;
-	return dev->vpd->ops->read(dev, pos, count, buf);
-}
-EXPORT_SYMBOL(pci_read_vpd);
-
-/**
- * pci_write_vpd - Write entry to Vital Product Data
- * @dev:	pci device struct
- * @pos:	offset in vpd space
- * @count:	number of bytes to write
- * @buf:	buffer containing write data
- */
-ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
-{
-	if (!dev->vpd || !dev->vpd->ops)
-		return -ENODEV;
-	return dev->vpd->ops->write(dev, pos, count, buf);
-}
-EXPORT_SYMBOL(pci_write_vpd);
-
 #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
 
 /**
@@ -409,6 +379,36 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 }
 EXPORT_SYMBOL_GPL(pci_vpd_find_info_keyword);
 
+/**
+ * pci_read_vpd - Read one entry from Vital Product Data
+ * @dev:	pci device struct
+ * @pos:	offset in vpd space
+ * @count:	number of bytes to read
+ * @buf:	pointer to where to store result
+ */
+ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
+{
+	if (!dev->vpd || !dev->vpd->ops)
+		return -ENODEV;
+	return dev->vpd->ops->read(dev, pos, count, buf);
+}
+EXPORT_SYMBOL(pci_read_vpd);
+
+/**
+ * pci_write_vpd - Write entry to Vital Product Data
+ * @dev:	pci device struct
+ * @pos:	offset in vpd space
+ * @count:	number of bytes to write
+ * @buf:	buffer containing write data
+ */
+ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
+{
+	if (!dev->vpd || !dev->vpd->ops)
+		return -ENODEV;
+	return dev->vpd->ops->write(dev, pos, count, buf);
+}
+EXPORT_SYMBOL(pci_write_vpd);
+
 #ifdef CONFIG_PCI_QUIRKS
 /*
  * Quirk non-zero PCI functions to route VPD access through function 0 for
-- 
2.32.0


