Return-Path: <linux-pci+bounces-21768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E870A3ABBB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED15F16A5FC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB11C3F1C;
	Tue, 18 Feb 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAAd/qX4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7B2862A5;
	Tue, 18 Feb 2025 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917975; cv=none; b=s9KB/IDEpqnOwTpeYD8p0YJh8rLW1s90rk8syvfYlVjRLdCAWXMjRXVH/d39TcugIzlfGSVbyUDjlgDYenVud23VwD3q8FbPRVN3DE1gVll+KYhBah8Z8B+1Rskjh9iFodc87gC7CTAe54S8h7Mrd7QRj4oF5feQ/IC8UTTtFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917975; c=relaxed/simple;
	bh=/b5Hpj1f7yJgvbKrphP6Ri0sMcj4xtt856FZzy0Lv7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVZm3fvT1g5pC6UbnVzci8zBZ+dIo9FjQw6JGsX2U1Fy3b0GyMW3dE12UVw67p5Mxy5iiFPZj9IJsuKNXIADL/CB6YMHAG5melaVGcCCrJgBBWLbHUYsT4EY9vRcYpp2cjMY/+9gv+TEUUTVo/IRpGrts7bHoWd0DHz34spZwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAAd/qX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617D2C4CEE9;
	Tue, 18 Feb 2025 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739917974;
	bh=/b5Hpj1f7yJgvbKrphP6Ri0sMcj4xtt856FZzy0Lv7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KAAd/qX4UOvDbOwNnhWOnlSwHp9kAmGQ64rcnfcha4VPFqcKzzPy3wnVBNqdeayU9
	 E4qMTUn3yqV+IKUdiM50yniYT21B/NNal6fQDhAYAmGDCOh87Q8S0ZvLX1qJFHtF/q
	 9WQMrx25vPmyxDijosbOyJ5TMHqJgTJkKbyr99tJJzDeKgcUwpgL4rqepj4yRaLhzO
	 zauBBurpWXWZw9Wn2lDhivKVIiitHef0bUTr7CsPCbkG+h3wBtGL1z+6IYA0XhNsCB
	 0rwrJ6depsuUybBDKl3cTu5P/Ogw6h5mvFB98bAiry74dLQ8c8K0tsLdq3WftPBbSR
	 RoR2ELnMav7sg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso4888091a12.2;
        Tue, 18 Feb 2025 14:32:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMDUxRFJXpw9gLEL9aJojlrYQGjjPM/muG08/HPIJpI7/2/0TPink4TBLAfMQzbPyeqHamuwbEuWPm@vger.kernel.org, AJvYcCXdpAYlfzfDiwcb1Y/TfzKVAaFlmR4eUM8A7pL0FL+nuWUMagP95TgAYLeyQO7S/v2jiI1kFIm0ctlZWPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzZS0iYrIt5r7vf7Zpbxgi9xNy4Kceib4PrXWqfCSPMHtPk9u
	DwkLFBUrT6p8Juz/kGLxyp5d+6+pdmyEhLL6YVCBmOgdccl/7Hom+FflS38fSPVN0AvleKh8jrf
	TaSgwfYGgeyEa3fuvB4QKqMoDkg==
X-Google-Smtp-Source: AGHT+IGbj8cBtp91/Fe3BaEKNO/HdIdSWwYsIibl0UALaecSgf4d1GNu8D2qYOSALt4T7Q0kztSe3FjfBDbHrtJdeXg=
X-Received: by 2002:a05:6402:50c8:b0:5dc:a44d:36bd with SMTP id
 4fb4d7f45d1cf-5e089521896mr976943a12.8.1739917972966; Tue, 18 Feb 2025
 14:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107153255.2740610-1-robh@kernel.org> <20241115073104.gsgf3xfbv4gg67ut@thinkpad>
 <20250216165406.jp2dzfwdfucklt5b@pali>
In-Reply-To: <20250216165406.jp2dzfwdfucklt5b@pali>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Feb 2025 16:32:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhYy4cdD8nnn4EjEfdipwS2EQfZAuG4QtKopXM95P2Ag@mail.gmail.com>
X-Gm-Features: AWEUYZnZOHLmJ7BNmzdA8bqCUJoLvmFX4gKX9vplzHjuoT53syEnpMmsZXAO0EQ
Message-ID: <CAL_JsqLhYy4cdD8nnn4EjEfdipwS2EQfZAuG4QtKopXM95P2Ag@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 10:54=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
>
> On Friday 15 November 2024 13:01:04 Manivannan Sadhasivam wrote:
> > On Thu, Nov 07, 2024 at 09:32:55AM -0600, Rob Herring (Arm) wrote:
> > > The mvebu "ranges" is a bit unusual with its own encoding of addresse=
s,
> > > but it's still just normal "ranges" as far as parsing is concerned.
> > > Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> > > instead of open coding the parsing.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > LGTM!
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Could someone please verify it on mvebu machine?
> >
> > - Mani
>
> That is mostly impossible as pci-mvebu is broken. Bjorn and Krzysztof in
> past already refused to take patches which would fix the driver or
> extend it for other platforms.

That makes no sense. The driver is broken and we won't take patches to fix =
it.

> So I do not understand why you are rewriting something which worked,
> instead of fixing something which is broken. The only point can be to
> make driver even more broken...

We make coding improvements to the kernel code all the time. There is
no way folks can test every platform. Either drivers need to get
tested at some frequency or they should just be removed until someone
cares enough to maintain them.

Rob

