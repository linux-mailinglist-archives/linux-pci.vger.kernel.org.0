Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF51967D6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 18:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1RKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 13:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1RKL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 13:10:11 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F1920714;
        Sat, 28 Mar 2020 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585415410;
        bh=/PDxSJeJ79NjGwLm/F9FHx5ygVoffePbLoemN5Auc04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hz+ILYiDBU7PcTEWKnkbjqw5j1r2Lz7kwrDL4Mb76RrGXCPvw4mdIA/Xml+U4W3QY
         g9H/TcYXsCkVdOiO2236ByX1fmKazptpbGt0BiAEHmK5SuLfg0slTK2n4sRXhv8YPm
         BqyX8gd+jVdhkaR9FEhN53Ee0vgQVuRvk6ozPf7o=
Date:   Sat, 28 Mar 2020 12:10:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v18 03/11] PCI/DPC: Fix DPC recovery issue in non hotplug
 case
Message-ID: <20200328171007.GA49779@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5af8e6e-ce37-eba4-330e-94b43bd0adb7@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 06:17:44PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 3/24/20 4:49 PM, Bjorn Helgaas wrote:
> > I don't understand why hotplug is relevant here.  This path
> > (dpc_reset_link()) is only used for downstream ports that support DPC.
> > DPC has already disabled the link, which resets everything below the
> > port, regardless of whether the port supports hotplug.
> > 
> > I do see that PCI_ERS_RESULT_NEED_RESET seems to promise a lot more
> > than it actually *does*.  The doc (pci-error-recovery.rst) says
> > .error_detected() can return PCI_ERS_RESULT_NEED_RESET to *request* a
> > slot reset.  But if that happens, pcie_do_recovery() doesn't do a
> > reset at all.  It calls the driver's .slot_reset() method, which tells
> > the driver "we've reset your device; please re-initialize the
> > hardware."
> > 
> > I guess this abuses PCI_ERS_RESULT_NEED_RESET by taking advantage of
> > that implementation deficiency in pcie_do_recovery(): we know the
> > downstream devices have already been reset via DPC, and returning
> > PCI_ERS_RESULT_NEED_RESET means we'll call .slot_reset() to tell the
> > driver about that reset.
> > 
> > I can see how this achieves the desired result, but if/when we fix
> > pcie_do_recovery() to actually *do* the reset promised by
> > PCI_ERS_RESULT_NEED_RESET, we will be doing *two* resets: the first
> > via DPC and a second via whatever slot reset mechanism
> > pcie_do_recovery() would use.
>
> When we fix this issue, if we make sure the reset logic is
> implemented before we call .reset_link callback we should be
> able to avoid resetting the device twice. Before we call DPC
> .reset_link callback, the device link will not up and hence we
> should not able to reset it.
>
> > So I guess the real issue (as you allude to in the commit log) is that
> > we rely on hotplug to unbind/rebind the driver, and without hotplug we
> > need to at least tell the driver the device was reset.
>
> Agree
>
> > I'll try to expand the comment here so it reminds me what's going on
> > when we have to look at this again:)   Let me know if I'm on the right
> > track.
>
> Yes, your understanding is correct.

OK, thanks.  I'm still uncomfortable with this issue, so I think I'm
going to apply this series but omit this patch.  Here's why:

1) The fact that resets may cause hotplug events isn't specific to
DPC, so I don't think dpc_reset_link() is the right place.  For
instance, aer_root_reset() ultimately does a secondary bus reset.  The
pci_slot_reset() -> pciehp_reset_slot() path goes to some trouble to
ignore the resulting hotplug event, but the pci_bus_reset() path does
not.

2) I'm not convinced that "hotplug_is_native()" is the correct test.
Even if we're using ACPI hotplug (acpiphp), that will detach the
drivers and remove the devices, won't it?

I considered something like the patch below, which partly addresses my
first concern, but not the second.  Even the first one is awfully
messy because of the different ways the aer_root_reset() path can
work.


PCI/ERR: Skip driver callbacks if reset causes hotplug remove/add

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 1ac57e9e1e71..000551a06013 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -208,6 +208,18 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		status = reset_link(dev, service);
 		if (status != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
+
+		/*
+		 * If pdev supports hotplug, a link reset causes a hotplug
+		 * remove event.  If we have a hotplug driver, it will
+		 * detach all drivers of downstream devices and remove the
+		 * devices, so we can't call any driver error recovery
+		 * callbacks.  Bringing the link back up causes a hotplug
+		 * add event, and the devices should be re-enumerated and
+		 * the drivers re-attached.
+		 */
+		if (hotplug_is_native(pdev))
+			goto succeeded;
 	} else {
 		pci_walk_bus(bus, report_normal_detected, &status);
 	}
@@ -224,7 +236,11 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		 * functions to reset slot before calling
 		 * drivers' slot_reset callbacks?
 		 */
+		pci_warn(pdev, "driver requested reset, but that's not implemented\n");
 		status = PCI_ERS_RESULT_RECOVERED;
+	}
+
+	if (status == PCI_ERS_RESULT_RECOVERED) {
 		pci_dbg(dev, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
 	}
@@ -235,6 +251,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	pci_dbg(dev, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
+succeeded:
 	pci_aer_clear_device_status(dev);
 	pci_cleanup_aer_uncorrect_error_status(dev);
 	pci_info(dev, "device recovery successful\n");
