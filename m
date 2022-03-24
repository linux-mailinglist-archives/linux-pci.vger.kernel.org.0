Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7333B4E678B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbiCXRPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 13:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352161AbiCXRPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 13:15:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB6326F7;
        Thu, 24 Mar 2022 10:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF3C5B82337;
        Thu, 24 Mar 2022 17:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454AEC340EC;
        Thu, 24 Mar 2022 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648142019;
        bh=jMi1G5nIwMEKhuPCL/A1QiK7aP2q19+GorUJGSunucs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Egwfe4rrC4QgezISl4qPVGP1OusolFa0RQbX4Ftdyx/XRCHIU/gAhzejII7unpM2o
         6SjwZO/Zj797OyqbQg9m8TlsZaXvDgt4CBYY1jdURGssOABT/82RBUpBQiaGiozdI3
         NZDZJnWw8iOpbT38ilwI9WmWXzwdLiJRVI9jTlLhjyncEtwLPI0xlSVqXN6wdqn6RO
         8uHpM6PnvAZ1BvDbWVZjxoFhnRzbZwYe+hoau7pbIaQwedMuvm5ZosuJeuI/knQz7A
         NX+zWUaLfR98Kp312ZBhTx+Abn/UynAxReSJVacE/gXuAwoidrONNoi37xAER1mTfk
         U+celXAOvWMTw==
Date:   Thu, 24 Mar 2022 12:13:37 -0500
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
Subject: Re: [PATCH v2 3/4] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20220324171337.GA1458545@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302145733.12606-4-pali@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:57:32PM +0100, Pali Rohár wrote:
> Add function of_pci_get_slot_power_limit(), which parses the
> 'slot-power-limit-milliwatt' DT property, returning the value in
> milliwatts and in format ready for the PCIe Slot Capabilities Register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> * Added support for PCIe 6.0 slot power limit encodings
> * Round down slot power limit value
> ---
>  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 15 +++++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..549a404bd536 100644
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
> +	} else if (slot_power_limit_mw <= 600*1000) {
> +		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
> +		scale = 0;
> +	} else {
> +		value = 0xFF;
> +		scale = 0;

The purpose of this function is to return values that can be
programmed into the Slot Capabilities register.  The 0xFF Slot Power
Limit Value is reserved, and I don't think we should use it until the
spec defines a meaning for it.

If the DT tells us 800W is available, we'll put 0xFF in Slot Power
Limit Value.  If the spec eventually defines (0xFF, 0) to mean "1000W
available", a device may try to consume all 1000W, which will not
work.

If slot_power_limit_mw > 600*1000, I think we should advertise 600W
available (value 0xFE, scale 0) and return 600W (600*1000).

Bjorn
