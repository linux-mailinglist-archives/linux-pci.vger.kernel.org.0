Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABCB3F990E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhH0MdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 08:33:07 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33749 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245117AbhH0MdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 08:33:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A1BEA320092B;
        Fri, 27 Aug 2021 08:32:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 27 Aug 2021 08:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=T
        QPZ1l9/n/aAKI5dFX0XaKSsdV7Pi7+J36UBSmDSPLQ=; b=yQAK4eo1ZO8AK95K1
        q7HfbKKKXW/qcQNwvkhx2lKRgHbm02De+KDejEzXMvFQ/MAYgeEMkzDgaoPEbvhX
        D6UecH9NwYewphyrrx5jZkhG2fbEfsWNduF2pWlmktMMJ2NQww2VmuxuCFBDtAHw
        DPm4cOtguIXLEp3OWkLvEDa3XF/INpjh5BL11Wj0/Z5isV2o06gkxBEdAMcOotXY
        1Pt8xFLHwsGb+5RuBSY/Qru68J0zaSa9FbnHa+kVx1rbJIPBj3HnbveHyig9Fhm6
        WJQzmT6HW2Eyw40/anBU77xbDsMiGxbTUFWk/0An1anPMdYfk4fai634BMedvga7
        lrnrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=TQPZ1l9/n/aAKI5dFX0XaKSsdV7Pi7+J36UBSmDSP
        LQ=; b=avc+xnSCCAQ8cu2rMcBTyzsjo7vTNCEha+fJtArU+eNyblY0d14axKVrv
        FMHU9AY5FnC99bLOF+ZTXa1yYh5ptzcw1goP7tlHQQOpJ3Sq7td3xLC5AC5Rnf4r
        QiUiVwrymNz8kZ8ia+fDde9LHIXPV03UAq6EOtLWNHOmCOf1xwK06r/FdlX6BJ5/
        6tJ7dEq8qgaV7nsGUZJ9NU0pHM/CJ1t6/p4HtqhIiehOQ6zG/PrNo+fJxf/YuFBF
        sH+zEkfEvXedMxLo8DqcUfzeacyOVrGgeOjCvqw12H9Y7ahU+EqRku9ksQhnDkRx
        IayDkYeNsmAN6hVZqdkyPp/XvXrsg==
X-ME-Sender: <xms:T9soYWhspszUsu1aXMJNeUJ7tZcMy-KB1onjXdK7Io0HzRGaztRTbA>
    <xme:T9soYXC0FxCLZJ8Oe7CyqEPuJXKA1oudLeu63MLAFx5PMNLcjdAEm6379vKiSbsZY
    CXWlCGj05aEOzFzRFU>
X-ME-Received: <xmr:T9soYeHL1JSSTF2W3HmeNS8WHUTAXxH6nW9h58lv9WgbeV0WT9jOnyfTX0btF5exYfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddufedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefggfeikeejhefgkeegudffudeftefhveejleelleegheevieff
    udejudfgtedvjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:T9soYfRgFuTOFBOFRbTtNMrczmr6UleKUQfC4GzxALN_Upf6SlAgnQ>
    <xmx:T9soYTxE1m1JlvCW4bHcrwTvYA7YohBEf8xlPTodxVGuA-ACKEKGDQ>
    <xmx:T9soYd6Rv7UsmqkjyTCmLCWOpiBqoVZDs8NqG1f4xqZgpCGHYagETw>
    <xmx:UNsoYT8VCUYRBnEjyoJguD5qlKXYkOzUxqduc6R8MaUGG-QxIj9wNg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Aug 2021 08:32:13 -0400 (EDT)
Subject: Re: [PATCH V9 2/5] PCI: loongson: Add ACPI init support
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20210827082031.2777623-1-chenhuacai@loongson.cn>
 <20210827082031.2777623-3-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <d83fa016-9ecc-4bf3-c004-137f77f710ee@flygoat.com>
Date:   Fri, 27 Aug 2021 20:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827082031.2777623-3-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


