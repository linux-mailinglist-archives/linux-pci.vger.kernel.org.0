Return-Path: <linux-pci+bounces-4534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00861872693
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820301F28C26
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 18:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC014A8D;
	Tue,  5 Mar 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guU7GJwE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4521426F;
	Tue,  5 Mar 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663579; cv=none; b=shedQZvHSTp4rL2t5Tns7Hpd5KU0+U7ksYtJmAa1uK1ZSVue7MV81aj+C8zWq+7CzUy8CIPVoyeQ/DS7/pseIWGKjJxDCOpteyM2bpbkITE2FiMX4EO/rjkMcmnPEkZOFkNpgvnZFzMab4p8qqLfksMhQ8fICz5QIA+xoBvDU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663579; c=relaxed/simple;
	bh=8Joi1YnfUI86PoK8RcJj71z8krLezvtgpVjZfkAO2YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS3bQQLbvLwVbMndo2YjjXv2+hUprE3ZyKlPhPawxR2hwP5rVxRrXghQk2Pva4B69OIL9zuU6sELtrhKabCv2vcsWKXJUO4fLRgephTfAgvJLfX3x/SD3NfLrv8HqXf94toH4m77A7DkRcNxOQghD0RlaFrS6obybNx2tcA1G5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guU7GJwE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d3fae963a8so3709561fa.1;
        Tue, 05 Mar 2024 10:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709663575; x=1710268375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XpjG7T2rIbD0hxqF2pzMwPpY3w1Cqosv81NqmDg20eA=;
        b=guU7GJwEDP/ohZg+VI2wbQfH49WihnjpVS662AmHq3ntkNr4YR/lS+YFhLITIbE6V1
         mclSvCLFuNBV1BQ2xaY7tyxHT89KPuuI9OBTi/5KpixLYA0JC2gbRtb+5rt5yQCPDaVt
         QI0PZVRTr2ZCnj6anaZ+/iwjJcFc0jqsSIbGvblTwjG0n2qtcsjY4waF/W8CnvB1eYNo
         n2iMBCo021fKKfr1ZBx8mnYMrP1+Z3UmN1rIytrYFfKvUj/2VkzomRMByeVqYV6CrxXe
         cTWc9IbcCPfHRb9/Ztf9mK4xuGxZ+dUGAopmJKsksK573jKVDSM8a8SB93WRP9fEjkL9
         pu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663575; x=1710268375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpjG7T2rIbD0hxqF2pzMwPpY3w1Cqosv81NqmDg20eA=;
        b=m+wcbQcMOzLrH6zo0rU+u+fZJ6TUEpmTK6tDLG0eSUak8zFsBuURQQGUDJKgt2eywx
         KdGJcT8wJ/+8p168+mKWpi36LHxicIGLgOZO8jzoSpkGaJEs9UFL6iv8WHoVmGUjXPMt
         u+pyugxxq6sV8VklwftKTOernAkvYaeExs62aWK14VM9V2igS2n08Mi4rTJI7moRFbS0
         1lstBtmTpQwuTiHKYWzfjj28i06YxhPfEtRsV+rZkSwh/KiBEfDFBKNE1y4i7lm8Bu0O
         qb8Fok+KwKNh+/O6QlmRi5r7di9YvM8xfJnclPw3zC168UO3C6rCpbrp7Q9wbGX29Fea
         j8jw==
X-Forwarded-Encrypted: i=1; AJvYcCV94JSYkG5x4m49NeVEG+WIVaDd05azwhL8L3cfb4AAghJY6Iq3zMLXhWqFR1j42qcM6yoKWIT1FFxapJBkmjcg3NGE8wIW71DDy1kCaH/gE81IB2CJp7lxJTsErPMIEiVIXSBjadL3
X-Gm-Message-State: AOJu0YwYtY4Q3BT3F/YTzkOmKKCbRx8EwCTM6d07A9ZHbnFREjiDhwjI
	fkEdoyQb+ElWQUo3e+6YLijjJrKmZyuWQnzbCT/dvaL/bh/wC9fd3R+nbC7p2EjCqx5HWnaSfr5
	fVgx2IEnaum3NlpZtlqdS0TbK4Oc=
