Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD523521E
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgHAMYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgHAMYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75837C061757;
        Sat,  1 Aug 2020 05:24:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so11390591ejb.11;
        Sat, 01 Aug 2020 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f7EHkSWbrjhplB2d+YIJIh5vLQH5GmykUiEqLTIStB4=;
        b=ncnCAE+5L7BB5/YjIaWKdov1rz6HP5TvXA9nZA3PXndUUW1xK5+ufbrRdCYCwHcqHm
         t1EMuhi4tuEBdBJ5YsN9BB5sxWFTI0+q//E8z9o5Ck0ZyU+V5BrrZ5nZXdtol4sWPkxZ
         b9MIFjQEbPFh3ySpTdLCOFWSkzspCjS2kD4irjY0YxXuW38z5ndkVpebr288Yek4HTE7
         +2vr3ZHRUJaZVRsq+jCq8P6pvvPOtSBdlH0LEq1DjZSQP5YlhLmDT7iewerLkZWaqc/g
         VR8PYab69Ni5ovDIAYK7FvMde3VGmx+R28fsxL9Zyq9QmFLaLLeo+1pPbnbJL/G3y8oR
         c/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f7EHkSWbrjhplB2d+YIJIh5vLQH5GmykUiEqLTIStB4=;
        b=Bhcu03CrvCaJhpZJX2C9eo2m2HsoOPftZ8cNgV+Fpwzv9tOYt2Lzi0CQJbhEnNsJWB
         mQn+d4uy3gJpjwI3gnqRiCkvH4Sxd1F86PvRUy9PtXUtxlYXMMWic9/ovyNXAXfAFoA+
         zneJIJCCt3/iT6OL4RBFM43GL9CLgFQ7BzHBAQVS0Q8fH62lVCpofXQQJI/ZNirhZu3G
         uhKsLjuz5cGZ3NfarXidsdCrI9oWLnSdfjgk3VoytxVYGBGIUiB+HI3FD/YrjkwDgqRz
         Upa+A1kCJS28fXBakfA1n3HjwICaA6S4UEQcfvTV2cDSmwvZV3nCjn1YuwRjWenOG0jW
         QYbA==
X-Gm-Message-State: AOAM531PtDbv4Hr3UCV4hSRBN4RQ1xhyaKmBGXFdg76c0H+8JBoFaP6u
        GJK+ARPilP/Ut1874jMXHaI=
X-Google-Smtp-Source: ABdhPJxK6QsCLubg/13FQ7axRtOuPxj8lfRiykbHYiquSlkMilSMcUUDzaC4VkaClUghhqDZwK4BZw==
X-Received: by 2002:a17:906:c002:: with SMTP id e2mr8812396ejz.244.1596284681233;
        Sat, 01 Aug 2020 05:24:41 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:40 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: [RFC PATCH 13/17] ide: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:42 +0200
Message-Id: <20200801112446.149549-14-refactormyself@gmail.com>
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
Check the actual value read for ~0. In this case, ~0 is an invalid value
thus it indicates some kind of error.

drivers/ide/cs5536.c cs5536_read() :
None of the callers of cs5536_read() uses the return value. The obtained
value can be checked for validity to confirm success.

Change the return type of cs5536_read() to void.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/ide/cs5536.c    |  6 +++---
 drivers/ide/rz1000.c    |  3 ++-
 drivers/ide/setup-pci.c | 26 ++++++++++++++++----------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
index 8b5ca145191b..58d1cf37c013 100644
--- a/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -55,16 +55,16 @@ enum {
 
 static int use_msr;
 
-static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
+static void cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
 {
 	if (unlikely(use_msr)) {
 		u32 dummy;
 
 		rdmsr(MSR_IDE_CFG + reg, *val, dummy);
-		return 0;
+		return;
 	}
 
-	return pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
+	pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
 }
 
 static int cs5536_write(struct pci_dev *pdev, int reg, int val)
diff --git a/drivers/ide/rz1000.c b/drivers/ide/rz1000.c
index fce2b7de5a19..19ac4328e707 100644
--- a/drivers/ide/rz1000.c
+++ b/drivers/ide/rz1000.c
@@ -27,7 +27,8 @@ static int rz1000_disable_readahead(struct pci_dev *dev)
 {
 	u16 reg;
 
-	if (!pci_read_config_word (dev, 0x40, &reg) &&
+	pci_read_config_word(dev, 0x40, &reg);
+	if ((reg != (u16)~0) &&
 	    !pci_write_config_word(dev, 0x40, reg & 0xdfff)) {
 		printk(KERN_INFO "%s: disabled chipset read-ahead "
 			"(buggy RZ1000/RZ1001)\n", pci_name(dev));
diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index fdc8e813170c..a7b93ccd55d1 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -37,7 +37,8 @@ static int ide_setup_pci_baseregs(struct pci_dev *dev, const char *name)
 	/*
 	 * Place both IDE interfaces into PCI "native" mode:
 	 */
-	if (pci_read_config_byte(dev, PCI_CLASS_PROG, &progif) ||
+	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+	if ((progif == (u8)~0) ||
 			 (progif & 5) != 5) {
 		if ((progif & 0xa) != 0xa) {
 			printk(KERN_INFO "%s %s: device not capable of full "
@@ -47,7 +48,8 @@ static int ide_setup_pci_baseregs(struct pci_dev *dev, const char *name)
 		printk(KERN_INFO "%s %s: placing both ports into native PCI "
 			"mode\n", name, pci_name(dev));
 		(void) pci_write_config_byte(dev, PCI_CLASS_PROG, progif|5);
-		if (pci_read_config_byte(dev, PCI_CLASS_PROG, &progif) ||
+		pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+		if ((progif == (u8)~0) ||
 		    (progif & 5) != 5) {
 			printk(KERN_ERR "%s %s: rewrite of PROGIF failed, "
 				"wanted 0x%04x, got 0x%04x\n",
@@ -251,7 +253,8 @@ static int ide_pci_configure(struct pci_dev *dev, const struct ide_port_info *d)
 			d->name, pci_name(dev));
 		return -ENODEV;
 	}
-	if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd)) {
+	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
+	if (pcicmd == (u16)~0) {
 		printk(KERN_ERR "%s %s: error accessing PCI regs\n",
 			d->name, pci_name(dev));
 		return -EIO;
@@ -415,8 +418,8 @@ static int ide_setup_pci_controller(struct pci_dev *dev, int bars,
 	if (ret < 0)
 		goto out;
 
-	ret = pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
-	if (ret < 0) {
+	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
+	if (pcicmd == (u16)~0) {
 		printk(KERN_ERR "%s %s: error accessing PCI regs\n",
 			d->name, pci_name(dev));
 		goto out_free_bars;
@@ -466,11 +469,14 @@ void ide_pci_setup_ports(struct pci_dev *dev, const struct ide_port_info *d,
 	for (port = 0; port < channels; ++port) {
 		const struct ide_pci_enablebit *e = &d->enablebits[port];
 
-		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
-		    (tmp & e->mask) != e->val)) {
-			printk(KERN_INFO "%s %s: IDE port disabled\n",
-				d->name, pci_name(dev));
-			continue;	/* port not enabled */
+		if (e->reg) {
+			pci_read_config_byte(dev, e->reg, &tmp);
+
+			if ((tmp == (u8)~0) || ((tmp & e->mask) != e->val)) {
+				printk(KERN_INFO "%s %s: IDE port disabled\n",
+					d->name, pci_name(dev));
+				continue;	/* port not enabled */
+			}
 		}
 
 		if (ide_hw_configure(dev, d, port, hw + port))
-- 
2.18.4

