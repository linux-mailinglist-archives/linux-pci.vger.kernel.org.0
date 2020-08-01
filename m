Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2343C23522C
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgHAMZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgHAMYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF5C06174A;
        Sat,  1 Aug 2020 05:24:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so34005317ejj.10;
        Sat, 01 Aug 2020 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=epPKirRj4kip4paapWF+wmIvk6STec5g/eZ1qAPHqnE=;
        b=WMcFJpRf/lOxCS+UFtLRYapRWoI4RITRNpKoH0WYIEdRtQzRhdoJM2m+oowu10XQVF
         b5yyHM+bxdKOZwzUyFNMeVE0Y6pD916gDf+ubV+SJLsjKZhZKbMi6/41b1IZQfC0gX4z
         iHWbsPoAMIAr7CmBfOVmZA3Mm8zN9YJXKSe43HPcEzI+TBnGB3uESwep6+cCCJLvdYQO
         k3Pq9Rp6gCCZqAq8yzQ1WmyM1fXSxNSUSIlGAg+LcnL+b+VgXM3bpxQijNN2G4f+VA1Y
         TGPNWlVCuRTIuCWVZ/ljxMkjt8i7dsBo+m9iPBIADCaJcBBBwjV4T7Eult2TR9cZ8wZk
         Lyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=epPKirRj4kip4paapWF+wmIvk6STec5g/eZ1qAPHqnE=;
        b=rVN7kHxIFajJ8FN/MUj4619uJgY90wtbZrnjIlwc12Xt1dWZ90r+RaumgAMqhmwBjC
         qzBX84h2LS4BJpPNVnXehzHi/qgugPhUTZ7WpOusVOVcIQ0zOLJukxMbPQl38RobjOau
         RL167NCXI/PwiSo5DY30VZ4qTsjOtmu2v+nm/PAE0Bz9g8QuGoF5rB0s6oWZCPG002Go
         vQwzfEblyUhrfglHsyWbnw3kwKXosOGIVj94CkpLQYcvq/Y7HL9YBduC7e3hBKsMDACm
         J7v+QhyHQir6Ei4Gi9L5JM54tw4qMwaJUEaGta3mv/bdLlMr4fojQ9Dg8KkdCd+oS3Fi
         RbjQ==
X-Gm-Message-State: AOAM533BRfOutsSwl7R8tIjRTpaOGZF19729hEOQtxc1HJ+xMow75WvF
        SSo2zO8VZVj0HBG0pXsIgmV7cbgXDxNM1g==
X-Google-Smtp-Source: ABdhPJwuExwGM+Muatp1WuT205GPGAkYdwooFfx/4UjM/AxNCA9IZ5/VWUebqtI+PF1sFL/q0k+PDA==
X-Received: by 2002:a17:906:7f0b:: with SMTP id d11mr8932095ejr.116.1596284674567;
        Sat, 01 Aug 2020 05:24:34 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:34 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [RFC PATCH 08/17] gpio: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:37 +0200
Message-Id: <20200801112446.149549-9-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/gpio/gpio-amd8111.c |  7 +++++--
 drivers/gpio/gpio-rdc321x.c | 21 ++++++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
index fdcebe59510d..7b9882380cbc 100644
--- a/drivers/gpio/gpio-amd8111.c
+++ b/drivers/gpio/gpio-amd8111.c
@@ -198,9 +198,12 @@ static int __init amd_gpio_init(void)
 	goto out;
 
 found:
-	err = pci_read_config_dword(pdev, 0x58, &gp.pmbase);
-	if (err)
+	pci_read_config_dword(pdev, 0x58, &gp.pmbase);
+	if (gp.pmbase == (u32)~0) {
+		err = -ENODEV;
 		goto out;
+	}
+
 	err = -EIO;
 	gp.pmbase &= 0x0000FF00;
 	if (gp.pmbase == 0)
diff --git a/drivers/gpio/gpio-rdc321x.c b/drivers/gpio/gpio-rdc321x.c
index 01ed2517e9fd..03f1ff07b844 100644
--- a/drivers/gpio/gpio-rdc321x.c
+++ b/drivers/gpio/gpio-rdc321x.c
@@ -85,10 +85,13 @@ static int rdc_gpio_config(struct gpio_chip *chip,
 	gpch = gpiochip_get_data(chip);
 
 	spin_lock(&gpch->lock);
-	err = pci_read_config_dword(gpch->sb_pdev, gpio < 32 ?
-			gpch->reg1_ctrl_base : gpch->reg2_ctrl_base, &reg);
-	if (err)
+	pci_read_config_dword(gpch->sb_pdev,
+				(gpio < 32) ? gpch->reg1_ctrl_base
+					: gpch->reg2_ctrl_base, &reg);
+	if (reg == (u32)~0) {
+		err = -ENODEV;
 		goto unlock;
+	}
 
 	reg |= 1 << (gpio & 0x1f);
 
@@ -166,17 +169,17 @@ static int rdc321x_gpio_probe(struct platform_device *pdev)
 	/* This might not be, what others (BIOS, bootloader, etc.)
 	   wrote to these registers before, but it's a good guess. Still
 	   better than just using 0xffffffff. */
-	err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
+	pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
 					rdc321x_gpio_dev->reg1_data_base,
 					&rdc321x_gpio_dev->data_reg[0]);
-	if (err)
-		return err;
+	if (rdc321x_gpio_dev->data_reg[0] == (u32)~0)
+		return -ENODEV;
 
-	err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
+	pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
 					rdc321x_gpio_dev->reg2_data_base,
 					&rdc321x_gpio_dev->data_reg[1]);
-	if (err)
-		return err;
+	if (rdc321x_gpio_dev->data_reg[1] == (u32)~0)
+		return -ENODEV;
 
 	dev_info(&pdev->dev, "registering %d GPIOs\n",
 					rdc321x_gpio_dev->chip.ngpio);
-- 
2.18.4

