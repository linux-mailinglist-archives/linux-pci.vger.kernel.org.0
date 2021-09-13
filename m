Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB340A1AF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 01:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbhIMXr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 19:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhIMXr0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8212161056;
        Mon, 13 Sep 2021 23:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631576769;
        bh=svwTodIvvUH1K7I0QXV/Fq8OZfMGRbpkLLRzATMEnjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XAuVecKo1bG+oD8+ClPB40My9Pj9qGl95fnW8Uj+gFDXnPYwOqohKxNilK8nBa+98
         KVBE6T1qbqdNDXPcPvK6FlvVj5xPCRgJHpIcIfhPcmHjXS4hkFgecI++gm43/R34RI
         JufosPHPUf8XI2EaLBmg5+HOwogRILhzptusK8SXyOPnZaqYnYsq2VF53ltnPVSLfk
         w9nBbmaRazSYAaiVgJm/3SrqOnfUmS2pYjwUtRpYjG/IrQdXsVcEzUmaa5BtLBlIbH
         U+fWITzQfzomzb6GREsqhi3Acv7UOEq6o9NjYFxamf+Qhal4pMPu0diA1qRCbg0utW
         Csv7J0LQd0Dcg==
Date:   Mon, 13 Sep 2021 18:46:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Linux 5.15-rc1
Message-ID: <20210913234608.GA1381155@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913141818.GA27911@codemonkey.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 10:18:18AM -0400, Dave Jones wrote:
> On Sun, Sep 12, 2021 at 04:58:27PM -0700, Linus Torvalds wrote:
>  > So 5.15 isn't shaping up to be a particularly large release, at least
>  > in number of commits. At only just over 10k non-merge commits, this is
>  > in fact the smallest rc1 we have had in the 5.x series. We're usually
>  > hovering in the 12-14k commit range.
> 
> This release takes over two minutes longer to boot on one my
> machines than 5.14.  The time just seems to be unaccounted for, even
> with initcall_debug

> ...
> [    2.194093] pci 0000:01:00.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
> [    2.194097] pci 0000:01:00.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
> [    2.194100] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
> [    2.194109] pci 0000:01:00.0: reg 0x10: [mem 0xd0080000-0xd00fffff 64bit pref]
> [    2.194113] pci 0000:01:00.0: reg 0x18: [io  0xe020-0xe03f]
> [    2.194121] pci 0000:01:00.0: reg 0x20: [mem 0xd0104000-0xd0107fff 64bit pref]
> [    2.194126] pci 0000:01:00.0: reg 0x30: [mem 0xdfd80000-0xdfdfffff pref]
> [    2.194136] pci 0000:01:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
> [    2.194139] pci 0000:01:00.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
> [    2.194164] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> 
> * stall here for 86 seconds *
> 
> [   88.675114] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
> ...


> 7bac54497c3e3b2ca37b7043f1fa78586540f10e is the first bad commit
> commit 7bac54497c3e3b2ca37b7043f1fa78586540f10e
> Author: Heiner Kallweit <hkallweit1@gmail.com>
> Date:   Sun Aug 8 19:22:52 2021 +0200
> 
>     PCI/VPD: Determine VPD size in pci_vpd_init()
> 
>     Determine VPD size in pci_vpd_init().
> 
>     Quirks set dev->vpd.len to a non-zero value, so they cause us to skip the
>     dynamic size calculation.  Prerequisite is that we move the quirks from
>     FINAL to HEADER so they are run before pci_vpd_init().
> 
>     Link: https://lore.kernel.org/r/cc4a6538-557a-294d-4f94-e6d1d3c91589@gmail.com
>     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> 
> Which unfortunately doesn't revert cleanly I can't test it reverted in
> isolation.
> 
> My guess is there's something quirky about the PCI bus on this machine
> that causes stalls until we hit timeout, but I'm not sure where to begin
> debugging this.

Sorry for the inconvenience of this, and thank you very much for doing
the bisection to track it down.

We *could* revert 7bac54497c3e, but it'd be messy because a bunch of
follow-up stuff depends on it.

I propose something like the patch below.  Would you mind trying it
out?


commit 4ede9949b93c ("PCI/VPD: Defer VPD sizing until first access")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Sep 13 16:13:26 2021 -0500

    PCI/VPD: Defer VPD sizing until first access
    
    7bac54497c3e ("PCI/VPD: Determine VPD size in pci_vpd_init()") reads VPD at
    enumeration-time to find the size.  But this is quite slow, and we don't
    need the size until we actually need data from VPD.  Dave reported a boot
    slowdown of more than two minutes [1].
    
    Defer the VPD sizing until a driver or the user requests information from
    VPD.  If devices are quirked because VPD is known not to work, clear the
    vpd.cap pointer so we don't access it at all.
    
    [1] https://lore.kernel.org/r/20210913141818.GA27911@codemonkey.org.uk/
    Fixes: 7bac54497c3e ("PCI/VPD: Determine VPD size in pci_vpd_init()")
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 25557b272a4f..ca823ceee10c 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -46,13 +46,12 @@ static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
 }
 
 #define PCI_VPD_MAX_SIZE	(PCI_VPD_ADDR_MASK + 1)
