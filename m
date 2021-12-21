Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBA47C8AD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 22:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhLUVMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 16:12:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:16026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhLUVMC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Dec 2021 16:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640121122; x=1671657122;
  h=message-id:subject:from:reply-to:to:cc:in-reply-to:
   references:mime-version:date:content-transfer-encoding;
  bh=6sWzQDDbAyPSBNpdULYG2Fce+yiVkeUsYUCIGw1P19A=;
  b=ATr0GAqw8DoBog4x6Cgct6Xa+OWTmkr62BDhH1MVGzcIdroogcCtGNDz
   x4xyIjOeqz0DTV+ZKFo7WMh2mAOa3wR5BqC+vHdCKKOz/d5ZXLUqkmmgv
   2XcKMyAgy0FX8ecs7SuznNjTws36/k1k26zAhGVsK6GqPxZurZEPMuUFT
   OSZnrcYF7UlY9zSGjJwanaw9Clq6HSSS1rL8M4jtgmnMioK8aZ8ydgwvg
   z0COPe7JMLdrT67qZnQRFLr5j+BsL6hcsd9EYBJTo0XRZHDVgaKIysmlw
   qUakABxFQnpUxAxPUPdANT4MYN6V+pQBeALEQaGRIuJ8uBu0sRTCQL8ct
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="303864345"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="303864345"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 13:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="586818508"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 21 Dec 2021 13:11:50 -0800
Received: from rbambrou-mobl.amr.corp.intel.com (unknown [10.209.90.33])
        by linux.intel.com (Postfix) with ESMTP id 35919580684;
        Tue, 21 Dec 2021 13:11:50 -0800 (PST)
