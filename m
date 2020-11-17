Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A12B5871
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 04:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKQDpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 22:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKQDpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 22:45:22 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12A6206C0;
        Tue, 17 Nov 2020 03:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605584722;
        bh=drQcFzeE83tYePhTQAMPI109uNcJDc7j2Dq1wNZibSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VjjlEIGgDNDhib3HCD/ecC6ccR7GzEYF9OdOftw9gAYWzFub+Viwl4q+IUWmwlF2Y
         urB1uwAis2lyOonRS8IIOXWG7VEZDmC46HVF66jLRVxYfRJMqqivSXdPv+26HnOiVm
         AKMffiOwCL+v1YuqZgKBoeN/92pD/1KELFik5mvQ=
Received: by mail-lf1-f52.google.com with SMTP id s30so28221660lfc.4;
        Mon, 16 Nov 2020 19:45:21 -0800 (PST)
X-Gm-Message-State: AOAM530SyYEIoB+lYsTP9NNUUYLxyv5fyX3QTWdfJV25e/7yZwrYQFIF
        f0gLJDqRzzJBvk5DXbKUm9xsUAgVJbvVcDfb+p8=
X-Google-Smtp-Source: ABdhPJwu9KvFb4x2d38z4QPfSz9ugM2w2KFYs5tx1WnJv/d/x+L//RCuQWZUkx1an8X909f+rrZEhLo/Hs797o1lGpM=
X-Received: by 2002:a19:c354:: with SMTP id t81mr860303lff.283.1605584720130;
 Mon, 16 Nov 2020 19:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20201116075215.15303-2-wens@kernel.org> <20201116164159.GA1282970@bjorn-Precision-5520>
In-Reply-To: <20201116164159.GA1282970@bjorn-Precision-5520>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 17 Nov 2020 11:45:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mMMQmQYay0EVREiQYmSvefmvbsFSCN=C3qG22P8U5HA@mail.gmail.com>
Message-ID: <CAGb2v66mMMQmQYay0EVREiQYmSvefmvbsFSCN=C3qG22P8U5HA@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: rockchip: make ep_gpio optional
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 12:42 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Run "git log --oneline drivers/pci/controller/pcie-rockchip.c" (or
> even just look at the Fixes: commits you mention) and follow the
> convention, e.g.,
>
>   PCI: rockchip: Make 'ep-gpios' DT property optional
>
> Also, you used 'ep_gpio' (singular, with an underline) in the subject
> but 'ep-gpios' (plural, with hyphen) in the commit log.  The error
> message and Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
> both say 'ep-gpios' (plural, with hyphen).

'ep_gpio' refers to the variable used within the driver. But reading it
again, it does seem kind of weird. I will rewrite it to be more consistent.

ChenYu

> Please fix so this is all consistent.  Details matter.
>
> On Mon, Nov 16, 2020 at 03:52:12PM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The Rockchip PCIe controller DT binding clearly states that ep-gpios is
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
> >  drivers/pci/controller/pcie-rockchip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index 904dec0d3a88..c95950e9004f 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >       }
> >
> >       if (rockchip->is_rc) {
> > -             rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> > +             rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
> >               if (IS_ERR(rockchip->ep_gpio)) {
> >                       dev_err(dev, "missing ep-gpios property in node\n");
> >                       return PTR_ERR(rockchip->ep_gpio);
> > --
> > 2.29.1
> >
