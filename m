Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC967060E8
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEQHPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEQHPV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 03:15:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7571AD;
        Wed, 17 May 2023 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684307719; x=1715843719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0760VYEfUrxGDdWJcrH2VhqTnnZSGu4a+2aOggBHMgA=;
  b=CtSQJJldxhmOG782HRzVBBELfdDrjy6vtdTpaf/mxM/5zMKUKQXahDFS
   gf/OwReFR6CAZ1GS6TKBx+u4aMxYkBkOJ2S3EBMc4pCh7RrgQtQicouP4
   t4DMK9qVgxgrMowaRvgfxV7zyP5/xM7n5EbCp0N+caN3waGxfZhxYG4l0
   W8SYh2I6drDlQzPHkYABM1pMG0OQFO0dFfeUufDRZJ5Fu6jDOUw/fay4e
   iooQgF817OSOgFXsKVCktHMHuK0S+t8+HbvvKSE2bVAwWnY8FRu9JmWZ2
   oRADO81/2opG0nvUmZDlseVdb39ikob9u3rFxRvZgV0Vg0mkDopqhZtp6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379875842"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="379875842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="652122991"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="652122991"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2023 00:15:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id ED286618; Wed, 17 May 2023 10:15:27 +0300 (EEST)
Date:   Wed, 17 May 2023 10:15:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <mlimonci@amd.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: Re: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Message-ID: <20230517071527.GU66750@black.fi.intel.com>
References: <20230515231515.1440-1-mario.limonciello@amd.com>
 <20230516055918.GS66750@black.fi.intel.com>
 <f0417d28-0c1a-f46e-9cbd-f20f2ac1e9f9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0417d28-0c1a-f46e-9cbd-f20f2ac1e9f9@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Tue, May 16, 2023 at 09:29:38AM -0500, Limonciello, Mario wrote:
> On 5/16/2023 12:59 AM, Mika Westerberg wrote:
> 
> > +Rafael
> > 
> > Hi Mario,
> > 
> > On Mon, May 15, 2023 at 06:15:15PM -0500, Mario Limonciello wrote:
> > > Using an XHCI device to wakeup the system from s2idle fails when
> > > that XHCI device is connected to a USB-C port for an AMD USB4
> > > router.
> > > 
> > > Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
> > > suspend") all root port go into D3 during s2idle.
> > > When the root ports are in D3 over s2idle it's not possible for the
> > > platform firmware to properly identify the wakeup source.
> > > 
> > > As a user presses a key on a keyboard the APU will exit
> > > hardware sleep, but no wake source will be active so the kernel will
> > > let the APU enter back into a hardware sleep state.
> > > 
> > > Here is an example of that sequence of events.  The USB keyboard was
> > > pressed after 11.9 seconds, and then a GPIO was triggered after
> > > another 12 seconds.
> > > ```
> > > PM: suspend-to-idle
> > > ACPI: EC: ACPI EC GPE status set
> > > ACPI: PM: Rearming ACPI SCI for wakeup
> > > amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> > > Timekeeping suspended for 11.985 seconds
> > > PM: Triggering wakeup from IRQ 9
> > > ACPI: EC: ACPI EC GPE status set
> > > ACPI: EC: ACPI EC GPE dispatched
> > > ACPI: EC: ACPI EC work flushed
> > > ACPI: EC: ACPI EC work flushed
> > > ACPI: PM: Rearming ACPI SCI for wakeup
> > > amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> > > PM: Triggering wakeup from IRQ 9
> > > ACPI: EC: ACPI EC GPE status set
> > > ACPI: PM: Rearming ACPI SCI for wakeup
> > > amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> > > Timekeeping suspended for 12.916 seconds
> > > PM: Triggering wakeup from IRQ 9
> > > PM: Triggering wakeup from IRQ 7
> > > ACPI: EC: ACPI EC GPE status set
> > > ACPI: EC: ACPI EC GPE dispatched
> > > ACPI: EC: ACPI EC work flushed
> > > ACPI: PM: Wakeup after ACPI Notify sync
> > > PM: resume from suspend-to-idle
> > > ```
> > > 
> > > If the root ports are in D0 during s2idle, then the wake source is
> > > properly identified and an IRQ is active for the root port, waking
> > > the system up.
> > > 
> > > Here is the same sequence with root ports in D0.  The USB keyboard
> > > was pressed after 11 seconds.
> > > ```
> > > PM: suspend-to-idle
> > > ACPI: EC: ACPI EC GPE status set
> > > ACPI: PM: Rearming ACPI SCI for wakeup
> > > amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> > > Timekeeping suspended for 11.138 seconds
> > > PM: Triggering wakeup from IRQ 9
> > > ACPI: PM: ACPI non-EC GPE wakeup
> > > PM: resume from suspend-to-idle
> > > PM: Triggering wakeup from IRQ 40
> > > ```
> > > 
> > > Comparing registers between Linux and Windows 11 this behavior to put root
> > > ports into D3 at suspend is unique to Linux. Windows does not put the
> > > root ports into D3 over Modern Standby.
> > Are you sure this is the case? Leaving the root port in D0 would mean
> > its power resource is left on and that would leave the whole USB4 domain
> > on consuming quite a lot of power.
> 
> Right - I had the same thought, but at least for AMD after the hardware
> enters into s2idle
> the platform does some internal management of power domains.
> 
> > The root ports involved are supposed
> > to support PME from the D3hot/cold (this is what they advertise in their
> > config spaces) which should allow the OS to move the port into low power
> > states. Of course the PME from D3cold in general needs some ACPI support
> > (typically a GPE) in the BIOS.
> 
> AFAICT the actual issue is entirely a wakeup platform firmware sequencing
> issue
> while in a hardware sleep state and not PMEs.
> 
> It's only exposed by putting the root ports into D3 over s2idle.

But there are two ways to enter s2idle (well or the S0ix whatever is the
AMD term for that). Either through system sleep or simply waiting that
all the needed devices runtime suspend. There should be no difference
from device perspective AFAICT.

> As an experiment on an unpatched kernel if I avoid letting amd-pmc bind then
> the
> hardware will never enter a hardware sleep state over Linux s2idle and this
> issue
> doesn't occur.
> 
> That shows that PMEs *do* work from D3cold.
> 
> With all of this I have to wonder if the Windows behavior of what to do with
> the root
> ports is tied to the uPEP requirements specified in the firmware.
> 
> Linux doesn't do any enforcement or adjustments from what uPEP indicates.
> 
> The uPEP constraints for the root port in question in an affected AMD system
> has:
> 
>                     Package (0x04)
>                     {
>                         Zero,
>                         "\\_SB.PCI0.GP19",
>                         Zero,
>                         Zero
>                     },
> 
> AMD's parsing is through 'lpi_device_get_constraints_amd' so that structure
> shows
> as not enabled and doesn't specify any D-state requirements.

AFAIK this object does not exist in ChromeOS so Linux cannot use it
there.

> What do they specify for Intel on a matching root port?

I think the corresponding entry in ADL-P system for TBT PCIe root port 0
looks like this:

	Package (0x03)
	{
	    "\\_SB.PC00.TRP0",
	    Zero, 
	    Package (0x02)
	    {
		Zero, 
		Package (0x02)
		{
		    0xFF, 
		    0x03
		}
	    }
	},

I'm not entirely sure what does it tell? ;-)
