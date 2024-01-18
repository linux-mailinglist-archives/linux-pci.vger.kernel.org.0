Return-Path: <linux-pci+bounces-2329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2333831F58
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 19:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393A01F22E5A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C432E3FF;
	Thu, 18 Jan 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XD0Na6Ei"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EB1F60B
	for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604022; cv=none; b=ropB3YO7Xlxtz/RWBf8HncVH5GrTWpkbkbGdNo+VRuwuXrgvamshgTlqGZD3GWgKQZF7A1O6mVGs+SKnuF72Ftau9t+sRtdn07bTBB8sRws4qOuQZtW+p68mu+02PvkdqYHjL8qqgkzpJlmf0Kjz8r13maWUPD+syEcmLqcTzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604022; c=relaxed/simple;
	bh=SSrbxqg7mxETW0fX4R7D09mC4obPL5B+tC1UjlKzuJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcpRJca2ziSUW1kh+b6OPyrWITz6mRcGrTlQfRt+sPWetFYXfRmS83Q0AkXD/7nHv8weHzNGYJSznpt5X+2QDAKHh6JXL7cxUNPR+MnbB3xyni+K7Y1FYyNrQDRL0j1sdSVK3VnPXw/J7F42rT5yk4++RSsuinFfgtHMLVR0/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XD0Na6Ei; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dae7cc31151so9758445276.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705604020; x=1706208820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5PF5X8GlaeqQs8DaRumhWkKtgXSZmtgvKGxrmWMH5I8=;
        b=XD0Na6EioXlCaCESXQzBahPa/7rgsSx8lt43UMXIzoWf1hCM/H01EhaMg+NixR2npC
         Ui94KTKUg7K8inuQsqd1Q+//TdTjYekGTnCMdvkYYG3fYbfwh4ZowcYbB6ar0MJivurX
         ifMF8wMgVNXclXb2Ec77hZFQQ7jx6OieVxrr6iIghwywtsriSOPD9GceMty06YMyRaWU
         pPIbpctlf2xPTuryI8EdEeBxWQuAz2m27v9Afw2pDCIBOb4+ux7CshkwLfM5Be62iAXd
         3F9haFlRbvJ2sJ3QrL6XsaYMK0rBj53KoqrDMU5FQ7XlSlnqQAGf7cBtyZQWJc55eQ8Q
         jeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705604020; x=1706208820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PF5X8GlaeqQs8DaRumhWkKtgXSZmtgvKGxrmWMH5I8=;
        b=H32Jw4j3EqEPW+UlYZ5ZDHwhVIkhIce8MBuPPOyDJBcByb2C+vLwgwnT4osI4HnOMI
         Nl/GXsYZgKRJ7gDrl0NBkjIzJoMIJ6i0hhqAue0z3QYHhf+e3McDbVZtYD9mrobf2LaZ
         +a9DzgIfUaWXTsyYu1NhH4v3NlM2y1q3rZURJoDJAjpl//ieXixngtbTuI9j4xb518m1
         ymz0i4Oxvq23AKW5U298VCXuTrgwQQO6d0p9gwxeZu2eTnzdsJCDORM7QMpkzKh3dB7U
         KGtwDsdF15dMRS0XknhcmADAgKUODfnD9hiOm68qKoPtQ5piSgff79imxwxjNkKmcMnF
         2NAg==
X-Gm-Message-State: AOJu0Ywwt+US5e54Bo6ygV38lrCTT3NgHgEyupa76EXpo0IwmtKfQifq
	OYTjPWEDc1aqyREZLB01p4L5RBDkqf/TxnjKGVuSY24ygpIV5fRfeAMidPXl1FL0pXkZx7veoKV
	Fy8eAj77IrfTlL9yR3pVudiB9xegSEeD7MEldzw==
X-Google-Smtp-Source: AGHT+IGYawuUGtABimou0KyICRk+SeNTYHoN53AbxiLx8Ab2OTyuWdrEN8ho0M8p1A0PFwuK2IM4wgevTE1M+mVqV8A=
X-Received: by 2002:a25:941:0:b0:dc2:48af:bf0f with SMTP id
 u1-20020a250941000000b00dc248afbf0fmr1121704ybm.51.1705604020167; Thu, 18 Jan
 2024 10:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
