Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B86C7FA5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCXOOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCXOOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 10:14:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFADE3A5;
        Fri, 24 Mar 2023 07:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4AF9B82468;
        Fri, 24 Mar 2023 14:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6209BC433A1;
        Fri, 24 Mar 2023 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679667274;
        bh=1LI/70a8Wdzks6bphAAWWIPjcQjTsKtdN1DkUgKWRyI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ijFDYpG/KmgbsY4vdmpD0gMdOmVDjHJbSSOCZWf2UoedbgA14V4lzmDCJusk/OSBS
         i+UIAIrDliH36R7XxBg4b1aaHtEfoFxqYdCbf6vGPEx5CDBtCA3SKXKJwVD2p4Ew4x
         Pa5BUUlEjKOg+lE9kljAXCMIv+RYJdtMmLFreE7dfzlH9IYH/CKkTB09BltAgiXbQX
         yV1NxMXsvaQjziDncb8LJMLRNcn209UuO/BuNWX/SkIIYfmMP+Q9CgnH3/UrGzg5Pc
         1l1qnuakm1XiQ6Y3Z05VaUgZrPQvwVNHyoxwJj5BMGQqfrY11JuL694Of7xOHGL82/
         9uZGKLjOhe2Bw==
Received: by mail-yb1-f173.google.com with SMTP id j7so2324958ybg.4;
        Fri, 24 Mar 2023 07:14:34 -0700 (PDT)
X-Gm-Message-State: AAQBX9cKsI5jFEa4A9G4b1o2X6YFc2oSnVMdBgfJGmNdtxfqwWLGOLIW
        i7VfevEpptHqjaAXcv2HxNxGv6320j/5l3bE+w==
X-Google-Smtp-Source: AKy350aU8U/xa35sgqgoBviTpehPqsQok15zfHRwXey3E4rFa90TzAVVGYDvgFYgAnWPoMyJRecbZNcnHpK5DszUhfo=
X-Received: by 2002:a05:6902:1586:b0:b68:7b14:186b with SMTP id
 k6-20020a056902158600b00b687b14186bmr1090776ybu.1.1679667273310; Fri, 24 Mar
 2023 07:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <1674183732-5157-2-git-send-email-lizhi.hou@amd.com> <CAL_Jsq+FM9P0n7BQZBY1AGJRtjAWw9F6h5DYmLkdPeXZaiYJwA@mail.gmail.com>
 <a13ba751-9350-47ee-1c4d-77bbfbb8ed72@amd.com>
In-Reply-To: <a13ba751-9350-47ee-1c4d-77bbfbb8ed72@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Mar 2023 09:14:22 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5LtUcLTRnywdf7XB3HNtO6j2J=qykVeDN1MYZEEx1Cg@mail.gmail.com>
Message-ID: <CAL_Jsq+5LtUcLTRnywdf7XB3HNtO6j2J=qykVeDN1MYZEEx1Cg@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 9:12=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
>
> On 3/23/23 15:40, Rob Herring wrote:
> > On Thu, Jan 19, 2023 at 9:02=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> w=
rote:
> >> of_create_node() creates device node dynamically. The parent device no=
de
> >> and full name are required for creating the node. It optionally create=
s
> >> an OF changeset and attaches the newly created node to the changeset. =
The
> >> device node pointer and the changeset pointer can be used to add
> >> properties to the device node and apply the node to the base tree.
> >>
> >> of_destroy_node() frees the device node created by of_create_node(). I=
f
> >> an OF changeset was also created for this node, it will destroy the
> >> changeset before freeing the device node.
> >>
> >> Expand of_changeset APIs to handle specific types of properties.
> >>      of_changeset_add_prop_string()
> >>      of_changeset_add_prop_string_array()
> >>      of_changeset_add_prop_u32_array()
> >>
> >> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > Your Sob should be last because you sent this patch. The order of Sob
> > is roughly the order of possession of the patch.
> Got it.
> >
> >> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> >> Signed-off-by: Max Zhen <max.zhen@amd.com>
> > So Sonal and Max modified this patch?
> They did not directly modify the code. And we discussed the design
> together.  They also reviewed the patch before I sent it out. Please let
> me know if other keyword should be used in this case.

Reviewed-by or nothing. Some feel that only reviews on public lists
should get that tag and internal, private reviews don't matter.

