Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C07BA5DF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbjJEQUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbjJEQRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:17:34 -0400
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 09:05:57 PDT
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3036938A0E
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 09:05:56 -0700 (PDT)
Received: from [10.0.0.60] (p5489d568.dip0.t-ipconnect.de [84.137.213.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id 3CF9C2BE94A;
        Thu,  5 Oct 2023 17:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1696521474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKIQ+5WRqMEmkeBfewWnr0AprEXOBYnCrEWLjTPEBvA=;
        b=TwUHa0GomZpauHLZMcjznoHkGmWlzvpaqRgWO6fvHGWxV7GTtBGDI5Ny3eFfMCQtz8tKpp
        J3KZbS2rvF6axIHMEEdbxHb+idagO80SYBL7+MH8138h+mRJFOtPVnESKeU0Bpw4EnNiyH
        m0rP4DodF4Oa+bIpSsO2s+XeD3GvbSiXDxpDcEfMttIChsm3Ga5amngiTQJY8NYe2os5X0
        iab1oAzAguJP1IrOIU3JSN8/wgZ/TBDmO5FNQ3vzphF8H5uzVIY07qb/S2GO/Qjc7/Y/wc
        FAobVGazWnseNPldntHsP5a9rE/i7qQ14r6a7JAG9YFjXpHvL2p8BZeC+SkrFg==
Message-ID: <923d8df0-1112-aca9-8289-c6e2457298cd@witt.link>
Date:   Thu, 5 Oct 2023 17:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        linux-pci@vger.kernel.org
References: <20231005153043.GA746943@bhelgaas>
From:   Thomas Witt <kernel@witt.link>
In-Reply-To: <20231005153043.GA746943@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/10/2023 17:30, Bjorn Helgaas wrote:
> On Thu, Oct 05, 2023 at 12:02:58PM +0300, Mika Westerberg wrote:
>> On Wed, Oct 04, 2023 at 05:23:24PM -0500, Bjorn Helgaas wrote:
>> ...
> 
>> The thing with TUXEDO is that on Thomas's system with mem_sleep=deep
>> this patch (without denylist) breaks the resume as he describes here:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=216877
>>
>> However, on exact same TUXEDO system with the same firmwares Werner is
>> not able to reproduce the issue with or without the patch. So I'm not
>> sure what to do and that's why I added denylist that should take effect
>> on Thomas' system when mem_sleep=deep is set but also work on the same
>> system without it.
>>
>> And since we have the denylist, I decided to add the ASUS there to avoid
>> accidentally breaking those too.
>> ...
> 
>>> I think there's still something we're missing.
>>>
>>> We restore the LTR config before restoring DEVCTL2 (including the LTR
>>> enable bit) and L1SS state.  I don't think we know the state of ASPM
>>> and L1SS at that point, do we?  Do you think there could be an issue
>>> there, too?
>>
>> AFAICT LTR does not affect until it is explicitly enabled and I don't
>> think many drivers actually program it (although we have some sort of
>> API for it at least for Intel LPSS devices).
> 
> I couldn't find anything in the spec that suggests LTR should be an
> issue.  I'm just grasping at straws here.
> 
> There's obviously *something* we're doing wrong because ASPM worked
> before suspend, so we should be able to get it to work after resume.
> 
> Could we learn anything by dumping config space of the problem devices
> before/after the suspend/resume and comparing them?
> 
> If we could figure out a difference between Werner's working TUXEDO
> and Thomas' non-working TUXEDO, that might be a hint, too.
> 
>> If you have suggestions, I'm all open. If I understand you would like
>> this to be done like:
>>
>>    - Drop the denylist
>>    - Add back the suspend/restore of L1SS
>>    - Ask everyone in this thread to try it out
>>
>> I can do that no problem but I guess that for the TUXEDO one (Thomas')
>> it probably is going to fail still.
> 
> Right, without the denylist, I expect Thomas' TUXEDO to fail, but I
> still hope we can figure out why.  If we just keep it on the denylist,
> that system will suffer from more power consumption than necessary,
> but only after suspend/resume.
> 
> A denylist seems like the absolute last resort.  In this case we don't
> know about anything *wrong* with those platforms; all we know is that
> our resume path doesn't work.  It's likely that it fails on other
> platforms we haven't heard about, too.
> 
> Bjorn

The best guess from Mika and David was a firmware issue, but I run the 
same Firmware revision as Werner. I even reflashed the Firmware, but 
that did not change anything:

Quoting David Box:
 > I agree that we should pursue an exception for your system. This is
 > looking like a firmware bug. One thing we did notice in the turbostat
 > results is your IRTL (Interrupt Response Time Limit) values are bogus:
 >
 > cpu6: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
 > cpu6: MSR_PKGC6_IRTL: 0x00008000 (valid, 0 ns)
 > cpu6: MSR_PKGC7_IRTL: 0x00008000 (valid, 0 ns)
 > cpu6: MSR_PKGC8_IRTL: 0x00008000 (valid, 0 ns)
 > cpu6: MSR_PKGC9_IRTL: 0x00008000 (valid, 0 ns)
 > cpu6: MSR_PKGC10_IRTL: 0x00008000 (valid, 0 ns)
 >
 > This is despite the PKGC configuration register showing that all
 > states are enabled:
 >
 > cpu6: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3, 
UNdemote-C1, demote-
C3, demote-C1, locked, pkg-cstate-limit=8 (unlimited))
 >
 > Firmware sets this.

Since I can't currently flash modified firmware on this computer, can 
those values be overridden from userspace?

