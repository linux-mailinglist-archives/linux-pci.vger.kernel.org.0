Return-Path: <linux-pci+bounces-3861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B641285F6B9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99AC1C22BB6
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC54177B;
	Thu, 22 Feb 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaq/4x0y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462641235
	for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601233; cv=none; b=JE/vaPc+69Rw1xCbDKpU6ONARQUN327k7ckEzeJ+IGwfnui9rSosL4d+2xz7d1EedhexgMmcfb4w0b/+lnc2GuumRjHZYCVANFuNzBFQh0h/ahLUUedgfUAEnEEUwrujIXLQB893DKwwWgHlVPGgrRSQgaihUHqr00LCfk6KJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601233; c=relaxed/simple;
	bh=+rgLuw5oSwBFP4Ow0ptZ3qnTpUGqMbW5KK1t7j5QRoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uw0toxyEt8akAeMbEmDIUBbxFlgvkoKB+bzzq8HpAgGyM5CcsgXko93cTn8O1BCOpnY/9jiPNp37gaz5rvcKMzQXa+kHkEuy0YxE6fTUls8lwG5q4cmP9vC1W8hEf2L6euu6ZxpwCzpoK3DUSlhwVRicQtu8jfLvHOhlpTe1iA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaq/4x0y; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso8176692276.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 03:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708601231; x=1709206031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4xgDZb1P7EFUwoTHIn2hJ0tMWxsP/j125TvtkH/GhA=;
        b=zaq/4x0ykWlKc5A8P5W1u0NUMpBUrOqgSSDgort8rcxCKF8F6BJjpUU9NipTLJJ/Yw
         sN4+bQmEE9Jd2T1dpQ79bw8yCZK9uWufoIVtgOfneHwsXfZI0rZKB6uyevtxL3enTRiP
         cZXan2Yb9KiNM/qu4zgWVlXssBsvuiYg/jbwy4wZh/iHayf7BPGAfBRcBoR7k3MHfuE0
         Nh6gyzaff2GF8TqaaCgQ+yPoyQSpBeb3ynA+1wgSgagnxjT0LSy3ZvPo9F5kN4I8o2pa
         IIwEuPa3ufDK+FeMnI9RSCZdpZy/iczYHYAbiZTeScFHqrtNwq8Te+yYBHwGAl/705aY
         Dylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601231; x=1709206031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4xgDZb1P7EFUwoTHIn2hJ0tMWxsP/j125TvtkH/GhA=;
        b=BdSIDZzjxI7UB2uWENUrNb0LO7Qawv27+CJqYg10+oYuhEnyD5VMT3kbyCf6WHve8f
         p1PQKy6w/5JfkrIl1F82oUoQCmSYmyEo2vat2V1Aj4BXl+JpYh3CPFhNtXh0YsJ+DrbS
         K1S2syHPr/Qh0OJiUv1KDyDbWL5BcuPmSIcdqQJowKrLUjqT22We1Nwm+XYYucdxJS5S
         J0gDo1N71sLSB4g8YKOXR0SQDJ2j/FhQxJoEuGvN6SsnADY07v1meEi9plAYII4gEuW/
         kvvkf346eSRlJM8VGGRgIW/ExoJjTqbg4NbjqoTwPP6WdEFmqoepp6kaxzyBNG1zvCtr
         q+tA==
X-Forwarded-Encrypted: i=1; AJvYcCW6m7bMYLRmlNIavn+Wrh83kpGInH16kRYbR8J0Q2pb9xRxHZPcbTC75kUmRnZQw2Hxkpqh1+Z+VGJfRe66sJgg4fKcd9KUB3AY
X-Gm-Message-State: AOJu0Yyw+aR4JB00R0EzdxpGgichXfw8n9FlSCuUa79Ok6lh2GACuJaA
	ctoPC3ahso4qCkJfbsP862QSv5U7+wpZkt0wFGZXZ+iBwKtE0RD0uFColb/2tp7wln4FRle/QVG
	5ddRwwvlIRrK2rJ0plp5YRihqTUf4IlDyE+PJuw==
X-Google-Smtp-Source: AGHT+IGAH9HKM2JNlJGtqlBg9xAVeOcNDcSSfQGB4O1issqL+64giDGxV3EK2ifXD1JwfWN2ZGYk5wlqfAYXwHW/w3g=
X-Received: by 2002:a25:1184:0:b0:dc6:aed5:718a with SMTP id
 126-20020a251184000000b00dc6aed5718amr1758467ybr.26.1708601230793; Thu, 22
 Feb 2024 03:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org> <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
 <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
 <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com>
 <b9a31374-8ea9-407e-9ec3-008a95e2b18b@linaro.org> <CAA8EJppWY8c-pF75WaMadWtEuaAyCc5A1VLEq=JmB2Ngzk-zyw@mail.gmail.com>
 <CAMRc=Md6SoXukoGb4bW-CSYgjpO4RL+0Uu3tYrZzgSgVtFH6Sw@mail.gmail.com>
