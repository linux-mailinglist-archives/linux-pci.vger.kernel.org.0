Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA25B2D0974
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 04:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgLGDbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 22:31:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgLGDbQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Dec 2020 22:31:16 -0500
X-Gm-Message-State: AOAM531fmYpUdSB0X9LzVcnLceUz7cLGxg2nb19F6VgI1CpHZyfmgCFj
        LUa+dsyU1BYR4OjqNd5a4IJf93YIRvWyj0V886U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607311835;
        bh=eUFEhztFtJTOa9eLt/B7ip1iRdwwveiI7Iz0zAA+e4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MHCFBPPGIBbBzQoTfSE+6TXG+czMkoFtneP7hOKgWTB9get5ooKKySHHq4wSSSHuu
         jnwpdLNM5HQPCKsNzuikeUfH+oTnYsw+JtnarFq1XxpoIVh4dA5bOjXNNz1hXmnzEg
         8D7JGBu2XBvUgnAAyZrJYedpgLVmPjy1DZq5h6VH7CQCMkkBDbVSgf9GYiYwvPVJ0S
         R4BMQguCVtuSekDaOCc9Q0v6AC0sq+9T/IhRwyvTH/Fh8b6J+/rJXhtcv9GzNVickx
         kRx17yyvDMEWnwuWeiZbdloL2KSo2n3w7GLWAGCMod1qHa9Ei94otUbLbqVPJRml0+
         PDuXmAcN/SqdQ==
X-Google-Smtp-Source: ABdhPJxayhJDe6prQ4cG6ZHdLlgm9hAqKWp2IyvGfr9ZYkzgsb8dlwZ9TK86GpKKZ0XyJ+ub6j9+Vpgs/sZy8RdPdas=
X-Received: by 2002:a9f:21f8:: with SMTP id 111mr10681980uac.115.1607311834678;
 Sun, 06 Dec 2020 19:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20201118071724.4866-1-wens@kernel.org> <20201118071724.4866-2-wens@kernel.org>
 <1737702.WCGJIqnLLh@diego>
In-Reply-To: <1737702.WCGJIqnLLh@diego>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 7 Dec 2020 11:30:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65119yabRi1EE1KSjJ0ehBqd-SoLD-PT-9su3Z+QSVwdg@mail.gmail.com>
Message-ID: <CAGb2v65119yabRi1EE1KSjJ0ehBqd-SoLD-PT-9su3Z+QSVwdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

On Wed, Nov 18, 2020 at 4:49 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 18. November 2020, 08:17:21 CET schrieb Chen-Yu Tsai:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The Rockchip PCIe controller DT binding clearly states that 'ep-gpios' =
is
> > an optional property. And indeed there are boards that don't require it=
.
> >
> > Make the driver follow the binding by using devm_gpiod_get_optional()
> > instead of devm_gpiod_get().
> >
> > Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller suppo=
rt")
> > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC drive=
r")
> > Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt()=
 to parse DT")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de

It's been close to three weeks since this was sent.
Any chance we can get this into v5.10 or v5.11?


Regards
ChenYu

> I'll pick up patches 2-4 separately, after giving Rob a chance to look at
> the simple binding.
>
>
> Heiko
>
> > ---
> > Changes since v1:
> >
> >   - Rewrite subject to match existing convention and reference
> >     'ep-gpios' DT property instead of the 'ep_gpio' field
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/contr=
oller/pcie-rockchip.c
> > index 904dec0d3a88..c95950e9004f 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *ro=
ckchip)
> >       }
> >
> >       if (rockchip->is_rc) {
> > -             rockchip->ep_gpio =3D devm_gpiod_get(dev, "ep", GPIOD_OUT=
_HIGH);
> > +             rockchip->ep_gpio =3D devm_gpiod_get_optional(dev, "ep", =
GPIOD_OUT_HIGH);
> >               if (IS_ERR(rockchip->ep_gpio)) {
> >                       dev_err(dev, "missing ep-gpios property in node\n=
");
> >                       return PTR_ERR(rockchip->ep_gpio);
> >
>
>
>
>
