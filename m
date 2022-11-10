Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000C9624E47
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 00:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKJXNz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 18:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJXNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 18:13:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A44E0B4;
        Thu, 10 Nov 2022 15:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7BBF61B97;
        Thu, 10 Nov 2022 23:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC23BC433D6;
        Thu, 10 Nov 2022 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668122033;
        bh=sHhpWatm0XHYdgH50cYmsLgvmswF80vK4USqcgB/vpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SUF0mZcd+hFjraMZNerHJodGhBs95Zqcoj3PcYKLTMWwGX4jZYbdHjdo9nF3s0LLM
         LbwRJcyz9xw8+xoZ12Zga/GDohk7jkWppMZYfgaJcK256ShKQ4YBWRl38VHT3llrkS
         2GbrY2fun+IYij5pp3TE2AJ8tryl7mny1yNotHtGa8uDHvubvTuUF2fh6KqtoRiwiv
         /+j1v07aSdFDw9CT8mfe0wEv4Pg2gw+y5e07K+RYZxUhIrpoEVlhm3tPSA7Dx5wSu+
         6L0bcJ8urPoZaL/amtnDePf51w0P68YwKPdUN3o6GOwyQyOIfb8uzLzH5+dvpZWQFS
         Ga8eddOa/fGOQ==
Date:   Thu, 10 Nov 2022 17:13:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] PCI: loongson: Skip scanning unavailable child devices
Message-ID: <20221110231351.GA681551@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2323333-522c-4127-aaf0-90539fbd0cf4@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 11:00:45PM +0000, Jiaxun Yang wrote:
> 在2022年11月10日十一月 下午9:07，Bjorn Helgaas写道：
> > On Tue, Nov 08, 2022 at 02:42:40PM +0800, Liu Peibao wrote:
> >> The PCI Controller of 2k1000 could not mask devices by setting vender ID or
> >> device ID in configuration space header as invalid values. When there are
> >> pins shareable between the platform device and PCI device, if the platform
> >> device is preferred, we should not scan this PCI device. In the above
> >> scene, add `status = "disabled"` property in DT node of this PCI device.
> >> 
> >> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> >> ---
> >> V3 -> V4: 1. get rid of the masklist and search the status property
> >> 	  directly.
> >>           2. check the status property only when accessing the vendor ID.
> >> V2 -> V3: 1. use list_for_each_entry() for more clearly.
> >>           2. fix wrong use of sizeof().
> >> V1 -> V2: use existing property "status" instead of adding new property.
> >> 
> >>  drivers/pci/controller/pci-loongson.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >> 
> >> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> >> index 05c50408f13b..efca0b3b5a29 100644
> >> --- a/drivers/pci/controller/pci-loongson.c
> >> +++ b/drivers/pci/controller/pci-loongson.c
> >> @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
> >>  			return NULL;
> >>  	}
> >>  
> >> +#ifdef CONFIG_OF
> >> +	/* Don't access disabled devices. */
> >> +	if (pci_is_root_bus(bus) && where == PCI_VENDOR_ID) {
> >> +		struct device_node *dn;
> >> +
> >> +		dn = of_pci_find_child_device(bus->dev.of_node, devfn);
> >> +		if (dn && !of_device_is_available(dn))
> >> +			return NULL;
> >> +	}
> >> +#endif
> >
> > Looks nice and simple, thanks for trying this out.
> 
> Should we make this into common PCI code?
> I guess Loongson won’t be the last platform having such problem.

I think we should wait until somebody else has this problem.

It's not a completely trivial situation because if the device uses PCI
memory or I/O space, we have to worry about how that space is handled.
Does the BIOS assign that space?  Is it included in the host bridge
_CRS or "ranges" properties?  If the device is below any PCI bridges
(I don't think that's the case in your situation), how does the space
it requires get routed through the bridges?

It would be nice to say something in this commit log about whether
these are issues on your platform.

> >>  	/* CFG0 can only access standard space */
> >>  	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
> >>  		return cfg0_map(priv, bus, devfn, where);
> >> -- 
> >> 2.20.1
> >>
> 
> -- 
> - Jiaxun
