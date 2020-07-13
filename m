Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2515021D6F2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgGMNYu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgGMNXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03ADC061755;
        Mon, 13 Jul 2020 06:23:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bm28so11680454edb.2;
        Mon, 13 Jul 2020 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wedHCIChLPI3W8eJR45NkujB6S4xOXi2tVCNNo2QC2g=;
        b=IFgUkHYUyQ5yQAzQIlZ+QKHSWJi9aV4DKXkMTpCLI8tz4cQXE4ag3ugFeOcFKQDAyg
         EWa9qIrHkYxPAJMSO1gtMhCpe4qELsErSvppuGNJeWxNdWzvDhTiuvD3oVrtf/NAydtg
         MMLlkhS/HPlMjHrJlNIMh2U1vizkVtujUJ2nmM5X4BuI9pCfdNmVNOFQR4NYYZYsC9/4
         sHf+92UmiYhr5XXjzOV0iy3+CXdhk5s1srXZ8SsGqDwta9X7ukdKtB4sJM3DiCjYV3vO
         z6r3AXhLllgg51T6aLGw2V2K7xpabsbgWOYO39XhFApMzMcWe3gwJclj1XZKAsYJ5ncU
         gY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wedHCIChLPI3W8eJR45NkujB6S4xOXi2tVCNNo2QC2g=;
        b=UF3glH2OseE0PRxdhlnfheU7WN/QnOa/OSngRIHuWVMlLcLw4znb/rFLyAOuanNguY
         yzO1BKaehXlmwRgkrpUE780L//4JBMjRc/EeleMfrjzPvcnYwakYUocAWWdwKCy8hB9/
         72QWnopFImfWhNn+mjNTPk4Jok5sONow6P8hKyWjCSSBKKl+965Jrefl8noW/GqlM06E
         JsZ4vcV689vpkku9y0t92kYI+DbszLyMUqKMPbY9J3fc3rx6mJ3pDFBzQUpZmMSgjIO7
         YDw78rVY5hXztQ0OYR6jPW044MpUfhqz6YhoM5fP6UeJEIId+v2mv3sG1VWnjq7AUNY1
         /iYQ==
X-Gm-Message-State: AOAM533V+e/0P0Rt3tNGR9G64zaQhnCBxABy9a5eBhNmNJDx/0VsJRUr
        hZ+f5rzSrIjigJIB3gjCzoY=
X-Google-Smtp-Source: ABdhPJz3+R8EMDUd8r+h17AEUUENNjntQ7SKL3N/QarL0j05KmXQg0LEb8ICq9q0/JqFa1l7NL7ZDg==
X-Received: by 2002:aa7:c504:: with SMTP id o4mr89798702edq.311.1594646579546;
        Mon, 13 Jul 2020 06:22:59 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:59 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 16/35] hwmon: (sis5595) Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:28 +0200
Message-Id: <20200713122247.10985-17-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/hwmon/sis5595.c | 8 ++++----
 drivers/hwmon/via686a.c | 8 ++++----
 drivers/hwmon/vt8231.c  | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 0c6741f949f5..0ea174fb3048 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -825,7 +825,7 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 		pci_write_config_word(dev, SIS5595_BASE_REG, force_addr);
 	}
 
-	if (PCIBIOS_SUCCESSFUL !=
+	if (0 !=
 	    pci_read_config_word(dev, SIS5595_BASE_REG, &address)) {
 		dev_err(&dev->dev, "Failed to read ISA address\n");
 		return -ENODEV;
@@ -843,16 +843,16 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL !=
+	if (0 !=
 	    pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable)) {
 		dev_err(&dev->dev, "Failed to read enable register\n");
 		return -ENODEV;
 	}
 	if (!(enable & 0x80)) {
-		if ((PCIBIOS_SUCCESSFUL !=
+		if ((0 !=
 		     pci_write_config_byte(dev, SIS5595_ENABLE_REG,
 					   enable | 0x80))
-		 || (PCIBIOS_SUCCESSFUL !=
+		 || (0 !=
 		     pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable))
 		 || (!(enable & 0x80))) {
 			/* doesn't work for some chips! */
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index a2eddd2c2538..cffea688878f 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -863,11 +863,11 @@ static int via686a_pci_probe(struct pci_dev *dev,
 	if (force_addr) {
 		address = force_addr & ~(VIA686A_EXTENT - 1);
 		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n", address);
-		if (PCIBIOS_SUCCESSFUL !=
+		if (0 !=
 		    pci_write_config_word(dev, VIA686A_BASE_REG, address | 1))
 			return -ENODEV;
 	}
-	if (PCIBIOS_SUCCESSFUL !=
+	if (0 !=
 	    pci_read_config_word(dev, VIA686A_BASE_REG, &val))
 		return -ENODEV;
 
@@ -878,7 +878,7 @@ static int via686a_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL !=
+	if (0 !=
 	    pci_read_config_word(dev, VIA686A_ENABLE_REG, &val))
 		return -ENODEV;
 	if (!(val & 0x0001)) {
@@ -890,7 +890,7 @@ static int via686a_pci_probe(struct pci_dev *dev,
 		}
 
 		dev_warn(&dev->dev, "Enabling sensors\n");
-		if (PCIBIOS_SUCCESSFUL !=
+		if (0 !=
 		    pci_write_config_word(dev, VIA686A_ENABLE_REG,
 					  val | 0x0001))
 			return -ENODEV;
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 2335d440f72d..cc1d24c2a2c8 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -987,12 +987,12 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n",
 			 address);
 
-		if (PCIBIOS_SUCCESSFUL !=
+		if (0 !=
 		    pci_write_config_word(dev, VT8231_BASE_REG, address | 1))
 			return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_BASE_REG,
+	if (0 != pci_read_config_word(dev, VT8231_BASE_REG,
 							&val))
 		return -ENODEV;
 
@@ -1002,13 +1002,13 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_ENABLE_REG,
+	if (0 != pci_read_config_word(dev, VT8231_ENABLE_REG,
 							&val))
 		return -ENODEV;
 
 	if (!(val & 0x0001)) {
 		dev_warn(&dev->dev, "enabling sensors\n");
-		if (PCIBIOS_SUCCESSFUL !=
+		if (0 !=
 			pci_write_config_word(dev, VT8231_ENABLE_REG,
 							val | 0x0001))
 			return -ENODEV;
-- 
2.18.2

