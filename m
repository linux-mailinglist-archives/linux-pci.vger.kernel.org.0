Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68948CE69
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 23:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiALW2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 17:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiALW23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 17:28:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB62C061756;
        Wed, 12 Jan 2022 14:28:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0C14B8213B;
        Wed, 12 Jan 2022 22:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FCBC36AE5;
        Wed, 12 Jan 2022 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642026505;
        bh=BPXFoWwpMt4UufdPm8cbHymgT2ys4poVS5bIQq+IgLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f40SEp8uvcn1vgzQjshFynrsRmgFwwVgtEve75CYp6icUo2lVEf2o22XUblX1gqYm
         v3DLYWVWQvl7TW27UtMu20fEvssZqniCldSCK+QtYBt4+9i217VU+/sQLizr6xH3bx
         /wsVEPTlZlrdrOMJbwcUiB6jcxU+Cw5lPp12TJtFqrDW89J/pv5FfaraVGlZE7SOUb
         xb/r7XfDfDax04szP8auIcF6FQGpa99eQ7ahxL5pToa2TGEmmusaNPEn7DOrh0+E3k
         TTz4/8fiY05VBKZnk2fJoCSXxanNzRazVSGb8Q8BjfjxVd3f3sbQ+ZgD6xMoUuQdfk
         lFjNMPqRee5Yg==
Received: by pali.im (Postfix)
        id 49AA5768; Wed, 12 Jan 2022 23:28:22 +0100 (CET)
Date:   Wed, 12 Jan 2022 23:28:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH dt + pci 2/2] PCI: Add function for parsing
 `slot-power-limit-milliwatt` DT property
Message-ID: <20220112222822.7yirl7k57ju5d2ox@pali>
References: <20211031150706.27873-2-kabel@kernel.org>
 <20220112220815.GA287870@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112220815.GA287870@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 12 January 2022 16:08:15 Bjorn Helgaas wrote:
> On Sun, Oct 31, 2021 at 04:07:06PM +0100, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > Add function of_pci_get_slot_power_limit(), which parses the
> > `slot-power-limit-milliwatt` DT property, returning the value in
> > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Do we have a caller of of_pci_get_slot_power_limit() yet?  I didn't
> see one from a quick look
> (https://lore.kernel.org/linux-pci/?q=b%3Aof_pci_get_slot_power_limit).
> 
> Let's merge this when we have a user for it.

I have a patch for both pci-mvebu.c and pci-aardvark.c drivers. But
there are lot of patches for these drivers waiting on mailing list for
review... Should I sent another patch for pci-mvebu.c which will use
this of_pci_get_slot_power_limit() function?

> > ---
> >  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h | 15 +++++++++++
> >  2 files changed, 79 insertions(+)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index d84381ce82b5..9c1a38d5dd99 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -627,3 +627,67 @@ int of_pci_get_max_link_speed(struct device_node *node)
> >  	return max_link_speed;
> >  }
> >  EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
> > +
> > +/**
> > + * of_pci_get_slot_power_limit - Parses the "slot-power-limit-milliwatt"
> > + *				 property.
> > + *
> > + * @node: device tree node with the slot power limit information
> > + * @slot_power_limit_value: pointer where the value should be stored in PCIe
> > + *			    Slot Capabilities Register format
> > + * @slot_power_limit_scale: pointer where the scale should be stored in PCIe
> > + *			    Slot Capabilities Register format
> > + *
> > + * Returns the slot power limit in milliwatts and if @slot_power_limit_value
> > + * and @slot_power_limit_scale pointers are non-NULL, fills in the value and
> > + * scale in format used by PCIe Slot Capabilities Register.
> > + *
> > + * If the property is not found or is invalid, returns 0.
> > + */
> > +u32 of_pci_get_slot_power_limit(struct device_node *node,
> > +				u8 *slot_power_limit_value,
> > +				u8 *slot_power_limit_scale)
> > +{
> > +	u32 slot_power_limit;
> > +	u8 value, scale;
> > +
> > +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> > +				 &slot_power_limit))
> > +		slot_power_limit = 0;
> > +
> > +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> > +	if (slot_power_limit == 0) {
> > +		value = 0x00;
> > +		scale = 0;
> > +	} else if (slot_power_limit <= 255) {
> > +		value = slot_power_limit;
> > +		scale = 3;
> > +	} else if (slot_power_limit <= 255*10) {
> > +		value = slot_power_limit / 10;
> > +		scale = 2;
> > +	} else if (slot_power_limit <= 255*100) {
> > +		value = slot_power_limit / 100;
> > +		scale = 1;
> > +	} else if (slot_power_limit <= 239*1000) {
> > +		value = slot_power_limit / 1000;
> > +		scale = 0;
> > +	} else if (slot_power_limit <= 250*1000) {
> > +		value = 0xF0;
> > +		scale = 0;
> > +	} else if (slot_power_limit <= 275*1000) {
> > +		value = 0xF1;
> > +		scale = 0;
> > +	} else {
> > +		value = 0xF2;
> > +		scale = 0;
> > +	}
> > +
> > +	if (slot_power_limit_value)
> > +		*slot_power_limit_value = value;
> > +
> > +	if (slot_power_limit_scale)
> > +		*slot_power_limit_scale = scale;
> > +
> > +	return slot_power_limit;
> > +}
> > +EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 1cce56c2aea0..9352278141be 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -665,6 +665,9 @@ struct device_node;
> >  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
> >  int of_get_pci_domain_nr(struct device_node *node);
> >  int of_pci_get_max_link_speed(struct device_node *node);
> > +u32 of_pci_get_slot_power_limit(struct device_node *node,
> > +				u8 *slot_power_limit_value,
> > +				u8 *slot_power_limit_scale);
> >  void pci_set_of_node(struct pci_dev *dev);
> >  void pci_release_of_node(struct pci_dev *dev);
> >  void pci_set_bus_of_node(struct pci_bus *bus);
> > @@ -691,6 +694,18 @@ of_pci_get_max_link_speed(struct device_node *node)
> >  	return -EINVAL;
> >  }
> >  
> > +static inline u32
> > +of_pci_get_slot_power_limit(struct device_node *node,
> > +			    u8 *slot_power_limit_value,
> > +			    u8 *slot_power_limit_scale)
> > +{
> > +	if (slot_power_limit_value)
> > +		*slot_power_limit_value = 0;
> > +	if (slot_power_limit_scale)
> > +		*slot_power_limit_scale = 0;
> > +	return 0;
> > +}
> > +
> >  static inline void pci_set_of_node(struct pci_dev *dev) { }
> >  static inline void pci_release_of_node(struct pci_dev *dev) { }
> >  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> > -- 
> > 2.32.0
> > 
