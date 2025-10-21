Return-Path: <linux-pci+bounces-38928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E2BF7BE4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672E3401081
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572A2FD668;
	Tue, 21 Oct 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke9gU49O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045F19309E
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064796; cv=none; b=D7ZW0zwRXyidNsXRs9FgDXi+FneSSlXiRz/mJ4PeSeXjYIdsYrokDENGh2Zm+H4VWtBzIHD1osZ1HVxkemyu6Hn65nFYkoYe0RH68dFUWSVUQglCXf2ajNHhM1vcago7dJwIpVPfRkcszbTRzHSEQhtWYqshn8bdguogebhl0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064796; c=relaxed/simple;
	bh=qpx7VnzXu0jWnMHS6AoL7AXgBkvwcS31z32WB2upC9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jD1AywD8czZqzjj5Amttz2rPz5XN7bmRJi20+ICJ/RQ9x9714WKdXMq75C5AC3hfua5UxfFGtN6tDIVxzG9prJSGVejG6Th4y+hr1zdqVdXm0ElQ/Eo4hMWArxdXwUmwwcctSzdsPefhuIpXkRenHStmO6vc4lBGkFbzrochG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke9gU49O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD20BC4CEF7
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761064795;
	bh=qpx7VnzXu0jWnMHS6AoL7AXgBkvwcS31z32WB2upC9g=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=ke9gU49OgWntnGWDJ25iZiP5Pjt1ccyYrQwQRjMAj/5pM8eFE/hPTVirU4HUKZ4ux
	 6MkezHdJBm7IIPxD8xAzwX8GczMcfkafFfJHV1epyGiGCq/06UMsiSpiKp5MBG6UsG
	 /dpdLulVyagsXl90YbhhbjJXvXk6tb10JHMilN3Oif1dynKkIgovLt47qyechH2Hao
	 i8SfIWInCAffxuLfyf4e7hE3ksfImD3gDh26sEMS4+8EW2jD0TqFzFuxznuygDJz04
	 gpjCgCVmRl6U25gsim8Kx0JhU6Voz41r6be/VHu/1/8SrPEqtKV7nBailMoOxSR0cQ
	 gdfAGwWKy3ugA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36c0b946cb5so46878211fa.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 09:39:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeyaugovIC1q/W7GkGDQWUgIvXfkmleuR2kvyYNt9qeyNzX0VmZZQt4D2quJtg5NhEBUxIjdnsxgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE+L3mhOSTq9IrsfUdzYBnRzUz+pe7RrzOmOnOA8G/TGmUG5c
	CGJ6tiezesQIHEBBZOVK0tHQvvDcy5O2ZsAG3dOlNqYkvmOtEPqc3V9KHFaJfNd/+kSeQGrbBwj
	yJ2pSO2wKSAZmi2lv5B3as2o0wDVLR0U=
X-Google-Smtp-Source: AGHT+IE2XjfXeECfoI3UjrAZUn5quwYmJl2VF2lxd1i+sdiq5r6M2c/okvW135k2n/kF/1QwC+gpk9oVdn3+8YVxEho=
X-Received: by 2002:a05:651c:554:b0:377:78cd:e8fd with SMTP id
 38308e7fff4ca-37797826492mr57797611fa.9.1761064794269; Tue, 21 Oct 2025
 09:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e>
 <zk4ea5cibrkp4vttuy4evrqybf76b3nop5lnyck4ws4nyf2yc4@ghj2eyswsoow>
 <CAMRc=MdWmO4wvX6zpzN0-LZF1pF5Y2=sS8fBwr=CKMGWHg+shA@mail.gmail.com>
 <rfr5cou6jr7wmtxixfgjxhnda6yywlsxsei7md7ne3qge7r3gk@xv6n5pvcjzrm>
 <CAMRc=Me9Td5G9qZV8A98XkGROKw1D2UeQHpFzt8uApF8995MZw@mail.gmail.com>
 <rvsyll4u6v4tpaxs4z3k4pbusoktkaocq4o3g6rjt6d2zrzqst@raiuch3hu3ce>
 <CAMRc=Me+4H6G+-Qj_Gz2cv2MgRHOmrjMyNwJr+ardDR1ndYHvQ@mail.gmail.com>
 <fydmplp5z4hjic2wlmvcy6yr3s5t5u4qsgo7yzbqq3xu2g6hdk@v4tzjj3ww4s6>
 <CAMRc=McGuNX42k_HdV20zW+buACBTmTZEHWgS-ddRYsvnfwDSg@mail.gmail.com> <ibdmghl5dg3oda2j5ejp35ydky4xkazewhdvskm7p32vstdegr@36pj32b6dt44>
