Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3074265B2ED
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jan 2023 14:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjABNyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 08:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABNyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 08:54:16 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C027C;
        Mon,  2 Jan 2023 05:54:14 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 56B8F20005;
        Mon,  2 Jan 2023 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672667650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XI1jqSD80O19fS9j+6GijbwVoDQ0YZyBahVLr8QSp4A=;
        b=XEP/DVAKSf5CmbUL+ECBUNjhk6W6ixRGlmWUIjLJKIAxMHXit+mqGsUUXNbpXf9ZxZVpXq
        L0iDJ6F+F2yux1N3ok7LHtnVlztq/NTQ7KJk0O9xLmVgJBazVdLkc/9TCXs03q0e7z2PlP
        C7Cghn6C+bndokE/9VH0fCchUTMXfOG/5oc/65P2+DdrTrRgvBDdUQr6P697SLlCHFxmzg
        43PV9iSgyBEtsZrbn3sMi0KvTJBO0cRGqOD0SkpmA8EElxMkzilXrgFZo8O5aIfp14/HFw
        Tx9WyvJ3vECiEwLwNL2UwTgVV/YM6OG/qXCCocbazR5TPmXig3/CvAq+SNXTcw==
Date:   Mon, 2 Jan 2023 14:56:18 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected
 devices
Message-ID: <20230102145618.4b5bace8@fixe.home>
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

Hi Lizhi,

For all these functions, the "pdev" parameter is actually unused.

[snip]

> +
> +static int of_pci_prop_compatible(struct pci_dev *pdev,
> +				  struct of_changeset *ocs,
> +				  struct device_node *np)
> +{
> +	const char *compat_strs[PROP_COMPAT_NUM] =3D { 0 };
> +	int i, ret;
> +
> +	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =3D
> +		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);

Maybe it should be better to use "pci%04x,%04x" to keep the existing
naming.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
