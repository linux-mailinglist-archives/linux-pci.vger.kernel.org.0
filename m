Return-Path: <linux-pci+bounces-19310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62249A01A9E
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF20F1883FCA
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82D14D717;
	Sun,  5 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0VuDodx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36014B07E
	for <linux-pci@vger.kernel.org>; Sun,  5 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094921; cv=none; b=Owt5+DwFZ9pEORj2eYUZOebHT1oHelCDpjKVv7MS+PnEAmVU3FbMAwyGCv0JqqLX2dllhicUzhsn/OyNhKw2Je+wmxufO7BKxy9jnrVDLMe9bdZIzOBceAGVnFSl+FH8pEGR7nvCe0IaBdr70N6JKCrvk8CMgILxYfWYoK3ggD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094921; c=relaxed/simple;
	bh=W8n4UV6+W1kcJ9PGinQ/CjgG6MkwYDyuasni3ltxRO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwME9/i7Y6tIBFVBhl261qr2to9zP9N53DEVH6Ydp/P2SRuWquUUscw7Gix03duaL+6LfDh0m3vXjUbB+nIas/WxVWWSPvFvRJWmOU6COJYed413nZ7zEDfDY6bahNR0ECl0liV24N0Ig1QugZx4lNZMrdS008BZeQS6AxTubj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0VuDodx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21680814d42so163881325ad.2
        for <linux-pci@vger.kernel.org>; Sun, 05 Jan 2025 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736094918; x=1736699718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PnREJXO8gdOnlDXn6hPd7bSDzdru7IQfI4OFlA05/Zk=;
        b=i0VuDodxftT9iVhyH5DlZjIW4/9meupkBgQgSN8wpOa8upkfz2qe+wzAuFemBrDUdy
         Hp0o33L5SwSnnLZKM9a0bzXm4u1/LGG6YS3DK07kKx6kzh35eynv68Nk5Wa2Bn2roDfv
         YZeRZoU+I/CMZct6W9de5RAAwhCDwsfnzNrpyilBdSK3ODF+/2TlKSKC2K3hqtnE4zt3
         OybOS9sMkLahJVc71smniNyZkBbfzjh4LJCLnSYgNVlb2yq49P4uZVj6HihRY4qqk6it
         9kDOxf1NuyXYnnTd/z/LUNWqnPx/1nVuRr67kdq686L9OMgDK2trZl+N/hJ6bcAi14IA
         J3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736094918; x=1736699718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnREJXO8gdOnlDXn6hPd7bSDzdru7IQfI4OFlA05/Zk=;
        b=ZA9kR/TTCM8FaxPuNpYg02KZleW+SNb/AO+wwX2l/bkaCB5BhlMeclh+S1kAOh3gX5
         48UhOS65A34za6O0qyroG9/SLrXJtxBCHGdxbkZQfgaoWws0wpTu3aOzAghc8+3AT+l5
         0fVgJcsJ/g1jFmA4penQV4zBvqBkJ5ag9H4q43BXCxOYSdxWqw+0Rtir4AbP4zcOeZUd
         fbQNPuao4yxXNENXVPraJJhlq25Bd5+Kn2r3hQCnUUc4A93ZYZq5MG6nWGh7EZbW5RqL
         stoxoRVcllDyOq7ZfnN6xTB9s9x6ADrGtC2C4Em1Xo8NryaALGP83LlCp/5J1+supmtZ
         lQVw==
X-Forwarded-Encrypted: i=1; AJvYcCWSdeHeygjRh6FZMLQQSurCUA7bcMb+HND29GillK/8iuNPZGlo6/KxrL6OfCmqyYtsk4Q3H2jy1mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hbuXWkww9amMeDdHPX4W6cs7AtGL2tleEM6psIE4MxkOt2yl
	Os3AGuHuTrIqzNreRxMtAANYha6CjsssGlIVfGndsniDPQXz8yFZQoTmj9S8PQ==
