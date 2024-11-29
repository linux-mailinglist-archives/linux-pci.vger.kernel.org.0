Return-Path: <linux-pci+bounces-17453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7DA9DC220
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 11:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33953B226D2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B90D195F28;
	Fri, 29 Nov 2024 10:30:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624318E34A;
	Fri, 29 Nov 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876200; cv=none; b=IP1xJR8YG/qpbzfkEqcaUqjmXYwLNgm1eWMkCmkH/uGzfFeHFPy1gEKyeO+o1rmWt0Uc98VtOZeVIBkEDNqA/t1/m1djV8sJc5o/BzhLehKfzKierY3g1gWVPV6fcVzgufh+z82b7DLAhnmsQYgw14DFH+5aC4F0iAjIGNWjKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876200; c=relaxed/simple;
	bh=yKaFp5yqzqpNtQG9D+9HKY/4P32rt1Zkitv2khOZdnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQNMJ//keQQlx6CkMYeqntuBbyU8kjRvS0Y8B81kIj9RdfEq5LK42xgIzN5u+YQHLwimVLb8113/opj/9DvfxSXXI9NiB2Drc5afLOpN48UQAEm/JTSEHO2Ai1dxFfa95FG42KRP9ouKm129kvKlPQfvNO/Kj3CPnOqeZ4FOvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4aefdbf8134so458038137.2;
        Fri, 29 Nov 2024 02:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732876196; x=1733480996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppQhOfB0GTFohm0DRY2oBb++m5qCmhOXx8Ed8pgjkgA=;
        b=DHMIT8k4sYePRRv8hv66Qno8wNI7NE0Zrr/tiwbLb744iEwuYKXPYspgI5pEhWS0c7
         Myuzm9yUarMbgBi9HaZ3zIJ4UPxE9owX/SorYvXeo45uVXJO7dzaWsB+2MN4lIth8bej
         +o3dTBPNTQWD3VdKFj5nnduW/jl8t8w2sByLNIHQQ1THm+unX1dtNoK2W0pHMo92dWhw
         fqxv5EIuTh6o5ygFV0FYG1EbuG2Tg9psz35qPx3Cq9ufdxd6Zt7dIr5s+rhlJksjvAv9
         juPnsKCKeDNcaxRIoSK2g06UcCj9WhaKM9MBwFJSaRVQw0/zuHRwkJiBhYZh6c8lOP0m
         oRgw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9E00vm6AdieskEI6TEUdfs9O6Ns+gBi3cu0/mudtYzoBv/MnWOvwdxIPplKS+Upq2EnCfty+0FB9equC@vger.kernel.org, AJvYcCUbF1M2fdVDEKpbIEzk2LFsP1V1v8oa6z6u/PGZ5FeEGP2H0/0wnwdafGHrJnRdk5w7qRp8gAAY@vger.kernel.org, AJvYcCW/r7E3X6bpVvgmp6RNd5tG0PnONgYBISOIBBwzhhCEQFRuiwgRSDWnv5bbmT93VR+WQG4LayJhpUVx@vger.kernel.org, AJvYcCW88Hm0ltFvxk5YMO/YYQrb2PXnTajwIOYw5QxlLxbTcIXQBGPazpBGBghQC5lE8Yv8FN4/MIr9YwgE@vger.kernel.org
X-Gm-Message-State: AOJu0YzomJh3CTG13xy/9dtE90TIPnPF4pGefi6QN6pjwmm3fqhB3VuT
	NtXwzrX1BkeQM/ur9a4rDY2ClYa+76UF4vZCMpJARliP+e89HI5vuOMMxBr8nXI=
X-Gm-Gg: ASbGnctN+t29dq+TLG92sgnpLQuF1uIIV6BzBRJlmRm6UelplZmF6Jo/dRWhepEuAnA
	rhvmy9bq2w3HZ4nB5scXeW4F8eyk4hinNmKQ9CLTPZ1FsKB9gu5hDnJ/h9vhhBxy+J/HptUYPl+
	E4j6aHgW7WI/aOEoTntHbjyKgQoWuqlC6IZMwscV0Ogm2p6W3sq0cQrZI8zetHjkWcrfWbyJwZD
	ttMMXhYUJOldGuiuvuIQFZv56ZBIZ9etw4lIKioQI0v7dTWbApF6f9si43HB1smU/mUVuTekMGk
	qBglVxcLLWTP
