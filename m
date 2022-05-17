Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A634C52A531
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbiEQOsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348400AbiEQOsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 10:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610724CD5C;
        Tue, 17 May 2022 07:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF81861665;
        Tue, 17 May 2022 14:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A079C34113;
        Tue, 17 May 2022 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652798928;
        bh=WH1XjOHZMUkBmVozWE2TGSdngqxpzYYtwhgMhjYHD08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sBlX4WLiZkn8cbvAIXQxMV8M+hCKD+y4Sidi3Smw476AHGWW0eKMxhHwJclFRXYVR
         qAfMWePypc2OXfkXONjn0EQvSl8mp2wdPvqkqyTALRXgcyvR3YWZmE/j2sSEEX47cp
         4O1n0Acl53n0c3FBia0WLP2q005RI4s4Wibyyq5c3DWZM2U0fONBbC4mzv40fDEM/1
         a68UHUcWv708WOw9ZpKJPvApfixFjFvmalX8ewv0/vPIchdZA5Yv4A+myzsa0y3iTe
         9Mhstqptv8d0RQenbofqWpm3e8w9snKA1p0PlApfT3NYS9XzprGhWb6E84PqICS/kN
         I6myESnqnwOPg==
Date:   Tue, 17 May 2022 09:48:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Message-ID: <20220517144846.GA1068039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g6GdKfN4b5uwHEhh4hBuG=haVHaXc-XuMQLe8Wd41Y3g@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 10:59:32PM +0200, Rafael J. Wysocki wrote:
> On Mon, May 16, 2022 at 10:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, May 13, 2022 at 10:00:48PM +0000, Jingar, Rajvi wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: Thursday, May 12, 2022 11:36 AM
> > > > To: Rafael J. Wysocki <rafael@kernel.org>
> > > > Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> > > > <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>; David Box
> > > > <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>; Linux
> > > > Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> > > > pm@vger.kernel.org>
> > > > Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
> > > >
> > > > On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > > > > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> > > >
> > > > > > > Something like this should suffice IMV:
> > > > > > >
> > > > > > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > > > > > >
> > > > > > >         pci_disable_ptm(pci_dev);
> > > > > >
> > > > > > It makes sense to me that we needn't disable PTM if the device is in
> > > > > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > > > > driver did.  Why is that important?  Why should we not do the
> > > > > > following?
> > > > > >
> > > > > >   if (pci_dev->current_state != PCI_D3cold)
> > > > > >     pci_disable_ptm(pci_dev);
> > > > >
> > > > > We can do this too.  I thought we could skip the power state
> > > > > check if dev_state_saved was unset, because then we would know
> > > > > that the power state was not D3cold.  It probably isn't worth
> > > > > the hassle though.
> > >
> > > We see issue with certain platforms where only checking if device
> > > power state in D3Cold is not enough and the !dev_state_saved check
> > > is needed when disabling PTM. Device like nvme is relying on ASPM,
> > > it stays in D0 but state is saved. Touching the config space wakes
> > > up the device which prevents the system from entering into low power
> > > state.
> >
> > Correct me if I'm wrong: for NVMe devices, nvme_suspend() has already
> > saved state and put the device in some low-power state.  Disabling PTM
> > here is functionally OK but prevents a system low power state, so you
> > want to leave PTM enabled.
> >
> > But I must be missing something because pci_prepare_to_sleep()
> > currently disables PTM for Root Ports.  If we leave PTM enabled on
> > NVMe but disable it on the Root Port above it, any PTM Request from
> > NVMe will cause an Unsupported Request error.
> >
> > Disabling PTM must be coordinated across PTM Requesters and PTM
> > Responders.  That means the decision to disable cannot depend on
> > driver-specific things like whether the driver has saved state.
> 
> Setting state_saved generally informs pci_pm_suspend_noirq() that the
> device has already been handled and it doesn't need to do anything to
> it.
> 
> But you are right that PTM should be disabled on downstream devices as
> well as on the ports that those devices are connected to and it can be
> done even if the given device has already been handled, so the
> state_saved value is technically irrelevant.
> 
> That's why I suggested to check if the power state is between D0 and
> D3cold (exclusive) and only disable PTM if that is the case.  It is
> pointless to disable PTM for devices in D3cold and it may be harmful
> for devices that are left in D0.

"... it may be harmful for devices that are left in D0" -- I want to
understand this better.  It sounds like nvme_suspend() leaves the
device in some device-specific low-power flavor of D0, and subsequent
config accesses take it out of that low-power situation?  

If that's the case, it sounds a little brittle.  I don't think it's
obvious that "pci_dev->state_saved was set by the driver" means "no
config accesses allowed in pci_pm_suspend_noirq()."  And
pci_pm_suspend_noirq() calls quirks via pci_fixup_device(), which are
very likely to do config accesses.

Maybe PTM needs to be disabled earlier, e.g., in pci_pm_suspend()?  I
don't think PTM uses any interrupts, so there's probably no reason
interrupts need to be disabled before disabling PTM.