X-Google-Smtp-Source: AGHT+IFu0jJ30nyvSqIno+iVzvIgDHG29XdbqE2DLTx1VGyU1CPP4niQ7GScN82zEFjsRxC4J/FJXjerePfvQgaBmC8=
X-Received: by 2002:a2e:b98c:0:b0:2d3:365e:9d02 with SMTP id
 p12-20020a2eb98c000000b002d3365e9d02mr1597644ljp.28.1709663574840; Tue, 05
 Mar 2024 10:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305113057.56468-1-pmenzel@molgen.mpg.de> <20240305182320.GA541715@bhelgaas>
 <AM9P193MB10797B556A8C4C4B389038D5D3222@AM9P193MB1079.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P193MB10797B556A8C4C4B389038D5D3222@AM9P193MB1079.EURP193.PROD.OUTLOOK.COM>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Tue, 5 Mar 2024 12:32:42 -0600
Message-ID: <CABhMZUV7cTvAta--5T7DUE8m=L=wA3jDfdxELXCUdLxiwu5N4A@mail.gmail.com>
Subject: Re: [PATCH] PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports
To: Niels van Aert <nvaert1986@hotmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:28=E2=80=AFPM Niels van Aert <nvaert1986@hotmail.=
com> wrote:
>
> Bjorn,
>
> Feel free to add my name Niels van Aert and e-mail address.

Done, thanks very much!

> ________________________________
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, March 5, 2024 7:23 PM
> To: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Mika Westerberg <mika.westerberg=
@linux.intel.com>; nvaert1986@hotmail.com <nvaert1986@hotmail.com>; linux-p=
ci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-kernel@vger.kernel.or=
g <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] PCI/DPC: Quirk PIO log size for Intel Raptor Lake Ro=
ot Ports
>
> On Tue, Mar 05, 2024 at 12:30:56PM +0100, Paul Menzel wrote:
> > Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Roo=
t
> > Ports") and commit 3b8803494a06 ("PCI/DPC: Quirk PIO log size for Intel=
 Ice
> > Lake Root Ports") add quirks for Ice, Tiger and Alder Lake Root Ports.
> > System firmware for Raptor Lake still has the bug, so Linux logs the
> > warning below on several Raptor Lake systems like Dell Precision 3581 w=
ith
> > Intel Raptor Lake processor (0W18NX) system firmware/BIOS version 1.10.=
1.
> >
> >     pci 0000:00:07.0: [8086:a76e] type 01 class 0x060400
> >     pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
> >     pci 0000:00:07.0: PTM enabled (root), 4ns granularity
> >     pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
> >     pci 0000:00:07.1: [8086:a73f] type 01 class 0x060400
> >     pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
> >     pci 0000:00:07.1: PTM enabled (root), 4ns granularity
> >     pci 0000:00:07.1: DPC: RP PIO log size 0 is invalid
> >
> > So, apply the quirk for Raptor Lake Root Ports as well.
> >
> > This also enables the DPC driver to dump the RP PIO Log registers when =
DPC
> > is triggered.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218560
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: nvaert1986@hotmail.com
> > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> Added stable tag and applied to pci/dpc for v6.9 with tags:
>
>   Reported-by: <nvaert1986@hotmail.com>
>   Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218560
>   Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>   Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>   Cc: <stable@vger.kernel.org>
>   Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>   Cc: <nvaert1986@hotmail.com>
>
> nvaert1986@, thanks very much for your report.  Let me know if you
> prefer to omit your email or add your real name.  Happy to do either.
>
> > ---
> >  drivers/pci/quirks.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index d797df6e5f3e..663d838fa861 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6225,6 +6225,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9=
a2b, dpc_log_size);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
> >  #endif
> >
> >  /*
> > --
> > 2.43.0
> >

