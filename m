Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391B0103D5
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 04:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEACMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 22:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfEACMw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 22:12:52 -0400
Received: from localhost (104.sub-174-234-128.myvzw.com [174.234.128.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D9E21734;
        Wed,  1 May 2019 02:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556676771;
        bh=lB4/aFNGpFTPYT+2MM7qes/8i6/9JWncrFE5ixUZcw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0SfrUdY4tAMwBEy1M3fwZCtpcWSqWCpLPQ20HeKHUfuXUDF5tKPRx2EWpvZ8PU2KA
         r7fACImZYsRKZ56VzrMrU2Lsg18s5vWrI23zC3KJa5UaxlGLu1O/mR7Ue+Ljglb4RF
         3N6lvvrVRC1Z+Zl8CJky2PiKjN+ko2D14L38CS78=
Date:   Tue, 30 Apr 2019 21:12:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Alex G <mr.nuke.me@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI/LINK: Report degraded links via link
 bandwidth notification"
Message-ID: <20190501021249.GD145057@google.com>
References: <20190429185611.121751-1-helgaas@kernel.org>
 <20190429185611.121751-2-helgaas@kernel.org>
 <d902522e-f788-5e12-6b63-18ac5d5fa955@gmail.com>
 <20190430161151.GB145057@google.com>
 <20190430180508.GB25654@localhost.localdomain>
 <20190430181813.GC25654@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430181813.GC25654@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 30, 2019 at 12:18:13PM -0600, Keith Busch wrote:
> On Tue, Apr 30, 2019 at 12:05:09PM -0600, Keith Busch wrote:
> > On Tue, Apr 30, 2019 at 11:11:51AM -0500, Bjorn Helgaas wrote:
> > > > I'm not convinced a revert is the best call.
> > > 
> > > I have very limited options at this stage of the release, but I'd be
> > > glad to hear suggestions.  My concern is that if we release v5.1
> > > as-is, we'll spend a lot of energy on those false positives.
> > 
> > May be too late now if the revert is queued up, but I think this feature
> > should have been a default 'false' Kconfig bool rather than always on.

Since this feature currently just adds a message in dmesg, which we
don't really consider a stable API, I think a Kconfig switch is a
reasonable option.

If you send me a signed-off-by for the following patch, I can apply it:

commit 302b77157e66
Author: Keith Busch <kbusch@kernel.org>
Date:   Tue Apr 30 12:18:13 2019 -0600

    PCI/LINK: Add Kconfig option (default off)
    
    e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
    notification") added dmesg logging whenever a link changes speed or width
    to a state that is considered degraded.  Unfortunately, it cannot
    differentiate signal integrity-related link changes from those
    intentionally initiated by an endpoint driver, including drivers that may
    live in userspace or VMs when making use of vfio-pci.  Some GPU drivers
    actively manage the link state to save power, which generates a stream of
    messages like this:
    
      vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5 GT/s x16 link)
    
    Since we can't distinguish the intentional changes from the signal
    integrity issues, leave the reporting turned off by default.  Add a Kconfig
    option to turn it on if desired.
    
    Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
    notification")

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 5cbdbca904ac..4a094f0d2856 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -142,3 +142,12 @@ config PCIE_PTM
 
 	  This is only useful if you have devices that support PTM, but it
 	  is safe to enable even if you don't.
+
+config PCIE_BW
+	bool "PCI Express Bandwidth Change Notification"
+	default n
+	depends on PCIEPORTBUS
+	help
+	  This enables PCI Express Bandwidth Change Notification.  If
+	  you know link width or rate changes occur only to correct
+	  unreliable links, you may answer Y.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index f1d7bc1e5efa..d356a5bdb158 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -3,7 +3,6 @@
 # Makefile for PCI Express features and port driver
 
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
-pcieportdrv-y			+= bw_notification.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
@@ -13,3 +12,4 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
+obj-$(CONFIG_PCIE_BW)		:= bw_notification.o
