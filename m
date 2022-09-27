Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964DA5ECC5F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiI0SsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiI0SsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 14:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5F41C4800;
        Tue, 27 Sep 2022 11:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C909361B45;
        Tue, 27 Sep 2022 18:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D95C433C1;
        Tue, 27 Sep 2022 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664304499;
        bh=RT1m/jTPKLtubCI4ao+hH85N0chg2egDFNFz49YsIqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OhdD7fI8OESp2sMPY1aoAWjWWwPMiyYNvyKsXYyZY1QKZchG6aV6dy/3DZztBSgPe
         v4AHKzvu1RxSRWWxTgE5vY2HwPi0Urp5BwhjmeF42ZZjh22ku+bVFgDZZy4NibUrKZ
         FnLNeCXzEOcho51np2nLKhOZa4NP3pXrfnf5uDGDGsO50IvDu9o6FuUA7fKw0Bh64d
         Q7bLUQSQNK5u6EIwVh5fhCAZ8twLkADBMHlyNCoL2HN3/eX/FxXbnWgIlkNnE/fYat
         ZMeDNdAuPX7DQoBP6pUSXCMpwLgocLPfTZ8uy2mxZWDQk6G2vQfvRmxfoGqNoSIi0s
         7ZvKBmzjCkXew==
Date:   Tue, 27 Sep 2022 13:48:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, xiaocli@redhat.com,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: Re: [PATCH v2 1/1] PCI: Set no io resource for bridges that behind
 VMD controller
Message-ID: <20220927184817.GA1719151@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664288166-7432-1-git-send-email-lixiaochun.2888@163.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 10:16:06PM +0800, Xiaochun Lee wrote:
> From: Xiaochun Lee <lixc17@lenovo.com>
> 
> When enable VMDs on Intel CPUs, VMD controllers(8086:28c0) be
> recognized by VMD driver and there are many failed messages of
> BAR 13 when scan the bridges and assign IO resource behind it
> as listed below, the bridge wants to get 0x6000 as its IO
> resource, but there is no IO resources on the host bridge.
> 
> VMD host bridge resources:
> vmd 0000:e2:00.5: PCI host bridge to bus 10001:00
> pci_bus 10001:00: root bus resource [bus 00-1f]
> pci_bus 10001:00: root bus resource [mem 0xf4000000-0xf5ffffff]
> pci_bus 10001:00: root bus resource [mem 0x29ffff02010-0x29fffffffff 64bit]
> pci_bus 10001:00: scanning bus
> 
> Read bridge IO resource:
> pci 10001:00:02.0: PCI bridge to [bus 01]
> pci 10001:00:02.0:   bridge window [io  0x1000-0x6fff]
> pci 10001:00:03.0: PCI bridge to [bus 02]
> pci 10001:00:03.0:   bridge window [io  0x1000-0x6fff]
> 
> Failed messages of BAR#13:
> pci 10001:00:02.0: BAR 13: no space for [io  size 0x6000]
> pci 10001:00:02.0: BAR 13: failed to assign [io  size 0x6000]
> pci 10001:00:03.0: BAR 13: no space for [io  size 0x6000]
> pci 10001:00:03.0: BAR 13: failed to assign [io  size 0x6000]
> 
> VMD-enabled root ports use
> Enhanced Configuration Access Mechanism (ECAM) access
> PCI Express configuration space, and offer VMD_CFGBAR as
> base of PCI Express configuration space for the bridges
> behind it. The configuration space includes IO resources,

I don't quite understand this part.  ECAM is an MMIO method, so it
uses memory space, not I/O port space.

> but these IO resources are not actually used on X86,
> it can result in BAR#13 assign IO resource failed.
> Therefor,clear IO resources by setting an IO base value
> greater than limit to these bridges here, so in this case,
> we can leverage kernel parameter "pci=hpiosize=0KB" to
> avoid this failed messages show up.

Is the only purpose of this patch to avoid the "no space" and "failed
to assign" messages?  Or is there something that actually doesn't
work?

I don't think it's worth making a quirk just to avoid the message.
There are several systems where I/O port space is not available, and
it *would* be nice to have a generic approach that handles that
better.

> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
> ---
>  drivers/pci/quirks.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4944798e75b5..efecf12e8059 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5956,3 +5956,63 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>  #endif
> +
> +#if defined(CONFIG_X86_64) || defined(CONFIG_X86)
> +
> +#ifdef CONFIG_UML_X86
> +#define is_vmd(bus)             false
> +#endif /* CONFIG_UML_X86 */
> +
> +/*
> + * VMD-enabled root ports use Enhanced Configuration Access Mechanism (ECAM)
> + * access PCI Express configuration space, and offer VMD_CFGBAR as the
> + * base of PCI Express configuration space for the bridges behind it.
> + * The configuration space includes IO resources, but these IO
> + * resources are not actually used on X86, and it can result
> + * in BAR#13 assign IO resource failed. Therefor, clear IO resources
> + * by setting an IO base value greater than limit to these bridges here,
> + * so in this case, append kernel parameter "pci=hpiosize=0KB" can avoid
> + * the BAR#13 failed messages show up.
> + */
> +static void quirk_vmd_no_iosize(struct pci_dev *bridge)
> +{
> +	u8 io_base_lo, io_limit_lo;
> +	u16 io_low;
> +	u32 io_upper16;
> +	unsigned long io_mask,  base, limit;
> +
> +	io_mask = PCI_IO_RANGE_MASK;
> +	if (bridge->io_window_1k)
> +		io_mask = PCI_IO_1K_RANGE_MASK;
> +
> +	/* VMD Domain */
> +	if (is_vmd(bridge->bus) && bridge->is_hotplug_bridge) {
> +		pci_read_config_byte(bridge, PCI_IO_BASE, &io_base_lo);
> +		pci_read_config_byte(bridge, PCI_IO_LIMIT, &io_limit_lo);
> +		base = (io_base_lo & io_mask) << 8;
> +		limit = (io_limit_lo & io_mask) << 8;
> +		/* if there are defined io ports behind the bridge on x86,
> +		 * we clear it, since there is only 64KB IO resource on it,
> +		 * beyond that, hotplug io bridges don't needs IO port resource,
> +		 * such as NVMes attach on it. So the corresponding range must be
> +		 * turned off by writing base value greater than limit to the
> +		 * bridge's base/limit registers.
> +		 */
> +		if (limit >= base) {
> +			/* Clear upper 16 bits of I/O base/limit */
> +			io_upper16 = 0;
> +			/* set base value greater than limit */
> +			io_low = 0x00f0;
> +
> +			/* Temporarily disable the I/O range before updating PCI_IO_BASE */
> +			pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
> +			/* Update lower 16 bits of I/O base/limit */
> +			pci_write_config_word(bridge, PCI_IO_BASE, io_low);
> +			/* Update upper 16 bits of I/O base/limit */
> +			pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, io_upper16);
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> +		PCI_CLASS_BRIDGE_PCI, 8, quirk_vmd_no_iosize);
> +#endif
> -- 
> 2.37.3
> 
