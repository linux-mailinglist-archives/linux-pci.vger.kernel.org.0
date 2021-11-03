Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76DC444B99
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 00:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhKCX2q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 19:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKCX2q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 19:28:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F4CC061714
        for <linux-pci@vger.kernel.org>; Wed,  3 Nov 2021 16:26:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635981965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfTyFoXajtV0v9y/BzmoswZaGOzbbSsMzbV3xAEe7f8=;
        b=FG232QjcqbTedwDbie2TZlaxunqVOoH7LkuCfHq9pkVIrcjDea/Jq7f4TE4HKlJKokS5Qd
        mk3z0Zjoj8VI5X34ZomjX1G4/fEJ5mQEwdRTwnQCLLUF5TzjqkDxdWKDQg4/Pp04ati32T
        LReCTHFGzrgNprU+Ps61kW5PcsjY9O9kqlKUTuYJvSbES8zwklYl+no3/15X5qd/rkPEYO
        YU6Z/zGM+AqFTwoVix4R9s9BYpVcZ3bENnaOOfJsMUKxIDFFPjspwNlwWt8EtwxzjQBwG+
        eKdK/dUMdlpAhhqS52T770CdDjTuPGeSoreno/76+rV2A27PHJbpxAurtevwAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635981965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfTyFoXajtV0v9y/BzmoswZaGOzbbSsMzbV3xAEe7f8=;
        b=Wi+PWP2tcmH6wdHfleglyGLWoarqN06h513enO1PuRi77n2p1ZX35nkizmwepUsrxjlzHy
        +B+iC4GV3dxfcuBg==
To:     Josef Johansson <josef@oderland.se>
Cc:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jgross@suse.com,
        linux-pci@vger.kernel.org, maz@kernel.org,
        xen-devel@lists.xenproject.org, Jason Andryuk <jandryuk@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] PCI/MSI: Move non-mask check back into low level accessors
In-Reply-To: <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com> <87fssmg8k4.ffs@tglx>
 <87cznqg5k8.ffs@tglx> <d1cc20aa-5c5c-6c7b-2e5d-bc31362ad891@oderland.se>
 <89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se>
 <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se>
Date:   Thu, 04 Nov 2021 00:26:05 +0100
Message-ID: <87k0ho6ctu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Josef!

On Wed, Oct 27 2021 at 17:29, Josef Johansson wrote:
> On 10/27/21 14:01, Josef Johansson wrote:
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index 6a5ecee6e567..28d509452958 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -529,10 +529,10 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
>>  
>>  	/*
>>  	 * Checking the first MSI descriptor is sufficient. MSIX supports
>> -	 * masking and MSI does so when the maskbit is set.
>> +	 * masking and MSI does so when the can_mask is set.
>>  	 */
>>  	desc = first_msi_entry(dev);
>> -	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
>> +	return desc->msi_attrib.is_msix || desc->msi_attrib.can_mask;
>>  }
>>  
>>  int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>
> Hi Thomas,
>
> With the above added the kernel boots fine and I can even suspend it twice.
> Which is with my laptop, a good sign.
>
> You can add Tested-By: josef@oderland.se.

Thank you for fixing my quick hack in vacation mode. I'll send out a v2
in a minute.

Thanks,

        tglx
 
