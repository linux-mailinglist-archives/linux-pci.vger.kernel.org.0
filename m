Return-Path: <linux-pci+bounces-2364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2489832B96
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 15:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F371C23436
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7C53E25;
	Fri, 19 Jan 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kjAr4a+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DA537ED
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675717; cv=none; b=Z+FoK1f+4UvTVMgTK8WdDyp2E24VcqtzBhXV0r39haXA6+GaTwNze+a1PdL7dK1tUp2PO1i9XCkjYy4cSd8TW/SnGKMGmcV9fmc2qY13oJYK+lNKrUdY11llAndwA/hwV7qFyvmscureK7KjfpYAKytkmjcTP6h2Ixv/cIyDr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675717; c=relaxed/simple;
	bh=mcasdrK9tsgv64zuh5ad3tAh8I6lDw0EnAs5pD7vPtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bd4EkYTOjidt9jkIvkbqK1epoimmDSDiJN7S5DKqMOKNGGM7JDZGZSYDkdPyoLug0JxgwwoPDmcbyh8WXUrPhnoPhggIVvDk2IjTbfnRDuG4IU0bjAOgFX0zy2H1aIS5Lk3Oso7Ce1UWM2+BH8UXnMrmlHG/O+0BAtDyj083lgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kjAr4a+T; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b739b29686so564971e0c.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705675715; x=1706280515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT8Ncx8OtnbiClPBAKlN7utHv1YM0P6Lld/QOdOjhZo=;
        b=kjAr4a+TNkom7z+wvvf0AkTXKB7onWYxHdsOZbEJuRxnkXa0xOsctLFm05bXl3y+YK
         me6k+7D1rrRmJeI1T98Wc+4FjHnvGceH9MxagV/FgnZLGZkmHxB2iaoNxnrsUBuR5ZJU
         BU8sEcAChS7aefUKBn5cQlAafaX+ryiq3go+SWesG7B2DD9Ggaxcl8s3Zezy/WpU1tjq
         p9Qzh66zjzb4HJMrPBL3jZbWnO/u8U4GD/qymIJo9cal6ikESZqgS0vpc/Oh2/8UD6AL
         s3NIlj8oEw9mR8LAFSBHvjg/N1dscISyt1heEESpsL084F0i/1Jl+EUbA1EhAF1Aq1b3
         jJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705675715; x=1706280515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT8Ncx8OtnbiClPBAKlN7utHv1YM0P6Lld/QOdOjhZo=;
        b=I+gop282a2A6M0kaMzRRkAdHpo7g+1yb5rOxDuiy6B/gb8YrgEIgQL0TEtPpFnV3fY
         ZC4VfZeog8SGUVdcCy++NlBy2bKTNWolfkp+19jIFfKJuzsP3XZf22juissjYA542HRW
         Xw5JNPAWhIFYfkPsd5YfLgAqnO1/elqir/az7EO8u+mThnBfC1uYEcT1lF83yT8vAB7w
         ikJiYltZENcu1KagLZ1xmtnIA1JT0PTjoPNLD9JZHFIoIflhQ85M7cDQvjqiYzkyWZGZ
         OYBORKjnlF8Tj8Q2qqhQY+YZAq5fLSjjh0hdRW8Ozx2NiGIl5SMSgNyNRM+NC3DNAEcp
         Akjg==
X-Gm-Message-State: AOJu0YyN9iaibZVpzXw+x0pMt/HYdubn0XM2gwW+XWT46zG+ju4p8EUk
	tFs4e3EzarMvCDu0GgiD7KnN3U/AOix6hpLEGG4X/AErk5be1Spt20n0CPJV/drSbc/rPBXZTvT
	l+8v70wkTBhcm3c+EEI18bewPUi2uXt3IlmVDnw==
X-Google-Smtp-Source: AGHT+IH148GvFKhyvnpCBTcw5sd5a4Uf8p3RqnETOxUeuPL4kpb132tH+JeiNaZaa8YtTlrHdfJUvfTNHdTZygq7GEk=
X-Received: by 2002:a05:6122:2224:b0:4bb:3b8:afbd with SMTP id
 bb36-20020a056122222400b004bb03b8afbdmr5000vkb.0.1705675715289; Fri, 19 Jan
 2024 06:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
 <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com>
 <CAMRc=McUZh0jhjMW7H6aVKbw29WMCQ3wdkVAz=yOZVK5wc45OA@mail.gmail.com>
 <CAA8EJprFV6SS_dGF8tOHcBG+y8j74vO0B40Y=e7Kj1-ZThNqPA@mail.gmail.com>
 <CAMRc=MdOALzkDtpnbqF16suShvP5apGYy4LTQ4dTc3r9Rbb1kg@mail.gmail.com>
 <CAA8EJpr=PMdOWzp8fahL9e9QC-qgS=hSaTqT1XdUs8Dvvsxqgg@mail.gmail.com> <CAMRc=McdXC8zP4_+a3hBijVLXmLFakfjdXjzPOwaNsPCwPT36w@mail.gmail.com>
In-Reply-To: <CAMRc=McdXC8zP4_+a3hBijVLXmLFakfjdXjzPOwaNsPCwPT36w@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 19 Jan 2024 15:48:24 +0100
Message-ID: <CAMRc=Mfi=R9ogkdiKGuCO_rf__shA7B7VOpLxAHEFzL5Y-N_KQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Fri, Jan 19, 2024 at 3:07=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
>
> [snip]
>
> > > >
> > >
> > > Alright, so let's imagine we do model the PMU on the device tree. It =
would
> > > look something like this:
> > >
> > > qca6390_pmu: pmic@0 {
> > >         compatible =3D "qcom,qca6390-pmu";
> > >
> > >         bt-gpios =3D <...>;
> > >         wlan-gpios =3D <...>;
> > >
> > >         vdd-supply =3D <&vreg...>;
> > >         ...
> > >
> > >         regulators-0 {
> > >                 vreg_x: foo {
> > >                         ...
> > >                 };
> > >
> > >                 ...
> > >         };
> > > };
> > >
> > > Then the WLAN and BT consume the regulators from &qca6390_pmu. Obviou=
sly we
> > > cannot go:
> > >
> > > wlan {
> > >         pwrseq =3D &qca6390_pmu;
> > > };
> > >
> > > But it's enough to:
> > >
> > > wlan {
> > >         vdd-supply =3D <&vreg_x>;
> > > };
> >
> > I'm not sure this will fly. This means expecting that regulator
> > framework is reentrant, which I think is not the case.
> >
>
> Oh maybe I didn't make myself clear. That's the DT representation of
> HW. With pwrseq, the BT or ATH11K drivers wouldn't use the regulator
> framework. They would use the pwrseq framework and it could use the
> phandle of the regulator to get into the correct pwrseq device without
> making Rob and Krzysztof angry.
>
> Bart
>
> [snip]

I'm working on a PoC of the generic pwrseq framework but without the
explicit pwrseq modelling in DT. Should have an RFC ready early next
week.

Bart

