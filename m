Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB271700F
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 23:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjE3V7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 17:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjE3V7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 17:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74370AA;
        Tue, 30 May 2023 14:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3DB7633E4;
        Tue, 30 May 2023 21:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E34FC433D2;
        Tue, 30 May 2023 21:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685483937;
        bh=4jZy45exYnNgaB2caizBfu6ca9UZFJzRxgPGz69y72E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I9wD0v9zhH6npsjAzCcI051WAdJ/VI/woFNHZz4owv3nHsFdPTSoXEZcYH8OEHhQf
         EGdmXwkuqt92aPw/mEk6fjvKLHxCSxqsO7zsvxPJttJUCSRWpcQbhEthjWLMYB1mlO
         cVXJtapO28e3rDDVQhJwur72rfDHLt7LPek2FfJ6w2h1fy+LbGAqx70qTfvl/6JO/n
         Wo2gs/WWyGFLVv85virLpcGjEZSIO9yylPZb70qP2Le5w9dKEy1GIXPCUbwX51fqN2
         bVXZ22NoBqNN0sRjHeniosa7SrkNFKtBny5AB9XsKRTdmOA5naCgx1RcNQbqp9DrBe
         MiwLFjJcLyH0Q==
Date:   Tue, 30 May 2023 16:58:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH pci] PCI: don't skip probing entire device if first fn OF
 node has status = "disabled"
Message-ID: <ZHZxn0a3/EJbthYO@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521115141.2384444-1-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 21, 2023 at 02:51:41PM +0300, Vladimir Oltean wrote:
> pci_scan_child_bus_extend() calls pci_scan_slot() with devfn
> (bus:device:function) being a multiple of 8, i.e. for each unique
> device.
> 
> pci_scan_slot() has logic to say that if the function 0 of a device is
> absent, the entire device is absent and we can skip the other functions
> entirely. Traditionally, this has meant that pci_bus_read_dev_vendor_id()
> returns an error code for that function.
> 
> However, since the blamed commit, there is an extra confounding
> condition: function 0 of the device exists and has a valid vendor id,
> but it is disabled in the device tree. In that case, pci_scan_slot()
> would incorrectly skip the entire device instead of just that function.
> 
> Such is the case with the NXP LS1028A SoC, which has an ECAM
> for embedded Ethernet (see pcie@1f0000000 in
> arm64/boot/dts/freescale/fsl-ls1028a.dtsi). Each Ethernet port
> represents a function within the ENETC ECAM, with function 0 going
> to ENETC Ethernet port 0, connected to SERDES port 0 (SGMII or USXGMII).
> 
> When using a SERDES protocol such as 0x9999, all 4 SERDES lanes go to
> the Ethernet switch (function 5 on this ECAM) and none go to ENETC
> port 0. So, ENETC port 0 needs to have status = "disabled", and embedded
> Ethernet takes place just through the other functions (fn 2 is the DSA
> master, fn 3 is the MDIO controller, fn 5 is the DSA switch etc).
> Contrast this with other SERDES protocols like 0x85bb, where the switch
> takes up a single SERDES lane and uses the QSGMII protocol - so ENETC
> port 0 also gets access to a SERDES lane.

Can you write this description in terms of PCI topology?  The
nitty-gritty SERDES details are not relevant at this level, except to
say that Function 0 is present in some cases but not others, and when
it is not present, *other* functions may be present.

Sigh.  Per spec (PCIe r6.0, sec 7.5.1.1.9), software is not permitted
to probe for Functions other than 0 unless "explicitly indicated by
another mechanism, such as an ARI or SR-IOV Capability."

Does it "work" to probe when the spec prohibits it?  Probably.  Does
it lead to some breakage elsewhere eventually?  Quite possibly.  They
didn't put "software must not probe" in the spec just to make
enumeration faster.

So I'm a little grumpy about further complicating this already messy
path just to accommodate a new non-compliant SoC.  Everybody pays the
price of understanding all this stuff, and it doesn't seem in balance.

Can you take advantage of some existing mechanism like
PCI_SCAN_ALL_PCIE_DEVS or hypervisor_isolated_pci_functions() (which
could be renamed and made more general)?

