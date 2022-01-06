Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAD486D58
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 23:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiAFWpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 17:45:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:22026 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245167AbiAFWps (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 17:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641509148; x=1673045148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2yKiysNW48zWRq0SqZnWVCLvA8i0IgkDGR/I+OUaIsk=;
  b=T5nhqUvAMH7l/zOKzc2a8INOep/rIeuKTA7ufpEU+pht+p5Rn48px8n3
   f/mc3x0sRCQ4YRpI/kyVh7r8VMXrtFP3XFIAVgntXxe69R0ExBTksMBdh
   JM+V0Sq9qeVC5AIeHOU/FYNAs5nr0FCgyi9UHcF5u3XfY+OxKp2g7/i8d
   4F9Q2W0iCH+kErkMKV5pOrjxTz0u6FHO++pSgzltS+UxdggDjJrkSGsRM
   p/iboHoQoAtxLDISezLLozjO190ia6yH0uh+QBArIKHifqHK8mt+d3Vse
   wOiptFNEbHBshJqyW7bsGyIe2wD63Dc981pnRU8XxfyqkoQIIq/a+Wn+9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329098097"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="329098097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:45:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="513566624"
Received: from sumedhrr-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.102.95])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:45:46 -0800
Date:   Thu, 6 Jan 2022 14:45:45 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v2 2/2] x86/quirks: better wrap quirk conditions
Message-ID: <20220106224545.hfrxehkztm5eht7s@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220106003654.770316-2-lucas.demarchi@intel.com>
 <20220106222325.GA329826@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220106222325.GA329826@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 06, 2022 at 04:23:25PM -0600, Bjorn Helgaas wrote:
>On Wed, Jan 05, 2022 at 04:36:54PM -0800, Lucas De Marchi wrote:
>> Remove extra parenthesis and wrap lines so it's easier to read what are
>> the conditions being checked. The call to the hook also had an extra
>> indentation: remove here to conform to coding style.
>
>It's nice when your subject lines are consistent.  These look like:
>
>  x86/quirks: Fix logic to apply quirk once
>  x86/quirks: better wrap quirk conditions
>
>The second isn't capitalized like the first.  Obviously if you split

trying to maintain the entropy from

	git log --oneline --no-merges -- arch/x86/kernel/early-quirks.c

:). Jokes aside, yeah, my bad.

>the first patch, you'll have three subject lines, and one will mention
>Alderlake.

See my reply to the first patch - Alderlake is only the reproducer, but
it's broken in other platforms as well, as long as it's paired with an
Intel discrete gpu in the "right" pci slot.

It would be weird to send a patch "Fix xyz in Alderlake" and then
telling people with the same problem in Icelake that they are
missing that fix. So I went with the approach: 1) what is the generic
problem; 2) where it was initially reproduced.

thanks
Lucas De Marchi

>
>Bjorn
