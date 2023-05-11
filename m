Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA66FFC18
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbjEKVu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKVu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 17:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDBC5BB4;
        Thu, 11 May 2023 14:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A625651FF;
        Thu, 11 May 2023 21:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4118C433EF;
        Thu, 11 May 2023 21:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683841851;
        bh=K4WgEsYyO81HfMwY9MP7UqaYLOk4som61w9X0fncpTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1Ma5etn8qiIyII92l350T7Kxgywc1UZMcdJDZ2SWzXv7qCxL0vkrwEik9Ckw0b3R
         y4RzWkniCey3x25t9y8sL53vQsyQOPgoZGp6qcUyM5RzCDeIh3JuuJAf260dmjuiRK
         5ClqUIV2tXrig9u8DpnkR7LofOh5EleiEC+9GVo4dzp5MIdCJLMkGDePR4uKax8IZQ
         6SyelbV1jhY8YtiB2Nl1zV6K057I6tPJlkCleXot1Z9gIwrC7nfnWqiOiVnYs8T4bP
         mTL9PAA3GFA2MeA04BmoIOiN6tcWVLmJCGQb8V+wIEDEFk/OD2FOUDoXes4W31fHgZ
         Op9Zwe0tIvwwg==
Date:   Thu, 11 May 2023 17:50:46 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
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
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <ZF1jNnETIZD97XmQ@sashalap>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
 <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
 <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
 <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
 <a8b29619-f1da-4cb9-a5bd-a396b52e159f@roeck-us.net>
 <20230508134414.GCZFj8rieNwF1AOerB@fat_crate.local>
 <MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 07:51:42PM +0000, Limonciello, Mario wrote:
>[AMD Official Use Only - General]
>
>+stable, Sasha
>
>> > Together with this patch there are now at least two regressions if
>> > -rc1 whch could have been avoided and may impact testability on
>> > affected systems.
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
>Unfortunately, it looks like the broken commit got backported into 6.1.28,
>but the fix still isn't in Linus' tree.
>
>Sasha,
>
>Can you please pick up
>https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=23a5b8bb022c1e071ca91b1a9c10f0ad6a0966e9
>for 6.1.29 to fix the regression?

Happily, once it lands upstream :)

-- 
Thanks,
Sasha
