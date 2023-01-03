Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9065C318
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjACPhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 10:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjACPgy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 10:36:54 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8B1055B;
        Tue,  3 Jan 2023 07:36:52 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 18868E000C;
        Tue,  3 Jan 2023 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672760210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KTZljicl5dwV9dTlvTkbBce651QHVSe64cnRvCpaSA=;
        b=QPb+w4MTOITrGKzhCX32CcuzIB4z3i+eqo9ED9LMf9jByBmjhaELC7Z4gjQKRP1Bbt6IQh
        GPGNvuDtymXIDIFTdXCbZWgnrb1I+fhtJKKX1U/Ccid8tf1z0nHtixt+PK9JstFsX2UFcO
        fD0dUf+oM5g2dlaNe9ZyxxLuawbU8hIJe977Kxuj8QuHVOMlFSBBmtt1wlgMqwfNE5kW/N
        /bJEPrpCgOCuxBKZkG0NYAPPuBVITfS/j5+0GMxw0/dpVAHk2aLuhGia7ltgrzfcs3YJ9E
        Z06MuRnyj7WeTtxJacbFlAGMgyNm9drgP89G+K5e72E/szfQ+qQSCmmLJh5PRQ==
Date:   Tue, 3 Jan 2023 16:38:58 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected
 devices
Message-ID: <20230103163858.5f4c0ece@fixe.home>
In-Reply-To: <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
        <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Thu, 15 Dec 2022 09:30:45 -0800,
Lizhi Hou <lizhi.hou@amd.com> a =C3=A9crit :

Further comments

> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> new file mode 100644
> index 000000000000..05c8ca05a71b
> --- /dev/null
> +++ b/drivers/pci/of_property.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <asm/unaligned.h>
> +#include "pci.h"
> +
> +#define OF_PCI_ADDRESS_CELLS		3
> +#define OF_PCI_SIZE_CELLS		2
> +
> +struct of_pci_addr_pair {
> +	u32		phys_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		size[OF_PCI_SIZE_CELLS];
> +};
> +
> +struct of_pci_range {
> +	u32		child_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		size[OF_PCI_SIZE_CELLS];
> +};
> +
> +#define OF_PCI_ADDR_SPACE_CONFIG	0x0
> +#define OF_PCI_ADDR_SPACE_IO		0x1
> +#define OF_PCI_ADDR_SPACE_MEM32		0x2
> +#define OF_PCI_ADDR_SPACE_MEM64		0x3
> +
> +#define OF_PCI_ADDR_FIELD_NONRELOC	BIT(31)
> +#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
> +#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
> +#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
> +#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
> +#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
> +#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
> +
> +#define OF_PCI_ADDR_HI			GENMASK_ULL(63, 32)
> +#define OF_PCI_ADDR_LO			GENMASK_ULL(31, 0)
> +#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
> +#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)

This is unused.

> +
> +enum of_pci_prop_compatible {
> +	PROP_COMPAT_PCI_VVVV_DDDD,
> +	PROP_COMPAT_PCICLASS_CCSSPP,
> +	PROP_COMPAT_PCICLASS_CCSS,
> +	PROP_COMPAT_NUM,
> +};
> +
> +static int of_pci_prop_device_type(struct pci_dev *pdev,
> +				   struct of_changeset *ocs,
> +				   struct device_node *np)
> +{
> +	return of_changeset_add_prop_string(ocs, np, "device_type", "pci");
> +}
> +
> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
> +				     struct of_changeset *ocs,
> +				     struct device_node *np)
> +{
> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
> +					 OF_PCI_ADDRESS_CELLS);
> +}
> +
> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
> +				  struct of_changeset *ocs,
> +				  struct device_node *np)
> +{
> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
> +					 OF_PCI_SIZE_CELLS);
> +}
> +
> +static void of_pci_set_address(u32 *prop, u64 addr, u32 flags)
> +{
> +	prop[0] =3D flags;
> +	put_unaligned(addr, &prop[1]);
> +}
> +
> +static int of_pci_get_addr_flags(struct resource *res, u32 *flags)
> +{
> +	u32 ss;
> +
> +	if (res->flags & IORESOURCE_IO)
> +		ss =3D OF_PCI_ADDR_SPACE_IO;
> +	else if (res->flags & IORESOURCE_MEM_64)
> +		ss =3D OF_PCI_ADDR_SPACE_MEM64;
> +	else if (res->flags & IORESOURCE_MEM)
> +		ss =3D OF_PCI_ADDR_SPACE_MEM32;
> +	else
> +		return -EINVAL;
> +
> +	*flags &=3D ~(OF_PCI_ADDR_FIELD_SS | OF_PCI_ADDR_FIELD_PREFETCH);
> +	if (res->flags & IORESOURCE_PREFETCH)
> +		*flags |=3D OF_PCI_ADDR_FIELD_PREFETCH;
> +
> +	*flags |=3D ss;

This seems wrong, should be:

*flags |=3D FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