X-Gm-Gg: ASbGncv7LvuMtt0Cp+VPm0TMfcJk4DHOtNCpTkn0I3xfXwS0SdSzfyTS3OaxiMSSO+Q
	6BOSzotCia0qFlhePbDpk6Q4nYuwJ385nd+PuvxnLr51Hy9McNjh2SCg4rSaP3xFGrs/u4XIN83
	oscuEZLxC1+ZDmbYMRcQvPQHSM6yeNo/l6F5nSnXmZsBIQxC8fxgNkVMyPlx64vShkrLk/n9hCT
	k2JOuTO/Bl8NQEQiHqeg3WuqGp1xUKMvt4DfOaZubw3r99g7yRBJ/9Fp8iWqCi93u/o/g==
X-Google-Smtp-Source: AGHT+IEOtAp4w31CjTLB1aFWoVsatu6IG9r4c5kd2CVIdLrHft5tD4dMe9HJZQJaorB/J3Udvac1sQ==
X-Received: by 2002:a17:903:2cc:b0:216:2e5e:971d with SMTP id d9443c01a7336-219e70dc3f7mr692735935ad.51.1736094918605;
        Sun, 05 Jan 2025 08:35:18 -0800 (PST)
Received: from thinkpad ([117.193.213.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde72sm277254345ad.130.2025.01.05.08.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:35:18 -0800 (PST)
Date: Sun, 5 Jan 2025 22:05:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <20250105163511.rwer5pl6tevw4zp2@thinkpad>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <Z3fzad51PIxccDGX@ryzen>
 <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>
 <Z3f4JQZ6yYV1BJ-b@ryzen>
 <CANAwSgRTcHuDNLvPJAs7ZaV-NnepeOkHj_kVc5OAJtP03hd6pQ@mail.gmail.com>
 <Z3f95RXj7GhZZHEP@ryzen>
 <CANAwSgQEb7rWFaeEO3Mb8LAwK6A5mrCyQFEysmSpeVdhoRWrtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgQEb7rWFaeEO3Mb8LAwK6A5mrCyQFEysmSpeVdhoRWrtw@mail.gmail.com>

On Fri, Jan 03, 2025 at 08:59:51PM +0530, Anand Moon wrote:
> Hi Niklas
> 
> On Fri, 3 Jan 2025 at 20:40, Niklas Cassel <cassel@kernel.org> wrote:
> >
> > On Fri, Jan 03, 2025 at 08:36:18PM +0530, Anand Moon wrote:
> > > > >
> > > > > We need to enable the GMAC PHY and reset it using the proper GPIO pin
> > > > > (PCIE_PERST_L).
> > > > > Please refer to the schematic for more details.
> > > >
> > > > The PERST# GPIO is already asserted + deasserted from the PCIe Root Complex
> > > > (host) driver:
> > > > https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L191-L206
> > > >
> > > > which will cause the endpoint device (a RTL8125 NIC in this case)
> > > > to be reset during bootup.
> > > >
> > > Thanks for letting me know. It seems like a workaround.
> > > I'll try to disable this and test it again.
> > >
> > > My point is that we haven't enabled the GMAC PHY (device nodes)
> > > and must properly reset the GMAC.
> > >
> > > We're relying on the code above hack to do that job.
> >
> > I do not think it is a hack.
> >
> > If you look in most PCIe controller drivers, they toggle PERST before
> > enumerating the bus:
> > $ git grep gpiod_set_value drivers/pci/controller/
> >
> 
> Ok, understood. However, we have multiple reset lines per controller,
> so the PCIe driver will reset these lines using gpiod_set_value.
> 
> PCIE30X4_PERSTn_M1_L
> PCIE30x1_0_PERSTn_M1_L
> PCIE_PERST_L

PERST# gpio is unique per controller instance and will be asserted/deasserted
by the PCIe controller driver itself. Endpoint drivers should not touch these.

And most of the PCIe endpoint devices do not need to be described in devicetree
as PCIe is a discoverable bus. But we do define some of them if they require any
special board configuration.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

