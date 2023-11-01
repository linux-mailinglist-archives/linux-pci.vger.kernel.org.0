Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6A7DE7E2
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 23:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjKAWC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 18:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjKAWC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 18:02:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0D110;
        Wed,  1 Nov 2023 15:02:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6417EC433C7;
        Wed,  1 Nov 2023 22:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698876144;
        bh=wnWLDQK0FBkzmPX13eahCC6CH20kSJCdKoocecCI93s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o2rfU4uLCVdKybijAOa0me8qs5gY1oB7W2Enq/sp2esf+Jwnr7SYLqwJxrGTyBLxD
         PJWsQWuazLx6iAm/0lrWgeCqJiP8CdebHo9Xh8OI2WNErazD88E4DtknZ+UPlwdekC
         OY2biJnnx4gnzeztqIxtutRc8ixr5jfaT3kGV4tLBLTz8359uadpWwuz9U13om4TrB
         sqIA0nmj6ahkuLNP2mlSe0icOjpJ3521K/HwMq8BKiOgf2IxFcMBypHivMxonTMaLo
         hk8FkX4RuaOEj0+s5j3zJP7NChiEuW1judgpJy9ImvWkRy6pgo4lIIrgY1qaQJByWx
         9cciBOTffXTaw==
Date:   Wed, 1 Nov 2023 17:02:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH fixes v4] pci: loongson: Workaround MIPS firmware MRRS
 settings
Message-ID: <20231101220222.GA99154@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101114957.309902-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 01, 2023 at 11:49:56AM +0000, Jiaxun Yang wrote:
> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.

Thanks for this patch.  We're in the v6.7 merge window, so we won't
start merging v6.8 content until v6.7-rc1 (probably Nov 12).

> There are many MIPS based Loongson systems in wild that
> shipped with firmware which does not set maximum MRRS properly.

As far as I know, there's no requirement for firmware to set MRRS at
all *except* for the "no_inc_mrrs" hack added by 8b3517f88ff2.  That
hack treats the current MRRS value as a limit to work around the
Loongson bug that read requests larger than the limit cause a
Completer Abort instead of multiple completions.

> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> MRRS support is considered rare.
> 
> It must be done at device enablement stage because hardware will
> reset MRRS to inavlid value if a device got disabled.

s/inavlid/invalid/

This part isn't clear to me, though.  What exactly does "device got
disabled" mean?  The device got reset?  Power cycled?
PCI_COMMAND_MASTER was cleared?

PCI_FIXUP_ENABLE quirks are run during pci_enable_device(), which
basically just turns on PCI_COMMAND_MEMORY and/or PCI_COMMAND_IO.

If MRRS gets reset when PCI_COMMAND_MASTER is set or cleared, we don't
have a quirk phase that runs during pci_set_master(), which is where
PCI_COMMAND_MASTER gets set, so it's not clear that
pci_enable_device() is the right place.

> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

We'll look for an ack from the maintainer.  Maybe that's you, since
you added the driver in the first place?  Or maybe it's Huacai?

MAINTAINERS currently doesn't list anybody for
drivers/pci/controller/pci-loongson.c, and it should.  That should be
a separate patch.

> ---
> v4: Improve commit message
> 
> This is a partial revert of the origin quirk so there shouldn't
> be any drama.
> ---
>  drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index d45e7b8dc530..d184d7b97e54 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>  
> +#ifdef CONFIG_MIPS
> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus = pdev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },

This looks like the same list of devices as for loongson_mrrs_quirk().
So I guess the idea is that we need loongson_mrrs_quirk() for
Loongarch-based systems, and this loongson_old_mrrs_quirk() for
MIPS-based systems?

If so, maybe they could be #ifdef'd to show that, e.g., so that only
one or the other is compiled?

> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +		/*
> +		 * There are still some wild MIPS Loongson firmware won't
> +		 * set MRRS properly. Limiting MRRS to 256 as MIPS Loongson
> +		 * comes with higher MRRS support is considered rare.
> +		 */
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(pdev) > 256) {
> +				pci_info(pdev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(pdev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_quirk);
> +#endif
> +
>  static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>  {
>  	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
> -- 
> 2.34.1
> 
