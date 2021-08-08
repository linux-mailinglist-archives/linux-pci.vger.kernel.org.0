Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D6C3E3BE4
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 19:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhHHRWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHRWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 13:22:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED5C061760
        for <linux-pci@vger.kernel.org>; Sun,  8 Aug 2021 10:22:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m12so18182463wru.12
        for <linux-pci@vger.kernel.org>; Sun, 08 Aug 2021 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xfC/a7r2v7rInT2z/B87NUzq6WuaHjmedALyon0+2G0=;
        b=ZDtdAM7yImJNDa38XuGeEj7um4/oabBGChij19mxMXgq4yHpWu10cVbhdnrG9bPOPM
         8ESnjHrVoyoITuq3eYmLbtaFTYpdB8v1xLC+jJO56BgffSLkOIkiUhbmvm+ujhMGSdx5
         1CwABWKyyM4UGhfUo6e9p0hRrg5QFPUh6HLbkpRwXrStCQEUd5Yd7fysdfJwhAtJfYdx
         WQbe0MB7Pv/i6WqxVukW9cl8/dW+Gq95+qngJUTAOzaHRf2G8HzS0EoklyPgFJrq7pw0
         T85dyD/DdYr9qLkfsFwag25pFnMzIiIC38Jcbi4/CC6wdy5ZC1DzjHkNhdwV3noi+TLh
         qC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xfC/a7r2v7rInT2z/B87NUzq6WuaHjmedALyon0+2G0=;
        b=oHikz3jGyC3nTxq+UFRUMWSwiuJh3MWgcmKRhKJGVo2QB/tPmpeEImaROaQZbWXhY7
         cgIoltKhlXo1XL8gSx0YgwuElUjcxFH7s33YcITBDzHI7jwW8BCfH1MZotpzGbrmfLjq
         BVSSU/ZZrpe2obwWN7iMCr0gGBWqeiMT0igKrID4N0idDE9goEUH/1ezhIfVwfnfAisv
         FFsfQ4aSskcxAT9wAypt9CI4NC3nzH7zrJsQCXIk+LrFlWsrqRoBLQLV4TLl++h/P7AT
         SJQBQsJ+8bLI8Es0LxMFQniFNeBn0g4vusNUpXiCAW5NJOVOnsxCi22fhu7jLmVR1K7g
         p7+w==
X-Gm-Message-State: AOAM5321z3apVFmBmbXyXRodU9Y63LC+YVoIigG101Aie8TUHHPcoGEO
        jfCHlv00LR/3VLQMSUCCWFAi5pZceSLDDw==
X-Google-Smtp-Source: ABdhPJwgH4uF6V0Xxzr3npDDvp7PreuxjyXrQSqcvCqct0DhMCP2kk1hXyRIcBZEqPm8+fIla5zEog==
X-Received: by 2002:adf:ecc9:: with SMTP id s9mr20709634wro.306.1628443319504;
        Sun, 08 Aug 2021 10:21:59 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:7101:8b48:5eab:cb5f? (p200300ea8f10c20071018b485eabcb5f.dip0.t-ipconnect.de. [2003:ea:8f10:c200:7101:8b48:5eab:cb5f])
        by smtp.googlemail.com with ESMTPSA id w14sm5737633wrt.23.2021.08.08.10.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:21:59 -0700 (PDT)
Subject: [PATCH 4/6] PCI/VPD: Embed struct pci_vpd member in struct pci_dev
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Message-ID: <d898489e-22ba-71f1-2f31-f1a78dc15849@gmail.com>
Date:   Sun, 8 Aug 2021 19:21:56 +0200
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

