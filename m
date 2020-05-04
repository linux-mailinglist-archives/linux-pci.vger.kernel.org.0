Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AA21C46EC
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgEDTR4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTRz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 15:17:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308DC061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 12:17:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so10894447ljl.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5y7s4PWroa1gwnyLNtSMCQ3JGVI+WJOL6EKjMe5W3F4=;
        b=CEF5KbC+ZZv1agEd0hGUTJb1kaDpTU4CRpY2Xpas5rFl1VLfRh3lj25UefL2wLcdRY
         gOxJPUXUL0ms20FmQjPDgnd9uwmAz78iKPEAnMxDKjmuOeO0emcRq3OvxV0VFgUXieLq
         1kGDqMioYKobgJ6PezvSUPBO1UcFs1KSYiXSZ77nVl01ayvjwYKBdXkX1IclkoENgpl6
         NAOwgU803LsYI7KViRQOU0fWhMoSh3z7DHtNeAwuCEqJf4ONrS6/H1IdXvQ3894zIFan
         8ZRYtjSlSZpQ6OFj7iKzCZ+kCo0vdSzUXmpWSHEuv7gbu1J2E5lS1YXDxG5J/xFPYE1s
         DtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5y7s4PWroa1gwnyLNtSMCQ3JGVI+WJOL6EKjMe5W3F4=;
        b=SAuQXB9coHECv9Qb3Vzh65cMUQea4+I49CPacwjNZI+b2DJ6+MYgZn1h06UcNPkTVu
         kbsOX/Wp9IGP4PeOZaNhVMwRPQUYj1VSHKYVcbIRDEoeoJLaDVf3aZsTZu1Wg2VRsh0U
         iQ2LpHI0c+Ghg8riShG8w7kQgxOHn9AewMEEkIP+9yWmb+kRpSrMG/HMuO7lQDYtrbfY
         izT2WmWnOqMmb0N6soEQ2GopDWGGXEopaQhUNpxVs70K/mRjNAIgS5XknIjZlXLrX/sh
         joWFhvjIVyt6qty+gGITgskY5AV9yMDZ2HCQyMrBLTxGX8UFT7QIwZ/UkETYLEjFvJGH
         d5lw==
X-Gm-Message-State: AGi0PuYgu8R1NzpOfF4nlJvhvIg3pZrpHVNrFwVoKP0EKuh0STG5eZgY
        zFW0YwC5Fc9Eehr4xzBJie2WNrtHV4iYNcA1DYzCkA==
X-Google-Smtp-Source: APiQypIUu7FD3s3XXpHx+vYIdjrQuSwSFdLkibpsRLYPj2rH8EU4fAwHSnE22AnEZsVmyhLng9Z/Uqr4Lbmej0JTvQQ=
X-Received: by 2002:a2e:9785:: with SMTP id y5mr10391063lji.66.1588619873361;
 Mon, 04 May 2020 12:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
 <20200504114727.GA64193@myrica> <20200504115942.GB64193@myrica>
In-Reply-To: <20200504115942.GB64193@myrica>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 4 May 2020 12:17:16 -0700
Message-ID: <CACK8Z6FnwE8aNiWqYN1gw6-vr8W8WB7eASQF3kH8PB=pBfnE+g@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 4, 2020 at 4:59 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Mon, May 04, 2020 at 01:47:27PM +0200, Jean-Philippe Brucker wrote:
> > Hi,
> >
> > On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > > Hi,
> > >
> > > Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> > > the firmware asks it to:
> > >
> > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> > >
> > > An "untrusted" device indicates a (likely external facing) device that
> > > may be malicious, and can trigger DMA attacks on the system. It may
> > > also try to exploit any vulnerabilities exposed by the driver, that
> > > may allow it to read/write unintended addresses in the host (e.g. if
> > > DMA buffers for the device, share memory pages with other driver data
> > > structures or code etc).
> > >
> > > High Level proposal
> > > ===============
> > > Currently, the "untrusted" device property is used as a hint to enable
> > > IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> > > go a step further, and allow the administrator to build a list of
> > > whitelisted drivers for these "untrusted" devices.
> >
> > How about letting the administrator whitelist devices that are trusted,
> > rather than whitelisting drivers?
>
> Uh, I completely missed the point. Your proposal is about preventing from
> binding any untrusted devices to non-whitelisted drivers. Please disregard
> my reply :)

