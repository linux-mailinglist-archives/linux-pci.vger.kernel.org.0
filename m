Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E150578C43C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjH2M1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjH2M0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:26:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB28E4A;
        Tue, 29 Aug 2023 05:26:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qaxnk-0000X0-Pd; Tue, 29 Aug 2023 14:26:32 +0200
Message-ID: <2a73e06c-46a4-64a1-a646-76b095b8b978@leemhuis.info>
Date:   Tue, 29 Aug 2023 14:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Content-Language: en-US, de-DE
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
        stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693311994;0440d1bc;
X-HE-SMSGID: 1qaxnk-0000X0-Pd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

What's the status here? From my point it looks like this regression that
was ported six weeks ago is still not fixed -- and it seems nothing has
happened since three weeks now. But maybe I'm just missing something,
that's why I'm asking.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 08.08.23 09:38, Jiaxun Yang wrote:
> 
> 
> 在 2023/8/6 22:30, Huacai Chen 写道:
>> Hi, Jiaxun,
>>
>> On Sun, Aug 6, 2023 at 10:20 AM Jiaxun Yang <jiaxun.yang@flygoat.com>
>> wrote:
>>>
>>>
>>> 在 2023/7/25 14:10, Jiaxun Yang 写道:
>>>> This is a partial revert of commit 8b3517f88ff2 ("PCI:
>>>> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>>>>
>>>> There are many MIPS based Loongson systems in wild that
>>>> shipped with firmware which does not set maximum MRRS properly.
>>>>
>>>> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
>>>> MRRS support is considered rare.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
>>>> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Ping?
>>> I expect this patch to go through PCI fixes tree.
>> Can we do it like this by modifying the existing loongson_mrrs_quirk()?
> 
> Hmm, I'm not sure this will work, since loongson_mrrs_quirk only run on
> bridges
> but the old quirk should run on every single device.
> 
> Thanks
> Jiaxun
> 
>>
>> static void loongson_mrrs_quirk(struct pci_dev *pdev)
>> {
>>          /*
>>           * Some Loongson PCIe ports have h/w limitations of maximum read
>>           * request size. They can't handle anything larger than this. So
>>           * force this limit on any devices attached under these ports.
>>           */
>>          struct pci_host_bridge *bridge =
>> pci_find_host_bridge(pdev->bus);
>>
>> #ifdef CONFIG_MIPS
>>          set_pcie_ports_to_mrrs_256_to_emulate_the_firmware_behavior();
>> #endif
>>
>>          bridge->no_inc_mrrs = 1;
>> }
>>
>>> Thanks
>>> - Jiaxun
>>>
>>>> ---
>>>> v2: Rename quirk name to: loongson_old_mrrs_quirk
>>>> ---
>>>>    drivers/pci/controller/pci-loongson.c | 38
>>>> +++++++++++++++++++++++++++
>>>>    1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-loongson.c
>>>> b/drivers/pci/controller/pci-loongson.c
>>>> index fe0f732f6e43..d0f68b102d10 100644
>>>> --- a/drivers/pci/controller/pci-loongson.c
>>>> +++ b/drivers/pci/controller/pci-loongson.c
>>>> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>                        DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>>>>
>>>> +#ifdef CONFIG_MIPS
>>>> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
>>>> +{
>>>> +     struct pci_bus *bus = pdev->bus;
>>>> +     struct pci_dev *bridge;
>>>> +     static const struct pci_device_id bridge_devids[] = {
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
>>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
>>>> +             { 0, },
>>>> +     };
>>>> +
>>>> +     /* look for the matching bridge */
>>>> +     while (!pci_is_root_bus(bus)) {
>>>> +             bridge = bus->self;
>>>> +             bus = bus->parent;
>>>> +             /*
>>>> +              * There are still some wild MIPS Loongson firmware won't
>>>> +              * set MRRS properly. Limiting MRRS to 256 as MIPS
>>>> Loongson
>>>> +              * comes with higher MRRS support is considered rare.
>>>> +              */
>>>> +             if (pci_match_id(bridge_devids, bridge)) {
>>>> +                     if (pcie_get_readrq(pdev) > 256) {
>>>> +                             pci_info(pdev, "limiting MRRS to 256\n");
>>>> +                             pcie_set_readrq(pdev, 256);
>>>> +                     }
>>>> +                     break;
>>>> +             }
>>>> +     }
>>>> +}
>>>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
>>>> loongson_old_mrrs_quirk);
>>>> +#endif
>>>> +
>>>>    static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>>>>    {
>>>>        pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
> 
