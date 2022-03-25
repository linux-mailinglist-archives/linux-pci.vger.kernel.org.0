Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2260D4E6FE6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 10:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356586AbiCYJV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356541AbiCYJVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 05:21:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81BBCF48C;
        Fri, 25 Mar 2022 02:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60A0C60C33;
        Fri, 25 Mar 2022 09:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A01C340E9;
        Fri, 25 Mar 2022 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648200017;
        bh=lxwHTABmCN1CazROEdpejwhPX+nwGGj7wnIuHcqcTZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYxt8xCECLPqXVdNHCptJNzUFZzBhfTL09WONwZX7s/1yqG4DSTMEy03TGOAi7hxR
         T9IHLyZ1xPrudvbKDYUgxUZwJYqNqMTP5OJ2+2x7gsDmuTBp+pDKewmvcfIa4OyH51
         I47vMRUd3fw/s971NUzdp0ccyT5ME8wMLWMfizeEGuI5GNZQn0zxbgAGgcjKNCXwRp
         nKUocdjQAz8SkrJwN2cCiLIrILerDZU46uDCBtMYOPf9utnR6ik8oBMpuknqxU5/mo
         zRP7IsSJKJT1kis4nzAJNHliEoVWuwu3XLrqWWYYjYmeXiKeIe/42ogv9gP+J+cgKO
         5547Xbu3oJSfg==
Received: by pali.im (Postfix)
        id 811B97DD; Fri, 25 Mar 2022 10:20:14 +0100 (CET)
Date:   Fri, 25 Mar 2022 10:20:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20220325092014.yfxf474odzqfymml@pali>
References: <20220302145733.12606-4-pali@kernel.org>
 <20220324171337.GA1458545@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220324171337.GA1458545@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 March 2022 12:13:37 Bjorn Helgaas wrote:
> On Wed, Mar 02, 2022 at 03:57:32PM +0100, Pali Rohár wrote:
> > Add function of_pci_get_slot_power_limit(), which parses the
> > 'slot-power-limit-milliwatt' DT property, returning the value in
> > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes in v2:
> > * Added support for PCIe 6.0 slot power limit encodings
> > * Round down slot power limit value
> > ---
> >  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h | 15 +++++++++++
> >  2 files changed, 79 insertions(+)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index cb2e8351c2cc..549a404bd536 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -633,3 +633,67 @@ int of_pci_get_max_link_speed(struct device_node *node)
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
> > +	} else if (slot_power_limit_mw <= 255*100) {
> > +		value = slot_power_limit_mw / 100;
> > +		scale = 1;
> > +	} else if (slot_power_limit_mw <= 239*1000) {
> > +		value = slot_power_limit_mw / 1000;
> > +		scale = 0;
> > +	} else if (slot_power_limit_mw <= 250*1000) {
> > +		value = 0xF0;
> > +		scale = 0;
> > +	} else if (slot_power_limit_mw <= 600*1000) {
> > +		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
> > +		scale = 0;
> > +	} else {
> > +		value = 0xFF;
> > +		scale = 0;
> 
> The purpose of this function is to return values that can be
> programmed into the Slot Capabilities register.  The 0xFF Slot Power
> Limit Value is reserved, and I don't think we should use it until the
> spec defines a meaning for it.
> 
> If the DT tells us 800W is available, we'll put 0xFF in Slot Power
> Limit Value.  If the spec eventually defines (0xFF, 0) to mean "1000W
> available", a device may try to consume all 1000W, which will not
> work.
> 
> If slot_power_limit_mw > 600*1000, I think we should advertise 600W
> available (value 0xFE, scale 0) and return 600W (600*1000).
> 
> Bjorn

Ok, I will send a v3 with this change.
