Return-Path: <linux-pci+bounces-2362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52F832AF3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 15:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5478C1C20E60
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F553E34;
	Fri, 19 Jan 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNRXDiiY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EE53E0E
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673251; cv=none; b=WPxYQXnx8mYQHcaFzbIi3PnpSXw2aTKcr1753ooVAKS2/EL1ttmtns3Ibp9r6C7YO/6ETWdHZCIWU8wHIxI3/Rk+n1AOWJnln6bZj5cN8Ep4OSJDr+dUs2If2Cr33Nm7Y6MbYWTxCFdHeIlRc0ngR/7+4d0fcRo4fYoWoXwgsLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673251; c=relaxed/simple;
	bh=W7VlGr/pUhSjMTOKO8U+EN3WTfaEJ1F6LduBG3wg8zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TApV1XwDgK0hCNNvclrRqxnBqHiL0cIekdud+ri/2Yf8cHuczUlhUk4s/FTLmyrUNlg70VKiGHTdFqNABSmAgk9AYYNGhPGoeRIOqQiKYpYkCbCM7aeyN8lDwgcFLi+pcAMeZVYbY6qj2kL4uq79nYzCKUsNzoz18MrZ0kcV5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNRXDiiY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ebca94cf74so8203627b3.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705673248; x=1706278048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buk4fXAQxtFB8rM3poCtERMP9p3lY+Uw087Jo7Ewjck=;
        b=yNRXDiiYmPZZ2VLPPPbO0bBQZY/xzRQHR7NCHZCUqWX2otdjzm6uum2QVgdjNHQfUX
         lcbaDtEnp+fJiKgaVHaErGSmAu1i4s/Dzbo/v02TsAUG10aovzcggWYpEk1GY+Iiw9Xx
         vAVPey4BzDww/22moIWJcz4nUyHl0ecDGfcHMCm+y8p0IT1j4JLsF8w31PmFMQv9Wd0L
         Dd8Thi28QUe7QRv9du4DOHgHbvcjp6tFjkZxqKbFP4YuOQoD1U5urUVAtuaGeCtHbhiG
         2tSDjfwdC763CpdBz6oh+NiYPbLYiV84ukldIPDcxAn3Nz3JzhUaUhuSX9BgaETd3ITR
         n4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705673248; x=1706278048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buk4fXAQxtFB8rM3poCtERMP9p3lY+Uw087Jo7Ewjck=;
        b=QEvtERZOkC1UEUdoLNvZooa6JNqdTdJfCjpvO4n5kJGAoLxoZP2mGDCdAMqKIMOnh4
         60Dz+/nnS6UpuwayJx4gTikix8Sh4RC7LR3PlqdxVPmL3KrWRe/EhpJHAh7HOixvlp/i
         7NqHq7uu7lwf3WleA+3dPnMP75zNmYY+ZFduhi8A7LLYnl4IcT96Dks30KQpFPSreLaC
         4bO8sE9da6+rzwBzchEK6Ghh6I8Ei1tcBLyJ3WlBLxeR1hrvmxOhbCCB57c3fHDj8r7t
         CMWWycLqMAg7rYPU7KiQ4zR3eC7SG0/aV8qlOUEruZVjZht9c5xmWwWzgFNWFAz4rHPd
         UH1g==
X-Gm-Message-State: AOJu0Ywpcr2JSQUQWRwJZC9cGeIOHTYlQawz97LOsZ3WzXR9yEqP563i
	huyws4wQCQUYoO77PDHgzK3yCWKVy57uD0IWpg2imPboHcphXJJpsUjzbwKqQG8YRoprWLYYUiQ
	XL/rAZsPvVzahG8FqnI3mtAOj5kjBj/DQMNjOPg==
X-Google-Smtp-Source: AGHT+IFmqIskvUyQCVk6zycWvl/Efv5A6xlnyIt0UcdF3dtHDc9MLGxqVG3NGXwYjxwTWdhnQVEuXgXU9ayI9wSQK+Q=
X-Received: by 2002:a0d:c201:0:b0:5ff:6173:e98e with SMTP id
 e1-20020a0dc201000000b005ff6173e98emr2257479ywd.63.1705673248180; Fri, 19 Jan
 2024 06:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
 <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com>
 <CAMRc=McUZh0jhjMW7H6aVKbw29WMCQ3wdkVAz=yOZVK5wc45OA@mail.gmail.com>
 <CAA8EJprFV6SS_dGF8tOHcBG+y8j74vO0B40Y=e7Kj1-ZThNqPA@mail.gmail.com> <CAMRc=MdOALzkDtpnbqF16suShvP5apGYy4LTQ4dTc3r9Rbb1kg@mail.gmail.com>
