Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878451B816
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfEMOUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:20:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41917 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfEMOUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:20:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id l132so7294761pfc.8;
        Mon, 13 May 2019 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfEinhg03sSZ7pXMo+nvFfsTZ9FEX6OAKPCG9/H+74k=;
        b=f9FQd1e7/ceOOJOCQXAC2WhE7XuFVeyvZfexLqJGA+Q09e4MnIgHeZ8ty/U3ELl1kN
         xzT+MwmWrB4ER5d/hDEHk/m4FY6dczVRxFryVDlJaKWzmEDNhUC22nFg8i2fpHjFOJK+
         aJAp/iIG/poe124qypQ4HeUEYrmlNzQIvA1RM1rY0aC+bqM9/xLbyKNzfJRDShg5Vpp9
         HpZoxs9w4x7PJ4lvzbAJy2Wa8NRQ4izDJesjCzJIdGhRXdbl5+Xk1uO5o5ahs/JhPWWO
         MjprhdPWCcES2eMDVEZi15a9GZRIJgp7djL+XPup5AjY967hH82w4IFH15MRNWv8hjad
         rFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfEinhg03sSZ7pXMo+nvFfsTZ9FEX6OAKPCG9/H+74k=;
        b=X03DkhnNXTdOq+K7dD0C6ExEu/PURHqwbaScv7FLJBLC+jvKF1e0Ykze590S7s8E2l
         3kC1TptOEofJWm9WLYUqkYJPeEqIoGfbNXoRZqU6Zd3Y+4VluP+ynQCY7hU5e/lYyumh
         tYhBy/PANi+Nho3CUEIDgdch9sOHGcVYYL2lgshTNZI6qEuFnp+20v2DDFXbzMHcYNC1
         aGWQ4ZOwItLhRHOKm0ns70pibgw2G2pZWYuj0tYYY7P7XjMqtJLBvBvqFAo50t15X8yk
         wEN70THsFd/GwuCEEkUcyr296B++TMzvt3mRlWP5FJ/M2i06DlFDDS87dV3mEWerUSX7
         gprA==
X-Gm-Message-State: APjAAAXOrsgThqjyEcfO7QYWmDRpTok1Fu6rDUcGTzaoFYkcvZcIcYui
        KZATS/nAi8oEsDOiHEWYm+s=
X-Google-Smtp-Source: APXvYqxN6kc1/87dXCo3am7ERCx2aEq4z/OpdQjHq19iVlFNigLkkc5sxFwZ8GmjteNuuNASJJYuzw==
X-Received: by 2002:a62:5653:: with SMTP id k80mr32852165pfb.144.1557757243104;
        Mon, 13 May 2019 07:20:43 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.20.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:20:42 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 05/12] Documentation: PCI: convert MSI-HOWTO.txt to reST
Date:   Mon, 13 May 2019 22:19:53 +0800
Message-Id: <20190513142000.3524-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513142000.3524-1-changbin.du@gmail.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
v2:
  o drop numbering.
  o simplify author list
