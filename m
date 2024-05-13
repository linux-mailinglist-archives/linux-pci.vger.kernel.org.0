Return-Path: <linux-pci+bounces-7416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133E8C3DF9
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5801F22781
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D041487D2;
	Mon, 13 May 2024 09:21:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EF1487CC;
	Mon, 13 May 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592076; cv=none; b=BwZhb2p4eRM+UYSewAtmjC+PB7sd70Ii+q6RT1SKKEqF0Zsw5wEvxNCa/LQ1jApqEo8LQAvWQQLlEjHv8S+F3JPkyyr6Pi6+/SlOAI8vBoiVmDSTLUrVFSPqNKgGViCxGQxsesTrHFut7xkk3dk2Yu02aCzzM1na49+juXm1m7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592076; c=relaxed/simple;
	bh=E9xqG6mkDnr7RNS+eZyybbXbVZxwmyX8WqjuMUIaWI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sa0a/CVgtOuC3/Mgp7eKcOnQeOGVMS1kRo9PF8yWnCVsPudbq3j379sk8mM+MV6GbpzHhg8EBVwgQem96h5Bv1fk8PJs+9eNKj+6bN4yicwsUpSDaFnePUwNasLzxnrCo6U22cKcEC0WRY6jTwadOOi+lEeVv6padouIUHXOegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61be674f5d1so44971527b3.2;
        Mon, 13 May 2024 02:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715592073; x=1716196873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfqKWrhN0H2vJ7JvOGO3IefYAkTVUiwdhsHChZFz29k=;
        b=fg5OslqSi2Fc5mX/TCHaigv3/e1dFqSRMdnnDzzILsNiHiO3zFOMJodAeAyuy7OZNX
         mEZ0vfGZE+mv9nBwVcu4Nsx/Ndn4ZGEzA3/SU5XR9C8b8AbtxM56/t7/WHqB//+U4p+v
         2fUw5rMpfQJSK52Ls14s9rvjFVm3THX2DNUzgPBRdl3ESKj/YuyM1qSBLwap06x+cB07
         BY4fgxDcvGsWy34lhF27JPhNt2zMjZQxvph0m+H6vwHd7+BiK+vo84kfuaJvGyQZGmyB
         Ssy5J9wDC4J3McwS3zL3OqNZoYMpsibkRSFKKkisA+8013OPMXajQf9JM/GZh5YoNLMQ
         qcKA==
X-Forwarded-Encrypted: i=1; AJvYcCXQD/b4WIjBo7g7g4KaQKqmXQ7H0GF+/oqxfj1oDn/ywSImnzafuJzEFxFmjFluRJIR0GQuWarLOG3aN2eko6OiMSpnWHRg6FlAgYdGaFCOUmCO9kChBHKMMl5E88Qush54QELZFc+ErE5TPRSmdIbWI1ZeO105d6+pfFSrCA9KCyVrrmQrjnAg
X-Gm-Message-State: AOJu0YwcBeDM4MIRgC5+M2UarSl6RvRMHH+IsiWaG/w2ivpkxoOFkM8B
	3OAVX1dnJwze+vMOPUwgfI9Yy1JGrDnCQWcXG3/FE4Ecyv5Q/uK8AqG+sj9H
X-Google-Smtp-Source: AGHT+IF4bG1HoN1MNrD5loG3NJ8dCKAaU/63g1QjXGotcQgJuW3zLPRGaJyDg4K458+amDgnnvS5+A==
X-Received: by 2002:a81:4c0d:0:b0:620:2753:96b8 with SMTP id 00721157ae682-622aff922b6mr121902537b3.12.1715592072044;
        Mon, 13 May 2024 02:21:12 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e37913asm19903747b3.105.2024.05.13.02.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 02:21:11 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-debaa161ae3so4610527276.1;
        Mon, 13 May 2024 02:21:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXs8Mqz4hDB0T6WufutXFd7XA6sgAKUZH0YLnOm+iNFNBPdlPaeY2EPNS5FgYJ/FLcTE0GYX2/vkkwE9kf2xS67r2aVv0Cp/QhzUYsO2OJMXPcPm5nNytLeoQyQSQEaxFHGcqqOGt0qZNqvaXONLZOmMEhHCeEod01BQpxmfIHFU6hX6TzuiqxL
X-Received: by 2002:a25:be54:0:b0:de5:6a2f:45d3 with SMTP id
 3f1490d57ef6-dee4f360270mr13207618276.36.1715592069302; Mon, 13 May 2024
 02:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-5-yoshihiro.shimoda.uh@renesas.com> <20240511072702.GD6672@thinkpad>
In-Reply-To: <20240511072702.GD6672@thinkpad>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 May 2024 11:20:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTGev4GmX9LFwXx1gn+69ZJFGLB+vsaJou5eLMMa7pkw@mail.gmail.com>
Message-ID: <CAMuHMdVTGev4GmX9LFwXx1gn+69ZJFGLB+vsaJou5eLMMa7pkw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, jingoohan1@gmail.com, marek.vasut+renesas@gmail.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

On Sat, May 11, 2024 at 9:37=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
> On Mon, Apr 15, 2024 at 05:11:32PM +0900, Yoshihiro Shimoda wrote:
> > In other to support future SoCs such as r8a779g0 and r8a779h0 that
> > require different initialization settings, let's introduce SoC
> > specific driver data with the initial member being the device mode.
> > No functional change.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> One nitpick below. With that addressed,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

> > @@ -437,9 +441,9 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar=
_gen4_pcie *rcar)
> >  /* Common */
> >  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
> >  {
> > -     rcar->mode =3D (uintptr_t)of_device_get_match_data(&rcar->pdev->d=
ev);
> > +     rcar->drvdata =3D of_device_get_match_data(&rcar->pdev->dev);
>
> Even though rcar->drvdata won't be NULL, the lack of NULL check will caus=
e
> folks to send fixup patch later. So please add a NULL check here itself.

I tend to disagree: this can never return NULL.
Less than half of the callers of of_device_get_match_data() check for
a NULL pointer, and many of them do so because they are used both
with and without DT.

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