ÔÚ 2021/8/27 16:20, Huacai Chen Ð´µÀ:
> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
> while LoongArch-base Loongson uses ACPI, this patch add ACPI init
> support for the driver in drivers/pci/controller/pci-loongson.c
> because it is currently FDT-only.
>
> LoongArch is a new RISC ISA, mainline support will come soon, and
> documentations are here (in translation):
>
> https://github.com/loongson/LoongArch-Documentation
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Revieded-by: <jiaxun.yang@flygoat.com>
> ---
>   drivers/acpi/pci_mcfg.c               | 13 ++++++
>   drivers/pci/controller/Kconfig        |  2 +-
>   drivers/pci/controller/pci-loongson.c | 60 ++++++++++++++++++++++++++-
>   include/linux/pci-ecam.h              |  1 +
>   4 files changed, 73 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..860014b89b8e 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -41,6 +41,8 @@ struct mcfg_fixup {
>   static struct mcfg_fixup mcfg_quirks[] = {
>   /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
>   
> +#ifdef CONFIG_ARM64
> +
>   #define AL_ECAM(table_id, rev, seg, ops) \
>   	{ "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
>   
> @@ -169,6 +171,17 @@ static struct mcfg_fixup mcfg_quirks[] = {
>   	ALTRA_ECAM_QUIRK(1, 13),
>   	ALTRA_ECAM_QUIRK(1, 14),
>   	ALTRA_ECAM_QUIRK(1, 15),
> +#endif /* ARM64 */
> +
> +#ifdef CONFIG_LOONGARCH
> +#define LOONGSON_ECAM_MCFG(table_id, seg) \
> +	{ "LOONGS", table_id, 1, seg, MCFG_BUS_ANY, &loongson_pci_ecam_ops }
> +
> +	LOONGSON_ECAM_MCFG("\0", 0),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 0),
> +	LOONGSON_ECAM_MCFG("\0", 1),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 1),
> +#endif /* LOONGARCH */
>   };
>   
>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 5e1e3796efa4..77aa7272425c 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -287,7 +287,7 @@ config PCI_HYPERV_INTERFACE
>   config PCI_LOONGSON
>   	bool "LOONGSON PCI Controller"
>   	depends on MACH_LOONGSON64 || COMPILE_TEST
> -	depends on OF
> +	depends on OF || ACPI
>   	depends on PCI_QUIRKS
>   	default MACH_LOONGSON64
>   	help
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 433261c5f34c..164c0f6e419f 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -9,6 +9,8 @@
>   #include <linux/of_pci.h>
>   #include <linux/pci.h>
>   #include <linux/pci_ids.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>   
>   #include "../pci.h"
>   
> @@ -97,6 +99,18 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
>   }
>   DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
>   
> +static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg;
> +
> +	if (acpi_disabled)
> +		return (struct loongson_pci *)(bus->sysdata);
> +	else {
> +		cfg = bus->sysdata;
> +		return (struct loongson_pci *)(cfg->priv);
> +	}
> +}
> +
>   static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
>   				unsigned int devfn, int where)
>   {
> @@ -124,8 +138,10 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>   			       int where)
>   {
>   	unsigned char busnum = bus->number;
> -	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> -	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
> +	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
> +
> +	if (pci_is_root_bus(bus))
> +		busnum = 0;
>   
>   	/*
>   	 * Do not read more than one device on the bus other than
> @@ -146,6 +162,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>   	return NULL;
>   }
>   
> +#ifdef CONFIG_OF
> +
>   static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>   {
>   	int irq;
> @@ -259,3 +277,41 @@ static struct platform_driver loongson_pci_driver = {
>   	.probe = loongson_pci_probe,
>   };
>   builtin_platform_driver(loongson_pci_driver);
> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +
> +static int loongson_pci_ecam_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct loongson_pci *priv;
> +	struct pci_controller_data *data;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	cfg->priv = priv;
> +	data->flags = FLAG_CFG1 | FLAG_DEV_FIX,

FLAG_DEV_FIX still exists on ACPI based system£¿

:-(

> +	priv->data = data;
> +	priv->cfg1_base = cfg->win - (cfg->busr.start << 16);
> +
> +	return 0;
> +}
> +
> +const struct pci_ecam_ops loongson_pci_ecam_ops = {
> +	.bus_shift = 16,
> +	.init	   = loongson_pci_ecam_init,
> +	.pci_ops   = {
> +		.map_bus = pci_loongson_map_bus,
> +		.read	 = pci_generic_config_read,
> +		.write	 = pci_generic_config_write,
> +	}
> +};
> +
> +#endif
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index adea5a4771cf..6b1301e2498e 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -87,6 +87,7 @@ extern const struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 *
>   extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>   extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
>   extern const struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
> +extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
>   #endif
>   
>   #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