Message-ID: <9b540d4f11bb4e2e1422b641df1f5e84aa68602f.camel@linux.intel.com>
Subject: Re: [PATCH V4 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        francisco.munoz.ruiz@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CACK8Z6F812_DYVr=sxRXxhtPxyCw206U=jW6CFt6T-MyKJXMgQ@mail.gmail.com>
References: <20211220172848.GA1006510@bhelgaas>
         <e87a297cc74cca02fa1a8f5aa9562489a4db26b3.camel@linux.intel.com>
         <CACK8Z6F812_DYVr=sxRXxhtPxyCw206U=jW6CFt6T-MyKJXMgQ@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 21 Dec 2021 13:11:26 -0800
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, 2021-12-20 at 18:14 -0800, Rajat Jain wrote:
> Hello,
> 
> On Mon, Dec 20, 2021 at 3:06 PM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > Hi Born,
> > 
> > So you know this patch comes from our platform power management team to
> > address several VMD bugs
> > affecting power. The VMD driver developers are already cc'd but also adding
> > Francisco from the VMD
> > team who can maybe help clarify.
> > 
> > On Mon, 2021-12-20 at 11:28 -0600, Bjorn Helgaas wrote:
> > > On Thu, Dec 16, 2021 at 01:24:00PM -0800, David E. Box wrote:
> > > > On Thu, 2021-12-16 at 11:26 -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Dec 15, 2021 at 09:56:00PM -0800, David E. Box wrote:
> > > > > > From: Michael Bottini <michael.a.bottini@linux.intel.com>
> > > > > > 
> > > > > > On Tiger Lake and Alder Lake platforms, VMD controllers do not have
> > > > > > ASPM
> > > > > > enabled nor LTR values set by BIOS. This leads high power
> > > > > > consumption on
> > > > > > these platforms when VMD is enabled as reported in bugzilla
> > > > > > [1].  Enable
> > > > > > these features in the VMD driver using pcie_aspm_policy_override()
> > > > > > to set
> > > > > > the ASPM policy for the root ports.
> > > > > > ...
> > > > > > To do this, add an additional flag in VMD features to specify
> > > > > > devices that must have their respective policies overridden.
> > > > > 
> > > > > I'm not clear on why you want this to apply to only certain VMDs
> > > > > and not others.  Do some BIOSes configure ASPM for devices below
> > > > > some VMDs?
> > > > 
> > > > Not currently. But the plan is for future devices to move back to
> > > > having BIOS do the programming.
> > > 
> > > Since this is apparently a BIOS design choice, it seems wrong to base
> > > the functionality on the Device ID instead of some signal that tells
> > > us what the BIOS is doing.
> > 
> > I don't know if there is another way to tell what the BIOS is _not_ doing.
> > DID is tied to the SoC so
> > it's our best method of inferring this. We know the firmware team has said
> > they will not support
> > programming these values for the mentioned platforms so there's no BIOS
> > update coming to change
> > this.
> 
> I'd like to mention here that ChromeOS also runs linux kernel on TGL
> and ADL platforms, and we may run a different BIOS altogether, so yes,
> we'd greatly appreciate if you do not assume BIOS setting from device
> ID / SOC ID, if the setting is *not tied to device ID / SOC ID*.
> Perhaps you use ACPI or device trees to convey what BIOS has or hasn't
> configured?

The reason why BIOS is not programming these values is because when VMD is
enabled the ports are not visible to BIOS. This would apply to any BIOS
including those used by ChromeOS.


And because BIOS doesn't see these ports ...

> 
> > But to be sure, we can add a check first to confirm that these values have
> > not been programmed
> > (ASPM is disabled and LTRs are 0).
> 
> Yes, reading the ASPM configuration from hardware sounds OK to me.
> 
> > > > > > + * Override the BIOS ASPM policy and set the LTR value for PCI
> > > > > > storage
> > > > > > + * devices on the VMD bride.
> > > > > 
> > > > > I don't think there's any BIOS "policy" here.  At this point BIOS
> > > > > is no longer involved at all, so all that's left is whatever ASPM
> > > > > config the BIOS did or did not do.
> 
> Should the Policy override really take place if aspm_policy =
> POLICY_DEFAULT which seems to suggest we leave it to whatever BIOS
> left it at?

... we cannot rely on POLICY_DEFAULT for their ASPM setting. This leaves the
devices with ASPM disabled.

That said, we do honor the PCI aspm_disabled flag which is tied to both the FADT
bit and module parameter. So we only enable it if OS control is allowed.

> 
> Perhaps for this override to take place, aspm_policy needs to be the
> policy needs to be POLICY_POWERSAVE?
> 
> #define POLICY_DEFAULT 0        /* BIOS default setting */
> #define POLICY_PERFORMANCE 1    /* high performance */
> #define POLICY_POWERSAVE 2      /* high power saving */
> #define POLICY_POWER_SUPERSAVE 3 /* possibly even more power saving */

We do have to set a default in place of the missing BIOS configuration. We chose
to do ASPM_STATE_ALL, allowing all ASPM settings supported by the endpoint.

> 
> 
> > > > > Why only storage?
> > > > 
> > > > Only storage devices will be on these root ports.
> > > 
> > > How do you know this?  You say below that there's an M.2 slot, so
> > > surely the slot could contain a non-storage device?  Couldn't somebody
> > > build a platform with a VMD root port connected to a regular PCIe x4
> > > slot?
> > 
> > In VMD mode the root ports under the VMD bridge are used specifically to
> > manage storage devices. So
> > only storage devices should be attached to these ports.
> 
> Bjorn: from 
> https://www.intel.com/content/www/us/en/architecture-and-technology/intel-volume-management-device-overview.html
> "Intel® Volume Management Device (Intel® VMD) is specifically designed
> for enterprise-grade management of NVMe SSDs connected to Intel® Xeon®
> CPUs."
> 
> I think what David means is that any other device other than an NVME
> SSD showing up under VMD might be an error / bad device.

I don't know if that would happen. It certainly would not be used as intended.

> 
> 
> > >   Couldn't such a slot support hotplug?
> > 
> > The answer I just learned is yes. It may be possible to have a switch too.
> > So both of those would
> > need to be addressed though I'm note quite sure how yet.
> > 
> > > It would be very unusual to hard-code topology knowledge like this
> > > into the kernel, since plug-and-play has always been a major goal of
> > > PCI.
> > > 
> > > > > > +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> > > > > > +{
> > > > > > +       int features = *(int *)userdata, pos;
> > > > > > +
> > > > > > +       if (!(features & VMD_FEAT_QUIRK_OVERRIDE_ASPM) ||
> > > > > > +           pdev->class != PCI_CLASS_STORAGE_EXPRESS)
> > > > > > +               return 0;
> > > > > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT,
> > > > > > 0x1003);
> > > > > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT,
> > > > > > 0x1003);
> > > > > 
> > > > > 1) Where did this magic 0x1003 value come from?  Does that depend
> > > > > on the VMD device?  The endpoint?  The circuit design?  The path
> > > > > between endpoint and VMD?  What if there are switches in the path?
> > > > 
> > > > The number comes from the BIOS team. They are tied to the SoC. I
> > > > don't believe there can be switches in the path but Nirmal and
> > > > Jonathan should know for sure. From what I've seen these root ports
> > > > are wired directly to M.2 slots on boards that are intended for
> > > > storage devices.
> > > 
> > > I guess you're saying that 0x1003 is determined by the SoC.  If so, I
> > > think this value should be in your .driver_data (which would mean
> > > converting it from a scalar to a struct, as many other drivers do).
> > > The current code suggests that 0x1003 is the correct value for *all*
> > > VMDs and all configurations.
> > 
> > Okay
> > 
> > > I don't understand LTR well enough to be convinced that this static
> > > value would be the correct value for all possible hierarchies and
> > > devices that could appear below a VMD root port.  I would love to be
> > > educated about this.
> > 
> > I am not an LTR expert either, but LTRs are "conglomerated" per spec.
> > Switches subtract their own
> > latency from the minimum LTR of the downstream ports and report this
> > conglomerated value upstream.
> > So the value will decrease as needed to account for latency in the
> > hierarchy.
> > 
> > PCI 5.0 Version 1.0, Section 6.18 (pg 611)
> 
> As described here and as much as I understand, I think these LTR
> values (0x1003 here) depend on the platform topology. So what works
> for David's platform may not work for another one that may have
> Switched for e.g., or for perhaps for another NVME that is hotplugged
> later (and has different characteristics than what is on board).
> Technically tying the LTR values to a SOC or VID/DID sounds incorrect
> to me, and instead should be tied to the platform. Ideally I *thiink*
> they should come from ACPI or device tree. However, I wouldn't protest
> putting them in driver_data for now given that there aren't any other
> users. We may have to find a solution once there are more platforms
> that begin to use this driver. I think this is a bigger problem that
> needs to be addressed w.r.t. ASPM in general.

I'll seek more clarification from firmware team on the LTR. But again the fact
that switches can reduce the reported LTR seems to allow for at least some
decoupling of the endpoint LTR value from the topology.

David

> 
> Thanks & Best Regards,
> 
> Rajat
> 
> 
> > Thanks
> > 
> > David
> > 
> > > Bjorn