---
 Documentation/PCI/index.rst                   |  1 +
 .../PCI/{MSI-HOWTO.txt => msi-howto.rst}      | 85 +++++++++++--------
 2 files changed, 52 insertions(+), 34 deletions(-)
 rename Documentation/PCI/{MSI-HOWTO.txt => msi-howto.rst} (88%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 0d9390298c4a..458354daac47 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -11,3 +11,4 @@ Linux PCI Bus Subsystem
    pci
    picebus-howto
    pci-iov-howto
+   msi-howto
diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/msi-howto.rst
similarity index 88%
rename from Documentation/PCI/MSI-HOWTO.txt
rename to Documentation/PCI/msi-howto.rst
index 618e13d5e276..994cbb660ade 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/msi-howto.rst
@@ -1,13 +1,16 @@
-		The MSI Driver Guide HOWTO
-	Tom L Nguyen tom.l.nguyen@intel.com
-			10/03/2003
-	Revised Feb 12, 2004 by Martine Silbermann
-		email: Martine.Silbermann@hp.com
-	Revised Jun 25, 2004 by Tom L Nguyen
-	Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
-		Copyright 2003, 2008 Intel Corporation
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-1. About this guide
+==========================
+The MSI Driver Guide HOWTO
+==========================
+
+:Authors: Tom L Nguyen; Martine Silbermann; Matthew Wilcox
+
+:Copyright: 2003, 2008 Intel Corporation
+
+About this guide
+================
 
 This guide describes the basics of Message Signaled Interrupts (MSIs),
 the advantages of using MSI over traditional interrupt mechanisms, how
@@ -15,7 +18,8 @@ to change your driver to use MSI or MSI-X and some basic diagnostics to
 try if a device doesn't support MSIs.
 
 
-2. What are MSIs?
+What are MSIs?
+==============
 
 A Message Signaled Interrupt is a write from the device to a special
 address which causes an interrupt to be received by the CPU.
@@ -29,7 +33,8 @@ Devices may support both MSI and MSI-X, but only one can be enabled at
 a time.
 
 
-3. Why use MSIs?
+Why use MSIs?
+=============
 
 There are three reasons why using MSIs can give an advantage over
 traditional pin-based interrupts.
@@ -61,14 +66,16 @@ Other possible designs include giving one interrupt to each packet queue
 in a network card or each port in a storage controller.
 
 
-4. How to use MSIs
+How to use MSIs
+===============
 
 PCI devices are initialised to use pin-based interrupts.  The device
 driver has to set up the device to use MSI or MSI-X.  Not all machines
 support MSIs correctly, and for those machines, the APIs described below
 will simply fail and the device will continue to use pin-based interrupts.
 
-4.1 Include kernel support for MSIs
+Include kernel support for MSIs
+-------------------------------
 
 To support MSI or MSI-X, the kernel must be built with the CONFIG_PCI_MSI
 option enabled.  This option is only available on some architectures,
@@ -76,14 +83,15 @@ and it may depend on some other options also being set.  For example,
 on x86, you must also enable X86_UP_APIC or SMP in order to see the
 CONFIG_PCI_MSI option.
 
-4.2 Using MSI
+Using MSI
+---------
 
 Most of the hard work is done for the driver in the PCI layer.  The driver
 simply has to request that the PCI layer set up the MSI capability for this
 device.
 
 To automatically use MSI or MSI-X interrupt vectors, use the following
-function:
+function::
 
   int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		unsigned int max_vecs, unsigned int flags);
@@ -101,12 +109,12 @@ any possible kind of interrupt.  If the PCI_IRQ_AFFINITY flag is set,
 pci_alloc_irq_vectors() will spread the interrupts around the available CPUs.
 
 To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
-vectors, use the following function:
+vectors, use the following function::
 
   int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 
 Any allocated resources should be freed before removing the device using
-the following function:
+the following function::
 
   void pci_free_irq_vectors(struct pci_dev *dev);
 
@@ -126,7 +134,7 @@ The typical usage of MSI or MSI-X interrupts is to allocate as many vectors
 as possible, likely up to the limit supported by the device.  If nvec is
 larger than the number supported by the device it will automatically be
 capped to the supported limit, so there is no need to query the number of
-vectors supported beforehand:
+vectors supported beforehand::
 
 	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_ALL_TYPES)
 	if (nvec < 0)
@@ -135,7 +143,7 @@ vectors supported beforehand:
 If a driver is unable or unwilling to deal with a variable number of MSI
 interrupts it can request a particular number of interrupts by passing that
 number to pci_alloc_irq_vectors() function as both 'min_vecs' and
-'max_vecs' parameters:
+'max_vecs' parameters::
 
 	ret = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
@@ -143,23 +151,24 @@ number to pci_alloc_irq_vectors() function as both 'min_vecs' and
 
 The most notorious example of the request type described above is enabling
 the single MSI mode for a device.  It could be done by passing two 1s as
-'min_vecs' and 'max_vecs':
+'min_vecs' and 'max_vecs'::
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		goto out_err;
 
 Some devices might not support using legacy line interrupts, in which case
-the driver can specify that only MSI or MSI-X is acceptable:
+the driver can specify that only MSI or MSI-X is acceptable::
 
 	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nvec < 0)
 		goto out_err;
 
-4.3 Legacy APIs
+Legacy APIs
+-----------
 
 The following old APIs to enable and disable MSI or MSI-X interrupts should
-not be used in new code:
+not be used in new code::
 
   pci_enable_msi()		/* deprecated */
   pci_disable_msi()		/* deprecated */
