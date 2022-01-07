Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA32487BC2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348721AbiAGSEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 13:04:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41864 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348697AbiAGSEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 13:04:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAFC1B826BB;
        Fri,  7 Jan 2022 18:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DA1C36AEB;
        Fri,  7 Jan 2022 18:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641578669;
        bh=gCTTYZjIiLnl1Y4T4lCWqJ7QqtpzPWbm36KtXPy8tsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O0+qypImVPOnP9dqZAcQor+DQN/hxVgVtBV7UucFETtJLz4YN0TJYyNzvowk3uFJr
         TKhmw2Z2B06c3IBOiFH7GqJdvQXUdjBvwOev5DullYiC/p/ANV+gObJ/toPBNTGeKA
         55z9mIX9Zq47COGkccgnJ9iLtVp3yXn7EKC52S1eCKSL5I8NniQBs2Oj84Xn8Mc0q6
         LQGDT8t5Zsjv8ihksGvbYDgplyx1/ASJz/hO3r+cpDr6iX9ta9LMzmFIenPfoC390T
         Kb6kP6yfnz7MDx/EXQCZzaj9/LgqCxCj25OYKc33bssTkLWSTZg6cTSZSA1CWNRtwC
         FlgnRh+MFOy4g==
Date:   Fri, 7 Jan 2022 19:04:24 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pci@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH dt + pci 2/2] PCI: Add function for parsing
 `slot-power-limit-milliwatt` DT property
Message-ID: <20220107190424.3fc3e9b7@thinkpad>
In-Reply-To: <20211031150706.27873-2-kabel@kernel.org>
References: <20211031150706.27873-1-kabel@kernel.org>
        <20211031150706.27873-2-kabel@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

the property was merged into dt-schema, see
  https://github.com/devicetree-org/dt-schema/commit/7b2d7c521ba55903846cbb=
a00518e1c4038699b4
so we don't need to add it to linux git anymore.

Since the property is documented id dt-schema, can we now merge this
patch, which adds the of_pci_get_slot_power_limit() function? Both
aardvark and mvebu driver will use this function.

Marek

On Sun, 31 Oct 2021 16:07:06 +0100
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> From: Pali Roh=C3=A1r <pali@kernel.org>
>=20
> Add function of_pci_get_slot_power_limit(), which parses the
> `slot-power-limit-milliwatt` DT property, returning the value in
> milliwatts and in format ready for the PCIe Slot Capabilities Register.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---
>  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 15 +++++++++++
>  2 files changed, 79 insertions(+)
>=20
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index d84381ce82b5..9c1a38d5dd99 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -627,3 +627,67 @@ int of_pci_get_max_link_speed(struct device_node *no=
de)
>  	return max_link_speed;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
> +
> +/**
> + * of_pci_get_slot_power_limit - Parses the "slot-power-limit-milliwatt"
> + *				 property.
> + *
> + * @node: device tree node with the slot power limit information
> + * @slot_power_limit_value: pointer where the value should be stored in =
PCIe
> + *			    Slot Capabilities Register format
> + * @slot_power_limit_scale: pointer where the scale should be stored in =
PCIe
> + *			    Slot Capabilities Register format
> + *
> + * Returns the slot power limit in milliwatts and if @slot_power_limit_v=
alue
> + * and @slot_power_limit_scale pointers are non-NULL, fills in the value=
 and
> + * scale in format used by PCIe Slot Capabilities Register.
> + *
> + * If the property is not found or is invalid, returns 0.
> + */
> +u32 of_pci_get_slot_power_limit(struct device_node *node,
> +				u8 *slot_power_limit_value,
> +				u8 *slot_power_limit_scale)
> +{
> +	u32 slot_power_limit;
> +	u8 value, scale;
> +
> +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> +				 &slot_power_limit))
> +		slot_power_limit =3D 0;
> +
> +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> +	if (slot_power_limit =3D=3D 0) {
> +		value =3D 0x00;
> +		scale =3D 0;
> +	} else if (slot_power_limit <=3D 255) {
> +		value =3D slot_power_limit;
> +		scale =3D 3;
> +	} else if (slot_power_limit <=3D 255*10) {
> +		value =3D slot_power_limit / 10;
> +		scale =3D 2;
> +	} else if (slot_power_limit <=3D 255*100) {
> +		value =3D slot_power_limit / 100;
> +		scale =3D 1;
> +	} else if (slot_power_limit <=3D 239*1000) {
> +		value =3D slot_power_limit / 1000;
> +		scale =3D 0;
> +	} else if (slot_power_limit <=3D 250*1000) {
> +		value =3D 0xF0;
> +		scale =3D 0;
> +	} else if (slot_power_limit <=3D 275*1000) {
> +		value =3D 0xF1;
> +		scale =3D 0;
> +	} else {
> +		value =3D 0xF2;
> +		scale =3D 0;
> +	}
> +
> +	if (slot_power_limit_value)
> +		*slot_power_limit_value =3D value;
> +
> +	if (slot_power_limit_scale)
> +		*slot_power_limit_scale =3D scale;
> +
> +	return slot_power_limit;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1cce56c2aea0..9352278141be 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -665,6 +665,9 @@ struct device_node;
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *re=
s);
>  int of_get_pci_domain_nr(struct device_node *node);
>  int of_pci_get_max_link_speed(struct device_node *node);
> +u32 of_pci_get_slot_power_limit(struct device_node *node,
> +				u8 *slot_power_limit_value,
> +				u8 *slot_power_limit_scale);
>  void pci_set_of_node(struct pci_dev *dev);
>  void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
> @@ -691,6 +694,18 @@ of_pci_get_max_link_speed(struct device_node *node)
>  	return -EINVAL;
>  }
> =20
> +static inline u32
> +of_pci_get_slot_power_limit(struct device_node *node,
> +			    u8 *slot_power_limit_value,
> +			    u8 *slot_power_limit_scale)
> +{
> +	if (slot_power_limit_value)
> +		*slot_power_limit_value =3D 0;
> +	if (slot_power_limit_scale)
> +		*slot_power_limit_scale =3D 0;
> +	return 0;
> +}
> +
>  static inline void pci_set_of_node(struct pci_dev *dev) { }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }

