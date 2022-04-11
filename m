Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AC4FC554
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiDKT44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 15:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbiDKT4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 15:56:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6171DA43;
        Mon, 11 Apr 2022 12:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6253BB81896;
        Mon, 11 Apr 2022 19:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01EBC385A3;
        Mon, 11 Apr 2022 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649706876;
        bh=bOc/33Z7+1jn2eHnVDtC0HCa/hvdIrrV1vtEJE1e728=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V6+ZhQQJ0FpA3JTLhfNdMXpuSewBXjtopDEltHhlXbZSpO78QxEP1ZcpA53xrUGsh
         JZIgs+nnioj5B5rZ6ZYyOhb7PDCoD7KmnK/a9wN3yFN+gEevKq5C7FKAGKVSdCXq5Y
         OyOxDtW+tcvHx+oApyxc1n3O0GdcPQcKVQnC4aO+t4AYiy/7D5M4rDnBXkLUpIdGcF
         Mn1DGUs5kOloLRJHvN8s17W01fSA3P9CNLtNXxfP1Wp5sxhX29Q5fOgOnp+bAuGyJV
         H1WckifF0+jHHfVPXfJsIFHHTscgId3sxp4qkX7Zoj7qKahszAXlbLGHQ5S4ktxgJV
         SPyfAAuKNR0Sw==
Date:   Mon, 11 Apr 2022 14:54:34 -0500
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
Message-ID: <20220411195434.GA531670@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411111407.7ycuoldxjvqnkoo4@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 01:14:07PM +0200, Pali Rohár wrote:
> On Friday 08 April 2022 10:27:50 Bjorn Helgaas wrote:
> > On Fri, Mar 25, 2022 at 10:38:26AM +0100, Pali Rohár wrote:
> > > Add function of_pci_get_slot_power_limit(), which parses the
> > > 'slot-power-limit-milliwatt' DT property, returning the value in
> > > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changes in v3:
> > > * Set 600 W when DT slot-power-limit-milliwatt > 600 W
> > > Changes in v2:
> > > * Added support for PCIe 6.0 slot power limit encodings
> > > * Round down slot power limit value
> > > ---
> > >  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.h | 15 +++++++++++
> > >  2 files changed, 79 insertions(+)
> > > 
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index cb2e8351c2cc..5ebff26edd41 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -633,3 +633,67 @@ int of_pci_get_max_link_speed(struct device_node *node)
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
> > > +	} else if (slot_power_limit_mw <= 255*100) {
> > > +		value = slot_power_limit_mw / 100;
> > > +		scale = 1;
> > > +	} else if (slot_power_limit_mw <= 239*1000) {
> > > +		value = slot_power_limit_mw / 1000;
> > > +		scale = 0;
> > > +	} else if (slot_power_limit_mw <= 250*1000) {
> > > +		value = 0xF0;
> > > +		scale = 0;
> > 
> > I think the spec is poorly worded here.  PCIe r6.0, sec 7.5.3.9, says:
> > 
> >   F0h   > 239 W and <= 250 W Slot Power Limit
> > 
> > I don't think it's meaningful for the spec to include a range here.
> > The amount of power the slot can supply has a single maximum.  I
> > suspect the *intent* of F0h/00b is that a device in the slot may
> > consume up to 250W.
> > 
> > Your code above would mean that slot_power_limit_mw == 245,000 would
> > cause the slot to advertise F0h/00b (250W), which seems wrong.
> 
> So for slot_power_limit_mw == 245 W we should set following values?
> 
>   slot_power_limit_mw = 239 W
>   value = 0xF0
>   scale = 0

I think Slot Cap should never advertise more power than the slot can
supply.  So if the DT tells us the slot can supply 245 W, I don't
think Slot Cap should advertise that it can supply 250 W.  I think we
should drop down to the next lower possible value, which is 239 W
(value 0xEF, scale 0).  I think this is what your v4 does.

> > I think we should do something like this instead:
> > 
> >   scale = 0;
> >   if (slot_power_limit_mw >= 600*1000) {
> >     value = 0xFE;
> >     slot_power_limit_mw = 600*1000;
> >   } else if (slot_power_limit_mw >= 575*1000) {
> >     value = 0xFD;
> >     slot_power_limit_mw = 575*1000;
> >   } ...
> 
> This is already implemented in branch:
> 
>   } else if (slot_power_limit_mw <= 600*1000) {
>   	value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
>   	scale = 0;

OK, I was thinking there was a hole here, but I guess not.  I think do
think it's easier to read and verify if it's structured as "the slot
can supply at least X, so advertise X", as opposed to "the slot can
supply X or less, so advertise Y".

Bjorn
