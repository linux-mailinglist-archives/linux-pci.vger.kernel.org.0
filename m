Return-Path: <linux-pci+bounces-11483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDEF94BD8B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 14:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87048281DAD
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 12:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1F18B47E;
	Thu,  8 Aug 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PowFAQPT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8F18A937;
	Thu,  8 Aug 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120368; cv=none; b=NGcB4LXB/Wp98jyerC7SZcXRELBYi/lmiKDR2r47Xab1K8TRoMkPm1DG08SC9p3M4a4KvNIU6Akp0EsnQW705dPHp+RmYqSw5yDdYf1vD9LKhNRN7sqi3lwVC5093Eau+feRf/ktsJCfESlJqXOpvgE6k0jHaYiK4kDmIdslzi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120368; c=relaxed/simple;
	bh=nTalzfrNCjKlLWKsns4urkDENdMZzxYdv7NUi8Kvc44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpqPdAVL6wxvNiXtiHXIxPLWCLB+TRGUXpWj0NFjQ5wVfdYC1RA6HqDEB8VvDd4ggOrsyFTLiLIV8OPuvgaKGP0n/pbrpyvTyYCMaUzzj8ZKSWUSqm0TZZS/+vfqK92voZcf6UFrTpwjA8FwKr8OKGYkxhFhmoyM3kUA7dLS1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PowFAQPT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ab76558a9so135751866b.1;
        Thu, 08 Aug 2024 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120365; x=1723725165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VV1dTykEhoT9nZ9CwTmUeuc8Dm5mUMbxnCuJKvSQ9M=;
        b=PowFAQPTSvAo8ZIZLmJrS81YbkAw5dOH3HcnYHUwdvh/HdVzMUI4np9voemjs3OVN8
         +r+29aWlyTzMptJ7L/2fYqZoNo0w3tkGfkTaoZ5UuyMhxiPcJQEgWbgJQcYKAqRqLL24
         ReNzvFVUPDdJYcrY7IjUUtXmd6vK7QPmZoYV5igzFJDj6eCwrRdbA40lgiluiGxRrmSw
         vFI6D6yusp3vjSb8Ih/SHpVOGvhvcgYPiGXHrXuZJpzGvduX+8VtE/OskzCawE3aEBBY
         LDqMFEo3jaC8BW5eV6zX2r4fTIbFPjy1a1TZBWwCZSTpbZPgPK5FpGIgpSHksH7I3ErZ
         RShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120365; x=1723725165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VV1dTykEhoT9nZ9CwTmUeuc8Dm5mUMbxnCuJKvSQ9M=;
        b=bgT43rji0zjvaix7IksgytcxsY9uJKBhjewFD+Bu7pFhmlr58fZMotfAVwhL6uXfeU
         s4cWCRVUUGM96nLXfWIQ6YMBIMIM1EKCouHk6ca4i7+hRuHF8m/HwW+OwC7G6G3vKmh8
         LL4SM8n7tN0nlCefTJxXL6HrFu7CGV8PuIgfpMG/ZZdyU61gVvZIfB3v4FltFasRO1Jx
         muenoAOBL573+njhemnXk9V3dWoJMZxuvc7x0Sgytltaeze3JBLYXYLW7mimJO7PDyQV
         tBz24hlQqp0d528xqN3QeVHiHdSpkZC35VQ79eDfqmuCImlz3ak4FvH/Q7vTDj6+eeeX
         nRQg==
X-Forwarded-Encrypted: i=1; AJvYcCVjnBfAUWJDEimTka8baJRt9XMIXkb9e4Vp0s4caRemyVT6BzQuFxfhUzJoBqf3v6oc+3tUOgJYLOo6@vger.kernel.org, AJvYcCWZChc3AXZXNr2RK/PgbNVyK3lABBus+TbbY34vB157VKlVAvA16hX6oAdcbL8mBLY0G0EFBieU@vger.kernel.org, AJvYcCWxIUwOeyQAWbmvoKdif+1gl4wCqROg/R3Vzu5mqOkYeGqC/AHf0L9Uv21giZti0ezyV7+vqBn/NbAkMVbF@vger.kernel.org, AJvYcCXnnkOvM5B7NWlU8Eeknl0JaSJhMqbGlU5GWWTIl5sVXCawXAwFc9kvyi2iMG207r9PuRQR6r70n6rx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5FGYZV4RAtco7vxDFoX6zZLRVnpfJSacXJPvRHPVKzyrRYfE
	UN35iS5p0wGw1cvemw+rsobIMpDVFIFqXB/rsmeqtI+xCuLALpJstBuRWBPWUCY8fLzQBpCiN+B
	6QmB5/DiytDTSqLCfsjwu9xa6kb4=
X-Google-Smtp-Source: AGHT+IFUNX1ekCclzfjH7BCH130vbtHkmXnzNDQGQNHgUQtZNFLCYl0pxpBbwHki1DFA7Qhthd0swzZQZh7Gam147QY=
X-Received: by 2002:a17:907:7f9f:b0:a77:cdae:6a59 with SMTP id
 a640c23a62f3a-a8092016903mr164012466b.21.1723120364320; Thu, 08 Aug 2024
 05:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805101725.93947-1-herve.codina@bootlin.com>
 <20240805101725.93947-2-herve.codina@bootlin.com> <CAHp75VdtFET87R9DZbz27vEeyv4K5bn7mxDCnBVdpFVJ=j6qtg@mail.gmail.com>
 <20240807120956.30c8264e@bootlin.com>
In-Reply-To: <20240807120956.30c8264e@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Aug 2024 15:32:07 +0300
Message-ID: <CAHp75Ve0SVSzM36srTY7DwqY5_T9Bkqa0_xyDC2RzU=D1nsTwg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] misc: Add support for LAN966x PCI device
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:10=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:
> On Mon, 5 Aug 2024 22:13:38 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 5, 2024 at 12:19=E2=80=AFPM Herve Codina <herve.codina@boot=
lin.com> wrote:

...

> > > +       if (!pdev->irq)
> > > +               return ERR_PTR(-EOPNOTSUPP);
> >
> > Before even trying to get it via APIs? (see below as well)
> > Also, when is it possible to have 0 here?
>
> pdev->irq can be 0 if the PCI device did not request any IRQ
> (i.e. PCI_INTERRUPT_PIN in PCI config header is 0).

> I use that to check whether or not INTx is supported.

But why do you need that? What happens if you get a new device that
supports let's say MSI?

> Even if this code is present in the LAN966x PCI driver, it can be use as =
a
> starting point for other drivers and may be moved to a common part in the
> future.
>
> Do you think I should remove it ?

I think pci_alloc_vectors() should be enough. Make it to be the first
call, if you think it's better.

> If keeping it is fine, I will add a comment.


--=20
With Best Regards,
Andy Shevchenko

