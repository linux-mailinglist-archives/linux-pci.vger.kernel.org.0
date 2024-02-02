Return-Path: <linux-pci+bounces-3003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA66846D3D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 11:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D7F1F231BE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6591F79DCE;
	Fri,  2 Feb 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VWf9hxg7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3561682
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868144; cv=none; b=ods+v7HjFpuoOSGylUDnKbKokAnp62cnpLIJgyfUoMCvNQC8lv42051QF6Ighx8cyfccZFSQmIrT8kBZklRRuzSHx03Z7UuP0VG4W45/cSxB1f9omhWwYM4oLNaFdzjNoYIJ20mhj1Kdol+ivRJl5umgaMWPhUm/M+/Rde56fEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868144; c=relaxed/simple;
	bh=NtnCOabBizlH+j0rVkHlFrH9ORsi8hA0FEPEyh8lt8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6ihKhQyZifbKNVFLLcvcmCq/Uy8uuZhzuS3UsGif7R+urkQIvilpAzcon9HrPmrV5PMgVs9koY59S5y3QLad/b1NEOS9bigi218gSZA/rWhhz0qLKcVPtL9yujlnNveioE/AjayGAMs2jUg4HQfdq3Ijjc7yWGB5PUDTFsJXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VWf9hxg7; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5c7443956so910794241.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706868140; x=1707472940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtnCOabBizlH+j0rVkHlFrH9ORsi8hA0FEPEyh8lt8Q=;
        b=VWf9hxg725rKSp6K/x+5G2APFjXuzNFuO328oOy+4jq7wSUZPDcsN/WBO1xY/KucMR
         h2B/FmMB8MHPsdAiHyeKqfo92dX5HvmXCOaSs7I+FWg6TdSh2s8Im0iFANyJa5FhJTJ7
         IAvfDSEPKtMLaslzpvJ6fWtysky2I2h0SHaSJpMGvavViS1eJV84Frm9aj0f3HU3d83L
         fCfSzWwVKVJ9ppS1cEq0b+/qAM1gZPMlHDzO2D98LMqnZfizmyhdfsv7HLuohKH80NV0
         0E5tOXp97kQRUQUl3JnP8EuUSOpr3WF8kPZkZgoNlN9Q9PTEd2SIVTDrzqz4uH6FhIPc
         GjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868140; x=1707472940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtnCOabBizlH+j0rVkHlFrH9ORsi8hA0FEPEyh8lt8Q=;
        b=HZVQifTYxe7vCGyEC34m0Nvjyjl/WPe+ZwuLA2EEUhU/Q6n97yOZxrWZ4BlNqe1U7g
         QEEMjCns4yJKDRcGHJQQgjTWZy88CAYc+7BC2tiUaIm/kwS2rozsgxsQO/c9pnTMP5AE
         UNXtyQR7FWF7lnXgSoovPfBPYjllKRw28EWAUMX8X6a/i9VyIBiktSftlWAFdXAJouYy
         QOqgzElYQ6AQp0vsGsOrnzW9KgypylVjz2I5XAnTv/9/0FEq4e++9pULrRoJNf4ArGUT
         EP17tXTun5JKJ6yFedG54NDaOaoQl9guSwXis4cNWU2mNZdLOLAKL63nND+KQvQ7fWdt
         cYXg==
X-Gm-Message-State: AOJu0Ywbg7Xnt4Tu1emqoUsrb1K66f7hao9dU3hLvjKpQJ8kQ4E1SQyu
	wX5J0y3r2qy3n8Rw4ovG1FG+6H6bPYVXpuscAHo/A3YHIFPI+uahiJeeNzNDUgTIXpLZd6EiRYC
	i5XT1+E85KTzxQvErqma1LlzxRZTo650ZYOom3w==
X-Google-Smtp-Source: AGHT+IED6VmhmnR3HprrJEZF3z8i5PAWSPHx1dSrGyeGjOSLO6M2827ucqxCswBRLc2iIV8iv4KQz4ChfAHcSo5p4Vg=
X-Received: by 2002:a05:6102:12c4:b0:46d:5d1:abc1 with SMTP id
 jd4-20020a05610212c400b0046d05d1abc1mr480506vsb.26.1706868140600; Fri, 02 Feb
 2024 02:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh> <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
 <2024011836-wok-treadmill-c517@gregkh> <d2he3ufg6m46zos4swww4t3peyq55blxhirsx37ou37rwqxmz2@5khumvic62je>
 <CAMRc=MeXJjpJhDjyn_P-SGo4rDnEuT9kGN5jAbRcuM_c7_aDzQ@mail.gmail.com> <oiwvcvu6wdmpvhss3t7uaqkl5q73mki5pz6liuv66bap4dr2mp@jtjjwzlvt6za>
In-Reply-To: <oiwvcvu6wdmpvhss3t7uaqkl5q73mki5pz6liuv66bap4dr2mp@jtjjwzlvt6za>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Feb 2024 11:02:09 +0100
Message-ID: <CAMRc=McT8wt6UbKtyofkJo3WcyJ-S4d2MPp8oZmjWbX6LGbETQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 4/9] PCI: create platform devices for child OF
 nodes of the port node
To: Bjorn Andersson <andersson@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:03=E2=80=AFAM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>

[snip]

> > >
> > > I believe I missed this part of the discussion, why does this need to=
 be
> > > a platform_device? What does the platform_bus bring that can't be
> > > provided by some other bus?
> > >
> >
> > Does it need to be a platform_device? No, of course not. Does it make
> > sense for it to be one? Yes, for two reasons:
> >
> > 1. The ATH11K WLAN module is represented on the device tree like a
> > platform device, we know it's always there and it consumes regulators
> > from another platform device. The fact it uses PCIe doesn't change the
> > fact that it is logically a platform device.
>
> Are you referring to the ath11k SNOC (firmware running on co-processor
> in the SoC) variant?
>
> Afaict the PCIe-attached ath11k is not represented as a platform_device
> in DeviceTree.
>

My bad. In RB5 it isn't (yet - I want to add it in the power
sequencing series). It is in X13s though[1].

> Said platform_device is also not a child under the PCIe bus, so this
> would be a different platform_device...
>

It's the child of the PCIe port node but there's a reason for it to
have the `compatible` property. It's because it's an entity of whose
existence we are aware before the system boots.

> > 2. The platform bus already provides us with the entire infrastructure
> > that we'd now need to duplicate (possibly adding bugs) in order to
> > introduce a "power sequencing bus".
> >
>
> This is a perfectly reasonable desire. Look at our PMICs, they are full
> of platform_devices. But through the years it's been said many times,
> that this is not a valid or good reason for using platform_devices, and
> as a result we have e.g. auxiliary bus.
>

Ok, so I cannot find this information anywhere (nor any example). Do
you happen to know if the auxiliary bus offers any software node
integration so that the `compatible` property from DT can get
seamlessly mapped to auxiliary device IDs?

> Anyway, (please) don't claim that "we need to", when it actually is "we
> want to use platform_device because that's more convenient"!

Bart

[snip]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts#n744

