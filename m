Return-Path: <linux-pci+bounces-1872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15424827F0F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062511C21329
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B1D8F51;
	Tue,  9 Jan 2024 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BR3uNY2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BD8F63
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso28235831fa.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 23:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704784124; x=1705388924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKZ+huI8zyF9y64Tci/e9CKNNCnYcIoMFreFA1gzux0=;
        b=BR3uNY2aqxJmT75o7xwDgxeATb4y9fom4lRLSxsyllBe4QDRq2d0GDZQ/OGt7N8LnX
         1VYqXJ8lSMOZUvQiOTUjnqzIFT7ExjFMPLl5Lh8hTzl/FND/cT2ZEvzEX35ic27taei9
         66Ymdhj+sS5Y0+j9M0Iti3pUvgQ13Bxv0xIDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704784124; x=1705388924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKZ+huI8zyF9y64Tci/e9CKNNCnYcIoMFreFA1gzux0=;
        b=DDR/vhJR1Py0S9K0Io1PnsfHCTw6YDlSr2OXOXK+qLqli68Eejz/yI1jaFzHao0jZg
         t2utHWQJJYz1jEcfQKUezt6XY3A5Gt8NFlcljvA5l+Rz2ecg1Pl82NB2qQaBtlUn2NzE
         T7LTcHFc47AQBoFWLmk6hLQQjOHAXm7vBKxGg3aKQVRzGt/zktGvDAoccqWUvq9sO2F0
         PY7wzoCvrW0mBCtKqdogfs0lZmB67dQ+gc3x931ldRmAvZOUiI8x488wXiEjfAmy5L5A
         HjMRUi379fqNGPyKJCtQ1ZgojV84DlRmSQgl7RtznGC4tj0ACafRLqkyWqapXAQoSceV
         p5ZQ==
X-Gm-Message-State: AOJu0YxdvKkaBcFUC05hmiKsHPZYsBsShkD7tpfOzSyjjv+IFHFYmY3F
	dCVqokuLfNRVWaxgQCxk89rWP9K4FtBcJVWvDcq19Yz6+GRL
X-Google-Smtp-Source: AGHT+IHuV7ZXffeImPrQxW5h78uhSNEY4eppTSaVCMuaEKuHEsMq7+O1LGba2p8gHRlJMVF9kVGnSOLYolVvVTYKveM=
X-Received: by 2002:a2e:a404:0:b0:2cd:1b40:5725 with SMTP id
 p4-20020a2ea404000000b002cd1b405725mr1063109ljn.212.1704784123625; Mon, 08
 Jan 2024 23:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <a85dbfc3-e327-442a-9aab-5115f86944f7@gmail.com>
In-Reply-To: <a85dbfc3-e327-442a-9aab-5115f86944f7@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Jan 2024 15:08:32 +0800
Message-ID: <CAGXv+5EtvMgbr9oZ7cfnDCDN15BKqgpuiacHHf8_T5kLqYJpJw@mail.gmail.com>
Subject: Re: [RFC 0/9] PCI: introduce the concept of power sequencing of PCIe devices
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>, 
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jim Quinlan <jim2101024@gmail.com>, 
	james.quinlan@broadcom.com, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:09=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> Hello,
>
> On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > During last year's Linux Plumbers we had several discussions centered
> > around the need to power-on PCI devices before they can be detected on
> > the bus.
> >
> > The consensus during the conference was that we need to introduce a
> > class of "PCI slot drivers" that would handle the power-sequencing.
> >
> > After some additional brain-storming with Manivannan and the realizatio=
n
> > that the DT maintainers won't like adding any "fake" nodes not
> > representing actual devices, we decided to reuse the existing
> > infrastructure provided by the PCIe port drivers.
> >
> > The general idea is to instantiate platform devices for child nodes of
> > the PCIe port DT node. For those nodes for which a power-sequencing
> > driver exists, we bind it and let it probe. The driver then triggers a
> > rescan of the PCI bus with the aim of detecting the now powered-on
> > device. The device will consume the same DT node as the platform,
> > power-sequencing device. We use device links to make the latter become
> > the parent of the former.
> >
> > The main advantage of this approach is not modifying the existing DT in
> > any way and especially not adding any "fake" platform devices.
>
> There is prior work in that area which was applied, but eventually revert=
ed:
>
> https://www.spinics.net/lists/linux-pci/msg119136.html
>
> and finally re-applied albeit in a different shape:
>
> https://lore.kernel.org/all/20220716222454.29914-1-jim2101024@gmail.com/
>
> so we might want to think about how to have pcie-brcmstb.c converted
> over your proposed approach. AFAIR there is also pcie-rockchip.c which
> has some rudimentary support for voltage regulators of PCIe end-points.

I think the current in-tree approaches mostly target either PCIe slots,
whether full size or mini-PCIe or M.2, or soldered-on components that
either only have a single power rail, have internal regulators, or have
surrounding circuitry that would be incorporated on a PCIe card.

These all have standardized power rails (+12V, +3.3V, +3.3V aux, etc.).

> What does not yet appear in this RFC is support for suspend/resume,
> especially for power states where both the RC and the EP might be losing
> power. There also needs to be some thoughts given to wake-up enabled
> PCIe devices like Wi-Fi which might need to remain powered on to service
> Wake-on-WLAN frames if nothing else.
>
> I sense a potential for a lot of custom power sequencing drivers being
> added and ultimately leading to the decision to create a "generic" one
> which is entirely driven by Device Tree properties...

We can have one "generic" slot power sequencing driver, which just
enables all the power rails together. I would very much like to see that.

I believe the power sequencing in this series is currently targeting more
tightly coupled designs that use power rails directly from the PMIC, and
thus require more explicit power sequencing.

ChenYu


> Thanks for doing this!
> --
> Florian
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

