Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1115489E85
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 18:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiAJRiq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 12:38:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:55909 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238197AbiAJRiq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jan 2022 12:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641836326; x=1673372326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWPZuMth+MIE1cAaW/Lz+OiONq1rD6InuNNGj+Be908=;
  b=ZNLWqGRY9ZBJGpubxGJLPwIzTfEwY6kEuFldI5Xxogv14OQ6oyozfBkU
   mJlVRzeRyfvGy+LFt8mRMCab9qaRtu/WRUvf52UsMEkImcU6syDx7nkQY
   B7Yxv5lWxW9VRXWU9XklDx1pvXKIJkg0Uyv9Ph6/BfpjbQ1dK/UgaXSES
   hZO45pfSmCIesytCFaP+FhsOVKPoVO9x6/558IjL1eqhRwq8e0n9KU8pj
   VQI5gdl7p+3TH54gCoxHBhlFucnVG/n4C4P7qSPV0ZtKdY3WpNMvYR4a4
   3bkzmXTA0RZvcug75UNdPDiY3jKjL4VRE907Sx4H0plnhT9IfNGeyEbSR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="243232697"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243232697"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:37:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="528361329"
Received: from ryanjor-mobl.amr.corp.intel.com (HELO intel.com) ([10.255.36.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:37:09 -0800
Date:   Mon, 10 Jan 2022 12:37:08 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH v3 3/3] x86/quirks: Fix stolen detection with
 integrated + discrete GPU
Message-ID: <YdxuxIx7X8mncC/D@intel.com>
References: <YdxoyHIYssuJjN4w@intel.com>
 <20220110173211.GA61717@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110173211.GA61717@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 10, 2022 at 11:32:11AM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 10, 2022 at 12:11:36PM -0500, Rodrigo Vivi wrote:
> > On Fri, Jan 07, 2022 at 08:57:32PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Jan 07, 2022 at 01:05:16PM -0800, Lucas De Marchi wrote:
> > > > early_pci_scan_bus() does a depth-first traversal, possibly calling
> > > > the quirk functions for each device based on vendor, device and class
> > > > from early_qrk table. intel_graphics_quirks() however uses PCI_ANY_ID
> > > > and does additional filtering in the quirk.
> > > > 
> > > > If there is an Intel integrated + discrete GPU the quirk may be called
> > > > first for the discrete GPU based on the PCI topology. Then we will fail
> > > > to reserve the system stolen memory for the integrated GPU, because we
> > > > will already have marked the quirk as "applied".
> > > > 
> > > > This was reproduced in a setup with Alderlake-P (integrated) + DG2
> > > > (discrete), with the following PCI topology:
> > > > 
> > > > 	- 00:01.0 Bridge
> > > > 	  `- 03:00.0 DG2
> > > > 	- 00:02.0 Integrated GPU
> > > > 
> > > > Move the setting of quirk_applied in intel_graphics_quirks() so it's
> > > > mark as applied only when we find the integrated GPU based on the
> > > > intel_early_ids table.
> > > > 
> > > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > 
> > > I don't know the details of stolen memory, but the implementation of
> > > this quirk looks good to me.  Very nice that it's now very clear
> > > exactly what the change is.
> > 
> > 
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > 
> > Bjorn, ack to merge through drm-intel?
> 
> This is a bit of a shared area between the x86 folks and me, but
> certainly no objection from me.

Lucas brought a good point about patch 1 touching more stuff than i915 one,
so to minimize conflicts maybe the x86 tree would be better...
also works for us if you prefer.

> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > > > ---
> > > > 
> > > > v3: now that we do the refactor before the fix, we can do a single line
> > > > change to fix intel_graphics_quirks(). Also, we don't change
> > > > intel_graphics_stolen() anymore as we did in v2: we don't have to check
> > > > other devices anymore if there was a previous match causing
> > > > intel_graphics_stolen() to be called (there can only be one integrated
> > > > GPU reserving the stolen memory).
> > > > 
> > > >  arch/x86/kernel/early-quirks.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > > > index df34963e23bf..932f9087c324 100644
> > > > --- a/arch/x86/kernel/early-quirks.c
> > > > +++ b/arch/x86/kernel/early-quirks.c
> > > > @@ -609,8 +609,6 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
> > > >  	if (quirk_applied)
> > > >  		return;
> > > >  
> > > > -	quirk_applied = true;
> > > > -
> > > >  	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
> > > >  
> > > >  	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
> > > > @@ -623,6 +621,8 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
> > > >  
> > > >  		intel_graphics_stolen(num, slot, func, early_ops);
> > > >  
> > > > +		quirk_applied = true;
> > > > +
> > > >  		return;
> > > >  	}
> > > >  }
> > > > -- 
> > > > 2.34.1
> > > > 
