Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495DB3B5C50
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhF1KQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:16:20 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:44275 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231935AbhF1KQT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:16:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4DA3432006F2;
        Mon, 28 Jun 2021 06:13:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Jun 2021 06:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=f
        ITsaayCW02tFGJn6zMSs4a3QAqWNAou6do+JT2E5AA=; b=hcnNqPjbrlbyqqN7F
        yNUQRp4iPlROBSyfKH7z6zf62xCgBgN4cWzdjVte9/v1j844FY4rg2fTyPv9fJQd
        zW9U01AIrlXDPW17ruhJv/SVekuTmbNviSlCnY3C+qcwa12OeQkWB+vwCE58ZUS9
        EFXf1CF0XsCo8uN47WF3VtfvhG5k2srKqISnjFxSXhE2LuVw2S0tx2WPo9VVYBGS
        uqNy1arJeIJWwyuT+YWE2LaIZofDn1iNIth/fiN6xmy1DDJd0pFrwZmqYzXhHMXL
        Uc/h36COhd0SwSgVRLrfWK+i+4qH2hY7lVDXBlKpEvKN4+nDJP7tsvnU2K0bc7Og
        cE5Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=fITsaayCW02tFGJn6zMSs4a3QAqWNAou6do+JT2E5
        AA=; b=HIS0LVzH8Vp0Rpi834gOeEg6YMbxlKPYBGMh75S8988fgg/5tNPXmEZBn
        2PCoEhHnS1LDPyx1e3/dXpV8LYrF0Q2LyVH1FofnhbA+Xou7F99K8QwL7d+qJXza
        2L3fI2CCi31A7JZ+hbHmKT8eK4FGix26sJ75H4MZAHuLlASPrwGMHMfmqJpD18j1
        a0MYowzdA+E5owamLAu12nkJuprPtY235QF9vNrWa+RvfUZsLaT7FCKLba1gMgDm
        UlfONqFSSFmo9vSFUsLDu1y/Nj2RzoX3+45kw73Ma/m/o+v3NgvRXLPkPhAi48Re
        q78yvoZO7wlfhyUtnZf/BwuVwGeLg==
X-ME-Sender: <xms:4KDZYFUkhRmBlYl3IQa9triqJ4Q0aCkA0HG6YPEsU7N1MQ79mU4vyA>
    <xme:4KDZYFnypvhw_IE4iTNVzuqkQhtDB3KG4oUM_PGVrYSA7G89bEnEVFkw-GNwvycJe
    q9Ij2AngmIklW1Xu0k>
X-ME-Received: <xmr:4KDZYBZ-PWxZrUVxytrgjzekyH-IFDGNWXE6xC9SF84VQEMYvRkx0Le9_2K7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefggfeikeejhefgkeegudffudeftefhveejleelleegheevieff
    udejudfgtedvjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:4KDZYIXfoepX6bMsO0fKDSsGohVvGEbHh1nixcOGOOty9-ODPR4HEA>
    <xmx:4KDZYPltnfb-otIKq7XXoyBgfwhJ73CC7INar_4vMt998KNv2CJU2Q>
    <xmx:4KDZYFclSELY99ijdckSA9JR3p2U0fjDoXzEM-_SlXe18soxIkgAQw>
    <xmx:4KDZYNg-ua6YTqvVyFV-HlXfvJPpbadimsWYH9qwVRq6uZR88OtEGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:13:50 -0400 (EDT)
Subject: Re: [PATCH V4 2/4] PCI: Move loongson pci quirks to quirks.c
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-3-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <bcde3fa6-9292-3f59-cb39-30ed0f311291@flygoat.com>
Date:   Mon, 28 Jun 2021 18:13:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628101027.1372370-3-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



ÔÚ 2021/6/28 ÏÂÎç6:10, Huacai Chen Ð´µÀ:
> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
> but LoongArch-base Loongson uses ACPI, but the driver in drivers/
> pci/controller/pci-loongson.c is FDT-only. So move the quirks to
> quirks.c where can be shared by all architectures.
>
> LoongArch is a new RISC ISA, mainline support will come soon, and
> documentations are here (in translation):
>
> https://github.com/loongson/LoongArch-Documentation

Probably you should guard it with CONFIG_MACH_LOONGSON64 now and add 
CONFIG_LOONGARCH
once LOONGARCH code is mainlined.

