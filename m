Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BF3B5C98
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhF1KoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:44:19 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:56305 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231935AbhF1KoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:44:19 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3199E3200583;
        Mon, 28 Jun 2021 06:41:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 06:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=H
        kiABmcpdd+XPtsn45ho4rW61e2JbdQGEpKI4/22nz0=; b=LRtfGc/bhjzNQ3llu
        pknM/Qs9NGO+zJUFqJ75TY/sk92o2PAzjy63AniIdOfwTQHOr/kfqrodGMICcnBb
        PNCA3yF4dxto2FRo7qQ+ZxWa5HGftN+9k4uGusU11e6ovUXOiLI2ALq8cziQoup8
        5FdLxlvBAebaZXQtZMHpE00qOtOtMWkUE48jsevDl73g1Yp3gDFZD8IaOg/gW0KG
        PcYgi2Y1mam6yJW/Ek7ICPajIolQMSpCAmIO6V8Re/Og/FSZgHjcy6+YAz9OWFiV
        mR0CRObmHpBewKN62ta24MJdZ8XrW2oweK9/5BgXBzV0yvR+7jrsRxgG8+6yDuhr
        sh/MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=HkiABmcpdd+XPtsn45ho4rW61e2JbdQGEpKI4/22n
        z0=; b=DJffh9N/MGAx1s952aSH18AS+6bBK3/mhBXcN0bfdeRf6887fpNH2Hjyp
        7+QChISvwmBkbjr6/kEiHRI77wkxC3YPhnZr3nkB241ThzdUCsGC7NiMC7P99t1m
        7ZBCO2L2g3hL9K/GBx6lC2LB4zEmgGG2v9ArnukrwkVIvMQoV8G4jpu2H+BJRjCN
        KSvxHefZMtw6/zS+NXKownfb+PnkN/PMRWMvQpxaUnPVKQkEZoAa0kyUdKjP72kz
        +01PnBgp8v9QntX4wUH6M54hkuiE8QwQY/qzv6AgB7tZqd/Fc8YJLvaLv+RV0Bol
        b+boST6x7TYXyVDdDVXmcK3WJyMEQ==
X-ME-Sender: <xms:cKfZYNTt3N9aTMOuKcLLoHHx8x5qYZ0Os_NUGkZEFqmYBJOmEoCCyA>
    <xme:cKfZYGzXIy7-NulXY8m3eCSQ5RwlIYtAEAwWflZpneXrb4FtK_zW7TtgPYR3QUx04
    0DvMBkLyQdCwbKmeVk>
X-ME-Received: <xmr:cKfZYC0Zvg94gm2LcVCBoUSDTxCGOd5CkVmOQhQq4RrFUnz6-LOxg7FTLqR6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeekieeghfffhfeuuddtvdegleeltdejgeevfeekteetheefhffg
    vefhueetkeefieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:cKfZYFCS7v7uzP6BaM9oVkPmduehmcBPiGbLFaomHwPAXWIf3IXfEw>
    <xmx:cKfZYGjwC2Hm4s79oxDr3Jxcq1gKBiqdAOI8cqs1qjJhcAXhBtu7yw>
    <xmx:cKfZYJpo2VzPTuM9D1wvI-5KuInoyrYbWB2eW4ZdZrUXz_ABg_V08g>
    <xmx:cKfZYHuH6KnK4T3mYljIKNxa2KiS7ZUZDRAIcuPPZa43D45dqHKoCQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:41:49 -0400 (EDT)
Subject: Re: [PATCH V4 2/4] PCI: Move loongson pci quirks to quirks.c
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-3-chenhuacai@loongson.cn>
 <bcde3fa6-9292-3f59-cb39-30ed0f311291@flygoat.com>
 <CAAhV-H4rK5uGtDDJDg02i-gNpMSzYLGO5pLUsAYfjUWYtJPi3w@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <1b42d46f-8332-204e-62d6-d0903d5a0af7@flygoat.com>
