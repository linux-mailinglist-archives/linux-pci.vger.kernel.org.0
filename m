Return-Path: <linux-pci+bounces-35345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26801B411FE
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 03:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 074634E1D08
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 01:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA11B4138;
	Wed,  3 Sep 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+2lHvAW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF165E555;
	Wed,  3 Sep 2025 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863542; cv=none; b=uxLB37jr3z5FyP2gvY4CbovrKTuvu0pqNPb19qOzxdOqZFXPJzvrostBUO23InS/k4/fJJqdJFf7IrP/CxblP61sEF1ej619N27utpxLgxuRD719s2QRnIprnBMiHp6R9Nxu1jpancErbQjFd7c3aRVSPXAmIawgBJiQ4bED1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863542; c=relaxed/simple;
	bh=zOeJ5ngI5GgY1IUOwe+4owS6Ud/kOULo7zVSgkL3p5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y918Il5B70wR7rviaAI3n0Jw5rDdh512nZ2sUpFQuVFcl/i9Ypv2tsqc0f15MemcEY22YtnKrMyj7AlRvanYBCeeXvgWKrKLp8F66pH6gj/sckw0+qh1RI/6ec9g8eOpO9AgDpmcctgVJRXnWBBWP4QasE4ZRe1y1wpvuxE4zCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+2lHvAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD9C4CEED;
	Wed,  3 Sep 2025 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756863541;
	bh=zOeJ5ngI5GgY1IUOwe+4owS6Ud/kOULo7zVSgkL3p5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z+2lHvAWCl/vO+TD/GRYZ9XtoEazhN/pB71rceWYow23uHBN1fB1jPi5jB706VZEc
	 nNN69N2/v5o09ABUe26G9HN2Nt7RwNncmLFrsYtZzl9BU3EFIlJNgRy35IzG0iP9XR
	 rGL4ClS6Yheul2bjqvaK+musBTCTdwTkFjB3JQq0dmjgdFL/82THwQilqMIboxMA8M
	 TnJl0fbrJe8tjkcHJtN0YM9XEr7T3L0Zr6jWQU8n2m4k6Nqe+OVgHXqJ6YNSX+Ft2c
	 Bf+3u68972YE44fB0dbAbw39K/JGl3Yf3gytBwHNJLJplH24BgwU8PfsrQcagdJB3D
	 VLObaZ/NtlyaQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cf8280f02so6949972a12.0;
        Tue, 02 Sep 2025 18:39:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMa/o0Fw8zbcI/SRoVxVMGap76FqAjW7t1TEQbg6z1FoXlCsMQ52LsfH/c+JO/WEM9eeReVlHaH3+X@vger.kernel.org, AJvYcCWUb5r1BVfdSMeLm9UDcuYrtwxTiDWQ0dJpyAGHI39rjsFqPtUSFpErMwgEatJ61VnNE9p0FP2TOz5FCQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZE4q6bc8ycQ9GXh0neOC+BcqiTusKnFyZrJ+3TjzP9THJKOz
	FAeLt4zvfT0/h20/r53HtGCOx5+qzACKckTsrESdjT9Qup6UrGgi/ZhjWlt5+hyGTjQrcyPR4gR
	XW04Qyw1ZXBegN6suc/xYtkjFzji3bw==
X-Google-Smtp-Source: AGHT+IFptbMpMMT2D9FRexdLPIqSHrJPMLwelNoD7hUYbe5eOkeTndk6fldDic2MqA1Vki3qonEvJQY7U6OrawKIpS0=
X-Received: by 2002:a05:6402:42c2:b0:61e:d636:5815 with SMTP id
 4fb4d7f45d1cf-61ed6365ademr1443549a12.24.1756863539897; Tue, 02 Sep 2025
 18:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902151543.147439-1-klaus.kudielka@gmail.com>
In-Reply-To: <20250902151543.147439-1-klaus.kudielka@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 2 Sep 2025 20:38:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvF12GZfoZVdHaOxn9uH3axnUT0dHJtD13EQv1rtxQ1g@mail.gmail.com>
X-Gm-Features: Ac12FXxUo1lmvvhdHtzI1m4RbTesfMH5DhqHLkRQGu05jSBfxV6er8SVWtO9ixw
Message-ID: <CAL_JsqLvF12GZfoZVdHaOxn9uH3axnUT0dHJtD13EQv1rtxQ1g@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Fix the use of the for_each_of_range() iterator
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>, Jan Palus <jpalus@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:17=E2=80=AFAM Klaus Kudielka <klaus.kudielka@gmai=
l.com> wrote:
>
> The blamed commit simplifies code, by using the for_each_of_range()
> iterator. But it results in no pci devices being detected anymore on
> Turris Omnia (and probably other mvebu targets).
>
> Analysis:
>
> To determine range.flags, of_pci_range_parser_one() uses bus->get_flags()=
,
> which resolves to of_bus_pci_get_flags(). That function already returns a=
n
> IORESOURCE bit field, and NOT the original flags from the "ranges"
> resource.
>
> Then mvebu_get_tgt_attr() attempts the very same conversion again.
> But this is a misinterpretation of range.flags.
>
> Remove the misinterpretation of range.flags in mvebu_get_tgt_addr(),
> to restore the intended behavior.
>
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for pa=
rsing "ranges"")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220479
> ---
>  drivers/pci/controller/pci-mvebu.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Thanks for debugging this. And the code is further simplified which is
even better!

Acked-by: Rob Herring (Arm) <robh@kernel.org>

