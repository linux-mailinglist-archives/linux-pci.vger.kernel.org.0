Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81A50A9D0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377500AbiDUURN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiDUURL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 16:17:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6AC3ED04;
        Thu, 21 Apr 2022 13:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EED28B82910;
        Thu, 21 Apr 2022 20:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A08C385A5;
        Thu, 21 Apr 2022 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650572057;
        bh=XIQ3s+b4ff6OpMBRDGPpBLyqIwyf91wLJo75diArt8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plOPHo5fXwncWwq4SvpfVvtHFDSF5m8UV7y3GAK9ytEIAsZ7UNUNnS89x3/foNN4x
         VmtJ0sRwJn0e+1bQ3PzYB1UIPxb93WM6lSXRISW6OF9oZOe+rJa8zlOaqS+bqfSSHD
         Dqt54zp839clupkSJZvWCcO0DHpUxLI67a20hq+jGdJQU003YS9upnYRr65LhWDKnr
         VdmnJk6wzxeL8cHroPQVjMJ8OhtQYquCQ6KVPtZaQaKLcux5SASY4d2OaKRRIsvF+n
         bngLgyifaI5YL3oBrnHEW99ZmP4rMxzIAMwbBVX/3vT4QrbJQ3x54AstzhQz4xlI4I
         iUJjvKGCMALtw==
Received: by pali.im (Postfix)
        id 21A7FCD7; Thu, 21 Apr 2022 22:14:14 +0200 (CEST)
Date:   Thu, 21 Apr 2022 22:14:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20220421201413.hwpfby4i5tvhwxqv@pali>
References: <20220412094946.27069-4-pali@kernel.org>
 <20220413202433.GA688099@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220413202433.GA688099@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 13 April 2022 15:24:33 Bjorn Helgaas wrote:
> On Tue, Apr 12, 2022 at 11:49:45AM +0200, Pali Rohár wrote:
> > Add function of_pci_get_slot_power_limit(), which parses the
> > 'slot-power-limit-milliwatt' DT property, returning the value in
> > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Looks good to me!  Thank you!
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Perfect!

Lorenzo, is this patch series OK now for merging?

> > ---
> > Changes in v4:
> > * Set 239 W when DT slot-power-limit-milliwatt is between 239 W and 250 W
> > * Fix returning power limit value
> > Changes in v3:
> > * Set 600 W when DT slot-power-limit-milliwatt > 600 W
> > Changes in v2:
> > * Added support for PCIe 6.0 slot power limit encodings
> > * Round down slot power limit value
> > ---
> >  drivers/pci/of.c  | 70 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h | 15 ++++++++++
> >  2 files changed, 85 insertions(+)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index cb2e8351c2cc..6c1b81304665 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -633,3 +633,73 @@ int of_pci_get_max_link_speed(struct device_node *node)
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
> > +	u32 slot_power_limit_mw;
> > +	u8 value, scale;
> > +
> > +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> > +				 &slot_power_limit_mw))
> > +		slot_power_limit_mw = 0;
> > +
> > +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> > +	if (slot_power_limit_mw == 0) {
> > +		value = 0x00;
> > +		scale = 0;
> > +	} else if (slot_power_limit_mw <= 255) {
> > +		value = slot_power_limit_mw;
> > +		scale = 3;
> > +	} else if (slot_power_limit_mw <= 255*10) {
> > +		value = slot_power_limit_mw / 10;
> > +		scale = 2;
> > +		slot_power_limit_mw = slot_power_limit_mw / 10 * 10;
> > +	} else if (slot_power_limit_mw <= 255*100) {
> > +		value = slot_power_limit_mw / 100;
> > +		scale = 1;
> > +		slot_power_limit_mw = slot_power_limit_mw / 100 * 100;
> > +	} else if (slot_power_limit_mw <= 239*1000) {
> > +		value = slot_power_limit_mw / 1000;
> > +		scale = 0;
> > +		slot_power_limit_mw = slot_power_limit_mw / 1000 * 1000;
> > +	} else if (slot_power_limit_mw < 250*1000) {
> > +		value = 0xEF;
> > +		scale = 0;
> > +		slot_power_limit_mw = 239*1000;
> > +	} else if (slot_power_limit_mw <= 600*1000) {
> > +		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
> > +		scale = 0;
> > +		slot_power_limit_mw = slot_power_limit_mw / (1000*25) * (1000*25);
> > +	} else {
> > +		value = 0xFE;
> > +		scale = 0;
> > +		slot_power_limit_mw = 600*1000;
> > +	}
> > +
> > +	if (slot_power_limit_value)
> > +		*slot_power_limit_value = value;
> > +
> > +	if (slot_power_limit_scale)
> > +		*slot_power_limit_scale = scale;
> > +
> > +	return slot_power_limit_mw;
> > +}
> > +EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 3d60cabde1a1..e10cdec6c56e 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -627,6 +627,9 @@ struct device_node;
> >  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
> >  int of_get_pci_domain_nr(struct device_node *node);
> >  int of_pci_get_max_link_speed(struct device_node *node);
> > +u32 of_pci_get_slot_power_limit(struct device_node *node,
> > +				u8 *slot_power_limit_value,
> > +				u8 *slot_power_limit_scale);
> >  void pci_set_of_node(struct pci_dev *dev);
> >  void pci_release_of_node(struct pci_dev *dev);
> >  void pci_set_bus_of_node(struct pci_bus *bus);
> > @@ -653,6 +656,18 @@ of_pci_get_max_link_speed(struct device_node *node)
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
> > 2.20.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
