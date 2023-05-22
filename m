Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61DB70BC23
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjEVLqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjEVLqD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 07:46:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61885B6
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 04:45:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q13z9-0001tx-Pk; Mon, 22 May 2023 13:45:55 +0200
Message-ID: <844f3819-c819-bc55-0518-0b1b9651825f@leemhuis.info>
Date:   Mon, 22 May 2023 13:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
Content-Language: en-US, de-DE
To:     Koba Ko <koba.ko@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>, regressions@lists.linux.dev
References: <20230411204229.GA4168208@bhelgaas>
 <20230504152344.GA857680@bhelgaas>
 <CAJB-X+Vu8HJSNza896ELGrUKk64gPH=MjbYQMSxW6Xiw4MSiJw@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAJB-X+Vu8HJSNza896ELGrUKk64gPH=MjbYQMSxW6Xiw4MSiJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684755957;b027ccca;
X-HE-SMSGID: 1q13z9-0001tx-Pk
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05.05.23 08:56, Koba Ko wrote:
> On Thu, May 4, 2023 at 5:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Koba, Ajay, Tasev, Mark, Thomas, regressions list]
>> On Tue, Apr 11, 2023 at 03:42:29PM -0500, Bjorn Helgaas wrote:
>>> On Tue, Apr 11, 2023 at 08:32:04AM +0000, bugzilla-daemon@kernel.org wrote:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=217321
>>>> ...
>>>>         Regression: No
>>>>
>>>> [Symptom]
>>>> Intel cpu can't sleep deeper than pcˇ during long idle
>>>> ~~~
>>>> Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
>>>> 15.08   75.02   0.00    0.00    0.00    0.00    0.00
>>>> 15.09   75.02   0.00    0.00    0.00    0.00    0.00
>>>> ^CPkg%pc2       Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
>>>> 15.38   68.97   0.00    0.00    0.00    0.00    0.00
>>>> 15.38   68.96   0.00    0.00    0.00    0.00    0.00
>>>> ~~~
>>>> [How to Reproduce]
>>>> 1. run turbostat to monitor
>>>> 2. leave machine idle
>>>> 3. turbostat show cpu only go into pc2~pc3.
>>>>
>>>> [Misc]
>>>> The culprit are this
>>>> a7152be79b62) Revert "PCI/ASPM: Save L1 PM Substates Capability for
>>>> suspend/resume”
>>>>
>>>> if revert a7152be79b62, the issue is gone
>>>
>>> Relevant commits:
>>>
>>>   4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
>>>   a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")
>>>
>>> 4ff116d0d5fd appeared in v6.1-rc1.  Prior to 4ff116d0d5fd, ASPM L1 PM
>>> Substates configuration was not preserved across suspend/resume, so
>>> the system *worked* after resume, but used more power than expected.
>>>
>>> But 4ff116d0d5fd caused resume to fail completely on some systems, so
>>> a7152be79b62 reverted it.  With a7152be79b62 reverted, ASPM L1 PM
>>> Substates configuration is likely not preserved across suspend/resume.
>>> a7152be79b62 appeared in v6.2-rc8 and was backported to the v6.1
>>> stable series starting with v6.1.12.
>>>
>>> KobaKo, you don't mention any suspend/resume in this bug report, but
>>> neither patch should make any difference unless suspend/resume is
>>> involved.  Does the platform sleep as expected *before* suspend, but
>>> fail to sleep after resume?
>>>
>>> Or maybe some individual device was suspended via runtime power
>>> management, and that device lost its L1 PM Substates config?  I don't
>>> know if there's a way to disable runtime PM easily.
>>
>> Koba, per your bugzilla update, the issue happens even without
>> suspend/resume.  And we don't know whether some particular device is
>> responsible.
>>
>> But if we save/restore L1SS state, we can sleep deeper than PC3.  If
>> we don't preserve L1SS state, we can't.
>>
>> We definitely want to preserve the L1SS state, but we can't simply
>> apply 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
>> suspend/resume") again because it caused its own regressions [1,2,3]
>>
>> So somebody needs to figure out what was wrong with 4ff116d0d5fd, fix
>> it, verify that it doesn't cause the issues reported by Tasev, Thomas,
>> and Mark, and then we can apply it.
> 
> Good days, discussed with Kai-Heng and he mentioned  the GPU may not
> be pulled off the power.
> then the GPU needs L1ss to get into power saving.
> 
> I will investigate further on this way.

Did anything come our of this?

FWIW, I'm considering to drop this from the list of tracked regressions.
Yes, this is a regression, but it's caused by fix for another (worse)
regression -- so there is nothing we can do for now anyway (and Koba
seems motivated already to look properly into all of this). Or does
anyone consider this to be a problem?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
