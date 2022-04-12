Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE84FDFD8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiDLMaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353443AbiDLM2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 08:28:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA15B267;
        Tue, 12 Apr 2022 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649763495; x=1681299495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m72jmhgC7YfsqgqgAoeS8Cl15fMwSujr/+aPK65oKdA=;
  b=gKZJI3sKvlkv8dHzMjaH12CysDbctMcZ/5semIIrcJ/5T48k42Se4f9l
   gFu1ALfRNEFzQIxa0sqCI8ZIwDa7XybGiWOY4z0O6GKgsROJJo4L2mvl6
   MfBIAywEBhCvBMcjFu2IOIUO1iZaMTahuYOhHgnFfDTKbhjZcTonvmN6l
   bU5lmsxtWt1i+AwUeukJENMP/Pl4m9JTo3Bh8ysWVziTYuxBhE/z8kEGl
   GeueLADaQOqhPIh2HOhgXGgol7RrCDQ5cIOlQL1NPVCQZ5PX+TGt8tyMV
   zLOZOGLgrSOjxYsIsPOez/LL84tE3Cx8BUfHewjL6CMQovPa95iYozNUx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="287371255"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="287371255"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:38:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="526006766"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:38:12 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Apr 2022 14:38:10 +0300
Date:   Tue, 12 Apr 2022 14:38:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 4/9] PCI/PM: Rework changing power states of PCI
 devices
Message-ID: <YlVkojhMtirzzlFy@lahna>
References: <4419002.LvFx2qVVIh@kreacher>
 <11975904.O9o76ZdvQC@kreacher>
 <13011315.uLZWGnKmhe@kreacher>
 <YlVNzZRHW58QRD3c@lahna>
 <CAJZ5v0iKnzHZnx-96CBaeMvz29ezoCBH=F60gM7uAkoBazUzFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iKnzHZnx-96CBaeMvz29ezoCBH=F60gM7uAkoBazUzFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 01:31:57PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 12, 2022 at 1:17 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Apr 11, 2022 at 04:25:12PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There are some issues related to changing power states of PCI
> > > devices, mostly related to carrying out unnecessary actions in some
> > > places, and the code is generally hard to follow.
> > >
> > >  1. pci_power_up() has two callers, pci_set_power_state() and
> > >     pci_pm_default_resume_early().  The latter updates the current
> > >     power state of the device right after calling pci_power_up()
> > >     and it restores the entire config space of the device right
> > >     after that, so pci_power_up() itself need not read the
> > >     PCI_PM_CTRL register or restore the BARs after programming the
> > >     device into D0 in that case.
> > >
> > >  2. It is generally hard to get a clear view of the pci_power_up()
> > >     code flow, especially in some corner cases, due to all of the
> > >     involved PCI_PM_CTRL register reads and writes occurring in
> > >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> > >     some of which are redundant.
> > >
> > >  3. The transitions from low-power states to D0 and the other way
> > >     around are unnecessarily tangled in pci_raw_set_power_state()
> > >     which causes it to use a redundant local variable and makes it
> > >     rather hard to follow.
> > >
> > > To address the above shortcomings, make the following changes:
> > >
> > >  a. Remove the code handling transitions into D0
> >
> > Should this be D3?
> 
> No.  Transitions into D0 will be handled by pci_power_up() directly,
> so they need not be handled by pci_raw_set_power_state().

OK.

