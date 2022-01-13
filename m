Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4E48CFA0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 01:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiAMAVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 19:21:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:10197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbiAMAVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 19:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642033291; x=1673569291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DwqNpg9uX+1ZuFEltZ/81ZLkibhRO944rgse5OaU4dg=;
  b=PCombgG+fG7RSdXC31oFvN1w7qgmrhXYXG1a6v047K+O8sLksz4U3rrW
   wyyhNrfdrMBOGsMmTJqbzfuPIIkTBmkpj9GRCC/edGdJJVHSS/2558YWA
   nkFTqgtSyIwHE97tBaisgaEWmxwng5Ey/f1BcOVYSQdjOE9b+P/LQ3RB5
   wl0375cSbDQtdoBnjsi0nKZYf1uqC8uUrIG3dhyR4nDbR0w866ORI0Ug1
   JvDY+/1/jtxPR3/JhfHWHxaO9ERB7tQXSVAxmaxMlQXb/b0Nf0kEaF6JJ
   Xo6k79AHBNLmloaroh/SMYmZB38PAqIlNRp4J4U0cPwquDgypTBwgR7m0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="304621356"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="304621356"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 16:21:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="613766459"
Received: from jsinnott-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.139.158])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 16:21:29 -0800
Date:   Wed, 12 Jan 2022 16:21:28 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH v4] x86/quirks: Replace QFLAG_APPLY_ONCE with
 static locals
Message-ID: <20220113002128.7wcji4n5rlpchlyt@ldmartin-desk2>
References: <20220112233043.1865454-1-lucas.demarchi@intel.com>
 <20220113000805.GA295089@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220113000805.GA295089@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 06:08:05PM -0600, Bjorn Helgaas wrote:
>On Wed, Jan 12, 2022 at 03:30:43PM -0800, Lucas De Marchi wrote:
>> The flags are only used to mark a quirk to be called once and nothing
>> else. Also, that logic may not be appropriate if the quirk wants to
>> do additional filtering and set quirk as applied by itself.
>>
>> So replace the uses of QFLAG_APPLY_ONCE with static local variables in
>> the few quirks that use this logic and remove all the flags logic.
>>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
>Only occurred to me now, but another, less intrusive approach would be
>to just remove QFLAG_APPLY_ONCE from intel_graphics_quirks() and do
>its bookkeeping internally, e.g.,

that is actually what I suggested after your comment in v2: this would
be the first patch with "minimal fix". But then to keep it consistent
with the other calls to follow up with additional patches on top
converting them as well.  Maybe what I wrote wasn't clear in the
direction? Copying it here:

	1) add the static local only to intel graphics quirk  and remove the
	flag from this item
	2 and 3) add the static local to other functions and remove the flag
	from those items
	4) remove the flag from the table, the defines and its usage.
	5) fix the coding style (to be clear, it's already wrong, not
	something wrong introduced here... maybe could be squashed in (4)?)

Lucas De Marchi

>
>diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
>index 391a4e2b8604..7b655004e5fd 100644
>--- a/arch/x86/kernel/early-quirks.c
>+++ b/arch/x86/kernel/early-quirks.c
>@@ -587,10 +587,14 @@ intel_graphics_stolen(int num, int slot, int func,
>
> static void __init intel_graphics_quirks(int num, int slot, int func)
> {
>+	static bool stolen __initdata = false;
> 	const struct intel_early_ops *early_ops;
> 	u16 device;
> 	int i;
>
>+	if (stolen)
>+		return;
>+
> 	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
>
> 	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
>@@ -602,6 +606,7 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
> 		early_ops = (typeof(early_ops))driver_data;
>
> 		intel_graphics_stolen(num, slot, func, early_ops);
>+		stolen = true;
>
> 		return;
> 	}
>@@ -703,7 +708,7 @@ static struct chipset early_qrk[] __initdata = {
> 	{ PCI_VENDOR_ID_INTEL, 0x3406, PCI_CLASS_BRIDGE_HOST,
> 	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
> 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, PCI_ANY_ID,
>-	  QFLAG_APPLY_ONCE, intel_graphics_quirks },
>+	  0, intel_graphics_quirks },
> 	/*
> 	 * HPET on the current version of the Baytrail platform has accuracy
> 	 * problems: it will halt in deep idle state - so we disable it.
