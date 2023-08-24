Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264AD7879D0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbjHXVB6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjHXVBf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 17:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8970C19BF;
        Thu, 24 Aug 2023 14:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB33F65A01;
        Thu, 24 Aug 2023 21:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2CC433C9;
        Thu, 24 Aug 2023 21:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692910892;
        bh=WGXHNtjJ66mhm3BLfcNPr1ycpu/FNmeQ5wDC88aJEOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cx/rJ4TeM/azbfhhz7SusjQ2InJvIltI1bQyMDdZPXivo3+IEXDhtz2N7MBk+ddDd
         cVq6URWjonWju9Vv7rrj6x+5jSTqH8fnAt0Fs5oSxPJ0mwMvL6Y2fTKLZ6dmJU4lfP
         fwZTNlIK+HlnNRXszpWpOG5TW853v+wvNmgz/ITsW+/T23IPn/R3HADi5ql3c30wXG
         vsU9xtW6W5OrZGgiPfnu1M2Tuo8cIIzUuN4cthSWVpOmm+Gw7nG20v6uHTSMO8dT4S
         CbOao11Y+wpicGiLoKxYKBRACCfuvfede1rJv/8a8iv629niJnv+vBOhUi4dQopajN
         tSrcxjUKJVdGA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bba6fc4339so3133361fa.2;
        Thu, 24 Aug 2023 14:01:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxetia3+JZchZoSCey2ABgftyMA1GOmUrN9NZm6Gyi29W4boj9j
        zfBK5sCnts4zVWJy9Pmfy4pJrMmFaIRSFKx/7g==
X-Google-Smtp-Source: AGHT+IFB4HRVgVCVcRCVMRatDK7jbxYiJ5diUhw6T0+q0k8bf/tRBqjNA2zJPlMlWuRUnFKYafUWURWsbxCHyaGdHhw=
X-Received: by 2002:a2e:b0f4:0:b0:2bc:e827:a4f9 with SMTP id
 h20-20020a2eb0f4000000b002bce827a4f9mr2094050ljl.30.1692910890338; Thu, 24
 Aug 2023 14:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-5-git-send-email-lizhi.hou@amd.com> <2aae84b8-41f9-3c24-bac9-8f882d2211b@linux-m68k.org>
 <2d2efa50-43b2-242c-028b-76554ed30962@amd.com>
In-Reply-To: <2d2efa50-43b2-242c-028b-76554ed30962@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Aug 2023 16:01:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQEramXrpevb_SkD0yRSLGu8Zv82ww+RN9swqSBrpE+w@mail.gmail.com>
Message-ID: <CAL_JsqLQEramXrpevb_SkD0yRSLGu8Zv82ww+RN9swqSBrpE+w@mail.gmail.com>
Subject: Re: [PATCH V13 4/5] of: overlay: Extend of_overlay_fdt_apply() to
 specify the target node
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 1:40=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
> Hi Geert,
>
> Thanks for reviewing the patch. I add my comment in-line.
>
> On 8/24/23 01:31, Geert Uytterhoeven wrote:
> >     Hi Lizhi,
> >
> > On Tue, 15 Aug 2023, Lizhi Hou wrote:
> >> Currently, in an overlay fdt fragment, it needs to specify the exact
> >> location in base DT. In another word, when the fdt fragment is
> >> generated,
> >> the base DT location for the fragment is already known.
> >>
> >> There is new use case that the base DT location is unknown when fdt
> >> fragment is generated. For example, the add-on device provide a fdt
> >> overlay with its firmware to describe its downstream devices. Because =
it
> >> is add-on device which can be plugged to different systems, its firmwa=
re
> >> will not be able to know the overlay location in base DT. Instead, the
> >> device driver will load the overlay fdt and apply it to base DT at
> >> runtime.
> >> In this case, of_overlay_fdt_apply() needs to be extended to specify
> >> the target node for device driver to apply overlay fdt.
> >>    int overlay_fdt_apply(..., struct device_node *base);
> >>
> >> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> >
> > Thanks for your patch, which is now commit 47284862bfc7fd56 ("of:
> > overlay: Extend of_overlay_fdt_apply() in dt-rh/for-next.
> >
> >> --- a/drivers/of/overlay.c
> >> +++ b/drivers/of/overlay.c
> >> @@ -715,6 +730,7 @@ static struct device_node *find_target(struct
> >> device_node *info_node)
> >> /**
> >>  * init_overlay_changeset() - initialize overlay changeset from
> >> overlay tree
> >>  * @ovcs:        Overlay changeset to build
> >> + * @target_base:    Point to the target node to apply overlay
> >>  *
> >>  * Initialize @ovcs.  Populate @ovcs->fragments with node information
> >> from
> >>  * the top level of @overlay_root.  The relevant top level nodes are t=
he
> >
> > As an overlay can contain one or more fragments, this means the
> > base (when specified) will be applied to all fragments, and will thus
> > override the target-path properties in all fragments.
> >
> > However, for the use case of an overlay that you can plug into
> > a random location (and of which there can be multiple instances),
> > there can really be only a single fragment.  Even nodes that typically
> > live at the root level (e.g. gpio-leds or gpio-keys) must be inserted
> > below the specified location, to avoid conflicts.

It's not a random location, but a location where the full path and/or
unit-address are not known. What we should know is the node's base
name and compatible.

I think we can assume for this kind of usecase, that adding nodes only
under a defined base node is allowed. This is also just the
restriction I've asked for every time more general support of applying
overlays by the kernel is requested. The add-on card, hat, cape, etc.
usecases should all be applied downstream of some node.

> >
> > Hence:
> >   1. Should init_overlay_changeset() return -EINVAL if target_base is
> >      specified, and there is more than one fragment?
>
> Maybe allowing more than one fragment make the interface more generic?
> For example, it could support the use case that multiple fragments share
> the same base node.
>
> Currently, the fragment overlay path is "base node path" + "fragment
> target path". Thus, for the structure:
>
> /a/b/c/fragment0
>
> /a/b/d/fagment1
>
> It can be two fragments in one fdt by using
>
>    base node path =3D /a/b
>
>    fragment0 target path =3D /c
>
>    fragment1 target path =3D /d
>
> I am not sure if there will be this kind of use case or not. And I think
> it would not be hurt to allow that.
>
> >
> >   2. Should there be a convention about the target-path property's
> >      contents in the original overlay?
> >      drivers/of/unittest-data/overlay_pci_node.dtso in "[PATCH V13 5/5]
> >      of: unittest: Add pci_dt_testdrv pci driver" uses
> >
> >          target-path=3D"";
> >
> >      which cannot be represented when using sugar syntax.
> >      "/" should work fine, though.
>
> Because the fragment overlay path is "base node path" + "fragment target
> path", I may add code to check if "fragment target patch is '/' and
> ignore it. I think that would support sugar syntax with only '/' specifie=
d.

Note that "/" is also a valid target path. I think it would be better
to have a form that's obviously not a fixed path. I think what's
needed is to be able to specify just the nodename with or without the
unit-address. I don't know if dtc will accept that.

As labels are part of the ABI with overlays, a target label could also
work. Though the kernel would have to learn to add new labels or get a
label path from another source as a label doesn't exist on a generated
node.

Rob
