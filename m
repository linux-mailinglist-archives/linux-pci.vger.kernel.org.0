Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2247CDEA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 09:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbhLVISD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 03:18:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:26708 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243218AbhLVISD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Dec 2021 03:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640161083; x=1671697083;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AygL7u1GpKW2WxRHEvl1gzra+DcWNKVSIRQhZbWNXZI=;
  b=SDIdUUK3YjUYSU+3zZ2ts9RjvbA8SltmNCJKnP3AHpaAtIqN27OJV/Jp
   +FS+629W4k2+PM4oPPAeqJIpPT12ylcC9t7k7mdL/a0R3bZUSSR5jnofF
   FkD2cZXlYLV7EC/K1LUBi25WG5qnPc4J7TpjZWIm8FpUV7lCckkbVPr0M
   dOt/wrTkku+qh9qmzLWY/svO6G4fAKquIPfnQcSQ+jn6AzbZCC5jEzzkV
   WeNcVBe8Uj1sSHV4/dikSthaDDKSo8Ib8ZadlZWqY9LirGO7GoHUEU7m6
   sb8cT8+ocZYNV3CCF6CZxAfVS9WgyR8H0OcAwaNbekN4N3py2inDlGbB4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220585292"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="220585292"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 00:18:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="548938302"
Received: from aravind2-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.9.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 00:17:58 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH V3] drm/i915/adl-n: Enable ADL-N platform
In-Reply-To: <8735mqb6oi.ffs@tglx>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211210051802.4063958-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87r1ab1huq.fsf@intel.com> <8735mqb6oi.ffs@tglx>
Date:   Wed, 22 Dec 2021 10:17:55 +0200
Message-ID: <87tuf1yrws.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 18 Dec 2021, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, Dec 17 2021 at 15:27, Jani Nikula wrote:
>> On Fri, 10 Dec 2021, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
>>> Adding PCI device ids and enabling ADL-N platform.
>>> ADL-N from i915 point of view is subplatform of ADL-P.
>>>
>>> BSpec: 68397
>>>
>>> Changes since V2:
>>> 	- Added version log history
>>> Changes since V1:
>>> 	- replace IS_ALDERLAKE_N with IS_ADLP_N - Jani Nikula
>>>
>>> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
>>
>> Cc: x86 maintainers & lists
>>
>> Ack for merging the arch/x86/kernel/early-quirks.c PCI ID update via
>> drm-intel?
>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks, pushed to drm-intel-next.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
