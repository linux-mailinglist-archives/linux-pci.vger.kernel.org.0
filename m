Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7870D1D318E
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgENNmx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 09:42:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:37190 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgENNmw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 09:42:52 -0400
IronPort-SDR: 5lgHbvvt4NzVTAlcqN3chXQsLRLl0/uUY1uBZZnIaypANfoU5OTd6ha/bWrCJhPlkq7S9dYf2S
 S276kImC3+aQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 06:42:51 -0700
IronPort-SDR: iVmqsADkFoXBG6PiMbZIL179v00QjW1GxpjpJb0wJ/H0W8ElYLN4Ekt4TPMAI0h29y7lyVOh/Q
 XPrLEFxOwwNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="372274628"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 14 May 2020 06:42:42 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 14 May 2020 16:42:42 +0300
Date:   Thu, 14 May 2020 16:42:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, ashok.raj@intel.com,
        lalithambika.krishnakumar@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
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
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200514134242.GY2571@lahna.fi.intel.com>
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
 <20200513151929.GA38418@bjorn-Precision-5520>
 <CACK8Z6F8ncByr92+PUHPAGudZBM4fqKiau+t=JE6P1963et3fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6F8ncByr92+PUHPAGudZBM4fqKiau+t=JE6P1963et3fQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 13, 2020 at 02:26:18PM -0700, Rajat Jain wrote:
> +ashok.raj@intel.com
> +lalithambika.krishnakumar@intel.com
> 
> On Wed, May 13, 2020 at 8:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Christian (bolt maintainer), Alex, Joerg (IOMMU folks)]
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
> > > whitelisted drivers for these "untrusted" devices. This whitelist of
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
> >
> > We definitely have some problems in this area.
> >
> > - Thunderbolt has similar security issues, and "bolt"
> >   (https://gitlab.freedesktop.org/bolt/bolt) provides a user interface
> >   for authorizing devices.  Bolt is device-oriented (and specifically
> >   for Thunderbolt), not driver-oriented, and I have no idea what
> >   kernel interfaces it uses, but I wonder if there's some overlap with
> >   this proposal.  It seems like both bolt and this proposal could
> >   ultimately be part of the same user interface.
> 
> Thanks for pointing to it! My proposal does indeed stem from enabling
> of thunderbolt in our devices, and the PCIe tunneling (and thus the
> additional threat from external devices) that it brings along. I took
> a brief look at its documentation and it seems (Christian can correct
> me) that it identifies devices with "UUID" and then uses that to drive
> all its decisions. So essentially the problem it is trying to solve is
> determining whether or not to enable PCIe tunnels based on the UUID of
> the device. It seems to me that it assumes that the devices are
> trustworthy (i.e. for eg. they will not spoof any other whitelisted
> UUID). Christian, can you please help explain if bolt is capable of
> dealing with malicious devices that can spoof other devices in order
> to try and do bad things to the system?

It is not. It basically implements the TBT security levels that were
used in PCs before IOMMU was deployed. These security levels are based
on user "approving" a device so if anyone does something malicious to
the "approved" device replaces it with another with the same identity
then all bets are off.

For current systems and USB4 ones we still use bolt to perform two
important things but this is not about security that much:

  1. Disable PCIe tunneling completely
  2. Implement whitelist of TBT/USB4 devices

The whitelist here means that for example administrator can limit users
to use only certain TBT/USB4 devices that their organization wants to
support.

DMA security is handled by IOMMU.

> > - ATS allows PCIe endpoints to cache address translations so they
> >   can generate DMAs with translated addresses (TLP Address Type 10b,
> >   see PCIe r5.0, sec 10.2.1).  These DMAs can potentially bypass
> >   the IOMMU.
> >
> >   AFAICT, amd_iommu always turns on ATS when possible.  It looks
> >   like intel-iommu and arm-smmu-v3 turn it on except for "untrusted"
> >   (external) devices.
> 
> Correct. The point here is to turn on more restrictions on "untrusted" devices.
> 
> >
> >   There's nothing to prevent a malicious external device from
> >   generating DMA with translated addresses even if we haven't
> >   enabled ATS.
> >
> >   I think all three IOMMUs have mechanisms to block TLPs with
> >   translated addresses, but I can't tell whether they all *use*
> >   them.
> 
> Understood.
> 
> >
> > - ACS is an optional capability, but if implemented at all, downstream
> >   ports (including root ports) are required to implement Translation
> >   Blocking.  When enabled, this blocks upstream memory requests with
> >   non-default AT fields.
> >
> >   Linux currently never enables Translation Blocking.  Maybe the IOMMU
> >   protection is sufficient, but I think we should consider enabling TB
> >   by default and disabling it only when required to enable ATS.  That
> >   may catch malicious TLPs closer to the source and help when there is
> >   no IOMMU at all.
> 
> Understood and point taken. Note that enabling IOMMU protection (and
> even disabling ATS and enabling TB) is not enough though. This isn't
> to say that they shouldn't be done. Yes, they definitely need to be
> done. As these can help ensure that a device can generate transactions
> *only* to the memory areas (DMA buffers) that the driver has allotted
> to it, [and thus all the security mitigations (IOMMU/ ACS/AT/TB) have
> been configured so as to provide the device access for those areas].
> 
> What these settings can't help with, though, is a malicious device
> trying to exploit certain driver vulnerabilities, that allow the
> device to do bad things even while *restricting transactions within
> the IOMMU allowed memory*. An attacker can do this by carefully
> looking at drivers to identify and exploit driver vulnerabilities
> (driver negligence). There is a lot of research work, but we for e.g.
> are looking at this:
> https://www.ndss-symposium.org/wp-content/uploads/2019/02/ndss2019_04A-1_Song_paper.pdf.
> Here are the examples of driver vulnerabilities that it found, that
> could be exploited even with the IOMMU/ACS and other restrictions in
> place (please check case studies in sections F/G/H in the above paper)
> since I may not be able to explain that well:
> 
> * A driver could be double fetching the memory, causing it to do
> different things than intended. E.g.
> * A driver could be (negligently) passing some kernel addresses to the device.
> * A driver could be using (for memory dereferencing, for e.g.) the
> address/indices, given by the device, without enough validation.
> * A driver may negligently be sharing the DMA memory with some other
> driver data in the same PAGE. Since the IOMMU restrictions are PAGE
> granular, this might give device access to that driver data.
> 
> I think the points I am trying to make here are that
> 
> 1) Since malicious devices can spoof other (potentially whitelisted)
> devices, classifying devices into trusted and non-trusted is a good
> step, but it is not enough. We do need to go one step further and
> classify drivers into trusted/untrusted also, so as to (allow to)
> impose more restrictions.
> 
> 2) Drivers can be vulnerable / exploitable; and finding, fixing, and
> introducing new exploits is a never ending cat and mouse game. But
> everyone's appetite for risk is different depending on use case, and
> thus administrators need a way to say, "I trust these drivers enough
> that I consider them safe for my use, even on untrusted ports".
> 
> There is going to be a class of threat vectors that cannot be
> addressed by IOMMU and ACS alone. And my proposal aims at those cases
> specifically. It makes the case for an admin to actually look at the
> various drivers and use various techniques available (PCIe fuzzing,
> code analysis etc) to bless drivers. I once again suspect that I may
> have failed to elaborate on the threat vectors clearly. Please let me
> know if that is the case, and in that case, I'll probably ask our
> security folks to chime in.

I think this pretty well explains the issue. At least for me :)
