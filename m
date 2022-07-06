Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC31F5695A3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 01:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiGFXMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 19:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiGFXMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 19:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F02B254;
        Wed,  6 Jul 2022 16:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D653361C44;
        Wed,  6 Jul 2022 23:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F54C3411C;
        Wed,  6 Jul 2022 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657149172;
        bh=ItUfXozH148AAuBBM9m3CJz2AswU9qEpMXW4wCiKrbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MoPCh2CP6uzyylfEANjTd0/xAmA0C5kkryXD5GkXbVhDdlkKWIunfDCVrdMd7XbCW
         og1o4lubhXfxo/fsYuj8GrTS9I8+qNEXchpNDgSbc5EJ/TAeJ/7OQZLm+3hTzKGUkh
         Rv9cTw0kuJbUP7d85Uls60N2Dd+BXX7mDklYbui6oVExiiwMzo3Z4DfIu82udgrazS
         Iqs4en2x7GxvskF+vE52KiR2vddz8NCx3m1OhhO71qTi08LFl87u3mEAm980ukxvkJ
         /iAaZm62MkCr0VdFc4OBTWD/S0iRI0Td+h0JrafsBoZnybZtK7XCK7SAtJWz8jTH3M
         bBuJLo3vgr3wg==
Date:   Wed, 6 Jul 2022 18:12:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] PCI: brcmstb: Add mechanism to turn on subdev
 regulators
Message-ID: <20220706231250.GA231452@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701162726.31346-3-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 12:27:23PM -0400, Jim Quinlan wrote:
> Add a mechanism to identify standard PCIe regulators in the DT, allocate
> them, and turn them on before the rest of the bus is scanned during
> pci_host_probe().
> 
> The allocated structure that contains the regulators is stored in the port
> driver dev.driver_data field.  Here is a point-by-point of how and when
> this mechanism is activated:
> 
> If:
>     -- PCIe RC driver sets pci_ops {add,remove)_bus to
>        pci_subdev_regulators_{add,remove}_bus during its probe.
>     -- There is a DT node "RB" under the host bridge DT node.

"RB" isn't mentioned in pcie-brcmstb.c.  What's the connection to it?
Is it just an example, and the actual name doesn't matter?

