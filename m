Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060591EB22E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFAXZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 19:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgFAXZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 19:25:46 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62CB206A4;
        Mon,  1 Jun 2020 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591053944;
        bh=zoSOIOn3WUQ/fb3+axNdzj287bqat0ebjEMWMuXDElE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ApLXfiE64LM/ouJs9KNrTYtPTN87SWs7nk3EjGpQRGet/cVFZ/m7+Trjf/FhdOyiz
         lj6mvgeqbxd6TXaTkJw4PFdYpmaf9XUeBvgm80ChIXD7K63LobxDwhGC1xVBrPLNaD
         LWQHQ2msz4WdEjOiEJETJjvA7Y/Kft/yNXplz5LA=
Date:   Mon, 1 Jun 2020 18:25:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200601232542.GA473883@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg, linux-kernel for wider exposure]

On Tue, May 26, 2020 at 09:30:08AM -0700, Rajat Jain wrote:
> On Thu, May 14, 2020 at 7:18 PM Rajat Jain <rajatja@google.com> wrote:
> > On Thu, May 14, 2020 at 12:13 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > On Wed, May 13, 2020 at 02:26:18PM -0700, Rajat Jain wrote:
> > > > On Wed, May 13, 2020 at 8:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > > > > > Hi,
> > > > > >
> > > > > > Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> > > > > > the firmware asks it to:
> > > > > >
> > > > > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > > > > 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> > > > > >
> > > > > > An "untrusted" device indicates a (likely external facing) device that
> > > > > > may be malicious, and can trigger DMA attacks on the system. It may
> > > > > > also try to exploit any vulnerabilities exposed by the driver, that
> > > > > > may allow it to read/write unintended addresses in the host (e.g. if
> > > > > > DMA buffers for the device, share memory pages with other driver data
> > > > > > structures or code etc).
> > > > > >
> > > > > > High Level proposal
> > > > > > ===============
> > > > > > Currently, the "untrusted" device property is used as a hint to enable
> > > > > > IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> > > > > > go a step further, and allow the administrator to build a list of
> > > > > > whitelisted drivers for these "untrusted" devices. This whitelist of
> > > > > > drivers are the ones that he trusts enough to have little or no
> > > > > > vulnerabilities. (He may have built this list of whitelisted drivers
> > > > > > by a combination of code analysis of drivers, or by extensive testing
> > > > > > using PCIe fuzzing etc). We propose that the administrator be allowed
> > > > > > to specify this list of whitelisted drivers to the kernel, and the PCI
> > > > > > subsystem to impose this behavior:
> > > > > >
> > > > > > 1) The "untrusted" devices can bind to only "whitelisted drivers".
> > > > > > 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> > > > > >
> > > > > > Of course this behavior is to be imposed only if such a whitelist is
> > > > > > provided by the administrator.
> 
> I haven't heard much on this proposal after the initial inputs (to
> which I responded). Essentially, I agree that IO-MMU and ACS
> restrictions need to be put in plcase. But I think we need this
> additionally. Does this look acceptable to you? I wanted to start
> spinning out the patches, but wanted to see if there are any pending
> comments or concerns.

I think it makes sense to code this up and see what it would look
like.  The bare minimum seems like a driver "bind-to-external-devices"
bit that's visible in sysfs plus something in the driver probe path
that checks it.  Neither is inherently PCI-specific, but maybe the
right place will become obvious when implementing it.

I'm still not 100% sure the device "external/untrusted" bit is the
right thing to check.  If you don't trust a driver enough to expose it
to an external device, is it reasonable to trust it for internal
devices?  It seems like one could attack the driver of even an
internal device like a NIC by controlling the data fed to it.  

The existing use of "external/untrusted" for IOMMU protection is
different.  There we're acknowledging that the *device* itself is
unknown and we need to protect ourselves from malicious DMA.

Here we're concerned about a *driver* that's completely under our
control.  If we don't trust the driver, we could (a) fix the problems
in the driver, (b) change the driver so it handles external/untrusted
devices differently, or (c) not ship the driver at all.

