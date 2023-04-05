Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3306D7226
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 03:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbjDEBph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 21:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjDEBpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 21:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCB53599;
        Tue,  4 Apr 2023 18:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FB13639E4;
        Wed,  5 Apr 2023 01:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EADC433EF;
        Wed,  5 Apr 2023 01:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680659134;
        bh=v5MzJVx3ApNivha6Yi9fk8iwlHw1THAZvhjRL060T3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SCan6Qh7b4j996wxje4t00ajCOSNlQPGcD1uL/dk2mGthxG4efufdUQ+lzXuoehpB
         IDDOwlgCcAbqz37uY9UKQvGDUYj/FIMLP0qBbd9MYWhIcLIuuct/KiOjvmcmsnV8Uw
         1AtxxyJJ1BbtB0xHEh/iPEPBmi9qgSbC70XOWr11XNwq/wwJCun7st2w9yqmcFrHfN
         Tqi6OM4hADtybHcdrdX1JCL1/soM9B/5XJVEclVuKmuQ6Z2/mVUrIesROszjLGT/t9
         m2g6xlQOW3fmyijoUCm/Yh1qj4ojbiPfhQpaHX+B0Pq21tlsIYf1zC1dFs8HuPDHt5
         VqlStL+TVEHXA==
Received: by mail-yb1-f173.google.com with SMTP id cf7so40950288ybb.5;
        Tue, 04 Apr 2023 18:45:34 -0700 (PDT)
X-Gm-Message-State: AAQBX9f2GgKcoT6pK91DJw8kFUnSabpO04QqXHECM8tGWgrg/kc33Txt
        kphiE/uXfnNluXEq5p3hMlXXJ3/K0tfQY8ijkg==
X-Google-Smtp-Source: AKy350bCL+6/83jZmfnBumi8qMNba8O04DC79AQSSXaVislWjAL0J3ejnUR0Ob2SRAaECnx3jk6lJaOz9l/KscW25Og=
X-Received: by 2002:a25:d64e:0:b0:b6c:2224:8a77 with SMTP id
 n75-20020a25d64e000000b00b6c22248a77mr3178587ybg.1.1680659133393; Tue, 04 Apr
 2023 18:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <1674183732-5157-2-git-send-email-lizhi.hou@amd.com> <CAL_Jsq+FM9P0n7BQZBY1AGJRtjAWw9F6h5DYmLkdPeXZaiYJwA@mail.gmail.com>
 <a13ba751-9350-47ee-1c4d-77bbfbb8ed72@amd.com> <CAL_Jsq+5LtUcLTRnywdf7XB3HNtO6j2J=qykVeDN1MYZEEx1Cg@mail.gmail.com>
 <0ac96eb0-908c-f0c6-2ec8-23957f5a7941@amd.com>
In-Reply-To: <0ac96eb0-908c-f0c6-2ec8-23957f5a7941@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Apr 2023 20:45:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJEbGRj8dUw-rijLibkcyJEA3PB=98nsJ8e78YokWjkvw@mail.gmail.com>
Message-ID: <CAL_JsqJEbGRj8dUw-rijLibkcyJEA3PB=98nsJ8e78YokWjkvw@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 4:26=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
>
> On 3/24/23 07:14, Rob Herring wrote:
> > On Thu, Mar 23, 2023 at 9:12=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> w=
rote:
> >>
> >> On 3/23/23 15:40, Rob Herring wrote:
> >>> On Thu, Jan 19, 2023 at 9:02=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com>=
 wrote:
> >>>> of_create_node() creates device node dynamically. The parent device =
node
> >>>> and full name are required for creating the node. It optionally crea=
tes
> >>>> an OF changeset and attaches the newly created node to the changeset=
. The
> >>>> device node pointer and the changeset pointer can be used to add
> >>>> properties to the device node and apply the node to the base tree.
> >>>>
> >>>> of_destroy_node() frees the device node created by of_create_node().=
 If
