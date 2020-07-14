Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9321ED00
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgGNJf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 05:35:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:13657 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgGNJf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 05:35:58 -0400
IronPort-SDR: 5i1Y2mTegdJJnlaXPGKO8HgWROEkQFunc7Tyjjl/7vGr0P32yglQ6JPuuvu365sdTWLgWtTfKf
 xpLXPQr7HtZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146862954"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="146862954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:35:58 -0700
IronPort-SDR: KyJwSd6fC9MGoOpsyH1PUxj4BZEOMgfk7Z75grKJcV5XviJpyWWph1GJSEirxGhx+fKrqN1dZT
 DMs/+GS7+5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="360332384"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2020 02:35:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jvHLw-001kcZ-I1; Tue, 14 Jul 2020 12:35:56 +0300
Date:   Tue, 14 Jul 2020 12:35:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [NEEDS-REVIEW] [PATCH v1 1/2] x86/PCI: Get rid of custom x86
 model comparison
Message-ID: <20200714093556.GH3703480@smile.fi.intel.com>
References: <20200713194437.11325-1-andriy.shevchenko@linux.intel.com>
 <c59df703-48af-a981-2934-7e4394e04baa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c59df703-48af-a981-2934-7e4394e04baa@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 01:59:55PM -0700, Dave Hansen wrote:
> On 7/13/20 12:44 PM, Andy Shevchenko wrote:
> > -	switch (intel_mid_identify_cpu()) {
> > -	case INTEL_MID_CPU_CHIP_TANGIER:
> > +	id = x86_match_cpu(intel_mid_cpu_ids);
> > +	if (id)
> > +		model = id->model;
> > +
> > +	switch (model) {
> > +	case INTEL_FAM6_ATOM_SILVERMONT_MID:
> >  		polarity = IOAPIC_POL_HIGH;
> 
> The diff makes it _look_ like there's a behavior change, swapping
> silvermont and tangier.  It appears from intel_mid_arch_setup() that
> INTEL_FAM6_ATOM_SILVERMONT_MID and tangier are related:
> 
> #define INTEL_FAM6_ATOM_SILVERMONT_MID  0x4A /* Merriefield */
> 
> ...
>         case 0x3C:
>         case 0x4A:
>                 __intel_mid_cpu_chip = INTEL_MID_CPU_CHIP_TANGIER;
>                 x86_platform.legacy.rtc = 1;
>                 break;

Yes. The original code is too old and was submitted without relying on existing
kernel helpers.

> But that's probably worth a note in the changelog.  If you added a patch
>  to intel_mid_arch_setup() to this series to use the intel-family.h
> #defines, this would be much more self explanatory.

No, I'm not going to do that at all. The idea behind is to get rid of this ugly
customisation.

> This also all makes me wonder if intel_mid_identify_cpu() is really even
> necessary.

Exactly!

> Does this fix any kinds of problems?  It's a diffstat-challenged cleanup
> if not:

>  arch/x86/pci/intel_mid_pci.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> That's not usually how cleanups look. :)

I understand. This will help to do a real clean up in the future.

-- 
With Best Regards,
Andy Shevchenko


