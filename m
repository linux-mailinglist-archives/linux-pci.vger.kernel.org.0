Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284104A02F4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 22:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbiA1Vg6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 16:36:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:49477 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351339AbiA1Vg5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 16:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643405817; x=1674941817;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=O8+qYYMChKDPm5y7l8O6pu2vDB8trFOrTiRzdfkKn6E=;
  b=U8ayN15FKvmbFj6t10Jw+XcOc1vdG7vW5bHxnQ0JniD7yMxR10q7rc24
   VP89Ry/SyJTV5WNkj3QmbJ1qBlP8y1Lk/bw1x1Xxyf9FWVCI5OsIeuTXp
   zm3+5BIIabuOToOnkwuVXNB2GT8PC00PtwTY5IdfyivA/JxXsHFFp4Gj6
   l8tgIg8CB+mA/Wmd3AMaFpqrXvGIWetlBDUKeypcCDGLKZPCQaWLlopFA
   ROeeGgbLTcmiTnpJ4eOf/Ckkc2SBCR12rxhBxH22/bDo4Zk8dB/YBNySr
   TDTMztddjXh3Ig9OKs8+CwoLYBkZCCTJd5NXQDspiHaEqZqI5yeWXz+7R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="271663561"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="271663561"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:36:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697225168"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:36:56 -0800
Message-ID: <8f820849-6940-4271-e678-1ae037cdfb64@intel.com>
Date:   Fri, 28 Jan 2022 13:36:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     Brent Spillner <spillner@acm.org>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YfQpy5yGGqY8T0wW@jupiter.dyndns.org>
 <a7ef2455-ede5-2238-639b-b3a66842a04b@intel.com>
 <CAGwJgaNa2u8vmxsnaSdpSH+ZO0e2GCYObSwC+j03843gXQ_vwg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] arch:x86:pci:irq.c: Improve log message when IRQ cannot
 be identified
In-Reply-To: <CAGwJgaNa2u8vmxsnaSdpSH+ZO0e2GCYObSwC+j03843gXQ_vwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/28/22 12:48, Brent Spillner wrote:
> It seems like the multiline string literal is your main pain point--- would
> 
> +#ifdef CONFIG_ACPI
> +                       if (acpi_noirq)
> +                               msg = "; consider removing acpi=noirq";
> +                       else
> +                               msg = "; recommend verifying UEFI/BIOS
> IRQ options";
> +#else
> +                       msg = "; recommend verifying UEFI/BIOS IRQ
> options or enabling ACPI";
> +#endif
> 
> be OK without going to IS_ENABLED()?  (Personally, I think the #ifdef
> style is more readable.)

I think that's _better_ than what was in the patch.  But, even with it,
I still think the #ifdef mess borders on unreadable.

But, if Bjorn likes it, then go for it. :)
