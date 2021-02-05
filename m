Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54F231117B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 20:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhBESGJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 13:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233333AbhBESEH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 13:04:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50B3464FB7;
        Fri,  5 Feb 2021 19:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612554343;
        bh=bz/EyQJiUAVXBt1qSMcsB4OXb32ZQhUVe8ziBE+HPu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pug5XRWALIPqH/8FtOaRiBJiNeUy3yTWE//urb1cKpJTUYYreJUSfhNwBxXweAshp
         s3klDIeFd2aABTkd6xz6voYvZ09+gurq5/ZxCJBFhpS7++JO1m7xVGv7Rsc6kA10V2
         vKc1bc3MyyexO06LVhi6t5KvsXit5RgaNRtPwGycEmhkW2jwp6Lg4p7gx0YzIwDbpr
         M3S0cjwhiyRNbDppVxblsKfzreecyVqZc8APi/eA291lEMY2alafikVe5kU+4RL4PH
         gbrS2eIghnZ3Y+u1xJV25Jg1s+LqLhZWs07czGt+7oCOcFTAUm6vM6udFjvkxT23Rh
         Im4sbelikS8bA==
Date:   Fri, 5 Feb 2021 13:45:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
Message-ID: <20210205194541.GA191443@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <423067e5-9d65-5f0f-bedc-9c5939a63be7@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 05, 2021 at 11:08:45AM -0500, Andrey Grodzovsky wrote:
> On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
> > On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
> > > + linux-pci mailing list and a bit of extra details bellow.
> > > 
> > > On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
> > > > Bjorn, Sergey I would also like to use this opportunity to ask you a
> > > > question on a related topic - Hot unplug.
> > > > I've been working for a while on this (see latest patchset set here
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7Ccb508648cdca4144b0af08d8c9ec0c9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481362958887459%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=IZgVF3%2Bq0vGwXBJo5gh8%2BaYEgYnXWqIhnfI3swFDCXU%3D&amp;reserved=0).
> > > > My question is specifically regarding this patch
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7Ccb508648cdca4144b0af08d8c9ec0c9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481362958887459%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ARrUqyg%2F3NoCOs0l6hgaR3Fktqt2nz6Ab0FP9zSVx04%3D&amp;reserved=0
> > > > - the idea here is to
> > > > prevent any accesses to MMIO address ranges still mapped in kernel page
> > 
> > I think you're talking about a PCI BAR that is mapped into a user
> > process.
> 
> For user mappings, including MMIO mappings, we have a reliable
> approach where we invalidate device address space mappings for all
> user on first sign of device disconnect and then on all subsequent
> page faults from the users accessing those ranges we insert dummy
> zero page into their respective page tables. It's actually the
> kernel driver, where no page faulting can be used such as for user
> space, I have issues on how to protect from keep accessing those
> ranges which already are released by PCI subsystem and hence can be
> allocated to another hot plugging device.

That doesn't sound reliable to me, but maybe I don't understand what
you mean by the "first sign of device disconnect." At least from a PCI
perspective, the first sign of a surprise hot unplug is likely to be
an MMIO read that returns ~0.

It's true that the hot unplug will likely cause an interrupt and we
*may* be able to unbind the driver before the driver or a user program
performs an MMIO access, but there's certainly no guarantee.  The
following sequence is always possible:

  - User unplugs PCIe device
  - Bridge raises hotplug interrupt
  - Driver or userspace issues MMIO read
  - Bridge responds with error because link to device is down
  - Host bridge receives error, fabricates ~0 data to CPU
  - Driver or userspace sees ~0 data from MMIO read
  - PCI core fields hotplug interrupt and unbinds driver

> > It is impossible to reliably *prevent* MMIO accesses to a BAR on a
> > PCI device that has been unplugged.  There is always a window
> > where the CPU issues a load/store and the device is unplugged
> > before the load/store completes.
> > 
> > If a PCIe device is unplugged, an MMIO read to that BAR will
> > complete on PCIe with an uncorrectable fatal error.  When that
> > happens there is no valid data from the PCIe device, so the PCIe
> > host bridge typically fabricates ~0 data so the CPU load
> > instruction can complete.
> > 
> > If you want to reliably recover from unplugs like this, I think
> > you have to check for that ~0 data at the important points, i.e.,
> > where you make decisions based on the data.  Of course, ~0 may be
> > valid data in some cases.  You have to use your knowledge of the
> > device programming model to determine whether ~0 is possible, and
> > if it is, check in some other way, like another MMIO read, to tell
> > whether the read succeeded and returned ~0, or failed because of
> > PCIe error and returned ~0.
> 
> Looks like there is a high performance price to pay for this
> approach if we protect at every possible junction (e.g. register
> read/write accessors ), I tested this by doing 1M read/writes while
> using drm_dev_enter/drm_dev_exit which is DRM's RCU based guard
> against device unplug and even then we hit performance penalty of
> 40%. I assume that with actual MMIO read (e.g.
> pci_device_is_present)  will cause a much larger performance
> penalty.

I guess you have to decide whether you want a fast 90% solution or a
somewhat slower 100% reliable solution :)

I don't think the checking should be as expensive as you're thinking.
You only have to check if:

  (1) you're doing an MMIO read (there's no response for MMIO writes,
      so you can't tell whether they succeed),
  (2) the MMIO read returns ~0,
  (3) ~0 might be a valid value for the register you're reading, and
  (4) the read value is important to your control flow.

For example, if you do a series of reads and act on the data after all
the reads complete, you only need to worry about whether the *last*
read failed.  If that last read is to a register that is known to
contain a zero bit, no additional MMIO read is required and the
checking is basically free.

> > > > table by the driver AFTER the device is gone physically and
> > > > from the PCI  subsystem, post pci_driver.remove call back
> > > > execution. This happens because struct device (and struct
> > > > drm_device representing the graphic card) are still present
> > > > because some user clients which  are not aware of hot removal
> > > > still hold device file open and hence prevents device refcount
> > > > to drop to 0. The solution in this patch is brute force where
> > > > we try and find any place we access MMIO mapped to kernel
> > > > address space and guard against the write access with a
> > > > 'device-unplug' flag. This solution is obliviously racy
> > > > because a device can be unplugged right after checking the
> > > > falg.  I had an idea to instead not release but to keep those
> > > > ranges reserved even after pci_driver.remove, until DRM device
> > > > is destroyed when it's refcount drops to 0 and by this to
> > > > prevent new devices plugged in and allocated some of the same
> > > > MMIO address  range to get accidental writes into their
> > > > registers.  But, on dri-devel I was advised that this will
> > > > upset the PCI subsystem and so best to be avoided but I still
> > > > would like another opinion from PCI experts on whether this
> > > > approach is indeed not possible ?
