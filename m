Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470F821D6E3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgGMNXF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgGMNXC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:02 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234E9C061755;
        Mon, 13 Jul 2020 06:23:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ga4so17129725ejb.11;
        Mon, 13 Jul 2020 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WeyIeoPZJMXK7vhLHL5c0YV2wwYi5JPUEFrxzTX8RvU=;
        b=va14DwSpJTk8Hv73zRY2TzzhxmZEFmEKBsfKXWnt/tzVTOr74i7qtpDWIp4vmQMCAk
         wxYB0bW9tYz22zJj8OOtOi6N6bWeBzWo3lSiWKmps+V96kj1qxSE3QFi9C2Gzqd5YZaX
         6cOeVRPEPWamg1UBvZrCC3b9/xKGFeZ/lvllDTgYQ67sZ6eseA6VrCI4nMR9ipMAdB5V
         8IjA/EOJGUyLhipxOaXpWCoZTwBGBotZf2uFyOnPyLWJMxn4IAzBLMREPrQdOH3U+WJK
         Lo/IdoSaucGHkIZCHDI2TlTI3UEyeqroXs5xoA5KQ2KdyUlT+5/nUpNxnknP4tFcEAJy
         jB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WeyIeoPZJMXK7vhLHL5c0YV2wwYi5JPUEFrxzTX8RvU=;
        b=LGg7jsKXoaN+pSGau4pwB+fE4mRTgpbIYaSznKlPphSlWwFXGJG+gOQgLtI47bU+nI
         39MH1Qwq6tcRw9WeKrC/L7NojJ5wIkG72YUqxVGzsQc8ebjhn7/Mc/RPspsYSahoZ0kO
         A2PwotGPL1+lccwWnkom4gQ9I97aw3+VBRfjQGlcViCVu1ejtlViHmaW9mcc0acQwBCj
         +gtDQ+rRSO5QQQ95Psee0F7jwo+d2/ffYCrTcOksKp8Vf4uflld6+VsMModbvXkvv8Bl
         JV/oNm+gBP3aVq5f8JICACaHbvbGmm5GchHlLsfLXoCO2hlXkAIphnAfXilhChJJbQkC
         sEkg==
X-Gm-Message-State: AOAM531cOrjuGO8j92TLQY4S96Ul1MdFEHh5ghhgMLpc0Hf71NiipaAD
        MZwJpwI8Wa+pxm3nx4P1mrEvMrEtjiC+hQ==
X-Google-Smtp-Source: ABdhPJwUjqmZeNSlCTAl57KxA+cutsVpR1kCU85dk+qzkHj4E1FjAK7/IQ+7zYeHb5tZSd31kCRd1A==
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr77156370ejw.170.1594646580813;
        Mon, 13 Jul 2020 06:23:00 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:00 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 17/35] hwmon: (sis5595) Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:29 +0200
Message-Id: <20200713122247.10985-18-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 16/35

 drivers/hwmon/sis5595.c | 13 ++++---------
 drivers/hwmon/via686a.c | 13 ++++---------
 drivers/hwmon/vt8231.c  | 13 ++++---------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 0ea174fb3048..91fdddaa4136 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -825,8 +825,7 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 		pci_write_config_word(dev, SIS5595_BASE_REG, force_addr);
 	}
 
-	if (0 !=
-	    pci_read_config_word(dev, SIS5595_BASE_REG, &address)) {
+	if (pci_read_config_word(dev, SIS5595_BASE_REG, &address)) {
 		dev_err(&dev->dev, "Failed to read ISA address\n");
 		return -ENODEV;
 	}
@@ -843,17 +842,13 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (0 !=
-	    pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable)) {
+	if (pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable)) {
 		dev_err(&dev->dev, "Failed to read enable register\n");
 		return -ENODEV;
 	}
 	if (!(enable & 0x80)) {
-		if ((0 !=
-		     pci_write_config_byte(dev, SIS5595_ENABLE_REG,
-					   enable | 0x80))
-		 || (0 !=
-		     pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable))
+		if ((pci_write_config_byte(dev, SIS5595_ENABLE_REG, enable | 0x80))
+		 || (pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable))
 		 || (!(enable & 0x80))) {
 			/* doesn't work for some chips! */
 			dev_err(&dev->dev, "Failed to enable HWM device\n");
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index cffea688878f..b8466e2e1435 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -863,12 +863,10 @@ static int via686a_pci_probe(struct pci_dev *dev,
 	if (force_addr) {
 		address = force_addr & ~(VIA686A_EXTENT - 1);
 		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n", address);
-		if (0 !=
-		    pci_write_config_word(dev, VIA686A_BASE_REG, address | 1))
+		if (pci_write_config_word(dev, VIA686A_BASE_REG, address | 1))
 			return -ENODEV;
 	}
-	if (0 !=
-	    pci_read_config_word(dev, VIA686A_BASE_REG, &val))
+	if (pci_read_config_word(dev, VIA686A_BASE_REG, &val))
 		return -ENODEV;
 
 	address = val & ~(VIA686A_EXTENT - 1);
@@ -878,8 +876,7 @@ static int via686a_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (0 !=
-	    pci_read_config_word(dev, VIA686A_ENABLE_REG, &val))
+	if (pci_read_config_word(dev, VIA686A_ENABLE_REG, &val))
 		return -ENODEV;
 	if (!(val & 0x0001)) {
 		if (!force_addr) {
@@ -890,9 +887,7 @@ static int via686a_pci_probe(struct pci_dev *dev,
 		}
 
 		dev_warn(&dev->dev, "Enabling sensors\n");
-		if (0 !=
-		    pci_write_config_word(dev, VIA686A_ENABLE_REG,
-					  val | 0x0001))
+		if (pci_write_config_word(dev, VIA686A_ENABLE_REG, val | 0x0001))
 			return -ENODEV;
 	}
 
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index cc1d24c2a2c8..ee6cd6b85f91 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -987,13 +987,11 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n",
 			 address);
 
-		if (0 !=
-		    pci_write_config_word(dev, VT8231_BASE_REG, address | 1))
+		if (pci_write_config_word(dev, VT8231_BASE_REG, address | 1))
 			return -ENODEV;
 	}
 
-	if (0 != pci_read_config_word(dev, VT8231_BASE_REG,
-							&val))
+	if (pci_read_config_word(dev, VT8231_BASE_REG, &val))
 		return -ENODEV;
 
 	address = val & ~(VT8231_EXTENT - 1);
@@ -1002,15 +1000,12 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (0 != pci_read_config_word(dev, VT8231_ENABLE_REG,
-							&val))
+	if (pci_read_config_word(dev, VT8231_ENABLE_REG, &val))
 		return -ENODEV;
 
 	if (!(val & 0x0001)) {
 		dev_warn(&dev->dev, "enabling sensors\n");
-		if (0 !=
-			pci_write_config_word(dev, VT8231_ENABLE_REG,
-							val | 0x0001))
+		if (pci_write_config_word(dev, VT8231_ENABLE_REG, val | 0x0001))
 			return -ENODEV;
 	}
 
-- 
2.18.2

