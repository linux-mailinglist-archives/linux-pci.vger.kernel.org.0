Return-Path: <linux-pci+bounces-19563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69EA065E7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 21:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB711668A4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 20:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E6201278;
	Wed,  8 Jan 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRU7AluD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F51ABED9;
	Wed,  8 Jan 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367455; cv=none; b=DGywlHJmGZgB0OQURLR5REKRDR7nTvTriwwIjMQ0ZRi8UW2DI3nDPP7B53vV51oP+QEsKigX2+CC21AGwwO1MheB2jyjgbtCGBo72MRPZ/EMXN6qBWGGWVQh1t0eg5xGjZSVaqMFZwpCKFt/Ufn8+f5/Yg2V7mCWHNi7u/4vUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367455; c=relaxed/simple;
	bh=UlgTK6XXpvluotnBKDkjwi0TZYFkb2Dlj6TuK9B304w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDSuHjNOguXd2QRCsL0ksoT++bkyVkTvDUMX5kORm7jMXnkhwq6shHH9amyxhJUGCKpK/VK/rmOe7Ip8cX1+lXTsigGlXFcOd6HFK+JI+gXbjgtL4IIJ/cJ/OkC91SbAdhTT1Lh4ZHDuw3Qbg68b7aTbQulmDRyAXj4ZSlpUKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRU7AluD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08AAC4CEE3;
	Wed,  8 Jan 2025 20:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736367454;
	bh=UlgTK6XXpvluotnBKDkjwi0TZYFkb2Dlj6TuK9B304w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LRU7AluDokzSuJcYlUJ04Z/1hmAtfR1t4PWN4RRNIYzKNxqsy7ilE1gmCwIW94uU0
	 UQTYzqHtffbpPUKaLxQCSkpMxDeYDv2v+jNEtDQScUPKM9WbOUSbu8xRR9eapZUQDx
	 ySIikwWWmsoNArljEdyJU6+ViM+RMzuJW0+NRQoy6hWACY8I0Q9XHVfTIDCHRZtwzm
	 /oLSVKWCWykXq78lk3NoDiWrYq+H7I+KhpwJZ/oI/NYM+lQq5P0Wo2uo3/3OxPEsLg
	 +d3M99SBSpLHW8i/dq8tEOkVjpqbgPMNvGTqcgRKe1y0lMwU03CFExRPkgNa/YWUOT
	 yUnr/um7UwkEw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb98ad8caaso94532b6e.0;
        Wed, 08 Jan 2025 12:17:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBs2bkiEOY2VGMnxK1yAAOHws3b4vGoDAmA0d3AP2xqZlK8wzlFT3oFUaHLGWUSAdEc0rsEHmrjrZe@vger.kernel.org, AJvYcCW9pyRoefqJVQarBjSArCu6uPbxLUzzx1ii7lXv3mVleRkfPAZ2rlYI1RjImC2wkbq93mNsGGsZqCY=@vger.kernel.org, AJvYcCX0d4Ny/j/eA9+vDqSd9XQ7mU9anVkgGFb73T9HaDxs52Cjak/fe/Tngc4FPDPEbjkodeLEF+bim7Bjouo=@vger.kernel.org, AJvYcCX66eY5Knfmpk2TyivDb1h2l4wS7xn6tcItI3ta8l0Pom2Mk5F+frB5HAAD8pZLc9NsxG8mbcl4@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFq9C7ARfS5bhqCL68GYNvWsX8yX4vgoBXpw6FeXaDiw3qA5P
	SDeRR0yZXgXHbBXiHUY7Tn2xQ8aR34sIUOUjBaqLS3IuCEOcrPfk7uKy9UdOU9VRHYk8l3/HcKS
	nnUSUiwLlbQiBfOlOXKW6R+6Kl0g=
X-Google-Smtp-Source: AGHT+IEw/PzHhdF6IgsucKtmOsoDyttO+mPdlNlL3UfSQrxrUcj5eDyOlltm4BmxG5Ru2EM6tN7I+xCkIIgATDlO+Xg=
X-Received: by 2002:a05:6808:2390:b0:3ea:4140:e7cb with SMTP id
 5614622812f47-3ef2ec247camr2596731b6e.19.1736367453986; Wed, 08 Jan 2025
 12:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108195109.GA224965@bhelgaas> <5df4a525-dc5d-405a-be07-5b33e94f5a4f@maciej.szmigiero.name>
