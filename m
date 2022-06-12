Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572125479E0
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jun 2022 13:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiFLLME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jun 2022 07:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiFLLME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2022 07:12:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D533ED08;
        Sun, 12 Jun 2022 04:12:01 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o0LVf-0006Zc-A8; Sun, 12 Jun 2022 13:11:59 +0200
Message-ID: <d4ea2dd2-2e89-d3a2-ee5c-f64bb1b8f576@leemhuis.info>
Date:   Sun, 12 Jun 2022 13:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 216109] New: Steam Deck fails
 to boot when E820 entries clipped out of _CRS]
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220609224339.GA543225@bhelgaas>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220609224339.GA543225@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655032321;e51f73e7;
X-HE-SMSGID: 1o0LVf-0006Zc-A8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 10.06.22 00:43, Bjorn Helgaas wrote:
> New regression in v5.19-rc1.
> 
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> Subject: [Bug 216109] New: Steam Deck fails to boot when E820 entries clipped
> 	out of _CRS
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216109
> 
>            Summary: Steam Deck fails to boot when E820 entries clipped out
>                     of _CRS
>     Kernel Version: v5.19
> 
> Guilherme G. Piccoli reported that v5.18 boots fine on Steam Deck, but
> v5.19-rc1 does not.  He bisected it to 4c5e242d3e93 ("x86/PCI: Clip only host
> bridge windows for E820 regions") [1].
>
> A quirk similar to [2] that disables E820 clipping makes v5.19-rc1 work again.
> 
> The reason why v5.18 (which always does E820 clipping by default) works, while
> v5.19-rc1 (which also does E820 clipping on this platform) does not has not
> been explained yet.
> 
> [1] https://git.kernel.org/linus/4c5e242d3e93
> [2] https://git.kernel.org/linus/d341838d776a

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 4c5e242d3e93
#regzbot title x86/PCI/e820:Steam Deck fails to boot when E820 entries
clipped out of _CRS
#regzbot ignore-activity
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=216109

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replied to), as the kernel's
documentation call for; above page explains why this is important for
tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
