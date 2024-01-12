Return-Path: <linux-pci+bounces-2085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5DB82BD6C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 10:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540EC1C251B1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C257310;
	Fri, 12 Jan 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TXwmvMkQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6841756B76
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7ce9defc4c2so700680241.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705052595; x=1705657395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SOKaW2woRervs3SEctxvdhsDA2CX0fXEo5IZIZEkjI=;
        b=TXwmvMkQt1bOumNT9ex0KA1MwvpznXy0lLXDMsJFXN+cnNl2GWlLSfZaFxsjYsWF9q
         KQuvfv4cjMnyMvqCIC8QnRA4z2lrgXxakAnNvkb7iDmqX1X59vyi9F8ASou8YzD8BknU
         ZjMlx7pocpxBBPNoGDAN4oCPgtF7Noz0slVoAEAP8mKPbVnnmnqTfrr6OVBLPsTvnCI8
         qJIrBAILq9vRyzZqZuBhhQYoJOWNGAqiBRiDdJW0f2/D52c9XwRhccAncOdIceHb6YLf
         1YK/T8iE0U3rl9C3fw0UqyHc4Al6UJVfBS0ZUCswy9SsL4dyz54iGYahruAMR97cI7rG
         hdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052595; x=1705657395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SOKaW2woRervs3SEctxvdhsDA2CX0fXEo5IZIZEkjI=;
        b=SrX3nUmeuwHAiVW53BizQ5uG1BgddZNwsyzAPG/0iQl+t4hnU07kOoKxQCCusi5V3x
         bl4Js8YdHUkuQ/r4aCO8gJw3q1/KBLWNeYXk5LZJuXtOR3coj7v5JYhVlkEMlm/Il6Fv
         1lp+R+yK3fD7oyOx1iQzCPoXfR85X9Edcxm8S6ybcWmHNSCocsjyicWYNHn53oha0t0A
         vZu7BrBvkDIzkm7Vc988AhiXJ0lqz3fpE4qBUeVNKVBfwXBBV5v7WqQyQLaAKPW9/abY
         jqR/F75WWJ3mSmbdifz44zMyTV8JTclMONLoBm9Wmqn3VnSZPDMd7YZcQ0EtYEAEItQ/
         +fOw==
X-Gm-Message-State: AOJu0YyRJosTu585F7l7sV1sf2YoYkp0SelwWKMCe/jlFcPjjlswjgc/
	Ffuro4ewrkojmrfuPUXDfPYP3gnYj7jWuD6M9mCJ+PAcXDs7Pw==
X-Google-Smtp-Source: AGHT+IGaXoThckSM8NX1Ht9fT8RFyHBo65nMhJgSYIF7TWGvCDsemWJEAEquS+QXpokkqOQiXcw1Whlfv4mDa2JkGVI=
X-Received: by 2002:a05:6122:3b88:b0:4b6:aeb7:3f1d with SMTP id
 fs8-20020a0561223b8800b004b6aeb73f1dmr839449vkb.9.1705052595200; Fri, 12 Jan
 2024 01:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de> <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de> <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de> <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de> <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
 <20240111150201.GA28409@wunner.de> <CAMRc=Mcngw1vw9q0DXRWLKk4o9FOY+Mzz-niueT-v2THvbS1Dw@mail.gmail.com>
 <CAMuHMdUnB_eGhzyOYRczXLMgb65dfHgwHgnv7eXSWDvOvTEdjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUnB_eGhzyOYRczXLMgb65dfHgwHgnv7eXSWDvOvTEdjQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Jan 2024 10:43:04 +0100
Message-ID: <CAMRc=MeGsWV_71MzJ-Srm5MnwMfmwac_DLyC9O-8242eekuhNg@mail.gmail.com>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:44=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Bartosz,
>
> On Thu, Jan 11, 2024 at 5:16=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > No, it was actually a no-op due to CONFIG_PCI_DYNAMIC_OF_NODES not
> > being set. But this is only available if CONFIG_OF_DYNAMIC is enabled
> > which requires OF_UNITTEST (!).
>
> Huh? Config PCI_DYNAMIC_OF_NODES does select OF_DYNAMIC.
>

Indeed, I got something wrong.

But in any case: we *don't* need dynamic OF nodes as we don't create
new ones. We use the ones that already exist. This is logically a
wrong place to add this.

Lukas, Terry: am I getting this right - is the port driver supposed to
go away at some point? Because I'm not sure I understand what the
problem is here. To me it seems that when we create a real device for
the PCIe port, then it's only normal to populate its child devices
from the port driver.

Bartosz

> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>

