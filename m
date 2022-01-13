Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67B148D01F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 02:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiAMB2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 20:28:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:57880 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbiAMB2j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 20:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642037319; x=1673573319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GQhvpc9h2q+oWT0Bwc9I8ajOa4+I4trncxc6miRVHI=;
  b=LEWGEU418sRdd1tHEfAAc37NyvfxK9/j0EwFKiUnsuGOw6P6EiAyDEgz
   Vc7mJKQ7JodDOYwVYPBAdeFOXrVZGVu3B4sTPFWmfj6uFu/I/ERES3isZ
   pBrr+WGYyjNrbwz+AgMVgeo9QUfi44tWlvo4ir4/K1jhZjZyGWvbfhjSY
   C/QdRheSuYb7oXy8cist1EMGXR2DVZMtEGAVKawHQ7y1Fyo5Cu3fRyE1m
   nnBO44N2o/2sIF3L4jZxFDS+lyNjPqAo9LKGJZSIX+VEIFwI2vFhRCpTL
   w6LzJrV17GGYhENM5FHfeOl2lyAF5/5SY4XD0BT5c04q+GNNfEkVDqurN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244106300"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="244106300"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:28:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="765397423"
Received: from jsinnott-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.139.158])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:28:29 -0800
Date:   Wed, 12 Jan 2022 17:28:29 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH v4] x86/quirks: Replace QFLAG_APPLY_ONCE with
 static locals
Message-ID: <20220113012829.pquif5ujboyohzld@ldmartin-desk2>
References: <20220113002128.7wcji4n5rlpchlyt@ldmartin-desk2>
 <20220113010645.GA301048@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220113010645.GA301048@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 07:06:45PM -0600, Bjorn Helgaas wrote:
>On Wed, Jan 12, 2022 at 04:21:28PM -0800, Lucas De Marchi wrote:
>> On Wed, Jan 12, 2022 at 06:08:05PM -0600, Bjorn Helgaas wrote:
>> > On Wed, Jan 12, 2022 at 03:30:43PM -0800, Lucas De Marchi wrote:
>> > > The flags are only used to mark a quirk to be called once and nothing
>> > > else. Also, that logic may not be appropriate if the quirk wants to
>> > > do additional filtering and set quirk as applied by itself.
>> > >
>> > > So replace the uses of QFLAG_APPLY_ONCE with static local variables in
>> > > the few quirks that use this logic and remove all the flags logic.
>> > >
>> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> > > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>> >
>> > Only occurred to me now, but another, less intrusive approach would be
>> > to just remove QFLAG_APPLY_ONCE from intel_graphics_quirks() and do
>> > its bookkeeping internally, e.g.,
>>
>> that is actually what I suggested after your comment in v2: this would
>> be the first patch with "minimal fix". But then to keep it consistent
>> with the other calls to follow up with additional patches on top
>> converting them as well.  Maybe what I wrote wasn't clear in the
>> direction? Copying it here:
>>
>> 	1) add the static local only to intel graphics quirk  and remove the
>> 	flag from this item
>> 	2 and 3) add the static local to other functions and remove the flag
>> 	from those items
>> 	4) remove the flag from the table, the defines and its usage.
>> 	5) fix the coding style (to be clear, it's already wrong, not
>> 	something wrong introduced here... maybe could be squashed in (4)?)
>
>Oh, sorry, I guess I just skimmed over that without really
>comprehending it.
>
>Although the patch below is basically just 1 from above and doesn't
>require any changes to the other functions or the flags themselves
>(2-4 above).

Yes, but I would do the rest of the conversion anyway. It would be odd
to be inconsistent with just a few functions. So in the end I think we
would achieve the same goal.

I would really prefer this approach, having the bug fix first, if I was
concerned about having to backport this to linux-stable beyond 5.10.y
(we have a trivial conflict on 5.10).

However given this situation is new (Intel GPU + Intel Discrete GPU)
rare (it also needs a PCI topology in a certain way to reproduce it),
I'm not too concerned. Not even sure if it's worth submitting to
linux-stable.

I'll wait others to chime in on one way vs the other.

thanks
Lucas De Marchi
