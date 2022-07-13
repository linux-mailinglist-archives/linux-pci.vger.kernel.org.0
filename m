Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75C5732F5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiGMJhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiGMJhE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:37:04 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA6FF32D5;
        Wed, 13 Jul 2022 02:36:56 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id y3so11382795qtv.5;
        Wed, 13 Jul 2022 02:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQ7N/fYLlysLbE4zdECWnWy27WreI9oEQxiTnGoMGOc=;
        b=HYys9IgnJCWNzM+6vk+2H14DanpEbL6+ZOHdTpD4Nq7XHO8Qefix1pCCvI1CXxzRxd
         MFyLQonCez/l/90P4l64znB9efd0dxbcP3yLNkgZrTdR8e/wUVPPemgyyOPfO7SYD9Fj
         /CJ+5Y2DM8uE6qEGMT62w6ST2bk1RXiL2wQwdJFhKi8JrmCglIEovmXv35NfuOMi03R5
         JsHO6+4rS5vbuyuEgXFzSr8G3xk6JpzYhnSKsKbQNmat32yRpZMQdn8HttGiYGDNFQ5u
         iZlM3P8W5DRq/uTu1PuhHEpHiY76UFUtm+ybgbA7jml2pUAOCucCQ4+AMNhvDnLzOFD9
         uAVQ==
X-Gm-Message-State: AJIora+Yim3pUifcYfeckLa3ke7u5knohP5HPIMrOewM+20w7zMKNePJ
        X1cTOXwcHIyatnkHr4srx8bcHhXDV/QLLA==
X-Google-Smtp-Source: AGRyM1u+12N7nN4GfKQcL+35Ef6Dp/u7kPvbDN7fGktpzs00FWDntqb2C1Wuf6kay8EK9KwNILzECw==
X-Received: by 2002:ac8:5c94:0:b0:31b:899:3063 with SMTP id r20-20020ac85c94000000b0031b08993063mr1988143qta.153.1657705014171;
        Wed, 13 Jul 2022 02:36:54 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b0031eb0bb5c3csm7823150qtb.28.2022.07.13.02.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:36:53 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id g4so18314343ybg.9;
        Wed, 13 Jul 2022 02:36:53 -0700 (PDT)
X-Received: by 2002:a05:6902:1246:b0:66e:ea31:8d05 with SMTP id
 t6-20020a056902124600b0066eea318d05mr2830637ybu.89.1657705013318; Wed, 13 Jul
 2022 02:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210713125007.1260304-1-kai.heng.feng@canonical.com> <5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net>
In-Reply-To: <5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Jul 2022 11:36:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrLxHi6x0VKeB3emHYkDcVmAm=u4K2xzPqKOQ9znvuNg@mail.gmail.com>
Message-ID: <CAMuHMdWrLxHi6x0VKeB3emHYkDcVmAm=u4K2xzPqKOQ9znvuNg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Reinstate "PCI: Coalesce host bridge contiguous apertures"
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Johannes,

On Wed, Nov 17, 2021 at 6:41 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> So this patch landed now ... :)
>
> > +     /* Coalesce contiguous windows */
> > +     resource_list_for_each_entry_safe(window, n, &resources) {
> > +             if (list_is_last(&window->node, &resources))
> > +                     break;
> > +
> > +             next = list_next_entry(window, node);
> > +             offset = window->offset;
> > +             res = window->res;
> > +             next_offset = next->offset;
> > +             next_res = next->res;
> > +
> > +             if (res->flags != next_res->flags || offset != next_offset)
> > +                     continue;
> > +
> > +             if (res->end + 1 == next_res->start) {
> > +                     next_res->start = res->start;
> > +                     res->flags = res->start = res->end = 0;
> > +             }
> > +     }
> >
>
> Maybe this was already a problem before - but I had a stupid thing in
> arch/um/drivers/virt-pci.c (busn_resource has start == end == 0), and
> your changes here caused that resource to be dropped off the list.
>
> Now this wouldn't be a problem, but we add it using pci_add_resource()
> and then that does a memory allocation, but you don't free it here? I'm
> not sure it'd even be safe to free it here and I'll just set
> busn_resource to have end==1 instead (it's all kind of virtual).
>
> But I still wanted to ask if this might be a problem here for others.

Yes it is.  I've sent a fix
https://lore.kernel.org/r/9c41a4372b27420c732ff5599d823e363de00c6d.1657704829.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
