Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167F650B4A5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446196AbiDVKJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 06:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446197AbiDVKJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 06:09:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5882853737;
        Fri, 22 Apr 2022 03:06:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06DF01477;
        Fri, 22 Apr 2022 03:06:12 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.12.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E6B3F766;
        Fri, 22 Apr 2022 03:06:10 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:06:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20220422100604.GA500@lpieralisi>
References: <20220412094946.27069-4-pali@kernel.org>
 <20220413202433.GA688099@bhelgaas>
 <20220421201413.hwpfby4i5tvhwxqv@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421201413.hwpfby4i5tvhwxqv@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 21, 2022 at 10:14:13PM +0200, Pali Rohár wrote:
> On Wednesday 13 April 2022 15:24:33 Bjorn Helgaas wrote:
> > On Tue, Apr 12, 2022 at 11:49:45AM +0200, Pali Rohár wrote:
> > > Add function of_pci_get_slot_power_limit(), which parses the
> > > 'slot-power-limit-milliwatt' DT property, returning the value in
> > > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > Looks good to me!  Thank you!
> > 
> > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Perfect!
> 
> Lorenzo, is this patch series OK now for merging?

Yes it is. I have a related question (ie how to check whether a binding
has been accepted into the DT schema) but I will sort that out with
Rob.

Thanks,
Lorenzo

> > > ---
> > > Changes in v4:
> > > * Set 239 W when DT slot-power-limit-milliwatt is between 239 W and 250 W
> > > * Fix returning power limit value
> > > Changes in v3:
> > > * Set 600 W when DT slot-power-limit-milliwatt > 600 W
> > > Changes in v2:
> > > * Added support for PCIe 6.0 slot power limit encodings
> > > * Round down slot power limit value
> > > ---
> > >  drivers/pci/of.c  | 70 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.h | 15 ++++++++++
> > >  2 files changed, 85 insertions(+)
> > > 
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index cb2e8351c2cc..6c1b81304665 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -633,3 +633,73 @@ int of_pci_get_max_link_speed(struct device_node *node)
> > >  	return max_link_speed;
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
> > > +
> > > +/**
> > > + * of_pci_get_slot_power_limit - Parses the "slot-power-limit-milliwatt"
> > > + *				 property.
> > > + *
> > > + * @node: device tree node with the slot power limit information
> > > + * @slot_power_limit_value: pointer where the value should be stored in PCIe
> > > + *			    Slot Capabilities Register format
> > > + * @slot_power_limit_scale: pointer where the scale should be stored in PCIe
> > > + *			    Slot Capabilities Register format
> > > + *
> > > + * Returns the slot power limit in milliwatts and if @slot_power_limit_value
> > > + * and @slot_power_limit_scale pointers are non-NULL, fills in the value and
> > > + * scale in format used by PCIe Slot Capabilities Register.
> > > + *
> > > + * If the property is not found or is invalid, returns 0.
> > > + */
> > > +u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > +				u8 *slot_power_limit_value,
> > > +				u8 *slot_power_limit_scale)
> > > +{
> > > +	u32 slot_power_limit_mw;
> > > +	u8 value, scale;
> > > +
> > > +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> > > +				 &slot_power_limit_mw))
> > > +		slot_power_limit_mw = 0;
> > > +
> > > +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> > > +	if (slot_power_limit_mw == 0) {
> > > +		value = 0x00;
> > > +		scale = 0;
> > > +	} else if (slot_power_limit_mw <= 255) {
> > > +		value = slot_power_limit_mw;
> > > +		scale = 3;
> > > +	} else if (slot_power_limit_mw <= 255*10) {
> > > +		value = slot_power_limit_mw / 10;
> > > +		scale = 2;
> > > +		slot_power_limit_mw = slot_power_limit_mw / 10 * 10;
> > > +	} else if (slot_power_limit_mw <= 255*100) {
> > > +		value = slot_power_limit_mw / 100;
> > > +		scale = 1;
> > > +		slot_power_limit_mw = slot_power_limit_mw / 100 * 100;
> > > +	} else if (slot_power_limit_mw <= 239*1000) {
> > > +		value = slot_power_limit_mw / 1000;
> > > +		scale = 0;
> > > +		slot_power_limit_mw = slot_power_limit_mw / 1000 * 1000;
> > > +	} else if (slot_power_limit_mw < 250*1000) {
> > > +		value = 0xEF;
> > > +		scale = 0;
> > > +		slot_power_limit_mw = 239*1000;
> > > +	} else if (slot_power_limit_mw <= 600*1000) {
> > > +		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
> > > +		scale = 0;
> > > +		slot_power_limit_mw = slot_power_limit_mw / (1000*25) * (1000*25);
> > > +	} else {
> > > +		value = 0xFE;
> > > +		scale = 0;
> > > +		slot_power_limit_mw = 600*1000;
> > > +	}
> > > +
> > > +	if (slot_power_limit_value)
> > > +		*slot_power_limit_value = value;
> > > +
> > > +	if (slot_power_limit_scale)
> > > +		*slot_power_limit_scale = scale;
> > > +
> > > +	return slot_power_limit_mw;
> > > +}
> > > +EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 3d60cabde1a1..e10cdec6c56e 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -627,6 +627,9 @@ struct device_node;
> > >  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
> > >  int of_get_pci_domain_nr(struct device_node *node);
> > >  int of_pci_get_max_link_speed(struct device_node *node);
> > > +u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > +				u8 *slot_power_limit_value,
> > > +				u8 *slot_power_limit_scale);
> > >  void pci_set_of_node(struct pci_dev *dev);
> > >  void pci_release_of_node(struct pci_dev *dev);
> > >  void pci_set_bus_of_node(struct pci_bus *bus);
> > > @@ -653,6 +656,18 @@ of_pci_get_max_link_speed(struct device_node *node)
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +static inline u32
> > > +of_pci_get_slot_power_limit(struct device_node *node,
> > > +			    u8 *slot_power_limit_value,
> > > +			    u8 *slot_power_limit_scale)
> > > +{
> > > +	if (slot_power_limit_value)
> > > +		*slot_power_limit_value = 0;
> > > +	if (slot_power_limit_scale)
> > > +		*slot_power_limit_scale = 0;
> > > +	return 0;
> > > +}
> > > +
> > >  static inline void pci_set_of_node(struct pci_dev *dev) { }
> > >  static inline void pci_release_of_node(struct pci_dev *dev) { }
> > >  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> > > -- 
> > > 2.20.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