X-Google-Smtp-Source: AGHT+IEcOE2rcIs0I6rQJgvoUwcTkXON9eIFaZI+35fuAr7ODGoHF8ouLi+Vszm+5v2BMc2RxdWmOA==
X-Received: by 2002:a05:6102:151f:b0:4af:49cc:7515 with SMTP id ada2fe7eead31-4af49cc99d7mr12238631137.7.1732876196604;
        Fri, 29 Nov 2024 02:29:56 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a0e475sm705843241.7.2024.11.29.02.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 02:29:56 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4af490d79d4so440648137.0;
        Fri, 29 Nov 2024 02:29:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9jRzhHmbRN2wsEyR8i39eKN+io8VF0TaUwkG1izGfX8CtQbMbRUtWX+KztDOdIWk2Zny2iA9jQDdz@vger.kernel.org, AJvYcCVF02p3pVmyWSXlRcQWEp3k8PFMlPzfFM5G731JBoPS/ZXPlPdv8eX/Rm9HUfFrearepLfW/nOoO8T+@vger.kernel.org, AJvYcCVV0DUPPKH99yGZYHMJFPT+Xh15odT9GrBv1uKgtbvgLP0oIph3hLQ1snaXARzgGlrrc522z07igTX442jK@vger.kernel.org, AJvYcCWYPFJrhZanAzsd2jHJ22gWA/SnebQppDd0t2v97QGlEMZN0yKDlGTzTQmasfWiaW7ZUvE8Lx1g@vger.kernel.org
X-Received: by 2002:a05:6102:f07:b0:4a3:a014:38aa with SMTP id
 ada2fe7eead31-4af448a91b7mr13985272137.11.1732876195687; Fri, 29 Nov 2024
 02:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010063611.788527-1-herve.codina@bootlin.com>
 <20241010063611.788527-2-herve.codina@bootlin.com> <dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
 <20241129091013.029fced3@bootlin.com> <1a895f7c-bbfc-483d-b36b-921788b07b36@app.fastmail.com>
 <CAMuHMdWXgXiHNUhrXB9jT4opnOQYUxtW=Vh0yBQT0jJS49+zsw@mail.gmail.com> <93ad42dc-eac6-4914-a425-6dbcd5dccf44@app.fastmail.com>
In-Reply-To: <93ad42dc-eac6-4914-a425-6dbcd5dccf44@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Nov 2024 11:29:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgqEZtd82hSp0iYahtTcTnORFytTm11EiZOjLf8V9tQw@mail.gmail.com>
Message-ID: <CAMuHMdWgqEZtd82hSp0iYahtTcTnORFytTm11EiZOjLf8V9tQw@mail.gmail.com>
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

Hi Arnd,

On Fri, Nov 29, 2024 at 10:23=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Fri, Nov 29, 2024, at 09:44, Geert Uytterhoeven wrote:
> > On Fri, Nov 29, 2024 at 9:25=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Fri, Nov 29, 2024, at 09:10, Herve Codina wrote:
> >> I would write in two lines as
> >>
> >>         depends on PCI
> >>         depends on OF_OVERLAY
> >>
> >> since OF_OVERLAY already depends on OF, that can be left out.
> >> The effect is the same as your variant though.
> >
> > What about
> >
> >     depends on OF
> >     select OF_OVERLAY
> >
> > as "OF" is a clear bus dependency, due to the driver providing an OF
> > child bus (cfr. I2C or SPI bus controller drivers depending on I2C or
> > SPI), and OF_OVERLAY is an optional software mechanism?
>
> OF_OVERLAY is currently a user visible option, so I think it's
> intended to be used with 'depends on'. The only other callers
> of this interface are the kunit test modules that just leave
> out the overlay code if that is disabled.

Indeed, there are no real upstream users of OF_OVERLAY left.
Until commit 1760eb547276299a ("drm: rcar-du: Drop leftovers
dependencies from Kconfig"), the rcar-lvds driver selected OF_OVERLAY
to be able to fix up old DTBs.

> If we decide to treat OF_OVERLAY as a library instead, it should
> probably become a silent Kconfig option that gets selected by
> all its users including the unit tests, and then we can remove
> the #ifdef checks there.

Yep.

> Since OF_OVERLAY pulls in OF_DYNAMIC, I would still prefer that
> to be a user choice. Silently enabling OF_OVERLAY definitely has
> a risk of introducing regressions since it changes some of the
> interesting code paths in the core, in particular it enables
> reference counting in of_node_get(), which many drivers get wrong.

Distro kernels will have to enable this anyway, if they want to
support LAN966x...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

