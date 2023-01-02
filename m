Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D565B2E1
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jan 2023 14:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjABNsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 08:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjABNsm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 08:48:42 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0102F22B;
        Mon,  2 Jan 2023 05:48:39 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DA6DC1C0007;
        Mon,  2 Jan 2023 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672667318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaEMzuEbjh8o3s0M+7BOHx2OufQjrgiQxu3MTpmKmQo=;
        b=RYs8skZNSlrU0FeRUO2gfvSNjHAP1FKd0rcS3xEMmUqbfhhmN4+dcGALJyr8W2YJ17fDH8
        smWMRwKBoDZfIwRHZtZYQ6PzMd7w0tZx1I0xUQqYfAXBs8FK9oVVoErMierSJsTIYmCYAa
        0l1ZI0N61K9/XlTVwJtFNpLHAN0WdsuqMHJ2+DS0TGE1ZFezoTyfsXUkJjIZo6uTqpFk9N
        Dz73esiK3SA2gz//uYqPqJ0b4/LPinDAzNRpvBjUbjU8wzIOaf5z9ZFzlPlo+SeRxhgMO8
        vI+QpsMHUybHq2sQJr6VXvq/yyzvyoZ8WDTffmiK3bu9K7fy3rm+Hgu+/AA9dA==
Date:   Mon, 2 Jan 2023 14:50:46 +0100
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
Subject: Re: [PATCH V5 1/3] of: dynamic: Add interfaces for creating device
 node dynamically
Message-ID: <20230102145046.3e1d009e@fixe.home>
In-Reply-To: <1671125446-57584-2-git-send-email-lizhi.hou@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
        <1671125446-57584-2-git-send-email-lizhi.hou@amd.com>
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

Le Thu, 15 Dec 2022 09:30:44 -0800,
Lizhi Hou <lizhi.hou@amd.com> a =C3=A9crit :

> of_create_node() creates device node dynamically. The parent device node
> and full name are required for creating the node. It optionally creates
> an OF changeset and attaches the newly created node to the changeset. The
> device node pointer and the changeset pointer can be used to add
> properties to the device node and apply the node to the base tree.
>=20
> of_destroy_node() frees the device node created by of_create_node(). If
> an OF changeset was also created for this node, it will destroy the
> changeset before freeing the device node.
>=20
> Expand of_changeset APIs to handle specific types of properties.
>     of_changeset_add_prop_string()
>     of_changeset_add_prop_string_array()
>     of_changeset_add_prop_u32_array()
>=20
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Reviewed-by: Brian Xu <brian.xu@amd.com>
> ---
>  drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |  24 ++++++
>  2 files changed, 221 insertions(+)
>=20
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index cd3821a6444f..067d996a9f79 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct devic=
e_node *np,
>  	return NULL;
>  }
> =20
> +/**
> + * of_create_node - Dynamically create a device node
> + *
> + * @parent: Pointer to parent device node
> + * @full_name: Node full name
> + * @cset: Pointer to returning changeset
> + *
> + * Return: Pointer to the created device node or NULL in case of an erro=
r.
> + */
> +struct device_node *of_create_node(struct device_node *parent,
> +				   const char *full_name,
> +				   struct of_changeset **cset)
> +{
> +	struct of_changeset *ocs;
> +	struct device_node *np;
> +	int ret;
> +
> +	np =3D __of_node_dup(NULL, full_name);
> +	if (!np)
> +		return NULL;
> +	np->parent =3D parent;
> +
> +	if (!cset)
> +		return np;
> +
> +	ocs =3D kmalloc(sizeof(*cset), GFP_KERNEL);

I started to test this series and this sizeof(*cset) is probably wrong,
it should be sizeof(*ocs) or it will yield the size of a struct
of_changeset pointer and not the struct of_changeset itself.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
