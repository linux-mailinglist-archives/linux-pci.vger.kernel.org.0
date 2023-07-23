Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97575E0CC
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGWJYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGWJYI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 05:24:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E611A4;
        Sun, 23 Jul 2023 02:24:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qNVJt-0000EZ-PK; Sun, 23 Jul 2023 11:24:05 +0200
Message-ID: <01e617d6-c7e0-8f46-6f04-94961251f2a0@leemhuis.info>
Date:   Sun, 23 Jul 2023 11:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Kernel 6.5-rc2: system crash on suspend bisected
Content-Language: en-US, de-DE
To:     Woody Suwalski <terraluna977@gmail.com>, imammedo@redhat.com,
        bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690104247;995ef5b1;
X-HE-SMSGID: 1qNVJt-0000EZ-PK
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 20.07.23 05:36, Woody Suwalski wrote:
> 
> Laptop shows a kernel crash trace after a first suspend to ram, on a
> second attempt to suspend it becomes frozen solid. This is 100%
> repeatable with a 6.5-rc2 kernel, not happening with a 6.4 kernel - see
> the attached dmesg output.
> 
> I have bisected the kernel uilds and it points to :
> [40613da52b13fb21c5566f10b287e0ca8c12c4e9] PCI: acpiphp: Reassign
> resources on bridge if necessary
> 
> Reversing this patch seems to fix the kernel crash problem on my laptop.
> 
> Happy to test some proper fix patches...
> 

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 40613da52b13fb21c5566f10b287e0ca8c12c
#regzbot title PCI: acpiphp: Oops on first attempt to suspend, freeze on
second
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
