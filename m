Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD55F4C3700
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 21:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiBXUrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 15:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiBXUrt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 15:47:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F7F5F4F5;
        Thu, 24 Feb 2022 12:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B0BF618B6;
        Thu, 24 Feb 2022 20:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D9CC340E9;
        Thu, 24 Feb 2022 20:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645735637;
        bh=FYQ8VrczMzKCYBS2fqPJjnn5DOPdGVQZpAF+gTsqXtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pxl+AbTmWvoCndwH8I+otmkcCq3c+l5agXw1C6v/+if43v26CMehYuY02ZfCAd45F
         4nKW3cPqh8CCHk7YkpP41RaexzvBOQkwKw1N7zt7spvpy3h5+N3U3EkGcpMhB7mTsE
         cJ62Qg5SFY7OuW8fljKGM5ceuxMOrI2p9Qg2ZtmLYg68jGuguYK4pvBGky2cMmN6Wk
         j5pZrNROOssdt/01NK21l3enpoMlfLf67eTlyC9KmPtpYAV5tWp3/fCnzytj4TZjsD
         Sk36mTHaau1hWFiTYbr1X4ncDCmusAhlRERC9V5As7RSP9JPWurhMnNQLubgPfklVY
         wYN/i3Z3r0ELg==
Date:   Thu, 24 Feb 2022 14:47:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20220224204715.GA291889@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222163158.1666-5-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 05:31:56PM +0100, Pali Rohár wrote:
> Add function of_pci_get_slot_power_limit(), which parses the
> 'slot-power-limit-milliwatt' DT property, returning the value in
> milliwatts and in format ready for the PCIe Slot Capabilities Register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 15 +++++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..2b0c0a3641a8 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -633,3 +633,67 @@ int of_pci_get_max_link_speed(struct device_node *node)
>  	return max_link_speed;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
> +
> +/**
> + * of_pci_get_slot_power_limit - Parses the "slot-power-limit-milliwatt"
> + *				 property.
> + *
> + * @node: device tree node with the slot power limit information
> + * @slot_power_limit_value: pointer where the value should be stored in PCIe
> + *			    Slot Capabilities Register format
> + * @slot_power_limit_scale: pointer where the scale should be stored in PCIe
> + *			    Slot Capabilities Register format
> + *
> + * Returns the slot power limit in milliwatts and if @slot_power_limit_value
> + * and @slot_power_limit_scale pointers are non-NULL, fills in the value and
> + * scale in format used by PCIe Slot Capabilities Register.
> + *
> + * If the property is not found or is invalid, returns 0.
> + */
> +u32 of_pci_get_slot_power_limit(struct device_node *node,
> +				u8 *slot_power_limit_value,
> +				u8 *slot_power_limit_scale)
> +{
> +	u32 slot_power_limit;

Including "mw" or similar reference to the units would give a hint of
how to relate the code to the spec.

> +	u8 value, scale;
> +
> +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> +				 &slot_power_limit))
> +		slot_power_limit = 0;
> +
> +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */

Add a spec reference to PCIe r6.0, sec 7.5.3.9.  IIUC, this supports
up to 300W, which was what r5.0 defined, but r6.0 added values up to
0xfe (600W).

> +	if (slot_power_limit == 0) {
> +		value = 0x00;
> +		scale = 0;
> +	} else if (slot_power_limit <= 255) {
> +		value = slot_power_limit;
> +		scale = 3;
> +	} else if (slot_power_limit <= 255*10) {
> +		value = slot_power_limit / 10;
> +		scale = 2;
> +	} else if (slot_power_limit <= 255*100) {
> +		value = slot_power_limit / 100;
> +		scale = 1;
> +	} else if (slot_power_limit <= 239*1000) {
> +		value = slot_power_limit / 1000;
> +		scale = 0;
> +	} else if (slot_power_limit <= 250*1000) {
> +		value = 0xF0;
> +		scale = 0;
> +	} else if (slot_power_limit <= 275*1000) {
> +		value = 0xF1;
> +		scale = 0;
> +	} else {
> +		value = 0xF2;
> +		scale = 0;
> +	}
> +
> +	if (slot_power_limit_value)
> +		*slot_power_limit_value = value;
> +
> +	if (slot_power_limit_scale)
> +		*slot_power_limit_scale = scale;
> +
> +	return slot_power_limit;

If "slot-power-limit-milliwatt" contains a value larger than can be
represented in "value" and "scale", the return value will not agree
with value/scale, will it?

Currently you only use the return value for a log message, so no real
harm yet, other than the fact that we might print "Slot power limit
1000.0W" when the hardware will only advertise 600W available.

Also, if "slot-power-limit-milliwatt" contains something like
260000 mW (260 W), we'll return 0xF1/0, so the hardware will
advertise 275 W available.

> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..e10cdec6c56e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -627,6 +627,9 @@ struct device_node;
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  int of_get_pci_domain_nr(struct device_node *node);
>  int of_pci_get_max_link_speed(struct device_node *node);
> +u32 of_pci_get_slot_power_limit(struct device_node *node,
> +				u8 *slot_power_limit_value,
> +				u8 *slot_power_limit_scale);
>  void pci_set_of_node(struct pci_dev *dev);
>  void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
> @@ -653,6 +656,18 @@ of_pci_get_max_link_speed(struct device_node *node)
>  	return -EINVAL;
>  }
>  
> +static inline u32
> +of_pci_get_slot_power_limit(struct device_node *node,
> +			    u8 *slot_power_limit_value,
> +			    u8 *slot_power_limit_scale)
> +{
> +	if (slot_power_limit_value)
> +		*slot_power_limit_value = 0;
> +	if (slot_power_limit_scale)
> +		*slot_power_limit_scale = 0;
> +	return 0;
> +}
> +
>  static inline void pci_set_of_node(struct pci_dev *dev) { }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> -- 
> 2.20.1
> 
