Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3556FFB11
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjEKUJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKUJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 16:09:16 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFE910EC;
        Thu, 11 May 2023 13:09:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pxCb5-0000QH-Hy; Thu, 11 May 2023 22:09:07 +0200
Message-ID: <c45f3a39-2103-6beb-ae6d-5bdf070854e0@leemhuis.info>
Date:   Thu, 11 May 2023 22:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
 <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
 <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
 <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
 <a8b29619-f1da-4cb9-a5bd-a396b52e159f@roeck-us.net>
 <20230508134414.GCZFj8rieNwF1AOerB@fat_crate.local>
 <MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
In-Reply-To: <MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1683835755;0525ef7d;
X-HE-SMSGID: 1pxCb5-0000QH-Hy
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11.05.23 21:51, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> +stable, Sasha
> 
>>> Together with this patch there are now at least two regressions if
>>> -rc1 whch could have been avoided and may impact testability on
>>> affected systems.
>>
>> Are you saying that this patch which fixes s2idle on some random box
>> should've gone to Linus *immediately*?
>>
>> And read my mail again:
>>
>> "Some fixes need longer testing because there have been cases where
>> a fix breaks something else."
>>
>> So yes, I disagree with rushing fixes immediately. If they're obvious
>> - whatever that means - then sure but not all of them are such.
>>
>> --
> 
> Unfortunately, it looks like the broken commit got backported into 6.1.28,
> but the fix still isn't in Linus' tree.
> 
> Sasha,
> 
> Can you please pick up
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=23a5b8bb022c1e071ca91b1a9c10f0ad6a0966e9
> for 6.1.29 to fix the regression?

FWIW, the stable team afaics usually does not fix anything in stable
trees before it's fixed in mainline. IOW: that fix now quickly needs to
go to Linus to get it quickly fixed in 6.1.y.

Side note: I'll soon post a rewritten section of 'Prioritize work on
fixing regressions' which is part of
Documentation/process/handling-regressions.rst. It among others will
cover this case:

```
* Whenever you want to swiftly resolve a regression that recently also
made it into a proper mainline, stable, or longterm release, fix it
quickly in mainline; when appropriate thus involve Linus to fast-track
the fix. That's because the stable team normally does neither revert nor
fix any changes that cause a regression in mainline, too.
```

Ciao, Thorsten