Now that struct pci_vpd became really small, we can simplify the code
by embedding a struct pci_vpd member in struct pci_dev instead of
dynamically allocating it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/probe.c |  1 -
 drivers/pci/vpd.c   | 67 ++++++++++-----------------------------------
 include/linux/pci.h |  9 ++++--
 3 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37..0ec5c792c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2225,7 +2225,6 @@ static void pci_release_capabilities(struct pci_dev *dev)
 {
 	pci_aer_exit(dev);
 	pci_rcec_exit(dev);
-	pci_vpd_release(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
 }
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index d6c216caf..86f9440e0 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -13,12 +13,6 @@
 
 /* VPD access through PCI 2.2+ VPD capability */
 
-struct pci_vpd {
-	struct mutex	lock;
-	unsigned int	len;
-	u8		cap;
-};
-
 static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
 {
 	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
@@ -37,7 +31,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
 
 	/* Otherwise the following reads would fail. */
-	dev->vpd->len = PCI_VPD_MAX_SIZE;
+	dev->vpd.len = PCI_VPD_MAX_SIZE;
 
 	while (pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
@@ -90,7 +84,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
  */
 static int pci_vpd_wait(struct pci_dev *dev, bool set)
 {
-	struct pci_vpd *vpd = dev->vpd;
+	struct pci_vpd *vpd = &dev->vpd;
 	unsigned long timeout = jiffies + msecs_to_jiffies(125);
 	unsigned long max_sleep = 16;
 	u16 status;
@@ -120,16 +114,14 @@ static int pci_vpd_wait(struct pci_dev *dev, bool set)
 static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			    void *arg)
 {
-	struct pci_vpd *vpd;
+	struct pci_vpd *vpd = &dev->vpd;
 	int ret = 0;
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
-	if (!dev || !dev->vpd)
+	if (!vpd->cap)
 		return -ENODEV;
 
-	vpd = dev->vpd;
-
 	if (pos < 0)
 		return -EINVAL;
 
@@ -189,16 +181,14 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 			     const void *arg)
 {
-	struct pci_vpd *vpd;
+	struct pci_vpd *vpd = &dev->vpd;
 	const u8 *buf = arg;
 	loff_t end = pos + count;
 	int ret = 0;
 
-	if (!dev || !dev->vpd)
+	if (!vpd->cap)
 		return -ENODEV;
 
-	vpd = dev->vpd;
-
 	if (pos < 0 || (pos & 3) || (count & 3))
 		return -EINVAL;
 
@@ -243,25 +233,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 
 void pci_vpd_init(struct pci_dev *dev)
 {
-	struct pci_vpd *vpd;
-	u8 cap;
-
-	cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
-	if (!cap)
-		return;
-
-	vpd = kzalloc(sizeof(*vpd), GFP_ATOMIC);
-	if (!vpd)
-		return;
-
-	mutex_init(&vpd->lock);
-	vpd->cap = cap;
-	dev->vpd = vpd;
-}
-
-void pci_vpd_release(struct pci_dev *dev)
-{
-	kfree(dev->vpd);
+	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
+	mutex_init(&dev->vpd.lock);
 }
 
 static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
@@ -293,7 +266,7 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (!pdev->vpd)
+	if (!pdev->vpd.cap)
 		return 0;
 
 	return a->attr.mode;
@@ -401,7 +374,7 @@ static void quirk_f0_vpd_link(struct pci_dev *dev)
 	if (!f0)
 		return;
 
-	if (f0->vpd && dev->class == f0->class &&
+	if (f0->vpd.cap && dev->class == f0->class &&
 	    dev->vendor == f0->vendor && dev->device == f0->device)
 		dev->dev_flags |= PCI_DEV_FLAGS_VPD_REF_F0;
 
@@ -419,10 +392,8 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
  */
 static void quirk_blacklist_vpd(struct pci_dev *dev)
 {
-	if (dev->vpd) {
-		dev->vpd->len = PCI_VPD_SZ_INVALID;
-		pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
-	}
+	dev->vpd.len = PCI_VPD_SZ_INVALID;
+	pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
@@ -444,16 +415,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
-static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
-{
-	struct pci_vpd *vpd = dev->vpd;
-
-	if (!vpd || len == 0 || len > PCI_VPD_MAX_SIZE)
-		return;
-
-	vpd->len = len;
-}
-
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
 	int chip = (dev->device & 0xf000) >> 12;
@@ -472,9 +433,9 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 	 * limits.
 	 */
 	if (chip == 0x0 && prod >= 0x20)
-		pci_vpd_set_size(dev, 8192);
+		dev->vpd.len = 8192;
 	else if (chip >= 0x4 && func < 0x8)
-		pci_vpd_set_size(dev, 2048);
+		dev->vpd.len = 2048;
 }
 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca..e752cc39a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -300,9 +300,14 @@ struct pci_cap_saved_state {
 	struct pci_cap_saved_data	cap;
 };
 
+struct pci_vpd {
+	struct mutex	lock;
+	unsigned int	len;
+	u8		cap;
+};
+
 struct irq_affinity;
 struct pcie_link_state;
-struct pci_vpd;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
@@ -473,7 +478,7 @@ struct pci_dev {
 #ifdef CONFIG_PCI_MSI
 	const struct attribute_group **msi_irq_groups;
 #endif
-	struct pci_vpd *vpd;
+	struct pci_vpd	vpd;
 #ifdef CONFIG_PCIE_DPC
 	u16		dpc_cap;
 	unsigned int	dpc_rp_extensions:1;
-- 
2.32.0


