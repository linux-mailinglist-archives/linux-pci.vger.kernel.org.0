Return-Path: <linux-pci+bounces-37213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6CBA9F98
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D792F4E1E25
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1FF30C630;
	Mon, 29 Sep 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1dUyX8h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15726309EE8
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162376; cv=none; b=hL1UwKjKUcOcDBcEhpgoniWOFgIR3E03Zz05fPzkRCGJ9El1PLgx606a63gWZcqjUxzxxdYq5MmeCJsLLj3FKQ5NIj3p4SOwfuWVV6qIRPeL65MAFZ6dqmclUG2xvY5IUl0cJlfePY2pLVbHHAQr+vWmv+8u1tfNTNfULQcutFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162376; c=relaxed/simple;
	bh=Tg4GHAGSujxf07p3BKLBHupxzDzRxA4YhwnGHXjIWqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDehnHMVhVaE/V5/Iabpe2nVFYRbo3hjXsp114v0iNIpBofBZkebRSYAR1OzZr4pmEgji/itYRWLCyUbvVCz2qBJ5ezeq7U4sfBt7Tn9JQeN9MeQWUJyJjU9Roy4wZExCTpTBNPj92SF70ZYgo7AhjM9xbaezQLoKvvFCjNyL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1dUyX8h; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso1667313a12.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759162372; x=1759767172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKbIiyOJGnPtewg2XGQmyuDm4Je77/TR9Lj2L/HdtYA=;
        b=c1dUyX8hhJSYyGYODEZJNq541ZKuCw/Gdz7nPQEv/xxNam6/fqe07/DWYBL7kEC3dD
         EXqzZlE7dPBQT5g3rtAqSJGV1ZiYvgc4lu7IV7GLHHj0kZIjYjIQSF4+9/KP0y2QWiuP
         2LlFfSPu6WtLuvy7qDyG76i9nDVWNA7cnKynvmukfpOJvIIZUDWmmnAZp0agIUq5QyCC
         hnjK7f8n0iWjotqiwEQGMwem5PD+yZU/1fcJQDuJQ9b6lYc5A1QfMFc0qLbv7K1w0r/N
         4gPJW1+MriX792QkKWGr934qmGWJ8fYrUHeg/W07ZQfr6JScdZAQCW0o6H9jxFoka5BT
         iJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162372; x=1759767172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKbIiyOJGnPtewg2XGQmyuDm4Je77/TR9Lj2L/HdtYA=;
        b=n5oAfD7y/DVlBz9Sk6rkDsjAbM4E62E1MqHniA66VC6K8+2qauARaIwfU/obboqspU
         Q2SY1EUu5U7mp9SmNJT7uJ5pLfXP5H738aGPQk95Li1ZXESL4lxsU7/xV8DegFzEsi5z
         AYH5uPJCjr3aQS9FRhkv9BmjyZtDo6wKBZgSAfdh44Ce1dufr15lJZ4UpTyhwNWcqian
         sIJLtm1ZYYsRHuofcNXig1l4oC+venjzKYHFJ9uT67H+ZQWu5/cr/OyMxox6WZXE3UMl
         j74lfQ053GWzEKcFHYZOGKRpAksThfxATSRFHOuv/og7EKLq1NSvtGXatpPD0Z/ZxiM5
         jvAA==
X-Forwarded-Encrypted: i=1; AJvYcCVHDXzJsRK50mnTImSAig5cAh3y12WoSPERvu/cInJSdP90XFlW22TqWarsO9kiA447JifduHm8BNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxcFva54+tebSrwrr9kFLeZ5DaDc4hFScsQdttLA0lIHq/X5e
	L263LEAV/BLNeAqjnXLHqzPWBlwHkPLfx4YeBykkM42jQQPiYMU9kKGstxQ0knErfVqH6FNgzXu
	rnxu1kIFpCrzdqH0MXsN4HeYYb9PG6nM=
X-Gm-Gg: ASbGnctOJvDUox3hfNz2mwnukpq60U2M6kPhKO8nGZlfWqY8sVWO+LuAIiun6YSZwD/
	HGDIh0B1Z99hT1mVnc5nS0C/2ROEBMf9mYcBpdNlhYnOAkI8gb7YMbUGb+0FmyTuWqpdZ6z9H7D
	aXxtbCBsoIGiTQ+iYEIGlJbwPST83zq+gpwIX6s73AMHMkF/jroTwel6wlEo6lCQ9zIAIcdMNK/
	zz6HLV8+iz2fVBi
X-Google-Smtp-Source: AGHT+IE0lqGvuA/Xz523aRKIL9hmjXUK7+0u8AEeVGECM/7avOtLvinLYTseWMgOs08RG2BDuA8KXOfxxvlTzVs/fE8=
X-Received: by 2002:a05:6402:3508:b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-6365af5adecmr1127595a12.18.1759162372397; Mon, 29 Sep 2025
 09:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-3-linux.amoon@gmail.com> <aNbXdFPrDr8V2a+1@lizhi-Precision-Tower-5810>
 <CANAwSgT3inDQZ40uFtXwFze2m4hZUvnyKTek3PQ9jb6picgi-A@mail.gmail.com> <aw3flahx3g4exezj5245cgrixasshvf26yibctxsd3l42ygwke@equdzipwspvx>
In-Reply-To: <aw3flahx3g4exezj5245cgrixasshvf26yibctxsd3l42ygwke@equdzipwspvx>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 29 Sep 2025 21:42:35 +0530
X-Gm-Features: AS18NWB4VW7y7yX6xXK-2yBG9rF9CezN0Xp1TVzzbBM3LHGAaoA03PQWsyQH6Vg
Message-ID: <CANAwSgR-sq_jRp7ZQyWxrW_o6vRnCsu7FW77odDzY5xPcMuwEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan, Jon,

On Mon, 29 Sept 2025 at 19:31, Manivannan Sadhasivam <mani@kernel.org> wrot=
e:
>
> On Sat, Sep 27, 2025 at 11:20:10AM +0530, Anand Moon wrote:
> > Hi Frank,
> >
> > On Fri, 26 Sept 2025 at 23:42, Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Fri, Sep 26, 2025 at 12:57:43PM +0530, Anand Moon wrote:
> > > > Currently, the driver acquires clocks and prepare/enable/disable/un=
prepare
> > > > the clocks individually thereby making the driver complex to read.
> > > >
> > > > The driver can be simplified by using the clk_bulk*() APIs.
> > > >
> > > > Use:
> > > >   - devm_clk_bulk_get() API to acquire all the clocks
> > > >   - clk_bulk_prepare_enable() to prepare/enable clocks
> > > >   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in =
bulk
> > > >
> > > > Following change also removes the legacy has_cml_clk flag and its a=
ssociated
> > > > conditional logic. Instead, the driver now relies on the clock defi=
nitions from
> > > > the device tree to determine the correct clock sequencing.
> > > > This reduces hardcoded dependencies and improves the driver's maint=
ainability.
> > > >
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v1: Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() with
> > > >       fix clks array.
> > >
> > > why not use devm_clk_bulk_get_all()?
> > >
> > My RFC used this devm_clk_bulk_get_all() which could work for all the S=
oC,
> > However, Jon recommended switching to named clocks, following the
> > approach used in .
> > but Jon suggested to use clock names as per dwmac-tegra.c driver.
> >
>
> The concern was with validating the DTS files with binding. Since it was =
in .txt
> format, validation was not possible. But you are converting it to .yaml, =
so you
> can safely use devm_clk_bulk_get_all().
>
Yes I would also like to use the previous approach.

> - Mani
Thanks
-Anand
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

