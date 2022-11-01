Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1A61459C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKAIX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAIX6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 04:23:58 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB1B13EB2;
        Tue,  1 Nov 2022 01:23:57 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id fz10so3171633qtb.3;
        Tue, 01 Nov 2022 01:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oV9IoANGr7KjTrgD9Er5Ouofy/hTns0x+o38tZjPpPU=;
        b=VIqBUVhvVPunqfm5zy7DGyIUW87X/2nXzy3tsIyLP0TRopusKyKKIF6EPNuOB1lkJx
         fsMdb3fsh6Au9MXmtnEsd6lOXMzIffBIkXm9xH5eL+IND4FXikngZoquclltK9kyWxrT
         moThGB50NEMiIB2nBrJZkjCyvxURRnpnM06oFYg1IreAeDJub+D1lQFL/iUp7BSGQoVo
         N28vQEPL5MZpS0kL5nKxafC+gObISvFZp8G1WL2reWtWbQ4st6/abSt8MPXRcfoW10Ts
         03X0mNlQfOrP/2dK+XFCRIcmB3cvQmMjFtuKFFoK6t1LzcZ0kiJPeTyvF/jakgMr6pW8
         zZBg==
X-Gm-Message-State: ACrzQf2/JYMOPGR4TebyaVWjB1KAQmaD/p2twsSmQiMgw2sA7Nn4GTfw
        PLiOt8WC1Xh4KKgTPFlAdMnzoMXpVOC/Ew==
X-Google-Smtp-Source: AMsMyM6ncAi1nR6qFhisl9xZL7qu2dKvisZb5735klZsafny9A3b5SuVVlMfO4Ja3K3H9s65GJtR0Q==
X-Received: by 2002:ac8:4c9b:0:b0:3a5:1721:8023 with SMTP id j27-20020ac84c9b000000b003a517218023mr11859817qtv.523.1667291036850;
        Tue, 01 Nov 2022 01:23:56 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a445400b006eeae49537bsm6217812qkp.98.2022.11.01.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 01:23:56 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i127so16451313ybc.11;
        Tue, 01 Nov 2022 01:23:56 -0700 (PDT)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr3924009ybc.89.1667291036065; Tue, 01 Nov
 2022 01:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <9c41a4372b27420c732ff5599d823e363de00c6d.1657704829.git.geert+renesas@glider.be>
 <ed791d5270ce8684085b47d83332ef0aa172e1d0.camel@linux.ibm.com>
In-Reply-To: <ed791d5270ce8684085b47d83332ef0aa172e1d0.camel@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Nov 2022 09:23:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHf5ydfJtmzkEF89ey-HUM4+vmECDoia0r4YTKvijTkg@mail.gmail.com>
Message-ID: <CAMuHMdVHf5ydfJtmzkEF89ey-HUM4+vmECDoia0r4YTKvijTkg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix dropping valid root bus resources with .end = zero
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,

On Mon, Oct 31, 2022 at 12:56 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> On Wed, 2022-07-13 at 11:35 +0200, Geert Uytterhoeven wrote:
> > On r8a7791/koelsch:
> >
> >     kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> >     # cat /sys/kernel/debug/kmemleak
> >     unreferenced object 0xc3a34e00 (size 64):
> >       comm "swapper/0", pid 1, jiffies 4294937460 (age 199.080s)
> >       hex dump (first 32 bytes):
> >       b4 5d 81 f0 b4 5d 81 f0 c0 b0 a2 c3 00 00 00 00  .]...]..........
> >       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >       backtrace:
> >       [<fe3aa979>] __kmalloc+0xf0/0x140
> >       [<34bd6bc0>] resource_list_create_entry+0x18/0x38
> >       [<767046bc>] pci_add_resource_offset+0x20/0x68
> >       [<b3f3edf2>] devm_of_pci_get_host_bridge_resources.constprop.0+0xb0/0x390
> >
> > When coalescing two resources for a contiguous aperture, the first
> > resource is enlarged to cover the full contiguous range, while the
> > second resource is marked invalid.  This invalidation is done by
> > clearing the flags, start, and end members.
> >
> > When adding the initial resources to the bus later, invalid resources
> > are skipped.  Unfortunately, the check for an invalid resource considers
> > only the end member, causing false positives.
> >
> > E.g. on r8a7791/koelsch, root bus resource 0 ("bus 00") is skipped, and
> > no longer registered with pci_bus_insert_busn_res() (causing the memory
> > leak), nor printed:
> >
> >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
> >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
> >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> >     -pci_bus 0000:00: root bus resource [bus 00]
> >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> >
> > Fix this by only skipping resources where all of the flags, start, and
> > end members are zero.
> >
> > Fixes: 7c3855c423b17f6c ("PCI: Coalesce host bridge contiguous apertures")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Is there any side effect of not registering the root bus resource with
> > pci_bus_insert_busn_res()?  This is the resource created by
> > of_pci_parse_bus_range(), and thus affects any DT platforms using
> > "bus-range = <0 0>".
> >
> > Perhaps checking for "!res->flags" would be sufficient?
> >
> > I assume this still causes memory leaks on systems where resources are
> > coalesced, as the second resource of a contiguous aperture is no longer
> > referenced? Perhaps instead of clearing the resource, it should be
> > removed from the list (and freed? is it actually safe to do that?)?
> >
> > Apparently Johannes had identified the bug before, but didn't realize
> > the full impact...
> > https://lore.kernel.org/r/5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net/
> > ---
> >  drivers/pci/probe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d37033a..be628798d279ada0 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -994,7 +994,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >       resource_list_for_each_entry_safe(window, n, &resources) {
> >               offset = window->offset;
> >               res = window->res;
> > -             if (!res->end)
> > +             if (!res->flags && !res->start && !res->end)
> >                       continue;
> >
> >               list_move_tail(&window->node, &bridge->windows);
>
> Hi Geert, Hi Bjorn, Hi Kai-Heng,
>
> I just stumbled over this issue on s390 with the below kmemleak
> splat[0]. On s390 we currently always have a single PCI bus with bus
> number 00 per PCI domain so this is triggered whenever there are PCI
> devices attached to the system.
>
> Applying the patch from this mail makes the splat go away and the
> 'pci_bus 0002:00: root bus resource [bus 00]' message reappear. As this
> mail is from July I guess it got lost and this was never picked up ;-(

Sorry, I still have to go over all patches submitted last summer that
didn't make it...

> For now feel free to add my:
>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
