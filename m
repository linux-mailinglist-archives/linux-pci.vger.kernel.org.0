Return-Path: <linux-pci+bounces-1834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F5D82787A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 20:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DE1284A12
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4454F8D;
	Mon,  8 Jan 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="15/oa8U4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E802454FA1
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7cc92a83200so453623241.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704741774; x=1705346574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t630KAds7hYgoJ0f0LCQ0AiFafn/yi4jTUENLdj9Tv0=;
        b=15/oa8U4pdYzJkHwwrBD/ZBIkmGcfTosoOL6LTbBCbW9PSojKpdH1liW5vWEyMcehQ
         vEx6D2purj1hfQkQAL3p7NY67GY3BgKuLDFWxCiRsNi9pB6cnKjGzbPHUmnWKyKCjdtf
         kCENjprM5m6D9ONGevgO16eUiQJ7c+XnFGq+uwkdXxbjjwgNVYwk/gCf4oAdEpUEQ8L7
         0OqmMouljJgrcrBqjkntsuGjj4ZJzLOSxVVK8UYut5H65FahRmMsln2nAHcgAK9SzAQK
         YKS8MBcUY3csqZgpL3Yov7vR97sH6qVXqaOH+q/SooB/SUXyoRfC9X0cu4mQNvPb/ONS
         J0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741774; x=1705346574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t630KAds7hYgoJ0f0LCQ0AiFafn/yi4jTUENLdj9Tv0=;
        b=RBLgn7u9eK/+bG+zPKJ8Y/pDzXLN7w/nn5wmOHbqt7RpiSr2kPP5GA7sRmFb0hk+s5
         9alHWcxpFW9i8Y3sP8JC+gSvnwcpmgB7j+q1pCrjlAyKPGn4SCR7NH5eEIyo4j0wKTdn
         PHvNDncC5odbSz7CRS4FR+JceAeoTwkeiLf6JJ5/nWvCtDteWejD+eOhUm1LOoEG71PT
         HKo2YoWkeuy5cd012Yvv9Dnwn2i3o17o/GW5F/puwX1hMmN8ZXeahFWknCifwo62ijgU
         vX6xUCFanMCCe2t7SQDJiYsjIGvIZOJMMRzCroDZFrb1zIveXrOaENHAnnXGTrSMfTMN
         W0tg==
X-Gm-Message-State: AOJu0YxyN7o9UYk98zbnvGV90FVStBN4uFKoaolyNgsEI1iuy62Qshdw
	U0bLO4RSwCmuE0R9QVX87VCCs03s2vbQzhocQKKWkVk8tkCn3Q==
X-Google-Smtp-Source: AGHT+IEah3V2Xy4oFA525rnBCO8YyKWJvg7Na5/wUj76Z4lWssvjCk0GeQpBn6QxzFQI/HexZWRnBZrcb5Awcliqtng=
X-Received: by 2002:a05:6122:17a6:b0:4b6:aeb7:3f1d with SMTP id
 o38-20020a05612217a600b004b6aeb73f1dmr1198020vkf.9.1704741773775; Mon, 08 Jan
 2024 11:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-7-brgl@bgdev.pl>
 <20240108191052.GA1893484-robh@kernel.org>
In-Reply-To: <20240108191052.GA1893484-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jan 2024 20:22:42 +0100
Message-ID: <CAMRc=Mc7D1rVHaA4yoOC2DHDkkCptF4wjAm=24Rr=kkqM1ztjg@mail.gmail.com>
Subject: Re: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for
 Qualcomm Atheros
To: Rob Herring <robh@kernel.org>
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

On Mon, Jan 8, 2024 at 8:10=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jan 04, 2024 at 02:01:20PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Document the PCI vendor prefix for Qualcomm Atheros so that we can
> > define the QCA PCI devices on device tree.
>
> Why? vendor-prefixes.yaml is only applied to property names. 'qca'
> should be the prefix for those.
>
> Rob

I didn't have any better idea. PCI devices on DT are defined by their
"pci<vendor ID>,<model ID>" compatible, not regular human-readable
strings and this makes checkpatch.pl complain.

I'm open to suggestions.

Bartosz

