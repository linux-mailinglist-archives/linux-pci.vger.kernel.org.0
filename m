Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2B6DF519
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDLMYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjDLMYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 08:24:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB976BC
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 05:24:31 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pmZWX-0006e2-3C; Wed, 12 Apr 2023 14:24:29 +0200
Message-ID: <ba7e422f-9468-cb3f-f5da-ccefdd018a2a@leemhuis.info>
Date:   Wed, 12 Apr 2023 14:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
Content-Language: en-US, de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230411204229.GA4168208@bhelgaas>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230411204229.GA4168208@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681302271;f1e22d48;
X-HE-SMSGID: 1pmZWX-0006e2-3C
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A quick note before the usual boilerplate:

Bjorn, you asked KobaKo some questions, but didn't CC him -- and the
comment apparently did not make it to the bugzilla ticket. Something
wrong there? I wish I could CC him, but due to bugzilla's "never show
your email address to logged out users" policies I can't. I added a
comment to the ticket pointing him to your mail.

[TLDR for the rest of the mail: adding this reported to the regression
tracking]

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 11.04.23 22:42, Bjorn Helgaas wrote:
> On Tue, Apr 11, 2023 at 08:32:04AM +0000, bugzilla-daemon@kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=217321
>> ... 
>>         Regression: No
>>
>> [Symptom]
>> Intel cpu can't sleep deeper than pcˇ during long idle
>> ~~~
>> Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
>> 15.08   75.02   0.00    0.00    0.00    0.00    0.00
>> 15.09   75.02   0.00    0.00    0.00    0.00    0.00
>> ^CPkg%pc2       Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
>> 15.38   68.97   0.00    0.00    0.00    0.00    0.00
>> 15.38   68.96   0.00    0.00    0.00    0.00    0.00
>> ~~~
>> [How to Reproduce]
>> 1. run turbostat to monitor
>> 2. leave machine idle
>> 3. turbostat show cpu only go into pc2~pc3.
>>
>> [Misc]
>> The culprit are this 
>> a7152be79b62) Revert "PCI/ASPM: Save L1 PM Substates Capability for
>> suspend/resume”
>>
>> if revert a7152be79b62, the issue is gone
> 
> Relevant commits:
> 
>   4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
>   a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")
> 
> 4ff116d0d5fd appeared in v6.1-rc1.  Prior to 4ff116d0d5fd, ASPM L1 PM
> Substates configuration was not preserved across suspend/resume, so
> the system *worked* after resume, but used more power than expected.
> 
> But 4ff116d0d5fd caused resume to fail completely on some systems, so
> a7152be79b62 reverted it.  With a7152be79b62 reverted, ASPM L1 PM
> Substates configuration is likely not preserved across suspend/resume.
> a7152be79b62 appeared in v6.2-rc8 and was backported to the v6.1
> stable series starting with v6.1.12.
> 
> KobaKo, you don't mention any suspend/resume in this bug report, but
> neither patch should make any difference unless suspend/resume is
> involved.  Does the platform sleep as expected *before* suspend, but
> fail to sleep after resume?
> 
> Or maybe some individual device was suspended via runtime power
> management, and that device lost its L1 PM Substates config?  I don't
> know if there's a way to disable runtime PM easily.
> 
> The lspci output attached to the bugzilla was not collected as root,
> so it lacks the ASPM-related information.  Can you do this again with
> "sudo lspci -vv"?
#regzbot introduced: a7152be79b62
https://bugzilla.kernel.org/show_bug.cgi?id=217321
#regzbot title: PCI/ASPM: Intel system does not sleep deeper than PC3
(caused by a revert applied to fixes another regression)
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
