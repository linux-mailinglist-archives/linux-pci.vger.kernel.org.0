Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB178E5A7
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 07:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbjHaFb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 01:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHaFb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 01:31:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0EE0;
        Wed, 30 Aug 2023 22:31:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C968E5C0121;
        Thu, 31 Aug 2023 01:31:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 31 Aug 2023 01:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1693459882; x=1693546282; bh=C0U2k3Y3eqQI0vlN7gboUUSrag4xms6QohF
        0rT+ZSQs=; b=F5koVE/t46yxrl6HZeLTsTNJVN/MAxe7p+JRGJB8RKWNN1Ga3Y6
        tONRQLxkFcjkTkHv//+XccJQC9w6h7CUVTx4t04uBkzpxZVAOVtQ+mb1d+QAnS8j
        OTQu9ibReqqyBezr2gTUL5Zglv4OTUZ1ieiFZE+eC1/QF73H14lRNUcWdhzM1gQo
        /0udtdr1fvUxiFarfCdw34uKwHWWYilUFtKFwxgBt+zpQ/bmYd0REmysSOITS1b9
        MEoGXmkPJ/Mpu+al0KrWixPOVVGcAA1uaziiER1TUDosoN0tj8ezr7ffBGdTUSV3
        xnZkcVtOYg+WIFuh5q/d0omYav5nfkkKZ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693459882; x=1693546282; bh=C0U2k3Y3eqQI0vlN7gboUUSrag4xms6QohF
        0rT+ZSQs=; b=aQnSn43RAgfDZBJghJEi4q5l3hYrsRoB4qb/SW13UgtBsz/Xufz
        CInBMk0WKHq/Lkfsct1fXw4xEodi9+o/oEHxPkolgADcfoq5PuLYpjWcyXhmTd3U
        STzOeDneyLTRCLuqxdlgtPTHjm4ZCuuINPWv9txwEfUu61nPda43doWEAxPgo5pD
        Iwc8Mi1otj8qXekmfo+t5RnacB33XeQjc2HmpG3l7pGtU8BdRbH8u/KR4UCt12JC
        qJpPhIYMIyctamS75GUCxhI5HAFwBHBBbhY46B3fdG3hO12yrj8wg/EXrKpBlhVB
        J0XA3NtPJ0ypZg+/k+1ikKmkLCI+TGqqbWw==
X-ME-Sender: <xms:qiXwZDp4_zGy-tIE_dci5x6Hti6KRZGZleMSQe1N8Fba_P7CRiFWUw>
    <xme:qiXwZNpoODlTI5WtlTUB5pOYYOYROEtnN9i4diFk8qWenZWrcfudNd8V917P77vMY
    sTbjmK5q6owmZ5vgPM>
X-ME-Received: <xmr:qiXwZAPZkLdzfyZW4rA4w73dAaI2_jamlbKIa7xhPR4A5eZ_mObPKrX5L94KZOZdPmUr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefledgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdefieevgeffledutddvgfdufeeggeeuleffteekheduudet
    iedvjefgfeffvefgnecuffhomhgrihhnpehlvggvmhhhuhhishdrihhnfhhopdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:qiXwZG6ETDlnQkB5l85QA5LQLKvAPzViVGUA3WhuunUcPMuCu8RA1A>
    <xmx:qiXwZC77Otrv9KxUsdUWMtVH5bxuzWR6By31RvElBfefOlftGrCwQw>
    <xmx:qiXwZOjiFtz0h8ffnZSo2NCAg5u4U80RWfq3zAbCNcUbI626BnFqLw>
    <xmx:qiXwZPtfg5aDvtoJ4I5Ysi4j8wvm1KH35kMd-UtFdxBUDr2_TeTYqg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 01:31:19 -0400 (EDT)
Message-ID: <8534e568-30f8-dad2-ec7b-40ce45250172@flygoat.com>
Date:   Thu, 31 Aug 2023 13:31:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
        stable@vger.kernel.org
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <2a73e06c-46a4-64a1-a646-76b095b8b978@leemhuis.info>
Content-Language: en-GB
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <2a73e06c-46a4-64a1-a646-76b095b8b978@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/29 20:26, Linux regression tracking (Thorsten Leemhuis) 写道:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> What's the status here? From my point it looks like this regression that
> was ported six weeks ago is still not fixed -- and it seems nothing has
> happened since three weeks now. But maybe I'm just missing something,
> that's why I'm asking.

