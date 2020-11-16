Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1E2B52A4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 21:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbgKPUdO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 15:33:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbgKPUdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 15:33:13 -0500
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1kelAB-0008OQ-6b
        for linux-pci@vger.kernel.org; Mon, 16 Nov 2020 20:31:47 +0000
Received: by mail-qk1-f197.google.com with SMTP id t141so7343772qke.22
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2020 12:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PSXhzbcrsOfHiv3kiMwmmcqoiVOXgTLxYAH1d1uZyKo=;
        b=W0K1uDhqZN6mNTvLErDU72sYf02mQq2j3YlTf2I+uNupq3KonpKiB5X0ED5/Tw2cQK
         YSe/sDFO1W3z+BV1xWXxsLf1oKWgTbT80vyT5UpBZqtpfod69JXQGTkxApoScpnLzY6e
         57Vgc2w2IdXroHPTI+GV4Kne4elhFE1009WylYNBinLm98Fm5sm9kvqUwPl3EBKhvtmD
         QvbrpHnWqSXYgey76zy0czpIh/u6xVVaySKNXu9JUMoZD+krErmhVXOHO7KwXty2H5ne
         n+G445BGHFuyDh5jMv/g6BlwltmESbjEMV4G/nfIrofaVWOgnuhsG9p73UsrI+LuTElG
         G6nw==
X-Gm-Message-State: AOAM532I6gR9jSVcS6W5lvLGbFNgyl2t3EeI5qiTtXSP1pIex3fMlztL
        s6G19whXYq+XfDpoywilABvZVP43ZQ8NtfkjZxn+/9U19vTB/y02f9sYHgmvocmuQialnvx3vc8
        cIJ8SCRDp1oLfzssmNf25hg7Z1lLcnxhFdj5Eqg==
X-Received: by 2002:a05:620a:153b:: with SMTP id n27mr2954034qkk.322.1605558706088;
        Mon, 16 Nov 2020 12:31:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSYnPEVNvljlCoF9SHH3GtyiMrxoAP9uZJ3QWQSYuQ8xOznhBzafz/Rt/VsX6N7XwjLpXp6Q==
X-Received: by 2002:a05:620a:153b:: with SMTP id n27mr2953996qkk.322.1605558705729;
        Mon, 16 Nov 2020 12:31:45 -0800 (PST)
Received: from [192.168.1.121] ([177.215.76.189])
        by smtp.gmail.com with ESMTPSA id i21sm12290111qtm.1.2020.11.16.12.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:31:45 -0800 (PST)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, lukas@wunner.de
Cc:     linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org> <87sg9almmg.fsf@x220.int.ebiederm.org>
 <874klqac40.fsf@nanos.tec.linutronix.de>
 <87lff2ic0h.fsf@x220.int.ebiederm.org>
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
Message-ID: <c8238524-4197-c22d-7bae-df61133fcbfe@canonical.com>
Date:   Mon, 16 Nov 2020 17:31:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lff2ic0h.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First of all, thanks everybody for the great insights/discussion! This
thread ended-up being a great learning for (at least) me.

Given the big amount of replies and intermixed comments, I wouldn't be
able to respond inline to all, so I'll try another approach below.


From Bjorn:
"I think [0] proposes using early_quirks() to disable MSIs at boot-time.
That doesn't seem like a robust solution because (a) the problem affects
all arches but early_quirks() is x86-specific and (b) even on x86
early_quirks() only works for PCI segment 0 because it relies on the
0xCF8/0xCFC I/O ports."

Ah. I wasn't aware of that limitation, I thought enhancing the
early_quirks() search to go through all buses would fix that, thanks for
the clarification! And again, worth to clarify that this is not a
problem affecting all arches _in practice_ - PowerPC for example has the
FW primitives allowing a powerful PCI controller (out-of-band) reset,
preventing this kind of issue usually.

[0]
https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com


From Bjorn:
"A crash_device_shutdown() could do something at the host bridge level
if that's possible, or reset/disable bus mastering/disable MSI/etc on
individual PCI devices if necessary."

