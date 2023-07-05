Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9574904B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 23:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGEVxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 17:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGEVxP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 17:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0D2199E;
        Wed,  5 Jul 2023 14:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC4A615C5;
        Wed,  5 Jul 2023 21:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19AAC433C7;
        Wed,  5 Jul 2023 21:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688593993;
        bh=3NpsjahjXhaBkqkTtFPAWiphr/jp7w5/2RAssyMlXws=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZoBQUB6LU3VB4G/xRvhmaA6J+ToJoZ7QUNWY/FUn0JTgPuTOwpeTmQExYNbIiGwbb
         OKi4Q9K0bGNaGC4K8Sp0aorFtWVZlH/A1loE7e8ShyJzGeglF3cMt4I3omAwVokCgK
         khVjb3JorAV6tLMDlHPKIqw/lYyatjwRhT1jMWCdG4bJTWfiOGen1T6wu4F1Hlqxe9
         AuEvBBgy6qcYie1Ln0Qrh4Q7jfc+fzmVajKPX9YPdiBwyKQF5d9s6ILRQBs7gYzC/d
         qDw2iZI5vY8maifGxUHM4FO8nJg0AHxGshluFqJWbNPtMOrxHPpP6vny3U4RX2Ynb5
         f4ZZ6MMQLRykQ==
Message-ID: <ad4a422b-dfba-c09b-e6e0-d9016300e91e@kernel.org>
Date:   Thu, 6 Jul 2023 06:53:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI: rcar-ep: Include linux/pci-epf.h instead of
 linux/pci-epc.h
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com
References: <20230705104824.174396-1-alistair@alistair23.me>
 <7536d9a3-4738-2bc2-e33e-d93347893865@kernel.org>
 <20230705114443.GA3555378@rocinante>
 <CAKmqyKMD99cDwfyY8BJ0_ExB+VXytT3VdeENwuw5ZyqAKq3X0w@mail.gmail.com>
 <20230705131546.GA333066@rocinante>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230705131546.GA333066@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/5/23 22:15, Krzysztof Wilczyński wrote:
> Hello,
> 
>>>>> pci-epc.h doesn't define the members of the pci_epf_header struct, so
>>>>> trying to access them results in errors like this:
>>>>>
>>>>>     error: invalid use of undefined type 'struct pci_epf_header'
>>>>>       167 |                 val = hdr->vendorid;
>>>>>
>>>>> Instead let's include pci-epf.h which not only defines the
>>>>> pci_epf_header but also includes pci-epc.h.
>>>
>>> [...]
>>>> It is odd that the the build bot did not detect this...
>>>
>>> This is a bit of a surprise to me too, especially since none of the usual
>>> bots pick this up, and I can't seem to find such a failure in the nightly
>>> CI logs either.
>>>
>>> Alistair, how did you stumble into this issue?  Also, which version or
>>> a tree would that be?
>>
>> I was building the kernel with this defconfig [1] inside OpenEmbedded.
>> It was the 6.4-rc7 kernel, specifically this one [2].
>>
>> 1: https://github.com/damien-lemoal/buildroot/blob/rockpro64_ep_v23/board/pine64/rockpro64_ep/linux.config
>> 2: https://github.com/damien-lemoal/linux/tree/rockpro64_ep_v23
> 
> Thank you!  Much appreciated.
> 
> So, the vanilla kernel does not have headers arranged like this custom tree
> that Damien maintains for his own needs, per:
> 
>   - https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/pci-epc.h
>   - https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/pci-epf.h
> 
> I suppose, there are some changes that break it for you, for example:
> 
>   https://github.com/damien-lemoal/linux/commit/c7aa8ddd76a141b975a097532050a76c6a58c436

Arg ! Yes, my bad ! The patches in this tree are a work-in-progress and I am
waiting for 6.5-rc1 to rebase everything and re-testing before posting them.
This is all tested using the rockchip-ep controller and I did not compile test
other controllers. I will make sure to do that before posting :)

Apologies for the noise.

> 
> So, I cannot take this patch as it would break vanilla kernel for us. :)
> 
> Try building using vanilla kernel, and see if that helps.
> 
> 	Krzysztof

-- 
Damien Le Moal
Western Digital Research

