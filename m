Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5732A3EB619
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 15:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhHMNfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 09:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239907AbhHMNex (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 09:34:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 187A86109D;
        Fri, 13 Aug 2021 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628861665;
        bh=9Qb86SEcqSX6DL3UPIPIbuJjCwOh3exFov3A37CTFTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A9DVApuuX8cKZ+y7eUG2FZQkxImAiO+5Y7okEril/Wj/QfqCw2kPhb8iqtVXoYkoI
         0cu2T8dCz6WK046poLS5ez0WKw3gMu4+MQoRqSO7c66ZWT3X2uECu1AMMfBhVAavKb
         SI32RXrbt5aZUeYfh7T/oFy/R65CvG3eStm5udvgorbfmgPWHmCpHqNLgGxk4wN9TB
         H2IUuiq5FJwNVjXb3F1sUesXJbXJko5JzPJMMIDsBIxEN5PuWxHBzccQgOsO1Cu6vZ
         iA790T9c3waU7y/Xo5SAoSvlMjAeoWDtWcGHMDUWil6nfoh7sJVKrAO2Y51mQuYrrE
         r7PPEsSiHvOLQ==
Received: by mail-ej1-f48.google.com with SMTP id h9so18363578ejs.4;
        Fri, 13 Aug 2021 06:34:24 -0700 (PDT)
X-Gm-Message-State: AOAM532JQCvN3tGiGuFvQXtTlbTUZODKFSUfEbsHc2iXgDFRd5S7zMrB
        xS3FM8X6E0HvtFvh+PVm5dk13JjyibjnYnlCnw==
X-Google-Smtp-Source: ABdhPJxykWQAAdheo/ybHO8yXMFnNnbUNOwuVGCk/NVi5KQsWbsVMBqVHL+sFluDbVY0htG/vh471fwCFjdLoezEmCQ=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr2457754eje.341.1628861663642;
 Fri, 13 Aug 2021 06:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210813113338.GA30697@kili> <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
In-Reply-To: <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Aug 2021 08:34:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4Dadf00pJxEDd14zbWyN99s1A2L4fxZSkZddeg2pV6g@mail.gmail.com>
Message-ID: <CAL_JsqJ4Dadf00pJxEDd14zbWyN99s1A2L4fxZSkZddeg2pV6g@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference in probe
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 7:55 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-13 12:33, Dan Carpenter wrote:
> > If devm_regulator_get_optional() returns an error pointer, then we
> > should return it to the user.  The current code makes an exception
> > for -ENODEV that will result in an error pointer dereference on the
> > next line when it calls regulator_enable().  Remove the exception.
>
> Doesn't this break the apparent intent of the regulator being optional,
> though?

I'm pretty sure 'optional' means ENODEV is never returned. So there
wasn't any real problem, but the check was unnecessary.

>
> Robin.
>
> > Fixes: e1229e884e19 ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 20cef2e06f66..2d0ffd3c4e16 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -225,9 +225,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >       /* DON'T MOVE ME: must be enable before PHY init */
> >       rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> >       if (IS_ERR(rockchip->vpcie3v3))
> > -             if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> > -                     return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> > -                                     "failed to get vpcie3v3 regulator\n");
> > +             return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> > +                                  "failed to get vpcie3v3 regulator\n");
> >
> >       ret = regulator_enable(rockchip->vpcie3v3);
> >       if (ret) {
> >
