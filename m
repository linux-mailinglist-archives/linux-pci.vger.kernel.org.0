Return-Path: <linux-pci+bounces-3744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281EA85AE52
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91E1284DEE
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1D3524C0;
	Mon, 19 Feb 2024 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeBEtE8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DCD55792
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381319; cv=none; b=GUKrD32SdE6jGKp/0zejED1PmMwrYBCjHUPhGNbNFi8v8BcSFZ2H4Z+DRoTvY6epAyi0/Q3Vp7MA2O1auykcOEpiGuFWOACkIOqSnEYUQkvzZI+XyNuWiEmgw14S+y/ItxPCV8H07pGDGJNmEzvmTunoMl21ZXprOEU6pzvLKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381319; c=relaxed/simple;
	bh=AV04W98SGcs03DR+MbROhSLr0Maq3x3IF7tuWG4r08E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHXdBB0JiiI+8yOr22YfXAaW1K4chILWsMjInSyLMOOrSeP4Bryc4D4hMCCBwxK5XcgO36dmJ6tXBQxdVcOEZHikCaISKd0hC8wSB7wvYSbS//UHhhUxcWTfPUlzS1E4p2m/RgPXJByx47Qhh0DrrWialagKB24rabe6y6XH5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jeBEtE8D; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6085ed1e916so2355957b3.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708381317; x=1708986117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWBfqhdEXedBrtNGEQDXyHOTQXUxKpS9xFZl5trWPds=;
        b=jeBEtE8D5+RBIx8FwXYe8gUqn9uAmiKUwypD5maslZ2iX9iMfG22I5zVV2MhFz/O+f
         e7k6cUsrsAlM17Ys50ObNbcuDligfa6M1uh3Lme7xPi/iysl3Md6dk3qY4LPFHydMTTt
         xNIl0wtPa3UvLZ4GJToMPIja2UHOY9++XHEogBuwgGA2+ahV0L7qpQSw2puGwTneltJ8
         INrX2j378nAQkTnIK0fS+iiGsZ51kfR26MNaQe7xhwSvaZ6f8fDKA3XcDxoqvfJLIqOt
         El4H4KFRCDUGnY9oVUhm3v9SEoXEXuqkF1wlxdOUXdeq7Fl8ewcAwO5cOeWB87jRkFQQ
         BkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708381317; x=1708986117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWBfqhdEXedBrtNGEQDXyHOTQXUxKpS9xFZl5trWPds=;
        b=S7lQEwYtNoR1K+SkSinCc9/pi5ShMn4a4qqshAaw/AIJ5vVWNp8wpd/TytEg5fsojb
         4njU5/RuvpCZGTUTH7hCHv+02+VBQKkdAoYCfPHAc8/9JJ/NiCg1eI6I9fyZ/2roc6qO
         zgqCv7k7PaOLahHQFlbkSBn39GygZm3anJqcI8E0IyuZHMkl6D20fCdxEjsl5Ysz4BrB
         YOCVGWk7prLFftDLg/hhadhQlH9wynZVg49Hs49lscc1CdZBACIM7OXyiqEeP0ukKy6M
         8EFrPnBWmrysjWz575zGvcM5EjKQvF8yqOc77Up75TuMq0yEDR15sQ3snCgVJ/+dQEdg
         3hpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmAtGOVtIUoW1ONjIqLPNntVTBPjgS7sF3ZztOusQjoI04uAsrdXEXgp5wjlpGu4Z+C01a4F5eINvGgDsrupfzN8kcNnPqkoQ6
X-Gm-Message-State: AOJu0YyaD3LIw5GIlmx9s2MNWZi1SiRPkv80oQ7/GOjnhcx8KBzjE7yn
	fYK4owLdm7yE1mwlVU93cI3UXUnZMD9EhhzsZ4M4iiEzxryFFM6esZC6r9TOTq9qoxKtAZzmucc
	j/kKkRBIkW3ppZ0UauHFqxJnSgD+2ZhwHLpYz97DXB+uqk+9E
