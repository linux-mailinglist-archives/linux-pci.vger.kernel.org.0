Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B692A96CB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 14:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKFNPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 08:15:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45373 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgKFNPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 08:15:07 -0500
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1kb1ZP-00036k-CE
        for linux-pci@vger.kernel.org; Fri, 06 Nov 2020 13:14:23 +0000
Received: by mail-qv1-f70.google.com with SMTP id s9so609055qvt.13
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2020 05:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HPVFLNtJgEG3/T/AiPiJFJb96JDnXIr/3D3z64Va+Eo=;
        b=HM/1t/aAHX4cRARu5sULwyzcxKVHgP6t20JBu8iS0U1B3DOy3G2dI4iY7RR1lJpOAX
         wQJedmO8CoxCzk4kuhzcHgqaPNfS9Iu7HZeOSelh0vu8Bo5qYr6uohvwg9UIl5kt2Ubk
         1FXAeg2WwIKEXmDeL49LRfHmlu0Mx9FnGxcem2s84ZDqIbyxkEoXX5MSArYUBPFze3sP
         Rc8wgsVGC6Ztt6tCHMte+zEpPFhtM3LgL/ORf5wenDx12a9IQk6kWupaISUnSOKcK0wY
         Ya2dQx0sGzk0F3jm+mieHXWLHw3tpTJ/SFCK1ICb5p6j4Epjb8vB0qfFvFJqeEhF0CvV
         +Kuw==
X-Gm-Message-State: AOAM532TR85v1xxaAWT5DeuO2IfVC+LDucnu+VIbhHC423gKmzuK+lG1
        +vRMWtJjNWDWJ+DQvPkra0nsS3Y8RcaaVltmo4qdmCy1KtFksh3Kai9B+dEq2UFxIWLroEwJzlD
        GTgMQ00J3B2DbFjyTIGqwwbZ96YWnAx+EoAgN3Q==
X-Received: by 2002:a05:6214:951:: with SMTP id dn17mr1587414qvb.9.1604668462334;
        Fri, 06 Nov 2020 05:14:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxy3Z788RTdCGVaT5GG1jrF5xWEHnB7xPO6wPDKnHz31b3XsWEStppEzm/eVMQmS55qoB9IYw==
X-Received: by 2002:a05:6214:951:: with SMTP id dn17mr1587386qvb.9.1604668461987;
        Fri, 06 Nov 2020 05:14:21 -0800 (PST)
Received: from [192.168.1.75] ([177.215.78.178])
        by smtp.gmail.com with ESMTPSA id o8sm485618qtm.9.2020.11.06.05.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 05:14:21 -0800 (PST)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de
Cc:     linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
 <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
 <20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <684cf38f-3977-4ec2-c4a6-7c4c31f9851a@canonical.com>
Date:   Fri, 6 Nov 2020 10:14:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/10/2018 14:03, Bjorn Helgaas wrote:
> On Mon, Oct 22, 2018 at 05:35:06PM -0300, Guilherme G. Piccoli wrote:
>> On 18/10/2018 19:15, Bjorn Helgaas wrote:
>>> On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
>>> [...] 
>> I understand your point, but I think this is inherently an architecture
>> problem. No matter what solution we decide for, it'll need to be applied
>> in early boot time, like before the PCI layer gets initialized.
> 
> This is the part I want to know more about.  Apparently there's some
> event X between early_quirks() and the PCI device enumeration, and we
> must disable MSIs before X:
> 
>   setup_arch()
>       early_quirks()                     # arch/x86/kernel/early-quirks.c
>       early_pci_clear_msi()
>   ...
>   X
>   ...
>   pci_scan_root_bus_bridge()
>     ...
>     DECLARE_PCI_FIXUP_EARLY              # drivers/pci/quirks.c
> 
> I want to know specifically what X is.  If we don't know what X is and
> all we know is "we have to disable MSIs earlier than PCI init", then
> we're likely to break things again in the future by changing the order
> of disabling MSIs and whatever X is.
> 
> Bjorn
> 

Hi Bjorn (and all CCed), I'm sorry to necro-bump a thread >2 years
later, but recent discussions led to a better understanding of this 'X'
point, thanks to Thomas!

For those that deleted this thread from their email clients, it's
available in [0] - the summary is that we faced an IRQ storm really
early in boot, due to a bogus PCIe device MSI behavior, when booting a
kdump kernel. This led the machine to get stuck in the boot and we
couldn't kdump. The solution hereby proposed is to clear MSI interrupts
early in x86, if a parameter is provided. I don't have the reproducer
anymore and it was pretty hard to reproduce in virtual environments.

So, about the 'X' Bjorn, in another recent thread about IRQ storms [1],
Thomas clarified that and after a brief discussion, it seems there's no
better way to prevent the MSI storm other than clearing the MSI
capability early in boot. As discussed both here and in thread [1], this
is indeed a per-architecture issue (powerpc is not subject to that, due
to a better FW reset mechanism), so I think we still could benefit in
having this idea implemented upstream, at least in x86 (we could expand
to other architectures if desired, in the future).

As a "test" data point, this was implemented in Ubuntu (same 3 patches
present in this series) for ~2 years and we haven't received bug reports
- I'm saying that because I understand your concerns about expanding the
early PCI quirks scope.

Let me know your thoughts. I'd suggest all to read thread [1], which
addresses a similar issue but in a different "moment" of the system boot
and provides some more insight on why the early MSI clearing seems to
make sense.

Thanks,


Guilherme


[0]
https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com

[1] https://lore.kernel.org/lkml/87y2js3ghv.fsf@nanos.tec.linutronix.de
