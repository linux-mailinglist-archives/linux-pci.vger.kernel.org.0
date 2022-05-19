Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8ED52D9E7
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 18:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbiESQLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbiESQK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 12:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5AC14013;
        Thu, 19 May 2022 09:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5849761BFB;
        Thu, 19 May 2022 16:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AF7C34100;
        Thu, 19 May 2022 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652976655;
        bh=altMU1x5dkULV65LqvjrW52Px3VtLs4XMJvIVnKnHWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sUtc1K9UagbRyfhUiKz9v9PGOqfIf38DRORdTyH/Znl0GZp9Sc5oZl+Cy2hdiAb2u
         LmL6LVdp0jtl0JGiKrnqhQ8x4oBfd/RrTUGnmfULdamzu2PpVrLvwjPEtslNGyZoL8
         X/rnDplhSSXuyFv/8DgxoTnI7frHAVr62/sAGEojNSpqLwu8vc9T38JVazYDGa7Yhv
         30CK4gAy8ulbsaeGA8OT53F30r5TGWH6p3bncIulcKhaL+uBRQv+WLlPQahI7T908O
         NZnmHpv8n2WSk11UIhLCHoMdGydmwC9ui9SFsHwlp15uPMUUKOA/2HJ4xQu4tE1HsW
         xwq5fGMbkjb0w==
Date:   Thu, 19 May 2022 11:10:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        kibi@debian.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220519161053.GA24069@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518194211.20143-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Rob for my naive DT questions]

On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> 
> introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
> endpoint node described in [2] was missing, no linkup would be attempted,
> and subsequent accesses would cause a panic because this particular PCIe HW
> causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
> 
> We fix this by allowing the DT endpoint subnode to be missing.  This is
> important for platforms like the CM4 which have a standard PCIe socket and
> the endpoint device is unknown.

I assume you're referring specifically to making this optional in the
DT:

    /* PCIe endpoint */
    pci-ep@0,0 {
            assigned-addresses =
                <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
            reg = <0x0 0x0 0x0 0x0 0x0>;
            compatible = "pci14e4,1688";
    };

I don't really understand what's going on here, but I assume this
describes a [14e4:1688] device, which the PCI database says is a
NetXtreme BCM5761 10/100/1000BASE-T Ethernet
(https://pci-ids.ucw.cz/read/PC/14e4/1688)

Why do you *ever* need this stanza?  "git grep pci-ep
Documentation/devicetree/bindings/pci/" says no other DT has one.

If the link does come up, I assume normal PCI enumeration would
discover the [14e4:1688] or whatever device is plugged into a CM4
socket, and it would read and assign BARs as needed.  Why do we need
to describe any of this in the DT?

If the link doesn't come up, it looks like you set the "refusal_mode"
so subsequent config accesses fail gracefully instead of with a CPU
abort.

[Tangent: since you never clear "refusal_mode", I assume there's no
possibility of hot-adding a device.  A device must be put in the slot
before power-up, right?]

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
> [2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> 
> Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index ba5c120816b2..adca74e235cb 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -540,16 +540,18 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
>  
>  static int brcm_pcie_add_bus(struct pci_bus *bus)
>  {
> -	struct device *dev = &bus->dev;
>  	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
>  	int ret;
>  
> -	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> +	/* Only busno==1 requires us to linkup */
> +	if ((int)bus->number != 1)

It's a big leap from "DT endpoint is optional" to "bus->number == 1 if
DT endpoint is missing" (if that's even what it means).  Help me
connect the dots here.

I *guess* this is really saying "we only want to bring the link up for
RPs"?

And "bus->number == 1" assumes the RP is on bus 0, there's only one
RP, and that RP's secondary bus is 1?  So it's only in that case
(we're adding the secondary bus of the RP), that we need to manually
bring up the link?

>  		return 0;
>  
>  	ret = pci_subdev_regulators_add_bus(bus);
> -	if (ret)
> +	if (ret) {
> +		pcie->refusal_mode = true;

Is this related?  It doesn't *look* related to making the DT endpoint
optional.

>  		return ret;
> +	}
>  
>  	/* Grab the regulators for suspend/resume */
>  	pcie->sr = bus->dev.driver_data;
> 
> base-commit: ef1302160bfb19f804451d0e919266703501c875
> prerequisite-patch-id: 23a425390a4226bd70bbff459148c80f5e28379c
> prerequisite-patch-id: e3f2875124b46b2b1cf9ea28883bf0c864b79479
> prerequisite-patch-id: 9cdd706ee2038c7b393c4d65ff76a1873df1ca03
> prerequisite-patch-id: 332ac90be6e4e4110e27bdd1caaff212c129f547
> prerequisite-patch-id: 32a74f87cbfe9e8d52c34a4edeee6d271925665a
> prerequisite-patch-id: f57cdf7ec7080bb8c95782bc7c3ec672db8ec1ce
> prerequisite-patch-id: 18dc9236aed47f708f5c854afd832f3c80be5ea7
> prerequisite-patch-id: dd147c6854c4ca12a9a8bd4f5714968a59d60e4e
> -- 
> 2.17.1
> 
