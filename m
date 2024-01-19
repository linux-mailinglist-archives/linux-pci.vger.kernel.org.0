Return-Path: <linux-pci+bounces-2348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAC83293A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 12:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61AD5B23386
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBABC4F1E0;
	Fri, 19 Jan 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="afNvk1oU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCD4C3D0
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665134; cv=none; b=rK2fdgBALvbK8mscR68HsH+sLBLODwUqQ6mroeSZPMvGz7zffqEql/3N92a8QdFw8YwZVqmV4bjSWbG86+BntMVaQoDRSGV1FWbujMW1NODH2+jJ1vUzfTcyumnRF3f/pWB1SZwdTeiFDaFwe7Oob+2S47tfL4hSGfudQWTxfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665134; c=relaxed/simple;
	bh=L/Fc06LLs/rGZJoI3sRZIJrlufKv5PaKYitAV+6n9QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhciuOKORMPC9lvwUaxBEWX5dPx0Mu1r2RJHLSMDWARMgHpB3HqnlZKv71KFDycEcWA92ImBfphHrgOyoXAcofDc1CZYV+Ltf/7Vegxg+Kg3s3WFTNfsJnjMSTH9OqDcfyCXzIbSF7iurTG1SlcPnIc40DeHzMun7dNjvRu5mn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=afNvk1oU; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7cecc0a662dso230977241.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705665132; x=1706269932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scQQNQ5xR79QdIxgg95WyhVE0qz02vfpeEac+jED8n0=;
        b=afNvk1oUnQ19qYmNfiBN0essEgUXat59gy72RjkVeS20wdU1gBqWOrEffQNMb2kswW
         cMwBoAps3H3BLxBX0r/zfrw6sdlVAkn1ps6YTUpz0hP4VVfXJUyc5mahKpA1BRm9nYyY
         7Mx9Rhe/cxicQ4YsF6KI10G1Ezcd+EajAHZBEa/ufPqgbqz/xv1lv4PNdVghiGkjHupm
         aoIPlV3td+icGePMWUtXF4dj+UjP1icTn+1amOYEfjuDWqaa4vu9yTOTzmsa7AtG5mQ2
         9oKvl2+QmQzD6rY0a5ZrU3wmVz/D4Ulctb07VURqpvZZRHr8Lhm3WWEmyS//g9PjQ1CH
         1JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705665132; x=1706269932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scQQNQ5xR79QdIxgg95WyhVE0qz02vfpeEac+jED8n0=;
        b=W5mySWVyiXpAADZrulZu/H7vyf1WpJiwK00CJJ0Z9oo8/IYweSsE+kdRrxAcTcE3RD
         C3xaNo6MKa7vPt+EbWZSTA9h2JdvbsNoQkD4djs65rwxVW0y3kZuzGpWCKUVoV0hmk5X
         pE1eu80Pag21BUmcjjzzz6B2WfxYqxK7WkzkxXsH7ciWhSg09h9X57yakavGcPaOwIFf
         Q2H8Y/3NmBgdj2tBMR0gFCG6OErF21ttWR5QUvOYfUW5LrPJIqQOdywL7pOxy2Rim2mo
         DQqaotcU2fq6E2BwNYnVta6Grhg7TLCG4eQtFEw4E1Q5f7D4OhXpxkzdO6k1pyHk1aWK
         YlGQ==
X-Gm-Message-State: AOJu0Yy8IFv45KeBGPBZDJQlZjgAT8BGhWlRCuZxgtDgdZharFgO4trS
	BDb/NN/VC4tjB33p6kx9DqVSrlvyv36A7G61v9QMrCzZfC3e6ZYaFr+IWi9O5Qf8szgIJkjwdjA
	NgK3MD5KS2JJt1+Anzbh4MjGC0+EopGye1pe+EA==
X-Google-Smtp-Source: AGHT+IFiXIk+YOAa2fYWVkFEFaJXqh/QhAez3rJdhcrCmsvPK+NsvJEO/O+MaokryJjfgFi1QEfe5UKWEheWp/KRPaY=
X-Received: by 2002:a67:f945:0:b0:468:90e:2c8e with SMTP id
 u5-20020a67f945000000b00468090e2c8emr1903776vsq.35.1705665132098; Fri, 19 Jan
 2024 03:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
 <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com>
In-Reply-To: <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 19 Jan 2024 12:52:00 +0100
Message-ID: <CAMRc=McUZh0jhjMW7H6aVKbw29WMCQ3wdkVAz=yOZVK5wc45OA@mail.gmail.com>
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

On Thu, Jan 18, 2024 at 7:53=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>

[snip]

> >
> > I'd still like to see how this can be extended to handle BT power up,
> > having a single entity driving both of the BT and WiFI.
> >
> > The device tree changes behave in exactly the opposite way: they
> > define regulators for the WiFi device, while the WiFi is not being
> > powered by these regulators. Both WiFi and BT are powered by the PMU,
> > which in turn consumes all specified regulators.
>
> Some additional justification, why I think that this should be
> modelled as a single instance instead of two different items.
>
> This is from msm-5.10 kernel:
>
>
> =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
> /**
>  * cnss_select_pinctrl_enable - select WLAN_GPIO for Active pinctrl statu=
s
>  * @plat_priv: Platform private data structure pointer
>  *
>  * For QCA6490, PMU requires minimum 100ms delay between BT_EN_GPIO off a=
nd
>  * WLAN_EN_GPIO on. This is done to avoid power up issues.
>  *
>  * Return: Status of pinctrl select operation. 0 - Success.
>  */
> static int cnss_select_pinctrl_enable(struct cnss_plat_data *plat_priv)
> =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
>
>
> Also see the bt_configure_gpios() function in the same kernel.
>

You are talking about a different problem. Unfortunately we're using
similar naming here but I don't have a better alternative in mind.

We have two separate issues: one is powering-up a PCI device so that
it can be detected and the second is dealing with a device that has
multiple modules in it which share a power sequence. The two are
independent and this series isn't trying to solve the latter.

But I am aware of this and so I actually have an idea for a
generalized power sequencing framework. Let's call it pwrseq as
opposed to pci_pwrseq.

Krzysztof is telling me that there cannot be any power sequencing
information contained in DT. Also: modelling the PMU in DT would just
over complicate stuff for now reason. We'd end up having the PMU node
consuming the regulators but it too would need to expose regulators
for WLAN and BT or be otherwise referenced by their nodes.

So I'm thinking that the DT representation should remain as it is:
with separate WLAN and BT nodes consuming resources relevant to their
functionality (BT does not need to enable PCIe regulators). Now how to
handle the QCA6490 model you brought up? How about pwrseq drivers that
would handle the sequence based on compatibles?

We'd add a new subsystem at drivers/pwrseq/. Inside there would be:
drivers/pwrseq/pwrseq-qca6490.c. The pwrseq framework would expose an
API to "sub-drivers" (in this case: BT serdev driver and the qca6490
power sequencing driver). Now the latter goes:

struct pwrseq_desc *pwrseq =3D pwrseq_get(dev);

And the pwrseq subsystem matches the device's compatible against the
correct, *shared* sequence. The BT driver can do the same at any time.
The pwrseq driver then gets regulators, GPIOs, clocks etc. and will be
responsible for dealing with them.

In sub-drivers we now do:

ret =3D pwrseq_power_on(pwrseq);

or

ret =3D pwrseq_power_off(pwrseq);

in the sub-device drivers and no longer interact with each regulator
on our own. The pwrseq subsystem is now in charge of adding delays
etc.

That's only an idea and I haven't done any real work yet but I'm
throwing it out there for discussion.

Bartosz

[snip]

