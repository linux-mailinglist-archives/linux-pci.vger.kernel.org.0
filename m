Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AF3B5CD1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhF1LBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 07:01:12 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40011 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhF1LBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 07:01:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B3C3532007E8;
        Mon, 28 Jun 2021 06:58:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 28 Jun 2021 06:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=i
        TcWVY/wnBITLJ0Gufco5Qt4Tlkdq43XN1BXzTrJ8nY=; b=GFhKUll2uypzaf6La
        Uat1diVIIvwoNzu1JLY7Pry0gMqQ20g7QKoQCEwPWREEIHTUtO+C61+khNhHh2rh
        Q6aqPsbgVSnK4RKB48lUeLN7Nh4+YeSZudlGLdxZ4n/A81szq2LRXeFPaSb8IxV8
        k0Ej5g9crdSlwlDJO8Yo8FLUXAVYdQZ841QJ2Hl3tTEdK1KOQNGyZG8uv/OKyksL
        mJYS/UJMLYur0LWyHe3OTh0d5tmnuZp+08pOYLluzCJS9S3sr3sJfmBFvTSQ2EI5
        Yd/a8MAwqOPdQ4OEPt5BUGuyCZaxXrlgnL+puC/ytg/V/IeC2vtpAvy2qwW6HvI7
        CIkYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=iTcWVY/wnBITLJ0Gufco5Qt4Tlkdq43XN1BXzTrJ8
        nY=; b=h4mFPtaFJ1irDvawDHI+eAYrjoFU7DonlmJqoACXss1qeYlJTbzYgHqlK
        X8LRRKuQXn6Jt2VIhV7yGIT/SLUuUqhwSc7h2/riOTHIy1zfAZz0wUBnBTIm5uHB
        y2YLWK3ahNbp8j7dp7k+gQiQyivG4XoqZRjzwUI6dGlnP+4Zv/FbNN+jKIBnAbhu
        HwOXCnmuwsXfN3hrw3QJ9lOcsNKUKW1ucXLZm0rZS2c6YTobeD4y4ZqaISKErdpx
        2BqEP1nT4iK90WDpM1gNRfinEcuVQ/1UHKqcdV7/UmySFc6clEBkwYvyOQXt5dUY
        W7ohG/hkC4ROeTytSOLcowCFwMM0Q==
X-ME-Sender: <xms:ZKvZYHNTmhhEf4lNlsAnKEw4WWhxQIgtxuXHAWbSmq5zKjiZ30iqlg>
    <xme:ZKvZYB_2qBDcazl2Pw-uOjXdQSpeYi1MLZZTVvm0LO1lkHeSATjnT3W5NhVbqF6eB
    b1V4mOtQ5nwMKQPi0U>
X-ME-Received: <xmr:ZKvZYGT9BKPTXJtumzLwkPJBv9Xxf9043jPeAnlVdXp9lUr7i7FGaR1JhLe6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefggfeikeejhefgkeegudffudeftefhveejleelleegheevieff
    udejudfgtedvjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ZKvZYLsn23nfCJC2x7w6L4ThDSa_GS589FVcxlz2gDLSMlx8g09rrw>
    <xmx:ZKvZYPewqc6YSri4P7xHFEQnYrz-VrvDT1JyugbgoEVZoSssaHwSSg>
    <xmx:ZKvZYH3f2EkvioHdypRV3HUjDK5ag1KCjcjJp0uSXD7EZLqxougSXQ>
    <xmx:ZavZYL7XfA09Ix6HCDEtSfJ6YmBVZaPl1htAh438SucwpCStEpWXxg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:58:42 -0400 (EDT)
Subject: Re: [PATCH V4 2/4] PCI: Move loongson pci quirks to quirks.c
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-3-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <0ff3245f-c5b7-d470-fd63-d000769e3e93@flygoat.com>
Date:   Mon, 28 Jun 2021 18:58:40 +0800
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
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks.
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

