Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3B6475B6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 19:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLHSld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 13:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLHSla (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 13:41:30 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80884248;
        Thu,  8 Dec 2022 10:41:29 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3Lpn-00007C-NX; Thu, 08 Dec 2022 19:41:27 +0100
Message-ID: <dec37fc9-1a69-74dc-d613-d806c732ffd7@leemhuis.info>
Date:   Thu, 8 Dec 2022 19:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=5d_Bug=c2=a0216782_-_resume_from_susp?=
 =?UTF-8?Q?end_broken_on_Asus_UX305FA?=
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Bjorn Helgaas <bhelgaas@google.com>
References: <5e8317f7-170a-588b-7a94-e0a546fbc9f3@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tasev Nikola <tasev.stefanoska@skynet.be>
In-Reply-To: <5e8317f7-170a-588b-7a94-e0a546fbc9f3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670524889;762026d0;
X-HE-SMSGID: 1p3Lpn-00007C-NX
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 08.12.22 15:43, Thorsten Leemhuis wrote:
> 
> I noticed a regression report in bugzilla.kernel.org. It afaics needs
> more debugging, but I nevertheless want add it to the tracking.

Bjorn, if you have a minute, could you please take a quick look at this
please: https://bugzilla.kernel.org/show_bug.cgi?id=216782

To quote

```
> Starting from kernel 6.1-rc1 for the first time in 8 years the
> resume
> from suspend is broken on my Asus UX305FA. After resume the sysrsq keys
> do not work and a hard reset is the only solution for shutdown, the
> screen is black, keyboard and mouse do not respond.
> 
> After bisecting the first bad commit is:
> 
> commit a47126ec29f538e1197862919f94d3b6668144a4
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Sep 9 15:24:57 2022 -0500
> 
>     PCI/PTM: Cache PTM Capability offset
>     
>     Cache the PTM Capability offset instead of searching for it every time we
>     enable/disable PTM or save/restore PTM state.  No functional change
>     intended.
```

The reporter has some trouble with the bisection (see the ticket for
details), but it looks a bit like the problems are actually caused by
that patch or something in that series.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
