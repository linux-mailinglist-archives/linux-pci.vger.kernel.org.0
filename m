Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919CB61E8D9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 04:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKGDHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Nov 2022 22:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiKGDHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Nov 2022 22:07:10 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719DCDFC3
        for <linux-pci@vger.kernel.org>; Sun,  6 Nov 2022 19:07:08 -0800 (PST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C8CAA412C8
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 03:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667790425;
        bh=lknP2X8kYl/GPxh/Z2bYVUBQv2fIBaXao2E98IBeW00=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=I7uDsJ5mZPapEZT6GLcnZ46OuPNneA/F3yLBaqrBXwCtQJX96DrahrGVy4vfu+42t
         w/0Kg7OP4DaWWImLVNTg5uRIa8i55qpso6C3Twg0XRNXGgD1D/hApofHUK/aj8XCp2
         1i0MLcebqO136RR0c9xMGfF/DFjQ818AXGJEVcuV0mdugtKqGqCKrrInGpTTVk/LP9
         obPd26VPHSJA+vpdqRh5tJTDm93QASI9o6/UC/HR3BXiOpNWKDL+YiHi/nlGv2IEdr
         1iQ5avXslPsk/NfDoI3An87AzxYhkVy8TElD+GN1Pk7Bi4hZO0VlbhisPm64MC9lmW
         +6d1O59VEyuxQ==
Received: by mail-pf1-f198.google.com with SMTP id f189-20020a6238c6000000b0056e3400fdc0so4829208pfa.10
        for <linux-pci@vger.kernel.org>; Sun, 06 Nov 2022 19:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lknP2X8kYl/GPxh/Z2bYVUBQv2fIBaXao2E98IBeW00=;
        b=gNE4YyqQB6DWyPnu/I19CLYq0B9f+drapx+16hcJG3QpzP91SdLt6ck40KDIve8DJ1
         lZnnUmzAltZL57gKTvoFemRdrXOLOOUmFQAelMqb+YWEQfcB735ivW6Pmyz0uPHIfNrk
         o9xqwBg2bL9GXtNj+to3fgmoA+J4/FOnBgjOHebzcxifNSwVOIr4VCLeWGcX+skhRCuM
         MQaonbRQKGyr3hW1sw829KvIr1ZFxhvHRFfmziFULj3tceAe4Udcew6ie2AIWxUcludO
         AbgJgQH/hPVU611svQvlY6xocjSir+0T/FlHR0WEfbNe5DL7M3ePlrMe07nkPKGPpszx
         HY0g==
X-Gm-Message-State: ACrzQf1qkSpnEi1mvOFGidVch3xSlfIp10pckcuQ98hbfr4PW+WunYX2
        vFSrNpdKtOImoTm4HHOAeyo0tPOCzz3K7YCX8etZvVX4hjgk+b7nhlpO9YDUUVYrrhzigLIj7sE
        sDqrncAZ9hVMGZAFFVp8NEicG8ifTTYi2Vbkc19ujZY+17Eeo+oJpHQ==
X-Received: by 2002:a17:90a:2a8b:b0:213:9ae5:b9ab with SMTP id j11-20020a17090a2a8b00b002139ae5b9abmr49893085pjd.110.1667790423974;
        Sun, 06 Nov 2022 19:07:03 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4eiPXQeRWPBTSoG+zgTZG8RAUIef5EJkzetVTJY4aFtPmQXyZQZ5BDXqMJM6U6gUndjpvnfgQIt0hO8BuwbSk=
X-Received: by 2002:a17:90a:2a8b:b0:213:9ae5:b9ab with SMTP id
 j11-20020a17090a2a8b00b002139ae5b9abmr49893050pjd.110.1667790423512; Sun, 06
 Nov 2022 19:07:03 -0800 (PST)
MIME-Version: 1.0
References: <9c41a4372b27420c732ff5599d823e363de00c6d.1657704829.git.geert+renesas@glider.be>
 <ed791d5270ce8684085b47d83332ef0aa172e1d0.camel@linux.ibm.com> <CAMuHMdVHf5ydfJtmzkEF89ey-HUM4+vmECDoia0r4YTKvijTkg@mail.gmail.com>
In-Reply-To: <CAMuHMdVHf5ydfJtmzkEF89ey-HUM4+vmECDoia0r4YTKvijTkg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 7 Nov 2022 11:06:51 +0800
Message-ID: <CAAd53p4h6Bs_-faDoDRAMi503LLVBvhZDBOCnQ6NnLUqOSg0vA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix dropping valid root bus resources with .end = zero
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 1, 2022 at 4:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Niklas,
>
> On Mon, Oct 31, 2022 at 12:56 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > On Wed, 2022-07-13 at 11:35 +0200, Geert Uytterhoeven wrote:
> > > On r8a7791/koelsch:
> > >
> > >     kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> > >     # cat /sys/kernel/debug/kmemleak
> > >     unreferenced object 0xc3a34e00 (size 64):
> > >       comm "swapper/0", pid 1, jiffies 4294937460 (age 199.080s)
> > >       hex dump (first 32 bytes):
> > >       b4 5d 81 f0 b4 5d 81 f0 c0 b0 a2 c3 00 00 00 00  .]...]..........
> > >       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >       backtrace:
> > >       [<fe3aa979>] __kmalloc+0xf0/0x140
> > >       [<34bd6bc0>] resource_list_create_entry+0x18/0x38
> > >       [<767046bc>] pci_add_resource_offset+0x20/0x68
> > >       [<b3f3edf2>] devm_of_pci_get_host_bridge_resources.constprop.0+0xb0/0x390
> > >
> > > When coalescing two resources for a contiguous aperture, the first
> > > resource is enlarged to cover the full contiguous range, while the
> > > second resource is marked invalid.  This invalidation is done by
> > > clearing the flags, start, and end members.
> > >
> > > When adding the initial resources to the bus later, invalid resources
> > > are skipped.  Unfortunately, the check for an invalid resource considers
> > > only the end member, causing false positives.
> > >
> > > E.g. on r8a7791/koelsch, root bus resource 0 ("bus 00") is skipped, and
> > > no longer registered with pci_bus_insert_busn_res() (causing the memory
> > > leak), nor printed:
> > >
> > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
> > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
> > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > >     -pci_bus 0000:00: root bus resource [bus 00]
> > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> > >
> > > Fix this by only skipping resources where all of the flags, start, and
> > > end members are zero.
> > >
> > > Fixes: 7c3855c423b17f6c ("PCI: Coalesce host bridge contiguous apertures")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > Is there any side effect of not registering the root bus resource with
> > > pci_bus_insert_busn_res()?  This is the resource created by
> > > of_pci_parse_bus_range(), and thus affects any DT platforms using
> > > "bus-range = <0 0>".
> > >
> > > Perhaps checking for "!res->flags" would be sufficient?
> > >
> > > I assume this still causes memory leaks on systems where resources are
> > > coalesced, as the second resource of a contiguous aperture is no longer
> > > referenced? Perhaps instead of clearing the resource, it should be
> > > removed from the list (and freed? is it actually safe to do that?)?
> > >
> > > Apparently Johannes had identified the bug before, but didn't realize
> > > the full impact...
> > > https://lore.kernel.org/r/5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net/
> > > ---
> > >  drivers/pci/probe.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 17a969942d37033a..be628798d279ada0 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -994,7 +994,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> > >       resource_list_for_each_entry_safe(window, n, &resources) {
> > >               offset = window->offset;
> > >               res = window->res;
> > > -             if (!res->end)
> > > +             if (!res->flags && !res->start && !res->end)
> > >                       continue;
> > >
> > >               list_move_tail(&window->node, &bridge->windows);
> >
> > Hi Geert, Hi Bjorn, Hi Kai-Heng,
> >
> > I just stumbled over this issue on s390 with the below kmemleak
> > splat[0]. On s390 we currently always have a single PCI bus with bus
> > number 00 per PCI domain so this is triggered whenever there are PCI
> > devices attached to the system.
> >
> > Applying the patch from this mail makes the splat go away and the
> > 'pci_bus 0002:00: root bus resource [bus 00]' message reappear. As this
> > mail is from July I guess it got lost and this was never picked up ;-(
>
> Sorry, I still have to go over all patches submitted last summer that
> didn't make it...
>
> > For now feel free to add my:
> >
> > Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Yes I think maybe we should also free it, but I am not entirely sure
it's safe to be freed in this context.
Kai-Heng

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