>     -- During the RC driver's pci_host_probe() the add_bus callback
>        is invoked where (bus->parent && pci_is_root_bus(bus->parent)
>        is true
> 
> Then:
>     -- A struct subdev_regulators structure will be allocated and
>        assigned to bus->dev.driver_data.
>     -- regulator_bulk_{get,enable} will be invoked on &bus->dev
>        and the former will search for and process any
>        vpcie{12v,3v3,3v3aux}-supply properties that reside in node "RB".
>     -- The regulators will be turned off/on for any unbind/bind operations.
>     -- The regulators will be turned off/on for any suspend/resumes, but
>        only if the RC driver handles this on its own.  This will appear
>        in a later commit for the pcie-brcmstb.c driver.

I guess this is all functionality that depends on new properties in
the DT?  Prior to this patch, pcie-brcmstb.c didn't do anything at all
with regulators, although brcm,stb-pcie.yaml does mention
"vpcie3v3-supply" in an example.

> The unabridged reason for doing this is as follows.  We would like the
> Broadcom STB PCIe root complex driver (and others) to be able to turn
> off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> the drivers of these endpoint devices are stock Linux drivers that are not
> aware that these regulator(s) exist and must be turned on for the driver to
> be probed.  The simple solution of course is to turn these regulators on at
> boot and keep them on.  However, this solution does not satisfy at least
> three of our usage modes:
> 
>   1. For example, one customer uses multiple PCIe controllers, but wants
>      the ability to, by script invoking and unbind, turn any or all of them
>      and their subdevices off to save power, e.g. when in battery mode.
> 
>   2. Another example is when a watchdog script discovers that an endpoint
>      device is in an unresponsive state and would like to unbind, power
>      toggle, and re-bind just the PCIe endpoint and controller.
> 
>   3. Of course we also want power turned off during suspend mode.  However,
>      some endpoint devices may be able to "wake" during suspend and we need
>      to recognise this case and veto the nominal act of turning off its
>      regulator.  Such is the case with Wake-on-LAN and Wake-on-WLAN support
>      where the PCIe endpoint device needs to be kept powered on in order to
>      receive network packets and wake the system.
> 
> In all of these cases it is advantageous for the PCIe controller to govern
> the turning off/on the regulators needed by the endpoint device.  The first
> two cases can be done by simply unbinding and binding the PCIe controller,
> if the controller has control of these regulators.
> 
> [1] These regulators typically govern the actual power supply to the
>     endpoint chip.  Sometimes they may be the official PCIe socket
>     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
>     the regulator(s) that supply power to the EP chip.
> 
> [2] The 99% configuration of our boards is a single endpoint device
>     attached to the PCIe controller.  I use the term endpoint but it could
>     possibly mean a switch as well.
> 
> Link: https://lore.kernel.org/r/20220106160332.2143-6-jim2101024@gmail.com
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 77 +++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 2bf5cc399fd0..661d3834c6da 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -24,6 +24,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/printk.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -283,6 +284,14 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
>  
> +struct subdev_regulators {
> +	unsigned int num_supplies;
> +	struct regulator_bulk_data supplies[];
> +};
> +
> +static int pci_subdev_regulators_add_bus(struct pci_bus *bus);
> +static void pci_subdev_regulators_remove_bus(struct pci_bus *bus);

I think these forward declarations are unnecessary.  I can remove them
if you agree.

>  struct brcm_msi {
>  	struct device		*dev;
>  	void __iomem		*base;
> @@ -436,6 +445,72 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
>  	return ssc && pll ? 0 : -EIO;
>  }
>  
> +static void *alloc_subdev_regulators(struct device *dev)
> +{
> +	static const char * const supplies[] = {
> +		"vpcie3v3",
> +		"vpcie3v3aux",
> +		"vpcie12v",
> +	};
> +	const size_t size = sizeof(struct subdev_regulators)
> +		+ sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
> +	struct subdev_regulators *sr;
> +	int i;
> +
> +	sr = devm_kzalloc(dev, size, GFP_KERNEL);
> +	if (sr) {
> +		sr->num_supplies = ARRAY_SIZE(supplies);
> +		for (i = 0; i < ARRAY_SIZE(supplies); i++)
> +			sr->supplies[i].supply = supplies[i];
> +	}
> +
> +	return sr;
> +}
> +
> +static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> +{
> +	struct device *dev = &bus->dev;
> +	struct subdev_regulators *sr;
> +	int ret;
> +
> +	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> +		return 0;
> +
> +	if (dev->driver_data)
> +		dev_err(dev, "dev.driver_data unexpectedly non-NULL\n");

I guess you're using the pci_bus dev->driver_data.  I don't know of
other users of it, but there's really no ownership model for it.  If
it's non-NULL here, it means somebody else, e.g., the PCI core, is
already using it, and when you overwrite it below, you will break that
other user.

I think you should complain and return instead of breaking the other
user.  That will mean the regulator won't get enabled and your
endpoint won't work, but I think that's a better way to fail than by
overwriting somebody else's pointer, which may lead to memory
corruption that's very hard to debug.

> +	sr = alloc_subdev_regulators(dev);
> +	if (!sr)
> +		return -ENOMEM;
> +
> +	dev->driver_data = sr;
> +	ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
> +	if (ret) {
> +		dev_err(dev, "failed to enable regulators for downstream device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
> +{
> +	struct device *dev = &bus->dev;
> +	struct subdev_regulators *sr = dev->driver_data;
> +
> +	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
> +		return;
> +
> +	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
> +		dev_err(dev, "failed to disable regulators for downstream device\n");
> +	regulator_bulk_free(sr->num_supplies, sr->supplies);
> +	dev->driver_data = NULL;
> +}
> +
>  /* Limits operation to a specific generation (1, 2, or 3) */
>  static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
>  {
> @@ -779,6 +854,8 @@ static struct pci_ops brcm_pcie_ops = {
>  	.map_bus = brcm_pcie_map_conf,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> +	.add_bus = pci_subdev_regulators_add_bus,
> +	.remove_bus = pci_subdev_regulators_remove_bus,
>  };
>  
>  static struct pci_ops brcm_pcie_ops32 = {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
