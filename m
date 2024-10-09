Return-Path: <linux-pci+bounces-14081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B569996704
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8492B287E03
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814B618E764;
	Wed,  9 Oct 2024 10:20:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8718DF81;
	Wed,  9 Oct 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469248; cv=none; b=f90yxizk2d7TSP6ANWJ+aAPKScecFoH08Qb4KoErg9WcjLuvdNFq6opntwG1bNgqPoO+XKnbDKDTYmYyeIhCZjE9ScxKAZgMOCFashfl2i36evfNnJxc5Hc/JDzDziYAaixyHJfxSH6R9H075mStsOb46e6HvGwVApXqGer0j7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469248; c=relaxed/simple;
	bh=WxQO53nShc3atpxASPIpnj4iBQ2ZCBiotS98AOqfNJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZurxNhIEyX1IJefSihWIsv2nDrutIQHhZvmU3Gn3oPQaQwlJBtORXRJuhtH+EdUYc5gflRlPIaYESObKAfAffWuwPt9yEAQ62sNFUXeEvtgcs17hjDGl+yAXOL6a2/zBIRhYsqpKA0K0JF807/BdRmXDIV6EJHtcPt5JeqXwuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6de14e0f050so51670587b3.0;
        Wed, 09 Oct 2024 03:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469245; x=1729074045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdkcypZhy554wrLZ9BXXTdDsDbUmUhozZb/Cfup4ur0=;
        b=Y5KD42wBcZY99JTxw1AOOPAVyCjVsCXHblmFJSeAgOppHDhECODeQzx85XFw7t2wK3
         aL/F+1dYeUSZydlE3x7VtRaPgG1ln5s3kt+kSdhCIkCSPmWh86RGIOCJ8XOzgGUHGpyQ
         8x4q/7yn5aZ5lIb5y6zVSK5Pc7VvVksZVMrgeIE2OnlzbksScawvRA6qsGN2sLT8GMVY
         QBKAaK8K3pl3ozsMlmJkX1M7JP26MladCYWImKczyU4BD9gXXH+qEcwf1pWZvoug0G4g
         7kgCucAEPRTVg/uPbcaeg3yBjQu+07diaFbba/cjzd2ZopgfJi7ZmCp1vKwQ/xMlf0re
         ES/w==
X-Forwarded-Encrypted: i=1; AJvYcCUx5aJIJdcm1plQz4CBNgFmi5U44/dWDtVkevEzouSkUIt/Nz8CgAy7BN1D54F5rzvVO19JhgS++rXu@vger.kernel.org, AJvYcCV/pFNzik61q6zcrSnDC4WocJ7n/7QncJYB/LuxcWptJhtR6q9Soq2FwJpuYEpd5AkOtXdWm8ALdV8s@vger.kernel.org, AJvYcCWmwZtWhu778VCVBWgUp/8JKlFrGJ26IAs0DEk5i/w+H4hGlTDAHJKChiUzf1wjDeLG6Qhu6K9g+m/Tndeh@vger.kernel.org, AJvYcCWxb9X9c8GOGeWBdIIWEA2VIqzVYOrDtShaG4rIfNqqyjn4YaZHaVjupEmA92cwGxDsiPRbvlCR@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVANEiAtHz1x30HIv7ZZeJVigRXWO+EWYzP1jDSm2wPv0X1Oh
	/Ehp6K0Ik9dbtC774KurISI7SyxLRNOocnTUWj8WjmGDFKWST81cJrB6MiEA
X-Google-Smtp-Source: AGHT+IHibOC4mm11dZNaU52P3GYvFF7pQdJbx8+yXadMudDf/LGaZoqJj9d9OfW3RUIFZdAAYFuvRQ==
X-Received: by 2002:a05:690c:4349:b0:6e2:2c72:3aaf with SMTP id 00721157ae682-6e32218bd03mr11875757b3.31.1728469245352;
        Wed, 09 Oct 2024 03:20:45 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e30ba26925sm7789227b3.49.2024.10.09.03.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 03:20:44 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6de14e0f050so51670447b3.0;
        Wed, 09 Oct 2024 03:20:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpyCUw6uBztOnTRvwDj8dx00kHW4Ku5GP7oxmBM4u26dlW5a/D+CTA0I/Hm5x9a/VgmR6x8qpm1fys@vger.kernel.org, AJvYcCV/UD+Dd5s1OaOX0EmXBIEUrOXPYkJKgB1cbKaJRvtuBCzZouKk1ySTYfk0dhzM3kOkSqpujOAW@vger.kernel.org, AJvYcCVKQNigbF5g7YF1j56dx11NZ7e3Brbr+bJWSrsW0ZB8+O6GltKDJVNBOP2zByIaZxIeUF+HTinEQukC@vger.kernel.org, AJvYcCXZ7/nmIBXNI4+2+zRkqnQdNQTozx0a2RVZM3nyjUsDGZqpqrMdQg+hXFddDmP8vtRCwy9PJBToHTEUnNCL@vger.kernel.org
X-Received: by 2002:a05:690c:fc7:b0:6e2:ef1:2555 with SMTP id
 00721157ae682-6e32212b9c3mr18951917b3.8.1728469244467; Wed, 09 Oct 2024
 03:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003081647.642468-1-herve.codina@bootlin.com>
 <20241003081647.642468-4-herve.codina@bootlin.com> <71fb65a929e5d5be86f95ab76591beb77e641c14.camel@microchip.com>
In-Reply-To: <71fb65a929e5d5be86f95ab76591beb77e641c14.camel@microchip.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Oct 2024 12:20:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVR8UfZyGUS1c3nZqvPYBNs7oSe5p1GjCA3BYwrz8-bdQ@mail.gmail.com>
Message-ID: <CAMuHMdVR8UfZyGUS1c3nZqvPYBNs7oSe5p1GjCA3BYwrz8-bdQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] reset: mchp: sparx5: Map cpu-syscon locally in
 case of LAN966x
To: Steen Hegelund <steen.hegelund@microchip.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Wed, Oct 9, 2024 at 9:30=E2=80=AFAM Steen Hegelund
<steen.hegelund@microchip.com> wrote:
> On Thu, 2024-10-03 at 10:16 +0200, Herve Codina wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe

Hmm, the email I received directly from Herv=C3=A9 did not have the part
you are quoting, so it looks like you are subject to a MiTM-attack ;-)

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

