Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9640BAC8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 23:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhINV5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 17:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233952AbhINV5C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 17:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE61D60F21;
        Tue, 14 Sep 2021 21:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631656545;
        bh=argaTgBr5VKnygg+HIx3am0H+3IxuMXP+1Nj76eAUGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RlXKjTqxbkMplldZoMu9gQ0gubJdn1CpeCHUDoqAq4ByneDA08RB8JjMEKU6vDHjp
         +l68uERXQBD4coEGnknGy08Zp3ELWcKZHNWmsUMJIjRaTqaX19jw0BbKxkYsdlCkSA
         p+uTJvgDqLZHX1y8OAT5S7CYufk05LbOuCnHPyX7Kax8b/1bz1PxHk4Oim0zqHCx/4
         n8SrnuAQexoW9ufF6W7Oo5LplxJR/szSNdfB6LFrtFMe9LHN4lepjwAu38q6ZLhWih
         WZZUv7BVlcRzNeYjg4bV0Nb1T2JpaA/FBJymWpK/Dr3+ekr89ZDLeFBko3c+dlWTi5
         i8j65az7PxaQA==
Date:   Tue, 14 Sep 2021 16:55:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Linux 5.15-rc1
Message-ID: <20210914215543.GA1437800@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54bd54b9-3774-92a5-4193-5ccccd235572@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 07:07:40PM +0200, Heiner Kallweit wrote:
> On 14.09.2021 13:26, Bjorn Helgaas wrote:
> > On Tue, Sep 14, 2021 at 08:21:46AM +0200, Heiner Kallweit wrote:
> >> On 14.09.2021 01:46, Bjorn Helgaas wrote:
> > 
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
> >>>  /*
> >>
> >> Leaving the quirks in FIXUP_HEADER stage would have the advantage that for
> >> blacklisted devices the vpd sysfs attribute isn't visibale. The needed
> >> changes to the patch are minimal.
> > 
> > What do you have in mind?  The only thing I can think of would be to
> > add a "pci_dev.no_vpd" bit.  "vpd.cap == 0" means the device has no
> > VPD, and "vpd.len == 0" means we haven't determined the size yet.  All
> > devices start off with vpd.cap == 0 and vpd.len == 0, so a
> > FIXUP_HEADER quirk would have to set a sentinel value or some other
> > bit.
> 
> Why not leave vpd.len == PCI_VPD_SZ_INVALID as sentinel?

Sentinel values aren't really my favorite thing, but it certainly does
have the advantage of hiding the sysfs attribute.

> And one more question: Why do you move the "if (!vpd->cap)" check from
> pci_vpd_read() to pci_read_vpd()? At a first glance I see no benefit.

I'm pretty sure I *had* a reason, but I can't remember right now :(
Moving it sure does uglify pci_read_vpd() and pci_write_vpd(), though.

What do you think of the following?  (This is a diff from v5.15-rc1.)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 25557b272a4f..4be24890132e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -99,6 +99,24 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 	return off ?: PCI_VPD_SZ_INVALID;
 }
 
+static bool pci_vpd_available(struct pci_dev *dev)
+{
+	struct pci_vpd *vpd = &dev->vpd;
+
+	if (!vpd->cap)
+		return false;
+
+	if (vpd->len == 0) {
+		vpd->len = pci_vpd_size(dev);
+		if (vpd->len == PCI_VPD_SZ_INVALID) {
+			vpd->cap = 0;
+			return false;
+		}
+	}
+
+	return true;
+}
+
 /*
  * Wait for last operation to complete.
  * This code has to spin since there is no other notification from the PCI
@@ -145,7 +163,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
-	if (!vpd->cap)
+	if (!pci_vpd_available(dev))
 		return -ENODEV;
 
 	if (pos < 0)
@@ -206,7 +224,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	int ret = 0;
 
-	if (!vpd->cap)
+	if (!pci_vpd_available(dev))
 		return -ENODEV;
 
 	if (pos < 0 || (pos & 3) || (count & 3))
@@ -242,14 +260,11 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 
 void pci_vpd_init(struct pci_dev *dev)
 {
+	if (dev->vpd.len == PCI_VPD_SZ_INVALID)
+		return;
+
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
@@ -294,13 +309,14 @@ const struct attribute_group pci_dev_vpd_attr_group = {
 
 void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
 {
-	unsigned int len = dev->vpd.len;
+	unsigned int len;
 	void *buf;
 	int cnt;
 
-	if (!dev->vpd.cap)
+	if (!pci_vpd_available(dev))
 		return ERR_PTR(-ENODEV);
 
+	len = dev->vpd.len;
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
