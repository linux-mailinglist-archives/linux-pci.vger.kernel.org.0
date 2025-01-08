Return-Path: <linux-pci+bounces-19562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D00A065DB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 21:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A56B7A2815
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 20:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0C203705;
	Wed,  8 Jan 2025 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd7GMc2u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6F1CDFD5;
	Wed,  8 Jan 2025 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367297; cv=none; b=CcWsr4u2IKCqWdWDKKIduDOO78C5MGdu7ELQUHSgUNB/9GgslMaWSC5KKcdlq/fJMdu7c0hjAPcvOZBe4LmUAMZhY2Zhz8ewOQBl+e3ji3O/ijclGx6UU+GCz0ccjzrSEJ3ZGZmHOBKkVw01HAWjloD/SpP1T5AO6Olk3jp3isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367297; c=relaxed/simple;
	bh=Ua7qCRnIdG3hmytoaFkfllP3/chUnEB0dgIQoQS8kzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=si15Rwuja0NUyflT5jC8Up8Hl28rmoM0Hh3Cgxo+fcWXan75h+N5yCoNB1iv1+VrNquVPL7qBwaEqbHH4BN2e6py/Pt7s3kaMK08zrFiT9X+7dx817pJieFgke4EGiLzA4AZ2ejyVfFh7dHD5ccLhLc02jXK48mXvrWNt3ta3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd7GMc2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FA7C4CEE6;
	Wed,  8 Jan 2025 20:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736367297;
	bh=Ua7qCRnIdG3hmytoaFkfllP3/chUnEB0dgIQoQS8kzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rd7GMc2uCCu+IjRTkuUwzFuPoAWlHKopRH1Vp+ACW6D7yX8oS3bTi7T2DZWWWO31v
	 4yXqyq132S3FkUjdh/iS93Zv0U0CTY3itxA9EPtDetka27RwzDzhSPr928vvqovxx2
	 FNMpIygg5aQOA4TUV6ju0mnycJ5ZWedsZDj16zn/PhABCWvnB3jAUVGqLWFiG9Sg86
	 /PVCHtzb84aiWKDaoBn4g6JpecbK74Ub+9dcCGFs5AVopwTnpRMnhaauDbhvU0k7v4
	 U0qztnt44AXsWERVKPu74fjf/lolHldiHcon2EmuALyEyDPLVgsV/DQ5dlO6Ux0tr0
	 MWQwhsNUL+kTA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e2851de95so60708a34.0;
        Wed, 08 Jan 2025 12:14:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEXRj7apQMib+hv0tSsdbBen0y1t1KURqDjUtMmOAGR518Cp+Cu9WwC1EK+Y+3D1MHpaaTVeFJt+M=@vger.kernel.org, AJvYcCVAC1Nkg9L9opHyNnZ+4t7VpxuWzWABgGjkayBIJyk6nzgIGRUjmjYct7kbUViLlE5DRlynnSyG6ZT9j+w=@vger.kernel.org, AJvYcCVayhMB5KSqt4+Nho2vAHusl1VUxxugsKEdUU/B4Hmf/Wn8ywZhzizli4LPc7Lw6dtMrPEftMRb@vger.kernel.org, AJvYcCXqqfKs9V4OieqAgwihpVzcFSZUFhiqyRW5bEhn/U5mWsIIqLga43pJ12DxjonGOsofaAnyxOL2eCXW@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJzZuGmHnlUpaY46/yrNTqOQSmF/RjxrcAVlzKoei0yFJTFDF
	wuKj/dbC+uzvvDx9ZLeSa2pJMBvfUtqmYBd1r2c/r3rHUIwFP9c9SLF/DMxUasQLlZp93YpYnly
	Qy9SlpVzrjTshvq/5gOSV5QWy6rM=
X-Google-Smtp-Source: AGHT+IEJ6ZCM0xH7ApaImZgmkmPMqedL5/cx0LDtjmmm4+npctXzmAuEOTamSduOQiG4Q8vsu7bgN9wClgxj+DFdXII=
X-Received: by 2002:a05:6808:3a19:b0:3e5:f06f:653d with SMTP id
 5614622812f47-3ef2ed01adbmr2904751b6e.22.1736367296268; Wed, 08 Jan 2025
 12:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c634d5bc-7a60-436a-94d8-c8a4fb0e0c26@gmail.com> <20250108195109.GA224965@bhelgaas>
In-Reply-To: <20250108195109.GA224965@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Jan 2025 21:14:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jVB9mTqUJ+66q_nSm2ULiDFO6Fmfpt3Q=wLSKsQXRewA@mail.gmail.com>
X-Gm-Features: AbW1kvZg6kVFf6IFOj0P0AjXh1Z82TEBJgWsEzBLjxp5ykDU9UZPz4qLPq8vQH0
Message-ID: <CAJZ5v0jVB9mTqUJ+66q_nSm2ULiDFO6Fmfpt3Q=wLSKsQXRewA@mail.gmail.com>
Subject: Re: [PATCH v2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, M Chetan Kumar <m.chetan.kumar@intel.com>, 
	Loic Poulain <loic.poulain@linaro.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:51=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Rafael, linux-pm because they *are* PM experts :)]