> > >     from pci_raw_set_power_state() and rename it as
> > >     pci_set_low_power_state().
> > >
> > >  b. Add the code handling transitions into D0 directly
> > >     to pci_power_up() and to a new wrapper function
> > >     pci_set_full_power_state() calling it internally that is
> > >     only used in pci_set_power_state().
> > >
> > >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> > >     and make it work in the same way for transitions from any
> > >     low-power states (transitions from D1 and D2 are handled
> > >     slightly differently before the change).
> > >
> > >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> > >     register read confirming the power state change into
> > >     pci_set_full_power_state() to avoid doing that in
> > >     pci_pm_default_resume_early() unnecessarily.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2:
> > >    * Do not add a redundant check to pci_set_low_power_state().
> > >
> > > ---
> > >  drivers/pci/pci.c |  154 +++++++++++++++++++++++++++++++++++-------------------
> > >  1 file changed, 101 insertions(+), 53 deletions(-)
> > >
> > > Index: linux-pm/drivers/pci/pci.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/pci/pci.c
> > > +++ linux-pm/drivers/pci/pci.c
> > > @@ -1068,10 +1068,9 @@ static inline bool platform_pci_bridge_d
> > >  }
> > >
> > >  /**
> > > - * pci_raw_set_power_state - Use PCI PM registers to set the power state of
> > > - *                        given PCI device
> > > + * pci_set_low_power_state - Program the given device into a low-power state
> > >   * @dev: PCI device to handle.
> > > - * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
> > > + * @state: PCI power state (D1, D2, D3hot) to put the device into.
> > >   *
> > >   * RETURN VALUE:
> > >   * -EINVAL if the requested state is invalid.
> > > @@ -1080,10 +1079,9 @@ static inline bool platform_pci_bridge_d
> > >   * 0 if device already is in the requested state.
> > >   * 0 if device's power state has been successfully changed.
> > >   */
> > > -static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> > > +static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
> > >  {
> > >       u16 pmcsr;
> > > -     bool need_restore = false;
> > >
> > >       /* Check if we're already there */
> > >       if (dev->current_state == state)
> > > @@ -1092,7 +1090,7 @@ static int pci_raw_set_power_state(struc
> > >       if (!dev->pm_cap)
> > >               return -EIO;
> > >
> > > -     if (state < PCI_D0 || state > PCI_D3hot)
> > > +     if (state < PCI_D1 || state > PCI_D3hot)
> > >               return -EINVAL;
> > >
> > >       /*
> > > @@ -1101,8 +1099,7 @@ static int pci_raw_set_power_state(struc
> > >        * we can go from D1 to D3, but we can't go directly from D3 to D1;
> > >        * we'd have to go from D3 to D0, then to D1.
> > >        */
> > > -     if (state != PCI_D0 && dev->current_state <= PCI_D3cold
> > > -         && dev->current_state > state) {
> > > +     if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
> > >               pci_err(dev, "invalid power transition (from %s to %s)\n",
> > >                       pci_power_name(dev->current_state),
> > >                       pci_power_name(state));
> > > @@ -1122,29 +1119,8 @@ static int pci_raw_set_power_state(struc
> > >               return -EIO;
> > >       }
> > >
> > > -     /*
> > > -      * If we're (effectively) in D3, force entire word to 0.
> > > -      * This doesn't affect PME_Status, disables PME_En, and
> > > -      * sets PowerState to 0.
> > > -      */
> > > -     switch (dev->current_state) {
> > > -     case PCI_D0:
> > > -     case PCI_D1:
> > > -     case PCI_D2:
> > > -             pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> > > -             pmcsr |= state;
> > > -             break;
> > > -     case PCI_D3hot:
> > > -     case PCI_D3cold:
> > > -     case PCI_UNKNOWN: /* Boot-up */
> > > -             if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
> > > -              && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > > -                     need_restore = true;
> > > -             fallthrough;    /* force to D0 */
> > > -     default:
> > > -             pmcsr = 0;
> > > -             break;
> > > -     }
> > > +     pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> > > +     pmcsr |= state;
> > >
> > >       /* Enter specified state */
> > >       pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> > > @@ -1153,9 +1129,9 @@ static int pci_raw_set_power_state(struc
> > >        * Mandatory power management transition delays; see PCI PM 1.1
> > >        * 5.6.1 table 18
> > >        */
> > > -     if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> > > +     if (state == PCI_D3hot)
> > >               pci_dev_d3_sleep(dev);
> > > -     else if (state == PCI_D2 || dev->current_state == PCI_D2)
> > > +     else if (state == PCI_D2)
> > >               udelay(PCI_PM_D2_DELAY);
> > >
> > >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > @@ -1165,22 +1141,6 @@ static int pci_raw_set_power_state(struc
> > >                        pci_power_name(dev->current_state),
> > >                        pci_power_name(state));
> > >
> > > -     /*
> > > -      * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> > > -      * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
> > > -      * from D3hot to D0 _may_ perform an internal reset, thereby
> > > -      * going to "D0 Uninitialized" rather than "D0 Initialized".
> > > -      * For example, at least some versions of the 3c905B and the
> > > -      * 3c556B exhibit this behaviour.
> > > -      *
> > > -      * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
> > > -      * devices in a D3hot state at boot.  Consequently, we need to
> > > -      * restore at least the BARs so that the device will be
> > > -      * accessible to its driver.
> > > -      */
> > > -     if (need_restore)
> > > -             pci_restore_bars(dev);
> > > -
> > >       if (dev->bus->self)
> > >               pcie_aspm_pm_state_change(dev->bus->self);
> > >
> > > @@ -1312,8 +1272,54 @@ static int pci_dev_wait(struct pci_dev *
> > >   */
> > >  int pci_power_up(struct pci_dev *dev)
> > >  {
> > > -     pci_platform_power_transition(dev, PCI_D0);
> > > -     return pci_raw_set_power_state(dev, PCI_D0);
> > > +     int ret;
> > > +
> > > +     ret = pci_platform_power_transition(dev, PCI_D0);
> > > +     if (ret) {
> >
> > Here pci_platform_power_transition() returned an error so we go and read
> > back the PM_CTRL to check in which power state the device is in? Perhaps
> > add a comment here explaining why we need to do this?
> 
> That's the comment below, but I gather it is insufficient as is.
> Please let me know if rephrasing it this way would help:
> 
> "Since pci_platform_power_transition() has returned an error, the
> PCI_PM_CTRL register has not been read by it and the current power
> state of the device is unknown. Read the PCI_PM_CTRL register now and
> bail out if that fails."

Yes, that's better, thanks!

> And I've just realized that pm_cap should be checked here, because it
> is not guaranteed to be set.

Good point.
