Return-Path: <linux-pci+bounces-3018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B384710D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3B01F2A87D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6320646544;
	Fri,  2 Feb 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a7fClUo5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50BA46430
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880244; cv=none; b=AYE96x8BndKNJJCUy8UcJfZZNrM75NoLcMWe8nQTniy8i3+nds6Aq6K11SS0AUSh2sigRHkkJ2RQKrFuq6KWRX5SxY6y99G09I886CsohyMYaofzfi3eq1Xtl45H5hRM43Ow/GrvSQ6LkNHab6luc4myRJ9/HaPQEAe47Pj55V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880244; c=relaxed/simple;
	bh=UAaor+OvHRxZyb19OeeiMq5YPyGKff5Y3t7zNK5hQio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR6ShGBNncISuWsQAv4vy0DpKUW2NRrbaD+lnzl0q7hUSvZmcdF/GSnKHNUqytF42QhzEu/6u2HFbrTuA3tJ2CfS1LenfxxANC24BZMWNJxgakA+ePMBmBLb8CZ3faOYy9gCu4fI3ep22gBNW30NyGHLUnAXJeuiOd2uzF1GGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a7fClUo5; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so1038166241.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 05:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706880240; x=1707485040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz8xZTKk1yx3xYmAtNA8p+sXodOnGKPr8O/375rWSU4=;
        b=a7fClUo59NJhPA1ErWnmZbE5HKGKf57H4BEv1vLgB2psSSIcIWWk3I1iXkcfktbUJZ
         62hvTvJoBSPygBbjVX1KQWQUqGJorUBVr1PU9yxWqBXKxeWqjng+RtSXcGiB9JixOJ+3
         A1FBrkxZDkyxLxvwphZJXDPlsxXT1/8OwxUp0tMnzE0/zZr7xjtbqqP5e+XYFgbNqHtf
         XyJ97MBpySHM3fhyy+AQzkxDR8mBlC+OmjCWYj6KNZ+g6lDoI6eAakzYTEtesrUvU5aB
         HXDoJllnInkzI37vPC1tesNuCBReeE+m9Miw/t/31oDWKk1YHRGz9xSo9Tr171Rsfihe
         8p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706880240; x=1707485040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz8xZTKk1yx3xYmAtNA8p+sXodOnGKPr8O/375rWSU4=;
        b=P56Kr5iG1Qro6TTCBkh1Z2EvgN6nSIjVz5wQy9YagvsYI6I6YpM7Y94OexCWzCHCez
         mCFt/1+/biDcDTnxTblVdXVbBJart2Y4O952o/cIjHq8RL8+DlHRx0Pdaegc0KPLMajs
         R2nEmWDYAvhLZVsChRfV7WupqwR2Pf2kIUMvCY+xPad3drBpZieH+3CkkeaibGT2uWFF
         xlSPplah00+kyV3FEZHyFoBY6aeD4IJH9is2SBX2txtV+Qqde4K4ObGy1Qlil5NqAFi7
         H9WLUHfChdP5LjDPIZpVPZV/DEVqQkPbeR2eTSp8iZXDjR8j1arabIyTnT0NPrJ1++vs
         k/iA==
X-Gm-Message-State: AOJu0YxfvUcNoRt/8cqB41yXR8L09RnaoIIb+X+EQ8+vOydJ30yFOn8z
	ZR/9uRKEWxnwI7+AAtYHHLO/CISbtD2DuatefNJEjc2pEB4dEonwdLcdaDisZJ6AwfVQVzm/ySP
	UBTqD5ZySqdSy4oQT/ViqWPEbS76D7H/uJ3Qd7A==
X-Google-Smtp-Source: AGHT+IFW4i4ANf20+Aj8hI0qnUo70/DfClBMexuJC+KQ5QvWnmdXsoNCitjgC49/m3KRH0I430Kb7cSQQ8+F2edsC+A=
X-Received: by 2002:a05:6102:3e1f:b0:46c:f805:eb7e with SMTP id
 j31-20020a0561023e1f00b0046cf805eb7emr5536531vsv.28.1706880240522; Fri, 02
 Feb 2024 05:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-3-brgl@bgdev.pl>
 <5lirm5mnf7yqbripue5nyqu6ej54sx4rtmgmyqjrqanabsriyp@2pjiv5xbmxpk>
