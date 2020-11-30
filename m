Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8352C8DF5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgK3TVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 14:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgK3TVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 14:21:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF91C0617A7;
        Mon, 30 Nov 2020 11:21:05 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606764063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgxfE2qR/kOL08XhMsKwlLXx45lwxwxlrvVIxPlKFnE=;
        b=Lq8je92wLPMiaatqTgkuheZ/cTMHUonwEd3DTDpcP1pOCITytuAhp4mzYCjs3fKDEuQkLJ
        ltUXYuc67piQCmn1RUU/3+1M0nRPFbByycb6vlNEQxRVQ+t7cTrQ/H/G9/r7bRzInZAaKB
        /bnISXW9Y9KXjMbCvFTQzrepTaUjo68/jdy9G7acWhMT2SO8+Yf+PQ/lOa07TJfazQcrX0
        Vlgm8cVVNmzlwpuiLGqwlm9x5vQxRt31Q6B0FBZrvmQ8+5v9VlTtrYh6//vntLeNH7mjp9
        GgXjaM8fOiOs8bOpP1TxT1j5q8NaUlIQial/s/87lfIX6xkfN6kFJRw9K8F/bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606764063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgxfE2qR/kOL08XhMsKwlLXx45lwxwxlrvVIxPlKFnE=;
        b=rIOd37H98PtLMva+Z1+DG7tYeSCn1N/ikON1u1N8d7D79T+hTwush6qGR0ZFj5lj9sjUCV
        iYv9AQhGUYbqwwCQ==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
In-Reply-To: <20201127061131.GB105524@shbuild999.sh.intel.com>
References: <20201119181904.149129-1-helgaas@kernel.org> <87v9dtk3j4.fsf@nanos.tec.linutronix.de> <20201126012421.GA92582@shbuild999.sh.intel.com> <87eekfk8bd.fsf@nanos.tec.linutronix.de> <20201127061131.GB105524@shbuild999.sh.intel.com>
Date:   Mon, 30 Nov 2020 20:21:03 +0100
Message-ID: <87eekairc0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Feng,

On Fri, Nov 27 2020 at 14:11, Feng Tang wrote:
> On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
>> On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
>> Yes, that can happen. But OTOH, we should start to think about the
>> requirements for using the TSC watchdog.
>> 
>> I'm inclined to lift that requirement when the CPU has:
>> 
>>     1) X86_FEATURE_CONSTANT_TSC
>>     2) X86_FEATURE_NONSTOP_TSC
>
>>     3) X86_FEATURE_NONSTOP_TSC_S3
> IIUC, this feature exists for several generations of Atom platforms,
> and it is always coupled with 1) and 2), so it could be skipped for
> the checking.

Yes, we can ignore that bit as it's not widely available and not
required to solve the problem.

>>     4) X86_FEATURE_TSC_ADJUST
>>     
>>     5) At max. 4 sockets
>> 
>> The only reason I hate to disable HPET upfront at least during boot is
>> that HPET is the best mechanism for the refined TSC calibration. PMTIMER
>> sucks because it's slow and wraps around pretty quick.
>> 
>> So we could do the following even on platforms where HPET stops in some
>> magic PC? state:
>> 
>>   - Register it during early boot as clocksource
>> 
>>   - Prevent the enablement as clockevent and the chardev hpet timer muck
>> 
>>   - Prevent the magic PC? state up to the point where the refined
>>     TSC calibration is finished.
>> 
>>   - Unregister it once the TSC has taken over as system clocksource and
>>     enable the magic PC? state in which HPET gets disfunctional.
>
> This looks reasonable to me. 
>
> I have thought about lowering the hpet rating to lower than PMTIMER, so it
> still contributes in early boot phase, and fades out after PMTIMER is
> initialised.

Not a good idea. pm_timer is initialized before the refined calibration
finishes.

Thanks,

        tglx
