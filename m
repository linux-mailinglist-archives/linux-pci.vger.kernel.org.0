Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2648CFF8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 02:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiAMBGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 20:06:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39770 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiAMBGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 20:06:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE2F61BD9
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 01:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1EFC36AE9;
        Thu, 13 Jan 2022 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642036007;
        bh=mAi7hYRDjTFdqIvG2j8opuszNCwfw5UH++EoHijXB2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZyWY3DZKb1XU9DkalV8R1SJRMe97HBagDaxsX6pHjL0uxe7PED2vqTI2gzqzPQJdy
         Qt3ZMClwlmZeushiumEmA3NEju9F6SsJtP3+84WYnftYq5acwXaI//S6F4cEfUB/es
         ZuKrp6Se3CRszVrhOf9yIvPHF9Ks79VydC4ScRwJxe65yQotx78srPHclcN7pKNOLb
         nQN+S1Fz+lvhw13g9hFv4FzzFL87kPs9YpZz80FXct3/jqzZW2Bh9H54NK8Db5aAdk
         6US5KzwkTVnX54SB1qZ42zA1tw/yXV10W1Qqhu9lbU39u0xTSsoi166cAU4hMxHoYn
         G1s+A54MZt0VQ==
Date:   Wed, 12 Jan 2022 19:06:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH v4] x86/quirks: Replace QFLAG_APPLY_ONCE with
 static locals
Message-ID: <20220113010645.GA301048@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113002128.7wcji4n5rlpchlyt@ldmartin-desk2>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 04:21:28PM -0800, Lucas De Marchi wrote:
> On Wed, Jan 12, 2022 at 06:08:05PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 12, 2022 at 03:30:43PM -0800, Lucas De Marchi wrote:
> > > The flags are only used to mark a quirk to be called once and nothing
> > > else. Also, that logic may not be appropriate if the quirk wants to
> > > do additional filtering and set quirk as applied by itself.
> > > 
> > > So replace the uses of QFLAG_APPLY_ONCE with static local variables in
> > > the few quirks that use this logic and remove all the flags logic.
> > > 
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Only occurred to me now, but another, less intrusive approach would be
> > to just remove QFLAG_APPLY_ONCE from intel_graphics_quirks() and do
> > its bookkeeping internally, e.g.,
> 
> that is actually what I suggested after your comment in v2: this would
> be the first patch with "minimal fix". But then to keep it consistent
> with the other calls to follow up with additional patches on top
> converting them as well.  Maybe what I wrote wasn't clear in the
> direction? Copying it here:
> 
> 	1) add the static local only to intel graphics quirk  and remove the
> 	flag from this item
> 	2 and 3) add the static local to other functions and remove the flag
> 	from those items
> 	4) remove the flag from the table, the defines and its usage.
> 	5) fix the coding style (to be clear, it's already wrong, not
> 	something wrong introduced here... maybe could be squashed in (4)?)

Oh, sorry, I guess I just skimmed over that without really
comprehending it.

Although the patch below is basically just 1 from above and doesn't
require any changes to the other functions or the flags themselves
(2-4 above).

> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > index 391a4e2b8604..7b655004e5fd 100644
> > --- a/arch/x86/kernel/early-quirks.c
> > +++ b/arch/x86/kernel/early-quirks.c
> > @@ -587,10 +587,14 @@ intel_graphics_stolen(int num, int slot, int func,
> > 
> > static void __init intel_graphics_quirks(int num, int slot, int func)
> > {
> > +	static bool stolen __initdata = false;
> > 	const struct intel_early_ops *early_ops;
> > 	u16 device;
> > 	int i;
> > 
> > +	if (stolen)
> > +		return;
> > +
> > 	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
> > 
> > 	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
> > @@ -602,6 +606,7 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
> > 		early_ops = (typeof(early_ops))driver_data;
> > 
> > 		intel_graphics_stolen(num, slot, func, early_ops);
> > +		stolen = true;
> > 
> > 		return;
> > 	}
> > @@ -703,7 +708,7 @@ static struct chipset early_qrk[] __initdata = {
> > 	{ PCI_VENDOR_ID_INTEL, 0x3406, PCI_CLASS_BRIDGE_HOST,
> > 	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
> > 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, PCI_ANY_ID,
> > -	  QFLAG_APPLY_ONCE, intel_graphics_quirks },
> > +	  0, intel_graphics_quirks },
> > 	/*
> > 	 * HPET on the current version of the Baytrail platform has accuracy
> > 	 * problems: it will halt in deep idle state - so we disable it.
