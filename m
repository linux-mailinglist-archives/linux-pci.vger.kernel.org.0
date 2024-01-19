Return-Path: <linux-pci+bounces-2372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07641832D77
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29742849C0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4455779;
	Fri, 19 Jan 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZHoH88h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3B5380D;
	Fri, 19 Jan 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682739; cv=none; b=ls9zEMYG1l+a+ursl/6jOnBcUVz00y5DpTMo9y9rK/eJouhjG0A7qytNPmb18OMGgUCl/C2/AO/0jleQOa9DFW7eV5l7oMFiLZz552qmRp+QGn3oaRnQxkesoIWP7ehzF3/JajhbcuiFXzkNWR1u/cA2ujfL3DJx/qRCBaSQHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682739; c=relaxed/simple;
	bh=Txo1OueoDLxHIemOchAiO26LJw2wuuWi6pAo386hds0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2J5Mv/GOGOR6NvroJkuIk9iKRAGSVWCmsmo+YWCOwcRaFmbpYFKzaP+g/l4QugtWHM6pZSfBvvRzV8A9OX8gMTHTgtjzTm/XEnSmxxuLVQILAHpVtsy9X9XDjX2i1jgHzc/GKN8l1DbykKI4BaBBqbZ7dlkxYKtNrQTEtJmX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZHoH88h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09746C433C7;
	Fri, 19 Jan 2024 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705682739;
	bh=Txo1OueoDLxHIemOchAiO26LJw2wuuWi6pAo386hds0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZHoH88hsemWlCk6FbTmuBQypDjrF9bOXPFOxQjJ+6aGkTXnoZ/IWKMYEFszCKlPX
	 +RTLxXwJdCX3/b5MjOND90T0pBSz43prhBnoJiODZjrstK67Rhe7avZwyLl//ci6C9
	 rjU2P9qv4OiUm2EJdfIceQOaOF2COJMvBwM8wnp+p/b5R2PigIwyfa/IlHA7pC2NaP
	 SR80Hk8VfkddYSDgqyaJ1Qc1joMfv4bqvG0GjIFJQkHNxnq6agOLw8+LZ8ykgVeWhJ
	 bvFwcc4ltC0OgC05bFSSq1PF6B6lboQOt6MzEjhyYDTaHeW6xUckPkzqiCCQTT6w8o
	 urzHYCgFJ35Yg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so2266585e87.0;
        Fri, 19 Jan 2024 08:45:38 -0800 (PST)
X-Gm-Message-State: AOJu0YwSM+5J28KkhagLauV9+2HlszeQ+Id+ochTw2hDj+jzdeLLoiO2
	EDKlZTOhiBYGAxCmbd19Xhp7JBJ9k7pKGfpFY4/unsURjXZGNd3Dapyar79cKcMp8oZlnfQzEzR
	tvlbReAc+did8blJo15Rh1SVcaA==
X-Google-Smtp-Source: AGHT+IH3WihsL5JSDYPKTQYktLYY8R3kllt3tKUWp/H+6G+h9KYdaA+nxnYkVgaeOk4WpmSbHqYFV089ySaM6z4HpyU=
X-Received: by 2002:a2e:bc83:0:b0:2cd:8ee4:50b6 with SMTP id
 h3-20020a2ebc83000000b002cd8ee450b6mr119453ljf.3.1705682717099; Fri, 19 Jan
 2024 08:45:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
 <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com>
 <CAMRc=McUZh0jhjMW7H6aVKbw29WMCQ3wdkVAz=yOZVK5wc45OA@mail.gmail.com> <20240119163405.GA32506@wunner.de>
In-Reply-To: <20240119163405.GA32506@wunner.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 19 Jan 2024 10:45:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJnOWcydUmkjrs-0DjpbhJytyA1zw8c8Ue7-W6PNY4CnA@mail.gmail.com>
Message-ID: <CAL_JsqJnOWcydUmkjrs-0DjpbhJytyA1zw8c8Ue7-W6PNY4CnA@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
To: Lukas Wunner <lukas@wunner.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:34=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Fri, Jan 19, 2024 at 12:52:00PM +0100, Bartosz Golaszewski wrote:
> > We have two separate issues: one is powering-up a PCI device so that
> > it can be detected
>
> Just wondering, I note in really_probe() we configure the pin controller,
> active the pm_domain etc before probing a driver.
>
> Would it make sense for the issue you mention above to similarly
> amend pci_scan_device() to enable whatever clocks or regulators
> are described in the devicetree as providers for the given PCI device?

If you mean via a callback to some device specific code, then yes, I
think that's exactly what should be done here. That's roughly what
MDIO does. If firmware says there is a device present, then probe it
anyways even if not detected. I don't think that will work for PCI
because it accesses a lot of registers before probe. We'd need some
sort of pre-probe hook instead called after reading vendor and device
ID, but before anything else.

If you mean PCI core just enable whatever clocks and regulators (and
GPIOs), then no, because what is the correct order and timing for each
of those? You don't know because that is device specific information
just as how to program a device is.

Rob

