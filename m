Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60496C1D9B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCTRU1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjCTRTa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 13:19:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0688783C6
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 10:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33C05B8100E
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 17:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF4FC433D2;
        Mon, 20 Mar 2023 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679332488;
        bh=syPDEXb/p7NJLbrDUG+nmYvCJxZN+I53a30cV//Z7Yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p+o4ngf+jRHmD5KDkPBEV8sOGp+WVv30aQmqe8PFsVHgNu8+8YwPYw+fr9RD+A8/5
         mspwDOsJJzuNCkXqjv2lrn6RFCbB1+ZW6Nvi6Aq8wUlWj4T+S7wVHrjnCe2ZKIBqFn
         wiFtfiFd3iCWYcZ5DCXwgJjPFZTsBzXUn84Z0wlRDFGns02UnA/b/2o89UjXHR0dmw
         srJNylYyO9wn40ldgkMNgQorav014KdrM7eSTjkrL5BXHUtea//2dyqTMLK5v7kKB9
         4i4716PWjNkpFlBVzKdgFvPuJnVIcrjqjstZxCAIxUTBU9DA+HrhCn5X62/Jb2sSKF
         iXs74q3HizFkw==
Date:   Mon, 20 Mar 2023 12:14:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230320171447.GA2293285@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB61017F7AD76AC3E3C296E6D1E2809@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael for RESUME_EARLY quirk question]

On Mon, Mar 20, 2023 at 01:32:16AM +0000, Limonciello, Mario wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Friday, March 10, 2023 16:14
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Natikar, Basavaraj
> > <Basavaraj.Natikar@amd.com>; bhelgaas@google.com; linux-
> > pci@vger.kernel.org; thomas@glanzmann.de
> > Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
> > 
> > On Thu, Mar 09, 2023 at 06:57:38PM -0600, Mario Limonciello wrote:
> > > On 3/9/23 16:30, Bjorn Helgaas wrote:
> > > > On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
> > > > > On 3/9/2023 12:25, Bjorn Helgaas wrote:
> > > > > ...
> > > >
> > > > > > > > https://gitlab.freedesktop.org/agd5f/linux/-
> > /commit/07494a25fc8881e122c242a46b5c53e0e4403139
> > > > > >
> > > > > > That nbio_v7.2.c patch and this patch don't look anything
> > > > > > alike.  It looks like the nbio_v7.2.c patch might run
> > > > > > once?  Could *this* be done once at enumeration-time, too?
> > > > >
> > > > > They don't look anything alike because they're attacking the
> > > > > problem from different angles.
> > > >
> > > > Why do we need different angles?
> > >
> > > The GPU driver approach only works if the GPU is enabled.  If
> > > the GPU could never be disabled then it alone would be
> > > sufficient.
> > >
> > > > > The NBIO patch fixes the initialization value for the
> > > > > internal registers.  This is what the BIOS "should" have
> > > > > done.  When the internal registers are configured properly
> > > > > then the behavior the kernel expects works as well.
> > > > >
> > > > > The NBIO patch will run both at amdgpu startup as well as
> > > > > when resuming from suspend.
> > > >
> > > > If initializing something as BIOS should have done makes the
> > > > hardware work correctly, isn't once enough?  Why does the NBIO
> > > > patch need to run at resume-time?
> > >
> > > During suspend some internal registers are in a power domain
> > > that the state will be lost.  These are typically restored by
> > > the BIOS to the values defined in initialization tables before
> > > handing control back to the OS.
> > 
> > I don't quite get this.  I thought I read that if BIOS had
> > initialized the hardware correctly, a D0->D3hot->D0 transition
> > would work without any issues.  Linux can do this with PMCSR
> > writes and BIOS isn't involved at all.
> 
> During a suspend transition not all registers are powered.  Firmware
> will capture some during the suspend transition and restore some of
> them for the resume transition, but it's up to the firmware whether
> this one is included.
> 
> Furthermore most IP blocks in amdgpu typically initialize the same
> during both startup and resume to ensure that firmware couldn't have
> mucked with the expected golden state.

We're spending way more time on this than makes sense, but I do think
it's important that the commit log is accurate and makes sense even to
people who don't know the internals of the device.

It *sounds* like what's happening is:

  - OS writes PMCSR to put device in D3hot
  - BIOS traps D0->D3hot transition via something like SMI and
    captures MSI-X state
  - Device enters D3hot
  - Device internal MSI-X state is lost
  - BIOS traps D3hot->D0 transition via SMI
  - Device enters D0
  - BIOS restores MSI-X state
  - OS resumes use of device

If that's what's happening, the fact that the device loses the
internal state in D3hot sounds like a *hardware* defect -- if you put
the device in a system without a BIOS, the D0->D3hot->D0 transitions
would not work as required by the PCIe spec.

We can call the fact that BIOS lacks the MSI-X save/restore a BIOS
defect, but the only reason BIOS would *need* that save/restore is
because of the underlying *hardware* defect.

If that's the case, I would expect a commit log something like this:

  The AMD [1022:15b8] USB controller loses some internal functional
  MSI-X context when transitioning from D0 to D3hot.  BIOS normally
  traps D0->D3hot and D3hot->D0 transitions so it can save and restore
  that internal context, but some firmware in the field lacks this
  workaround.

  If MSI-X is enabled, toggle the PCI_MSIX_FLAGS_ENABLE bit when
  resuming to D0, which resynchronizes the internal state that was
  lost in D3hot.

Rafael, do we run the DECLARE_PCI_FIXUP_RESUME_EARLY quirks for *all*
D3hot->D0 transitions?

I'm concerned about places like pci_pm_reset(), where we do
D0->D3hot->D0 to do the reset.  Or vfio_pm_config_write(), where it
looks like a guest could do that without running the quirk.

Current proposed patch is:
https://lore.kernel.org/r/ddbbfb50-24b6-202f-7452-c8959901c739@amd.com

Bjorn
