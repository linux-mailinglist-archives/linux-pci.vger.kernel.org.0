Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FEB6C23B7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 22:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCTVcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCTVcI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 17:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CE30E96
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 14:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B71A61844
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 21:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D760C433D2;
        Mon, 20 Mar 2023 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679347830;
        bh=W0jCMwJ0yiBoT2A8wa4j7CYZclXlmGB2Ixqwtd1i6Gg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O/+pb34C6MRsSN6OogZlmx1O83g4h6I54lbmaUqzJjsSlVuKFF1+KFPmFsODsfJtM
         HyusRriM0acgiOuSRUhjKWqi17kXur3ifog6WfU7b/XFH0PwpOIM+I9dkLrzKpQBjF
         01kPcyU1DZWa0B6322Gz4puEmw7mqTKyJPlokPtpd4vjo0PZw4+CZvTaE90/n1WIzR
         TDud9xIZ2iMR/Lbfutfgb5Ng54kpkUiJa5oIH8RlFc6KYtL6S3m5oVRPHidOdiPz2k
         +3wqmSQNoiQSW1uJGZ2ELpx5YHuBGiR5d4aPsT04pR8cUvjZjb2pXsdqIyJeMcWGEN
         y+0i5DXZ2oxZg==
Date:   Mon, 20 Mar 2023 16:30:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230320213028.GA2323315@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1af321-adf9-afa2-46ca-1b76da576fbd@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 02:47:48PM -0500, Limonciello, Mario wrote:
> > > > On Mon, Mar 20, 2023 at 01:32:16AM +0000, Limonciello, Mario wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Sent: Friday, March 10, 2023 16:14
> > > > > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > > > Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Natikar, Basavaraj
> > > > > > <Basavaraj.Natikar@amd.com>; bhelgaas@google.com; linux-
> > > > > > pci@vger.kernel.org; thomas@glanzmann.de
> > > > > > Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
> > > > > > 
> > > > > > On Thu, Mar 09, 2023 at 06:57:38PM -0600, Mario Limonciello wrote:
> > > > > > > On 3/9/23 16:30, Bjorn Helgaas wrote:
> > > > > > > > On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
> > > > > > > > > On 3/9/2023 12:25, Bjorn Helgaas wrote:
> > > > > > > > > ...
> > 
> > > > it's important that the commit log is accurate and makes sense even to
> > > > people who don't know the internals of the device.
> > > > 
> > > > It *sounds* like what's happening is:
> > > > 
> > > >    - OS writes PMCSR to put device in D3hot
> > > >    - BIOS traps D0->D3hot transition via something like SMI and
> > > >      captures MSI-X state
> > > >    - Device enters D3hot
> > > >    - Device internal MSI-X state is lost
> > > >    - BIOS traps D3hot->D0 transition via SMI
> > > >    - Device enters D0
> > > >    - BIOS restores MSI-X state
> > > >    - OS resumes use of device
> > > > 
> > > > If that's what's happening, the fact that the device loses the
> > > > internal state in D3hot sounds like a *hardware* defect -- if you put
> > > > the device in a system without a BIOS, the D0->D3hot->D0 transitions
> > > > would not work as required by the PCIe spec.
> > > 
> > > Actually it's a controller integrated into the APU.
> > > 
> > > So any system you put this APU into has a BIOS.  Because it's a socketed
> > > APU people can very easily move it from one motherboard to another and one
> > > vendor may have the BIOS properly configuring but another might not.
> > > 
> > > > We can call the fact that BIOS lacks the MSI-X save/restore a BIOS
> > > > defect, but the only reason BIOS would *need* that save/restore is
> > > > because of the underlying *hardware* defect.
> > > > 
> > > > If that's the case, I would expect a commit log something like this:
> > > > 
> > > >    The AMD [1022:15b8] USB controller loses some internal functional
> > > >    MSI-X context when transitioning from D0 to D3hot.  BIOS normally
> > > >    traps D0->D3hot and D3hot->D0 transitions so it can save and restore
> > > >    that internal context, but some firmware in the field lacks this
> > > >    workaround.
> > > 
> > > I wouldn't call it a workaround.  The hardware is doing exactly as it's
> > > intended for how the firmware programmed.
> > 
> > The whole point of the PCI spec is to build devices where standard
> > features like power management can be operated without device-specific
> > knowledge.
> 
> Right.  I "think" the confusion here might stem from the term "BIOS".
> 
> The initialization of the hardware happens from a series of microcontrollers
> in the APU before X86 cores are released from reset. By the time UEFI runs
> all of this should have already happened.
> 
> When I say "BIOS" I mean collectively "all" of this firmware.

I don't understand the point you're making here.  I don't think it
matters whether this device-specific knowledge is in APU
microcontroller firmware, BIOS, Linux, etc.

I'm trying to suggest that if we zoom all the way in and look just at
the PCIe TLPs, we would see two config writes that put the device in
D3hot, then back in D0.  A working device should end up either back in
D0active with MSI-X fully enabled (if No_Soft_Reset is set and MSI-X
was originally enabled), or in D0uninitialized (if No_Soft_Reset is
clear).

But with this device, apparently some additional software intervention
is required, i.e., after the config write to go back to D0, we need
two more writes to clear and set the MSI-X enable bit.

Let's say somebody runs coreboot on this platform.  Does coreboot need
this device-specific knowledge?

> > If we need device-specific code in BIOS or Linux, I'd say
> > that's a workaround.
> 
> Something I'd like to point out in case it wasn't apparent is Windows
> doesn't actually hit this problem.  It doesn't matter if the correct
> hardware initialization code is included in "BIOS" or not.

That's interesting because it means there's something we (I, at least)
don't understand about what's going on here.  Maybe Windows never puts
the device in D3hot at runtime?  Or maybe Windows disables MSI-X
before putting it into D3 and re-enables it after going to D0?  I
don't know how Windows power management works, so I'm not sure this
tells us anything useful about Linux.

> > Does this device set No_Soft_Reset?  If it does, when it receives a
> > config write to PMCSR that puts it in D3hot, followed by a config
> > write that puts it back in D0, it's supposed to return to D0 with no
> > additional software intervention required.  I think that also means no
> > BIOS intervention is required.
> > 
> > If it does not set No_Soft_Reset, pci_pm_reset() assumes that a
> > D0->D3hot->D0 transition resets the device.  We save and restore the
> > MSI-X Capability in that case, but we do NOT run the
> > DECLARE_PCI_FIXUP_RESUME_EARLY quirks.  I think that means MSI-X would
> > not work after a PM reset of this device.
> > 
> > Bjorn
