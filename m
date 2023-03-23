Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0716C7336
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 23:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCWWky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 18:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWWkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 18:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE672C648;
        Thu, 23 Mar 2023 15:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B67628DE;
        Thu, 23 Mar 2023 22:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129BAC4339C;
        Thu, 23 Mar 2023 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679611252;
        bh=Wvm9oO+TGTT6BMrhpf55Flb9UTupepd5i3H6Nq8mDmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rMSBFNzosq9oJs2+SFAzlKpRvqZroTrJW0wB6pXUPPIH4fmZ702CLwjfa0Yd430IC
         cdgsjYTSaS3YhERpUigO7qrMROGz0TAFodl4TF5zHHJcec4O9MsB7JUuyq9gj++/1c
         UsSUkufqGLAeUeAz37pBtVCsnkH21dkfmSR4oz/7V7loX6FWeJHNUtQl0d387ykQe0
         BSah+Z7C/cj/fH+d7cbPx82CL/5LkFSyCyDIoUm9hKfPPrzH35ruqdlMnA+VsZWGoT
         dEQkaX5apvBHZuYwx+5zebugcIbnLW+pAbk1woAHOeFyFo01DaeLcfGMMxuEKEJEOj
         r/KvvMLNcvuuA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-53d277c1834so1113777b3.10;
        Thu, 23 Mar 2023 15:40:52 -0700 (PDT)
X-Gm-Message-State: AAQBX9ccCbmAJ+Vf2GJJfEeDA+2S8gF3OA0ewOMAa8iDqb9EkU7+0paT
        XjJ5vLv0Hed5n/Q9gPIkPKpquBnOP9/+n9VC9Q==
X-Google-Smtp-Source: AKy350Ye3nCQoXobESxoqVV0U6QLwpHk+LL8jCYaZ/FlvFyOF4q/jbN2KYecF+P4OkcijobOhAzVvjmmCcgvuozE42w=
X-Received: by 2002:a81:a9c5:0:b0:545:62cb:3bdd with SMTP id
 g188-20020a81a9c5000000b0054562cb3bddmr81297ywh.5.1679611251079; Thu, 23 Mar
 2023 15:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com> <1674183732-5157-2-git-send-email-lizhi.hou@amd.com>
In-Reply-To: <1674183732-5157-2-git-send-email-lizhi.hou@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Mar 2023 17:40:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+FM9P0n7BQZBY1AGJRtjAWw9F6h5DYmLkdPeXZaiYJwA@mail.gmail.com>
Message-ID: <CAL_Jsq+FM9P0n7BQZBY1AGJRtjAWw9F6h5DYmLkdPeXZaiYJwA@mail.gmail.com>
Subject: Re: [PATCH V7 1/3] of: dynamic: Add interfaces for creating device
 node dynamically
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 9:02=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
> of_create_node() creates device node dynamically. The parent device node
> and full name are required for creating the node. It optionally creates
> an OF changeset and attaches the newly created node to the changeset. The
> device node pointer and the changeset pointer can be used to add
> properties to the device node and apply the node to the base tree.
>
> of_destroy_node() frees the device node created by of_create_node(). If
> an OF changeset was also created for this node, it will destroy the
> changeset before freeing the device node.
>
> Expand of_changeset APIs to handle specific types of properties.
>     of_changeset_add_prop_string()
>     of_changeset_add_prop_string_array()
>     of_changeset_add_prop_u32_array()
>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Your Sob should be last because you sent this patch. The order of Sob
is roughly the order of possession of the patch.

> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>

So Sonal and Max modified this patch?

> Reviewed-by: Brian Xu <brian.xu@amd.com>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>

Why does this have Cl=C3=A9ment's Sob?

> ---
>  drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |  24 ++++++
>  2 files changed, 221 insertions(+)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index cd3821a6444f..4e211a1d039f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct devic=
e_node *np,
>         return NULL;
>  }
>
> +/**
> + * of_create_node - Dynamically create a device node

For consistency, I think this should be of_changeset_create_node().

> + *
> + * @parent: Pointer to parent device node
> + * @full_name: Node full name
> + * @cset: Pointer to returning changeset
> + *
> + * Return: Pointer to the created device node or NULL in case of an erro=
r.
> + */
> +struct device_node *of_create_node(struct device_node *parent,
> +                                  const char *full_name,
> +                                  struct of_changeset **cset)
> +{
> +       struct of_changeset *ocs;
> +       struct device_node *np;
> +       int ret;
> +
> +       np =3D __of_node_dup(NULL, full_name);
> +       if (!np)
> +               return NULL;
> +       np->parent =3D parent;
> +
> +       if (!cset)
> +               return np;
> +
> +       ocs =3D kmalloc(sizeof(*ocs), GFP_KERNEL);
> +       if (!ocs) {
> +               of_node_put(np);
> +               return NULL;
> +       }
> +
> +       of_changeset_init(ocs);
> +       ret =3D of_changeset_attach_node(ocs, np);
> +       if (ret) {
> +               of_changeset_destroy(ocs);
> +               of_node_put(np);
> +               kfree(ocs);
> +               return NULL;
> +       }
> +
> +       np->data =3D ocs;
> +       *cset =3D ocs;
> +
> +       return np;
> +}
> +EXPORT_SYMBOL(of_create_node);
> +
> +/**
> + * of_destroy_node - Destroy a dynamically created device node
> + *
> + * @np: Pointer to dynamically created device node
> + *
> + */
> +void of_destroy_node(struct device_node *np)
> +{
> +       struct of_changeset *ocs;
> +
> +       if (np->data) {
> +               ocs =3D (struct of_changeset *)np->data;
> +               of_changeset_destroy(ocs);
> +       }
> +       of_node_put(np);

A sequence like this would be broken:

np  =3D of_create_node()
of_node_get(np)
of_destroy_node(np)

The put here won't free the node because it still has a ref, but we
just freed the changeset. For this to work correctly, we would need
the release function to handle np->data instead. However, all users of
data aren't a changeset.

I'm failing to remember why we're storing the changeset in 'data', but
there doesn't seem to be a reason now so I think that can just be
dropped. Then if you want to free the node, you'd just do an
of_node_put(). (And maybe after the node is attached you do a put too,
because the attach does a get. Not completely sure.)

A unittest for all these functions would be helpful.

Rob
