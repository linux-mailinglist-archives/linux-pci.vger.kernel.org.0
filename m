Return-Path: <linux-pci+bounces-1861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32B827D19
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 03:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E116285388
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E223D5;
	Tue,  9 Jan 2024 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+gGxxSN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFC5665;
	Tue,  9 Jan 2024 02:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EB9C43390;
	Tue,  9 Jan 2024 02:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704768993;
	bh=b4jGBQYI3SAR2SqDXJaYSqlSOJc84bSHKk28Q7eQgnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I+gGxxSNtyHRtO2VzhAKG1nYxNlizcmiZoXKFCvtLD/bgKnVZGF5THvcV9vOW7Y05
	 yUZgE0r1M3irhKm3qay8Y69ltwwDSXV2AI9B0sipIr/4srk23nvmBjZoTL8WoIafpO
	 WG29mqY7ZkOyanTcGEs7uBduM+Wt+Yj2iEKdthTMAljDgW50WynNYvHtr6dn4ffuH/
	 llRnMeOprdU7EPuL1qqzKYnVFUNQrpzul6nnayxvMmngpwI1P2cmQYo64JNrKFFfZ/
	 Vi+k4ksax1JmRik1uyJnNoXTg9oTqQrmjMIX1W/sTViYDlaqk0PBgvorXSKtuIrIyI
	 sFImw2+6UsTCQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ccec119587so28352311fa.0;
        Mon, 08 Jan 2024 18:56:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yzze1mVJlQ+S04p1QibOWengBh4t3O5kMef8019KWu8RJc5fHYg
	n0zNzitpLos038mBSSW1/tj3aXJHUkk/3o1ZkA==
X-Google-Smtp-Source: AGHT+IFHEy7UAVttPiN+sVOsHl8ngscwYS/9Rb/gv44VqIDfv2qtD5du9ju0uTnDbeescX9gPj6PS5hAvBUURaQ0pxw=
X-Received: by 2002:a2e:b7d5:0:b0:2cc:7814:11b with SMTP id
 p21-20020a2eb7d5000000b002cc7814011bmr2061459ljo.65.1704768991715; Mon, 08
 Jan 2024 18:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-7-brgl@bgdev.pl>
 <20240108191052.GA1893484-robh@kernel.org> <CAMRc=Mc7D1rVHaA4yoOC2DHDkkCptF4wjAm=24Rr=kkqM1ztjg@mail.gmail.com>
In-Reply-To: <CAMRc=Mc7D1rVHaA4yoOC2DHDkkCptF4wjAm=24Rr=kkqM1ztjg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Jan 2024 19:56:19 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKGrW-v=fr_9NYKg-8cho_-XbVQ92eXpjYYC1ma0_8UuA@mail.gmail.com>
Message-ID: <CAL_JsqKGrW-v=fr_9NYKg-8cho_-XbVQ92eXpjYYC1ma0_8UuA@mail.gmail.com>
Subject: Re: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for
 Qualcomm Atheros
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	Terry Bowman <terry.bowman@amd.com>, 
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

On Mon, Jan 8, 2024 at 12:22=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Mon, Jan 8, 2024 at 8:10=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Thu, Jan 04, 2024 at 02:01:20PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Document the PCI vendor prefix for Qualcomm Atheros so that we can
> > > define the QCA PCI devices on device tree.
> >
> > Why? vendor-prefixes.yaml is only applied to property names. 'qca'
> > should be the prefix for those.
> >
> > Rob
>
> I didn't have any better idea. PCI devices on DT are defined by their
> "pci<vendor ID>,<model ID>" compatible, not regular human-readable
> strings and this makes checkpatch.pl complain.
>
> I'm open to suggestions.

The checkpatch.pl check predates schemas and we could consider just
dropping it. The only thing it provides is checking a patch rather
than the tree (which the schema do). It's pretty hacky because it just
greps the tree for a compatible string which is not entirely accurate.
Also, we can extract an exact list of compatibles with
"dt-extract-compatibles" which would make a better check, but I'm not
sure making dtschema a dependency on checkpatch would be good.

The other option is just ignore the warning. PCI compatibles are fairly rar=
e.

Rob