In-Reply-To: <CAMRc=MdOALzkDtpnbqF16suShvP5apGYy4LTQ4dTc3r9Rbb1kg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Jan 2024 16:07:17 +0200
Message-ID: <CAA8EJpr=PMdOWzp8fahL9e9QC-qgS=hSaTqT1XdUs8Dvvsxqgg@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
To: brgl@bgdev.pl
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

On Fri, 19 Jan 2024 at 15:35, <brgl@bgdev.pl> wrote:
>
> On Fri, 19 Jan 2024 13:31:53 +0100, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> said:
> > On Fri, 19 Jan 2024 at 13:52, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >>
> >> On Thu, Jan 18, 2024 at 7:53=E2=80=AFPM Dmitry Baryshkov
> >> <dmitry.baryshkov@linaro.org> wrote:
> >> >
> >>
> >> [snip]
> >>
> >> > >
> >> > > I'd still like to see how this can be extended to handle BT power =
up,
> >> > > having a single entity driving both of the BT and WiFI.
> >> > >
> >> > > The device tree changes behave in exactly the opposite way: they
> >> > > define regulators for the WiFi device, while the WiFi is not being
> >> > > powered by these regulators. Both WiFi and BT are powered by the P=
MU,
> >> > > which in turn consumes all specified regulators.
> >> >
> >> > Some additional justification, why I think that this should be
> >> > modelled as a single instance instead of two different items.
> >> >
> >> > This is from msm-5.10 kernel:
> >> >
> >> >
> >> > =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
> >> > /**
> >> >  * cnss_select_pinctrl_enable - select WLAN_GPIO for Active pinctrl =
status
> >> >  * @plat_priv: Platform private data structure pointer
> >> >  *
> >> >  * For QCA6490, PMU requires minimum 100ms delay between BT_EN_GPIO =
off and
> >> >  * WLAN_EN_GPIO on. This is done to avoid power up issues.
> >> >  *
> >> >  * Return: Status of pinctrl select operation. 0 - Success.
> >> >  */
> >> > static int cnss_select_pinctrl_enable(struct cnss_plat_data *plat_pr=
iv)
> >> > =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
> >> >
> >> >
> >> > Also see the bt_configure_gpios() function in the same kernel.
> >> >
> >>
> >> You are talking about a different problem. Unfortunately we're using
> >> similar naming here but I don't have a better alternative in mind.
> >>
> >> We have two separate issues: one is powering-up a PCI device so that
> >> it can be detected and the second is dealing with a device that has
> >> multiple modules in it which share a power sequence. The two are
> >> independent and this series isn't trying to solve the latter.
> >
> > I see it from a different angle: a power up of the WiFi+BT chips. This
> > includes devices like wcn3990 (which have platform + serial parts) and
> > qca6390 / qca6490 / wcn6750 / etc. (which have PCI and serial parts).
> >
> > From my point of view, the PCIe-only part was nice for an RFC, but for
> > v1 I have expected to see a final solution that we can reuse for
> > wcn3990.
> >
>
> The submodules are represented as independent devices on the DT and I don=
't
> think this will change. It's not even possible as they operate on differe=
nt
> buses so it's not like we can MFD it with a top-level platform device and=
 two
> sub-nodes of which one is PCI and another serdev. With that in mind, I'm
> insisting that there are two separate issues and a generic power sequenci=
ng
> can be built on top of the PCI-specific pwrseq added here.
>
> >>
> >> But I am aware of this and so I actually have an idea for a
> >> generalized power sequencing framework. Let's call it pwrseq as
> >> opposed to pci_pwrseq.
> >>
> >> Krzysztof is telling me that there cannot be any power sequencing
> >> information contained in DT. Also: modelling the PMU in DT would just
> >> over complicate stuff for now reason. We'd end up having the PMU node
> >> consuming the regulators but it too would need to expose regulators
> >> for WLAN and BT or be otherwise referenced by their nodes.
> >
> > Yes. And it is a correct representation of the device. The WiFi and BT
> > parts are powered up by the outputs from PMU. We happen to have three
> > different pieces (WiFi, BT and PMU) squashed on a single physical
> > device.
> >
>
> Alright, so let's imagine we do model the PMU on the device tree. It woul=
d
> look something like this:
>
> qca6390_pmu: pmic@0 {
>         compatible =3D "qcom,qca6390-pmu";
>
>         bt-gpios =3D <...>;
>         wlan-gpios =3D <...>;
>
>         vdd-supply =3D <&vreg...>;
>         ...
>
>         regulators-0 {
>                 vreg_x: foo {
>                         ...
>                 };
>
>                 ...
>         };
> };
>
> Then the WLAN and BT consume the regulators from &qca6390_pmu. Obviously =
we
> cannot go:
>
> wlan {
>         pwrseq =3D &qca6390_pmu;
> };
>
> But it's enough to:
>
> wlan {
>         vdd-supply =3D <&vreg_x>;
> };