>
> On Wed, Jan 08, 2025 at 02:15:28AM +0200, Sergey Ryazanov wrote:
> > On 08.01.2025 01:45, Bjorn Helgaas wrote:
> > > On Wed, Jan 08, 2025 at 01:13:41AM +0200, Sergey Ryazanov wrote:
> > > > On 05.01.2025 19:39, Maciej S. Szmigiero wrote:
> > > > > Currently, the driver is seriously broken with respect to the
> > > > > hibernation (S4): after image restore the device is back into
> > > > > IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and =
needs
> > > > > full re-launch of the rest of its firmware, but the driver restor=
e
> > > > > handler treats the device as merely sleeping and just sends it a
> > > > > wake-up command.
> > > > >
> > > > > This wake-up command times out but device nodes (/dev/wwan*) rema=
in
> > > > > accessible.
> > > > > However attempting to use them causes the bootloader to crash and
> > > > > enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "=
a crash
> > > > > dump is ready").
> > > > >
> > > > > It seems that the device cannot be re-initialized from this crash=
ed
> > > > > stage without toggling some reset pin (on my test platform that's
> > > > > apparently what the device _RST ACPI method does).
> > > > >
> > > > > While it would theoretically be possible to rewrite the driver to=
 tear
> > > > > down the whole MUX / IPC layers on hibernation (so the bootloader=
 does
> > > > > not crash from improper access) and then re-launch the device on
> > > > > restore this would require significant refactoring of the driver
> > > > > (believe me, I've tried), since there are quite a few assumptions
> > > > > hard-coded in the driver about the device never being partially
> > > > > de-initialized (like channels other than devlink cannot be closed=
,
> > > > > for example).
> > > > > Probably this would also need some programming guide for this har=
dware.
> > > > >
> > > > > Considering that the driver seems orphaned [1] and other people a=
re
> > > > > hitting this issue too [2] fix it by simply unbinding the PCI dri=
ver
> > > > > before hibernation and re-binding it after restore, much like
> > > > > USB_QUIRK_RESET_RESUME does for USB devices that exhibit a simila=
r
> > > > > problem.
> > > > >
> > > > > Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which =
uses
> > > > > the existing suspend / resume handlers) and S4 (which uses the ne=
w code).
> > > > >
> > > > > [1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786b=
debb@leemhuis.info/
> > > > > [2]:
> > > > > https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-18=
04139413
> > > > >
> > > > > Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > >
> > > > Generally looks good to me. Lets wait for approval from PCI
> > > > maintainers to be sure that there no unexpected side effects.
> > >
> > > I have nothing useful to contribute here.  Seems like kind of a
> > > mess.  But Intel claims to maintain this, so it would be nice if
> > > they would step up and make this work nicely.
> >
> > Suddenly, Intel lost their interest in the modems market and, as
> > Maciej mentioned, the driver was abandon for a quite time now. The
> > author no more works for Intel. You will see the bounce.
>
> Well, that's unfortunate :)  Maybe step 0 is to remove the Intel
> entry from MAINTAINERS for this driver.
>
> > Bjorn, could you suggest how to deal easily with the device that is
> > incapable to seamlessly recover from hibernation? I am totally
> > hopeless regarding the PM topic. Or is the deep driver rework the
> > only option?
>
> I'm pretty PM-illiterate myself.  Based on
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/admin-guide/pm/sleep-states.rst?id=3Dv6.12#n109,
> I assume that when we resume after hibernate, devices are in the same
> state as after a fresh boot, i.e., the state driver .probe() methods
> see.

Well, yes and no.

There are two kernels involved in resume from hibernation: the restore
kernel that runs just like after a fresh boot except that at one point
in the boot process it attempts to load a hibernation image and (if
loading the image succeeds) jumps to the other kernel instance
included in the image, referred to as the image kernel.

For the restore kernel, devices are in the same state as after a fresh
boot (generally speaking, with some rare exceptions that are
irrelevant here IMV), but for the image kernel, they are in whatever
state the restore kernel has put them into.

> So I assume that some combination of dev_pm_ops methods must be able
> to do basically the same as .probe() to get the device usable again
> after it was completely powered off and back on.

Yes, but if the restore kernel has a driver for the device in
question, it may as well have initialized that device already.

In that case, the image kernel has much less to do to get the device
to work again.

The caveat is that the image kernel doesn't really know whether or not
this has been the case.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/driver-api/pm/devices.rst?id=3Dv6.12#n506
> mentions .freeze(), .thaw(), .restore(), etc, but the fact that few
> drivers set those pointers and all the nice macros for setting pm ops
> (SYSTEM_SLEEP_PM_OPS, NOIRQ_SYSTEM_SLEEP_PM_OPS, etc) only take
> suspend and resume functions makes me think most drivers must handle
> hibernation in the same .suspend() and .resume() functions they use
> for non-hibernate transitions.
>
> Since all drivers have to cope with devices needing to be
> reinitialized after hibernate, I would look around to see how other
> drivers do it and see if you can do it similarly.

This generally is good advice, but if the platform AML is defective,
it may not be sufficient.

