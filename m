Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D82D8738
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439237AbgLLPTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Dec 2020 10:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLLPTM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 12 Dec 2020 10:19:12 -0500
X-Gm-Message-State: AOAM532Nx+9hrRde1Wogr21fNly1ShBy18YGqbulx7NXCgQtFnydjgwR
        +WapUYbDeTdLPy/zsoZ7bDQZOykg1XwoqXS0YIs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607786311;
        bh=psS0hu2IUIHN0p65FsTtGV4EUTtLG77MUOh+AZo/pFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RmFUg1o5T+2sP8kQE8wa7IRy+eKJo5EB9Gh6xs3WbV2I5d+MTIBbS4YUCVy94Z8S/
         rs119tEMc8dJogiB88HTo3QzFZaReIkLWA8mDrP3WEpjmzAWNglqghpD9zk9EZenad
         91ZdRJEOzgl3NsT5MJ5lsEaSK5mIpKSOals2+XUqWFRDAmbI+/5i/gABtOl2UFTa0s
         RSPNcCwgf1tNBTn3Ptckf37nnREh+LBol2X7QYPZaNAR0F7DpiWexMD3vj6ijbFbYJ
         ouatYiF+r0HIa6aBWBUD5LUPrG+1KTTWQ8pKO67Gx5wyw9n8yTuv3PU/WAVGVujGhz
         v9V3IqYY/d4KQ==
X-Google-Smtp-Source: ABdhPJyYQRTgL1rTSEK+bKujyRCO/OeCso0uNE89jr89FeehL7hSSu8lYv+6qAr6DfcKWjb3JSUKkYAcGQNDLHbUEbQ=
X-Received: by 2002:a67:fd88:: with SMTP id k8mr15795093vsq.17.1607786310790;
 Sat, 12 Dec 2020 07:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20201118071724.4866-1-wens@kernel.org> <20201118071724.4866-2-wens@kernel.org>
 <CAL_JsqJphYYUsQR_kLH_y1gOArTifpEVUiTJfDpDsL8WjGxRfA@mail.gmail.com>
In-Reply-To: <CAL_JsqJphYYUsQR_kLH_y1gOArTifpEVUiTJfDpDsL8WjGxRfA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Sat, 12 Dec 2020 23:18:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v6409SeptNUvMnpozriZ-L7iFCFFoG+=fJrtohxezDrEDQ@mail.gmail.com>
Message-ID: <CAGb2v6409SeptNUvMnpozriZ-L7iFCFFoG+=fJrtohxezDrEDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
To:     Rob Herring <robh@kernel.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 7, 2020 at 10:11 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 18, 2020 at 1:17 AM Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The Rockchip PCIe controller DT binding clearly states that 'ep-gpios' is
> > an optional property. And indeed there are boards that don't require it.
> >
> > Make the driver follow the binding by using devm_gpiod_get_optional()
> > instead of devm_gpiod_get().
> >
> > Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> > Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > Changes since v1:
> >
> >   - Rewrite subject to match existing convention and reference
> >     'ep-gpios' DT property instead of the 'ep_gpio' field
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index 904dec0d3a88..c95950e9004f 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >         }
> >
> >         if (rockchip->is_rc) {
> > -               rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> > +               rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
> >                 if (IS_ERR(rockchip->ep_gpio)) {
> >                         dev_err(dev, "missing ep-gpios property in node\n");
>
> You should drop the error message. What it says is now never the
> reason for the error and it could most likely be a deferred probe
> which you don't want an error message for.

What about switching to dev_err_probe() instead?

That way deferred probe errors get silenced (or get a better debug message),
and error messages for other issues, such as miswritten gpio properties are
still produced.

ChenYu

> >                         return PTR_ERR(rockchip->ep_gpio);
> > --
> > 2.29.1
> >