Hi Thorsten,

Thanks for reaching back, unfortunately there is no progress so far.

+ Huacai, what's your opinion here? I do think this fix is in best shape for
now.

Thanks
- Jiaxun

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> On 08.08.23 09:38, Jiaxun Yang wrote:
>>
>> 在 2023/8/6 22:30, Huacai Chen 写道:
>>> Hi, Jiaxun,
>>>
>>> On Sun, Aug 6, 2023 at 10:20 AM Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> wrote:
>>>>
>>>> 在 2023/7/25 14:10, Jiaxun Yang 写道:
>>>>> This is a partial revert of commit 8b3517f88ff2 ("PCI:
>>>>> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>>>>>
>>>>> There are many MIPS based Loongson systems in wild that
>>>>> shipped with firmware which does not set maximum MRRS properly.
>>>>>
>>>>> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
>>>>> MRRS support is considered rare.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
>>>>> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
>>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>> Ping?
>>>> I expect this patch to go through PCI fixes tree.
>>> Can we do it like this by modifying the existing loongson_mrrs_quirk()?
>> Hmm, I'm not sure this will work, since loongson_mrrs_quirk only run on
>> bridges
>> but the old quirk should run on every single device.
>>
>> Thanks
>> Jiaxun
>>
>>> static void loongson_mrrs_quirk(struct pci_dev *pdev)
>>> {
>>>           /*
>>>            * Some Loongson PCIe ports have h/w limitations of maximum read
>>>            * request size. They can't handle anything larger than this. So
>>>            * force this limit on any devices attached under these ports.
>>>            */
>>>           struct pci_host_bridge *bridge =
>>> pci_find_host_bridge(pdev->bus);
>>>
>>> #ifdef CONFIG_MIPS
>>>           set_pcie_ports_to_mrrs_256_to_emulate_the_firmware_behavior();
>>> #endif
>>>
>>>           bridge->no_inc_mrrs = 1;
>>> }
>>>
>>>> Thanks
>>>> - Jiaxun
>>>>
>>>>> ---
>>>>> v2: Rename quirk name to: loongson_old_mrrs_quirk
>>>>> ---
>>>>>     drivers/pci/controller/pci-loongson.c | 38
>>>>> +++++++++++++++++++++++++++
>>>>>     1 file changed, 38 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pci-loongson.c
>>>>> b/drivers/pci/controller/pci-loongson.c
>>>>> index fe0f732f6e43..d0f68b102d10 100644
>>>>> --- a/drivers/pci/controller/pci-loongson.c
>>>>> +++ b/drivers/pci/controller/pci-loongson.c
>>>>> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>>     DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>>                         DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>>>>>
>>>>> +#ifdef CONFIG_MIPS
>>>>> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
>>>>> +{
>>>>> +     struct pci_bus *bus = pdev->bus;
>>>>> +     struct pci_dev *bridge;
>>>>> +     static const struct pci_device_id bridge_devids[] = {
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
>>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
>>>>> +             { 0, },
>>>>> +     };
>>>>> +
>>>>> +     /* look for the matching bridge */
>>>>> +     while (!pci_is_root_bus(bus)) {
>>>>> +             bridge = bus->self;
>>>>> +             bus = bus->parent;
>>>>> +             /*
>>>>> +              * There are still some wild MIPS Loongson firmware won't
>>>>> +              * set MRRS properly. Limiting MRRS to 256 as MIPS
>>>>> Loongson
>>>>> +              * comes with higher MRRS support is considered rare.
>>>>> +              */
>>>>> +             if (pci_match_id(bridge_devids, bridge)) {
>>>>> +                     if (pcie_get_readrq(pdev) > 256) {
>>>>> +                             pci_info(pdev, "limiting MRRS to 256\n");
>>>>> +                             pcie_set_readrq(pdev, 256);
>>>>> +                     }
>>>>> +                     break;
>>>>> +             }
>>>>> +     }
>>>>> +}
>>>>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
>>>>> loongson_old_mrrs_quirk);
>>>>> +#endif
>>>>> +
>>>>>     static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>>>>>     {
>>>>>         pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);

