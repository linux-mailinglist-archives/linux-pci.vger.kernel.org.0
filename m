Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA5489E22
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiAJRNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 12:13:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:42399 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238007AbiAJRNU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jan 2022 12:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641834800; x=1673370800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rFpO3idGkMwxHuRUVjKYhHQ355NihZqo1GVyZknlLlY=;
  b=JLgBQB0UT745Bt64RjTbE7bCFTctEftjZ4U+JuB8sfEnPdeEeLDw5Gss
   rFQTzRFAAxkBTI6wmLj4fVgds5JLvW0HU69obJ3chPOexErqG/5wPNBI7
   y/j1ABu0foN+GW3c92eKqkAmWwXFl574wyODXsu3h/2K7dqUgEQlgYBR9
   niThg3Yjubxt8pTnkC/mOORRoSL1o0K6nJr1B7Yo4zJgBWNrSBDYE2gKG
   wRe44mBIT8SW3V5ADn1HMk8YrV8gNpwczL2bNP1YEnmP/P885lnz2sHls
   990MI5Q8KlapHLMK8q+mG9YeIt/iIqcSr2R209ppJSw6YBm3Q2PUGHtCi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223254331"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="223254331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:11:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="528351871"
Received: from ryanjor-mobl.amr.corp.intel.com (HELO intel.com) ([10.255.36.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:11:37 -0800
Date:   Mon, 10 Jan 2022 12:11:36 -0500
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
Message-ID: <YdxoyHIYssuJjN4w@intel.com>
References: <20220107210516.907834-3-lucas.demarchi@intel.com>
 <20220108025732.GA443415@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108025732.GA443415@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 08:57:32PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 07, 2022 at 01:05:16PM -0800, Lucas De Marchi wrote:
> > early_pci_scan_bus() does a depth-first traversal, possibly calling
> > the quirk functions for each device based on vendor, device and class
> > from early_qrk table. intel_graphics_quirks() however uses PCI_ANY_ID
> > and does additional filtering in the quirk.
> > 
> > If there is an Intel integrated + discrete GPU the quirk may be called
> > first for the discrete GPU based on the PCI topology. Then we will fail
> > to reserve the system stolen memory for the integrated GPU, because we
> > will already have marked the quirk as "applied".
> > 
> > This was reproduced in a setup with Alderlake-P (integrated) + DG2
> > (discrete), with the following PCI topology:
> > 
> > 	- 00:01.0 Bridge
> > 	  `- 03:00.0 DG2
> > 	- 00:02.0 Integrated GPU
> > 
> > Move the setting of quirk_applied in intel_graphics_quirks() so it's
> > mark as applied only when we find the integrated GPU based on the
> > intel_early_ids table.
> > 
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> I don't know the details of stolen memory, but the implementation of
> this quirk looks good to me.  Very nice that it's now very clear
> exactly what the change is.


Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Bjorn, ack to merge through drm-intel?


> 
> > ---
> > 
> > v3: now that we do the refactor before the fix, we can do a single line
> > change to fix intel_graphics_quirks(). Also, we don't change
> > intel_graphics_stolen() anymore as we did in v2: we don't have to check
> > other devices anymore if there was a previous match causing
> > intel_graphics_stolen() to be called (there can only be one integrated
> > GPU reserving the stolen memory).
> > 
> >  arch/x86/kernel/early-quirks.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > index df34963e23bf..932f9087c324 100644
> > --- a/arch/x86/kernel/early-quirks.c
> > +++ b/arch/x86/kernel/early-quirks.c
> > @@ -609,8 +609,6 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
> >  	if (quirk_applied)
> >  		return;
> >  
> > -	quirk_applied = true;
> > -
> >  	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
> > @@ -623,6 +621,8 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
> >  
> >  		intel_graphics_stolen(num, slot, func, early_ops);
> >  
> > +		quirk_applied = true;
> > +
> >  		return;
> >  	}
> >  }
> > -- 
> > 2.34.1
> > 
