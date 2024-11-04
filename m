Return-Path: <linux-pci+bounces-15995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E4A9BBE90
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66616B210AA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B91D47C6;
	Mon,  4 Nov 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0AT79Pf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64D1D3584;
	Mon,  4 Nov 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750892; cv=none; b=W3FUfmCU+u27uPLaazB+Czwey/Siygt/9bgaBX/7ITwZs+YaEuDR6o1xyhCtBH0Cw9vh/vv2sy8mHmK+KpT4q/IX+eKaJ3K/qAkVZbfAxoArvUoAdQyCCjNLOmhJ0YHRxIrfBs+Z6dEvQ1XLO1FZijzuVuPSz2XNDzIuHgeDysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750892; c=relaxed/simple;
	bh=TCc6q0r6R2I3lfF3roUErekicEJi1K6wwJhVId853bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIULSDkmAlSrmMM/RPAlErkftEdKpT9JrapTNCLlH3qx3j7o9XYjrsPX8Ovlk229EIgB6FcM8KY1PT9J3P0T8LOxoxiKtMj4Y6phW5cE5PXXhhs694KaM8Pv8JgXn3c++qnQJKFGhf/EYjKG/bHYASz8YWTjkNot4ue6LM4fYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0AT79Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8476BC4CED3;
	Mon,  4 Nov 2024 20:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730750891;
	bh=TCc6q0r6R2I3lfF3roUErekicEJi1K6wwJhVId853bI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0AT79PfUf28tiIMvK55WHHk0pLB28CljVMZLi7qQ4R5/ylSQBHATDJw2iFFXdCQM
	 JmAQmLmxnawPkElkY7ZnGvOoSwI40TEskLnhElhmgkQN81Hg+alOv2S4d2X6Vrb7Ek
	 uF7KawDsrPf6pcijbuJlP7we4zdClt1zheLKkyjjlDd+tlhPxtwJGucnYJyJlqZ+0H
	 jdW/mWvJXugvLIaZjuFnUXp4CMbAyoHKIMPwPyTu9iSUwrFkICRwR+86Yr5qBHWNBY
	 a8jHsvVuFzbVIdZWzF9aKYFb/j0U5GkSHC0bR+38KTWOmY9QCSk40MStRyM8Kddqdo
	 2gadmStMKJP/g==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2918664a3fso3747912276.0;
        Mon, 04 Nov 2024 12:08:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB4pB9J0ikBd17RwifEb7236DOPfiX9/Gk2Xf0ldgkmgSdnoxLELNgX7ez+zQ96PeLHn3RsX6V2oXT@vger.kernel.org, AJvYcCWySC7LD7wnyyBZ3Wxc0rGSwWvbggPjwmX9s6POf8OTPYuX0Mpq6wSXs6YKrmDrEohZWceK24SRyTu2@vger.kernel.org, AJvYcCXj9p1zcjLhdbS4ZMVAxOtoGA8FoxNsG64eRUnTcsm7KFtzibZ7Xd64mbj2AT/1hyKYW20/Lxc+WAnPSK9g@vger.kernel.org
X-Gm-Message-State: AOJu0YxraPVyPBbsy1EjOofO22vja/yA+OEXckICvKsFf7AbehFq7tkm
	HQHm1URDy2LF28nwhlD1Czb+OAIirAZsgNGE6vvcfOo7luQ6ZlCk1H9r1EbHQoKU6WeWa1uUKcF
	FSQT0EOQ+Hi+EA5WY0xWOimRmZA==
X-Google-Smtp-Source: AGHT+IEegWBSU4UaiamoYZRLNH8nzU5B12KegKBqnGVD3vUbTADxvokr0VHAW4SMlprBSwtMRdM8g620lENv+7sc3Lg=
X-Received: by 2002:a25:ef46:0:b0:e29:689:f47 with SMTP id 3f1490d57ef6-e3301755cc4mr11321546276.6.1730750890545;
 Mon, 04 Nov 2024 12:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104172001.165640-1-herve.codina@bootlin.com> <20241104172001.165640-6-herve.codina@bootlin.com>
In-Reply-To: <20241104172001.165640-6-herve.codina@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Nov 2024 14:07:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLd1YezwczSsE7vFjxQ4C5VHQaG4nL3OTXA+QcXX+pxqw@mail.gmail.com>
Message-ID: <CAL_JsqLd1YezwczSsE7vFjxQ4C5VHQaG4nL3OTXA+QcXX+pxqw@mail.gmail.com>
Subject: Re: [PATCH 5/6] of: Use the standards compliant default address cells
 value for x86
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:20=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> The default address cells value is 1.
>
> According to the devicetree specification and the OpenFirmware standard
> (IEEE 1275-1994) this default value should be 2.
>
> The device tree compiler already use 2 as default value and the powerpc
> PROM code also use 2 as default value. Modern implementation should have
> the #address-cells property set and should not rely on this default
> value.

It's a mess.

Relying on defaults and inheriting from parent nodes in dtc has been a
warning as far back as I could trace (2005-2006).


> On x86, an empty root device-tree node is created but as the hardware
> is not described by a device-tree passed by the bootloader, this root
> device-tree remains empty and so the #address-cells default value is
> used.
>
> In preparation of the support for device-tree overlay on PCI devices
> feature on x86 (i.e. the creation of the PCI root bus device-tree node),
> this default value needs to be updated. Indeed, on x86_64, addresses are
> on 64bits and the upper part of an address is needed for correct address
> translations. On x86_32 having the default value updated does not lead
> to issues while the uppert part of a 64bits address is zero.
>
> Changing the default value for all architectures may break device-tree
> compatibility. Indeed, existing dts file without the #address-cells
> property set in the root node will not be compatible with this
> modification. Restrict the modification to the x86 architecture.
>
> Instead of having 1 for this default value, be consistent with standards
> and set the default address cells value to 2 in case of x86.

I prefer the default to just be wrong. My intention is to get rid of
the defaults (at least for all FDT, not OF) and walking up parent
nodes. My first step was to add warnings[1] and see who complained.

The base tree needs to be populated with #address-cells/#size-cells.
I'd be fine if we say those are always 2 to keep it simple.

Rob

[1] https://lore.kernel.org/all/20240530185049.2851617-1-robh@kernel.org/

