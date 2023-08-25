Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6777880D5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjHYHZs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 25 Aug 2023 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHYHZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 03:25:20 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C61FC7;
        Fri, 25 Aug 2023 00:25:17 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d7260fae148so626758276.1;
        Fri, 25 Aug 2023 00:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692948317; x=1693553117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xhn4Ub6v7oYgtdvXuR5d+GmEHUbHP7Cgzd91J0zUNls=;
        b=SPC28q4TGDMq7xSMPgQhA4YhT8acdVLTpzdfNMFKZxKy0yxcjfXa2pF5SnyrnkBxvE
         cylDvEObwsiAVnd7bxGHNNX5B1J7q03DkqbiPDcQqhEcmj615UbYpoFfIOOK/69A2Vbq
         4fggprtv3Ljpj4jayzInn8vgqnG2nFqLd6NaC+3NbzosuKUDU6tDgHg6npBkJJyPHNxN
         w0mPC/NKnH2ql5sgbYKx2WVi6KZxbs6qgzStpNIZMUMhk2f5CxUyX7iFEZwfRYequkXD
         tQHOCycGAE1CxzdoXtAERvfkT/EA8qIexNnTuRM/zq47EoGmAG8CsAbcVE6BL4trx9SH
         H+hA==
X-Gm-Message-State: AOJu0YxOVHhhNwWh117tnbHpVSr4VWHMcwSinVkINsWIsehTQ4TYAFNC
        0rUnLRCtxPXVMgPHXlBsI8ms8Xt+DJCG3A==
X-Google-Smtp-Source: AGHT+IGAL3dkY5fZGucbKaATtfnAR+TnhB64tJIuLm7h5tWYjnWhFfPidUJRTCFM8s6X0pIV0JfHuA==
X-Received: by 2002:a25:a049:0:b0:c6f:b2de:21ba with SMTP id x67-20020a25a049000000b00c6fb2de21bamr16161880ybh.17.1692948316860;
        Fri, 25 Aug 2023 00:25:16 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 198-20020a250dcf000000b00d0d2c7dbfecsm280727ybn.7.2023.08.25.00.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:25:16 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d7225259f52so633256276.0;
        Fri, 25 Aug 2023 00:25:16 -0700 (PDT)
X-Received: by 2002:a05:6902:100b:b0:d77:e43d:6e82 with SMTP id
 w11-20020a056902100b00b00d77e43d6e82mr7758325ybt.55.1692948316134; Fri, 25
 Aug 2023 00:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-5-git-send-email-lizhi.hou@amd.com> <2aae84b8-41f9-3c24-bac9-8f882d2211b@linux-m68k.org>
 <2d2efa50-43b2-242c-028b-76554ed30962@amd.com>
In-Reply-To: <2d2efa50-43b2-242c-028b-76554ed30962@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Aug 2023 09:25:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_riBrmEThdbaEMO468Hc0oBJKChW=jABUF3T9EhaRew@mail.gmail.com>
Message-ID: <CAMuHMdW_riBrmEThdbaEMO468Hc0oBJKChW=jABUF3T9EhaRew@mail.gmail.com>
Subject: Re: [PATCH V13 4/5] of: overlay: Extend of_overlay_fdt_apply() to
 specify the target node
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lizhi,

On Thu, Aug 24, 2023 at 8:40 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
> On 8/24/23 01:31, Geert Uytterhoeven wrote:
> > On Tue, 15 Aug 2023, Lizhi Hou wrote:
> >> Currently, in an overlay fdt fragment, it needs to specify the exact
> >> location in base DT. In another word, when the fdt fragment is
> >> generated,
> >> the base DT location for the fragment is already known.
> >>
> >> There is new use case that the base DT location is unknown when fdt
> >> fragment is generated. For example, the add-on device provide a fdt
> >> overlay with its firmware to describe its downstream devices. Because it
> >> is add-on device which can be plugged to different systems, its firmware
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
> >>  * the top level of @overlay_root.  The relevant top level nodes are the
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

Oh, I had missed that the "fragment target path" is appended,
and thought it was just overridden.

> /a/b/c/fragment0
>
> /a/b/d/fagment1
>
> It can be two fragments in one fdt by using
>
>    base node path = /a/b
>
>    fragment0 target path = /c
>
>    fragment1 target path = /d
>
> I am not sure if there will be this kind of use case or not. And I think
> it would not be hurt to allow that.

Is there a need for that? Both c and d can be handled as subnodes
in a single fragment if the target path is empty (and see below).

> >   2. Should there be a convention about the target-path property's
> >      contents in the original overlay?
> >      drivers/of/unittest-data/overlay_pci_node.dtso in "[PATCH V13 5/5]
> >      of: unittest: Add pci_dt_testdrv pci driver" uses
> >
> >          target-path="";
> >
> >      which cannot be represented when using sugar syntax.
> >      "/" should work fine, though.
>
> Because the fragment overlay path is "base node path" + "fragment target
> path", I may add code to check if "fragment target patch is '/' and
> ignore it. I think that would support sugar syntax with only '/' specified.

That makes sense.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