X-Google-Smtp-Source: AGHT+IEw1QxrScZ5otnCQ0EY59GfXlyDDJtQ3b51NbbVrQfFF81qQ7/f7MndD7svyF5jQtcz/STFrjnb2NG3XxDBlfQ=
X-Received: by 2002:a81:b603:0:b0:607:caee:ebd4 with SMTP id
 u3-20020a81b603000000b00607caeeebd4mr13871897ywh.31.1708381316805; Mon, 19
 Feb 2024 14:21:56 -0800 (PST)
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
 <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com> <b9a31374-8ea9-407e-9ec3-008a95e2b18b@linaro.org>
In-Reply-To: <b9a31374-8ea9-407e-9ec3-008a95e2b18b@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 00:21:45 +0200
Message-ID: <CAA8EJppWY8c-pF75WaMadWtEuaAyCc5A1VLEq=JmB2Ngzk-zyw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: neil.armstrong@linaro.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
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

On Mon, 19 Feb 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
>
> On 19/02/2024 13:33, Dmitry Baryshkov wrote:
> > On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >>
> >> On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
> >> <dmitry.baryshkov@linaro.org> wrote:
> >>>
> >>
> >> [snip]
> >>
> >>>>>>>>
> >>>>>>>> For WCN7850 we hide the existence of the PMU as modeling it is s=
imply not
> >>>>>>>> necessary. The BT and WLAN devices on the device-tree are repres=
ented as
> >>>>>>>> consuming the inputs (relevant to the functionality of each) of =
the PMU
> >>>>>>>> directly.
> >>>>>>>
> >>>>>>> We are describing the hardware. From the hardware point of view, =
there
> >>>>>>> is a PMU. I think at some point we would really like to describe =
all
> >>>>>>> Qualcomm/Atheros WiFI+BT units using this PMU approach, including=
 the
> >>>>>>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
> >>>>>>
> >>>>>> While I agree with older WiFi+BT units, I don't think it's needed =
for
> >>>>>> WCN7850 since BT+WiFi are now designed to be fully independent and=
 PMU is
> >>>>>> transparent.
> >>>>>
> >>>>> I don't see any significant difference between WCN6750/WCN6855 and
> >>>>> WCN7850 from the PMU / power up point of view. Could you please poi=
nt
> >>>>> me to the difference?
> >>>>>
> >>>>
> >>>> The WCN7850 datasheet clearly states there's not contraint on the WL=
AN_EN
> >>>> and BT_EN ordering and the only requirement is to have all input reg=
ulators
> >>>> up before pulling up WLAN_EN and/or BT_EN.
> >>>>
> >>>> This makes the PMU transparent and BT and WLAN can be described as i=
ndependent.
> >>>
> >>>  From the hardware perspective, there is a PMU. It has several LDOs. =
So
> >>> the device tree should have the same style as the previous
> >>> generations.
> >>>
> >>
> >> My thinking was this: yes, there is a PMU but describing it has no
> >> benefit (unlike QCA6x90). If we do describe, then we'll end up having
> >> to use pwrseq here despite it not being needed because now we won't be
> >> able to just get regulators from WLAN/BT drivers directly.
> >>
> >> So I also vote for keeping it this way. Let's go into the package
> >> detail only if it's required.
> >
> > The WiFi / BT parts are not powered up by the board regulators. They
> > are powered up by the PSU. So we are not describing it in the accurate
> > way.
>
> I disagree, the WCN7850 can also be used as a discrete PCIe M.2 card, and=
 in
> this situation the PCIe part is powered with the M.2 slot and the BT side
> is powered separately as we currently do it now.

QCA6390 can also be used as a discrete M.2 card.

> So yes there's a PMU, but it's not an always visible hardware part, from =
the
> SoC PoV, only the separate PCIe and BT subsystems are visible/controllabl=
e/powerable.

From the hardware point:
- There is a PMU
- The PMU is connected to the board supplies
- Both WiFi and BT parts are connected to the PMU
- The BT_EN / WLAN_EN pins are not connected to the PMU

So, not representing the PMU in the device tree is a simplification.

>
> Neil
>
> >
> > Moreover, I think we definitely want to move BT driver to use only the
> > pwrseq power up method. Doing it in the other way results in the code
> > duplication and possible issues because of the regulator / pwrseq
> > taking different code paths.

--=20
With best wishes
Dmitry

