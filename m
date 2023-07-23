Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ECF75E194
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjGWLNL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWLNK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 07:13:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D2810C3;
        Sun, 23 Jul 2023 04:13:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qNX1N-0006H6-2e; Sun, 23 Jul 2023 13:13:05 +0200
Message-ID: <d8471890-feb8-8953-a97d-5fc6b1f22d65@leemhuis.info>
Date:   Sun, 23 Jul 2023 13:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: PCI: Loongson: 8b3517f88ff2 breaks PCIe on some system
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>, jiaxun.yang@flygoat.com,
        Aurelien Jarno <aurel32@debian.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Loongarch <loongarch@lists.linux.dev>
References: <871f22f4-c456-db15-3466-085971bd1221@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <871f22f4-c456-db15-3466-085971bd1221@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690110788;91fa5781;
X-HE-SMSGID: 1qNX1N-0006H6-2e
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23.07.23 04:03, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> After 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases") backported to stable, we have received multiple regression reports including one from Debian build farm[1] that some systems failed to initialize some PCIe devices.
>>
>> I was able to reproduce on one of my Loongson-3A4000+7A system. It seems like the root cause is firmware on those systems didn't set MRRS properly but 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases") assumed firmware's maximum MRRS is always valid.
>>
>> [1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1035587
> 
> See Bugzilla for the full thread.
> 
> The linked Debian BTS entry have debugging details on this regression
> (boot log, cpuinfo, and lspci).
> 
> Anyway, I'm adding this regression to regzbot:
> 
> #regzbot introduced: 8b3517f88ff298 https://bugzilla.kernel.org/show_bug.cgi?id=217680
> #regzbot title: LS7A MRRS quirk fails to initialize PCIe devices
> #regzbot link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1035587

FWIW & TWIMC, a fix for this is in the works already afaics:

#regzbot monitor:
https://lore.kernel.org/all/20230718133259.2867432-1-jiaxun.yang@flygoat.com/
#regzbot fix: pci: loongson: Workaround MIPS firmware MRRS settings

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
