Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24C1163F98
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgBSIsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 03:48:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41605 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgBSIsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 03:48:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so22343405otc.8;
        Wed, 19 Feb 2020 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R08prwaXuvTYAVVThubWpAvz2VPPRFnMx93j3J6DFWA=;
        b=ZYDvn5yyYTUZAneLoxLh7tNN/BgyWo8q9Zz8A3QhxnB+c2kruqQe2yFxotIwq/UNMh
         pCX9UQZ7f/8WP6GBXFTNl/rpeNW2cboFPXLL3SPMvTq24KjAt1NSBUiOwyGmU7bkn5w5
         PyhJ/4m3EdSclk6A8bY7Z30e5cbYvRcpJ+pA06hZBbgmTJDggae1ejIOHxqPkyjDdZo1
         H09h5m2NSoRKlpBBOlxt0NT1qFVrrM6qoM6hrZ5ytQxh6o2QGakAqC2WABvzZgay7eUx
         YQ+V/YJk0myvKQTjayfxo95WPmZEaknEK6toa5xdgHgewiXXaYbX/4gOy6xH2JHIbaPS
         AOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R08prwaXuvTYAVVThubWpAvz2VPPRFnMx93j3J6DFWA=;
        b=dTvHKvtmVpJhQS/etWanqZadLqq2EnT9O2i+HF5290RXxYAxx4cCEVPDs/GHYAuuBl
         L1PsU2OKI75Z/9NHGl7aAYlf+Ih2I1SZiosvOTjvArn2F5YCBP/kdotlIhDraMyxJN09
         bnxkibo47oKp+YLHfmfdnMPzBJiIwtLte1nXmoDmFNOcaUxv6QWpQlLK92hLxgxNWxGb
         NRxP3mNWIJF06O9ZP+RZJUdFMIDWGKMw/ScB1suqZdOvsYYgCEO4F7TbylJQQ+e8Cxi3
         Wbpxv+MDA6y2ZwKl9Qd/a3LE8VfUk0ameudIBKfycVQ+FhjxJhuUopZ/F2h6XyJa08+D
         hPrA==
X-Gm-Message-State: APjAAAXwIrZyubmobCHxTRMwhnKregtQQhW8+ebHxn8ZgwlG4JKpWUd8
        rmKVcKwkTfxNrysPbe8VlAAD+BE7VUfkxMpJlIY=
X-Google-Smtp-Source: APXvYqyJ+/2xM4/pRZqtjAw7TzJq3x97VyAVdB+hLIZ/Kwd+N1nBgR0qLGPwOHDKMHc8A7r6EXU6PhMoAtXdWTjZD4w=
X-Received: by 2002:a9d:d06:: with SMTP id 6mr19490799oti.176.1582102092752;
 Wed, 19 Feb 2020 00:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20200208183641.6674-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200212140434.GA129189@google.com>
In-Reply-To: <20200212140434.GA129189@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 19 Feb 2020 08:47:46 +0000
Message-ID: <CA+V-a8vVaLpVofr=tp0AXwUzDMwCJ+Byc8VGtmmtOWVSs3GVvg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] PCI: rcar: Fix calculating mask for PCIEPAMR register
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review.

On Wed, Feb 12, 2020 at 2:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Feb 08, 2020 at 06:36:37PM +0000, Lad Prabhakar wrote:
> > The mask value was calculated incorrectly for PCIEPAMR register if the
> > size was less the 128bytes, this patch fixes the above by adding a check
> > on size.
>
> s/less the/less than/
> s/128bytes,/128 bytes./
> s/this patch fixes the above/Fix this issue/
>
My bad will fix that.

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pci/controller/pcie-rcar.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> > index d5568db..c76a92a 100644
> > --- a/drivers/pci/controller/pcie-rcar.c
> > +++ b/drivers/pci/controller/pcie-rcar.c
> > @@ -71,7 +71,7 @@ void rcar_pcie_set_outbound(int win, void __iomem *base,
> >       /* Setup PCIe address space mappings for each resource */
> >       resource_size_t res_start;
> >       resource_size_t size;
> > -     u32 mask;
> > +     u32 mask = 0x0;
> >
> >       rcar_pci_write_reg(base, 0x00000000, PCIEPTCTLR(win));
> >
> > @@ -80,7 +80,8 @@ void rcar_pcie_set_outbound(int win, void __iomem *base,
> >        * keeps things pretty simple.
> >        */
> >       size = resource_size(res);
> > -     mask = (roundup_pow_of_two(size) / SZ_128) - 1;
> > +     if (size > 128)
> > +             mask = (roundup_pow_of_two(size) / SZ_128) - 1;
>
> I would put the "mask = 0x0" right here so it's all in one place,
> i.e.,
>
>   if (size > 128)
>     mask = (roundup_pow_of_two(size) / SZ_128) - 1;
>   else
>     mask = 0x0;
>
Sure will change that.

Cheers,
--Prabhakar Lad

> >       rcar_pci_write_reg(base, mask << 7, PCIEPAMR(win));
> >
> >       if (!host) {
> > --
> > 2.7.4
> >
