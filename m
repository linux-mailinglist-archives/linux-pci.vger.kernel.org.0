Return-Path: <linux-pci+bounces-8578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AD7903875
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 12:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA051F263FE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB1176ACE;
	Tue, 11 Jun 2024 10:10:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903211779BD;
	Tue, 11 Jun 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100640; cv=none; b=hvzGA2vMu6dHbFurK6qroNY625FTFQMrjejSEZzgY6lW+QV9R81lS1cUqbb2szef0pP+6tphKhn02W3dvPqajkeLNJkJ0qthrSwKLpTN+c/E7OsBIHU2DBLgJY3OBojevKYEBBITPyX/z8s/Bs4x6wmZvFGLiNBp8SBHfVYg5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100640; c=relaxed/simple;
	bh=COhyy0EMEiEvTWniS5hiWSCp2E7Ug8+52x27otSmrDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u33YKnL+ozQGqjWdaaUBX6l0yYXKPrhPRgvxKiIwZsqzNB/QyTbcCFsdd6MumFBmwu21FK+1U+bz8JgihDb7zsSxU2h+drr4mGalHm26zKN85HpCYKLJ4gdn1to1MyL8VLFp2iYhEaxDdZcPGDWrdT5cmKudcVatGF11tueE/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627ebbefd85so61307007b3.3;
        Tue, 11 Jun 2024 03:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100636; x=1718705436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amTzPoOSg3hV6pTO9i4P2UyxjrS5lC65KltuZVzauqM=;
        b=p3mfh2IutjqL7EXgon3fhNdZ3fvwHRJehi5AxsPTxQD/PPnVNQOy/IsUlGDGyeMcVX
         aeAyjl7+mfuS0afWjpYKZkfd3ZAPJvrww86M1Ys2OQpHNSDD7RQ1Ljp9YltIlUBioz1n
         c4m6ZLwkkmsQxCIsigxI2uShs8GQPMwW/Atd5iMx/rTeXqwcgyk3dLmSRxSucy+Q9VDO
         FcNcUkbCjKl4iJSZ/Di+cVDEg6iZs2AB7PvF4gQ9mSJLw2MDYQPc+eB8gIcxz9rgdXGj
         oTX1qwroqo5BXj1h+QCiXAsuH1oUu4Ic2ApT0XVUL3OEgF6pMDVBQEaHK5nNPYts2htB
         pozw==
X-Forwarded-Encrypted: i=1; AJvYcCV73jX8AwMa0h+LH8PvZ2yz9ChQtlPg6wRhz+obWFdgt+ZjgdZ+nypbmuJsGML+keegxtsHRvMV5qOAEHedst5TxDT8YsKLzgacIRwf7NYalk9jdUgkHVuiPRoJG9cXDLwnaeTC4YAvrSN80o/U1+w+ktvAlF+WUXZta1bXwSi6NbbhXAPN9C5Z
X-Gm-Message-State: AOJu0YyaTQr3/JbvGqKnJ3DuLu/8u2Mo4Fkn5wwla8cKzd8RGiz90aNz
	SbLjjgtW99Zn9GjNvDffWhuFZr04GpEXa8W/tkVAzCQZekOdx3qC96qYu83H
X-Google-Smtp-Source: AGHT+IFGoxepLYMC6lNL/EkwxN9iUSsrzhYCoCnHKV7J8PzWM9riZD0Pd4IQAxZ9/fu8QnOPKkWjUg==
X-Received: by 2002:a25:ef45:0:b0:df7:695a:1cee with SMTP id 3f1490d57ef6-dfaf66d1473mr11950907276.50.1718100634925;
        Tue, 11 Jun 2024 03:10:34 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfae53aa989sm1989555276.43.2024.06.11.03.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:10:34 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfaff6bf125so3809266276.3;
        Tue, 11 Jun 2024 03:10:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4ADmnc7gPst0EFY5HQ6JsiZO/yZux180XzpypFQ36ea21kq+anFQATK4t0Pr6W+z17q+okbQkrV2Y5Dmu+AUryeLQZ7bC87gAFTPP+WfWa3Ms2v1JYzZn+k3eIm7ojgsVtTOPQa85lFp+8Y4Ku/cG5X91mSCn6EkMr9PvhcXEt/SvyZRnslB+
X-Received: by 2002:a25:51ca:0:b0:dfb:b89:e04c with SMTP id
 3f1490d57ef6-dfb0b89e36emr9220195276.33.1718100634464; Tue, 11 Jun 2024
 03:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com>
 <20240520074300.125969-5-yoshihiro.shimoda.uh@renesas.com>
 <20240608082455.GA3282@thinkpad> <TYCPR01MB11040691A48BD866E9F387D78D8C72@TYCPR01MB11040.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11040691A48BD866E9F387D78D8C72@TYCPR01MB11040.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Jun 2024 12:10:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXStQGDNP8c79Bc46kM7BMkbxi=2aVKnLrupWj9Ytn7Ug@mail.gmail.com>
Message-ID: <CAMuHMdXStQGDNP8c79Bc46kM7BMkbxi=2aVKnLrupWj9Ytn7Ug@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] PCI: rcar-gen4: Add support for r8a779g0
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:21=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Manivannan Sadhasivam, Sent: Saturday, June 8, 2024 5:25 PM
> > On Mon, May 20, 2024 at 04:42:59PM +0900, Yoshihiro Shimoda wrote:
> > > +static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie=
 *rcar,
> > > +                                          u32 offset, u32 mask, u32 =
val)
> > > +{
> > > +   u32 tmp;
> > > +
> > > +   tmp =3D readl(rcar->phy_base + offset);
> > > +   tmp &=3D ~mask;
> > > +   tmp |=3D val;
> >
> > Use FIELD_* macros to avoid using the shift value.
>
> According to the bitfield.h,
> ---
> * FIELD_{GET,PREP} macros take as first parameter shifted mask
>  * from which they extract the base mask and shift amount.
>  * Mask must be a compilation time constant.
> ---
> So, since the mask is a variable here, we cannot use FIELD_* macros for t=
his function.

Indeed.

I tried introducing non-constant field_{prep,get}() helpers[1] in series
[2], but there were some pushbacks.

Feel free to up-vote ;-)

[1] "[PATCH 01/17] bitfield: Add non-constant field_{prep,get}() helpers"
https://lore.kernel.org/all/3a54a6703879d10f08cf0275a2a69297ebd2b1d4.163759=
2133.git.geert+renesas@glider.be/

[2] "[PATCH 00/17] Non-const bitfield helper conversions"
https://lore.kernel.org/all/cover.1637592133.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

