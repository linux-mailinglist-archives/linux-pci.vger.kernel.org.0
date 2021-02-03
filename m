Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5A30E170
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 18:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBCRut (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 12:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhBCRur (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 12:50:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2361064DF6;
        Wed,  3 Feb 2021 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612374606;
        bh=oM7K2Vxjx7uuFW5sZDFCt0cMec89ncC7Fles1dY1qSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xe/FqDAZHDt11fhxGd2kfCDZdzPU6SrlbTI0WU7dV1mKEQzLlk93OR8H3H4N/t+K9
         +X+XDXVacVTPG5ulGEc9b+68JPZjgbvtHL16DBvVYqd5K4aXEHi273tmCRQZEvtAhk
         o7nw8d+jaNpSepvJ7iHnDJZksVLL9vpxBBng+ylsXveV05OXG4B2gnt18OirqjzZ/U
         P4VplM5+i7Q4peUyhOHOU6m059Os/DD8b9O3t2KTAwCW5TqiiV2tHmUg164hS1CmJU
         z8eCJ+Z6glJVkITJ95VaOaCBiYEIejVhWzmo8/ELaLcKgKj6H2xrQPHWMCk9+iwzqf
         3NWAsfiIy0hbQ==
Date:   Wed, 3 Feb 2021 18:50:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/11] PCI: dwc: pcie-kirin: allow using multiple
 reset GPIOs
Message-ID: <20210203185001.30008c19@coco.lan>
In-Reply-To: <YBq+qaOwJdNOllQ/@rocinante>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
        <4fb97b1fc3fe6df9a2fea8f96bdef433e75463a6.1612335031.git.mchehab+huawei@kernel.org>
        <YBq+qaOwJdNOllQ/@rocinante>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 3 Feb 2021 16:18:01 +0100
Krzysztof Wilczy=C5=84ski <kw@linux.com> escreveu:

> Hi Mauro,
>=20
> Thank you for working on this!
>=20
> > @@ -151,8 +152,10 @@ struct kirin_pcie {
> >       struct clk      *phy_ref_clk;
> >       struct clk      *pcie_aclk;
> >       struct clk      *pcie_aux_clk;
> > -     int             gpio_id_reset[4];
> > +     int             n_gpio_resets;
> >       int             gpio_id_clkreq[3];
> > +     int             gpio_id_reset[MAX_GPIO_RESETS];
> > +     const char      *reset_names[MAX_GPIO_RESETS];
> >       u32             eye_param[5];
> >  }; =20
> [...]
>=20
> A small nit, so feel free to ignore, of course.
>=20
> The "n_gpio_resets" variable might be better as "gpio_resets_num" or
> "gpio_resets_count" - both are popular name suffixes for that type of
> variables.  To add, other variables also start with "gpio_", thus it
> would also follow the naming pattern.
>=20
> [...]
> > +     kirin_pcie->n_gpio_resets =3D of_gpio_named_count(np, "reset-gpio=
s"); =20
> [...]
>=20
> This would then become (for example):
>=20
>   kirin_pcie->gpio_resets_count =3D of_gpio_named_count(np, "reset-gpios"=
);

Ok. Will change it at the next round.

Thanks,
Mauro
