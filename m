Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE382C5E23
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 00:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391939AbgKZX1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 18:27:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59446 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391933AbgKZX1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 18:27:39 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606433255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBVhEzk7XlmTATSUpd0ZUCNVKjbzeV4u/WeZy8k6QSE=;
        b=BUAsYzDmbBK9GP5mJvG6z312SvdOBxxt+8rHMij02fImgVcGGRpsyfI9TeoKSX92O25DR0
        N+E3C27Y5fX/whqcHjVqf2dp3CfojJ/QRo+H5zichl2CwMoDQAY3kizHBws9HLoJWDuv6T
        uWNIlekfTm/NfLQ4UcGpufXADZpToMEXxkcl8qbXDtF1x10n6JqfCcQF8ustciIZpUC009
        jSqxgIlLZxMXyJPT38BZptMi05Y7MmCjVsJssWiyKpyjbbkb4BQgAhtY2evBP7JU1xtTS9
        V2cCmr386UdKu56TaNURzzOlzSNC1xkHYUxbsuZtXhwPUw4f6/X1rKgB8xfBEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606433255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBVhEzk7XlmTATSUpd0ZUCNVKjbzeV4u/WeZy8k6QSE=;
        b=x1GABIcVYN9LeOdipeyJuWVbE15/hWvOTSR0jXplMvulINu6oNPfvgf1+YpMUXYCEX+fw8
        21I1ffpCrqOSlcCQ==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
In-Reply-To: <20201126012421.GA92582@shbuild999.sh.intel.com>
References: <20201119181904.149129-1-helgaas@kernel.org> <87v9dtk3j4.fsf@nanos.tec.linutronix.de> <20201126012421.GA92582@shbuild999.sh.intel.com>
Date:   Fri, 27 Nov 2020 00:27:34 +0100
Message-ID: <87eekfk8bd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Feng,

On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
> On Wed, Nov 25, 2020 at 01:46:23PM +0100, Thomas Gleixner wrote:
>> Now the more interesting question is why this needs to be a PCI quirk in
>> the first place. Can't we just disable the HPET based on family/model
>> quirks?
>> 
>> e0748539e3d5 ("x86/intel: Disable HPET on Intel Ice Lake platforms")
>> f8edbde885bb ("x86/intel: Disable HPET on Intel Coffee Lake H platforms")
>> fc5db58539b4 ("x86/quirks: Disable HPET on Intel Coffe Lake platforms")
>> 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail platform")

> I added this commit, and I can explain some for Baytrail. There was
> some discussion about the way to disable it:
> https://lore.kernel.org/lkml/20140328073718.GA12762@feng-snb/t/
>
> It uses PCI ID early quirk in the hope that later Baytrail stepping
> doesn't have the problem. And later on, there was official document
> (section 18.10.1.3 http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf)
> stating Baytrail's HPET halts in deep idle. So I think your way of 
> using CPUID to disable Baytrail HPET makes more sense.

Correct.

>> I might be missing something here, but in general on anything modern
>> HPET is mostly useless.
>
> IIUC, nowdays HPET's main use is as a clocksource watchdog monitor.

Plus for the TSC refined calibration, where it is really better than
anything else we have _if_ it is functional.

> And in one debug case, we found it still useful. The debug platform has 
> early serial console which prints many messages in early boot phase,
> when the HPET is disabled, the software 'jiffies' clocksource will
> be used as the monitor. Early printk will disable interrupt will
> printing message, and this could be quite long for a slow 115200
> device, and cause the periodic HW timer interrupt get missed, and
> make the 'jiffies' clocksource not accurate, which will in turn
> judge the TSC clocksrouce inaccurate, and disablt it. (Adding Rui,
> Len for more details)

Yes, that can happen. But OTOH, we should start to think about the
requirements for using the TSC watchdog.

I'm inclined to lift that requirement when the CPU has:

    1) X86_FEATURE_CONSTANT_TSC
    2) X86_FEATURE_NONSTOP_TSC
    3) X86_FEATURE_NONSTOP_TSC_S3
    4) X86_FEATURE_TSC_ADJUST
    
    5) At max. 4 sockets

After two decades of horrors we're finally at a point where TSC seems to
be halfways reliable and less abused by BIOS tinkerers. TSC_ADJUST was
really key as we can now detect even small modifications reliably and
the important point is that we can cure them as well (not pretty but
better than all other options).

The only nasty one in the list above is #5 because AFAIK there is still
no architecural guarantee for TSCs being synchronized on machines with
more than 4 sockets. I might be wrong, but then nobody told me.

The only reason I hate to disable HPET upfront at least during boot is
that HPET is the best mechanism for the refined TSC calibration. PMTIMER
sucks because it's slow and wraps around pretty quick.

So we could do the following even on platforms where HPET stops in some
magic PC? state:

  - Register it during early boot as clocksource

  - Prevent the enablement as clockevent and the chardev hpet timer muck

  - Prevent the magic PC? state up to the point where the refined
    TSC calibration is finished.

  - Unregister it once the TSC has taken over as system clocksource and
    enable the magic PC? state in which HPET gets disfunctional.

Hmm?

Thanks,

        tglx



