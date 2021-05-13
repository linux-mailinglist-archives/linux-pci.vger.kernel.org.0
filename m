Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0537FF89
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhEMVAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 17:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhEMVAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 17:00:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B09C06174A
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:59:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so496217wmq.0
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rhe9xzTsUM7XOWGRiaEe44S1N02oZhvUJrE4FQ7so2w=;
        b=F9xrnnCIdiqD3byyObLpI7r1GSZTS9jL9BQk9jHs6BzkYewxqsyNpkEqZnzklH53V4
         luo003Esmict7q4YFgXqGZLy+SGYA6zqNiLnr0fYwxAicYhFVOkZXn53b1KZEifTFUME
         5YgZh1o5uBW3CH8ndWCBBFsy7jym7fYkWzi7vMTMwxDt5RPGevrqQb6HgEiITotDYGvt
         iJuf+aLQ5EZqFgokXS//x6VBF9YyxWHMZeN4oyVsLFWHMWwt6ShuNfV/9fGBJ17NoYz3
         mSdgBUocKJzLiIlUCGqOcQIxhZZbA68jgNjLKrXVGUNbPCNd7V4+ahHbuzmOxn5vuRd5
         7EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rhe9xzTsUM7XOWGRiaEe44S1N02oZhvUJrE4FQ7so2w=;
        b=CRcqA3iPc+z5MPk2/wAz/7LZkiqHhYtaywzWpvV6REj3dlsyWeTxO23LadjO/fwS51
         B0ac4CniExA9KfRaYxd0aSSqx+J/gFORJkpbds9j8bbMKUlIa81BsyrPB6fgZtmjSVw+
         hb95RQ3JGu2zYDM4+fn8olPdXd6xW7DlGiQSKwSwgfJCJ18eYThORyZeEAWy5LfphooR
         I/S6jnOhKB1SMepzywXVAnd0Tcj6nYPcQwqBuvF30L7RfMpXrOUQw+d98QlsYmiSkpKL
         AenYOoGraKVKuy9qI0fWnZeNmKzhbTttSLzitLGqvOFMtH8+cNtO6MiWyu6AnnMrAPNU
         jb0w==
X-Gm-Message-State: AOAM531iMPB8Boq9syuS06i5bBR1d43T+DdzRnvQn/T1w8F7LESsHDvp
        tQtVhjEI9nDkVOQoXC3xVJivOVR7YjMqDA==
X-Google-Smtp-Source: ABdhPJzhQnQyc1kJs9Ez314fzB6i2dL77qgPngWkUqyk4sPacW0kXD/Y8PR+XrM4y6lEbRCVqWkImg==
X-Received: by 2002:a05:600c:19c8:: with SMTP id u8mr5864793wmq.50.1620939540072;
        Thu, 13 May 2021 13:59:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:dc15:2d50:47c3:384f? (p200300ea8f384600dc152d5047c3384f.dip0.t-ipconnect.de. [2003:ea:8f38:4600:dc15:2d50:47c3:384f])
        by smtp.googlemail.com with ESMTPSA id n5sm4080091wrx.31.2021.05.13.13.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:58:59 -0700 (PDT)
Subject: [PATCH 3/5] PCI/VPD: Remove old_size argument from pci_vpd_size
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Message-ID: <ede36c16-5335-6867-43a1-293641348430@gmail.com>
Date:   Thu, 13 May 2021 22:56:09 +0200
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

vpd->len is initialized to PCI_VPD_MAX_SIZE, and if a quirk is used to
set a specific VPD size, then pci_vpd_set_size() sets vpd->valid,
resulting in pci_vpd_size() not being called. Therefore we can remove
the old_size argument. Note that we don't have to check
off < PCI_VPD_MAX_SIZE because that's implicitly done by pci_read_vpd().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index ff537371c..e73a3a55f 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -75,14 +75,13 @@ EXPORT_SYMBOL(pci_write_vpd);
 /**
  * pci_vpd_size - determine actual size of Vital Product Data
  * @dev:	pci device struct
- * @old_size:	current assumed size, also maximum allowed size
  */
-static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
+static size_t pci_vpd_size(struct pci_dev *dev)
 {
 	size_t off = 0;
 	u8 header[3];	/* 1 byte tag, 2 bytes length */
 
-	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
+	while (pci_read_vpd(dev, off, 1, header) == 1) {
 		if (!header[0] && !off) {
 			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
 			return 0;
@@ -164,7 +163,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 
 	if (!vpd->valid) {
 		vpd->valid = 1;
-		vpd->len = pci_vpd_size(dev, vpd->len);
+		vpd->len = pci_vpd_size(dev);
 	}
 
 	if (vpd->len == 0)
@@ -231,7 +230,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 
 	if (!vpd->valid) {
 		vpd->valid = 1;
-		vpd->len = pci_vpd_size(dev, vpd->len);
+		vpd->len = pci_vpd_size(dev);
 	}
 
 	if (vpd->len == 0)
@@ -455,6 +454,7 @@ static void quirk_blacklist_vpd(struct pci_dev *dev)
 {
 	if (dev->vpd) {
 		dev->vpd->len = 0;
+		dev->vpd->valid = 1;
 		pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
 	}
 }
-- 
2.31.1