> Therefore, here, function 0 being unused has nothing to do with the
> entire PCI device being unused.
> 
> Add a "bool present_but_skipped" which is propagated from the caller
> of pci_set_of_node() all the way to pci_scan_slot(), so that it can
> distinguish an error reading the ECAM from a disabled device in the
> device tree.
> 
> Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/pci/pci.h   |  1 +
>  drivers/pci/probe.c | 58 +++++++++++++++++++++++++++++++--------------
>  2 files changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2475098f6518..dc11e0945744 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -240,6 +240,7 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  					int crs_timeout);
>  int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int crs_timeout);
>  
> +int __pci_setup_device(struct pci_dev *dev, bool *present_but_skipped);
>  int pci_setup_device(struct pci_dev *dev);
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		    struct resource *res, unsigned int reg);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0b2826c4a832..17a51fa55020 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1811,17 +1811,7 @@ static void early_dump_pci_device(struct pci_dev *pdev)
>  		       value, 256, false);
>  }
>  
> -/**
> - * pci_setup_device - Fill in class and map information of a device
> - * @dev: the device structure to fill
> - *
> - * Initialize the device structure with information about the device's
> - * vendor,class,memory and IO-space addresses, IRQ lines etc.
> - * Called at initialisation of the PCI subsystem and by CardBus services.
> - * Returns 0 on success and negative if unknown type of device (not normal,
> - * bridge or CardBus).
> - */
> -int pci_setup_device(struct pci_dev *dev)
> +int __pci_setup_device(struct pci_dev *dev, bool *present_but_skipped)
>  {
>  	u32 class;
>  	u16 cmd;
> @@ -1841,8 +1831,10 @@ int pci_setup_device(struct pci_dev *dev)
>  	set_pcie_port_type(dev);
>  
>  	err = pci_set_of_node(dev);
> -	if (err)
> +	if (err) {
> +		*present_but_skipped = true;
>  		return err;
> +	}
>  	pci_set_acpi_fwnode(dev);
>  
>  	pci_dev_assign_slot(dev);
> @@ -1995,6 +1987,23 @@ int pci_setup_device(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +/**
> + * pci_setup_device - Fill in class and map information of a device
> + * @dev: the device structure to fill
> + *
> + * Initialize the device structure with information about the device's
> + * vendor,class,memory and IO-space addresses, IRQ lines etc.
> + * Called at initialisation of the PCI subsystem and by CardBus services.
> + * Returns 0 on success and negative if unknown type of device (not normal,
> + * bridge or CardBus).
> + */
> +int pci_setup_device(struct pci_dev *dev)
> +{
> +	bool present_but_skipped = false;
> +
> +	return __pci_setup_device(dev, &present_but_skipped);
> +}
> +
>  static void pci_configure_mps(struct pci_dev *dev)
>  {
>  	struct pci_dev *bridge = pci_upstream_bridge(dev);
> @@ -2414,7 +2423,8 @@ EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>   * Read the config data for a PCI device, sanity-check it,
>   * and fill in the dev structure.
>   */
> -static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
> +static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn,
> +				       bool *present_but_skipped)
>  {
>  	struct pci_dev *dev;
>  	u32 l;
> @@ -2430,7 +2440,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	dev->vendor = l & 0xffff;
>  	dev->device = (l >> 16) & 0xffff;
>  
> -	if (pci_setup_device(dev)) {
> +	if (__pci_setup_device(dev, present_but_skipped)) {
>  		pci_bus_put(dev->bus);
>  		kfree(dev);
>  		return NULL;
> @@ -2575,17 +2585,20 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	WARN_ON(ret < 0);
>  }
>  
> -struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> +static struct pci_dev *__pci_scan_single_device(struct pci_bus *bus, int devfn,
> +						bool *present_but_skipped)
>  {
>  	struct pci_dev *dev;
>  
> +	*present_but_skipped = false;
> +
>  	dev = pci_get_slot(bus, devfn);
>  	if (dev) {
>  		pci_dev_put(dev);
>  		return dev;
>  	}
>  
> -	dev = pci_scan_device(bus, devfn);
> +	dev = pci_scan_device(bus, devfn, present_but_skipped);
>  	if (!dev)
>  		return NULL;
>  
> @@ -2593,6 +2606,13 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>  
>  	return dev;
>  }
> +
> +struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> +{
> +	bool present_but_skipped;
> +
> +	return __pci_scan_single_device(bus, devfn, &present_but_skipped);
> +}
>  EXPORT_SYMBOL(pci_scan_single_device);
>  
>  static int next_ari_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
> @@ -2665,6 +2685,7 @@ static int only_one_child(struct pci_bus *bus)
>   */
>  int pci_scan_slot(struct pci_bus *bus, int devfn)
>  {
> +	bool present_but_skipped;
>  	struct pci_dev *dev;
>  	int fn = 0, nr = 0;
>  
> @@ -2672,13 +2693,14 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  		return 0; /* Already scanned the entire slot */
>  
>  	do {
> -		dev = pci_scan_single_device(bus, devfn + fn);
> +		dev = __pci_scan_single_device(bus, devfn + fn,
> +					       &present_but_skipped);
>  		if (dev) {
>  			if (!pci_dev_is_added(dev))
>  				nr++;
>  			if (fn > 0)
>  				dev->multifunction = 1;
> -		} else if (fn == 0) {
> +		} else if (fn == 0 && !present_but_skipped) {
>  			/*
>  			 * Function 0 is required unless we are running on
>  			 * a hypervisor that passes through individual PCI
> -- 
> 2.34.1
> 
