Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE22B30D8
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 21:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgKNU6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 15:58:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKNU6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Nov 2020 15:58:11 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605387489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgmO+ovXS0H7Vz5OGOh347PfWQu+2lZpnKeHesuoCow=;
        b=ZKD0Ij3HgOCb3u6Q/mbn8OHp2fgVYQAOJfF6A922uc6bzYnZxpw687nnt6anZvCZokEsyX
        KfgVW2WX9Uqm7IXFqlC5w14q4xLIJIY3j/XS4rQBT2IRMdgd/WnOsCCJlUkXQQPOAZ0IPt
        f+pxLgdqaR05gsaUP9Mq1VOl/U80rVeErHz1C1g9r/NJr2p2eInbNJ4/g1aWnVXJmhXKY7
        8Rrb9zgmfbQjbf20cdi7dYxhmr+bhbAckMaez6MT/jEhT2c4N+X2rCNgYgmqdqJ80Z1Sty
        f5bnufQLUsefIUiXSQIr6Rq5cWMzaTJt2Ka4hVfEOgc5A03P8z/HJykm2PUcqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605387489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgmO+ovXS0H7Vz5OGOh347PfWQu+2lZpnKeHesuoCow=;
        b=3oZ5BSjO6nypbaQiWCHWpwDRjhngAoRaslwLtC/9AuSl8rLOdS2X9/Lef9/i4AldUOTw5h
        4W5C2SBXlNc68dAg==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <20201114203925.GA1182595@bjorn-Precision-5520>
References: <20201114203925.GA1182595@bjorn-Precision-5520>
Date:   Sat, 14 Nov 2020 21:58:08 +0100
Message-ID: <87h7prac67.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On Sat, Nov 14 2020 at 14:39, Bjorn Helgaas wrote:
> On Sat, Nov 14, 2020 at 12:40:10AM +0100, Thomas Gleixner wrote:
>> On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
>> > On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
>> >> pci_device_shutdown() still clears the Bus Master Enable bit if we're
>> >> doing a kexec and the device is in D0-D3hot, which should also disable
>> >> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
>> >> device causing the storm was in PCI_UNKNOWN state?
>> >
>> > That's indeed a really good question.
>> 
>> So we do that on kexec, but is that true when starting a kdump kernel
>> from a kernel crash? I doubt it.
>
> Ah, right, I bet that's it, thanks.  The kdump path is basically this:
>
>   crash_kexec
>     machine_kexec
>
> while the usual kexec path is:
>
>   kernel_kexec
>     kernel_restart_prepare
>       device_shutdown
>         while (!list_empty(&devices_kset->list))
>           dev->bus->shutdown
>             pci_device_shutdown            # pci_bus_type.shutdown
>     machine_kexec
>
> So maybe we need to explore doing some or all of device_shutdown() in
> the crash_kexec() path as well as in the kernel_kexec() path.

The problem is that if the machine crashed anything you try to attempt
before starting the crash kernel is reducing the chance that the crash
kernel actually starts.

Is there something at the root bridge level which allows to tell the
underlying busses to shut up, reset or go into a defined state? That
might avoid chasing lists which might be already unreliable.

Thanks,

        tglx