In-Reply-To: <ibdmghl5dg3oda2j5ejp35ydky4xkazewhdvskm7p32vstdegr@36pj32b6dt44>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 22 Oct 2025 00:39:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v65acHoO5025ZN7DhX0xVQf6JyHmUK3CB9UhnmTDDHq6vg@mail.gmail.com>
X-Gm-Features: AS18NWAGPRHcJje8w8MGIGImjcIFzXETxdKIrug_Hlh6_IEun9PtDw8YCzNUTf4
Message-ID: <CAGb2v65acHoO5025ZN7DhX0xVQf6JyHmUK3CB9UhnmTDDHq6vg@mail.gmail.com>
Subject: PCIe link training and pwrctrl sequence
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, PCI <linux-pci@vger.kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(recipient list trimmed down and added PCI & pwrctrl maintainers and lists)

On Tue, Oct 21, 2025 at 8:54=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Tue, Oct 21, 2025 at 02:22:46PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Oct 21, 2025 at 2:20=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > >
> > > > And with the implementation this series proposes it would mean that
> > > > the perst signal will go high after the first endpoint pwrctl drive=
r
> > > > sets it to high and only go down once the last driver sets it to lo=
w.
> > > > The only thing I'm not sure about is the synchronization between th=
e
> > > > endpoints - how do we wait for all of them to be powered-up before
> > > > calling the last gpiod_set_value()?
> > > >
> > >
> > > That will be handled by the pwrctrl core. Not today, but in the comin=
g days.
> > >
> >
> > But is this the right approach or are you doing it this way *because*
> > there's no support for enable-counted GPIOs as of yet?
> >
>
> This is the right approach since as of today, pwrctrl core scans the bus,=
 tries
> to probe the pwrctrl driver (if one exists for the device to be scanned),=
 powers
> it ON, and deasserts the PERST#. If the device is a PCI bridge/switch, th=
en the
> devices underneath the downstream bus will only be powered ON after the f=
urther
> rescan of the downstream bus. But the pwrctrl drivers for those devices m=
ight
> get loaded at any time (even after the bus rescan).
>
> This causes several issues with the PCI core as this behavior sort of emu=
lates
> the PCI hot-plug (devices showing up at random times after bus scan). If =
the
> upstream PCI bridge/switch is not hot-plug capable, then the devices that=
 were
> showing up later will fail to enumerate due to lack of resources. The fai=
lure
> is due to PCI core limiting the resources for non hot-plug PCI bridges as=
 it
> doesn't expect the devices to show up later in the downstream port.

Side note:

Today I was looking into how the PCI core does slot pwrctrl, and it doesn't
really work for some of the PCI controller drivers.

The pwrctrl stuff happens after the driver adds the host bus bridge.
However drivers are doing link training before that. If the power is
not on, link training will fail, and the driver errors out. It never
has a chance to get to pwrctrl.

I wonder if some bits should be split out so they could be interleaved with
link management on the host side. AFAICT only dwc and qcom will rescan the
bus when an interrupt says the link is up. Other controllers might not have
such an interrupt notification. I was looking at the MediaTek gen3 driver
specifically.

Otherwise I think the DT representation for the PCIe slot power is great.


Thanks
ChenYu

> One way to fix this issue is by making sure all the pwrctrl capable devic=
es
> underneath a PCI bridge getting probed, powered ON, and finally deasserti=
ng the
> PERST# for each one of them. If the PERST# happens to be shared, it will =
be
> deasserted once at the last. And this order has to be ensured by the pwrc=
trl
> core irrespective of the shared PERST#.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
>

