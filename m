Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19FE3D8C0C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 12:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhG1Kk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 06:40:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhG1KkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 06:40:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627468818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBLeATcwfqfAwWH6WlqEnrh3DtrFeH7LmMiAWPWZmCM=;
        b=LFAHo3tV8SwgQqBtpNGPxPYN7viHLKmKxVFgLXSQy2Eb8RB+D3MEEoTpgSUxfhE/2fUhIq
        sovrG4qU/PL6cdA1DFNS72fDZ6J+v3NAtUdPsoVBQf4puYtbrVp33WbosKxokJYvGRQfMM
        qmIipeRgJaSQ0QYwWKX7RHE7aE2rrnCHSCE1Dp7QQkSZxIVKadfAvmc1Q4RD8fVQ476Pz3
        frjiEfg2iqf/kRE/pR6jnWhZHG+3vVai8Pgev9yoi2LIerVNrEZrNQxu9dR+KCI/VVXkJQ
        0352TmcK+2VyC4+ggBCfFhoh84x9SPjpGTq4ONrxtTGIjWdIinq/D3Q1s7wREw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627468818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBLeATcwfqfAwWH6WlqEnrh3DtrFeH7LmMiAWPWZmCM=;
        b=S4XYjdut749SYDj3weoZDeeCZhriPTKyQFEaZHyx6jwTbquNIHtOUlJPYnQRHtPgJ6Db1x
        q4Oy+4MybuBUHVAQ==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, x86@kernel.org
Subject: Re: [patch 6/8] genirq: Provide IRQCHIP_AFFINITY_PRE_STARTUP
In-Reply-To: <871r7q2xik.wl-maz@kernel.org>
References: <20210721191126.274946280@linutronix.de> <20210721192650.687529735@linutronix.de> <871r7q2xik.wl-maz@kernel.org>
Date:   Wed, 28 Jul 2021 12:40:18 +0200
Message-ID: <87bl6m3enh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22 2021 at 16:12, Marc Zyngier wrote:
> On Wed, 21 Jul 2021 20:11:32 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>  #include <linux/irqdesc.h>
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -265,8 +265,11 @@ int irq_startup(struct irq_desc *desc, b
>>  	} else {
>>  		switch (__irq_startup_managed(desc, aff, force)) {
>>  		case IRQ_STARTUP_NORMAL:
>> +			if (d->chip->flags & IRQCHIP_AFFINITY_PRE_STARTUP)
>> +				irq_setup_affinity(desc);
>
> How about moving this to activate instead? We already special-case the
> activation of MSIs for PCI (MSI_FLAG_ACTIVATE_EARLY), and this
> wouldn't look completely out of place. The startup mode could be an
> issue though...

Yes, I thought about that, but the ordering here is:

setup()
  early_activate()

early activation just needs to program a valid message. Now later we
have request_irq() invoking:

     activate()
     startup()

So, yes. We could do that in activate, but then we still have the post
startup variant in irq_startup() which makes the code hard to follow.

There is another practical issue. Assume the irq is requested with
IRQF_NOAUTOEN, then irq_startup() will be invoked when the driver calls
enable_irq(), which might be way later and then the affinity setting
might be completely different already. So I rather keep it there.

Thanks,

        tglx
