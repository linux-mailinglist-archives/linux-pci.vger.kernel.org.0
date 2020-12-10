Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550B92D61BC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbgLJQ0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 11:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732251AbgLJQ0K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 11:26:10 -0500
Date:   Thu, 10 Dec 2020 10:25:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607617528;
        bh=hQXhOORqBl+npz51cCbgYaO3bmwjcjL6yW5cZwFqkpI=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=NNdh08n0NGO908V914QW/5qHDwQPyOxauT9t9mncmzoGemy/+cpY4Ryfrs32Lr2dR
         Y8Yjw9F+AYHKuvBhGcrXF17LkDGVzX8XJG5dRz0kc63EkEw8aYDYf95w8XMl/aK9hs
         oymy9b3iciCSJdKeOkbFp/7w13VJu/SKBlD4mhkaxhk39Ec0iC8kemTGV2zOkVpwdv
         tKOLlexJ5lmF+BjKdLN5mqT9y8LiGxoBi5n4Ji1lrEXw5pRlaPRr3CV4DkM4TstVbE
         8JsnFLs6+O34JMEiLz2CAE8tGIG89jJ7g1Uj8qCDjr11JHu6bwBb4PaY2XwX17siy+
         82zm7yiEUIOLw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Message-ID: <20201210162526.GA28440@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR12MB448871D58F0C212312D7BEB0F7CB0@MN2PR12MB4488.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 10, 2020 at 03:36:36PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
> > Sent: Thursday, December 10, 2020 5:48 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray 
> > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; 
> > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn 
> > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, 
> > Changfeng <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as 
> > broken
> > 
> > Alright. Done that.
> > This should be it finally I believe.
> > Which will be the initial kernel-version that incorporates that?
> 
> Looks good to me.  Bjorn, can you pick this up for PCI?

Didn't apply cleanly, but I applied it by hand to pci/misc for v5.11.
If all goes well it should appear in v5.11-rc1.

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/misc&id=23bb0d9a9fe70a8ff23f53af822f2c6e6f261818

