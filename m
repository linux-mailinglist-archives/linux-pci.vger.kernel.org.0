Return-Path: <linux-pci+bounces-30582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CEBAE7ADC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814857B5919
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551F28936B;
	Wed, 25 Jun 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwbAQ1Cr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC72288CB2
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841130; cv=none; b=iGqiggPYt/xfGDfIPMnSugPLHUn2OM4oJGPDl7wLA9G+pOh807xBL4UwoJXBRMxFc4rYt70V1SBI9Uq5OPWHSvMovoJL3vNK8YX8a/7tL3zmIhBx5WUT9HF3UapeeL2MxSseFD38TPE34FSFOp2Pg4oXuPxViWq3+RqWwgfqTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841130; c=relaxed/simple;
	bh=4CWyVOg1ySsSGm3tCccXgrCtfZcjTGRY536tD9B4aXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEOhe8YQ1M3cipBqkWoGo6c3CvPWSJQAGZmvtJOX/S2qecMzp+qXisw5F7s5gb4t+B8HA4LzS4mkhVaVUYFH0BfOacpoBv+ka52bEEi1j3N2VOA4HVlAqO4FafFNnvatbqu+poRIoRsyqOhpVaVF34Gjb702G4t7/2A+h6P685E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwbAQ1Cr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32add56e9ddso51976891fa.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750841127; x=1751445927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CWyVOg1ySsSGm3tCccXgrCtfZcjTGRY536tD9B4aXc=;
        b=LwbAQ1Cr3YZihFgPa5aK9bUmn44ivPfF5qkBM8w6l/uw+BGgxyzRFFDannqOEjx/gX
         aEAc1T+yPBUSAdiG2JCq0B6E0+1sWJekOFyCwpg4qbTAMUc5iTIsqyNbO4ifOIZrBXBf
         GRtlQKXAPk2dxGqlv7WDWt/42F/TdnxWe/05eLVL4iDJ7iW5/AbCaQyl/qgqOWSoW+QI
         cQptVJGDMMS7hXIK9qUicyEmM0RVLlilpu4h3tSBTy94ehG8IysLPlyXksaUyD1QFIih
         DYyoiOQI6Vfwr3R4As1c0LSjYYvso/oycxykAAg4S98+/RyfAfEzPdDE2SVE89IJNrnP
         9KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841127; x=1751445927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CWyVOg1ySsSGm3tCccXgrCtfZcjTGRY536tD9B4aXc=;
        b=gVjMGQFkijl0vrQiHcYtwvRe2Bn6xViAMAbmaKAogTKsjT6/VXLEuUTC2S+sIucbMn
         OnAk8Rn6SLNfpB4f8rLzplWKQ1GGa5XMSz9vgsEpPBiMjjviOFsJb/Fr19W579NFfAl8
         u/Xl0uPDZ1okNrqtw0BjnYEqY99Qt2k0aWdxaqmPBRzIEM1uzx59WajeIUg3f2IfJ8Ap
         GUv3L+gF4/64qXE/xhSz3h7AIRyetNmclHxWfQwvJmE+qltq4tQLlV6VT5AG7zvrZBPk
         Ut1ilts/YnXR7zxVUVwNhvRHW9cIcCvHKJG+wsqZ5aPRdGzQfll4drxZ8/XFDm4o/Hkf
         varQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyhFJWGwmSaLwKxvWIqvV/u9jy0uLfytdWRWhx8avxNzX7xaABwI/VR8yOTXk3YEvCk7HPR1pdBeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfKBxq4Sk0hR2O0YFmvXs8bc5zYMaOf9fWNyF2DRxlflBfgxOa
	0Ygei/tGpoA0gpJR8EL2v4vsekafcD32N1AUE2K6zI0sj07y3DgBldayfDiMRxYs4NPgrwZPmC4
	WVrOy7aaC2gwgRlbfYLbG+aIWxABJ9KtMQSy5FeqdzA==
X-Gm-Gg: ASbGncuM25OQSD9w313sA9GjKDwHJgaRKUO65+IP6fAOsFiIpM7FUzLNAhbEvhhFShF
	Hjh9AI2HoGShBYSQDdrJwjow7HqYMYwWznuEnpQlZTtOrzFdrRoqgvJ4Hod39vA1/UufS9xzKXX
	GPf2WFn5rVBrvN42odEzQB2gjn0Pe7rFmZ9Mt0zzMOAtM=
X-Google-Smtp-Source: AGHT+IE+JyenPgPvT+Svvv9s+V0VraZ6su8hbOajVsCqvqbMTxCrk4fBzjbCyvVMQ0l2eId9Zjx6ak0ozUYWm+PwBYY=
X-Received: by 2002:a05:651c:4201:b0:32b:533a:ef76 with SMTP id
 38308e7fff4ca-32cc6490c2cmr5605931fa.13.1750841127084; Wed, 25 Jun 2025
 01:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c282b89b1aa8b9e3c00f6bd3980332c47d82df7.1750778806.git.andrea.porta@suse.com>
 <9d31a4d7-ffd1-48ca-8df6-0ddc6683a49c@broadcom.com>
In-Reply-To: <9d31a4d7-ffd1-48ca-8df6-0ddc6683a49c@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 25 Jun 2025 10:45:15 +0200
X-Gm-Features: AX0GCFs5reLO3eAptejwJU5aIb8qpce34Nq1CQTt9TXYf2HTB17zcNXvrt_8Yc4
Message-ID: <CACRpkdbAxyZK_f8y6mzX_eJ3UM5ZtuXEpSmXE+QpUXaHKw_NGg@mail.gmail.com>
Subject: Re: [PATCH stblinux/next] pinctrl: rp1: Implement RaspberryPi RP1
 pinmux/pinconf support
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, 
	Herve Codina <herve.codina@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Phil Elwell <phil@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:11=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> On 6/24/25 08:36, Andrea della Porta wrote:
> > The current implementation for the pin controller peripheral
> > on the RP1 chipset supports gpio functionality and just the
> > basic configuration of pin hw capabilities.
> >
> > Add support for selecting the pin alternate function (pinmux)
> > and full configuration of the pin (pinconf).
> >
> > Related pins are also gathered into groups.
> >
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>
> Linus, can I get an ack or reviewed by tag from you and take that in the
> next few days to go with the Broadcom ARM SoC pull requests? Thanks!

I was just very confused by the "stblinux/next" thing in the
subject ... what is that even. I thought the patch was for some
outoftree stuff.

But go ahead!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

