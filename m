Return-Path: <linux-pci+bounces-17444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B529DC0AA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E28F161FAC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF652166F0C;
	Fri, 29 Nov 2024 08:44:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2985161321;
	Fri, 29 Nov 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869868; cv=none; b=unaipGLCCrAdp7m095Le/ARH62+p1IJwh73BKKvn+vzN8yuhMM5ZSoMc5JUUMMES81XrwbRqwx32MowSWuaxcQf2kfbsEuNY2oNittBMowU3qp2Hx6ttl7wbhx2WtOG2TN4DJb2CE2+CXOGy1sTSa0UBAfLoYf882r3K3yDvBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869868; c=relaxed/simple;
	bh=5sqR9uQjM/ILZukK9MwwvoCAHBbjzx1SgZRUJfRZKuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka+zVcFXmX+UxpI50mmRyd+RUL8ARUpl4YI/K4+JuD6zUlm3msdsQeVqkOa1d9unK5+EDNK1fawJ6Fy59DOWOfK7gKAclmUApZHUdoQqEUlqindorUkfDJ+TBur2MuHdKCY04104BymxjKPul04WQ5Q/jikt9adOZubxVeKFtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85b9c456f46so120569241.3;
        Fri, 29 Nov 2024 00:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732869865; x=1733474665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeED+wrJM5lj1ej/ygLCajwOh+yVxntCXNjbUrDu5EQ=;
        b=iC1A+om6WmwwwLA8LzLvylWay5zw3t7H3aZm++DwvbB9vh4XtYNZJxm869vAewkW6V
         xNZPalwGQO75ikRixKX5qQeJx2PYrGNO3j+h5TLwcvBV4UFq2Pw1P0qPCv37Xy72tgLK
         TUbf1JS4aU0DMMH4ICdPYF814sDzTJU3oVrpM20g/tJzcTgw66e25hj9wYXdU8QUZbAe
         pawPlmnPzVD/LMTTlEkJz38kaCRuC6ukeV3PDs1D+z0L1tEIwo9psme71wiuLxp+gN2I
         fwoxlCQdR0epBLSpB+4mreyrH84uLQ/3H6uXLxKMbQKyzwsUarIeJmZA+UtOfm2G4tfi
         Nnlw==
X-Forwarded-Encrypted: i=1; AJvYcCUP4sfAJNJdcouV+l7FPEn7G7TW/lv0jlEjA239cSavA/hKSn2D/6IKO8nPCn5ZHEziBvQrPqD4rb7NlWx5@vger.kernel.org, AJvYcCVuINbme7K8aqUausGmE+xOifeBD82QU9qYQAAsbEYwGn0sKi19qQWY4CzUrzPoqP3HeTBIJ2wGbwc5@vger.kernel.org, AJvYcCWujU5eIvZV63t9kjGwAN+DKgJWCmHTbQ96tFfuqPBGp+gnSHxYirNg/+ZRVZkITbkefaqYQRxk@vger.kernel.org, AJvYcCWzes+ZgN8668INrYgMVYHP9jcuk1Kt2s3t4fnOCnOuQ49jvETJ/BqXKA52CiOl4a2mjW6J6yccqUL8@vger.kernel.org
X-Gm-Message-State: AOJu0YzICj84xa3zef+7UwOLmku+bAGeubWpr8SfXm5n2Hp7Zvv7ROe6
	hBsyEE4psJuDZRM47GJ47CeQtn+/k8V3muSufz2aOgJY4EyMB8KwvtDooUp18Ps=
X-Gm-Gg: ASbGncuK7zIsuGcfNbT7aydZgvYWPj4vqoBw47n2zUmZGIEtr3mcJA5x8cHAlUlwue8
	UQRQt9T/6cwsh61DGpw4zhvGQRYYBSrntmL8NXlOwDKln5cTqaRrKID1WcN9JivkYmA/Gp/d8K3
	B/3UYVeXEaJDAWgBz6si68zw2K4769THqAP+5ddVBh5PL8bqws6w/cOw4gOjZx0hE/gSAetCDym
	/JiFzmuy+Qt9TJSu2dBpoYtqp9Sx2Sl5Sa1BjbVpTa28PciTF/5pDcITe4mPRPIRGNSVBAy0P+W
	FLDqCyGhjdYK