> >
> >> Reviewed-by: Brian Xu <brian.xu@amd.com>
> >> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > Why does this have Cl=C3=A9ment's Sob?
> I referenced Cl=C3=A9ment 's code and used one portion in my first patch
> series. And I re-implemented it later to address the code review
> comments/requests.

Then it goes first or you can use the 'Co-developed-by' tag.

> >
> >> ---
> >>   drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++=
++
> >>   include/linux/of.h   |  24 ++++++
> >>   2 files changed, 221 insertions(+)
> >>
> >> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> >> index cd3821a6444f..4e211a1d039f 100644
> >> --- a/drivers/of/dynamic.c
> >> +++ b/drivers/of/dynamic.c
> >> @@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct de=
vice_node *np,
> >>          return NULL;
> >>   }
> >>
> >> +/**
> >> + * of_create_node - Dynamically create a device node
> > For consistency, I think this should be of_changeset_create_node().
> Sure.
> >
> >> + *
> >> + * @parent: Pointer to parent device node
> >> + * @full_name: Node full name
> >> + * @cset: Pointer to returning changeset
> >> + *
> >> + * Return: Pointer to the created device node or NULL in case of an e=
rror.
> >> + */
> >> +struct device_node *of_create_node(struct device_node *parent,
> >> +                                  const char *full_name,
> >> +                                  struct of_changeset **cset)
> >> +{
> >> +       struct of_changeset *ocs;
> >> +       struct device_node *np;
> >> +       int ret;
> >> +
> >> +       np =3D __of_node_dup(NULL, full_name);
> >> +       if (!np)
> >> +               return NULL;
> >> +       np->parent =3D parent;
> >> +
> >> +       if (!cset)
> >> +               return np;
> >> +
> >> +       ocs =3D kmalloc(sizeof(*ocs), GFP_KERNEL);
> >> +       if (!ocs) {
> >> +               of_node_put(np);
> >> +               return NULL;
> >> +       }
> >> +
> >> +       of_changeset_init(ocs);
> >> +       ret =3D of_changeset_attach_node(ocs, np);
> >> +       if (ret) {
> >> +               of_changeset_destroy(ocs);
> >> +               of_node_put(np);
> >> +               kfree(ocs);
> >> +               return NULL;
> >> +       }
> >> +
> >> +       np->data =3D ocs;
> >> +       *cset =3D ocs;
> >> +
> >> +       return np;
> >> +}
> >> +EXPORT_SYMBOL(of_create_node);
> >> +
> >> +/**
> >> + * of_destroy_node - Destroy a dynamically created device node
> >> + *
> >> + * @np: Pointer to dynamically created device node
> >> + *
> >> + */
> >> +void of_destroy_node(struct device_node *np)
> >> +{
> >> +       struct of_changeset *ocs;
> >> +
> >> +       if (np->data) {
> >> +               ocs =3D (struct of_changeset *)np->data;
> >> +               of_changeset_destroy(ocs);
> >> +       }
> >> +       of_node_put(np);
> > A sequence like this would be broken:
> >
> > np  =3D of_create_node()
> > of_node_get(np)
> > of_destroy_node(np)
> >
> > The put here won't free the node because it still has a ref, but we
> > just freed the changeset. For this to work correctly, we would need
> > the release function to handle np->data instead. However, all users of
> > data aren't a changeset.
> >
> > I'm failing to remember why we're storing the changeset in 'data', but
> > there doesn't seem to be a reason now so I think that can just be
> > dropped. Then if you want to free the node, you'd just do an
> > of_node_put(). (And maybe after the node is attached you do a put too,
> > because the attach does a get. Not completely sure.)
>
> The question is how to save changeset and free it later. I used global
> link list to track the changeset been created.
>
> Storing the changeset in 'data' can avoid using the global link list.
>
> To use of_node_put() to free both node and changeset, I think we can
>
>    1) add a new flag, then in of_node_release() we can know np->data is
> changeset by checking the flag.
>
>    2) When creating node, allocate extra memory for changeset and set
> np->data to a global function of_free_dynamic_node().
>
>        In of_node_release(), check if np->data =3D=3D of_free_dynamic_nod=
e,
> call of_free_dynamic_node(np).
>
>        in of_free_dynamic_node(), free changeset by
> of_changeset_destroy(np+1)
>
> Does this make sense to you? If yes, 1) or 2) sounds better?

Neither works. Changesets and nodes are not 1:1 in general though they
are in your use. So you can use the data ptr, but the caller has to
decide that, not the DT core code.

Rob
