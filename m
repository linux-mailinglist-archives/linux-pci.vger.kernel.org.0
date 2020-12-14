Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC662D99A4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439555AbgLNOSJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 09:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439156AbgLNOSJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 09:18:09 -0500
X-Gm-Message-State: AOAM531lIkxewA9BovAnIlo4+Au62ebp07CxVhEIMAZ+zXPsjotv4XkY
        mWAzVpcVRibYU803TN/PuPyf+QP2HZSF4idmgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607955448;
        bh=vgF8+AK6GkBkQYu4wyAk0STQnnPO354gKvQ6xqwdcfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UmexIdARMA6NpqX5l/Ll1YH7GxF2bLQRdPOHD/ZZIUFm5MJNvSr2lKR1TSEU0DJGj
         6l7ix120lUgWQu482Ycgcty7yW3BRqOatZsrfTlM5v65GdoRdrkXX2aywlRUziM3cZ
         qodmZ0IwyS5ZXX1829JWd3FEkE3IP9G+T3diDYTe2wafs3ufzRLzb38pHXL3w05pyl
         5urYUo3XBlIiDijQ+p4vvKG9HNiT6hY+a5Q3xrL4lYRTtiZfwPwyOHs1QbcTvPR81+
         OUPNQzjxhLDJCm56ps8uqr6NkD6bkLaB5W8pFjGl5B2StUSP5umPrtlWGRSfA5Le86
         TqzRm9q75FaQA==
X-Google-Smtp-Source: ABdhPJzYRe4IfcaOp8gXNnir2xIHkexB7fAKbIAKD+/2t8UmLHcMcL+EMxw9BMGG2PCerqzkxj+BwlEdA4xVCD10jVg=
X-Received: by 2002:aa7:d154:: with SMTP id r20mr26170869edo.258.1607955447089;
 Mon, 14 Dec 2020 06:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20201118071724.4866-1-wens@kernel.org> <20201118071724.4866-2-wens@kernel.org>
 <CAL_JsqJphYYUsQR_kLH_y1gOArTifpEVUiTJfDpDsL8WjGxRfA@mail.gmail.com> <CAGb2v6409SeptNUvMnpozriZ-L7iFCFFoG+=fJrtohxezDrEDQ@mail.gmail.com>
In-Reply-To: <CAGb2v6409SeptNUvMnpozriZ-L7iFCFFoG+=fJrtohxezDrEDQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Dec 2020 08:17:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0fMQkqYZ0W0eqnB+J016n-VnBm0TM2Hv1nqhO8_yUbQ@mail.gmail.com>
Message-ID: <CAL_Jsq+0fMQkqYZ0W0eqnB+J016n-VnBm0TM2Hv1nqhO8_yUbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
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

On Sat, Dec 12, 2020 at 9:18 AM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Mon, Dec 7, 2020 at 10:11 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Nov 18, 2020 at 1:17 AM Chen-Yu Tsai <wens@kernel.org> wrote:
> > >
> > > From: Chen-Yu Tsai <wens@csie.org>
> > >
> > > The Rockchip PCIe controller DT binding clearly states that 'ep-gpios' is
> > > an optional property. And indeed there are boards that don't require it.
> > >
> > > Make the driver follow the binding by using devm_gpiod_get_optional()
> > > instead of devm_gpiod_get().
> > >
> > > Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> > > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> > > Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT")
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > > Changes since v1:
> > >
> > >   - Rewrite subject to match existing convention and reference
> > >     'ep-gpios' DT property instead of the 'ep_gpio' field
> > > ---
> > >  drivers/pci/controller/pcie-rockchip.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > > index 904dec0d3a88..c95950e9004f 100644
> > > --- a/drivers/pci/controller/pcie-rockchip.c
> > > +++ b/drivers/pci/controller/pcie-rockchip.c
> > > @@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> > >         }
> > >
> > >         if (rockchip->is_rc) {
> > > -               rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> > > +               rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
> > >                 if (IS_ERR(rockchip->ep_gpio)) {
> > >                         dev_err(dev, "missing ep-gpios property in node\n");
> >
> > You should drop the error message. What it says is now never the
> > reason for the error and it could most likely be a deferred probe
> > which you don't want an error message for.
>
> What about switching to dev_err_probe() instead?
>
> That way deferred probe errors get silenced (or get a better debug message),
> and error messages for other issues, such as miswritten gpio properties are
> still produced.

I guess, but those errors should be in the subsystem code IMO rather
than every driver.

Rob
