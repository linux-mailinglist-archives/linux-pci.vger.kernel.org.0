Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABAA2F02E0
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 19:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbhAISca (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jan 2021 13:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbhAISc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jan 2021 13:32:29 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BED2C06179F;
        Sat,  9 Jan 2021 10:31:49 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AFAC722708;
        Sat,  9 Jan 2021 19:31:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610217107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2UDMWK0VwuZPNdNMdX3dZBlVkph5iJ84buMQxQDKJM=;
        b=pfz+72KfFX4HT4+7K8S0iv9FJlA9Svw3oYFTiOk8xQ66f+xjCPTjTCklPymrOsc3tFq+Cb
        4JDBFOquyB8XIYHPERtRZM2MBCZLxCM+EQn72icWFAna7v5AuSF882hM9uNA+0eOj9F/Nr
        Kw8Nct5JoJ03ahEeJtzLGJugp0aD8W4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 Jan 2021 19:31:46 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
In-Reply-To: <20210108212021.GA1472277@bjorn-Precision-5520>
References: <20210108212021.GA1472277@bjorn-Precision-5520>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <642eb96b495f5ad7d2d14410fedcd1ad@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Am 2021-01-08 22:20, schrieb Bjorn Helgaas:
> On Wed, Dec 30, 2020 at 07:53:17PM +0100, Michael Walle wrote:
>> The Intel i210 doesn't work if the Expansion ROM BAR overlaps with
>> another BAR. Networking won't work at all and once a packet is sent 
>> the
>> netdev watchdog will bite:
> 
> 
> 1) Is this a regression?  It sounds like you don't know for sure
> because earlier kernels don't support your platform.

Whats the background of the question? The board is offially supported
since 5.8. I doubt that the code responsible to not touch the ExpROM
BAR in pci_std_update_resource() were recently changed/added; the
comment refers to a mail from 2005. So no I don't think it is a
regression per se.

It is just that some combination of hardware and firmware will program
the BARs in away so that this bug is triggered. And chances of this
happing are very unlikely.

Do we agree that it should be irrelevant how the firmware programs and
enables the BARs in this case? I.e. you could "fix" u-boot to match the
way linux will assign addresses to the BARs. But that would just work
around the real issue here. IMO.

> 2) Can you open a bugzilla at https://bugzilla.kernel.org and attach
> the complete dmesg and "sudo lspci -vv" output?  I want to see whether
> Linux is assigning something incorrectly or this is a consequence of
> some firmware initialization.

Sure, but you wouldn't even see the error with "lspci -vv" because
lspci will just show the mapping linux assigned to it. But not whats
written to the actual BAR for the PCI card. I'll also include a
"lspci -xx". I've enabled CONFIG_PCI_DEBUG, too.

https://bugzilla.kernel.org/show_bug.cgi?id=211105

> 3) If the Intel i210 is defective in how it handles an Expansion ROM
> that overlaps another BAR, a quirk might be the right fix. But my
> guess is the device is working correctly per spec and there's
> something wrong in how firmware/Linux is assigning things.  That would
> mean we need a more generic fix that's not a quirk and not tied to the
> Intel i210.

Agreed, but as you already stated (and I've also found that in the PCI
spec) the Expansion ROM address decoder can be shared by the other BARs
and it shouldn't matter as long as the ExpROM BAR is disabled, which is
the case here.

I've included the Intel ML, maybe the Intel guys can comment on that.

>> [   89.059374] ------------[ cut here ]------------
>> [   89.064019] NETDEV WATCHDOG: enP2p1s0 (igb): transmit queue 0 timed 
>> out
>> [   89.070681] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:443 
>> dev_watchdog+0x3a8/0x3b0
>> [   89.078989] Modules linked in:
>> [   89.082053] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       
>>   5.11.0-rc1-00020-gc16f033804b #289
>> [   89.091574] Hardware name: Kontron SMARC-sAL28 (Single PHY) on 
>> SMARC Eval 2.0 carrier (DT)
>> [   89.099870] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>> [   89.105900] pc : dev_watchdog+0x3a8/0x3b0
>> [   89.109923] lr : dev_watchdog+0x3a8/0x3b0
>> [   89.113945] sp : ffff80001000bd50
>> [   89.117268] x29: ffff80001000bd50 x28: 0000000000000008
>> [   89.122602] x27: 0000000000000004 x26: 0000000000000140
>> [   89.127935] x25: ffff002001c6c000 x24: ffff002001c2b940
>> [   89.133267] x23: ffff8000118c7000 x22: ffff002001c6c39c
>> [   89.138600] x21: ffff002001c6bfb8 x20: ffff002001c6c3b8
>> [   89.143932] x19: 0000000000000000 x18: 0000000000000010
>> [   89.149264] x17: 0000000000000000 x16: 0000000000000000
>> [   89.154596] x15: ffffffffffffffff x14: 0720072007200720
>> [   89.159928] x13: 0720072007740775 x12: ffff80001195b980
>> [   89.165260] x11: 0000000000000003 x10: ffff800011943940
>> [   89.170592] x9 : ffff800010100d44 x8 : 0000000000017fe8
>> [   89.175924] x7 : c0000000ffffefff x6 : 0000000000000001
>> [   89.181255] x5 : 0000000000000000 x4 : 0000000000000000
>> [   89.186587] x3 : 00000000ffffffff x2 : ffff8000118eb908
>> [   89.191919] x1 : 84d8200845006900 x0 : 0000000000000000
>> [   89.197251] Call trace:
>> [   89.199701]  dev_watchdog+0x3a8/0x3b0
>> [   89.203374]  call_timer_fn+0x38/0x208
>> [   89.207049]  run_timer_softirq+0x290/0x540
>> [   89.211158]  __do_softirq+0x138/0x404
>> [   89.214831]  irq_exit+0xe8/0xf8
>> [   89.217981]  __handle_domain_irq+0x70/0xc8
>> [   89.222091]  gic_handle_irq+0xc8/0x2b0
>> [   89.225850]  el1_irq+0xb8/0x180
>> [   89.228999]  arch_cpu_idle+0x18/0x40
>> [   89.232587]  default_idle_call+0x70/0x214
>> [   89.236610]  do_idle+0x21c/0x290
>> [   89.239848]  cpu_startup_entry+0x2c/0x70
>> [   89.243783]  secondary_start_kernel+0x1a0/0x1f0
>> [   89.248332] ---[ end trace 1687af62576397bc ]---
>> [   89.253350] igb 0002:01:00.0 enP2p1s0: Reset adapter
> 
> This entire splat is overkill.  The useful part is what somebody who
> trips over this might google for.  Strip out the "cut here", the
> timestamps, the register dump, and the last 6-8 lines of the call
> trace.

This seem to be different from subsys to subsys, but whatever ;)

-michael