In-Reply-To: <5df4a525-dc5d-405a-be07-5b33e94f5a4f@maciej.szmigiero.name>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Jan 2025 21:17:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hU8=h2QLQ+JDoTb28uWFH=r=PsCSGjgs+Mv4_ax-rrAg@mail.gmail.com>
X-Gm-Features: AbW1kvbRuludeoCmOjsiURSDpPSzmUa9N5nbCBtd5ayGk3nayhkynaraDOaJ8ks
Message-ID: <CAJZ5v0hU8=h2QLQ+JDoTb28uWFH=r=PsCSGjgs+Mv4_ax-rrAg@mail.gmail.com>
Subject: Re: [PATCH v2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Bjorn Helgaas <helgaas@kernel.org>, M Chetan Kumar <m.chetan.kumar@intel.com>, 
	Sergey Ryazanov <ryazanov.s.a@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 9:04=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 8.01.2025 20:51, Bjorn Helgaas wrote:
> > [+cc Rafael, linux-pm because they *are* PM experts :)]
> >
> > On Wed, Jan 08, 2025 at 02:15:28AM +0200, Sergey Ryazanov wrote:
> >> On 08.01.2025 01:45, Bjorn Helgaas wrote:
> >>> On Wed, Jan 08, 2025 at 01:13:41AM +0200, Sergey Ryazanov wrote:
> >>>> On 05.01.2025 19:39, Maciej S. Szmigiero wrote:
> >>>>> Currently, the driver is seriously broken with respect to the
> >>>>> hibernation (S4): after image restore the device is back into
> >>>>> IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and ne=
eds
> >>>>> full re-launch of the rest of its firmware, but the driver restore
> >>>>> handler treats the device as merely sleeping and just sends it a
> >>>>> wake-up command.
> >>>>>
> >>>>> This wake-up command times out but device nodes (/dev/wwan*) remain
> >>>>> accessible.
> >>>>> However attempting to use them causes the bootloader to crash and
> >>>>> enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a =
crash
> >>>>> dump is ready").
> >>>>>
> >>>>> It seems that the device cannot be re-initialized from this crashed
> >>>>> stage without toggling some reset pin (on my test platform that's
> >>>>> apparently what the device _RST ACPI method does).
> >>>>>
> >>>>> While it would theoretically be possible to rewrite the driver to t=
ear
> >>>>> down the whole MUX / IPC layers on hibernation (so the bootloader d=
oes
> >>>>> not crash from improper access) and then re-launch the device on
> >>>>> restore this would require significant refactoring of the driver
> >>>>> (believe me, I've tried), since there are quite a few assumptions
> >>>>> hard-coded in the driver about the device never being partially
> >>>>> de-initialized (like channels other than devlink cannot be closed,
> >>>>> for example).
> >>>>> Probably this would also need some programming guide for this hardw=
are.
> >>>>>
> >>>>> Considering that the driver seems orphaned [1] and other people are
> >>>>> hitting this issue too [2] fix it by simply unbinding the PCI drive=
r
> >>>>> before hibernation and re-binding it after restore, much like
> >>>>> USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
> >>>>> problem.
> >>>>>
> >>>>> Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which us=
es
> >>>>> the existing suspend / resume handlers) and S4 (which uses the new =
code).
> >>>>>
> >>>>> [1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bde=
bb@leemhuis.info/
> >>>>> [2]:
> >>>>> https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804=
139413
> >>>>>
> >>>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> >>>>
> >>>> Generally looks good to me. Lets wait for approval from PCI
> >>>> maintainers to be sure that there no unexpected side effects.
> >>>
> >>> I have nothing useful to contribute here.  Seems like kind of a
> >>> mess.  But Intel claims to maintain this, so it would be nice if
> >>> they would step up and make this work nicely.
> >>
> >> Suddenly, Intel lost their interest in the modems market and, as
> >> Maciej mentioned, the driver was abandon for a quite time now. The
> >> author no more works for Intel. You will see the bounce.
> >
> > Well, that's unfortunate :)  Maybe step 0 is to remove the Intel
> > entry from MAINTAINERS for this driver.
> >
> >> Bjorn, could you suggest how to deal easily with the device that is
> >> incapable to seamlessly recover from hibernation? I am totally
> >> hopeless regarding the PM topic. Or is the deep driver rework the
> >> only option?
> >
> > I'm pretty PM-illiterate myself.  Based on
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/admin-guide/pm/sleep-states.rst?id=3Dv6.12#n109,
> > I assume that when we resume after hibernate, devices are in the same
> > state as after a fresh boot, i.e., the state driver .probe() methods
> > see.
> >
> > So I assume that some combination of dev_pm_ops methods must be able
> > to do basically the same as .probe() to get the device usable again
> > after it was completely powered off and back on.
>
> You are right that it should be theoretically possible to fix this issue
> by re-initializing the driver in the hibernation restore/thaw callbacks
> and I even have tried to do so in the beginning.
>
> But as I wrote in this patch description, doing so would need significant
> refactoring of the driver as it is not currently capable of being
> de-initialized and re-initialized partially.
>
> Hence this patch approach of simply re-binding the driver which also
> seemed safer in the absence of any real programming docs for this hardwar=
e.

While this may not be elegant, it may actually get the job done.

Can you please resend the patch with a CC to linux-pm@vger.kernel.org?

