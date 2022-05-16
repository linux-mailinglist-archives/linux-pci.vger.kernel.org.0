Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B975290C6
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 22:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiEPUXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348697AbiEPUXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:23:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685BC4A3FC;
        Mon, 16 May 2022 13:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3368B8160D;
        Mon, 16 May 2022 20:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2867BC385AA;
        Mon, 16 May 2022 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652731770;
        bh=rwcIwbCFI9xFVXLkfNAUFzT4VPxeJBT8+qB230SdKEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ftezJRbo0/tVNeSMt26nRCFDfOr225FNJlvyfi62lETLGfr27HJiM4UihlothMNG9
         J72kkE9AtK6vjv0H5wvW+tUmzM/x9GVkmz81geXmMxQaV7txEzmslbv2TSOrcBCyuM
         AvXqTdJfXxRRubydx0AkTHYhDQmmgN0J4vPqYMXyMrJFevl1M2gtRWpXXnl94epDEd
         uLUuEjvfHJxT//N32djBasDQy5EwADpJSzNmmrPlW7tcwJngHMyC5B0saAFxpjYXli
         7ZDaBGdLUuiYIkqXD6mHZx5c2BUgZngemO5RCLzrZneYFCzP7m9Brg2Lvh1sqNan2Z
         Yk9aZIAkJd/kg==
Date:   Mon, 16 May 2022 15:09:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Jingar, Rajvi" <rajvi.jingar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Message-ID: <20220516200927.GA1046452@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5070B095B8A28634B43A231F9ECA9@SJ0PR11MB5070.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 10:00:48PM +0000, Jingar, Rajvi wrote:
> 
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, May 12, 2022 11:36 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>; David Box
> > <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>; Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> > pm@vger.kernel.org>
> > Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
> > 
> > On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> > 
> > > > > Something like this should suffice IMV:
> > > > >
> > > > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > > > >
> > > > >         pci_disable_ptm(pci_dev);
> > > >
> > > > It makes sense to me that we needn't disable PTM if the device is in
> > > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > > driver did.  Why is that important?  Why should we not do the
> > > > following?
> > > >
> > > >   if (pci_dev->current_state != PCI_D3cold)
> > > >     pci_disable_ptm(pci_dev);
> > >
> > > We can do this too.  I thought we could skip the power state
> > > check if dev_state_saved was unset, because then we would know
> > > that the power state was not D3cold.  It probably isn't worth
> > > the hassle though.
> 
> We see issue with certain platforms where only checking if device
> power state in D3Cold is not enough and the !dev_state_saved check
> is needed when disabling PTM. Device like nvme is relying on ASPM,
> it stays in D0 but state is saved. Touching the config space wakes
> up the device which prevents the system from entering into low power
> state.

Correct me if I'm wrong: for NVMe devices, nvme_suspend() has already
saved state and put the device in some low-power state.  Disabling PTM
here is functionally OK but prevents a system low power state, so you
want to leave PTM enabled.

But I must be missing something because pci_prepare_to_sleep()
currently disables PTM for Root Ports.  If we leave PTM enabled on
NVMe but disable it on the Root Port above it, any PTM Request from
NVMe will cause an Unsupported Request error.

Disabling PTM must be coordinated across PTM Requesters and PTM
Responders.  That means the decision to disable cannot depend on
driver-specific things like whether the driver has saved state.

> Following would fix the issue:
> 
>  if (!pci_dev->state_save) {
>                 pci_save_state(pci_dev);
> 
>                pci_disable_ptm(pci_dev);
> 
>                 if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>                         pci_prepare_to_sleep(pci_dev);
> }
> 
> > Ah, thanks.  IMHO it's easier to analyze for correctness if we only
> > check the power state.
> > 
> > Bjorn
