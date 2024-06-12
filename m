Return-Path: <linux-pci+bounces-8671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB507905609
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487CA287134
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C817F4E8;
	Wed, 12 Jun 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPP5HYTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBD17E908;
	Wed, 12 Jun 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204390; cv=none; b=r3zmAO3A7j8NswgI4ighBC9/Bpek6d1QsFEd9ZUUi/inC3yUk/qZz1043TFBlBOztwqyZZF+DQfQB4oD0LyJ7EChcSZADYmVZIaw1yT4/MROFUGukbA3QxhOFNjlnyPBJkRffHAETpXghoInp8arV2mmTqAQQg9GBcR3PtMLajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204390; c=relaxed/simple;
	bh=xjUBwltqpAe6aYRnfriue1Gh2w11fmbRUGTxTQAXaYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY8nN6xezMkfFsQQhFjlnaQ94nqDJojco1hRTZjYrZfqKIYhhHHohwMdg4fcBVjFTrupoUoSIhp/fx3vT3Ujh9QH2r6UyyWYS9jmgS8FX2QejhuHOq/Vwz9vnwUhy3Ts84T88q5CDAWZyYHwdH3MTLMtb5dx8zWPV799A2LKf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPP5HYTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A70C4AF1A;
	Wed, 12 Jun 2024 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204389;
	bh=xjUBwltqpAe6aYRnfriue1Gh2w11fmbRUGTxTQAXaYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPP5HYTwgbOgZecxq8aShvk9LnNbGElMzF2+hLVKYBiH0im11j6KEK+BXzjdF9XXA
	 snF7aFCimfCsZmCl6+ialg8qrZpsKH2AD2/LnWQrcjmS+9Eh5Kph3FmiElC2KmXwAo
	 H7ROI58qlZBRlVq2FJQRyhYvmx3LniZ3cS1Z3PO3/wpfPIjS7bNREgMH4HiL5NQYe1
	 xsPWQr/Oe9u3oHRXRSpkW3JsEpL2Ic2amMftS5oiVft0H7s9MdycMUVhMj7M8TPCNN
	 GvjGRtTk+bgWnkoE0MSWuqPERUFOS9wSm/dk/cck5Ju5mHAP9Kc7aThLydsiERXWm/
	 YoMZI/lSV65qA==
Date: Wed, 12 Jun 2024 20:29:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v8 4/5] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240612145933.GC58302@thinkpad>
References: <20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com>
 <20240520074300.125969-5-yoshihiro.shimoda.uh@renesas.com>
 <20240608082455.GA3282@thinkpad>
 <TYCPR01MB11040691A48BD866E9F387D78D8C72@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <CAMuHMdXStQGDNP8c79Bc46kM7BMkbxi=2aVKnLrupWj9Ytn7Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXStQGDNP8c79Bc46kM7BMkbxi=2aVKnLrupWj9Ytn7Ug@mail.gmail.com>

On Tue, Jun 11, 2024 at 12:10:22PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 11, 2024 at 11:21 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > From: Manivannan Sadhasivam, Sent: Saturday, June 8, 2024 5:25 PM
> > > On Mon, May 20, 2024 at 04:42:59PM +0900, Yoshihiro Shimoda wrote:
> > > > +static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *rcar,
> > > > +                                          u32 offset, u32 mask, u32 val)
> > > > +{
> > > > +   u32 tmp;
> > > > +
> > > > +   tmp = readl(rcar->phy_base + offset);
> > > > +   tmp &= ~mask;
> > > > +   tmp |= val;
> > >
> > > Use FIELD_* macros to avoid using the shift value.
> >
> > According to the bitfield.h,
> > ---
> > * FIELD_{GET,PREP} macros take as first parameter shifted mask
> >  * from which they extract the base mask and shift amount.
> >  * Mask must be a compilation time constant.
> > ---
> > So, since the mask is a variable here, we cannot use FIELD_* macros for this function.
> 
> Indeed.
> 

I just can't keep the constant factor in mind for some reason.

> I tried introducing non-constant field_{prep,get}() helpers[1] in series
> [2], but there were some pushbacks.
> 
> Feel free to up-vote ;-)
> 

For sure! This will be very useful, thanks.

- Mani

> [1] "[PATCH 01/17] bitfield: Add non-constant field_{prep,get}() helpers"
> https://lore.kernel.org/all/3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be/
> 
> [2] "[PATCH 00/17] Non-const bitfield helper conversions"
> https://lore.kernel.org/all/cover.1637592133.git.geert+renesas@glider.be/
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
> 

-- 
மணிவண்ணன் சதாசிவம்

