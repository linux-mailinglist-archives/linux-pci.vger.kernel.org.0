Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A68128C4BB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 00:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbgJLWZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388361AbgJLWZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 18:25:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4DEC0613D0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 15:25:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602541553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/jnwvjKTWXUQSzqDtJQ9DVB2IWZ3znhzaC28M8nvl4=;
        b=UwB5idtTkSSBaCtsq4vgB95/7TfnI8JoQYrnYNmD4iZDjIRneGWCHKxvtEg7gs8BXAyQ6j
        qpeKWDYzSYNmaUxbsx41SAozijN/5b8u5BSczmkgpBjtu+XuNJlmYQxrknnoS+0dwkyDHA
        zcliFZcGRh64I87S3zZeY4BIUoWBVx6QoUKm2VlJ6imUTuO9K4pR7hpOd3lB0NmkQMtwMP
        zz1lTyaSSyRjAn2xU+CfL5s+ffabImAt1xMnYUBy+I9J7UEogFkpRVpbHLCNOh+7r/LF5A
        e9AczGPVc2SLoSab9Ac4tTO0CUcApgZFdXbFfzD/DcwQ6RMnumLKQMIg3VPc9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602541553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/jnwvjKTWXUQSzqDtJQ9DVB2IWZ3znhzaC28M8nvl4=;
        b=IzuYrqiJRVtjOVwEeI3ChzKxK8olHH5c44a8/7M3NQBgX9vJQCACcCMwrfoamgFAewWvfn
        4AlOuDGSA8gJ5QBw==
To:     David Woodhouse <dwmw2@infradead.org>,
        Chris Friesen <chris.friesen@windriver.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
In-Reply-To: <cdc531fd18adc46c5642fed456aad25507df5eba.camel@infradead.org>
References: <20201012165839.GA3732859@bjorn-Precision-5520> <87a6wrqqpf.fsf@nanos.tec.linutronix.de> <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com> <87zh4rp7gg.fsf@nanos.tec.linutronix.de> <cdc531fd18adc46c5642fed456aad25507df5eba.camel@infradead.org>
Date:   Tue, 13 Oct 2020 00:25:53 +0200
Message-ID: <87blh7ozda.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12 2020 at 21:24, David Woodhouse wrote:
> On Mon, 2020-10-12 at 21:31 +0200, Thomas Gleixner wrote:
>> > In this case could disk I/O submitted by one of those CPUs end up 
>> > interrupting another one?
>> 
>> On older kernels, yes.
>> 
>> X86 enforces effective single CPU affinity for interrupts since v4.15.
>
> Is that here to stay?

Yes. The way how logical mode works is that it sends the vast majority
to the first CPU in the logical mask. So the benefit is pretty much zero
and we haven't had anyone complaining since we switched to that mode.

Having single CPU affinity enforced made the whole x86 affinity
disaster^Wlogic way simpler and also reduced vector pressure
significantly.

> Because it means that sending external interrupts
> in logical mode is kind of pointless, and we might as well do this...
>
> --- a/arch/x86/kernel/apic/x2apic_cluster.c
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> @@ -187,3 +187,3 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
>         .irq_delivery_mode              = dest_Fixed,
> -       .irq_dest_mode                  = 1, /* logical */
> +       .irq_dest_mode                  = 0, /* physical */
>  
> @@ -205,3 +205,3 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
>  
> -       .calc_dest_apicid               = x2apic_calc_apicid,
> +       .calc_dest_apicid               = apic_default_calc_apicid,
>  
>
> And then a bunch of things which currently set x2apic_phys just because
> of *external* IRQ limitations, no longer have to, and can still benefit
> from multicast of IPIs to whole clusters at a time.

Indeed, never thought about that.

Thanks,

        tglx
