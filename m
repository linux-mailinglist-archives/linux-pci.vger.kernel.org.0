Return-Path: <linux-pci+bounces-6118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E378A0C00
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 11:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70DAB25D4F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0BD1422C4;
	Thu, 11 Apr 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjrJIBBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE913FD68;
	Thu, 11 Apr 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826787; cv=none; b=S6pC0Jx77Rf7jxBMU9D039HZqXQjnxfDgJG+1eh1rLMJ5hsN+ogflbBHxqahG4+R7j6yi7L0TUttJouw/2XuZb4rWV86Fkls8epEGoYNT/t1y4TMq+mRLaQHSotDGoZKY2hViod/lXNeErEQiw02UVcETQmKH84pEdeUAL0lhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826787; c=relaxed/simple;
	bh=aCLIi+AVkjstQsIQpnTKGtc4pAB50POF3WZ8GuxPwO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUwV7eN3gpEn/XrHyyTu6qyMiXUly93pb5IV3XY3Bl1Ihbq52BUfFj1lS7E/9KJIbE0cgCf95s0jm8UtZb98r9yGaLves1fIl3TFBc37Xj0VRnAF6W/QL/qZRDZuU8Bg1PVMySrAEwCIC7DRCZRzSKgaPOtMfbfMm2UKT3XdpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjrJIBBp; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2330f85c2ebso941489fac.1;
        Thu, 11 Apr 2024 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712826784; x=1713431584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvNwsiJeMA7Qr/EyaBx9I0OkF4w8O8NC6WXdusd8vRk=;
        b=HjrJIBBp67kV3iOTh05FzUCXT9MOrxIiPDvQTtHe9dXG6xin6qvKbfsU6JaxD3HwMl
         S3ernLF/7ZsvfgG1Q5wxDmMZ7iyi3el9K2KCh2e+KznDIiLof+sc/rRqbabhvlffXYmo
         3DpyoDtUmCHo9mRg07qaTN0Lb0tMwK4+yMEBdi5WjIEHzodasLY1rvJBKQPWuvvcKY+M
         H5IAYv3StoqHmEFGvebp/bQRLsL/moE9K0VdVVGFy63XaLjvPeyIHPSD0rIRl2wPjC02
         RuacfGpvUx9Rr2zuBqcqLjqZ70sxyE1j06a33KJWiFMC2Ayu1w7k7tbBPxnpaUr1vcPw
         N9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826784; x=1713431584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvNwsiJeMA7Qr/EyaBx9I0OkF4w8O8NC6WXdusd8vRk=;
        b=urSyDaDVgmU8JlGeLRFgJi4+8FZFfu5ymTcwl3fbcp2fK4uxJ+iYTHkvnSl7vm7kRt
         xc9N3CzHANksGKO+YTYe2XCyX0x2w7GPlBgqW3V33YsACnFB5sTCKnpMI2BvQ941AiN8
         jBh4H3C2aRCMXSUnz21B66Kwjdz+jFg8OOxC9s/B05kWXsYqyIBk4SzvL3q8mOSiSofr
         2SP0Sd1TaX0XU+SOVm3kwPbGa8Qchl6FawfCGVTDMgsXQkzaT6o5otQBgXxmj8fzGkWX
         lGV1WA3H8GExNMjakIGWqqEJkFW7Z2PM3tcr/q0thhqe41qiw2e+lBl6jCCyoZ5axknP
         gCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXPjIvjLoFH5UXPg4ehIudvEpWYSo0MT8A0sWTeFPD1W012uA9rXX7+BJJ/Hh1AoQH9QgneGYH/sZRZKacvOTs88RnYd+wEB37Pg0+
X-Gm-Message-State: AOJu0Ywr00h45uYk/Ka/L+YA0E6VHUotgta2snpgt3hbSo/aRHJ1pTGc
	+EHaviqOkQ0uQS5y1FZbMn4J+w14duRkCnucD5BZkiEMTExIIuUZbInxQTnxefeo7Hf1hWsaPCa
	2hG0MRTmi83r6Mu2dtSwR8+OOOdRm/Od4
X-Google-Smtp-Source: AGHT+IG4Tbvl/3bgKG7P9+GQDIw3SVCCbcugECWBfqRopTCh5nwIsFnlNAdD1Sb2wTH5yeVYwgaVQrG6GT1R6gRK76w=
X-Received: by 2002:a05:6871:b203:b0:22e:ddde:adab with SMTP id
 bb3-20020a056871b20300b0022edddeadabmr3980205oac.36.1712826784642; Thu, 11
 Apr 2024 02:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111082704.2259450-1-sergio.paracuellos@gmail.com> <CAMhs-H-Nab+NAcdZ4+VoiikzXgDH55USREhYA6=6xd6ac_OCww@mail.gmail.com>
In-Reply-To: <CAMhs-H-Nab+NAcdZ4+VoiikzXgDH55USREhYA6=6xd6ac_OCww@mail.gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 11 Apr 2024 11:12:52 +0200
Message-ID: <CAMhs-H8zKEt9wxLiz1cKVXdasCR=oNtyvcDGp3ZNuF16vvZARg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Fix possible string truncation in snprintf
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2024 at 12:24=E2=80=AFPM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi,
>
> On Thu, Jan 11, 2024 at 9:27=E2=80=AFAM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > The following warning appears when driver is compiled with W=3D1.
> >
> > CC      drivers/pci/controller/pcie-mt7621.o
> > drivers/pci/controller/pcie-mt7621.c: In function =E2=80=98mt7621_pcie_=
probe=E2=80=99:
> > drivers/pci/controller/pcie-mt7621.c:228:49: error: =E2=80=98snprintf=
=E2=80=99 output may
> > be truncated before the last format character [-Werror=3Dformat-truncat=
ion=3D]
> > 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
> >     |                                                 ^
> > drivers/pci/controller/pcie-mt7621.c:228:9: note: =E2=80=98snprintf=E2=
=80=99 output between
> > 10 and 11 bytes into a destination of size 10
> > 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
> >     |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Clean this up increasing destination buffer one byte.
> >
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Closes: https://lore.kernel.org/linux-pci/20240110212302.GA2123146@bhel=
gaas/T/#t
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/control=
ler/pcie-mt7621.c
> > index 79e225edb42a..d97b956e6e57 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -202,7 +202,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pci=
e *pcie,
> >         struct mt7621_pcie_port *port;
> >         struct device *dev =3D pcie->dev;
> >         struct platform_device *pdev =3D to_platform_device(dev);
> > -       char name[10];
> > +       char name[11];
> >         int err;
> >
> >         port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > --
> > 2.25.1
> >
>
> Gentle ping on this patch :)

Another gentle ping on this patch :)

Thanks,
    Sergio Paracuellos

