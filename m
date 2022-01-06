Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F0486D99
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 00:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbiAFXQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 18:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 18:16:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0865DC061245
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 15:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 682E761E5D
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 23:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD0CC36AE0;
        Thu,  6 Jan 2022 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641511000;
        bh=fL/IKeb9Bvku3zqfQQfv3Jb9ZwXA9TDwB7xOBHb9fC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o6y0kr8lOsgErAjztx+ti1zEkMTKCTII8QpM54lLHXZjxT0bDiM8O72rRkFWBFDJP
         LrsWIfdWd3yMCYYz83c32BBu5vwicmA9Am62RvafJ/17IQ2EFUimPvUzbYry7Oggtj
         ZfOFJPkac7PrKDooLmFcvG+ulq0kzx9R60KtQ2UZS2sDyD2FX/T2eZL+0tgyqHUtNS
         jhdjJN5bzvC7r0Shpwj1wGyuQE7VEC5jgcmAXvIOxnKuc7/QqM8Yi6ckQZuQq9qoWg
         Bjaso7bc+x1oKdnpbsga5xgvl/EW+9CY1Vwm4Q1ctKjAKuRTPi+1bglIO1LnhAW4Nc
         D94D32G2yR8lQ==
Date:   Thu, 6 Jan 2022 17:16:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v2 1/2] x86/quirks: Fix logic to apply quirk once
Message-ID: <20220106231639.GA333775@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106223047.ryhjtrviaosnh7wv@ldmartin-desk2>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 06, 2022 at 02:30:47PM -0800, Lucas De Marchi wrote:
> On Thu, Jan 06, 2022 at 03:58:50PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 05, 2022 at 04:36:53PM -0800, Lucas De Marchi wrote:
> > > When using QFLAG_APPLY_ONCE we make sure the quirk is called only once.
> > > This is useful when it's enough one device to trigger a certain
> > > condition or when the resource in each that applies is global to the
> > > system rather than local to the device.
> > > 
> > > However we call the quirk handler based on vendor, class, and device,
> > > allowing the specific handler to do additional filtering. In that case
> > > check_dev_quirk() may incorrectly mark the quirk as applied when it's
> > > not: the quirk was called, but may not have been applied due to the
> > > additional filter.
> > > 
> > > This is particularly bad for intel_graphics_quirks() that uses
> > > PCI_ANY_ID and then compares with a long list of devices. This hasn't
> > > been problematic so far because those devices are integrated GPUs and
> > > there can only be one in the system.  However as Intel starts to
> > > release discrete cards, this condition is no longer true and we fail to
> > > reserve the stolen memory (for the integrated GPU) depending on the bus
> > > topology: if the traversal finds the discrete card first, for which
> > > there is no system stolen memory, we will fail to reserve it for the
> > > integrated card.
> > > 
> > > This fixes the stolen memory reservation for an Alderlake-P system with
> > > one additional Intel discrete GPU (DG2 in this case, but applies for
> > > any of them). In this system we have:
> > > 
> > > 	- 00:01.0 Bridge
> > > 	  `- 03:00.0 DG2
> > > 	- 00:02.0 Alderlake-P's integrated GPU
> > > 
> > > Since we do a depth-first traversal, when we call the handler because of
> > > DG2 we were marking it as already being applied and never reserving the
> > > stolen memory for Alderlake-P.
> > > 
> > > Since there are just a few quirks using the QFLAG_APPLY_ONCE logic and
> > > that is even the only flag, just use a static local variable in the
> > > quirk function itself. This allows to mark the quirk as applied only
> > > when it really is. As pointed out by Bjorn Helgaas, this is also more in
> > > line with the PCI fixups as done by pci_do_fixups().
> > > 
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > ---
> > > 
> > > v2: instead of changing all quirks to return if it was successfully
> > > applied, remove the flag infra and use a static local variable to mark
> > > quirks already applied (suggested by Bjorn Helgaas).
> > > 
> > >  arch/x86/kernel/early-quirks.c | 60 ++++++++++++++++++++--------------
> > >  1 file changed, 36 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > > index 391a4e2b8604..102ecd0a910e 100644
> > > --- a/arch/x86/kernel/early-quirks.c
> > > +++ b/arch/x86/kernel/early-quirks.c
> > > @@ -57,12 +57,18 @@ static void __init fix_hypertransport_config(int num, int slot, int func)
> > >  static void __init via_bugs(int  num, int slot, int func)
> > >  {
> > >  #ifdef CONFIG_GART_IOMMU
> > > +	static bool quirk_applied __initdata;
> > > +
> > > +	if (quirk_applied)
> > > +		return;
> > 
> > IMO this probably is better than using QFLAG_APPLY_ONCE, etc.
> > 
> > But this patch has the mechanical changes related to QFLAG_APPLY_ONCE,
> > which I think are useful but not very interesting and not a fix for
> > something that's broken, mixed together with the *important* change
> > that actually fixes a problem on Alderlake.
> 
> In general I agree with the statement and also ask people to follow that
> logic, but here I thought it was small enough to be considered as a
> whole.  Here is what I could do to split it up further in a way that is
> not going in a different direction:
> 
> 1) add the static local only to intel graphics quirk  and remove the
> flag from this item
> 2 and 3) add the static local to other functions and remove the flag
> from those items
> 4) remove the flag from the table, the defines and its usage.
> 5) fix the coding style (to be clear, it's already wrong, not
> something wrong introduced here... maybe could be squashed in (4)?)

I would make this two patches:

  1) Add static locals to all QFLAG_APPLY_ONCE quirks and remove
     QFLAG_APPLY_ONCE etc.  This patch is mechanical and shouldn't
     break or fix anything.

  2) Update the intel graphics quirk to change the way it sets the
     static local.  Make the subject be something about fixing the
     problem with Intel integrated + discrete graphics.
