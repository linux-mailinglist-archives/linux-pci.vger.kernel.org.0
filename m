Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100C749FFE1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiA1SAc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 13:00:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:55165 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343650AbiA1SA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 13:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643392828; x=1674928828;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=/kAMO9UCCWELpL95wHGY0j+eTJs2CMOTU7egNKfSooU=;
  b=aDdwCAiNnLmCzHbPQpR5OwJUjIbkqWOHIz+xyvNZOiUde5qGQX4bgLbK
   DgDVz/zZhK4AuESECaDBSscVaL1tWJ+ydTYgQOwNxemAFYIIGNg3A2spt
   UZaMQeDxbCOW75zUC6tRa81oM/zOEQDhFpQ05pX4s7YhoAdxy0gFSV8hZ
   3+6r6VanEGFzxeulwyHE2jhVgsyDE0GiQUg00OzaCFNkxzLlPFt3bPlTl
   UMzF3jmqafvj0D+d/OLvve9Y+ZFKaTEorx78fd8/fBboOMQi2IXd7jqWV
   mk1kvTLyiy37qKVqwyybFMuDRJT2qVlYQRkCqvvljGst13TzVlFyqBNYw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="230744973"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="230744973"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:00:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="697167028"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:00:26 -0800
Message-ID: <a7ef2455-ede5-2238-639b-b3a66842a04b@intel.com>
Date:   Fri, 28 Jan 2022 10:00:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     Brent Spillner <spillner@acm.org>, bhelgaas@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YfQpy5yGGqY8T0wW@jupiter.dyndns.org>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] arch:x86:pci:irq.c: Improve log message when IRQ cannot
 be identified
In-Reply-To: <YfQpy5yGGqY8T0wW@jupiter.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please fix up that subject.  We don't tend to use ":" to separate
things.  Second, the prefix isn't a filename.  It's really a subsystem.
 Take a look at:

	git log arch/x86/pci/irq.c

for some other examples.

On 1/28/22 09:37, Brent Spillner wrote:
> The existing code always suggests trying the pci=biosirq kernel
> parameter, but this option is only recognized when CONFIG_PCI_BIOS is
> set, which in turn depends on CONFIG_X86_32, so it is never appropriate
> on x86_64.
> 
> The new version tries to form a more useful message when pci=biosirq is
> not available, including by suggesting different acpi= options if
> appropriate (probably the most common cause of failed IRQ discovery).
> 
> See arch/x86/pci/common.c:535 for the interpretation of pci=biosirq, and
> arch/x86/Kconfig:2633 for the dependencies of CONFIG_PCI_BIOS.

Shockingly enough, that parameter is in the documentation:

	Documentation/admin-guide/kernel-parameters.txt

and double-shockingly, it's even called out as X86-32-only:

	biosirq		[X86-32] Use PCI BIOS calls to get the interrupt

Given that, do we really need to refer to the line numbers of the
implementation which will probably be stale by the time this is merged
anyway?

>  arch/x86/pci/irq.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index 97b63e35e152..bc4aaaa74832 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -1522,7 +1522,21 @@ static int pirq_enable_irq(struct pci_dev *dev)
>  		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
>  			msg = "";
>  		else
> +#ifdef CONFIG_PCI_BIOS
>  			msg = "; please try using pci=biosirq";
> +#else
> +			/* pci=biosirq is not a valid option */
> +#ifdef CONFIG_ACPI
> +			if (acpi_noirq)
> +				msg = "; consider removing acpi=noirq";
> +			else
> +#endif
> +				msg = "; recommend verifying UEFI/BIOS IRQ options"
> +#ifndef CONFIG_ACPI
> +					" or enabling ACPI"
> +#endif
> +					;
> +#endif

Any chance you could make that, um, a bit more readable?  It's OK to add
brackets to the else{} for readability even if they're not *strictly*
necessary.

It might also be nice to use

	if (IS_ENABLED(CONFIG_FOO))
		...

rather than the #ifdefs.

I'd also be perfectly OK having two different strings rather than
relying on string concatenation and the #ifdefs.

Is the "or enabling ACPI" message really necessary?
