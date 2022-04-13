Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752304FFFEE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 22:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiDMU1D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiDMU1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 16:27:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702203BF95;
        Wed, 13 Apr 2022 13:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05DB8B826A7;
        Wed, 13 Apr 2022 20:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DC9C385A3;
        Wed, 13 Apr 2022 20:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649881474;
        bh=2RUFHWOD1DBlUTn0rn61mqQySRcJDmALxwyHtmWQLn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aPH+4hetSldTnCtYHjSjHZlS36hTdhia7zn2zq5SX+9G3sxebtuIGhxzH4OX+gewX
         PwKr+qSWt43HeN9yS2K6MnnPAPG8eQ8M7OHsb0I5BTWocd687ok+ILwuCKlqU/9+HS
         2jifTC9ITN1nypIBnd1AnFFy6wzKK6342rYpa8cEAusITN6nQFyFfbQJAhrikjtyLz
         /+ghhMdq4TNhVltD1YGkZ6B79kRNI6KvcS7IVuRLq8QAagLI0/fjR7YjpmNlp5GxuD
         j/XV3OtY6eRyeRVPZRo5ShiVXbh48oY1pTyGusvti9IMmzdPJW+wjHfKwWzdtnuDAg
         lRhsVVhxYZ2XQ==
Date:   Wed, 13 Apr 2022 15:24:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20220413202433.GA688099@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412094946.27069-4-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 11:49:45AM +0200, Pali Rohár wrote:
> Add function of_pci_get_slot_power_limit(), which parses the
> 'slot-power-limit-milliwatt' DT property, returning the value in
> milliwatts and in format ready for the PCIe Slot Capabilities Register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Looks good to me!  Thank you!

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Changes in v4:
> * Set 239 W when DT slot-power-limit-milliwatt is between 239 W and 250 W
> * Fix returning power limit value
> Changes in v3:
> * Set 600 W when DT slot-power-limit-milliwatt > 600 W
> Changes in v2:
> * Added support for PCIe 6.0 slot power limit encodings
> * Round down slot power limit value
> ---
>  drivers/pci/of.c  | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 15 ++++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..6c1b81304665 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -633,3 +633,73 @@ int of_pci_get_max_link_speed(struct device_node *node)
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
> +	u32 slot_power_limit_mw;
> +	u8 value, scale;
> +
> +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> +				 &slot_power_limit_mw))
> +		slot_power_limit_mw = 0;
> +
> +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> +	if (slot_power_limit_mw == 0) {
> +		value = 0x00;
> +		scale = 0;
> +	} else if (slot_power_limit_mw <= 255) {
> +		value = slot_power_limit_mw;
> +		scale = 3;
> +	} else if (slot_power_limit_mw <= 255*10) {
> +		value = slot_power_limit_mw / 10;
> +		scale = 2;
> +		slot_power_limit_mw = slot_power_limit_mw / 10 * 10;
> +	} else if (slot_power_limit_mw <= 255*100) {
> +		value = slot_power_limit_mw / 100;
> +		scale = 1;
> +		slot_power_limit_mw = slot_power_limit_mw / 100 * 100;
> +	} else if (slot_power_limit_mw <= 239*1000) {
> +		value = slot_power_limit_mw / 1000;
> +		scale = 0;
> +		slot_power_limit_mw = slot_power_limit_mw / 1000 * 1000;
> +	} else if (slot_power_limit_mw < 250*1000) {
> +		value = 0xEF;
> +		scale = 0;
> +		slot_power_limit_mw = 239*1000;
> +	} else if (slot_power_limit_mw <= 600*1000) {
> +		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
> +		scale = 0;
> +		slot_power_limit_mw = slot_power_limit_mw / (1000*25) * (1000*25);
> +	} else {
> +		value = 0xFE;
> +		scale = 0;
> +		slot_power_limit_mw = 600*1000;
> +	}
> +
> +	if (slot_power_limit_value)
> +		*slot_power_limit_value = value;
> +
> +	if (slot_power_limit_scale)
> +		*slot_power_limit_scale = scale;
> +
> +	return slot_power_limit_mw;
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
