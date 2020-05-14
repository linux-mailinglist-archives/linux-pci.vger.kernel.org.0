Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0C1D3D39
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgENTM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 15:12:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:63146 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgENTM6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 15:12:58 -0400
IronPort-SDR: bGK1WpEvhAJWi7rk1zt2oQDyupm2bnUCoTk0rmK+3qIS53OeeuAmpjGZKVu5BwStt6fk6yrJ3w
 QINyQ/mdA8Ng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 12:12:46 -0700
IronPort-SDR: xhy3lpuX5VTHLfyGzonO61xivAtPd0V3Z4O06aWRgLN3Eum/OmSAc38j5CaJR38pthjhLsdCCS
 qfyJ9K5BrtNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="251775146"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2020 12:12:46 -0700
Date:   Thu, 14 May 2020 12:12:46 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200514191246.GB66397@otc-nc-03>
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
 <20200513151929.GA38418@bjorn-Precision-5520>
 <CACK8Z6F8ncByr92+PUHPAGudZBM4fqKiau+t=JE6P1963et3fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6F8ncByr92+PUHPAGudZBM4fqKiau+t=JE6P1963et3fQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rajat,


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

I'm not sure if a driver certifying itself as secure is acceptable.

Probably the pcie-component-authentication type mechanisms can establish
proper root of trust. Othewise we are just hand waving and any method
has its own gaps. You can probably say use the fuzzer etc, but that more
falls in every adminstrator needs to run and qualify every device. Once you 
have a firmware update that component needs to be re-certified as well.


> > >
> > > 3) Use the driver's "whitelisted" flag and the device's "untrusted"
> > > flag, to make a decision about whether to bind or not in
> > > pci_bus_match() or similar.
> > >
> > > 4) A mechanism to allow the administrator to specify the whitelist of
> > > drivers. I think this needs more thought as there are multiple
> > > options.

A default could be we:

* Trust nothing - need to have a challenge to establish ROT.
* Trust RCiEP devices. These are integrated components and you can probably
  think its not some FPGA plugged in trying to fake itself to defeat
  security.
* A sysadm supplied list of devices to trust. 
   - This could be maybe a RP and all devices below. Since they might be
     all internal facing, the sysadm put those things together. Not plugged
     in external facing ports. 

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

As @Jean suggested in other thread, maybe sysfs attribute to flip after
reboot is a good idea. One needs to be root, probably a good start. And 
you don't need to reboot to fix.

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
> 
> >
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

@Bjorn: Intel Root ports behave as follows: at least for servers:

Translation Requests: Are always non-posted. So RP will always respond with
UR if IOMMU.TRANSLATION_ENABLE=0

Translated Requests can be non-posted (reads), or Posted (Writes).
If IOMMU.TE=0, RP will return UR for reads, and drop writes.


* 
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

I'm not sure how much difference it makes if IOMMU's behave for translation
request and requests with AT=1 accordingly to ensure safety. What
additional protection does Translation blocking provides if we do not turn
on ATS for those untrusted devices.

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

with efforts like lockdown kernel, you ensure the entire kernel and drivers
move to-gether. My fear is if we don't keep this security properties small
enough, the pure permutation and combinations would become a validation
nightmare that by itself can't ensure what works and what doesn't.

> 
> There is going to be a class of threat vectors that cannot be
> addressed by IOMMU and ACS alone. And my proposal aims at those cases
> specifically. It makes the case for an admin to actually look at the
> various drivers and use various techniques available (PCIe fuzzing,
> code analysis etc) to bless drivers. I once again suspect that I may
> have failed to elaborate on the threat vectors clearly. Please let me
> know if that is the case, and in that case, I'll probably ask our
> security folks to chime in.

When you say "Admin should actually look at the various driver" what does
that mean?  I think we should give a simple security policy enforcement
that is simple enough to keep up with. Until we get those device security
enhancements are placed in practice.

https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html

Cheers,
Ashok
