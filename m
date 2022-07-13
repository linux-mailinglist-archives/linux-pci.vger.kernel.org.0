Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E93572BFC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 05:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiGMDhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 23:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiGMDhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 23:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FDD7B82
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 20:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AEFB61AF5
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 03:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B25C3411E;
        Wed, 13 Jul 2022 03:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657683473;
        bh=2fxmuF6ZWqBrrBQ+fspcybEr+BZrJ/IBfya/UIf9S7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LO3gX2PSGPQfuM7pYg2J3ZVn+Guew84EC+G/Q09UN78pe3/iPq1QnemF4QOpkXLr/
         PXu7FZx5MQ69LXzxIt97Y1a7qH7xvZfgiS+KNrOVh5Hsb/lEN/m90x4OFLu7fHUAgz
         tll0bloLp8Og8uxe5JKZeP3y8PbU94O9HSrwQf5jS+kUN2YVQTMDyUA0gUnqS0TBLz
         BqCR8CFjmjnsSW207CpnQ6uwG99o0CDUh58wlcTwQglBNER1OlpYNzzBCw2MslKOKs
         Ue77Y4Hn/gdVsk5Jv70K2R0NGhyMl1lINObRt2NL/jFL6AsjN4phzI4XtzBu9Rpq7P
         DagZgbbE+EwiA==
Date:   Tue, 12 Jul 2022 22:37:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V15 3/7] PCI: loongson: Add ACPI init support
Message-ID: <20220713033750.GA796301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702090808.1221300-4-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 02, 2022 at 05:08:04PM +0800, Huacai Chen wrote:
> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
> while LoongArch-base Loongson uses ACPI, this patch add ACPI init
> support for the driver in drivers/pci/controller/pci-loongson.c
> because it is currently FDT-only.

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

I rewrote this locally as:

  if (acpi_disabled)
    return (struct loongson_pci *)(bus->sysdata);

  cfg = bus->sysdata;
  return (struct loongson_pci *)(cfg->priv);

to avoid the asymmetry of braces/no braces.

> @@ -124,12 +138,14 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>  			       int where)
>  {
>  	unsigned char busnum = bus->number;
> -	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> -	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
> +	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
> +
> +	if (pci_is_root_bus(bus))
> +		busnum = 0;

I asked you about this before [1], but I don't understand the answer.

Let's say the root bus is 40 and we have this:

  40:00.0 Root Port to [bus 41]
  41:00.0 NIC

When we read the Vendor ID for 40:00.0:

  pci_loongson_map_bus(bus 40, 00.0, 0)
    if (pci_is_root_bus(bus))       # true
      busnum = 0;
    cfg0_map(priv, 0x00, 00.0, 0);
      if (bus != 0)                 # false
        ...
      addroff |= (0 << 16) | (0 << 8) | 0;

but for 41:00.0:

  pci_loongson_map_bus(bus 41, 00.0, 0)
    if (pci_is_root_bus(bus))       # false
      ...
    cfg0_map(priv, 0x41, 00.0, 0);
      if (bus != 0)                 # true
        addroff |= BIT(24);
      addroff |= (0x41 << 16) | (0 << 8) | 0;

Maybe the point is that for accesses to the root bus (which are always
Type 0 accesses), you never put "bus << 16" into addroff, no matter
what the actual root bus number is?

If that's the case, I think you should instead make cfg0_map() look
like this:

  cfg0_map(struct pci_bus *bus, ...)
  {
    unsigned long addroff = 0x0;

    if (!pci_is_root_bus(bus)) {
      addroff |= BIT(24);
      addroff |= (bus << 16);
    }
    addroff |= (devfn << 8) | where;
    return priv->cfg0_base + addroff;
  }

Then you don't need to do the weird busnum override in
pci_loongson_map_bus(), and the root bus checking is in one place
(cfg0_map()) instead of being split between pci_loongson_map_bus() and
cfg0_map().  Same for cfg1_map(), obviously.

[1] https://lore.kernel.org/r/20220531230437.GA793965@bhelgaas