I'm also not sure about the administrative details of this.  Certain
versions of the driver may be trusted while others are untrusted.
That would all have to be managed in userspace, so it's not really our
problem, but it sounds like a hassle.  Putting the information in the
driver itself would reduce that.

> > > > > > Details
> > > > > > ======
> > > > > >
> > > > > > 1) A kernel argument ("pci.impose_driver_whitelisting") to enable
> > > > > > imposing of whitelisting by PCI subsystem.
> > > > > >
> > > > > > 2) Add a flag ("whitelisted") in struct pci_driver to indicate whether
> > > > > > the driver is whitelisted.
> > >
> > > I'm not sure if a driver certifying itself as secure is acceptable.
> > >
> > > Probably the pcie-component-authentication type mechanisms can establish
> > > proper root of trust. Othewise we are just hand waving and any method
> > > has its own gaps. You can probably say use the fuzzer etc, but that more
> > > falls in every adminstrator needs to run and qualify every device. Once you
> > > have a firmware update that component needs to be re-certified as well.
> >
> > Yes and No. Yes, the whitelist may have to be re-evaluated for any
> > changes to kernel/drivers. But No, this will not be needed for any
> > device firmware updates.
> >
> > > > > > 3) Use the driver's "whitelisted" flag and the device's "untrusted"
> > > > > > flag, to make a decision about whether to bind or not in
> > > > > > pci_bus_match() or similar.
> > > > > >
> > > > > > 4) A mechanism to allow the administrator to specify the whitelist of
> > > > > > drivers. I think this needs more thought as there are multiple
> > > > > > options.
> > >
> > > A default could be we:
> > >
> > > * Trust nothing - need to have a challenge to establish ROT.
> > > * Trust RCiEP devices. These are integrated components and you can probably
> > >   think its not some FPGA plugged in trying to fake itself to defeat
> > >   security.
> > > * A sysadm supplied list of devices to trust.
> > >    - This could be maybe a RP and all devices below. Since they might be
> > >      all internal facing, the sysadm put those things together. Not plugged
> > >      in external facing ports.
> >
> > Right, but the main problem that we want to solve (about the untrusted
> > devices) still remains unaddressed.
> >
> > I believe that the approach taken by the paper you sent below, where
> > we're building a root of trust using device certificates, key pairs,
> > and challenges is definitely the right long term path. (Although I
> > feel there is still scope of some attacks there, but let's not go
> > there). But it requires the entire device ecosystem to come to an
> > agreement and then move to that, and is a big change (requiring change
> > in HW, FW and SW). That is still far away, and we need to think about
> > what we can do to deal with the current set of (external) devices that
> > we still want to support, and they can only plug in at untrusted
> > ports.
> >
> > > > > > a) Expose individual driver's "whitelisted" flag to userspace so a
> > > > > > boot script can whitelist that driver. There are questions that still
> > > > > > need answered though e.g. what to do about the devices that may have
> > > > > > already been enumerated and rejected by then? What to do with the
> > > > > > already bound devices, if the user changes a driver to remove it from
> > > > > > the whitelist. etc.
> > > > > >
> > > > > >       b) Provide a way to specify the whitelist via the kernel command
> > > > > > line. Accept a ("pci.whitelist") kernel parameter which is a comma
> > > > > > separated list of driver names (just like "module_blacklist"), and
> > > > > > then use it to initialize each driver's "whitelisted" flag as the
> > > > > > drivers are registered. Essentially this would mean that the whitelist
> > > > > > of devices cannot be changed after boot.
> > >
> > > As @Jean suggested in other thread, maybe sysfs attribute to flip after
> > > reboot is a good idea. One needs to be root, probably a good start. And
> > > you don't need to reboot to fix.
> > >
> > > > > > To me (b) looks a better option but I think a future requirement would
> > > > > > be the ability to remove the drivers from the whitelist after boot
> > > > > > (adding drivers to whitelist at runtime may not be that critical IMO)
> > > > >
> > > > > We definitely have some problems in this area.
> > > > >
> > > > > - Thunderbolt has similar security issues, and "bolt"
> > > > >   (https://gitlab.freedesktop.org/bolt/bolt) provides a user interface
> > > > >   for authorizing devices.  Bolt is device-oriented (and specifically
> > > > >   for Thunderbolt), not driver-oriented, and I have no idea what
> > > > >   kernel interfaces it uses, but I wonder if there's some overlap with
> > > > >   this proposal.  It seems like both bolt and this proposal could
> > > > >   ultimately be part of the same user interface.
> > > >
> > > > Thanks for pointing to it! My proposal does indeed stem from enabling
> > > > of thunderbolt in our devices, and the PCIe tunneling (and thus the
> > > > additional threat from external devices) that it brings along. I took
> > > > a brief look at its documentation and it seems (Christian can correct
> > > > me) that it identifies devices with "UUID" and then uses that to drive
> > > > all its decisions. So essentially the problem it is trying to solve is
> > > > determining whether or not to enable PCIe tunnels based on the UUID of
> > > > the device. It seems to me that it assumes that the devices are
> > > > trustworthy (i.e. for eg. they will not spoof any other whitelisted
> > > > UUID). Christian, can you please help explain if bolt is capable of
> > > > dealing with malicious devices that can spoof other devices in order
> > > > to try and do bad things to the system?
> > > >
> > > > > - ATS allows PCIe endpoints to cache address translations so they
> > > > >   can generate DMAs with translated addresses (TLP Address Type 10b,
> > > > >   see PCIe r5.0, sec 10.2.1).  These DMAs can potentially bypass
> > > > >   the IOMMU.
> > > > >
> > > > >   AFAICT, amd_iommu always turns on ATS when possible.  It looks
> > > > >   like intel-iommu and arm-smmu-v3 turn it on except for "untrusted"
> > > > >   (external) devices.
> > > >
> > > > Correct. The point here is to turn on more restrictions on "untrusted" devices.
> > > >
> > > > >   There's nothing to prevent a malicious external device from
> > > > >   generating DMA with translated addresses even if we haven't
> > > > >   enabled ATS.
> >
> > Reading this mail again, I think I now finally understand what Bjorn
> > was trying to say above, and I agree.
> >
> > > @Bjorn: Intel Root ports behave as follows: at least for servers:
> > >
> > > Translation Requests: Are always non-posted. So RP will always respond with
> > > UR if IOMMU.TRANSLATION_ENABLE=0
> > >
> > > Translated Requests can be non-posted (reads), or Posted (Writes).
> > > If IOMMU.TE=0, RP will return UR for reads, and drop writes.
> >
> > This is good info, thanks for confirming.
> >
> > > > >   I think all three IOMMUs have mechanisms to block TLPs with
> > > > >   translated addresses, but I can't tell whether they all *use*
> > > > >   them.
> > > >
> > > > Understood.
> > > >
> > > > > - ACS is an optional capability, but if implemented at all, downstream
> > > > >   ports (including root ports) are required to implement Translation
> > > > >   Blocking.  When enabled, this blocks upstream memory requests with
> > > > >   non-default AT fields.
> > > > >
> > > > >   Linux currently never enables Translation Blocking.  Maybe the IOMMU
> > > > >   protection is sufficient, but I think we should consider enabling TB
> > > > >   by default and disabling it only when required to enable ATS.  That
> > > > >   may catch malicious TLPs closer to the source and help when there is
> > > > >   no IOMMU at all.
> >
> > Agree. Additionally for untrusted ports, we should probably never
> > disable TB and never allow to enable ATS.
> >
> > > > Understood and point taken. Note that enabling IOMMU protection (and
> > > > even disabling ATS and enabling TB) is not enough though. This isn't
> > > > to say that they shouldn't be done. Yes, they definitely need to be
> > > > done. As these can help ensure that a device can generate transactions
> > > > *only* to the memory areas (DMA buffers) that the driver has allotted
> > > > to it, [and thus all the security mitigations (IOMMU/ ACS/AT/TB) have
> > > > been configured so as to provide the device access for those areas].
> > >
> > > I'm not sure how much difference it makes if IOMMU's behave for translation
> > > request and requests with AT=1 accordingly to ensure safety. What
> > > additional protection does Translation blocking provides if we do not turn
> > > on ATS for those untrusted devices.
> >
> > AFAICT nothing for Intel systems like you explained above. But maybe for others?
> >
> > > > What these settings can't help with, though, is a malicious device
> > > > trying to exploit certain driver vulnerabilities, that allow the
> > > > device to do bad things even while *restricting transactions within
> > > > the IOMMU allowed memory*. An attacker can do this by carefully
> > > > looking at drivers to identify and exploit driver vulnerabilities
> > > > (driver negligence). There is a lot of research work, but we for e.g.
> > > > are looking at this:
> > > > https://www.ndss-symposium.org/wp-content/uploads/2019/02/ndss2019_04A-1_Song_paper.pdf.
> > > > Here are the examples of driver vulnerabilities that it found, that
> > > > could be exploited even with the IOMMU/ACS and other restrictions in
> > > > place (please check case studies in sections F/G/H in the above paper)
> > > > since I may not be able to explain that well:
> > > >
> > > > * A driver could be double fetching the memory, causing it to do
> > > > different things than intended. E.g.
> > > > * A driver could be (negligently) passing some kernel addresses to the device.
> > > > * A driver could be using (for memory dereferencing, for e.g.) the
> > > > address/indices, given by the device, without enough validation.
> > > > * A driver may negligently be sharing the DMA memory with some other
> > > > driver data in the same PAGE. Since the IOMMU restrictions are PAGE
> > > > granular, this might give device access to that driver data.
> > > >
> > > > I think the points I am trying to make here are that
> > > >
> > > > 1) Since malicious devices can spoof other (potentially whitelisted)
> > > > devices, classifying devices into trusted and non-trusted is a good
> > > > step, but it is not enough. We do need to go one step further and
> > > > classify drivers into trusted/untrusted also, so as to (allow to)
> > > > impose more restrictions.
> > > >
> > > > 2) Drivers can be vulnerable / exploitable; and finding, fixing, and
> > > > introducing new exploits is a never ending cat and mouse game. But
> > > > everyone's appetite for risk is different depending on use case, and
> > > > thus administrators need a way to say, "I trust these drivers enough
> > > > that I consider them safe for my use, even on untrusted ports".
> > >
> > > with efforts like lockdown kernel, you ensure the entire kernel and drivers
> > > move to-gether.
> >
> > Thanks for pointing. That would be helpful, but I'm not sure if it
> > will address the problems I identified above.
> >
> > > My fear is if we don't keep this security properties small
> > > enough, the pure permutation and combinations would become a validation
> > > nightmare that by itself can't ensure what works and what doesn't.
> > >
> > > > There is going to be a class of threat vectors that cannot be
> > > > addressed by IOMMU and ACS alone. And my proposal aims at those cases
> > > > specifically. It makes the case for an admin to actually look at the
> > > > various drivers and use various techniques available (PCIe fuzzing,
> > > > code analysis etc) to bless drivers. I once again suspect that I may
> > > > have failed to elaborate on the threat vectors clearly. Please let me
> > > > know if that is the case, and in that case, I'll probably ask our
> > > > security folks to chime in.
> > >
> > > When you say "Admin should actually look at the various driver" what does
> > > that mean?  I think we should give a simple security policy enforcement
> > > that is simple enough to keep up with. Until we get those device security
> > > enhancements are placed in practice.
> > >
> > > https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html
> >
> > This I agree with, but until we get those enhanced secured devices in
> > place, we need to build a solution for existing devices that can be
> > plugged on untrusted ports.  Since currently there isn't a way for us
> > to verify device identity, any scheme that builds upon device provided
> > identification, falls apart as soon as we introduce "device spoofing"
> > in the threat model.
> >
> > The proposal allows a Linux distribution/system designer to choose
> > which drivers he wants to allow on the untrusted ports. I think this
> > is a fair ask - given that there isn't any other solution at this time
> > to address the issues I pointed out.
> >
> > Thanks!
> >
> > Rajat
> >
> > PS; A dimension that I think I'd like to mention again are the issues
> > arising out of "driver negligences" (like the vulnerabilities I
> > pointed above). These may not necessarily require a malicious device.
> > A driver whitelist also helps for that.