In-Reply-To: <CAMRc=Md6SoXukoGb4bW-CSYgjpO4RL+0Uu3tYrZzgSgVtFH6Sw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 13:26:59 +0200
Message-ID: <CAA8EJprUM6=ZqTwWLB8rW8WRDqwncafa-szSsTvPQCOOSXUn_w@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 at 13:00, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Feb 19, 2024 at 11:21=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 19 Feb 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
> > >
> > > On 19/02/2024 13:33, Dmitry Baryshkov wrote:
> > > > On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev.pl> w=
rote:
> > > >>
> > > >> On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
> > > >> <dmitry.baryshkov@linaro.org> wrote:
> > > >>>
> > > >>
> > > >> [snip]
> > > >>
> > > >>>>>>>>
> > > >>>>>>>> For WCN7850 we hide the existence of the PMU as modeling it =
is simply not
> > > >>>>>>>> necessary. The BT and WLAN devices on the device-tree are re=
presented as
> > > >>>>>>>> consuming the inputs (relevant to the functionality of each)=
 of the PMU
> > > >>>>>>>> directly.
> > > >>>>>>>
> > > >>>>>>> We are describing the hardware. From the hardware point of vi=
ew, there
> > > >>>>>>> is a PMU. I think at some point we would really like to descr=
ibe all
> > > >>>>>>> Qualcomm/Atheros WiFI+BT units using this PMU approach, inclu=
ding the
> > > >>>>>>> older ath10k units present on RB3 (WCN3990) and db820c (QCA61=
74).
> > > >>>>>>
> > > >>>>>> While I agree with older WiFi+BT units, I don't think it's nee=
ded for
> > > >>>>>> WCN7850 since BT+WiFi are now designed to be fully independent=
 and PMU is
> > > >>>>>> transparent.
> > > >>>>>
> > > >>>>> I don't see any significant difference between WCN6750/WCN6855 =
and
> > > >>>>> WCN7850 from the PMU / power up point of view. Could you please=
 point
> > > >>>>> me to the difference?
> > > >>>>>
> > > >>>>
> > > >>>> The WCN7850 datasheet clearly states there's not contraint on th=
e WLAN_EN
> > > >>>> and BT_EN ordering and the only requirement is to have all input=
 regulators
> > > >>>> up before pulling up WLAN_EN and/or BT_EN.
> > > >>>>
> > > >>>> This makes the PMU transparent and BT and WLAN can be described =
as independent.
> > > >>>
> > > >>>  From the hardware perspective, there is a PMU. It has several LD=
Os. So
> > > >>> the device tree should have the same style as the previous
> > > >>> generations.
> > > >>>
> > > >>
> > > >> My thinking was this: yes, there is a PMU but describing it has no
> > > >> benefit (unlike QCA6x90). If we do describe, then we'll end up hav=
ing
> > > >> to use pwrseq here despite it not being needed because now we won'=
t be
> > > >> able to just get regulators from WLAN/BT drivers directly.
> > > >>
> > > >> So I also vote for keeping it this way. Let's go into the package
> > > >> detail only if it's required.
> > > >
> > > > The WiFi / BT parts are not powered up by the board regulators. The=
y
> > > > are powered up by the PSU. So we are not describing it in the accur=
ate
> > > > way.
> > >
> > > I disagree, the WCN7850 can also be used as a discrete PCIe M.2 card,=
 and in
> > > this situation the PCIe part is powered with the M.2 slot and the BT =
side
> > > is powered separately as we currently do it now.
> >
> > QCA6390 can also be used as a discrete M.2 card.
> >
> > > So yes there's a PMU, but it's not an always visible hardware part, f=
rom the
> > > SoC PoV, only the separate PCIe and BT subsystems are visible/control=
lable/powerable.
> >
> > From the hardware point:
> > - There is a PMU
> > - The PMU is connected to the board supplies
> > - Both WiFi and BT parts are connected to the PMU
> > - The BT_EN / WLAN_EN pins are not connected to the PMU
> >
> > So, not representing the PMU in the device tree is a simplification.
> >
>
> What about the existing WLAN and BT users of similar packages? We
> would have to deprecate a lot of existing bindings. I don't think it's
> worth it.

We have bindings that are not reflecting the hardware. So yes, we
should gradually update them once the powerseq is merged.

> The WCN7850 is already described in bindings as consuming what is PMUs
> inputs and not its outputs.

So do WCN6855 and QCA6391 BlueTooth parts.

>
> Bart
>
> > >
> > > Neil
> > >
> > > >
> > > > Moreover, I think we definitely want to move BT driver to use only =
the
> > > > pwrseq power up method. Doing it in the other way results in the co=
de
> > > > duplication and possible issues because of the regulator / pwrseq
> > > > taking different code paths.
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

