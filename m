Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B777670EC68
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 06:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjEXEP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 00:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjEXEPz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 00:15:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4388119
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 21:15:50 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1fud-00017U-RP; Wed, 24 May 2023 06:15:47 +0200
Message-ID: <28b9d910-c485-5ecb-e2ac-1c735a4cfcb9@leemhuis.info>
Date:   Wed, 24 May 2023 06:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
Content-Language: en-US, de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>
References: <ZG00zhXPMigJIISI@bhelgaas>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZG00zhXPMigJIISI@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684901750;d5719135;
X-HE-SMSGID: 1q1fud-00017U-RP
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23.05.23 23:49, Bjorn Helgaas wrote:
> On Mon, May 22, 2023 at 01:45:55PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 05.05.23 08:56, Koba Ko wrote:
>>> On Thu, May 4, 2023 at 5:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> [+cc Koba, Ajay, Tasev, Mark, Thomas, regressions list]
>>>> On Tue, Apr 11, 2023 at 03:42:29PM -0500, Bjorn Helgaas wrote:
>>>>> On Tue, Apr 11, 2023 at 08:32:04AM +0000, bugzilla-daemon@kernel.org wrote:
>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=217321
>>>>>> ...
>>>>>>         Regression: No
>>>>>>
>>>>>> [Symptom]
>>>>>> Intel cpu can't sleep deeper than pcˇ during long idle
>>>>>> ~~~
>>>>>> Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
>>>>>> 15.08   75.02   0.00    0.00    0.00    0.00    0.00
>>>>>> 15.09   75.02   0.00    0.00    0.00    0.00    0.00
>>>>>> ^CPkg%pc2       Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
>>>>>> 15.38   68.97   0.00    0.00    0.00    0.00    0.00
>>>>>> 15.38   68.96   0.00    0.00    0.00    0.00    0.00
>>>>>> ~~~
>>>>>> [How to Reproduce]
>>>>>> 1. run turbostat to monitor
>>>>>> 2. leave machine idle
>>>>>> 3. turbostat show cpu only go into pc2~pc3.
>>>>>>
>>>>>> [Misc]
>>>>>> The culprit are this
>>>>>> a7152be79b62) Revert "PCI/ASPM: Save L1 PM Substates Capability for
>>>>>> suspend/resume”
>>>>>>
>>>>>> if revert a7152be79b62, the issue is gone
>>>>>
>>>>> Relevant commits:
>>>>>
>>>>>   4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
>>>>>   a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")
>>>>>
>>>>> 4ff116d0d5fd appeared in v6.1-rc1.  Prior to 4ff116d0d5fd, ASPM L1 PM
>>>>> Substates configuration was not preserved across suspend/resume, so
>>>>> the system *worked* after resume, but used more power than expected.
>>>>>
>>>>> But 4ff116d0d5fd caused resume to fail completely on some systems, so
>>>>> a7152be79b62 reverted it.  With a7152be79b62 reverted, ASPM L1 PM
>>>>> Substates configuration is likely not preserved across suspend/resume.
>>>>> a7152be79b62 appeared in v6.2-rc8 and was backported to the v6.1
>>>>> stable series starting with v6.1.12.
>>>>>
>>>>> KobaKo, you don't mention any suspend/resume in this bug report, but
>>>>> neither patch should make any difference unless suspend/resume is
>>>>> involved.  Does the platform sleep as expected *before* suspend, but
>>>>> fail to sleep after resume?
>>>>>
>>>>> Or maybe some individual device was suspended via runtime power
>>>>> management, and that device lost its L1 PM Substates config?  I don't
>>>>> know if there's a way to disable runtime PM easily.
>>>>
>>>> Koba, per your bugzilla update, the issue happens even without
>>>> suspend/resume.  And we don't know whether some particular device is
>>>> responsible.
>>>>
>>>> But if we save/restore L1SS state, we can sleep deeper than PC3.  If
>>>> we don't preserve L1SS state, we can't.
>>>>
>>>> We definitely want to preserve the L1SS state, but we can't simply
>>>> apply 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
>>>> suspend/resume") again because it caused its own regressions [1,2,3]
>>>>
>>>> So somebody needs to figure out what was wrong with 4ff116d0d5fd, fix
>>>> it, verify that it doesn't cause the issues reported by Tasev, Thomas,
>>>> and Mark, and then we can apply it.
>>>
>>> Good days, discussed with Kai-Heng and he mentioned  the GPU may not
>>> be pulled off the power.
>>> then the GPU needs L1ss to get into power saving.
>>>
>>> I will investigate further on this way.
>>
>> Did anything come our of this?
>>
>> FWIW, I'm considering to drop this from the list of tracked regressions.
>> Yes, this is a regression, but it's caused by fix for another (worse)
>> regression -- so there is nothing we can do for now anyway (and Koba
>> seems motivated already to look properly into all of this). Or does
>> anyone consider this to be a problem?
> 
> I would drop this from the regression list.
> 
> Yes, bz 217321 is a bug, and yes, 4ff116d0d5fd is a partial fix for
> it, but 4ff116d0d5fd causes worse problems (it breaks resume from
> suspend) than just living with bz 217321, which is a "mere" power
> consumption issue.

Thx for confirming and putting it in better words.

#regzbot inconclusive: can't be solved for now, as this is a regression
causes by a fix for a regression (see list/bz for details)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