I'm not sure this will fly. This means expecting that regulator
framework is reentrant, which I think is not the case.

> But the pwrseq driver for "qcom,qca6390-pmu" could map BT and WLAN compat=
ibles
> to the correct power sequence and then the relevant drivers could enable =
it
> using pwrseq_power_on().
>
> But that comes back to what I'm doing here: the PCI part for ath11k still
> needs the platform driver that will trigger the power sequence and that c=
ould
> be the PCI pwrseq driver for which the framework is introduced in this se=
ries.
>
> As I said: the two are largely orthogonal.

I'm fine with that as long as it stays as an RFC. We need to fix both
issues before committing qca6390 power up support.

>
> >>
> >> So I'm thinking that the DT representation should remain as it is:
> >> with separate WLAN and BT nodes consuming resources relevant to their
> >> functionality (BT does not need to enable PCIe regulators).
> >
> > Is it so? The QCA6390 docs clearly say that all regulators should be
> > enabled before asserting BT_EN / WLAN_EN. See the powerup timing
> > diagram and the t2 note to that diagram.
> >
>
> Fair enough.
>
> >> Now how to
> >> handle the QCA6490 model you brought up? How about pwrseq drivers that
> >> would handle the sequence based on compatibles?
> >
> > The QCA6490 is also known as WCN6855. So this problem applies to
> > Qualcomm sm8350 / sm8450 platforms.
> >
> > And strictly speaking I don't see any significant difference between
> > QCA6390 and WCN6855. The regulators might be different, but the
> > implementation should be the same.
> >
> >>
> >> We'd add a new subsystem at drivers/pwrseq/. Inside there would be:
> >> drivers/pwrseq/pwrseq-qca6490.c. The pwrseq framework would expose an
> >> API to "sub-drivers" (in this case: BT serdev driver and the qca6490
> >> power sequencing driver). Now the latter goes:
> >>
> >> struct pwrseq_desc *pwrseq =3D pwrseq_get(dev);
> >>
> >> And the pwrseq subsystem matches the device's compatible against the
> >> correct, *shared* sequence. The BT driver can do the same at any time.
> >> The pwrseq driver then gets regulators, GPIOs, clocks etc. and will be
> >> responsible for dealing with them.
> >>
> >> In sub-drivers we now do:
> >>
> >> ret =3D pwrseq_power_on(pwrseq);
> >>
> >> or
> >>
> >> ret =3D pwrseq_power_off(pwrseq);
> >>
> >> in the sub-device drivers and no longer interact with each regulator
> >> on our own. The pwrseq subsystem is now in charge of adding delays
> >> etc.
> >>
> >> That's only an idea and I haven't done any real work yet but I'm
> >> throwing it out there for discussion.
> >
> > I've been there and I had implemented it in the same way, but rather
> > having the pwrseq as a primary device in DT and parsing end-devices
> > only as a fallback / compatibility case.
> >
>
> Would you mind posting an example DT code here? I'm not sure if I underst=
and
> what "primary device" means in this context.

 qca_pwrseq: qca-pwrseq {
  compatible =3D "qcom,qca6390-pwrseq";

  #pwrseq-cells =3D <1>;

  vddaon-supply =3D <&vreg_s6a_0p95>;
  vddpmu-supply =3D <&vreg_s2f_0p95>;
  vddrfa1-supply =3D <&vreg_s2f_0p95>;
  vddrfa2-supply =3D <&vreg_s8c_1p3>;
  vddrfa3-supply =3D <&vreg_s5a_1p9>;
  vddpcie1-supply =3D <&vreg_s8c_1p3>;
  vddpcie2-supply =3D <&vreg_s5a_1p9>;
  vddio-supply =3D <&vreg_s4a_1p8>;

  bt-enable-gpios =3D <&tlmm 21 GPIO_ACTIVE_HIGH>;
  wifi-enable-gpios =3D <&tlmm 20 GPIO_ACTIVE_HIGH>;
  swctrl-gpios =3D <&tlmm 124 GPIO_ACTIVE_HIGH>;
 };

&uart6 {
 status =3D "okay";
 bluetooth {
  compatible =3D "qcom,qca6390-bt";
  clocks =3D <&sleep_clk>;

  bt-pwrseq =3D <&qca_pwrseq 1>;
 };
};

See https://lore.kernel.org/linux-arm-msm/20211006035407.1147909-13-dmitry.=
baryshkov@linaro.org/

--=20
With best wishes
Dmitry