Thanks.

- Jiaxun

>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/pci/controller/pci-loongson.c | 69 ---------------------------
>   drivers/pci/quirks.c                  | 69 +++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 48169b1e3817..88066e9db69e 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -12,15 +12,6 @@
>   
>   #include "../pci.h"
>   
> -/* Device IDs */
> -#define DEV_PCIE_PORT_0	0x7a09
> -#define DEV_PCIE_PORT_1	0x7a19
> -#define DEV_PCIE_PORT_2	0x7a29
> -
> -#define DEV_LS2K_APB	0x7a02
> -#define DEV_LS7A_CONF	0x7a10
> -#define DEV_LS7A_LPC	0x7a0c
> -
>   #define FLAG_CFG0	BIT(0)
>   #define FLAG_CFG1	BIT(1)
>   #define FLAG_DEV_FIX	BIT(2)
> @@ -32,66 +23,6 @@ struct loongson_pci {
>   	u32 flags;
>   };
>   
> -/* Fixup wrong class code in PCIe bridges */
> -static void bridge_class_quirk(struct pci_dev *dev)
> -{
> -	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> -}
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_PCIE_PORT_0, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_PCIE_PORT_1, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_PCIE_PORT_2, bridge_class_quirk);
> -
> -static void system_bus_quirk(struct pci_dev *pdev)
> -{
> -	/*
> -	 * The address space consumed by these devices is outside the
> -	 * resources of the host bridge.
> -	 */
> -	pdev->mmio_always_on = 1;
> -	pdev->non_compliant_bars = 1;
> -}
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_LS2K_APB, system_bus_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_LS7A_CONF, system_bus_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_LS7A_LPC, system_bus_quirk);
> -
> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> -{
> -	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> -	static const struct pci_device_id bridge_devids[] = {
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> -		{ 0, },
> -	};
> -
> -	/* look for the matching bridge */
> -	while (!pci_is_root_bus(bus)) {
> -		bridge = bus->self;
> -		bus = bus->parent;
> -		/*
> -		 * Some Loongson PCIe ports have a h/w limitation of
> -		 * 256 bytes maximum read request size. They can't handle
> -		 * anything larger than this. So force this limit on
> -		 * any devices attached under these ports.
> -		 */
> -		if (pci_match_id(bridge_devids, bridge)) {
> -			if (pcie_get_readrq(dev) > 256) {
> -				pci_info(dev, "limiting MRRS to 256\n");
> -				pcie_set_readrq(dev, 256);
> -			}
> -			break;
> -		}
> -	}
> -}
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> -
>   static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
>   				unsigned int devfn, int where)
>   {
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 22b2bb1109c9..dee4798a49fc 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -205,6 +205,75 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
>   DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
>   				PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
>   
> +/* Loongson-related quirks */
> +#define DEV_PCIE_PORT_0	0x7a09
> +#define DEV_PCIE_PORT_1	0x7a19
> +#define DEV_PCIE_PORT_2	0x7a29
> +
> +#define DEV_LS2K_APB	0x7a02
> +#define DEV_LS7A_CONF	0x7a10
> +#define DEV_LS7A_LPC	0x7a0c
> +
> +/* Fixup wrong class code in PCIe bridges */
> +static void loongson_bridge_class_quirk(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, loongson_bridge_class_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, loongson_bridge_class_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, loongson_bridge_class_quirk);
> +
> +static void loongson_system_bus_quirk(struct pci_dev *pdev)
> +{
> +	/*
> +	 * The address space consumed by these devices is outside the
> +	 * resources of the host bridge.
> +	 */
> +	pdev->mmio_always_on = 1;
> +	pdev->non_compliant_bars = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS2K_APB, loongson_system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_CONF, loongson_system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_LPC, loongson_system_bus_quirk);
> +
> +static void loongson_mrrs_quirk(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +		/*
> +		 * Some Loongson PCIe ports have a h/w limitation of
> +		 * 256 bytes maximum read request size. They can't handle
> +		 * anything larger than this. So force this limit on
> +		 * any devices attached under these ports.
> +		 */
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(dev) > 256) {
> +				pci_info(dev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(dev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +
>   /*
>    * The Mellanox Tavor device gives false positive parity errors.  Disable
>    * parity error reporting.