From Lukas:
"Guilherme's original patches from 2018 iterate over all 256 PCI buses.
That might impact boot time negatively.  The reason he has to do that is
because the crashing kernel doesn't know which devices exist and which
have interrupts enabled.  However the crashing kernel has that
information.  It should either disable interrupts itself or pass the
necessary information to the crashing kernel as setup_data or whatever.

Guilherme's patches add a "clearmsi" command line parameter.  I guess
the idea is that the parameter is always passed to the crash kernel but
the patches don't do that, which seems odd."

Very good points Lukas, thanks! The reason of not adding the clearmsi
thing as a default kdump procedure is kinda related to your first point:
it impacts a bit boot-time, also it's an additional logic in the kdump
kernel, which we know is (sometimes) the last resort in gathering
additional data to debug a potentially complex issue. That said, I'd not
like to enforce this kind of "policy" to everybody, so my implementation
relies on having it as a parameter, and the kdump userspace counter-part
could then have a choice in adding or not such mechanism to the kdump
kernel parameter list.

About passing the data to next kernel, this is very interesting, we
could do something like that either through setup_data (as you said) or
using a new proposal, the PKRAM thing [a].
This way we wouldn't need a crash_device_shutdown(), but instead when
kernel is loading a crash kernel (through kexec -p) we can collect all
the necessary information that'll be passed to the crash kernel
(obviously that if we are collecting PCI topology information, we need
callbacks in the PCI hotplug add/del path to update this information).

[a]
https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/

Below, inline reply to Eric's last message.


On 15/11/2020 17:46, Eric W. Biederman wrote:
>> [...]
>> An MSI interrupt is a (DMA) write to the local APIC base address
>> 0xfeexxxxx which has the target CPU and control bits encoded in the
>> lower bits. The written data is the vector and more control bits.
>>
>> The only way to stop that is to shut it up at the PCI device level.
> 
> Or to write to magic chipset registers that will stop transforming DMA
> writes to 0xfeexxxxx into x86 interrupts.  With an IOMMU I know x86 has
> such registers (because the point of the IOMMU is to limit the problems
> rogue devices can cause).  Without an IOMMU I don't know if x86 has any
> such registers.  I remember that other platforms have an interrupt
> controller that does provide some level of control.  That x86 does not
> is what makes this an x86 specific problem.
> [...]
> Looking at patch 3/3 what this patchset does is an early disable of
> of the msi registers.  Which is mostly reasonable.  Especially as has
> been pointed out the only location the x86 vector and x86 cpu can
> be found is in the msi configuration registers.
> 
> That also seems reasonable.  But Bjorn's concern about not finding all
> devices in all domains does seem real.
> [...]
> So if we can safely and reliably disable DMA and MSI at the generic PCI
> device level during boot up I am all for it.
> 
> 
> How difficult would it be to tell the IOMMUs to stop passing traffic
> through in an early pci quirk?  The problem setup was apparently someone
> using the device directly from a VM.  So I presume there is an IOMMU
> in that configuration.

This is a good idea I think - we considered something like that in
theory while working the problem back in 2018, but given I'm even less
expert in IOMMU that I already am in PCI, the option was to go with the
PCI approach. And you are right, the original problem is a device in
PCI-PT to a VM, and a tool messing with the PF device in the SR-IOV (to
collect some stats) from the host side, through VFIO IIRC.

Anyway, we could split the problem in two after all the considerations
in the thread, I believe:

(1) If possible to set-up the IOMMU to prevent MSIs, by "blocking" the
DMA writes for PCI devices *until* PCI core code properly initialize the
devices, that'd handle the majority of the cases I guess (IOMMU usage is
quite common nowadays).

(2) Collecting PCI topology information in a running kernel and passing
that to the kdump kernel would allow us to disable the PCI devices MSI
capabilities, the only problem here is that I couldn't see how to do
that early enough, before the 'sti' executes, without relying in
early_quirks(). ACPI maybe? As per Bjorn comment when explaining the
limitations of early_quirks(), this problem seems not to be trivial.

I'm a bit against doing that in crash_kexec() for the reasons mentioned
in the thread, specially by Thomas and Eric - but if there's no other
way...maybe this is the way to go.

Cheers,


Guilherme


P.S. Fixed Gavin's bouncing address, sorry for that.