> > -----Original Message-----
> > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Sent: Mittwoch, 9. Dezember 2020 15:24
> > To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>; 
> > Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix 
> > <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; 
> > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn 
> > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, 
> > Changfeng <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as 
> > broken
> > 
> > [AMD Public Use]
> > 
> > > -----Original Message-----
> > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > <Edgar.Merger@emerson.com>
> > > Sent: Wednesday, December 9, 2020 2:59 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray 
> > > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn 
> > > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, 
> > > Changfeng <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as 
> > > broken
> > >
> > > Alex,
> > >
> > > I had to revise the patch. Please see attachment. It is actually two 
> > > more SSIDs affected to that.
> > 
> > Other than some minor whitespace issues, the patch looks fine to me.
> > Please align the subsystem_device lines and put the closing 
> > parenthesis on the same line as the last check.
> > 
> > Thanks!
> > 
> > Alex
> > 
> > >
> > > Best regards,
> > > Edgar
> > >
> > > -----Original Message-----
> > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > Sent: Dienstag, 8. Dezember 2020 09:23
> > > To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; 'Huang, Ray'
> > > <Ray.Huang@amd.com>; 'Kuehling, Felix' <Felix.Kuehling@amd.com>
> > > Cc: 'Will Deacon' <will@kernel.org>; 'linux-kernel@vger.kernel.org'
> > > <linux- kernel@vger.kernel.org>; 'linux-pci@vger.kernel.org' <linux- 
> > > pci@vger.kernel.org>; 'iommu@lists.linux-foundation.org'
> > > <iommu@lists.linux-foundation.org>; 'Bjorn Helgaas'
> > > <bhelgaas@google.com>; 'Joerg Roedel' <jroedel@suse.de>; 'Zhu, 
> > > Changfeng' <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as 
> > > broken
> > >
> > > Applied the patch as in attachment. Verified that ATS for GPU-Device 
> > > had been disabled. See attachment "dmesg_ATS.log".
> > >
> > > Was running that build over night successfully.
> > >
> > > -----Original Message-----
> > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > Sent: Montag, 7. Dezember 2020 05:53
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray 
> > > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn 
> > > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, 
> > > Changfeng <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as 
> > > broken
> > >
> > > Hi Alex,
> > >
> > > I believe in the patch file, this
> > > +		    (pdev->subsystem_device == 0x0c19 ||
> > > +		     pdev->subsystem_device == 0x0c10))
> > >
> > > Has to be changed to:
> > > +		    (pdev->subsystem_device == 0xce19 ||
> > > +		     pdev->subsystem_device == 0xcc10))
> > >
> > > Because our SSIDs are "ea50:ce19" and "ea50:cc10" respectively and 
> > > another one would "ea50:cc08".
> > >
> > > I will apply that patch and feedback the results soon plus the patch 
> > > file that I actually had applied.
> > >
> > >
> > > -----Original Message-----
> > > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Sent: Montag, 30. November 2020 19:36
> > > To: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > <Edgar.Merger@emerson.com>;
> > > Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix 
> > > <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn 
> > > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, 
> > > Changfeng <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as 
> > > broken
> > >
> > > [AMD Public Use]
> > >
> > > > -----Original Message-----
> > > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > <Edgar.Merger@emerson.com>
> > > > Sent: Thursday, November 26, 2020 4:24 AM
> > > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray 
> > > > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; 
> > > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel 
> > > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS 
> > > > as broken
> > > >
> > > > Alex,
> > > >
> > > > This is pretty much the same patch as what I have received from 
> > > > Joerg previously, except that it is tied to the particular Emerson 
> > > > platform and its derivatives (listed with Subsystem IDs).
> > >
> > > Right.  As per my original point, I don't want to disable ATS on all 
> > > Picasso chips because doing so would break GPU compute on them, so 
> > > I'd like to apply this quirk as narrowly as possible.
> > >
> > > >
> > > > Below patch was what Joerg provided me and I successfully tested.
> > > >
> > > > This diff to the kernel should do that:
> > > >
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index 
> > > > f70692ac79c5..3911b0ec57ba 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -5176,6 +5176,8 @@
> > > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> > > > 0x6900, quirk_amd_harvest_no_ats); 
> > > > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, 
> > > > quirk_amd_harvest_no_ats);
> > > >  /* AMD Navi14 dGPU */
> > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, 
> > > > quirk_amd_harvest_no_ats);
> > > > +/* AMD Raven platform iGPU */
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, 
> > > > +quirk_amd_harvest_no_ats);
> > > >  #endif /* CONFIG_PCI_ATS */
> > > >
> > > >  /* Freescale PCIe doesn't support MSI in RC mode */
> > > >
> > > > So far I have seen this issue on two instances of this chip, but I 
> > > > must admit that I did test only two of them to this extent, so I 
> > > > guess it is not a bad chip in particular, but the chips we use are 
> > > > from the same production lot, so it might be a systematical 
> > > > problem of that
> > > production lot?
> > > >
> > > > UEFI-Setup shows:
> > > > Processor Family: 17h
> > > > Procossor Model: 20h - 2Fh
> > > > CPUID: 00820F01
> > > > Microcode Patch Level: 8200103
> > > >
> > > > Looking at the chip-die I found that this is a fully qualified IP 
> > > > Silicon (according to Ryzen Embedded R1000 SOC Interlock).
> > > > YE1305C9T20FG
> > > > BI2015SUY
> > > > 9JB6496P00123
> > > > 2016 AMD
> > > > DIFFUSED IN USA
> > > > MADE IN CHINA
> > > >
> > > > Currently used SBIOS is a branch from "EmbeddedPI-FP5 1.2.0.3RC3".
> > > >
> > > > In the future our SBIOS might merge with EmbeddedPI-FP5_1.2.0.5RC3.
> > > >
> > >
> > > I think it's more likely an sbios issue, so hopefully the new release fixes it.
> > >
> > > Alex
> > >
> > > >
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > > Sent: Mittwoch, 25. November 2020 17:08
> > > > To: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > <Edgar.Merger@emerson.com>;
> > > > Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix 
> > > > <Felix.Kuehling@amd.com>
> > > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; 
> > > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel 
> > > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS 
> > > > as broken
> > > >
> > > > [AMD Public Use]
> > > >
> > > > > -----Original Message-----
> > > > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > > <Edgar.Merger@emerson.com>
> > > > > Sent: Wednesday, November 25, 2020 5:04 AM
> > > > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray 
> > > > > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; 
> > > > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel 
> > > > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS 
> > > > > as broken
> > > > >
> > > > > I do have also other problems with this unit, when IOMMU is 
> > > > > enabled and pci=noats is not set as kernel parameter.
> > > > >
> > > > > [ 2004.265906] amdgpu 0000:0b:00.0: [drm:amdgpu_ib_ring_tests 
> > > > > [amdgpu]]
> > > > > *ERROR* IB test failed on gfx (-110).
> > > > > [ 2004.266024] [drm:amdgpu_device_delayed_init_work_handler
> > > > [amdgpu]]
> > > > > *ERROR* ib ring test failed (-110).
> > > > >
> > > >
> > > > Is this seen on all instances of this chip or only specific silicon?
> > > > I.e., could this be a bad chip?  Would it be possible to test a 
> > > > newer sbios?  I think the attached patch should work if we can't 
> > > > get it fixed on the platform side.  It should only enable the 
> > > > quirk on your
> > > particular platform.
> > > >
> > > > Alex
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > > > Sent: Mittwoch, 25. November 2020 10:16
> > > > > To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; 'Huang,
> > Ray'
> > > > > <Ray.Huang@amd.com>; 'Kuehling, Felix' <Felix.Kuehling@amd.com>
> > > > > Cc: 'Will Deacon' <will@kernel.org>; 'linux-kernel@vger.kernel.org'
> > > > > <linux- kernel@vger.kernel.org>; 'linux-pci@vger.kernel.org'
> > > > > <linux- pci@vger.kernel.org>; 'iommu@lists.linux-foundation.org'
> > > > > <iommu@lists.linux-foundation.org>; 'Bjorn Helgaas'
> > > > > <bhelgaas@google.com>; 'Joerg Roedel' <jroedel@suse.de>; 'Zhu, 
> > > > > Changfeng' <Changfeng.Zhu@amd.com>
> > > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS 
> > > > > as broken
> > > > >
> > > > > Remark:
> > > > >
> > > > > Systems with R1305G APU (which show the issue) have the 
> > > > > following
> > > > > VGA-
> > > > > Controller:
> > > > > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > > > [AMD/ATI] Picasso (rev cf)
> > > > >
> > > > > Systems with V1404I APU (which do not show the issue) have the 
> > > > > following
> > > > > VGA-Controller:
> > > > > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > > > [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile 
> > > > > Series] (rev 83)
> > > > >
> > > > > "rev cf" vs. "ref 83" is probably what you where referring to 
> > > > > with PCI Revision ID.
> > > > >
> > > > > -----Original Message-----
> > > > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > > > Sent: Mittwoch, 25. November 2020 07:05
> > > > > To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; Huang, Ray 
> > > > > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; 
> > > > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel 
> > > > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS 
> > > > > as broken
> > > > >
> > > > > I see that problem only on systems that use a R1305G APU
> > > > >
> > > > > sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
> > > > >
> > > > > shows
> > > > >
> > > > > VCE feature version: 0, firmware version: 0x00000000 UVD feature
> > > > > version: 0, firmware version: 0x00000000 MC feature version: 0, 
> > > > > firmware
> > > > version:
> > > > > 0x00000000 ME feature version: 50, firmware version: 0x000000a3 
> > > > > PFP feature version: 50, firmware version: 0x000000bb CE feature
> > version:
> > > > > 50, firmware version: 0x0000004f RLC feature version: 1, 
> > > > > firmware
> > > version:
> > > > > 0x00000049 RLC SRLC feature version: 1, firmware version:
> > > > > 0x00000001 RLC SRLG feature version: 1, firmware version:
> > > > > 0x00000001 RLC SRLS feature
> > > > > version: 1, firmware version: 0x00000001 MEC feature version: 
> > > > > 50, firmware
> > > > > version: 0x000001b5
> > > > > MEC2 feature version: 50, firmware version: 0x000001b5 SOS 
> > > > > feature
> > > > version:
> > > > > 0, firmware version: 0x00000000 ASD feature version: 0, firmware
> > > version:
> > > > > 0x21000030 TA XGMI feature version: 0, firmware version:
> > > > > 0x00000000 TA RAS feature version: 0, firmware version: 
> > > > > 0x00000000 SMC feature
> > > > > version: 0, firmware version: 0x00002527
> > > > > SDMA0 feature version: 41, firmware version: 0x000000a9 VCN 
> > > > > feature
> > > > > version: 0, firmware version: 0x0110901c DMCU feature version: 
> > > > > 0, firmware
> > > > > version: 0x00000001 VBIOS version: 113-RAVEN2-117
> > > > >
> > > > > We are also using V1404I APU on the same boards and I haven´t 
> > > > > seen the issue on those boards
> > > > >
> > > > > These boards give me slightly different info: sudo cat 
> > > > > /sys/kernel/debug/dri/0/amdgpu_firmware_info
> > > > >
> > > > > VCE feature version: 0, firmware version: 0x00000000 UVD feature
> > > > > version: 0, firmware version: 0x00000000 MC feature version: 0, 
> > > > > firmware
> > > > version:
> > > > > 0x00000000 ME feature version: 47, firmware version: 0x000000a2 
> > > > > PFP feature version: 47, firmware version: 0x000000b9 CE feature
> > version:
> > > > > 47, firmware version: 0x0000004e RLC feature version: 1, 
> > > > > firmware
> > > version:
> > > > > 0x00000213 RLC SRLC feature version: 1, firmware version:
> > > > > 0x00000001 RLC SRLG feature version: 1, firmware version:
> > > > > 0x00000001 RLC SRLS feature
> > > > > version: 1, firmware version: 0x00000001 MEC feature version: 
> > > > > 47, firmware
> > > > > version: 0x000001ab
> > > > > MEC2 feature version: 47, firmware version: 0x000001ab SOS 
> > > > > feature
> > > > version:
> > > > > 0, firmware version: 0x00000000 ASD feature version: 0, firmware
> > > version:
> > > > > 0x21000013 TA XGMI feature version: 0, firmware version:
> > > > > 0x00000000 TA RAS feature version: 0, firmware version: 
> > > > > 0x00000000 SMC feature
> > > > > version: 0, firmware version: 0x00001e5b
> > > > > SDMA0 feature version: 41, firmware version: 0x000000a9 VCN 
> > > > > feature
> > > > > version: 0, firmware version: 0x0110901c DMCU feature version: 
> > > > > 0, firmware
> > > > > version: 0x00000000 VBIOS version: 113-RAVEN-116
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Root Complex
> > > > > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2
> > > > IOMMU
> > > > > 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 
> > > > > 17h (Models
> > > > > 00h-1fh) PCIe Dummy Host Bridge
> > > > > 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 PCIe GPP Bridge [6:0]
> > > > > 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin 
> > > > > Switch Upstream (PCIE SW.US)
> > > > > 00:01.4 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 PCIe GPP Bridge [6:0]
> > > > > 00:01.5 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin 
> > > > > Switch Upstream (PCIE SW.US)
> > > > > 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 
> > > > > 17h (Models
> > > > > 00h-1fh) PCIe Dummy Host Bridge
> > > > > 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Internal PCIe GPP Bridge 0 to Bus A
> > > > > 00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Internal PCIe GPP Bridge 0 to Bus B
> > > > > 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus 
> > > > > Controller (rev 61)
> > > > > 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC 
> > > > > Bridge (rev
> > > > > 51)
> > > > > 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 0
> > > > > 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 1
> > > > > 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 2
> > > > > 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 3
> > > > > 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 4
> > > > > 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 5
> > > > > 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 6
> > > > > 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > > > Raven/Raven2 Device 24: Function 7
> > > > > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > > > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 
> > > > > 0e)
> > > > > 01:00.1 Serial controller: Realtek Semiconductor Co., Ltd. 
> > > > > Device 816a (rev 0e)
> > > > > 01:00.2 Serial controller: Realtek Semiconductor Co., Ltd. 
> > > > > Device 816b (rev 0e)
> > > > > 01:00.3 IPMI Interface: Realtek Semiconductor Co., Ltd. Device 
> > > > > 816c (rev 0e)
> > > > > 01:00.4 USB controller: Realtek Semiconductor Co., Ltd. Device 
> > > > > 816d (rev 0e)
> > > > > 02:00.0 Ethernet controller: Intel Corporation I210 Gigabit 
> > > > > Network Connection (rev 03)
> > > > > 03:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > > > 6-Port/8- Lane Packet Switch
> > > > > 04:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > > > 6-Port/8- Lane Packet Switch
> > > > > 04:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > > > 6-Port/8- Lane Packet Switch
> > > > > 04:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > > > 6-Port/8- Lane Packet Switch
> > > > > 04:04.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > > > 6-Port/8- Lane Packet Switch
> > > > > 04:05.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > > > 6-Port/8- Lane Packet Switch
> > > > > 06:00.0 Serial controller: Asix Electronics Corporation Device
> > > > > 9100
> > > > > 06:00.1 Serial controller: Asix Electronics Corporation Device
> > > > > 9100
> > > > > 07:00.0 Ethernet controller: Intel Corporation I210 Gigabit 
> > > > > Network Connection (rev 03)
> > > > > 0a:00.0 Ethernet controller: Intel Corporation I210 Gigabit 
> > > > > Network Connection (rev 03)
> > > > > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > > > [AMD/ATI] Picasso (rev cf)
> > > > > 0b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] 
> > > > > Raven/Raven2/Fenghuang HDMI/DP Audio Controller
> > > > > 0b:00.2 Encryption controller: Advanced Micro Devices, Inc. 
> > > > > [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
> > > > > 0b:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] 
> > > > > Raven2 USB
> > > > > 3.1
> > > > > 0b:00.5 Multimedia controller: Advanced Micro Devices, Inc. 
> > > > > [AMD] Raven/Raven2/FireFlight/Renoir Audio Processor
> > > > > 0b:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc.
> > > > > [AMD] Raven/Raven2/Renoir Non-Sensor Fusion Hub KMDF driver
> > > > > 0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH 
> > > > > SATA Controller [AHCI mode] (rev 61)
> > > > >
> > > > > PCI Revision ID is 06 I believe. Got that from this lspci -xx
> > > > >
> > > > > 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin 
> > > > > Switch Upstream (PCIE SW.US)
> > > > > 00: 22 10 5d 14 07 04 10 00 00 00 04 06 10 00 81 00
> > > > > 10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
> > > > > 20: e0 fc e0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
> > > > > 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00
> > > > > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > 50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
> > > > > 60: 1f 29 00 00 13 38 73 03 42 00 11 30 00 00 04 00
> > > > > 70: 00 00 40 01 18 00 01 00 00 00 00 00 bf 01 70 00
> > > > > 80: 06 00 00 00 0e 00 00 00 03 00 01 00 00 00 00 00
> > > > > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > a0: 05 c0 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
> > > > > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > c0: 0d c8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
> > > > > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > e0: 00 00 00 00 4c 8a 05 00 00 00 00 00 00 00 00 00
> > > > > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > >
> > > > > -----Original Message-----
> > > > > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > > > Sent: Dienstag, 24. November 2020 16:06
> > > > > To: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > > <Edgar.Merger@emerson.com>;
> > > > > Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix 
> > > > > <Felix.Kuehling@amd.com>
> > > > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; 
> > > > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel 
> > > > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS 
> > > > > as broken
> > > > >
> > > > > [AMD Public Use]
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > > > <Edgar.Merger@emerson.com>
> > > > > > Sent: Tuesday, November 24, 2020 2:29 AM
> > > > > > To: Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix 
> > > > > > <Felix.Kuehling@amd.com>
> > > > > > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander 
> > > > > > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org;
> > > > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; 
> > > > > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel 
> > > > > > <jroedel@suse.de>; Zhu,
> > > > > Changfeng
> > > > > > <Changfeng.Zhu@amd.com>
> > > > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU 
> > > > > > ATS as broken
> > > > > >
> > > > > > Module Version : PiccasoCpu 10
> > > > > > AGESA Version   : PiccasoPI 100A
> > > > > >
> > > > > > I did not try to enter the system in any other way (like via
> > > > > > ssh) than via Desktop.
> > > > >
> > > > > You can get this information from the amdgpu driver.  E.g., sudo 
> > > > > cat /sys/kernel/debug/dri/0/amdgpu_firmware_info .  Also what is 
> > > > > the PCI revision id of your chip (from lspci)?  Also are you 
> > > > > just seeing this on specific versions of the sbios?
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Alex
> > > > >
> > > > >
> > > > > >
> > > > > > -----Original Message-----
> > > > > > From: Huang Rui <ray.huang@amd.com>
> > > > > > Sent: Dienstag, 24. November 2020 07:43
> > > > > > To: Kuehling, Felix <Felix.Kuehling@amd.com>
> > > > > > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander 
> > > > > > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org;
> > > > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; 
> > > > > > Bjorn Helgaas <bhelgaas@google.com>; Merger, Edgar
> > > [AUTOSOL/MAS/AUGS]
> > > > > > <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>;
> > > > > Changfeng
> > > > > > Zhu <changfeng.zhu@amd.com>
> > > > > > Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS 
> > > > > > as
> > > > > broken
> > > > > >
> > > > > > On Tue, Nov 24, 2020 at 06:51:11AM +0800, Kuehling, Felix wrote:
> > > > > > > On 2020-11-23 5:33 p.m., Will Deacon wrote:
> > > > > > > > On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, 
> > > > > > > > Alexander
> > > > wrote:
> > > > > > > >> [AMD Public Use]
> > > > > > > >>
> > > > > > > >>> -----Original Message-----
> > > > > > > >>> From: Will Deacon <will@kernel.org>
> > > > > > > >>> Sent: Monday, November 23, 2020 8:44 AM
> > > > > > > >>> To: linux-kernel@vger.kernel.org
> > > > > > > >>> Cc: linux-pci@vger.kernel.org; 
> > > > > > > >>> iommu@lists.linux-foundation.org; Will Deacon 
> > > > > > > >>> <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; 
> > > > > > > >>> Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar
> > > > Merger
> > > > > > > >>> <Edgar.Merger@emerson.com>; Joerg Roedel
> > > <jroedel@suse.de>
> > > > > > > >>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > > > > > > >>>
> > > > > > > >>> Edgar Merger reports that the AMD Raven GPU does not 
> > > > > > > >>> work reliably on his system when the IOMMU is enabled:
> > > > > > > >>>
> > > > > > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx 
> > > > > > > >>> timeout, signaled seq=1, emitted seq=3
> > > > > > > >>>    | [...]
> > > > > > > >>>    | amdgpu 0000:0b:00.0: GPU reset begin!
> > > > > > > >>>    | AMD-Vi: Completion-Wait loop timed out
> > > > > > > >>>    | iommu ivhd0: AMD-Vi: Event logged 
> > > > > > > >>> [IOTLB_INV_TIMEOUT
> > > > > > > >>> device=0b:00.0 address=0x38edc0970]
> > > > > > > >>>
> > > > > > > >>> This is indicative of a hardware/platform configuration 
> > > > > > > >>> issue so, since disabling ATS has been shown to resolve 
> > > > > > > >>> the problem, add a quirk to match this particular device 
> > > > > > > >>> while Edgar follows-up with AMD
> > > > > > for more information.
> > > > > > > >>>
> > > > > > > >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > > >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > > >>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > > > > > > >>> Suggested-by: Joerg Roedel <jroedel@suse.de>
> > > > > > > >>> Link:
> > > > > > > >>>
> > > > > >
> > > > >
> > > >
> > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Furld
> > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > 3A__nam11.safelinks.p&amp
> > >
> > ;data=04%7C01%7CAlexander.Deucher%40amd.com%7C467e5e31a26440bd4
> > c0d08d8
> > >
> > 9cf98a9c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6374319428
> > 869349
> > >
> > 36%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > zIiLCJBTiI
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=q%2F2XCPX9jAIyCjZbej2q
> > arLwTai
> > > vnq3afaZPu%2BzlWp8%3D&amp;reserved=0
> > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > 252Furld&d=DwIFAw&c=jOU
> > >
> > RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > 862rdSP1
> > >
> > 3_P6LVp7j_9l1xmg&m=YkX6enlEevcTFbwL9p9WtRZLfFv4yrkYWGWII8q_ZSo
> > &s=n3lC5
> > > O0SPjN4j09x39L4oAOOQBED0Rc2xBoAmYeK7_o&e=
> > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > 3A__nam11.safelinks.p&amp
> > > >
> > >
> > ;data=04%7C01%7CAlexander.Deucher%40amd.com%7Cb29c13165c224c3794
> > > 2208d8
> > > >
> > >
> > 9c185604%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430975
> > > 6442408
> > > >
> > >
> > 26%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > > zIiLCJBTiI
> > > >
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2uB%2FmMkuxi%2Bc2Xb
> > > MD%2FhKpcw
> > > > QUxH49QfbCShTd227RDw%3D&amp;reserved=0
> > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > 252Furld&d=DwIFAw&c=jOU
> > > >
> > >
> > RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > > 862rdSP1
> > > >
> > >
> > 3_P6LVp7j_9l1xmg&m=BIpm40CYGVSJNrmoqPI4DeIayU0tYU2D5NpRwfbkZv
> > > A&s=tmsZ3
> > > > ihrSXZ3g6wdJ2maxU9mJ1TGcRxd91z9IQTP00A&e=
> > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > >
> > >
> > 3A__nam11.safelinks.p&amp;data=04%7C01%7CAlexander.Deucher%40amd
> > > >
> > >
> > .com%7C9194a443d95c4ffcb7f708d891ed0889%7C3dd8961fe4884e608e11a82
> > > >
> > >
> > d994e183d%7C0%7C1%7C637419794843309283%7CUnknown%7CTWFpbGZsb
> > > >
> > >
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > >
> > >
> > %3D%7C1000&amp;sdata=4JGSwn7au4u%2FBB69mmq0%2BrWfVG12sEyd5H
> > > > oBUeiut9o%3D&amp;reserved=0
> > > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > > 252Furld&d=DwIFAw&c=jOU
> > > > >
> > > >
> > >
> > RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > > > 862rdSP1
> > > > > 3_P6LVp7j_9l1xmg&m=ZhN0Jau6oCc4cnz64IhGK2-
> > > > XDiD5D_6vW6ZYbifWYF0&s=ndvE-
> > > > > ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=
> > > > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > > > 3A__nam11.safelinks.p&amp
> > > > > >
> > > > >
> > > >
> > >
> > ;data=04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> > > > > c9808d8
> > > > > >
> > > > >
> > > >
> > >
> > 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> > > > > 3633797
> > > > > >
> > > > >
> > > >
> > >
> > 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > > > > zIiLCJBTiI
> > > > > >
> > > > >
> > > >
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VLlzQtS3KWZqQslcJKZYrG
> > > > > sj6eMk3
> > > > > > VWaE%2BXhbNdRx80%3D&amp;reserved=0
> > > > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > > > 252Furld&d=DwIFAw&c=jOU
> > > > > >
> > > > >
> > > >
> > >
> > RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > > > > 862rdSP1
> > > > > > 3_P6LVp7j_9l1xmg&m=MMI_EgCqeOX4EvIftpL7agRxJ-
> > > > > udp1CLokf2QWuzFgE&s=ZLdz6
> > > > > > OgavzNn2vSzsgyL1IB6MbK7hPKavOYwbLhyTPU&e=
> > > > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > > > >
> > > > >
> > > >
> > >
> > 3A__lore%26d%3DDwIDAw%26c%3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQs
> > > > > > QPzPKJGaWbo%26r%3DBJxhacqqa4K1PJGm6_-
> > > > > >
> > > > >
> > > >
> > >
> > 862rdSP13_P6LVp7j_9l1xmg%26m%3DlNXu2xwvyxEZ3PzoVmXMBXXS55jsmf
> > > > > >
> > > > >
> > > >
> > >
> > DicuQFJqkIOH4%26s%3D_5VDNCRQdA7AhsvvZ3TJJtQZ2iBp9c9tFHIleTYT_ZM
> > > > > >
> > > > >
> > > >
> > >
> > %26e%3D&amp;data=04%7C01%7CAlexander.Deucher%40amd.com%7C6d5f
> > > > > >
> > > > >
> > > >
> > >
> > a241f9634692c03908d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7
> > > > > >
> > > > >
> > > >
> > >
> > C0%7C0%7C637417997272974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> > > > > >
> > > > >
> > > >
> > >
> > MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> > > > > >
> > > > >
> > > >
> > >
> > 0&amp;sdata=OEgYlw%2F1YP0C%2FnWBRQUxwBH56mGOJxYMWSQ%2Fj1Y
> > > > > > 9f6Q%3D&amp;reserved=0 .
> > > > > > > >>> kernel.org/linux-
> > > > > > > >>>
> > > > > >
> > iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
> > > > > > > >>> B1310.namprd10.prod.outlook.com
> > > > > > > >>>
> > > > > >
> > > > >
> > > >
> > >
> > her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > > > > > > >>>
> > > > > >
> > > > >
> > > >
> > >
> > 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > > > > > > >>>
> > > > > >
> > > > >
> > > >
> > >
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > > > > > > >>>
> > > > > >
> > > > >
> > > >
> > >
> > LCJXVCI6Mn0%3D%7C1000&amp;sdata=TMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > > > > > > >>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=0
> > > > > > > >>> Signed-off-by: Will Deacon <will@kernel.org>
> > > > > > > >>> ---
> > > > > > > >>>
> > > > > > > >>> Hi all,
> > > > > > > >>>
> > > > > > > >>> Since Joerg is away at the moment, I'm posting this to 
> > > > > > > >>> try to make some progress with the thread in the Link: tag.
> > > > > > > >> + Felix
> > > > > > > >>
> > > > > > > >> What system is this?  Can you provide more details?  Does 
> > > > > > > >> a sbios update fix this?  Disabling ATS for all Ravens 
> > > > > > > >> will break GPU compute for a lot of people.  I'd prefer 
> > > > > > > >> to just black list this particular system (e.g., just 
> > > > > > > >> SSIDs or
> > > > > > > >> revision) if
> > > possible.
> > > > > > >
> > > > > > > +Ray
> > > > > > >
> > > > > > > There are already many systems where the IOMMU is disabled 
> > > > > > > in the BIOS, or the CRAT table reporting the APU compute 
> > > > > > > capabilities is broken. Ray has been working on a fallback 
> > > > > > > to make APUs behave like dGPUs on such systems. That should 
> > > > > > > also cover this case where ATS is blacklisted. That said, it 
> > > > > > > affects the programming model, because we don't support the 
> > > > > > > unified and coherent memory model on dGPUs like we do on 
> > > > > > > APUs with
> > > IOMMUv2.
> > > > > > > So it would be good to
> > > > make
> > > > > > > the conditions for this workaround as narrow as possible.
> > > > > >
> > > > > > Yes, besides the comments from Alex and Felix, may we get your 
> > > > > > firmware version (SMC firmware which is from SBIOS) and device id?
> > > > > >
> > > > > > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx 
> > > > > > > >>> timeout, signaled seq=1, emitted seq=3
> > > > > >
> > > > > > It looks only gfx ib test passed, and fails to lanuch desktop, am I right?
> > > > > >
> > > > > > We would like to see whether it is Raven, Raven kicker (new 
> > > > > > Raven), or Picasso. In our side, per the internal test result, 
> > > > > > we didn't see the similiar issue on Raven kicker and Picasso platform.
> > > > > >
> > > > > > Thanks,
> > > > > > Ray
> > > > > >
> > > > > > >
> > > > > > > These are the relevant changes in KFD and Thunk for reference:
> > > > > > >
> > > > > > > ### KFD ###
> > > > > > >
> > > > > > > commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
> > > > > > > Author: Huang Rui <ray.huang@amd.com>
> > > > > > > Date:   Tue Aug 18 14:54:23 2020 +0800
> > > > > > >
> > > > > > >      drm/amdkfd: implement the dGPU fallback path for apu 
> > > > > > > (v6)
> > > > > > >
> > > > > > >      We still have a few iommu issues which need to address, 
> > > > > > > so force raven
> > > > > > >      as "dgpu" path for the moment.
> > > > > > >
> > > > > > >      This is to add the fallback path to bypass IOMMU if 
> > > > > > > IOMMU
> > > > > > > v2 is disabled
> > > > > > >      or ACPI CRAT table not correct.
> > > > > > >
> > > > > > >      v2: Use ignore_crat parameter to decide whether it will 
> > > > > > > go with IOMMUv2.
> > > > > > >      v3: Align with existed thunk, don't change the way of 
> > > > > > > raven, only renoir
> > > > > > >          will use "dgpu" path by default.
> > > > > > >      v4: don't update global ignore_crat in the driver, and 
> > > > > > > revise fallback
> > > > > > >          function if CRAT is broken.
> > > > > > >      v5: refine acpi crat good but no iommu support case, 
> > > > > > > and rename the
> > > > > > >          title.
> > > > > > >      v6: fix the issue of dGPU initialized firstly, just 
> > > > > > > modify the report
> > > > > > >          value in the node_show().
> > > > > > >
> > > > > > >      Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > > > >      Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > > > > > >      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > > >
> > > > > > > ### Thunk ###
> > > > > > >
> > > > > > > commit e32482fa4b9ca398c8bdc303920abfd672592764
> > > > > > > Author: Huang Rui <ray.huang@amd.com>
> > > > > > > Date:   Tue Aug 18 18:54:05 2020 +0800
> > > > > > >
> > > > > > >      libhsakmt: remove is_dgpu flag in the hsa_gfxip_table
> > > > > > >
> > > > > > >      Whether use dgpu path will check the props which 
> > > > > > > exposed from
> > > > > kernel.
> > > > > > >      We won't need hard code in the ASIC table.
> > > > > > >
> > > > > > >      Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > > > >      Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452
> > > > > > >
> > > > > > > commit 7c60f6d912034aa67ed27b47a29221422423f5cc
> > > > > > > Author: Huang Rui <ray.huang@amd.com>
> > > > > > > Date:   Thu Jul 30 10:22:23 2020 +0800
> > > > > > >
> > > > > > >      libhsakmt: implement the method that using flag which 
> > > > > > > exposed by kfd to configure is_dgpu
> > > > > > >
> > > > > > >      KFD already implemented the fallback path for APU. 
> > > > > > > Thunk will use flag
> > > > > > >      which exposed by kfd to configure is_dgpu instead of 
> > > > > > > hardcode
> > > > > before.
> > > > > > >
> > > > > > >      Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > > > >      Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb
> > > > > > >
> > > > > > > Regards,
> > > > > > >    Felix
> > > > > > >
> > > > > > >
> > > > > > > > Cheers, Alex. I'll have to defer to Edgar for the details, 
> > > > > > > > as my understanding from the original thread over at:
> > > > > > > >
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Furld
> > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > 3A__nam11.safelinks.p&amp
> > >
> > ;data=04%7C01%7CAlexander.Deucher%40amd.com%7C467e5e31a26440bd4
> > c0d08d8
> > >
> > 9cf98a9c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6374319428
> > 869349
> > >
> > 36%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > zIiLCJBTiI
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=q%2F2XCPX9jAIyCjZbej2q
> > arLwTai
> > > vnq3afaZPu%2BzlWp8%3D&amp;reserved=0
> > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > 252Furld&d=DwIFAw&c=jOU
> > >
> > RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > 862rdSP1
> > >
> > 3_P6LVp7j_9l1xmg&m=YkX6enlEevcTFbwL9p9WtRZLfFv4yrkYWGWII8q_ZSo
> > &s=n3lC5
> > > O0SPjN4j09x39L4oAOOQBED0Rc2xBoAmYeK7_o&e=
> > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > 3A__nam11.safelinks.p&amp
> > > >
> > >
> > ;data=04%7C01%7CAlexander.Deucher%40amd.com%7Cb29c13165c224c3794
> > > 2208d8
> > > >
> > >
> > 9c185604%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430975
> > > 6442408
> > > >
> > >
> > 26%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > > zIiLCJBTiI
> > > >
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2uB%2FmMkuxi%2Bc2Xb
> > > MD%2FhKpcw
> > > > QUxH49QfbCShTd227RDw%3D&amp;reserved=0
> > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > 252Furld&d=DwIFAw&c=jOU
> > > >
> > >
> > RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > > 862rdSP1
> > > >
> > >
> > 3_P6LVp7j_9l1xmg&m=BIpm40CYGVSJNrmoqPI4DeIayU0tYU2D5NpRwfbkZv
> > > A&s=tmsZ3
> > > > ihrSXZ3g6wdJ2maxU9mJ1TGcRxd91z9IQTP00A&e=
> > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > >
> > >
> > 3A__nam11.safelinks.p&amp;data=04%7C01%7CAlexander.Deucher%40amd
> > > >
> > >
> > .com%7C9194a443d95c4ffcb7f708d891ed0889%7C3dd8961fe4884e608e11a82
> > > >
> > >
> > d994e183d%7C0%7C1%7C637419794843309283%7CUnknown%7CTWFpbGZsb
> > > >
> > >
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > >
> > >
> > %3D%7C1000&amp;sdata=4JGSwn7au4u%2FBB69mmq0%2BrWfVG12sEyd5H
> > > > oBUeiut9o%3D&amp;reserved=0
> > > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > > 252Furld&d=DwIFAw&c=jOU
> > > > >
> > > >
> > >
> > RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > > > 862rdSP1
> > > > > 3_P6LVp7j_9l1xmg&m=ZhN0Jau6oCc4cnz64IhGK2-
> > > > XDiD5D_6vW6ZYbifWYF0&s=ndvE-
> > > > > ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=
> > > > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > > > 3A__nam11.safelinks.p&amp
> > > > > >
> > > > >
> > > >
> > >
> > ;data=04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> > > > > c9808d8
> > > > > >
> > > > >
> > > >
> > >
> > 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> > > > > 3633797
> > > > > >
> > > > >
> > > >
> > >
> > 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > > > > zIiLCJBTiI
> > > > > >
> > > > >
> > > >
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VLlzQtS3KWZqQslcJKZYrG
> > > > > sj6eMk3
> > > > > > VWaE%2BXhbNdRx80%3D&amp;reserved=0
> > > > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > > > 252Fur&d=DwIFAw&c=jOURT
> > > > > >
> > > >
> > kCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > > > > 862rdSP13_
> > > > > > P6LVp7j_9l1xmg&m=MMI_EgCqeOX4EvIftpL7agRxJ-
> > > > > udp1CLokf2QWuzFgE&s=IPZRolk
> > > > > > y3TYlbWPsOkY37MbDdzwhc1b_LaE6JkaOkOo&e=
> > > > > > > > ldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > > > > 3A__lore.kernel.org&a
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > mp;data=04%7C01%7CAlexander.Deucher%40amd.com%7C6d5fa241f963469
> > > > > > 2c039
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > 08d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63741
> > > > > > 79972
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > 72974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > > > > V2luMzI
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=iKTPucGQqcRXET
> > > > > > QZiQz
> > > > > > > > j90WdJeCYDytdZHJ1ZiUyR%2FM%3D&amp;reserved=0
> > > > > > > > _linux-
> > > 2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-
> > > > > > 40MWHPR10MB131
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > 0.namprd10.prod.outlook.com_&d=DwIDAw&c=jOURTkCZzT8tVB5xPEYIm3Y
> > > > > > JGoxo
> > > > > > > > TaQsQPzPKJGaWbo&r=BJxhacqqa4K1PJGm6_-
> > > > > > 862rdSP13_P6LVp7j_9l1xmg&m=lNXu
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > 2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=dsAVVJbD7gJIj3ctZpnnU
> > > > > > 60y21
> > > > > > > > ijWZmZ8xmOK1cO_O0&e=
> > > > > > > >
> > > > > > > > is that this is a board developed by his company.
> > > > > > > >
> > > > > > > > Edgar -- please can you answer Alex's questions?
> > > > > > > >
> > > > > > > > Will