In-Reply-To: <5lirm5mnf7yqbripue5nyqu6ej54sx4rtmgmyqjrqanabsriyp@2pjiv5xbmxpk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Feb 2024 14:23:49 +0100
Message-ID: <CAMRc=Mcq8a7T06DaX9nirfHOXPs+Bh51rKgO3FksxKH+Hph2FA@mail.gmail.com>
Subject: Re: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:34=E2=80=AFAM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>

[snip]

> > +
> > +             wlan-enable-gpios =3D <&tlmm 20 GPIO_ACTIVE_HIGH>;
> > +             bt-enable-gpios =3D <&tlmm 21 GPIO_ACTIVE_HIGH>;
> > +
> > +             regulators {
> > +                     vreg_pmu_rfa_cmn: ldo0 {
> > +                             regulator-name =3D "vreg_pmu_rfa_cmn";
> > +                             regulator-min-microvolt =3D <760000>;
> > +                             regulator-max-microvolt =3D <840000>;
>
> I'm still not convinced that the PMU has a set of LDOs, and looking at
> your implementation you neither register these with the regulator
> framework, nor provide any means of controlling the state or voltage of
> these "regulators".
>

Why are you so fixated on the driver implementation matching the
device-tree 1:1? I asked that question before - what does it matter if
we use the regulator subsystem or not? This is just what HW there is.
What we do with that knowledge in C is irrelevant. Yes, I don't use
the regulator subsystem because it's unnecessary and would actually
get in the way of the power sequencing. But it doesn't change the fact
that the regulators *are* there so let's show them.

What isn't there is a "power sequencer device". This was the main
concern about Dmitry's implementation before. We must not have
"bt-pwrseq =3D <&...>;" -like properties in device-tree because there is
no device that this would represent. But there *are* LDO outputs of
the PMU which can be modelled and then used in C to retrieve the power
sequencer and this is what I'm proposing.

Bartosz

> [..]
> >
> >  &uart6 {
> > @@ -1311,17 +1418,16 @@ &uart6 {
> >       bluetooth {
> >               compatible =3D "qcom,qca6390-bt";
> >
> > -             pinctrl-names =3D "default";
> > -             pinctrl-0 =3D <&bt_en_state>;
> > -
> > -             enable-gpios =3D <&tlmm 21 GPIO_ACTIVE_HIGH>;
> > -
> > -             vddio-supply =3D <&vreg_s4a_1p8>;
> > -             vddpmu-supply =3D <&vreg_s2f_0p95>;
> > -             vddaon-supply =3D <&vreg_s6a_0p95>;
> > -             vddrfa0p9-supply =3D <&vreg_s2f_0p95>;
> > -             vddrfa1p3-supply =3D <&vreg_s8c_1p3>;
> > -             vddrfa1p9-supply =3D <&vreg_s5a_1p9>;
> > +             vddrfacmn-supply =3D <&vreg_pmu_rfa_cmn>;
> > +             vddaon-supply =3D <&vreg_pmu_aon_0p59>;
> > +             vddwlcx-supply =3D <&vreg_pmu_wlcx_0p8>;
> > +             vddwlmx-supply =3D <&vreg_pmu_wlmx_0p85>;
> > +             vddbtcmx-supply =3D <&vreg_pmu_btcmx_0p85>;
> > +             vddrfa0-supply =3D <&vreg_pmu_rfa_0p8>;
> > +             vddrfa1-supply =3D <&vreg_pmu_rfa_1p2>;
> > +             vddrfa2-supply =3D <&vreg_pmu_rfa_1p7>;
> > +             vddpcie0-supply =3D <&vreg_pmu_pcie_0p9>;
> > +             vddpcie1-supply =3D <&vreg_pmu_pcie_1p8>;
>
> As I asked before, why does bluetooth suddenly care about PCIe supplies?
>

Yes, I forgot to remove it, I'll do it next time.

Bartosz

[snip]