@@ -174,9 +183,11 @@ number of vectors.  If you have a legitimate special use case for the count
 of vectors we might have to revisit that decision and add a
 pci_nr_irq_vectors() helper that handles MSI and MSI-X transparently.
 
-4.4 Considerations when using MSIs
+Considerations when using MSIs
+------------------------------
 
-4.4.1 Spinlocks
+Spinlocks
+~~~~~~~~~
 
 Most device drivers have a per-device spinlock which is taken in the
 interrupt handler.  With pin-based interrupts or a single MSI, it is not
@@ -188,7 +199,8 @@ acquire the spinlock.  Such deadlocks can be avoided by using
 spin_lock_irqsave() or spin_lock_irq() which disable local interrupts
 and acquire the lock (see Documentation/kernel-hacking/locking.rst).
 
-4.5 How to tell whether MSI/MSI-X is enabled on a device
+How to tell whether MSI/MSI-X is enabled on a device
+----------------------------------------------------
 
 Using 'lspci -v' (as root) may show some devices with "MSI", "Message
 Signalled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
@@ -196,7 +208,8 @@ has an 'Enable' flag which is followed with either "+" (enabled)
 or "-" (disabled).
 
 
-5. MSI quirks
+MSI quirks
+==========
 
 Several PCI chipsets or devices are known not to support MSIs.
 The PCI stack provides three ways to disable MSIs:
@@ -205,7 +218,8 @@ The PCI stack provides three ways to disable MSIs:
 2. on all devices behind a specific bridge
 3. on a single device
 
-5.1. Disabling MSIs globally
+Disabling MSIs globally
+-----------------------
 
 Some host chipsets simply don't support MSIs properly.  If we're
 lucky, the manufacturer knows this and has indicated it in the ACPI
@@ -219,7 +233,8 @@ on the kernel command line to disable MSIs on all devices.  It would be
 in your best interests to report the problem to linux-pci@vger.kernel.org
 including a full 'lspci -v' so we can add the quirks to the kernel.
 
-5.2. Disabling MSIs below a bridge
+Disabling MSIs below a bridge
+-----------------------------
 
 Some PCI bridges are not able to route MSIs between busses properly.
 In this case, MSIs must be disabled on all devices behind the bridge.
@@ -230,7 +245,7 @@ as the nVidia nForce and Serverworks HT2000).  As with host chipsets,
 Linux mostly knows about them and automatically enables MSIs if it can.
 If you have a bridge unknown to Linux, you can enable
 MSIs in configuration space using whatever method you know works, then
-enable MSIs on that bridge by doing:
+enable MSIs on that bridge by doing::
 
        echo 1 > /sys/bus/pci/devices/$bridge/msi_bus
 
@@ -244,7 +259,8 @@ below this bridge.
 Again, please notify linux-pci@vger.kernel.org of any bridges that need
 special handling.
 
-5.3. Disabling MSIs on a single device
+Disabling MSIs on a single device
+---------------------------------
 
 Some devices are known to have faulty MSI implementations.  Usually this
 is handled in the individual device driver, but occasionally it's necessary
@@ -252,7 +268,8 @@ to handle this with a quirk.  Some drivers have an option to disable use
 of MSI.  While this is a convenient workaround for the driver author,
 it is not good practice, and should not be emulated.
 
-5.4. Finding why MSIs are disabled on a device
+Finding why MSIs are disabled on a device
+-----------------------------------------
 
 From the above three sections, you can see that there are many reasons
 why MSIs may not be enabled for a given device.  Your first step should
@@ -260,8 +277,8 @@ be to examine your dmesg carefully to determine whether MSIs are enabled
 for your machine.  You should also check your .config to be sure you
 have enabled CONFIG_PCI_MSI.
 
-Then, 'lspci -t' gives the list of bridges above a device.  Reading
-/sys/bus/pci/devices/*/msi_bus will tell you whether MSIs are enabled (1)
+Then, 'lspci -t' gives the list of bridges above a device. Reading
+`/sys/bus/pci/devices/*/msi_bus` will tell you whether MSIs are enabled (1)
 or disabled (0).  If 0 is found in any of the msi_bus files belonging
 to bridges between the PCI root and the device, MSIs are disabled.
 
-- 
2.20.1

