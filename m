Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1A417C577
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgCFSfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 13:35:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:23407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFSfF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 13:35:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 10:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="233400615"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2020 10:35:04 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 24C675802C8;
        Fri,  6 Mar 2020 10:35:04 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [patch 7/7] PCI/AER: Fix the broken interrupt injection
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <20200306130341.199467200@linutronix.de>
 <20200306130624.098374457@linutronix.de>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <08c51309-0bd1-9696-4f4b-4f7425762268@linux.intel.com>
Date:   Fri, 6 Mar 2020 10:32:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306130624.098374457@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/6/20 5:03 AM, Thomas Gleixner wrote:
> The AER error injection mechanism just blindly abuses generic_handle_irq()
> which is really not meant for consumption by random drivers. The include of
> linux/irq.h should have been a red flag in the first place. Driver code,
> unless implementing interrupt chips or low level hypervisor functionality
> has absolutely no business with that.
>
> Invoking generic_handle_irq() from non interrupt handling context can have
> nasty side effects at least on x86 due to the hardware trainwreck which
> makes interrupt affinity changes a fragile beast. Sathyanarayanan triggered
> a NULL pointer dereference in the low level APIC code that way. While the
> particular pointer could be checked this would only paper over the issue
> because there are other ways to trigger warnings or silently corrupt state.
>
> Invoke the new irq_inject_interrupt() mechanism, which has the necessary
> sanity checks in place and injects the interrupt via the irq_retrigger()
> mechanism, which is at least halfways safe vs. the fragile x86 affinity
> change mechanics.
>
> It's safe on x86 as it does not corrupt state, but it still can cause a
> premature completion of an interrupt affinity change causing the interrupt
> line to become stale. Very unlikely, but possible.
>
> For regular operations this is a non issue as AER error injection is meant
> for debugging and testing and not for usage on production systems. People
> using this should better know what they are doing.
It looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Fixes: 390e2db82480 ("PCI/AER: Abstract AER interrupt handling")
> Reported-by: sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/pci/pcie/Kconfig      |    1 +
>   drivers/pci/pcie/aer_inject.c |    6 ++----
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -34,6 +34,7 @@ config PCIEAER
>   config PCIEAER_INJECT
>   	tristate "PCI Express error injection support"
>   	depends on PCIEAER
> +	select GENERIC_IRQ_INJECTION
>   	help
>   	  This enables PCI Express Root Port Advanced Error Reporting
>   	  (AER) software error injector.
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -16,7 +16,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/init.h>
> -#include <linux/irq.h>
> +#include <linux/interrupt.h>
>   #include <linux/miscdevice.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> @@ -468,9 +468,7 @@ static int aer_inject(struct aer_error_i
>   		}
>   		pci_info(edev->port, "Injecting errors %08x/%08x into device %s\n",
>   			 einj->cor_status, einj->uncor_status, pci_name(dev));
> -		local_irq_disable();
> -		generic_handle_irq(edev->irq);
> -		local_irq_enable();
> +		ret = irq_inject_interrupt(edev->irq);
>   	} else {
>   		pci_err(rpdev, "AER device not found\n");
>   		ret = -ENODEV;
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

