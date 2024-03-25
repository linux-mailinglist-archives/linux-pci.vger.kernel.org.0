Return-Path: <linux-pci+bounces-5122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E685388ABA9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04342E371B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1AC12C535;
	Mon, 25 Mar 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bNg693gY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012CE7F7C1
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383829; cv=none; b=WQn5M9aR177lb/bfiBXJYWy/VqZycglAz0wOeb3WH//xFGhmbeRp9sK+VabJh5TUmerRrorHwXjtUcts9Or4n0IbDivDu04FXdpqsiTsAaXebQ9He2DCJxXyhB9STeoV/V1mthArne3rNfejP8CvPZ2u+jreKo/yUbVYnuBSbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383829; c=relaxed/simple;
	bh=YFrRYJmE2c0Njd/WjfccaQYzVP23csJig+MqZX6xV88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4XKfqpuqfruf/RLBzP/53A+kejd0dJybVxXEhcJIzvd7fywJU+xxulSHD6tVUCqXKf5jv8qlOQ06W9V6jf3ET5dR3d7/JeE9pSjRjzZyCk7sGdvyqox7zHn6uTDZHlJ0w1i763Zmcd3o9/mxmhbL6QeOGzHD8bPo/uUR/TZXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bNg693gY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d49f7e5c2cso61392471fa.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711383826; x=1711988626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFcfwD2v6qpH4vAhBOADFCJxvrI715+cznBhJwreFCA=;
        b=bNg693gYe+XqMbXPLwytAj1DW4TWOdFgIkYynhGZ5jLpywIn73CoqucTs3oAz8BXmi
         k/Ivm6vwfw2fk13UUlQTvpD+XOJqmL2smuv253/e4EYqGUVC/F5E55gbZGVSFIV6c4T+
         IVRcHRt10DBkqxd5bu307cFUdzzSJqs/CYXplnrB6BT3w61HjpmbKzV8QK9aDcLsxUpA
         tSUOE5VIYP4vR+gbt0xhK1NDwyiYNMC2LIPd8ySb9bAaD2IfUqEJAYyc9Nmbc5bbHsfZ
         nR/Q3Rp3A50GLOyCF5d4juoXyxED0bdEXlmhBJf0CX1jnARlkRekA2F/tTDZ8zCtahKJ
         urXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383826; x=1711988626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFcfwD2v6qpH4vAhBOADFCJxvrI715+cznBhJwreFCA=;
        b=Sb6XRk1BSNbxN1lLcx+B1LCQdPBYtpf/rcjPMjlB8AgyPY0VKiF58Zmrx7lAFuA86I
         Na7YJQWVV84qGn21hE+fBVYFDSz5oxatq5Bz0iox6NQo6Gk+MNtXSrltI2ermxEUaCcM
         4tVO/rdYS0bvpQJW0H0XuyckOTlvHOhWOhE0jsT2llIaboYFH5w6fkhbO0uSWa0cQdC2
         Towx6NM+oHnD35yYLtK7leDMxv1gvfA9GXGgaf79G3jAIs7WeCDtUTn8ZU66+4aeyBbh
         lVMIwYzok3V6BpopYsY2bL9oK1/x8aNWEzcT9bEnbTCVAaixtn05uuTU6xELI++AIhRi
         w8ug==
X-Forwarded-Encrypted: i=1; AJvYcCX2lgnWvHwmTkUZnoYTNInZ9RalKtjxWrMDkKrN/G/Ve9P/WE+22FZoxzlAsFHl76OZQRP1gU5B9mMDO06Wh3AHvplxT45b80pM
X-Gm-Message-State: AOJu0Ywo3nOhLEFwl9j0C0dDosU9/oGTopHCBDIiUgBlhk8iR0yWuRy3
	NHgDAa5DUwZESVPZIxaoEhXA1yyIhYAG1FKp1WDUs4GoH6inBDLq2EnJvA34fmNkteIRdIAc8BR
	Pw2ZmGS6xj+xH5fDvf6MaupvrVMfgd+GDtZeb6Q==
X-Google-Smtp-Source: AGHT+IH4j5PPquST9xGKo8St/ikKbO6tk+Yedi+DAtFkCTZT5UC4mlTlEQkIXAn9mq4Oivrt7Ob9WJnK0Bj5SKvyufE=
X-Received: by 2002:a2e:8085:0:b0:2d4:ffe:c55e with SMTP id
 i5-20020a2e8085000000b002d40ffec55emr4716403ljg.25.1711383826136; Mon, 25 Mar
 2024 09:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <20240325131624.26023-5-brgl@bgdev.pl>
 <87r0fy8lde.fsf@kernel.org> <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
 <87frwe8jiu.fsf@kernel.org>
In-Reply-To: <87frwe8jiu.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 17:23:35 +0100
Message-ID: <CAMRc=MdCv+vTMZML-wzRQqZZavquV3DABYM4KYw-HwqS47sTyw@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, ath11k@lists.infradead.org, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:37=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > On Mon, Mar 25, 2024 at 2:57=E2=80=AFPM Kalle Valo <kvalo@kernel.org> w=
rote:
> >
> >>
> >> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> >>
> >> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> >
> >> > Add a PCI compatible for the ATH11K module on QCA6390 and describe t=
he
> >> > power inputs from the PMU that it consumes.
> >> >
> >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> [...]
> >>
> >> > +allOf:
> >> > +  - if:
> >> > +      properties:
> >> > +        compatible:
> >> > +          contains:
> >> > +            const: pci17cb,1101
> >> > +    then:
> >> > +      required:
> >> > +        - vddrfacmn-supply
> >> > +        - vddaon-supply
> >> > +        - vddwlcx-supply
> >> > +        - vddwlmx-supply
> >> > +        - vddrfa0p8-supply
> >> > +        - vddrfa1p2-supply
> >> > +        - vddrfa1p7-supply
> >> > +        - vddpcie0p9-supply
> >> > +        - vddpcie1p8-supply
> >>
> >> I don't know DT well enough to know what the "required:" above means,
> >> but does this take into account that there are normal "plug&play" type
> >> of QCA6390 boards as well which don't need any DT settings?
> >
> > Do they require a DT node though for some reason?
>
> You can attach the device to any PCI slot, connect the WLAN antenna and
> it just works without DT nodes. I'm trying to make sure here that basic
> setup still works.
>

Sure, definitely. I there's no DT node, then the binding doesn't apply
and the driver (the platform part of it) will not probe.

> Adding also Johan and ath11k list. For example, I don't know what's the
> plan with Lenovo X13s, will it use this framework? I guess in theory we
> could have devices which use qcom,ath11k-calibration-variant from DT but
> not any of these supply properties?
>

Good point. I will receive the X13s in a month from now. I do plan on
upstreaming correct support for WLAN and BT for it as well.

I guess we can always relax the requirements once a valid use-case appears?

Bart

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

