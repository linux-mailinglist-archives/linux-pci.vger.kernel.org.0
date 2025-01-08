Return-Path: <linux-pci+bounces-19533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C6CA05940
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333B51882A0E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8319D06A;
	Wed,  8 Jan 2025 11:09:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A41F76C7;
	Wed,  8 Jan 2025 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334575; cv=none; b=QtZT2Rbij64icb8PO4rzVAz22L7INAU8AzxXr74sfYiBDP11jbb2ZOAkc3GyxF47EpQKj4HNUjbczTiRP753NYpqFi+2Z6WiDNc9Ncc/k4HCG+JftIREYeF0+sqoVhkbOXhrzwSCA8DcvG628+RB6ZK1vb8fV1uaYSCTqptROP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334575; c=relaxed/simple;
	bh=owbcYAk+mxWnIxwWkcsX2AAhJ1TFbC1eOUolY7oO1Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXUJf5pEHSLwnPdLVFK3Q6nC0p9PzAJl7E/dS5m7KGK0KwMMmnZuXcM/pcqTziiyKn+52yuDKgZ8RONBXWkhtoE3fYUu6wz0rb5UOfeDwICkbkGn54Us+5yUIjl3eC/W8HIBxQEdN/uRynJtJ+ulbeXAa+XfYuEjWPeJin5YVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5160f1870f3so5128234e0c.0;
        Wed, 08 Jan 2025 03:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736334571; x=1736939371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ULSqV1L06FHUtWJ0lB0NhRHpD0zLj5+Kc37AInA1mc=;
        b=ceJqDbR6uSnF3VkgevXzvhqqyehcoPYDS42X5iCnw6lpmeYUKw6D17RMQi8Lw7+21m
         yC+7woPCsLurHkPSwv8ljRj/103GPiktbYqpueQnWyJ9NSt+umOYmVmNID31Et0v5MdT
         Lr0Wv71drrF7hTu04lVg/J38oB5P19FfDei/Js1jsMwU9Iw4Rc2F0KD1IivKZp+fHQgQ
         7JWyQt33v9nsCLtiwaiKri4GjGSeXT0Eh6ZzndeWunCjnXNhoZSFdb5nWxAfs61Jppf+
         vpjdBmv0Md9pCwnnhWQ7PDbS85bCyex/iZ/f0y4gI1nQIEF7L99DJ0K6xGXMiqftxQAp
         2YEw==
X-Forwarded-Encrypted: i=1; AJvYcCVVU/MYP0QgAVClp+J8dePh1SivwWAcSdfzKagSQv5VdTVdqtzB2YNEraAyzjYQXk03sifXbtrr5tZ+hJo=@vger.kernel.org, AJvYcCWPNAR0o0A1YbYdKaKbLS4u3G4uPFGmYABoR2UzSZLtLnnvvLlwyLqA7nxBGIv1YUWYmzcJ4xYo9XeugzKlbMa8+Pk=@vger.kernel.org, AJvYcCWjedclj5F07sGvv8k6h83oQjKFaAS/Bq+9Ndv0CcLDoJCDTlgVP/OAYeMDGhKwfJ1h57XRgMSfvq6i@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxNrhKoP+eEF5k0ee8vNOuPU/ZX9H4zCvOLNuIddtmqk7sxqO
	sIsV9w5HdfiTUqeH8OjOP30nV9DnN0lyrFxelqXBT34IaxSOnQ+8xaX05Mpf
X-Gm-Gg: ASbGncvHCFMU0XnSWWFiXlvJNwZ77ntCUYfqu7YWKLYpF/4LoociEUv0rWAmCf03KXh
	CbbJHI5dE27akDvijb7TyLUO5NS5tPNkCRzyriJOTdAt1GOqTcUUE0+ZqIOCe1IL7ePdKuJ2b8m
	YI/MA79GiMThZjmQ5bUWJrZkE8R2xGwO9IHxNYta0zBt7vMxuooNmyJGUrt8Zv72AOKqulnKzfd
	srR96dfUY5VLc9RTu/JxJ3W2FsLnvJSITHtNLJmMeCwLrgQc/Odqto8FKpzHD++df2MpFMaIlVe
	m73HwE+R60jDOTGygwQ=
