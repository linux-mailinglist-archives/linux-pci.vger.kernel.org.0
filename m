Return-Path: <linux-pci+bounces-44725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDED1DC7E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFCA4300699B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F42389474;
	Wed, 14 Jan 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNJKSXMn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248B37E2E5
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384967; cv=none; b=ELQI+z36MFA3PhynLClaOlhr9XY3KsMmAvno4eEjZcpt0U65L48B6KahgTjpfk7gKjlrbsFl4EFTJRXSiS+NolZSNkE+6RtDKqM8RC2pyjkzDLvFqeMw3FqbQDGyfS8MkpuJRa2CWJpXUnXLR6hHoKBpYtxz/2AvVbalIzZhV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384967; c=relaxed/simple;
	bh=J21eMwGvRb3Ir2T0rDZhf+5CjvL0Q3ymaKI1pU39VBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6ws+SQ6MwrCa7ZWtpUnd6jHRA3+G0SxFzcQiRyPIJGl/LZo4h3w8CwO2mjvXefJgkygOYm1H1bjAgLb5oO4E8it9COUcqN4JcC6CoXDBkTnw1mI38hlpEx7Jh1oxCbqXswadYEk9KyMDTqUTKa5jFlaiRxxfjCVB38nlQvczus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNJKSXMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EFDC2BCB2
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768384967;
	bh=J21eMwGvRb3Ir2T0rDZhf+5CjvL0Q3ymaKI1pU39VBI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=bNJKSXMnDqyAdNM576VsQIydoc3whz4WXP48ihXl/WtnIMHXN/IxCCrRRscgLdTdj
	 yzDt51zwU01cOsxGWqex85/rl1MmAM65mseG+ZUtsiJz6tU/5VpMM+K1R8K5+uKMy4
	 vN9q+yy+eRBJbOnRECr8X+LhHltNHIDodxY7SHawFpn27HrLJ/BB7sds0oINx5lLuB
	 0oHcAmNmpheSwY5HzkCz0vpjLPqSqyYLWkO/tnk0yRvzC541KMYZnxjxY++vogm7Ni
	 FTNeJBVaEEcY+Nf3Jvxqh5JeEGi40tYpBmS3rkCRXf5K0ghiUc6xv5GgkKpoll5sBY
	 ioQnYEdjgC8Ug==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38320cd563aso57311431fa.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 02:02:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1M13kC3IeVrf7GwKPt8DiSUz729RxIZYx9A7GhdkU+Czw0xPbhceO1uBN9brHUUdcECOch42GvMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GrZ58L3+VTzdBcTEAw5rJyAwWx+gus1e1ncg9epxBsbhgE7x
	ZadoRfNHaap1FuDyO5+YItMNOKKg1axlFXrZ5o9gt0MXPaqzkSVOPpM0iz4vjZFkipGETPAxxGH
	Vav4KrRfelkmTCrIOLgFp/f6AG60Newg=
X-Received: by 2002:a05:651c:a0a:b0:383:16e7:9bc with SMTP id
 38308e7fff4ca-3836073ed10mr6266071fa.21.1768384965281; Wed, 14 Jan 2026
 02:02:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com> <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
In-Reply-To: <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 14 Jan 2026 18:02:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v64FiDObsGx4A3m=HNP4xMKirXCK2PoCNtQci-DG4cU8yA@mail.gmail.com>
X-Gm-Features: AZwV_Qh9v98RAuEDwwJ5EmfR3hOwPvRr8ODi_heBwPelF0SUYCSd5yJsT1koanA
Message-ID: <CAGb2v64FiDObsGx4A3m=HNP4xMKirXCK2PoCNtQci-DG4cU8yA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sean Anderson <sean.anderson@seco.com>, manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 4:48=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:

[...]

> > > The original design aimed to avoid modifying controller drivers for p=
wrctrl
> > > integration. However, this approach lacked scalability because differ=
ent
> > > controllers have varying requirements for when devices should be powe=
red on. For
> > > example, controller drivers require devices to be powered on early fo=
r
> > > successful PHY initialization.
> >
> > Can you elaborate on this? Previously you said
> >
> > | Some platforms do LTSSM during phy_init(), so they will fail if the
> > | device is not powered ON at that time.
> >
> > What do you mean by "do LTSSM during phy_init()"? Do you have a specifi=
c
> > driver in mind?
> >
>
> I believe the Mediatek PCIe controller driver used in Chromebooks exhibit=
 this
> behavior. Chen talked about it in his LPC session:
> https://lpc.events/event/19/contributions/2023/

I don't remember all the details off the top of my head, but at least the
MediaTek and old (non-DesignWare) Rockchip drivers both did this:

    Wait for link up during the probe function; if it times out then
    nothing is there, and just fail the probe.

And this probably makes sense if the controller does not support hotplug,
and you want to keep unused devices / interfaces disabled to save power.

> > I would expect that the LTSSM would remain in the Detect state until th=
e
> > pwrseq driver is being probed.
> >
>
> True, but if the API (phy_init()) expects the LTSSM to move to L0, then i=
t will
> fail, right? It might be what's happening with above mentioned platform.

I can't remember if any drivers expected this. IIRC they waited for link up
in the probe function before registering the PCI host.

[...]


ChenYu

