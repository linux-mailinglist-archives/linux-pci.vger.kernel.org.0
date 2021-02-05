Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3468B310D94
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhBEOZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 09:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232573AbhBEOXL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 09:23:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB565650EB;
        Fri,  5 Feb 2021 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612539492;
        bh=/UHax9DSDxhTbZB5UfpvqL6k+tyO1o1Te0/jqrQRHZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rgLgeuyeb2XR/2ZkiProvByNiAZuhlih18TpVAuOv8ZABT5fv+FDPs7hTIOJLWpP1
         aiLJfbpMqI9SS3Cz5NrNfNhpDkKGnkB1s7gv/XQN/pfI/n0sgM7W2xjgjtl+ZxxJFG
         xEM2wxulg+lDCStLyrVE0hCz10Y7Jsfs36igrGnSwVcMOnB/9m3v6JMuREx/5XDvR/
         bTWmkuGnXfEGKvkdLYj2TTgZ4jb71wauUVHFPPCllgTkQr+KUNox4FE9fiFtYdgnN0
         M6/bfWyJNO//S5FoZeTSW5Wy9HFB+z6ejl6FGhkozchQVMMtgrqQBIGJY20NPwh0u5
         WDlg/ktPMhD2A==
Date:   Fri, 5 Feb 2021 09:38:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
Message-ID: <20210205153809.GA179207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31a7498d-dd68-f194-cbf5-1f73a53322ff@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
> + linux-pci mailing list and a bit of extra details bellow.
> 
> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
> > Bjorn, Sergey I would also like to use this opportunity to ask you a
> > question on a related topic - Hot unplug.
> > I've been working for a while on this (see latest patchset set here
> > https://lists.freedesktop.org/archives/amd-gfx/2021-January/058595.html).
> > My question is specifically regarding this patch
> > https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html
> > - the idea here is to
> > prevent any accesses to MMIO address ranges still mapped in kernel page

I think you're talking about a PCI BAR that is mapped into a user
process.

It is impossible to reliably *prevent* MMIO accesses to a BAR on a
PCI device that has been unplugged.  There is always a window where
the CPU issues a load/store and the device is unplugged before the
load/store completes.

If a PCIe device is unplugged, an MMIO read to that BAR will complete
on PCIe with an uncorrectable fatal error.  When that happens there is
no valid data from the PCIe device, so the PCIe host bridge typically
fabricates ~0 data so the CPU load instruction can complete.

If you want to reliably recover from unplugs like this, I think you
have to check for that ~0 data at the important points, i.e., where
you make decisions based on the data.  Of course, ~0 may be valid data
in some cases.  You have to use your knowledge of the device
programming model to determine whether ~0 is possible, and if it is,
check in some other way, like another MMIO read, to tell whether the
read succeeded and returned ~0, or failed because of PCIe error and
returned ~0.

> > table by the driver AFTER the device is gone physically and from the
> > PCI  subsystem, post pci_driver.remove
> > call back execution. This happens because struct device (and struct
> > drm_device representing the graphic card) are still present because some
> > user clients which  are not aware
> > of hot removal still hold device file open and hence prevents device
> > refcount to drop to 0. The solution in this patch is brute force where
> > we try and find any place we access MMIO
> > mapped to kernel address space and guard against the write access with a
> > 'device-unplug' flag. This solution is obliviously racy because a device
> > can be unplugged right after checking the falg.
> > I had an idea to instead not release but to keep those ranges reserved
> > even after pci_driver.remove, until DRM device is destroyed when it's
> > refcount drops to 0 and by this to prevent new devices plugged in
> > and allocated some of the same MMIO address  range to get accidental
> > writes into their registers.
> > But, on dri-devel I was advised that this will upset the PCI subsystem
> > and so best to be avoided but I still would like another opinion from
> > PCI experts on whether this approach is indeed not possible ?
> > 
> > Andrey
