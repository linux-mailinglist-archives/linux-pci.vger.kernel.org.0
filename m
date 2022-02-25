Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E84C499B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 16:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiBYPwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 10:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBYPwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 10:52:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3771CFA3E;
        Fri, 25 Feb 2022 07:51:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6677C61A25;
        Fri, 25 Feb 2022 15:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADA1C340E7;
        Fri, 25 Feb 2022 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804317;
        bh=V9gJHhPgPqYllsqDsYnBl3rnZBElaZYYZJ2q/xpB/No=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WEk/mxCcR8c9X+m2Z4durgNFf+0qvvd7AG/+ROPJjpBFyRpabW4dABD2ySstG3j2f
         jp9uhnRdKazS/n26oWz5/7btI+Xb6yWKKZzIOjdkNLt64TevZXygM1x11kpG92VMIP
         IA1PzDrWJ52Kko8oOADOn7d5mFE0Jmvl/+AZTnUsQRlOAqBf3EKzYs/xojzLoTpXFc
         UCrvm3Hvtes2eV7qCmFvQe/pZED2IZhJBpYWicqUog3dmSSD11bq0GJLtlt1Xb57Gs
         3DJ9csSRP3wIqHNIHgw+Kiorj0wIJJa3xUaQ0oaSEy/+bxTtSpxe4pxkIDty2zjFRz
         m5IbU0fG9Jg4Q==
Date:   Fri, 25 Feb 2022 09:51:56 -0600
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
Message-ID: <20220225155156.GA358965@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225123051.xlsv7fkesdf5upeh@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 01:30:51PM +0100, Pali Rohár wrote:
> On Thursday 24 February 2022 14:47:15 Bjorn Helgaas wrote:
> > On Tue, Feb 22, 2022 at 05:31:56PM +0100, Pali Rohár wrote:
> > > Add function of_pci_get_slot_power_limit(), which parses the
> > > 'slot-power-limit-milliwatt' DT property, returning the value in
> > > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.h | 15 +++++++++++
> > >  2 files changed, 79 insertions(+)
> > > 
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index cb2e8351c2cc..2b0c0a3641a8 100644
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
> > > +	u32 slot_power_limit;
> > 
> > Including "mw" or similar reference to the units would give a hint of
> > how to relate the code to the spec.
> > 
> > > +	u8 value, scale;
> > > +
> > > +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> > > +				 &slot_power_limit))
> > > +		slot_power_limit = 0;
> > > +
> > > +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> > 
> > Add a spec reference to PCIe r6.0, sec 7.5.3.9.  IIUC, this supports
> > up to 300W, which was what r5.0 defined, but r6.0 added values up to
> > 0xfe (600W).
> 
> I did not know about it and I have not seen/read r6.0.
> 
> It would be nice if somebody with access to r6.0 send a patch to lspci
> utility, so we could write support for 600W based on lspci parser.

Of course, sorry!  Obviously you would have implemented them all if
you had the spec!

Here's the info from r6.0, sec 7.5.3.9:

  Slot Power Limit Value - In combination with the Slot Power Limit
  Scale value, specifies the upper limit on power supplied by the slot
  (see § Section 6.9) or by other means to the adapter.

  Power limit (in Watts) is calculated by multiplying the value in
  this field by the value in the Slot Power Limit Scale field except
  when the Slot Power Limit Scale field equals 00b (1.0x) and Slot
  Power Limit Value exceeds EFh, the following alternative encodings
  are used:

    F0h   > 239 W and ≤ 250 W Slot Power Limit
    F1h   > 250 W and ≤ 275 W Slot Power Limit
    F2h   > 275 W and ≤ 300 W Slot Power Limit
    F3h   > 300 W and ≤ 325 W Slot Power Limit
    F4h   > 325 W and ≤ 350 W Slot Power Limit
    F5h   > 350 W and ≤ 375 W Slot Power Limit
    F6h   > 375 W and ≤ 400 W Slot Power Limit
    F7h   > 400 W and ≤ 425 W Slot Power Limit
    F8h   > 425 W and ≤ 450 W Slot Power Limit
    F9h   > 450 W and ≤ 475 W Slot Power Limit
    FAh   > 475 W and ≤ 500 W Slot Power Limit
    FBh   > 500 W and ≤ 525 W Slot Power Limit
    FCh   > 525 W and ≤ 550 W Slot Power Limit
    FDh   > 550 W and ≤ 575 W Slot Power Limit
    FEh   > 575 W and ≤ 600 W Slot Power Limit
    FFh   Reserved for Slot Power Limit Values above 600 W

  This register must be implemented if the Slot Implemented bit is Set.

  Writes to this register also cause the Port to send the
  Set_Slot_Power_Limit Message.

> > > +	if (slot_power_limit == 0) {
> > > +		value = 0x00;
> > > +		scale = 0;
> > > +	} else if (slot_power_limit <= 255) {
> > > +		value = slot_power_limit;
> > > +		scale = 3;
> > > +	} else if (slot_power_limit <= 255*10) {
> > > +		value = slot_power_limit / 10;
> > > +		scale = 2;
> > > +	} else if (slot_power_limit <= 255*100) {
> > > +		value = slot_power_limit / 100;
> > > +		scale = 1;
> > > +	} else if (slot_power_limit <= 239*1000) {
> > > +		value = slot_power_limit / 1000;
> > > +		scale = 0;
> > > +	} else if (slot_power_limit <= 250*1000) {
> > > +		value = 0xF0;
> > > +		scale = 0;
> > > +	} else if (slot_power_limit <= 275*1000) {
> > > +		value = 0xF1;
> > > +		scale = 0;
> > > +	} else {
> > > +		value = 0xF2;
> > > +		scale = 0;
> > > +	}
> > > +
> > > +	if (slot_power_limit_value)
> > > +		*slot_power_limit_value = value;
> > > +
> > > +	if (slot_power_limit_scale)
> > > +		*slot_power_limit_scale = scale;
> > > +
> > > +	return slot_power_limit;
> > 
> > If "slot-power-limit-milliwatt" contains a value larger than can be
> > represented in "value" and "scale", the return value will not agree
> > with value/scale, will it?
> 
> In previous version 0xF2 was reserved for values above 275 W. So for me
> it looked like a correct solution.
> 
> > Currently you only use the return value for a log message, so no real
> > harm yet, other than the fact that we might print "Slot power limit
> > 1000.0W" when the hardware will only advertise 600W available.
> > 
> > Also, if "slot-power-limit-milliwatt" contains something like
> > 260000 mW (260 W), we'll return 0xF1/0, so the hardware will
> > advertise 275 W available.
> 
> There is no way how to encode 260 W. It is possible only 250 W or 275 W,
> and nothing between. I chose to round value to upper limit. What do you
> prefer in these cases? Upper or lower limit?

I think rounding down is better.  If we round up, the slot will
advertise more power than it can deliver, and if the device tries to
consume the amount of power advertised, it may not work reliably.

So I think we should return encoded values that are no higher than
what the slot can actually deliver, and the return value should match
what Slot Capabilities advertises.

Bjorn
