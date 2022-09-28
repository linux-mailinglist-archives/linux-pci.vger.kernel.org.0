Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31B5ED7DD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiI1Iej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiI1IeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 04:34:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F6993784;
        Wed, 28 Sep 2022 01:34:11 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1odSW9-0006qO-R9; Wed, 28 Sep 2022 10:34:09 +0200
Message-ID: <2128c845-c3d0-e5af-0f08-7e28ac946e52@leemhuis.info>
Date:   Wed, 28 Sep 2022 10:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was:
 [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
 #forregzbot
Content-Language: en-US, de-DE
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
 <20220923192030.162412-1-ghalat@redhat.com>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220923192030.162412-1-ghalat@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664354052;d52024d7;
X-HE-SMSGID: 1odSW9-0006qO-R9
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 23.09.22 21:20, Grzegorz Halat wrote:
> Hi,
> 
> On Wed, Sep 16 2020 at 12:12, Stefan Bühler wrote:
>> this quirk breaks our serial ports PCIe card (i.e. we don't see any
>> output from the connected devices; no idea whether anything we send
>> reaches them):
> 
> I have the same problem, also with a PCI serial adapter from Oxford Semiconductor.
> I've bisected the kernel and it was introduced in b88bf6c3b6ff.
> When the system is booted with "pci=noioapicquirk" then the PCI card works fine.
> The CPU is Intel Xeon E5-2680 v3 @ 2.50GHz.
> 
> Sean, do you have any news about this issue?

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced b88bf6c3b6ff77948
#regzbot title boot interrupt quirk (also in 4.19.y) breaks serial ports
#regzbot ignore-activity
#regzbot backburner: known since 2020, original developer likely moved on

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
