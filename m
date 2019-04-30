Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052FFFFAF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 20:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfD3SYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 14:24:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:35329 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3SYC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 14:24:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 11:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="169379061"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2019 11:24:01 -0700
Date:   Tue, 30 Apr 2019 12:18:13 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20190430181813.GC25654@localhost.localdomain>
References: <20190429185611.121751-1-helgaas@kernel.org>
 <20190429185611.121751-2-helgaas@kernel.org>
 <d902522e-f788-5e12-6b63-18ac5d5fa955@gmail.com>
 <20190430161151.GB145057@google.com>
 <20190430180508.GB25654@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430180508.GB25654@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 30, 2019 at 12:05:09PM -0600, Keith Busch wrote:
> On Tue, Apr 30, 2019 at 11:11:51AM -0500, Bjorn Helgaas wrote:
> > > I'm not convinced a revert is the best call.
> > 
> > I have very limited options at this stage of the release, but I'd be
> > glad to hear suggestions.  My concern is that if we release v5.1
> > as-is, we'll spend a lot of energy on those false positives.
> 
> May be too late now if the revert is queued up, but I think this feature
> should have been a default 'false' Kconfig bool rather than always on.

This is what I mean:

---
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 5cbdbca904ac..7f480685df93 100644
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
+	  This enables PCI Express Bandwidth Change Notification. If
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
--
