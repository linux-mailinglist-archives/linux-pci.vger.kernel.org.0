Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17423486CFE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 22:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiAFV6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 16:58:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56426 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbiAFV6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 16:58:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B41BEB8244A
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 21:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E666C36AE3;
        Thu,  6 Jan 2022 21:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641506332;
        bh=egpD9QpstysMY9DCDYSSX5jsiVwTFFTgE06o3vSK7E4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CoenwZe4VIdpUgZd/heHfD9gBPrrmAY+UCbFLgfmZVSxA0j4i/T1bgITBg6Ne8/Dc
         r7J7Njf+IsPy0ouHMJSxTQXVa2udkPn6XvdsdB8TKUQHWIxxAgpR4phlTKkrImgL2X
         x+75UuTuvVd/8zdnMkrTV5t02pk0Oc7vAC7rUNIndPPpjvdtwcmT2JPVFeD4zHkUoV
         Lb8/rkHp/8hMfTgiRrPzdd/r46POzFfg/k6/agMk8edRfCoADaQeS0izQWSDy+tKh7
         Sf7cpaEuOpfletlDzUWfGt6Ac/Ee3PdwiA6C7lVy+NKEJuHx+yy0NRiyV0gAScSHQ+
         YmynW+xpqb+Pw==
Date:   Thu, 6 Jan 2022 15:58:50 -0600
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
Message-ID: <20220106215850.GA327560@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106003654.770316-1-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 05, 2022 at 04:36:53PM -0800, Lucas De Marchi wrote:
> When using QFLAG_APPLY_ONCE we make sure the quirk is called only once.
> This is useful when it's enough one device to trigger a certain
> condition or when the resource in each that applies is global to the
> system rather than local to the device.
> 
> However we call the quirk handler based on vendor, class, and device,
> allowing the specific handler to do additional filtering. In that case
> check_dev_quirk() may incorrectly mark the quirk as applied when it's
> not: the quirk was called, but may not have been applied due to the
> additional filter.
> 
> This is particularly bad for intel_graphics_quirks() that uses
> PCI_ANY_ID and then compares with a long list of devices. This hasn't
> been problematic so far because those devices are integrated GPUs and
> there can only be one in the system.  However as Intel starts to
> release discrete cards, this condition is no longer true and we fail to
> reserve the stolen memory (for the integrated GPU) depending on the bus
> topology: if the traversal finds the discrete card first, for which
> there is no system stolen memory, we will fail to reserve it for the
> integrated card.
> 
> This fixes the stolen memory reservation for an Alderlake-P system with
> one additional Intel discrete GPU (DG2 in this case, but applies for
> any of them). In this system we have:
> 
> 	- 00:01.0 Bridge
> 	  `- 03:00.0 DG2
> 	- 00:02.0 Alderlake-P's integrated GPU
> 
> Since we do a depth-first traversal, when we call the handler because of
> DG2 we were marking it as already being applied and never reserving the
> stolen memory for Alderlake-P.
> 
> Since there are just a few quirks using the QFLAG_APPLY_ONCE logic and
> that is even the only flag, just use a static local variable in the
> quirk function itself. This allows to mark the quirk as applied only
> when it really is. As pointed out by Bjorn Helgaas, this is also more in
> line with the PCI fixups as done by pci_do_fixups().
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
> 
> v2: instead of changing all quirks to return if it was successfully
> applied, remove the flag infra and use a static local variable to mark
> quirks already applied (suggested by Bjorn Helgaas).
> 
>  arch/x86/kernel/early-quirks.c | 60 ++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 391a4e2b8604..102ecd0a910e 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -57,12 +57,18 @@ static void __init fix_hypertransport_config(int num, int slot, int func)
>  static void __init via_bugs(int  num, int slot, int func)
>  {
>  #ifdef CONFIG_GART_IOMMU
> +	static bool quirk_applied __initdata;
> +
> +	if (quirk_applied)
> +		return;

IMO this probably is better than using QFLAG_APPLY_ONCE, etc.

But this patch has the mechanical changes related to QFLAG_APPLY_ONCE,
which I think are useful but not very interesting and not a fix for
something that's broken, mixed together with the *important* change
that actually fixes a problem on Alderlake.

Those two things need to be separate patches.  A patch that fixes a
problem should be as small as possible so it's easy to understand and
backport.

The subject line of this patch doesn't say anything at all about
Alderlake.  Splitting into two patches will make the subject lines
more useful.

Bjorn
