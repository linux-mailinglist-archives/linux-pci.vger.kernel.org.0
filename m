Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882B52FE3A
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiEUQnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 May 2022 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiEUQnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 May 2022 12:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494D344D7;
        Sat, 21 May 2022 09:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA83608D6;
        Sat, 21 May 2022 16:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4213CC385A5;
        Sat, 21 May 2022 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653151386;
        bh=az64NAXmbt4SZ0Idjh2q6rIuye3/f5hZ/eibgzKipTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EPB+gH2T3lz6z9Mhd+CRPKJqp/Uk6n6Gm12lVIgQgBJzsiTs5jeValjrGoSZhyNkM
         gES8SDqGvn1BvV75+/tnFM40KdVGpbf2STgC5SA/+1iTaRPY1JeRgHOv8P52ZfXCO4
         xYoPzRmwhJKKbDjNN50EqhZNQdO5PMSnEOpGdJd31lzdgfTLtwTPIDEkm3V2a0JjTa
         BQ8rCRWtz+aO5mVoD4VG62MLM/a72TDM+GPzjxW0Nd41VPGL7ZN+n9RB8Z3Y67vW1Q
         SXqrY0oYrdp2A2hfcx+tWxCzhn2PecmecAnB3rkM9IRiCTlh7R6+ln04vbBPepWg5e
         fM5OEk2H8cXxg==
Date:   Sat, 21 May 2022 11:43:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        kibi@debian.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220521164303.GA106705@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518194211.20143-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm because I think there are interesting power
management questions here]

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

I think the problem here is that on the CM, we try to enumerate
devices that are not powered up, isn't it?  The commit log should say
something about that power situation and how the driver learns about
the power regulators instead of just pointing at an DT endpoint node.

I guess the intent of this patch is to turn on the power to downstream
devices before enumerating them?  What happens if we turn on the power
but don't find any downstream devices?  From looking at the code, I
assume we just leave the power on.  Maybe that's what you want, I
dunno.

I added Rafael because this seems vaguely similar to runtime power
management, and if we can integrate with that somehow, I'd sure like
to avoid building a parallel infrastructure for it.

The current path we're on is to move some of this code that's
currently in pcie-brcmstb.c to the PCIe portdrv [0].  I'm a little
hesitant about that because ACPI does just fine without it.  If we're
adding new DT functionality that could not be implemented via ACPI,
that's one thing.  But I'm not convinced this is that new.

That's a longer term question.  In the short term we need to fix the
regression.  More specifics about that below.

[0] https://lore.kernel.org/r/20211110221456.11977-6-jim2101024@gmail.com

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
>  		return 0;
>  
>  	ret = pci_subdev_regulators_add_bus(bus);
> -	if (ret)
> +	if (ret) {
> +		pcie->refusal_mode = true;
>  		return ret;
> +	}
>  
>  	/* Grab the regulators for suspend/resume */
>  	pcie->sr = bus->dev.driver_data;

IIUC, this path:

  pci_alloc_child_bus
    brcm_pcie_add_bus                   # .add_bus method
      pci_subdev_regulators_add_bus     # in pcie-brcmstb.c for now
        alloc_subdev_regulators         # in pcie-brcmstb.c for now
        regulator_bulk_get
        regulator_bulk_enable
      brcm_pcie_linkup			# bring link up

is basically so we can leave power to downstream devices off, then
turn it on when we're ready to enumerate those downstream devices.

I think the brcmstb root bus is always bus 0, it only has a single
Root Port on the root bus, and it always leads to bus 1, so it sort of
makes sense that we only need to turn on power when we're about to
scan "bus->number == 1".

But this power management seems like a pattern that other controllers
will use.  Other controllers will have several Root Ports, so checking
the bus number won't work for them.  Instead of checking the bus
number, I think brcmstb should check more directly for a power
regulator.

Tangent 1: I think this means a downstream device goes from D3cold to
D0uninitialized?  Does this code account for the required delays
accesses to the device?  I see some in brcm_pcie_linkup(), but I don't
see anything that looks like Tpvperl (the time PERST# must remain
asserted after power becomes valid) or Tperst (when asserted, PERST#
must remain asserted at least this long) (both from PCIe r6.0, sec
6.6.1).

Tangent 2: "brcm_pcie_link_up()" makes sense -- it's the conventional
name for the simple boolean function that tells us whether the link is
up.  "brcm_pcie_linkup()", which *brings* the link up, is confusing
because it's too similar to "brcm_pcie_link_up()".  The conventional
name for this would be "brcm_pcie_start_link()".

Tangent 3: There are fewer than 20 forward function declarations in
drivers/pci/controller/, and 9 of them are in pcie-brcmstb.c.  It's a
lot easier to maintain all these drivers if they use a common style.
Generally speaking, Linux code orders function definitions to avoid
the need for forward declarations.

Bjorn
