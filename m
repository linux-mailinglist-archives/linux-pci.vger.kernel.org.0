Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBD235228
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgHAMZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgHAMYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:38 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C7C06174A;
        Sat,  1 Aug 2020 05:24:38 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c2so18272473edx.8;
        Sat, 01 Aug 2020 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bdwFdqR8uTJkBxeLE6+6M0ZT6V7Ev5F6Fk3j55l8Z9k=;
        b=iYcYgSrZmWlo3R6AUjHZkTUqWlOCuvWQfp9o/jYHquATEwsySoI7qb/5R298C4XuP6
         41LiSJR2F+wAaeJbMOPDCVFPHsL0+Fo4vxG7q9em4PQJboP6PNqu/EZa36fMsM/zZbBz
         JCHW/o6zUF9a2HzOkDNo+9vZ2c5PCBRDQeUpdDN2BOT+MMhqCt4g8i2V0lS4IiBQw05V
         he5n2kloQO33fgxJyOaPrLYN0f7EOtJSixf210mNPyBCU5yXE9oEPpuWtwkow02lziQ5
         AygMJ24A5io1qUJTTJ+itzp+4YiuCii7XbUXLOjJXwTJ52oP7dmycNBHJfJeLprStDPf
         kBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bdwFdqR8uTJkBxeLE6+6M0ZT6V7Ev5F6Fk3j55l8Z9k=;
        b=KrafF9SmbGjuxxq3QxgHGbOCL5EmkaHdjHj6jgJnrzUm2qRWpBoAiM6RBohiT+4VLS
         WL+diT2bZyw0e98zwMy+5pAOaizCtRJyo23fKLMGVtsC/HagT/re9IRZbA4m/24REg7R
         zcH8vBY6kFfFK5rdnMG2HEwALs/nl4wPozQVrkwQpOlzCrA+m+qCu8JBIg3clQfLxvfG
         UPvHDeZ5lKanJhYVBz164790R0oMabsObbouCL142l0pO3WTncUMRSJwNccySZNrdUay
         j56fbf6QqrkKOjuUQFXc5nA6ZravwdLN4ee9R3x1jeNK40Ub/5jExVXFqY0iyjaQFSL9
         f8Bg==
X-Gm-Message-State: AOAM531ql9NwKa4bBaCWZA6N05ppjS7ovsKDTCStcaje6mF1+kTmdMaX
        Yg+n+fk6oLoedpxQUx8NlvJCcsMW4VmPrQ==
X-Google-Smtp-Source: ABdhPJwD7rV3Z2sHm2Urux9ibnAQJLnjp5J8GSKRJQtu26ivkTzM9jU1IBe5MLhlZErz7vNjd6oCBw==
X-Received: by 2002:aa7:da0e:: with SMTP id r14mr8200605eds.236.1596284677325;
        Sat, 01 Aug 2020 05:24:37 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:36 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 10/17] hwmon: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:39 +0200
Message-Id: <20200801112446.149549-11-refactormyself@gmail.com>
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
 drivers/hwmon/i5k_amb.c | 12 ++++++++----
 drivers/hwmon/vt8231.c  |  8 ++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index eeac4b04df27..b7497510323c 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -427,11 +427,13 @@ static int i5k_find_amb_registers(struct i5k_amb_data *data,
 	if (!pcidev)
 		return -ENODEV;
 
-	if (pci_read_config_dword(pcidev, I5K_REG_AMB_BASE_ADDR, &val32))
+	pci_read_config_dword(pcidev, I5K_REG_AMB_BASE_ADDR, &val32);
+	if (val32 == (u32)~0)
 		goto out;
 	data->amb_base = val32;
 
-	if (pci_read_config_dword(pcidev, I5K_REG_AMB_LEN_ADDR, &val32))
+	pci_read_config_dword(pcidev, I5K_REG_AMB_LEN_ADDR, &val32);
+	if (val32 == (u32)~0)
 		goto out;
 	data->amb_len = val32;
 
@@ -458,11 +460,13 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
 	if (!pcidev)
 		return -ENODEV;
 
-	if (pci_read_config_word(pcidev, I5K_REG_CHAN0_PRESENCE_ADDR, &val16))
+	pci_read_config_word(pcidev, I5K_REG_CHAN0_PRESENCE_ADDR, &val16);
+	if (val16 == (u16)~0)
 		goto out;
 	amb_present[0] = val16;
 
-	if (pci_read_config_word(pcidev, I5K_REG_CHAN1_PRESENCE_ADDR, &val16))
+	pci_read_config_word(pcidev, I5K_REG_CHAN1_PRESENCE_ADDR, &val16);
+	if (val16 == (u16)~0)
 		goto out;
 	amb_present[1] = val16;
 
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 2335d440f72d..6603727e15a0 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -992,8 +992,8 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 			return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_BASE_REG,
-							&val))
+	pci_read_config_word(dev, VT8231_BASE_REG, &val);
+	if (val == (u16)~0)
 		return -ENODEV;
 
 	address = val & ~(VT8231_EXTENT - 1);
@@ -1002,8 +1002,8 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_ENABLE_REG,
-							&val))
+	pci_read_config_word(dev, VT8231_ENABLE_REG, &val);
+	if (val == (u16)~0)
 		return -ENODEV;
 
 	if (!(val & 0x0001)) {
-- 
2.18.4