-#define PCI_VPD_SZ_INVALID	UINT_MAX
 
 /**
  * pci_vpd_size - determine actual size of Vital Product Data
  * @dev:	pci device struct
  */
-static size_t pci_vpd_size(struct pci_dev *dev)
+static void pci_vpd_size(struct pci_dev *dev)
 {
 	size_t off = 0, size;
 	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
@@ -71,7 +70,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
 				pci_warn(dev, "failed VPD read at offset %zu\n",
 					 off + 1);
-				return off ?: PCI_VPD_SZ_INVALID;
+				goto finish;
 			}
 			size = pci_vpd_lrdt_size(header);
 			if (off + size > PCI_VPD_MAX_SIZE)
@@ -87,16 +86,19 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 
 			off += PCI_VPD_SRDT_TAG_SIZE + size;
 			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
-				return off;
+				goto finish;
 		}
 	}
-	return off;
+	goto finish;
 
 error:
 	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
 		 header[0], size, off, off == 0 ?
 		 "; assume missing optional EEPROM" : "");
-	return off ?: PCI_VPD_SZ_INVALID;
+finish:
+	dev->vpd.len = off;
+	if (off == 0)
+		dev->vpd.cap = 0;		/* No VPD at all */
 }
 
 /*
@@ -145,9 +147,6 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
-	if (!vpd->cap)
-		return -ENODEV;
-
 	if (pos < 0)
 		return -EINVAL;
 
@@ -206,9 +205,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	int ret = 0;
 
-	if (!vpd->cap)
-		return -ENODEV;
-
 	if (pos < 0 || (pos & 3) || (count & 3))
 		return -EINVAL;
 
@@ -244,12 +240,6 @@ void pci_vpd_init(struct pci_dev *dev)
 {
 	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
 	mutex_init(&dev->vpd.lock);
-
-	if (!dev->vpd.len)
-		dev->vpd.len = pci_vpd_size(dev);
-
-	if (dev->vpd.len == PCI_VPD_SZ_INVALID)
-		dev->vpd.cap = 0;
 }
 
 static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
@@ -294,25 +284,29 @@ const struct attribute_group pci_dev_vpd_attr_group = {
 
 void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
 {
-	unsigned int len = dev->vpd.len;
+	struct pci_vpd *vpd = &dev->vpd;
+	unsigned int len;
 	void *buf;
 	int cnt;
 
-	if (!dev->vpd.cap)
+	if (!vpd->cap)
 		return ERR_PTR(-ENODEV);
 
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	cnt = pci_read_vpd(dev, 0, len, buf);
+	if (vpd->len == 0)
+		pci_vpd_size(dev);
+
+	cnt = pci_read_vpd(dev, 0, vpd->len, buf);
 	if (cnt != len) {
 		kfree(buf);
 		return ERR_PTR(-EIO);
 	}
 
 	if (size)
-		*size = len;
+		*size = vpd->len;
 
 	return buf;
 }
@@ -374,6 +368,7 @@ static int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
  */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
 {
+	struct pci_vpd *vpd;
 	ssize_t ret;
 
 	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
@@ -381,11 +376,27 @@ ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
 		if (!dev)
 			return -ENODEV;
 
+		vpd = &dev->vpd;
+		if (!vpd->cap) {
+			pci_dev_put(dev);
+			return -ENODEV;
+		}
+
+		if (vpd->len == 0)
+			pci_vpd_size(dev);
+
 		ret = pci_vpd_read(dev, pos, count, buf);
 		pci_dev_put(dev);
 		return ret;
 	}
 
+	vpd = &dev->vpd;
+	if (!vpd->cap)
+		return -ENODEV;
+
+	if (vpd->len == 0)
+		pci_vpd_size(dev);
+
 	return pci_vpd_read(dev, pos, count, buf);
 }
 EXPORT_SYMBOL(pci_read_vpd);
@@ -399,6 +410,7 @@ EXPORT_SYMBOL(pci_read_vpd);
  */
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
 {
+	struct pci_vpd *vpd;
 	ssize_t ret;
 
 	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
@@ -406,11 +418,26 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
 		if (!dev)
 			return -ENODEV;
 
+		vpd = &dev->vpd;
+		if (!vpd->cap) {
+			pci_dev_put(dev);
+			return -ENODEV;
+		}
+
+		if (vpd->len == 0)
+			pci_vpd_size(dev);
+
 		ret = pci_vpd_write(dev, pos, count, buf);
 		pci_dev_put(dev);
 		return ret;
 	}
 
+	if (!vpd->cap)
+		return -ENODEV;
+
+	if (vpd->len == 0)
+		pci_vpd_size(dev);
+
 	return pci_vpd_write(dev, pos, count, buf);
 }
 EXPORT_SYMBOL(pci_write_vpd);
@@ -500,27 +527,27 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
  */
 static void quirk_blacklist_vpd(struct pci_dev *dev)
 {
-	dev->vpd.len = PCI_VPD_SZ_INVALID;
+	dev->vpd.cap = 0;
 	pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
 /*
  * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
  * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
  */
-DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
-			       PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
@@ -545,7 +572,7 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 		dev->vpd.len = 2048;
 }
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
-			 quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
+			quirk_chelsio_extend_vpd);
 
 #endif
