Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5ED4F9968
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiDHP36 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiDHP36 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 11:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D063981B;
        Fri,  8 Apr 2022 08:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A775961FB8;
        Fri,  8 Apr 2022 15:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C8FC385A1;
        Fri,  8 Apr 2022 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649431672;
        bh=spbvvLexuDlNOPAlzsWxyFyJy2c3S3c/xnyxDLTAJKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s3T+UM3bbC990eRqsi6NhvUT6CFbXbUzlJJ7VAxn07ZBhzQG+29cnyImFqJ3u727w
         pZEJ8O19sk/acW3gVNyv6AW5ROMaWOvbxBWslRzWb4LsTYFLl1A74/eY13LTuYBW0H
         LKbHb/t/fq6qI9uQDXerF3hB2GuwbykX3lAax31pCM380YN3KO75K9fkEul73+/cge
         4IuvRaeP31LFPmQo1jOBvS2it/GgVn88HwAt40v24EBVYTRGoqdKWIuaJNAmFl7xXD
         mnUaCEJL6geLSL3bGHQbqjYjrB24GZZNBIhraFJa4bnwy5dhrBYDLMdZ6e9Yo/q3mv
         b17lE59IperfQ==
Date:   Fri, 8 Apr 2022 10:27:50 -0500
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
Subject: Re: [PATCH v3 3/4] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20220408152750.GA306189@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220325093827.4983-4-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 25, 2022 at 10:38:26AM +0100, Pali Rohár wrote:
> Add function of_pci_get_slot_power_limit(), which parses the
> 'slot-power-limit-milliwatt' DT property, returning the value in
> milliwatts and in format ready for the PCIe Slot Capabilities Register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> * Set 600 W when DT slot-power-limit-milliwatt > 600 W
> Changes in v2:
> * Added support for PCIe 6.0 slot power limit encodings
> * Round down slot power limit value
> ---
>  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 15 +++++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..5ebff26edd41 100644
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
> +	} else if (slot_power_limit_mw <= 255*100) {
> +		value = slot_power_limit_mw / 100;
> +		scale = 1;
> +	} else if (slot_power_limit_mw <= 239*1000) {
> +		value = slot_power_limit_mw / 1000;
> +		scale = 0;
> +	} else if (slot_power_limit_mw <= 250*1000) {
> +		value = 0xF0;
> +		scale = 0;

I think the spec is poorly worded here.  PCIe r6.0, sec 7.5.3.9, says:

  F0h   > 239 W and <= 250 W Slot Power Limit

I don't think it's meaningful for the spec to include a range here.
The amount of power the slot can supply has a single maximum.  I
suspect the *intent* of F0h/00b is that a device in the slot may
consume up to 250W.

Your code above would mean that slot_power_limit_mw == 245,000 would
cause the slot to advertise F0h/00b (250W), which seems wrong.

I think we should do something like this instead:

  scale = 0;
  if (slot_power_limit_mw >= 600*1000) {
    value = 0xFE;
    slot_power_limit_mw = 600*1000;
  } else if (slot_power_limit_mw >= 575*1000) {
    value = 0xFD;
    slot_power_limit_mw = 575*1000;
  } ...

I raised an issue with the PCI SIG about this.

> +	} else if (slot_power_limit_mw <= 600*1000) {
> +		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
> +		scale = 0;
> +	} else {
> +		value = 0xFE;
> +		scale = 0;
> +	}
> +
> +	if (slot_power_limit_value)
> +		*slot_power_limit_value = value;
> +
> +	if (slot_power_limit_scale)
> +		*slot_power_limit_scale = scale;
> +
> +	return slot_power_limit_mw;

If the DT tells us 800W is available, we'll store (FEh/00b), which
means the slot can advertise to a downstream device that 600W is
available.  I think that's correct, since the current spec doesn't
provide a way to encode any value larger than 600W.

But the function still returns 800,000 mW, which means the next patch will
print:

  %s: Slot power limit 800.0W

even though it programs Slot Capabilities to advertise 600W.
That's why I suggested setting slot_power_limit_mw = 600*1000 above.

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