Yes, my proposal is about ensuring untrusted devices can be bound to
only trusted drivers (if the administrator so desires).

Thanks for the links though - I think they may be additionally useful
for what we're trying to do.

Thanks,

Rajat


>
> Thanks,
> Jean
>
> >
> > The "thunderclap" attack [1] emulates an existing device using an FPGA in
> > order to get probed by the device driver, and then bypasses a weakened
> > IOMMU. By design the driver cannot differentiate a well-behaved device
> > from a malicious one, so changing the trust level of the driver doesn't
> > feel like the right way. What the admin wants to say is "I trust this
> > port, no one is plugging any malicious device in here."
> >
> > Then you could also make the option 3-way: either keep the default trust
> > fixed by FW, or manually set "trusted" or "untrusted".
> >
> > For reference there have been several discussions, recently, about letting
> > admins change IOMMU configuration for a device. A PCI command-line option
> > [2] was suggested, but I think the current proposal is a sysfs knob on
> > IOMMU groups [3], that can be changed while devices are unbound from
> > drivers. It's not completely relevant since the "untrusted" property isn't
> > tied to the IOMMU subsystem, but seemed worth mentioning.
> >
> > [1] https://thunderclap.io/thunderclap-paper-ndss2019.pdf
> > [2] https://lore.kernel.org/linux-iommu/20200101052648.14295-3-baolu.lu@linux.intel.com/
> > [3] https://lore.kernel.org/linux-iommu/5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com/
> >
> > Thanks,
> > Jean
> >
> > > This whitelist of
> > > drivers are the ones that he trusts enough to have little or no
> > > vulnerabilities. (He may have built this list of whitelisted drivers
> > > by a combination of code analysis of drivers, or by extensive testing
> > > using PCIe fuzzing etc). We propose that the administrator be allowed
> > > to specify this list of whitelisted drivers to the kernel, and the PCI
> > > subsystem to impose this behavior:
> > >
> > > 1) The "untrusted" devices can bind to only "whitelisted drivers".
> > > 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> > >
> > > Of course this behavior is to be imposed only if such a whitelist is
> > > provided by the administrator.
> > >
> > > Details
> > > ======
> > >
> > > 1) A kernel argument ("pci.impose_driver_whitelisting") to enable
> > > imposing of whitelisting by PCI subsystem.
> > >
> > > 2) Add a flag ("whitelisted") in struct pci_driver to indicate whether
> > > the driver is whitelisted.
> > >
> > > 3) Use the driver's "whitelisted" flag and the device's "untrusted"
> > > flag, to make a decision about whether to bind or not in
> > > pci_bus_match() or similar.
> > >
> > > 4) A mechanism to allow the administrator to specify the whitelist of
> > > drivers. I think this needs more thought as there are multiple
> > > options.
> > >
> > > a) Expose individual driver's "whitelisted" flag to userspace so a
> > > boot script can whitelist that driver. There are questions that still
> > > need answered though e.g. what to do about the devices that may have
> > > already been enumerated and rejected by then? What to do with the
> > > already bound devices, if the user changes a driver to remove it from
> > > the whitelist. etc.
> > >
> > >       b) Provide a way to specify the whitelist via the kernel command
> > > line. Accept a ("pci.whitelist") kernel parameter which is a comma
> > > separated list of driver names (just like "module_blacklist"), and
> > > then use it to initialize each driver's "whitelisted" flag as the
> > > drivers are registered. Essentially this would mean that the whitelist
> > > of devices cannot be changed after boot.
> > >
> > > To me (b) looks a better option but I think a future requirement would
> > > be the ability to remove the drivers from the whitelist after boot
> > > (adding drivers to whitelist at runtime may not be that critical IMO)
> > >
> > >  WDYT?
> > >
> > > Thanks,
> > >
> > > Rajat
