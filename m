Return-Path: <linux-pci+bounces-42324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BEC94FB8
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 13:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D633A37CE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442FA1C84B8;
	Sun, 30 Nov 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gww/dvdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE61E3762
	for <linux-pci@vger.kernel.org>; Sun, 30 Nov 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764507340; cv=none; b=GzHQbe75AU2nrFuTDHS/eDJgWXzfTm94cIUUtf1KP2mhN49CZncu4QGItI252EWexj8kCRfr5tly9E2TJk8LD8HMMPpUGsJv5g2XkpEv2LJroHeIifbpFIGj52DCjNHra4tCSW/GH3eyfUFFPFTTEPZ6WivOt/FI8OJlTRH3dOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764507340; c=relaxed/simple;
	bh=+CUU91VE9U+UPRFztWIsw6a0HFlxr+X7N2lteq6FDVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cM6PXtcmvrV7imIicuRUJNSoOngTWeGvIyF8FtsgcILFsgiCmgwIgFBzxGs7iGVQpJideUWMMFVvuMFJF22GOfU9DkyaJOTSXKWvGwSM5CclaGgN+g00EyNBTpW/3ub+fd8vSJAwbQov96OEo5IJj4CLyUz0uXZaJfpioZeUyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gww/dvdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A76C2BCAF
	for <linux-pci@vger.kernel.org>; Sun, 30 Nov 2025 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764507339;
	bh=+CUU91VE9U+UPRFztWIsw6a0HFlxr+X7N2lteq6FDVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gww/dvdD+675GJvFeEUzoJ9+9j1fimzRlqZN4XMYb6eQ22Y67C+MtVRScVEvjgMj1
	 ZpYvL+nwB2pztVPvokl4UbEkKUzonZlmU5BFppJ+9Lj4kIxmWwfdBjPYKKj54W7re6
	 pCCNXn8T8DUMXZbwGdNQTa6g0p5S1DYOA0f5Hfr506b7n58qIcvUcbv8I+2GP1lQr/
	 zN1r7Jpu0BI8REbIRc1G32Hi5dMOEcFzmasdNLVlXuv3R46/uzyCsVukiB757JeGhN
	 2uDujYZ14AcjgVrLFPsqEQlrLMsGQFouXavU4LbUHBbzAin4+3g/0GH9NV7GhWXo1f
	 wmvNB24EyWnFw==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c76f65feb5so2452554a34.0
        for <linux-pci@vger.kernel.org>; Sun, 30 Nov 2025 04:55:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNZubFZtTpmomijHade822xvtLrl6rPWyvQH833JM3e79TM1OB3H1yD+ryqrGQU1ODoI2e22vxxYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGx/Z1CQdoehXcdIY2NRaJ8lRc6XVTiFAXRih9mGTfgoj1L5ig
	BFrkZ8Bx/wG7w3Th2xPNvxZsjKwh1qo8sFiDe4VGZzXRtpC1KorY9KF5sVRckumuQ1p5lvAmom3
	WT+JynIe0Sefusu4rr893yEdGUv9mqZ4=
X-Google-Smtp-Source: AGHT+IGgWthYmyiiRHTuIz/8bWmUoFRUwbcURTcZh3qG98AznU0lJvk231Fz5Su9DD5JkuIHGit6aHtLEtrfKZseF8E=
X-Received: by 2002:a05:6830:924:b0:7c7:dff:2ac1 with SMTP id
 46e09a7af769-7c798b8a7dbmr18909653a34.3.1764507338846; Sun, 30 Nov 2025
 04:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-thermal-device-v1-0-bbdad594d57a@gmx.de>
 <CAJZ5v0jOPrBcozzJMsB1eE12MuZRWDAV-+=jfrhJbi=S0p5J9Q@mail.gmail.com>
 <5f3ef610-4024-4ca0-a934-2649f5d25f40@gmx.de> <CAJZ5v0iJVV=kf-aJBx8F8dtGfaZpGVyhfi6DBWEg4j3c_nH8_A@mail.gmail.com>
 <e360b9b3-ada4-4cd1-8971-097484cf3f5f@gmx.de> <CAJZ5v0ij_Frdrya3=FaekbU2DFHUyBJnBq-oe9jRsB9eqXDisA@mail.gmail.com>
 <ed619280-6f25-4df6-98ca-890bdc343435@gmx.de> <CAJZ5v0hMPCRU_p_krX3nKzB=5TX7hGU38iyNmhSJSHO2j7K3eA@mail.gmail.com>
 <de14f2c4-e7b3-43a1-a9ee-9caba196b0f5@gmx.de>
In-Reply-To: <de14f2c4-e7b3-43a1-a9ee-9caba196b0f5@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 30 Nov 2025 13:55:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h3=9V8FFehyaPiG2SreRgeyvKK+oAkR_gzKQQNDBmczQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm74BLkYigBlEZwhgK9orhm-MSGQUfAzuwxqXDI_Qt7_9TxZm-rm-hXNS4
Message-ID: <CAJZ5v0h3=9V8FFehyaPiG2SreRgeyvKK+oAkR_gzKQQNDBmczQ@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 0/8] thermal: core: Allow setting the parent
 device of thermal zone/cooling devices
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Len Brown <lenb@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	ath11k@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:36=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 28.11.25 um 12:40 schrieb Rafael J. Wysocki:
>
> > On Fri, Nov 28, 2025 at 12:50=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> >> Am 27.11.25 um 22:46 schrieb Rafael J. Wysocki:

[cut]

> >> What do you think?
> > One advantage of using parents is that it will help user space to
> > figure out connections between the abstract cooling devices and the
> > associated hardware or firmware entities.  I think that this is an
> > important one.
> >
> > It also doesn't prevent fwnode_handle from being used because the
> > fwnode_handle may just be stored in the parent.  I like this more than
> > associating fwnode_handles directly with abstract cooling devices.
> >
> > If the cooling device parent (that is, the provider of the cooling
> > mechanism used by it) does not have an fwnode_handle, then either it
> > needs to be driven directly from user space, or the driver creating a
> > thermal zone device needs to provide a specific .should_bind()
> > callback that will know what to look for.
> >
> OK. When sending the next revision of this patch series, should i also ke=
ep
> the patches for the thermal zone device or should i only keep the patches
> concerning the cooling devices?

The cooling device changes are kind of unrelated to the thermal zone
device changes, so it would be better to send them as separate series,
but you may as well send those series at the same time as far as I'm
concerned.