Date:   Mon, 28 Jun 2021 18:41:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4rK5uGtDDJDg02i-gNpMSzYLGO5pLUsAYfjUWYtJPi3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/6/28 下午6:38, Huacai Chen 写道:
> Hi, Jiaxun,
>
> On Mon, Jun 28, 2021 at 6:13 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>
>> 在 2021/6/28 下午6:10, Huacai Chen 写道:
>>> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
>>> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
>>> but LoongArch-base Loongson uses ACPI, but the driver in drivers/
>>> pci/controller/pci-loongson.c is FDT-only. So move the quirks to
>>> quirks.c where can be shared by all architectures.
>>>
>>> LoongArch is a new RISC ISA, mainline support will come soon, and
>>> documentations are here (in translation):
>>>
>>> https://github.com/loongson/LoongArch-Documentation
>> Probably you should guard it with CONFIG_MACH_LOONGSON64 now and add
>> CONFIG_LOONGARCH
>> once LOONGARCH code is mainlined.
> These quirks won't match non-Loongson platforms (because they are
> matched by pci ids), so I think that is unnecessary.
Are you sure?
As I saw
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID
It will slow down boot progress on all systems.

Thanks.

- Jiaxun
>
> Huacai
>> Thanks.
>>
>> - Jiaxun
>>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>    drivers/pci/controller/pci-loongson.c | 69 ---------------------------
>>>    drivers/pci/quirks.c                  | 69 +++++++++++++++++++++++++++
>>>    2 files changed, 69 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>>> index 48169b1e3817..88066e9db69e 100644
>>> --- a/drivers/pci/controller/pci-loongson.c
>>> +++ b/drivers/pci/controller/pci-loongson.c
>>> @@ -12,15 +12,6 @@
>>>
>>>    #include "../pci.h"
>>>
>>> -/* Device IDs */
>>> -#define DEV_PCIE_PORT_0      0x7a09
>>> -#define DEV_PCIE_PORT_1      0x7a19
>>> -#define DEV_PCIE_PORT_2      0x7a29
>>> -
>>> -#define DEV_LS2K_APB 0x7a02
>>> -#define DEV_LS7A_CONF        0x7a10
>>> -#define DEV_LS7A_LPC 0x7a0c
>>> -
>>>    #define FLAG_CFG0   BIT(0)
>>>    #define FLAG_CFG1   BIT(1)
>>>    #define FLAG_DEV_FIX        BIT(2)
>>> @@ -32,66 +23,6 @@ struct loongson_pci {
>>>        u32 flags;
>>>    };
>>>
>>> -/* Fixup wrong class code in PCIe bridges */
>>> -static void bridge_class_quirk(struct pci_dev *dev)
>>> -{
>>> -     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>>> -}
>>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> -                     DEV_PCIE_PORT_0, bridge_class_quirk);
>>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> -                     DEV_PCIE_PORT_1, bridge_class_quirk);
>>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> -                     DEV_PCIE_PORT_2, bridge_class_quirk);
>>> -
>>> -static void system_bus_quirk(struct pci_dev *pdev)
>>> -{
>>> -     /*
>>> -      * The address space consumed by these devices is outside the
>>> -      * resources of the host bridge.
>>> -      */
>>> -     pdev->mmio_always_on = 1;
>>> -     pdev->non_compliant_bars = 1;
>>> -}
>>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> -                     DEV_LS2K_APB, system_bus_quirk);
>>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> -                     DEV_LS7A_CONF, system_bus_quirk);
>>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> -                     DEV_LS7A_LPC, system_bus_quirk);
>>> -
>>> -static void loongson_mrrs_quirk(struct pci_dev *dev)
>>> -{
>>> -     struct pci_bus *bus = dev->bus;
>>> -     struct pci_dev *bridge;
>>> -     static const struct pci_device_id bridge_devids[] = {
>>> -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
>>> -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
>>> -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
>>> -             { 0, },
>>> -     };
>>> -
>>> -     /* look for the matching bridge */
>>> -     while (!pci_is_root_bus(bus)) {
>>> -             bridge = bus->self;
>>> -             bus = bus->parent;
>>> -             /*
>>> -              * Some Loongson PCIe ports have a h/w limitation of
>>> -              * 256 bytes maximum read request size. They can't handle
>>> -              * anything larger than this. So force this limit on
>>> -              * any devices attached under these ports.
>>> -              */
>>> -             if (pci_match_id(bridge_devids, bridge)) {
>>> -                     if (pcie_get_readrq(dev) > 256) {
>>> -                             pci_info(dev, "limiting MRRS to 256\n");
>>> -                             pcie_set_readrq(dev, 256);
>>> -                     }
>>> -                     break;
>>> -             }
>>> -     }
>>> -}
>>> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
>>> -
>>>    static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
>>>                                unsigned int devfn, int where)
>>>    {
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 22b2bb1109c9..dee4798a49fc 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -205,6 +205,75 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
>>>    DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
>>>                                PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
>>>
>>> +/* Loongson-related quirks */
>>> +#define DEV_PCIE_PORT_0      0x7a09
>>> +#define DEV_PCIE_PORT_1      0x7a19
>>> +#define DEV_PCIE_PORT_2      0x7a29
>>> +
>>> +#define DEV_LS2K_APB 0x7a02
>>> +#define DEV_LS7A_CONF        0x7a10
>>> +#define DEV_LS7A_LPC 0x7a0c
>>> +
>>> +/* Fixup wrong class code in PCIe bridges */
>>> +static void loongson_bridge_class_quirk(struct pci_dev *dev)
>>> +{
>>> +     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>>> +}
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> +                     DEV_PCIE_PORT_0, loongson_bridge_class_quirk);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> +                     DEV_PCIE_PORT_1, loongson_bridge_class_quirk);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> +                     DEV_PCIE_PORT_2, loongson_bridge_class_quirk);
>>> +
>>> +static void loongson_system_bus_quirk(struct pci_dev *pdev)
>>> +{
>>> +     /*
>>> +      * The address space consumed by these devices is outside the
>>> +      * resources of the host bridge.
>>> +      */
>>> +     pdev->mmio_always_on = 1;
>>> +     pdev->non_compliant_bars = 1;
>>> +}
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> +                     DEV_LS2K_APB, loongson_system_bus_quirk);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> +                     DEV_LS7A_CONF, loongson_system_bus_quirk);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>> +                     DEV_LS7A_LPC, loongson_system_bus_quirk);
>>> +
>>> +static void loongson_mrrs_quirk(struct pci_dev *dev)
>>> +{
>>> +     struct pci_bus *bus = dev->bus;
>>> +     struct pci_dev *bridge;
>>> +     static const struct pci_device_id bridge_devids[] = {
>>> +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
>>> +             { 0, },
>>> +     };
>>> +
>>> +     /* look for the matching bridge */
>>> +     while (!pci_is_root_bus(bus)) {
>>> +             bridge = bus->self;
>>> +             bus = bus->parent;
>>> +             /*
>>> +              * Some Loongson PCIe ports have a h/w limitation of
>>> +              * 256 bytes maximum read request size. They can't handle
>>> +              * anything larger than this. So force this limit on
>>> +              * any devices attached under these ports.
>>> +              */
>>> +             if (pci_match_id(bridge_devids, bridge)) {
>>> +                     if (pcie_get_readrq(dev) > 256) {
>>> +                             pci_info(dev, "limiting MRRS to 256\n");
>>> +                             pcie_set_readrq(dev, 256);
>>> +                     }
>>> +                     break;
>>> +             }
>>> +     }
>>> +}
>>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
>>> +
>>>    /*
>>>     * The Mellanox Tavor device gives false positive parity errors.  Disable
>>>     * parity error reporting.

