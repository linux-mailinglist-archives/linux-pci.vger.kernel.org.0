Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027A53189B6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 12:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBKLnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 06:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhBKLks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 06:40:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B23C061756
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 03:40:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j11so5242315wmi.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 03:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tohq/JdjtvfZAdF0OwFagBaJvOCASM9Lm+6u557MXjU=;
        b=jZncg4+OXDdQ5q77dwIRHbggDnfB06LDmsbCk5upxPGhtffhotOMwIqK1O8T7B8hQt
         9VA9VJSW61VKy0oqGxmTVL2/0OMvbIJa7tncMhXCtgcgVHcizN5iPYqNNKVSkBnESbXp
         EP68F/9S+Ns61exdSbpanlq8Qj5LlUlGlMll+9ActU7xIAzQgDpj6prbBRYf9bqocqKT
         o4Q7d/hwclN8w2gg5mptmvGnFU/GMkaxz81vym5PTZRJbbmq3uTRfWdCBnmvnrZDODgt
         ogJ9MwhDKSSRjceWYLdSLQ3QEHERllMzCykpYjBu8JT9sFvcn71BJEdTNtvWwsGzNAvb
         vGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tohq/JdjtvfZAdF0OwFagBaJvOCASM9Lm+6u557MXjU=;
        b=KC9xbuesGGOtZJHRlfx7z83MfidZcSm46PFf7J7cFTo2jEHp1o2EC470SgBeYPQ6Lz
         zmM+KG3Gv7AQ3rePHQbLsh/mXlP4xcNOoc42XLUOdytvY0ok/oP41AyllCSSNG7cSaWd
         iBUF/MFwXmBqnUxQoGaZfjIu13dtp3lfzokrGokHqasAc7HajOI3KQ6FEDIvDefwEy+w
         6IeaJR+kU57qQDK6OwTFInYC4LOA9oMYdlo9ePgzhBDGxzyhQKvXGbQflNZ/fjAQX4+Y
         hXBv8hIdvRLIZQkCZxEk94dRTA2mruMBs/gZVJ6908HYzUXDau5V0MQuxodyyiZ6ckHw
         DlPA==
X-Gm-Message-State: AOAM530B/exrltoM/vicuzJeEcruJpwmGAM41WTjpWY8r1En6r/8soPs
        S0W4FckxB5h4OPvNBqAPSkhdlo/aGDL52g==
X-Google-Smtp-Source: ABdhPJySw7gjyxqROo/LUzY60SvdaPpgiUtbK6dsF70pGv8y8w8FQxZhsuGmKfqZThaAnWPyxrgGwA==
X-Received: by 2002:a1c:2d48:: with SMTP id t69mr4611953wmt.124.1613043606127;
        Thu, 11 Feb 2021 03:40:06 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:60ca:853:df03:450e? (p200300ea8f1fad0060ca0853df03450e.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:60ca:853:df03:450e])
        by smtp.googlemail.com with ESMTPSA id n187sm9631299wmf.29.2021.02.11.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 03:40:05 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Remove pci_set_vpd_size
Message-ID: <aa84f395-8c37-89d8-939f-496dfb630b90@gmail.com>
Date:   Thu, 11 Feb 2021 12:39:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

24a1720a0841 ("cxgb4: collect serial config version from register")
removed the only usage of pci_set_vpd_size(). If a device needs to
override the auto-detected VPD size, then this can be done using a
PCI quirk, like it's done for Chelsio devices. There's no need to
allow drivers to change the VPD size. So let's remove
pci_set_vpd_size().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
- Referenced commit just landed in linux-next via the netdev tree.
---
 drivers/pci/vpd.c   | 47 +++++++--------------------------------------
 include/linux/pci.h |  1 -
 2 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 4cf0d77ca..d1cbc5e64 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -16,7 +16,6 @@
 struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-	int (*set_size)(struct pci_dev *dev, size_t len);
 };
 
 struct pci_vpd {
@@ -59,19 +58,6 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
 }
 EXPORT_SYMBOL(pci_write_vpd);
 
-/**
- * pci_set_vpd_size - Set size of Vital Product Data space
- * @dev:	pci device struct
- * @len:	size of vpd space
- */
-int pci_set_vpd_size(struct pci_dev *dev, size_t len)
-{
-	if (!dev->vpd || !dev->vpd->ops)
-		return -ENODEV;
-	return dev->vpd->ops->set_size(dev, len);
-}
-EXPORT_SYMBOL(pci_set_vpd_size);
-
 #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
 
 /**
@@ -296,23 +282,19 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	return ret ? ret : count;
 }
 
-static int pci_vpd_set_size(struct pci_dev *dev, size_t len)
+static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
 {
 	struct pci_vpd *vpd = dev->vpd;
 
-	if (len == 0 || len > PCI_VPD_MAX_SIZE)
-		return -EIO;
-
-	vpd->valid = 1;
-	vpd->len = len;
-
-	return 0;
+	if (vpd && len && len <= PCI_VPD_MAX_SIZE) {
+		vpd->valid = 1;
+		vpd->len = len;
+	}
 }
 
 static const struct pci_vpd_ops pci_vpd_ops = {
 	.read = pci_vpd_read,
 	.write = pci_vpd_write,
-	.set_size = pci_vpd_set_size,
 };
 
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
@@ -345,24 +327,9 @@ static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
 	return ret;
 }
 
-static int pci_vpd_f0_set_size(struct pci_dev *dev, size_t len)
-{
-	struct pci_dev *tdev = pci_get_slot(dev->bus,
-					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
-	int ret;
-
-	if (!tdev)
-		return -ENODEV;
-
-	ret = pci_set_vpd_size(tdev, len);
-	pci_dev_put(tdev);
-	return ret;
-}
-
 static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.read = pci_vpd_f0_read,
 	.write = pci_vpd_f0_write,
-	.set_size = pci_vpd_f0_set_size,
 };
 
 int pci_vpd_init(struct pci_dev *dev)
@@ -528,9 +495,9 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 	 * limits.
 	 */
 	if (chip == 0x0 && prod >= 0x20)
-		pci_set_vpd_size(dev, 8192);
+		pci_vpd_set_size(dev, 8192);
 	else if (chip >= 0x4 && func < 0x8)
-		pci_set_vpd_size(dev, 2048);
+		pci_vpd_set_size(dev, 2048);
 }
 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97..edadc62ae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1302,7 +1302,6 @@ void pci_unlock_rescan_remove(void);
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-int pci_set_vpd_size(struct pci_dev *dev, size_t len);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
-- 
2.30.0