X-Google-Smtp-Source: AGHT+IFm3HwJ+gO5KHnCRpAEPQ3mcsuLNWHyHHNd2p4iLhkQiE0q9VoDUhQnbp3fNEJGCGTDzRhxWQ==
X-Received: by 2002:a05:6122:7d1:b0:518:78c7:9b4f with SMTP id 71dfb90a1353d-51c6c437fc9mr1312292e0c.3.1736334570930;
        Wed, 08 Jan 2025 03:09:30 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68bea904sm5052193e0c.26.2025.01.08.03.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:09:30 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4aff31b77e8so5549209137.1;
        Wed, 08 Jan 2025 03:09:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxwajsspPAHJ3AZRAMOCkKKh3OPPpMX/QdzfhlQhJiN6mVK1VotCUns2j6lp9JXuiHyNoovNCG3x2t@vger.kernel.org, AJvYcCVaxr+uuHVPkv/fbHO7P4PhqTn8WVITjcyHbH1JfDnsv5eBKaxlEYCJtmTN717TEr9wRTIk64WKxKtkJoFW4d/DhFE=@vger.kernel.org, AJvYcCWw+QisvkqMpUnch1xv6eFGBu6BlbDegs5Kx/QgkElJkIsO2elI0ebtt6XqLHQgpwUfnaB39xHSVUshDBw=@vger.kernel.org
X-Received: by 2002:a05:6102:148f:b0:4b2:5ca2:48fe with SMTP id
 ada2fe7eead31-4b3d0f46233mr1519645137.15.1736334570120; Wed, 08 Jan 2025
 03:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107225653.GA189000@bhelgaas> <tencent_D3EAA236B531BDF17998832CC18EC36CBC07@qq.com>
 <TY3PR01MB1134694A42FADD885D9D7596C86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CA+V-a8u--RC2Snmpm2QZxFfT382GrrD1Mse-JW-JJ_KWA-M_Lg@mail.gmail.com> <TY3PR01MB1134688B49138EA368C0E838686122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134688B49138EA368C0E838686122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 12:09:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWn8UV2F=YUsOnVkB0hDEd02Lzp1TtpKRPK-keU3Vm-mA@mail.gmail.com>
X-Gm-Features: AbW1kvawgdBuxPxoKZ8OnBnMo_JliP_sLYiiJniJaPIdWnxk3s3cAD1Dnmqksy4
Message-ID: <CAMuHMdWn8UV2F=YUsOnVkB0hDEd02Lzp1TtpKRPK-keU3Vm-mA@mail.gmail.com>
Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, "kingdix10@qq.com" <kingdix10@qq.com>, 
	"helgaas@kernel.org" <helgaas@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"robh@kernel.org" <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Wed, Jan 8, 2025 at 11:57=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > On Wed, Jan 8, 2025 at 10:45=E2=80=AFAM Biju Das <biju.das.jz@bp.renesa=
s.com> wrote:
> > > > From: kingdix10@qq.com <kingdix10@qq.com>
> > > > Sent: 08 January 2025 04:59
> > > > Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name
> > > > parameter when calling devm_request_mem_region
> > > >
> > > > On Tue, 2025-01-07 at 16:56 -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Jan 07, 2025 at 09:51:23PM +0800, kingdix10@qq.com wrote:
> > > > > > From: King Dix <kingdix10@qq.com>
> > > > > >
> > > > > > When using devm_request_mem_region to request a resource, if th=
e
> > > > > > passed variable is a stack string variable, it will lead to an
> > > > > > oops issue when executing the command cat /proc/iomem.
> > > > > >
> > > > > > Fix this by replacing outbound_name with the name of the
> > > > > > previously requested resource.
> > > > >
> > > > > Thanks a lot for doing this work!
> > > > >
> > > > > Add "()" after function names in subject and commit log.
> > > > >
> > > >
> > > > Thanks for your review. I will fix the issue right now.
> > > >
> > > > > Please include a couple lines of the oops message to help people
> > > > > connect the problem with the fix.
> > >
> > > Maybe Prabhakar should be able to provide Oops log, as it is tested o=
n real platform??
> > >
> > It doesn't Oops out, it just prints a null string. Below are the logs f=
rom RZ/G2M:
> >
> > $  cat /proc/iomem
> > 30000000-37ffffff :
> > 38000000-3fffffff :

Prabhakar's original email showed garbage here.
Looks like your mailer removed it...

> Before patch:
>
> fe000000-fe07ffff : fe000000.pcie-ep apb-base
> fe100000-fe1fffff :
> fe200000-fe3fffff :

Same here.

> After applying the patch:
> fe000000-fe07ffff : fe000000.pcie-ep apb-base
> fe100000-fe1fffff : memory0
> fe200000-fe3fffff : memory1
>
> kingdix10@qq.com, maybe you need to update commit description referring o=
ops.

Depending on the data found in memory at the time of printing, the
output will be different.  I guess it might still crash in the (very
unlikely) case that no NUL-terminator is found, and the string iterator
will access unmapped memory above the stack.

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

