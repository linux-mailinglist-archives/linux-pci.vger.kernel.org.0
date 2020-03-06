Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF117C581
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 19:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFShT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 13:37:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:19157 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFShT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 13:37:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 10:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="244686470"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2020 10:37:18 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id D020C580298;
        Fri,  6 Mar 2020 10:37:17 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [patch 6/7] genirq: Provide interrupt injection mechanism
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <20200306130341.199467200@linutronix.de>
 <20200306130623.990928309@linutronix.de>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <4729cdaf-8a51-6f22-ea75-4055a59747df@linux.intel.com>
Date:   Fri, 6 Mar 2020 10:34:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306130623.990928309@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/6/20 5:03 AM, Thomas Gleixner wrote:
> Error injection mechanisms need a half ways safe way to inject interrupts as
> invoking generic_handle_irq() or the actual device interrupt handler
> directly from e.g. a debugfs write is not guaranteed to be safe.
>
> On x86 generic_handle_irq() is unsafe due to the hardware trainwreck which
> is the base of x86 interrupt delivery and affinity management.
>
> Move the irq debugfs injection code into a separate function which can be
> used by error injection code as well.
>
> The implementation prevents at least that state is corrupted, but it cannot
> close a very tiny race window on x86 which might result in a stale and not
> serviced device interrupt under very unlikely circumstances.
>
> This is explicitly for debugging and testing and not for production use or
> abuse in random driver code.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   include/linux/interrupt.h |    2 +
>   kernel/irq/Kconfig        |    5 ++++
>   kernel/irq/chip.c         |    2 -
>   kernel/irq/debugfs.c      |   34 -----------------------------
>   kernel/irq/internals.h    |    2 -
>   kernel/irq/resend.c       |   53 ++++++++++++++++++++++++++++++++++++++++++++--
>   6 files changed, 61 insertions(+), 37 deletions(-)
>
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -248,6 +248,8 @@ extern void enable_percpu_nmi(unsigned i
>   extern int prepare_percpu_nmi(unsigned int irq);
>   extern void teardown_percpu_nmi(unsigned int irq);
>   
> +extern int irq_inject_interrupt(unsigned int irq);
> +
>   /* The following three functions are for the core kernel use only. */
>   extern void suspend_device_irqs(void);
>   extern void resume_device_irqs(void);
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -43,6 +43,10 @@ config GENERIC_IRQ_MIGRATION
>   config AUTO_IRQ_AFFINITY
>          bool
>   
> +# Interrupt injection mechanism
> +config GENERIC_IRQ_INJECTION
> +	bool
> +
>   # Tasklet based software resend for pending interrupts on enable_irq()
>   config HARDIRQS_SW_RESEND
>          bool
> @@ -127,6 +131,7 @@ config SPARSE_IRQ
>   config GENERIC_IRQ_DEBUGFS
>   	bool "Expose irq internals in debugfs"
>   	depends on DEBUG_FS
> +	select GENERIC_IRQ_INJECTION
>   	default n
>   	---help---
>   
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -278,7 +278,7 @@ int irq_startup(struct irq_desc *desc, b
>   		}
>   	}
>   	if (resend)
> -		check_irq_resend(desc);
> +		check_irq_resend(desc, false);
>   
>   	return ret;
>   }
> --- a/kernel/irq/debugfs.c
> +++ b/kernel/irq/debugfs.c
> @@ -190,39 +190,7 @@ static ssize_t irq_debug_write(struct fi
>   		return -EFAULT;
>   
>   	if (!strncmp(buf, "trigger", size)) {
> -		unsigned long flags;
> -		int err;
> -
> -		/* Try the HW interface first */
> -		err = irq_set_irqchip_state(irq_desc_get_irq(desc),
> -					    IRQCHIP_STATE_PENDING, true);
> -		if (!err)
> -			return count;
> -
> -		/*
> -		 * Otherwise, try to inject via the resend interface,
> -		 * which may or may not succeed.
> -		 */
> -		chip_bus_lock(desc);
> -		raw_spin_lock_irqsave(&desc->lock, flags);
> -
> -		/*
> -		 * Don't allow injection when the interrupt is:
> -		 *  - Level or NMI type
> -		 *  - not activated
> -		 *  - replaying already
> -		 */
> -		if (irq_settings_is_level(desc) ||
> -		    !irqd_is_activated(&desc->irq_data) ||
> -		    (desc->istate & (IRQS_NMI | IRQS_REPLAY)) {
> -			err = -EINVAL;
> -		} else {
> -			desc->istate |= IRQS_PENDING;
> -			err = check_irq_resend(desc);
> -		}
> -
> -		raw_spin_unlock_irqrestore(&desc->lock, flags);
> -		chip_bus_sync_unlock(desc);
> +		int err = irq_inject_interrupt(irq_desc_get_irq(desc));
>   
>   		return err ? err : count;
>   	}
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -108,7 +108,7 @@ irqreturn_t handle_irq_event_percpu(stru
>   irqreturn_t handle_irq_event(struct irq_desc *desc);
>   
>   /* Resending of interrupts :*/
> -int check_irq_resend(struct irq_desc *desc);
> +int check_irq_resend(struct irq_desc *desc, bool inject);
>   bool irq_wait_for_poll(struct irq_desc *desc);
>   void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
>   
> --- a/kernel/irq/resend.c
> +++ b/kernel/irq/resend.c
> @@ -91,7 +91,7 @@ static int irq_sw_resend(struct irq_desc
>    *
>    * Is called with interrupts disabled and desc->lock held.
>    */
> -int check_irq_resend(struct irq_desc *desc)
> +int check_irq_resend(struct irq_desc *desc, bool inject)
>   {
>   	int err = 0;
>   
> @@ -108,7 +108,7 @@ int check_irq_resend(struct irq_desc *de
>   	if (desc->istate & IRQS_REPLAY)
>   		return -EBUSY;
>   
> -	if (!(desc->istate & IRQS_PENDING))
> +	if (!(desc->istate & IRQS_PENDING) && !inject)
>   		return 0;
>   
>   	desc->istate &= ~IRQS_PENDING;
> @@ -122,3 +122,52 @@ int check_irq_resend(struct irq_desc *de
>   		desc->istate |= IRQS_REPLAY;
>   	return err;
>   }
> +
> +#ifdef CONFIG_GENERIC_IRQ_INJECTION
> +/**
> + * irq_inject_interrupt - Inject an interrupt for testing/error injection
> + * @irq:	The interrupt number
> + *
> + * This function must only be used for debug and testing purposes!
> + *
> + * Especially on x86 this can cause a premature completion of an interrupt
> + * affinity change causing the interrupt line to become stale. Very
> + * unlikely, but possible.
> + *
> + * The injection can fail for various reasons:
> + * - Interrupt is not activated
> + * - Interrupt is NMI type or currently replaying
> + * - Interrupt is level type
> + * - Interrupt does not support hardware retrigger and software resend is
> + *   either not enabled or not possible for the interrupt.
> + */
> +int irq_inject_interrupt(unsigned int irq)
> +{
> +	struct irq_desc *desc;
> +	unsigned long flags;
> +	int err;
> +
> +	/* Try the state injection hardware interface first */
> +	if (!irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true))
> +		return 0;
> +
> +	/* That failed, try via the resend mechanism */
> +	desc = irq_get_desc_buslock(irq, &flags, 0);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	/*
> +	 * Only try to inject when the interrupt is:
> +	 *  - not NMI type
> +	 *  - activated
> +	 */
> +	if ((desc->istate & IRQS_NMI) || !irqd_is_activated(&desc->irq_data))
> +		err = -EINVAL;
> +	else
> +		err = check_irq_resend(desc, true);
> +
> +	irq_put_desc_busunlock(desc, flags);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(irq_inject_interrupt);
> +#endif
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