> >>>> an OF changeset was also created for this node, it will destroy the
> >>>> changeset before freeing the device node.
> >>>>
> >>>> Expand of_changeset APIs to handle specific types of properties.
> >>>>       of_changeset_add_prop_string()
> >>>>       of_changeset_add_prop_string_array()
> >>>>       of_changeset_add_prop_u32_array()
> >>>>
> >>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> >>> Your Sob should be last because you sent this patch. The order of Sob
> >>> is roughly the order of possession of the patch.
> >> Got it.
> >>>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> >>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
> >>> So Sonal and Max modified this patch?
> >> They did not directly modify the code. And we discussed the design
> >> together.  They also reviewed the patch before I sent it out. Please l=
et
> >> me know if other keyword should be used in this case.
> > Reviewed-by or nothing. Some feel that only reviews on public lists
> > should get that tag and internal, private reviews don't matter.
> >
> >>>> Reviewed-by: Brian Xu <brian.xu@amd.com>
> >>>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> >>> Why does this have Cl=C3=A9ment's Sob?
> >> I referenced Cl=C3=A9ment 's code and used one portion in my first pat=
ch
> >> series. And I re-implemented it later to address the code review
> >> comments/requests.
> > Then it goes first or you can use the 'Co-developed-by' tag.
> >
> >>>> ---
> >>>>    drivers/of/dynamic.c | 197 ++++++++++++++++++++++++++++++++++++++=
+++++
> >>>>    include/linux/of.h   |  24 ++++++
> >>>>    2 files changed, 221 insertions(+)
> >>>>
> >>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> >>>> index cd3821a6444f..4e211a1d039f 100644
> >>>> --- a/drivers/of/dynamic.c
> >>>> +++ b/drivers/of/dynamic.c
> >>>> @@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct =
device_node *np,
> >>>>           return NULL;
> >>>>    }
> >>>>
> >>>> +/**
> >>>> + * of_create_node - Dynamically create a device node
> >>> For consistency, I think this should be of_changeset_create_node().
> >> Sure.
> >>>> + *
> >>>> + * @parent: Pointer to parent device node
> >>>> + * @full_name: Node full name
> >>>> + * @cset: Pointer to returning changeset
> >>>> + *
> >>>> + * Return: Pointer to the created device node or NULL in case of an=
 error.
> >>>> + */
> >>>> +struct device_node *of_create_node(struct device_node *parent,
> >>>> +                                  const char *full_name,
> >>>> +                                  struct of_changeset **cset)
> >>>> +{
> >>>> +       struct of_changeset *ocs;
> >>>> +       struct device_node *np;
> >>>> +       int ret;
> >>>> +
> >>>> +       np =3D __of_node_dup(NULL, full_name);
> >>>> +       if (!np)
> >>>> +               return NULL;
> >>>> +       np->parent =3D parent;
> >>>> +
> >>>> +       if (!cset)
> >>>> +               return np;
> >>>> +
> >>>> +       ocs =3D kmalloc(sizeof(*ocs), GFP_KERNEL);
> >>>> +       if (!ocs) {
> >>>> +               of_node_put(np);
> >>>> +               return NULL;
> >>>> +       }
> >>>> +
> >>>> +       of_changeset_init(ocs);
> >>>> +       ret =3D of_changeset_attach_node(ocs, np);
> >>>> +       if (ret) {
> >>>> +               of_changeset_destroy(ocs);
> >>>> +               of_node_put(np);
> >>>> +               kfree(ocs);
> >>>> +               return NULL;
> >>>> +       }
> >>>> +
> >>>> +       np->data =3D ocs;
> >>>> +       *cset =3D ocs;
> >>>> +
> >>>> +       return np;
> >>>> +}
> >>>> +EXPORT_SYMBOL(of_create_node);
> >>>> +
> >>>> +/**
> >>>> + * of_destroy_node - Destroy a dynamically created device node
> >>>> + *
> >>>> + * @np: Pointer to dynamically created device node
> >>>> + *
> >>>> + */
> >>>> +void of_destroy_node(struct device_node *np)
> >>>> +{
> >>>> +       struct of_changeset *ocs;
> >>>> +
> >>>> +       if (np->data) {
> >>>> +               ocs =3D (struct of_changeset *)np->data;
> >>>> +               of_changeset_destroy(ocs);
> >>>> +       }
> >>>> +       of_node_put(np);
> >>> A sequence like this would be broken:
> >>>
> >>> np  =3D of_create_node()
> >>> of_node_get(np)
> >>> of_destroy_node(np)
> >>>
> >>> The put here won't free the node because it still has a ref, but we
> >>> just freed the changeset. For this to work correctly, we would need
> >>> the release function to handle np->data instead. However, all users o=
f
> >>> data aren't a changeset.
> >>>
> >>> I'm failing to remember why we're storing the changeset in 'data', bu=
t
> >>> there doesn't seem to be a reason now so I think that can just be
> >>> dropped. Then if you want to free the node, you'd just do an
> >>> of_node_put(). (And maybe after the node is attached you do a put too=
,
> >>> because the attach does a get. Not completely sure.)
> >> The question is how to save changeset and free it later. I used global
> >> link list to track the changeset been created.
> >>
> >> Storing the changeset in 'data' can avoid using the global link list.
> >>
> >> To use of_node_put() to free both node and changeset, I think we can
> >>
> >>     1) add a new flag, then in of_node_release() we can know np->data =
is
> >> changeset by checking the flag.
> >>
> >>     2) When creating node, allocate extra memory for changeset and set
> >> np->data to a global function of_free_dynamic_node().
> >>
> >>         In of_node_release(), check if np->data =3D=3D of_free_dynamic=
_node,
> >> call of_free_dynamic_node(np).
> >>
> >>         in of_free_dynamic_node(), free changeset by
> >> of_changeset_destroy(np+1)
> >>
> >> Does this make sense to you? If yes, 1) or 2) sounds better?
> > Neither works. Changesets and nodes are not 1:1 in general though they
> > are in your use. So you can use the data ptr, but the caller has to
> > decide that, not the DT core code.
>
> Ok. In of_pci_make_dev_node(), I can do
>
>       ocs =3D kmalloc(*ocs);
>
>       of_changeset_init(ocs);
>
>       np =3D of_changeset_create_node(ocs, name);
>
>       np->data =3D ocs;
>
> Then in of_pci_remove_node(), I can do
>
>       if (!np || !of_node_check_flag(np, OF_DYNAMIC)) return;
>
>      of_changeset_destroy(np->data);
>
>      of_node_put(np);
>
>
> Does this sound reasonable?

Yes, I think that should work.

Rob
