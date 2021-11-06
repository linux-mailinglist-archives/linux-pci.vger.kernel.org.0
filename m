Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15E1446D9D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 12:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhKFL3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFL3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 07:29:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E16C061570
        for <linux-pci@vger.kernel.org>; Sat,  6 Nov 2021 04:26:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so5178072pjf.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Nov 2021 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUBg4F2w42ifFGcRoyXQkPsTj7mdb/CGi2CkiubKUc0=;
        b=BuLz3TVar020xUmzLvjuJodwhOHBQu5eQz+KTHGG7pMfble6xd96GnAD6fj/Ugo7Qr
         p5jI5cIVRqHhWFtmwy2tx5VqX4K78LJOMmvt3onEmi4PTszGqsGMgGNAMlT8yZ7FFJER
         Hiz2zeqjDHcCR7P5S80+WVDc36RP+KUUw/YQUlzXYSaUFRwGkyySCIaBRBzJDWyA0EMi
         7G5g/jBnIN9JJ+Zk+X0gswWQxowdtuMwh7yPQk/Zn/JW3ZTyUCmK/FMYw6BhWSy8faeZ
         jc4MM2aqsiRrlboniRUX+yLhdap3NgxAxgmV1Lv5NWKdmjz/c0+KOX+FLWD0e0CVzhqu
         c4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUBg4F2w42ifFGcRoyXQkPsTj7mdb/CGi2CkiubKUc0=;
        b=2aXLSvAoP31Lscl3lmXgB0o2QjC/KHfCQ+BSrQztGn6sExG/joVkwqNNQgO7nj5D15
         CRrGu2J1/HBe+xJoiVEXtBkonqCAR4limi1H6uVGPXYoa+ahxPm/5LUolgSQsoq6jo5I
         FqYXz3TZ6ynZM5wFf1fVI1Niy0TXUMPDnftd/1tM1kuwMD8R8rtY3wUEUGn6TBZVCNx6
         nG8KReAItnBC6/9sGn99xL/XMk85smdwggoalOlH/KcNBqLC+wSDArg47k5bDwKVbFW8
         8nJ/yqCZchszlqgaF0OXIKxU3t2LoFZIT0ZFPY0Ol7tr/YspbjSN+DbpGN6+XPqv3Hil
         Ux/g==
X-Gm-Message-State: AOAM530wm98Xfz/8++4JZdogpy6rhMmvgP34vJatObeclPRob+iontBo
        sRgwOsAjgNMlZUXQpx6aJcY=
X-Google-Smtp-Source: ABdhPJwBvzTRy5YJpHsYXww2XdOyY+8K1i1KwZIavfAODrYHcI03/OEIbmS4ar1eJii0h6f23jefCg==
X-Received: by 2002:a17:90b:4a01:: with SMTP id kk1mr9744254pjb.7.1636197988488;
        Sat, 06 Nov 2021 04:26:28 -0700 (PDT)
Received: from localhost.localdomain ([124.253.6.45])
        by smtp.googlemail.com with ESMTPSA id c21sm10971037pfl.15.2021.11.06.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 04:26:27 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 2/2] PCI: Use resource names in PCI log messages
Date:   Sat,  6 Nov 2021 16:56:06 +0530
Message-Id: <20211106112606.192563-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211106112606.192563-1-puranjay12@gmail.com>
References: <20211106112606.192563-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the pci_resource_name() to get the name of the resource and use it
while printing log messages.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/pci/probe.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..407854d17efa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -181,6 +181,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	u64 l64, sz64, mask64;
 	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
+	int idx = res - dev->resource;
+	const char *resource_name = pci_resource_name(dev, idx);
 
 	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
 
@@ -255,8 +257,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	sz64 = pci_size(l64, sz64, mask64);
 	if (!sz64) {
-		pci_info(dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
-			 pos);
+		pci_info(dev, FW_BUG "%s: invalid BAR (can't size)\n",
+			 resource_name);
 		goto fail;
 	}
 
@@ -266,8 +268,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 			res->start = 0;
 			res->end = 0;
-			pci_err(dev, "reg 0x%x: can't handle BAR larger than 4GB (size %#010llx)\n",
-				pos, (unsigned long long)sz64);
+			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
+				resource_name, (unsigned long long)sz64);
 			goto out;
 		}
 
@@ -276,8 +278,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET;
 			res->start = 0;
 			res->end = sz64 - 1;
-			pci_info(dev, "reg 0x%x: can't handle BAR above 4GB (bus address %#010llx)\n",
-				 pos, (unsigned long long)l64);
+			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
+				 resource_name, (unsigned long long)l64);
 			goto out;
 		}
 	}
@@ -303,8 +305,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		res->flags |= IORESOURCE_UNSET;
 		res->start = 0;
 		res->end = region.end - region.start;
-		pci_info(dev, "reg 0x%x: initial BAR value %#010llx invalid\n",
-			 pos, (unsigned long long)region.start);
+		pci_info(dev, "%s: initial BAR value %#010llx invalid\n",
+			 resource_name, (unsigned long long)region.start);
 	}
 
 	goto out;
@@ -314,7 +316,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->flags = 0;
 out:
 	if (res->flags)
-		pci_info(dev, "reg 0x%x: %pR\n", pos, res);
+		pci_info(dev, "%s: %pR\n", resource_name, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
-- 
2.30.1

