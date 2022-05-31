Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980A5399E8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 01:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348604AbiEaXEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 19:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiEaXEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 19:04:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872AC5A090
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 16:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9AE99CE1902
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 23:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E7FC385A9;
        Tue, 31 May 2022 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654038279;
        bh=uhYSyaV1oqEVrRDpWcCanQD+gh8x9zaq4zsgYPbxgyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sic2ACWOB91z4Dhw2WaH0K4nRB1VuNdjv/JvmX/CYO8BIZqOEZsSyUUsgle8uabvo
         vMV25px96xyBhO4+GLer5tWyEjRZHqYxtiFzNfsaEEbXwIqy+c9DdyhgMkSZBYENpn
         QekvNK9KsZ30CcLJX7B92n413mLcWWp9GRW+8t0sWguH2Dmvf2sAT4d0T9Arf1JKjk
         mO8WAfIiO4A2Sr+Qm0amlthQNMQ+gFgi8dVgDCtv9n68ZFlo3NhRaDHSRdZYakZ6AM
         DZcyi2TwlwfpptRaJQUox/aN3xCSWTGxJHrnGxjjNquhHLMgscWxuHaorHjmDG0Q7U
         S7QBaVezX212w==
Date:   Tue, 31 May 2022 18:04:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 2/6] PCI: loongson: Add ACPI init support
Message-ID: <20220531230437.GA793965@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430084846.3127041-3-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 04:48:42PM +0800, Huacai Chen wrote:
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
> ---
>  drivers/acpi/pci_mcfg.c               | 13 ++++++
>  drivers/pci/controller/Kconfig        |  2 +-
>  drivers/pci/controller/pci-loongson.c | 60 ++++++++++++++++++++++++++-
>  include/linux/pci-ecam.h              |  1 +
>  4 files changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..860014b89b8e 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -41,6 +41,8 @@ struct mcfg_fixup {
>  static struct mcfg_fixup mcfg_quirks[] = {
>  /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
>  
> +#ifdef CONFIG_ARM64
> +
>  #define AL_ECAM(table_id, rev, seg, ops) \
>  	{ "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
>  
> @@ -169,6 +171,17 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	ALTRA_ECAM_QUIRK(1, 13),
>  	ALTRA_ECAM_QUIRK(1, 14),
>  	ALTRA_ECAM_QUIRK(1, 15),
> +#endif /* ARM64 */

The addition of the CONFIG_ARM64 #ifdefs should be its own separate
patch so it's not buried in this Loongson one.

> +#ifdef CONFIG_LOONGARCH
> +#define LOONGSON_ECAM_MCFG(table_id, seg) \
> +	{ "LOONGS", table_id, 1, seg, MCFG_BUS_ANY, &loongson_pci_ecam_ops }
> +
> +	LOONGSON_ECAM_MCFG("\0", 0),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 0),
> +	LOONGSON_ECAM_MCFG("\0", 1),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 1),
> +#endif /* LOONGARCH */
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index b8d96d38064d..9dbd73898b47 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -293,7 +293,7 @@ config PCI_HYPERV_INTERFACE
>  config PCI_LOONGSON
>  	bool "LOONGSON PCI Controller"
>  	depends on MACH_LOONGSON64 || COMPILE_TEST
> -	depends on OF
> +	depends on OF || ACPI
>  	depends on PCI_QUIRKS
>  	default MACH_LOONGSON64
>  	help
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 0a947ace9478..adbfa4a2330f 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -9,6 +9,8 @@
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/pci_ids.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>  
>  #include "../pci.h"
>  
> @@ -97,6 +99,18 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
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
>  static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
>  				unsigned int devfn, int where)
>  {
> @@ -124,8 +138,10 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>  			       int where)
>  {
>  	unsigned char busnum = bus->number;
> -	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> -	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
> +	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
> +
> +	if (pci_is_root_bus(bus))
> +		busnum = 0;

This is weird.  The comment just below says "For our hardware the root
bus is always bus 0."  Is that not true any more?  Why would you
override the bus number?

>  	/*
>  	 * Do not read more than one device on the bus other than
> @@ -146,6 +162,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_OF
> +
>  static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	int irq;
> @@ -259,3 +277,41 @@ static struct platform_driver loongson_pci_driver = {
>  	.probe = loongson_pci_probe,
>  };
>  builtin_platform_driver(loongson_pci_driver);
> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +
> +static int loongson_pci_ecam_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct loongson_pci *priv;
> +	struct loongson_pci_data *data;
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
> +	data->flags = FLAG_CFG1;
> +	priv->data = data;
> +	priv->cfg1_base = cfg->win - (cfg->busr.start << 16);
> +
> +	return 0;
> +}
> +
> +const struct pci_ecam_ops loongson_pci_ecam_ops = {
> +	.bus_shift = 16,

I can't remember the details of how this works.  The standard PCIe
ECAM has:

  A[11:00] 12 bits of Register number/alignment
  A[14:12]  3 bits of Function number
  A[19:15]  5 bits of Device number
  A[27:20]  8 bits of Bus number

Doesn't a bus_shift of 16 mean there are only 16 bits available for
the register number, function, and device?  So that would limit us to
8 bits of register number?  Do we enforce that somewhere?

It seems like a limit on "where" should be enforced in
pci_ecam_map_bus() and other .map_bus() functions like
pci_loongson_map_bus().  Otherwise a config read at offset
0x100 would read config space of the wrong device.

Krzysztof, do you remember how this works?

> +	.init	   = loongson_pci_ecam_init,
> +	.pci_ops   = {
> +		.map_bus = pci_loongson_map_bus,
> +		.read	 = pci_generic_config_read,
> +		.write	 = pci_generic_config_write,
> +	}
> +};
