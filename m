Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0637969AEE2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 16:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBQPDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 10:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBQPDS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 10:03:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBF14996;
        Fri, 17 Feb 2023 07:02:52 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pT2F8-0005uQ-Lu; Fri, 17 Feb 2023 16:01:46 +0100
Message-ID: <189043d8-1ea7-4264-7f86-3e28b99cc7da@leemhuis.info>
Date:   Fri, 17 Feb 2023 16:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <d5d8d106-acce-e20c-827d-1b37de2b2188@posteo.de>
 <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
 <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
In-Reply-To: <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676646174;09ac0f8e;
X-HE-SMSGID: 1pT2F8-0005uQ-Lu
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12.01.23 15:48, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> On 11.01.23 23:11, Julian Groß wrote:
>>
>> when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
>> system seemingly randomly freezes due to the file system being set to
>> read-only due to an issue with my NVMe controller.
>> The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
>>
>> Through network logging I am able to catch the issue:
> 
> [...]
> 
> #regzbot ^introduced v5.19..v6.0-rc7
> #regzbot title nvme: system partially freezes with "nvme controller is down"
> #regzbot ignore-activity

Stop tracking this for now:

#regzbot inconclusive: stalled and might be a hw issue
#regzbot ignore-activity

For details see:

https://lore.kernel.org/all/81b5b28e-33fb-48ca-9e84-7574d5596bfb@posteo.de/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


