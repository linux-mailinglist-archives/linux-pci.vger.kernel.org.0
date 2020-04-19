Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8E1AFD42
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDSTKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 15:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSTKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 15:10:49 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB3EC061A0C;
        Sun, 19 Apr 2020 12:10:49 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x10so6968854oie.1;
        Sun, 19 Apr 2020 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gED75tHRUZsoWEBmkmqXmBkA+S7n+TXCiZUX+ASdEyA=;
        b=AMF1DXFRPm9Bk2MU0CgrIARVheldiQhxEiQbB0EpUkPWCUMpk9ohQMAwbi4ShqBtdd
         p3uu4cYI/3J8aCDSkzPifeuU4v6OK9jdP63Z8MqSalHHTYcf2Ky9o9DQLxOMmLIIvgU0
         FoGFyJl3TZY7zrAU841JHbEE2tqAG1a/eAraXi9sKJpT6aDEtU/4m4OFMABqs2irQVhA
         79AVHbzXGeIeCW5I3C3GJi1F7WBCY1a1YUrVfMAz8iDc6Znpxny4sb0eTxKyZ6AY9A+8
         XzenocQ/xWKFrjh7QZ4llHhcPYnMmkxedz2lc5Cju6rY9fMqAEd3FBmoAO5FOxykeK3d
         aYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gED75tHRUZsoWEBmkmqXmBkA+S7n+TXCiZUX+ASdEyA=;
        b=RzIm7/vAwX/xQEWOq1tOCRLnVc+obRdi/cgJEwpwMguF26qzJwrVJziwGER0ccdP9+
         17mQqmVIsvwRuMYQ/szFSf4HcS007W9h1EDdjguhHNiBMVup+jjM6je7Z6/jVyQ+Ve/X
         frGll5xqUwlzBIN1YXhM2IvrS7xwXc4WXKbLSBFdG6N/WbsVJBprY6okm7sC8lGeTCpQ
         0K2u2LbUQgKVFJEKQUPHDNxy4aRsdHPO3Y6b9YF8npyhCF90tpDGXtNGxiwaoyHctnAr
         crb8a+wu9/3B0TrFv/KbfMMOcYaUmqMhM9LaadzPTHIWnJah7IOFTVvpTbyLrX5fonXG
         Byow==
X-Gm-Message-State: AGi0PuZCS23G2uOP/+u4WXzwSkDXxuVa/Ex2vrTqe9sEBOAkidcq0MWm
        mkGOyK7UAwqGtfeF9SB6CCPqYa74RKHveymF1QQ=
X-Google-Smtp-Source: APiQypJy/sjdjUWZOujEBGWlWQXsxdIbkeokdvT3BGmONZYx9UDW/EoFLMydMrhyS4nVxPTI0l8LnJ60Q9sNUNhhjPg=
X-Received: by 2002:aca:5d83:: with SMTP id r125mr8757326oib.8.1587323448883;
 Sun, 19 Apr 2020 12:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587302823-4435-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <975f3a73bb272b8276687af609cd7e592d6ba9ac.camel@perches.com>
In-Reply-To: <975f3a73bb272b8276687af609cd7e592d6ba9ac.camel@perches.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 19 Apr 2020 20:10:22 +0100
Message-ID: <CA+V-a8uADgccR7sr_Jc0t6gcwGSX5aOANF4NZeNY6ZoSaJJ4Xg@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] MAINTAINERS: Add file patterns for rcar PCI device
 tree bindings
To:     Joe Perches <joe@perches.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joe,

On Sun, Apr 19, 2020 at 5:38 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-04-19 at 14:27 +0100, Lad Prabhakar wrote:
> > Add file pattern entry for rcar PCI devicetree binding, so that when
> > people run ./scripts/get_maintainer.pl the rcar PCI maintainers could also
> > be listed.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -12933,6 +12933,7 @@ L:    linux-pci@vger.kernel.org
> >  L:   linux-renesas-soc@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/pci/controller/*rcar*
> > +F:   Documentation/devicetree/bindings/pci/*rcar*
>
> MAINTAINERS was recently sorted for consistency.
>
> Please move this new line above drivers/ to keep alphabetic ordering.
>
Sure I will rebase this patch on -next and post this patch independently.

Cheers,
--Prabhakar