In-Reply-To: <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 18 Jan 2024 20:53:29 +0200
Message-ID: <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
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
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 20:16, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 17 Jan 2024 at 18:08, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The responses to the RFC were rather positive so here's a proper series.
> >
> > During last year's Linux Plumbers we had several discussions centered
> > around the need to power-on PCI devices before they can be detected on
> > the bus.
> >
> > The consensus during the conference was that we need to introduce a
> > class of "PCI slot drivers" that would handle the power-sequencing.
> >
> > After some additional brain-storming with Manivannan and the realization
> > that DT maintainers won't like adding any "fake" nodes not representing
> > actual devices, we decided to reuse existing PCI infrastructure.
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
> I'd still like to see how this can be extended to handle BT power up,
> having a single entity driving both of the BT and WiFI.
>
> The device tree changes behave in exactly the opposite way: they
> define regulators for the WiFi device, while the WiFi is not being
> powered by these regulators. Both WiFi and BT are powered by the PMU,
> which in turn consumes all specified regulators.

Some additional justification, why I think that this should be
modelled as a single instance instead of two different items.

This is from msm-5.10 kernel:


===== CUT HERE =====
/**
 * cnss_select_pinctrl_enable - select WLAN_GPIO for Active pinctrl status
 * @plat_priv: Platform private data structure pointer
 *
 * For QCA6490, PMU requires minimum 100ms delay between BT_EN_GPIO off and
 * WLAN_EN_GPIO on. This is done to avoid power up issues.
 *
 * Return: Status of pinctrl select operation. 0 - Success.
 */
static int cnss_select_pinctrl_enable(struct cnss_plat_data *plat_priv)
===== CUT HERE =====


Also see the bt_configure_gpios() function in the same kernel.


>
> >
> > Changes since RFC:
> > - move the pwrseq functionality out of the port driver and into PCI core
> > - add support for WCN7850 to the first pwrseq driver (and update bindings)
> > - describe the WLAN modules in sm8550-qrd and sm8650-qrd
> > - rework Kconfig options, drop the defconfig changes from the series as
> >   they are no longer needed
> > - drop the dt-binding changes for PCI vendor codes
> > - extend the DT bindings for ath11k_pci with strict property checking
> > - various minor tweaks and fixes
> >
> > Bartosz Golaszewski (7):
> >   arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
> >   PCI: create platform devices for child OF nodes of the port node
> >   PCI: hold the rescan mutex when scanning for the first time
> >   PCI/pwrseq: add pwrseq core code
> >   dt-bindings: wireless: ath11k: describe QCA6390
> >   dt-bindings: wireless: ath11k: describe WCN7850
> >   PCI/pwrseq: add a pwrseq driver for QCA6390
> >
> > Neil Armstrong (2):
> >   arm64: dts: qcom: sm8550-qrd: add Wifi nodes
> >   arm64: dts: qcom: sm8650-qrd: add Wifi nodes
> >
> >  .../net/wireless/qcom,ath11k-pci.yaml         |  89 ++++++
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  29 ++
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
> >  arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |  37 +++
> >  arch/arm64/boot/dts/qcom/sm8550.dtsi          |  10 +
> >  arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |  29 ++
> >  arch/arm64/boot/dts/qcom/sm8650.dtsi          |  10 +
> >  drivers/pci/Kconfig                           |   1 +
> >  drivers/pci/Makefile                          |   1 +
> >  drivers/pci/bus.c                             |   9 +-
> >  drivers/pci/probe.c                           |   2 +
> >  drivers/pci/pwrseq/Kconfig                    |  16 ++
> >  drivers/pci/pwrseq/Makefile                   |   4 +
> >  drivers/pci/pwrseq/pci-pwrseq-qca6390.c       | 267 ++++++++++++++++++
> >  drivers/pci/pwrseq/pwrseq.c                   |  82 ++++++
> >  drivers/pci/remove.c                          |   3 +-
> >  include/linux/pci-pwrseq.h                    |  24 ++
> >  17 files changed, 621 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/pci/pwrseq/Kconfig
> >  create mode 100644 drivers/pci/pwrseq/Makefile
> >  create mode 100644 drivers/pci/pwrseq/pci-pwrseq-qca6390.c
> >  create mode 100644 drivers/pci/pwrseq/pwrseq.c
> >  create mode 100644 include/linux/pci-pwrseq.h
> >
> > --
> > 2.40.1
> >
> >
>
>
> --
> With best wishes
> Dmitry



-- 
With best wishes
Dmitry

