Return-Path: <linux-pci+bounces-38896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB2BF68EF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5993AFF34
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33F333441;
	Tue, 21 Oct 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Cs6anh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7833343C
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051207; cv=none; b=dKFYuicuJEVdFzLTL+Ny+wWdGYZMZHYd4d70m8t1530dS2TZlzi0q40ycuxoBHY/pGVz2hVZJO7egq0hzkODDZm76hAfUOJ99GymXWM32eiaREmkNLJBrpC6CYTHXsp93HZaQvO2paKNnDd0e9Jk7XUJ8tg2rkSH1FYrr8xtbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051207; c=relaxed/simple;
	bh=JRMgqzMCkRarxTqmjB25RB2qN3M2EvcJMAfE3kwGsSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOLcB33D5K5996qvNaTBEnjqwNV+BaesvR0nbdgqAdDADDRIGH44ypQbXg2S9eVeL1Nd9YAAWUrzTSTvMk4kuf3GxRDk56KAN0EokO7tge+V+gDoU9tz0XxCe+cxPC5sCpMuMT69fBah12HPoZG3eAiRa1IRj1EIoBa/OLaETLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Cs6anh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE49C116B1
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761051207;
	bh=JRMgqzMCkRarxTqmjB25RB2qN3M2EvcJMAfE3kwGsSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p8Cs6anh7MxhwqhAo26mJSRzuftK40TA4a6UF4EhaaR3j7eaP0M3gFUqpYosDs697
	 ySlEGZGWbDR3UmWIvMBLGUXBlovIrkZwdS+8dZnjjF+v9vgiw0GnZGyBq2qx2AbyIY
	 rF02Y2wRMNB3yqrU026qp1+N2Ob+iqa3SDUm4+vLgQwBPOeRmdyCSUP787/6YAgxSa
	 w/sVW1QDCtEOzhT7EekrP2z3ektze5KSU1QIgdHOawXzn9FvCEXBti4FRZqG9v5IQ+
	 2EyRMs1TgCGNM6V+Rqv7C0g7ZMMZp7Quc7wP4aWhAGLbkSyq+bmUHXoNECDvw3Bjv/
	 93WrkNZwm/2xw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-43f715b18caso2706450b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 05:53:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3RzF85DVtjjmLPabSOAYKsV2BOtZmJ+lneEBMA9Stdr75IU0JGkEqdhspUI8vS9gbJADVV8OPenY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3sLsxPItRkVjT2g1i4f11MGkMEq4+7faR4pplon/tYqU3vsSM
	x4uv/9KL8iH7Tu6DJmNKRZx7uILIL8ZOjCA6rHn+MCRx2EkKKkpsEzGCClldYlT+bkTkFUS255V
	qyfWsmiLp3K4THS+728K5pexxcbCVKx4=
X-Google-Smtp-Source: AGHT+IELKAJn+CpJ5d/x/lg53OE74Osp3H7VB9TLdb1TgTTX0AqIbjmO0KqDlLu2W8HZjjlDl3/ySjO9XTu3OKhlfNQ=
X-Received: by 2002:a05:6808:18a7:b0:43f:7a87:b39 with SMTP id
 5614622812f47-443a2f6a7c2mr6912539b6e.28.1761051206442; Tue, 21 Oct 2025
 05:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de> <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com> <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com> <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
In-Reply-To: <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 14:53:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
X-Gm-Features: AS18NWCQj4vpYEf3m-BM318rLr21HBYlYKoNpN244opR4NeobUnk_Cp4bjPsdg0
Message-ID: <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully initialized
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Brian Norris <briannorris@chromium.org>, Lukas Wunner <lukas@wunner.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:27=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 20 Oct 2025, Brian Norris wrote:
>
> > Hi Ilpo,
> >
> > On Mon, Oct 20, 2025 at 06:56:41PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Fri, 17 Oct 2025, Brian Norris wrote:
> > >
> > > > On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > > > On Fri, 17 Oct 2025, Lukas Wunner wrote:
> > > > >
> > > > > > [cc +=3D Ilpo]
> > > > > >
> > > > > > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > > > > > PCI devices are created via pci_scan_slot() and similar, and =
are
> > > > > > > promptly configured for runtime PM (pci_pm_init()). They are =
initially
> > > > > > > prevented from suspending by way of pm_runtime_forbid(); howe=
ver, it's
> > > > > > > expected that user space may override this via sysfs [1].
> > > > >
> > > > > Is this true as pm_runtime_forbid() also increases PM usage count=
?
> > > >
> > > > Yes it's true. See below.
> > > >
> > > > > "void pm_runtime_forbid(struct device *dev);
> > > > >
> > > > > unset the power.runtime_auto flag for the device and increase its
> > > > > usage counter (used by the /sys/devices/.../power/control interfa=
ce to
> > > > > effectively prevent the device from being power managed at run ti=
me)"
> >
> > I see this doc line confused you, and I can sympathize.
> >
> > IIUC, the parenthetical means that sysfs *uses* pm_runtime_forbid() to
> > "effectively prevent runtime power management"; pm_runtime_forbid() doe=
s
> > not block user space from doing anything.
> >
> > > > Right, but sysfs `echo auto > .../power/control` performs the inver=
se --
> > > > pm_runtime_allow() -- which decrements that count.
> > >
> > > Fair enough, I didn't check what it does.
> > >
> > > IMO, the details about how the usage count behaves should be part of =
the
> > > changelog as that documentation I quoted sounded like user control is
> > > prevented when forbidden.
> >
> > I tried to elaborate on the API doc confusion above. But frankly, I'm
> > not sure how best to explain runtime PM.
> >
> > > I see you've put this part of the explanation
> > > into the v2 as well so I suggest you explain the usage count in the c=
hange
> > > so it is recorded in the commit if somebody has to look at this commi=
t
> > > years from now.
> >
> > Both v1 and v2 mention that the sysfs 'power/control' file can override
> > the kernel calling pm_runtime_forbid(). They don't mention the usage
> > count, since that's an implementation detail IMO. (To me, the mental
> > model works best if "usage count" (usually get()/put()) is considered
> > mostly orthogonal to forbid()/allow()/sysfs, because "forbid()" can be
> > overridden at any time.)
> >
> > This is also covered here:
> >
> > https://docs.kernel.org/power/runtime_pm.html#runtime-pm-initialization=
-device-probing-and-removal
> >
> > "In principle, this mechanism may also be used by the driver to
> > effectively turn off the runtime power management of the device until
> > the user space turns it on."
>
> The problem is already rooted into the function name, when a function is
> called "forbid", anyone unfamiliar will think it really forbids
> something.

And it does, until the "allow" counterpart of it is called.

The confusing part here is that the "allow" counterpart is called from
a sysfs attribute.

> The docs just further reinforced the idea and the fact that it
> also increments usage count.
>
> It is quite unexpected and feels quite illogical (for non-PM person like
> me) that user interface then goes to reverse that usage count increase,
> what would be the logical reason why there now are less users for it when
> user wants to turn on PM? (I understand things are done that way, no need
> to explain that further, but there are quite a few misleading things in
> this entire scenario, not just that parenthesis part of the docs.)

So the purpose of this "forbid" call in pci_pm_init() is to "block"
runtime PM for PCI devices by default, but allow user space to
"unblock" it later.

Would adding a comment to that effect next to that call be useful?

