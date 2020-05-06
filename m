Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487781C7DD3
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 01:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEFX1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 19:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgEFX1d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 19:27:33 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB2620736;
        Wed,  6 May 2020 23:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588807652;
        bh=xTCXmC5HFmHln29DXmkLrGOAgBXfP+Th2u7ltB1hof0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1f1jEblbynU/syY5JNyhj8bhjheFO88dqVV6LMnpEf6vIksiQDhnqrZpgHaIrgKVk
         27LOlrmUGDtDdRbvuPGe4r27gbYQPHCQ8QJats1OzEblepP28q4aPrLTTHQd68oopf
         KB6zaqhvcwstZ9IDJ9VFHBi42t20neb5H0GvcWfY=
Date:   Wed, 6 May 2020 18:27:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when
 to start waiting
Message-ID: <20200506232730.GA461230@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416083245.73957-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 16, 2020 at 11:32:45AM +0300, Mika Westerberg wrote:
> Kai-Heng Feng reported that it takes long time (>1s) to resume
> Thunderbolt connected PCIe devices from both runtime suspend and system
> sleep (s2idle).
> 
> These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> announces support for speeds > 5 GT/s but it is then capped by the
> second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837

Slight tangent: The bugzilla mentions that lspci doesn't decode
LNKCAP2: https://github.com/pciutils/pciutils/issues/38

Can you try the lspci patch below and see if it matches what you
expect?  It works for me, but I don't understand the kernel issue yet,
so I might be missing something.

commit e2bdd75bbaf6 ("lspci: Decode PCIe Link Capabilities 2")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed May 6 18:05:55 2020 -0500

    lspci: Decode PCIe Link Capabilities 2
    
    Decode Link Capabilities 2, which includes the Supported Link Speeds
    Vector.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/lib/header.h b/lib/header.h
index bfdcc80..3332b32 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -901,6 +901,9 @@
 #define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
 #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
+#define  PCI_EXP_LNKCAP2_SPEED(x)	(((x) >> 1) & 0x7f)
+#define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink Supported */
+#define  PCI_EXP_LNKCAP2_DRS		0x80000000 /* Device Readiness Status */
 #define PCI_EXP_LNKCTL2			0x30	/* Link Control */
 #define  PCI_EXP_LNKCTL2_SPEED(x)	((x) & 0xf) /* Target Link Speed */
 #define  PCI_EXP_LNKCTL2_CMPLNC		0x0010	/* Enter Compliance */
diff --git a/ls-caps.c b/ls-caps.c
index a6705eb..585b208 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1151,6 +1151,29 @@ static void cap_express_dev2(struct device *d, int where, int type)
     }
 }
 
+static const char *cap_express_link2_speed_cap(int vector)
+{
+  /*
+   * Per PCIe r5.0, sec 8.2.1, a device must support 2.5GT/s and is not
+   * permitted to skip support for any data rates between 2.5GT/s and the
+   * highest supported rate.
+   */
+  if (vector & 0x60)
+    return "RsvdP";
+  else if (vector & 0x10)
+    return "2.5-32GT/s";
+  else if (vector & 0x08)
+    return "2.5-16GT/s";
+  else if (vector & 0x04)
+    return "2.5-8GT/s";
+  else if (vector & 0x02)
+    return "2.5-5GT/s";
+  else if (vector & 0x01)
+    return "2.5GT/s";
+
+  return "Unknown";
+}
+
 static const char *cap_express_link2_speed(int type)
 {
   switch (type)
@@ -1204,10 +1227,19 @@ static const char *cap_express_link2_transmargin(int type)
 
 static void cap_express_link2(struct device *d, int where, int type)
 {
+  u32 l;
   u16 w;
 
   if (!((type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END) &&
 	(d->dev->dev != 0 || d->dev->func != 0))) {
+    /* Link Capabilities 2 was reserved before PCIe r3.0 */
+    l = get_conf_long(d, where + PCI_EXP_LNKCAP2);
+    if (l) {
+      printf("\t\tLnkCap2: Supported Link Speeds: %s, Crosslink%c DRS%c\n",
+	  cap_express_link2_speed_cap(PCI_EXP_LNKCAP2_SPEED(l)),
+	  FLAG(l, PCI_EXP_LNKCAP2_CROSSLINK),
+	  FLAG(l, PCI_EXP_LNKCAP2_DRS));
+    }
     w = get_conf_word(d, where + PCI_EXP_LNKCTL2);
     printf("\t\tLnkCtl2: Target Link Speed: %s, EnterCompliance%c SpeedDis%c",
 	cap_express_link2_speed(PCI_EXP_LNKCTL2_SPEED(w)),