X-Google-Smtp-Source: AGHT+IGT3qqJVhbwx4mb8rV4gpFfFkb7AcM5/lsMFvYhcuxpxnktolgSVGHTY4WmlWqcV8QyGlAjgg==
X-Received: by 2002:a05:6102:370b:b0:4ad:4bfd:5b0d with SMTP id ada2fe7eead31-4af449b8e70mr12728643137.23.1732869864920;
        Fri, 29 Nov 2024 00:44:24 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82c9135esm660654241.27.2024.11.29.00.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 00:44:23 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4af490d79d4so413059137.0;
        Fri, 29 Nov 2024 00:44:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfZTEz8UpGtMjnuMnNjfPS5PW7PKRAnVl1EyUF7ym62fG7J5z7jxtkmuYF5dEylIs76nu2e7I1pFVw@vger.kernel.org, AJvYcCVEGd0/50p/NgZ/1auTyFaW7XZvILoYN0wJKDbN41hysdGhC7PvTjcZ+3VNdWV9weL0jvQET5BErQgk@vger.kernel.org, AJvYcCVamZnMylmcmo+kzs1Xk6wR/PLO+fQdtlQiyDLjaWYtInvGY/5s4x2ivIf4sgV7bz7afevVJXcXcV2yPYDV@vger.kernel.org, AJvYcCXjETMPJud9L5Bsg/4S7PBqFzUtDVvw2SggaZFYPt7IgGTR5weWkPR594+B6y+WLtfcs6DNabW+@vger.kernel.org
X-Received: by 2002:a05:6102:508a:b0:4af:594e:ebdc with SMTP id
 ada2fe7eead31-4af594ef13amr6615796137.5.1732869863438; Fri, 29 Nov 2024
 00:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010063611.788527-1-herve.codina@bootlin.com>
 <20241010063611.788527-2-herve.codina@bootlin.com> <dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
 <20241129091013.029fced3@bootlin.com> <1a895f7c-bbfc-483d-b36b-921788b07b36@app.fastmail.com>
In-Reply-To: <1a895f7c-bbfc-483d-b36b-921788b07b36@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Nov 2024 09:44:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXgXiHNUhrXB9jT4opnOQYUxtW=Vh0yBQT0jJS49+zsw@mail.gmail.com>
Message-ID: <CAMuHMdWXgXiHNUhrXB9jT4opnOQYUxtW=Vh0yBQT0jJS49+zsw@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] misc: Add support for LAN966x PCI device
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herve Codina <herve.codina@bootlin.com>, Michal Kubecek <mkubecek@suse.cz>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, 
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 9:25=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Fri, Nov 29, 2024, at 09:10, Herve Codina wrote:
> > On Thu, 28 Nov 2024 20:42:53 +0100
> > Michal Kubecek <mkubecek@suse.cz> wrote:
> >> > --- a/drivers/misc/Kconfig
> >> > +++ b/drivers/misc/Kconfig
> >> > @@ -610,6 +610,30 @@ config MARVELL_CN10K_DPI
> >> >      To compile this driver as a module, choose M here: the module
> >> >      will be called mrvl_cn10k_dpi.
> >> >
> >> > +config MCHP_LAN966X_PCI
> >> > +  tristate "Microchip LAN966x PCIe Support"
> >> > +  depends on PCI
> >> > +  select OF
> >> > +  select OF_OVERLAY
> >>
> >> Are these "select" statements what we want? When configuring current
> >> mainline snapshot, I accidentally enabled this driver and ended up
> >> flooded with an enormous amount of new config options, most of which
> >> didn't make much sense on x86_64. It took quite long to investigate wh=
y.
> >>
> >> Couldn't we rather use
> >>
> >>      depends on PCI && OF && OF_OVERLAY
> >>
> >> like other drivers?
>
> Agreed.
>
> I would write in two lines as
>
>         depends on PCI
>         depends on OF_OVERLAY
>
> since OF_OVERLAY already depends on OF, that can be left out.
> The effect is the same as your variant though.

What about

    depends on OF
    select OF_OVERLAY

as "OF" is a clear bus dependency, due to the driver providing an OF
child bus (cfr. I2C or SPI bus controller drivers depending on I2C or
SPI), and OF_OVERLAY is an optional software mechanism?

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

