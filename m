Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD5319C51
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 11:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBLKEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 05:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhBLKEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Feb 2021 05:04:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FFCC06178B
        for <linux-pci@vger.kernel.org>; Fri, 12 Feb 2021 02:03:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so7233558wrz.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Feb 2021 02:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=y10zmKTwVSU2bmLvDau6dZ5wxR4I4atJnubBYNUZwLs=;
        b=QGehvdPLmnyihf0IxNfVK08VpYfCI3jl++jNTW/peYO+G2YIVagtdIPrxXZ9gRQDdd
         /AZZPJ6EQp58chjBOCz163syQAI3OI+qVDTp/c5KWEHO02v2MQjuTj3YespYU6OefiwK
         XyiIKPiRZzcM4pN+dK1qgUvzN/YymyICr553Kb3/0Q/NOkAS2/vhHsxBGPmeNG6XWngm
         Hxx/Blm9KpsgLRbOLo+gKmgS69Sp6YJdo0q+V1Mc+O1F993a6PPkjm/pgX4FGaavToBZ
         ceWylzpyKoQuc/Oz8EtyuZN+FAmMDKmJmZ7qvCswPP96S2l8iugOIEf77M5XPnJt+IFG
         IG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=y10zmKTwVSU2bmLvDau6dZ5wxR4I4atJnubBYNUZwLs=;
        b=eY/dFqnhcO2Il60S2u6P94K6CERw+wnfiCSFeugnf7JvxOwhY8LbY4/+OOEMIW4qsA
         wKKkcosA/u3DwFt7AkNtFLyHGTleK4iY+aHjdgWiGjrL3us6yArbhUFEbc+7NrKE+vEQ
         V9DuEAeAZksKIsxavyjzUEd/K1JQqVZGdueLtUIdn8jdw5yCOHFb6NQTp1tXP3Lyai5l
         qpYjwPeP+8KX5Mxm+dCT75EXd+jEfwlhyRpAzusZyFgIALZfdzUpUSXL2yj+pLf6VWSg
         tktLFYU9nZDmQnN01FAJ1+RKa6F9K0kIfp+7A3ypag6RDBB9Ink0lbRPxz03WOarYQTY
         UEdw==
X-Gm-Message-State: AOAM5314CbGGXjJDFAZ4zOKkLPRNQ+5zAgJeDjWPU+4WCjlJUl8Oad09
        zuq2oiysEA1WKmbNx4/mAp5flZFShdJ7Pw==
X-Google-Smtp-Source: ABdhPJy+V9bJjN+gjGzUEv9hG1sU+HL2yBLfWaWD8yq+C4Rywzj/oOlGcbqwm1H4+zlAVahyv6IdWg==
X-Received: by 2002:a5d:4902:: with SMTP id x2mr1898762wrq.207.1613124195631;
        Fri, 12 Feb 2021 02:03:15 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:6ca0:dfcc:de5d:f04e? (p200300ea8f1fad006ca0dfccde5df04e.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:6ca0:dfcc:de5d:f04e])
        by smtp.googlemail.com with ESMTPSA id s23sm13753893wmc.29.2021.02.12.02.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 02:03:15 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESEND] PCI/VPD: Remove pci_set_vpd_size
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <47d86e52-9bcf-7da7-1edb-0d988a7a82ab@gmail.com>
Date:   Fri, 12 Feb 2021 11:02:47 +0100
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
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
---
- Referenced commit just landed in linux-next via the netdev tree.
- Uups, had the list on bcc instead of cc.
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

