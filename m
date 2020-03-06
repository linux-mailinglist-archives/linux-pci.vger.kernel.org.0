Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF217BF0A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFNgj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCFNgi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 08:36:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9844C2072D;
        Fri,  6 Mar 2020 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583501797;
        bh=+rJzOGoCHyxNsgbROnVpMOHHJ4FB/8LYXTHJgeVIFL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lijuNYfGieomjEpSg+dgif/c9XKU8avRktCqThc9z0aSfsSoVFGvNQAJ3+P+vCDmX
         i9f4ej8QcMBjBmQM8vCrVlhkbA77BgDfYkckvToIIUlBU5sbxTOH2UkvwLeU+AvzyX
         +jNJTaRDmUGbusrOOD9TixTzVS7WoPySCb634KT0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAD9X-00AaHr-Tz; Fri, 06 Mar 2020 13:36:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Mar 2020 13:36:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [patch 2/7] genirq: Add protection against unsafe usage of
 generic_handle_irq()
In-Reply-To: <20200306130623.590923677@linutronix.de>
References: <20200306130341.199467200@linutronix.de>
 <20200306130623.590923677@linutronix.de>
Message-ID: <664b3a85c46aff34ae89548e118c1bd8@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-03-06 13:03, Thomas Gleixner wrote:
> In general calling generic_handle_irq() with interrupts disabled from 
> non
> interrupt context is harmless. For some interrupt controllers like the 
> x86
> trainwrecks this is outright dangerous as it might corrupt state if an
> interrupt affinity change is pending.
> 
> Add infrastructure which allows to mark interrupts as unsafe and catch 
> such
> usage in generic_handle_irq().
> 
> Reported-by: sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/irq.h    |   13 +++++++++++++
>  kernel/irq/internals.h |    8 ++++++++
>  kernel/irq/irqdesc.c   |    6 ++++++
>  kernel/irq/resend.c    |    5 +++--
>  4 files changed, 30 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -211,6 +211,8 @@ struct irq_data {
>   * IRQD_CAN_RESERVE		- Can use reservation mode
>   * IRQD_MSI_NOMASK_QUIRK	- Non-maskable MSI quirk for affinity change
>   *				  required
> + * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only 
> invoked
> + *				  from actual interrupt context.
>   */
>  enum {
>  	IRQD_TRIGGER_MASK		= 0xf,
> @@ -234,6 +236,7 @@ enum {
>  	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
>  	IRQD_CAN_RESERVE		= (1 << 26),
>  	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
> +	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
>  };
> 
>  #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, 
> state_use_accessors)
> @@ -303,6 +306,16 @@ static inline bool irqd_is_single_target
>  	return __irqd_to_state(d) & IRQD_SINGLE_TARGET;
>  }
> 
> +static inline void irqd_set_handle_enforce_irqctx(struct irq_data *d)
> +{
> +	__irqd_to_state(d) |= IRQD_HANDLE_ENFORCE_IRQCTX;
> +}
> +
> +static inline bool irqd_is_handle_enforce_irqctx(struct irq_data *d)
> +{
> +	return __irqd_to_state(d) & IRQD_HANDLE_ENFORCE_IRQCTX;
> +}
> +
>  static inline bool irqd_is_wakeup_set(struct irq_data *d)
>  {
>  	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -425,6 +425,10 @@ static inline struct cpumask *irq_desc_g
>  {
>  	return desc->pending_mask;
>  }
> +static inline bool handle_enforce_irqctx(struct irq_data *data)
> +{
> +	return irqd_is_handle_enforce_irqctx(data);
> +}
>  bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
>  #else /* CONFIG_GENERIC_PENDING_IRQ */
>  static inline bool irq_can_move_pcntxt(struct irq_data *data)
> @@ -451,6 +455,10 @@ static inline bool irq_fixup_move_pendin
>  {
>  	return false;
>  }
> +static inline bool handle_enforce_irqctx(struct irq_data *data)
> +{
> +	return false;
> +}
>  #endif /* !CONFIG_GENERIC_PENDING_IRQ */
> 
>  #if !defined(CONFIG_IRQ_DOMAIN) || 
> !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -638,9 +638,15 @@ void irq_init_desc(unsigned int irq)
>  int generic_handle_irq(unsigned int irq)
>  {
>  	struct irq_desc *desc = irq_to_desc(irq);
> +	struct irq_data *data;
> 
>  	if (!desc)
>  		return -EINVAL;
> +
> +	data = irq_desc_get_irq_data(desc);
> +	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
> +		return -EPERM;

It is a bit sad that there are only *two* users in the tree that
actually check the return value of generic_handle_irq(). Thankfully,
the WARN_ON should wake people up.

> +
>  	generic_handle_irq_desc(desc);
>  	return 0;
>  }
> --- a/kernel/irq/resend.c
> +++ b/kernel/irq/resend.c
> @@ -72,8 +72,9 @@ void check_irq_resend(struct irq_desc *d
>  		desc->istate &= ~IRQS_PENDING;
>  		desc->istate |= IRQS_REPLAY;
> 
> -		if (!desc->irq_data.chip->irq_retrigger ||
> -		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data)) {
> +		if ((!desc->irq_data.chip->irq_retrigger ||
> +		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data)) &&
> +		    !handle_enforce_irqctx(&desc->irq_data)) {
>  #ifdef CONFIG_HARDIRQS_SW_RESEND
>  			unsigned int irq = irq_desc_get_irq(desc);

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
