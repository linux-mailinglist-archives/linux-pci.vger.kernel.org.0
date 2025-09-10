Return-Path: <linux-pci+bounces-35848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3083B51FA3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 20:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524E63AA6F3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8C338F55;
	Wed, 10 Sep 2025 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI5vXeh3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360F295D90;
	Wed, 10 Sep 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527230; cv=none; b=nb0ZlO2Ll9lHMt5OtK4/QB25WeaLogVtLysc7y0wNK1HyzZQfrPEysfBz4YIxE3d/A3gr+CfxOaGGUqWmzo3dLC4PFuwCJ4kVEMM1rerqwrwrPYfCmgj2twwcfd8WdKaHV7+oTLzmJZ9a+qP0eMvKr9aXoIJobAR8ylutXzW+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527230; c=relaxed/simple;
	bh=aEYVwK9M9QzWa1yd7+FmJ7xSwSWsDm24bHNlO3+ZDiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flKqnytWKBZSm0fH0AVhySO5TTE4zb7mIzzMt6hjwLEVE+SxFPlxukj/tMItqsKezXz6/8AZVLPu8pj0cbmtKmPjw0XRSNu4ltwfe/LajrTdlR1DyNtLaNz6AQUVH6CobzKlj1JkCs1QeRShQCk+62YljYqmRNGqEOn8Hk7SnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI5vXeh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD41AC116B1;
	Wed, 10 Sep 2025 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527228;
	bh=aEYVwK9M9QzWa1yd7+FmJ7xSwSWsDm24bHNlO3+ZDiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XI5vXeh3E69iRJQ42zyvWPbQrQ039vWYrF+m6PVa3bxOeSwQNFvmLv1XXtZCBZ2aN
	 A6d0Hq6Hv+wlKq3HN9gRmnKmeTuUdSxHDOd97iLsBvu1LfV6wiQilyy8A6vgummyk5
	 b+DwOjmuQsJkGZfEBN+ITZwQwrko7Yu2ekNwlp+0pwSMKwJKS6jc9sJnDiYaRBahjR
	 x+YCUAykJaiVzneSzOmp3MExpKfsJQj60xlIhm+GxKK3QB8BliXx5Y7nFIWCl+B0yj
	 0e8ca1ohSrfrJAyxfet5z74xk4aj6avc9MYHe3bC3tN+Xd0IP3yAichjp3gBqGNUzs
	 LHbNdR3JLGJBg==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74c1251df00so2781213a34.0;
        Wed, 10 Sep 2025 11:00:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7R9sVOAAUEdYfeVuKPJdRXvyGmyrc6XQYYXvcCjzA/vPiAZagBfTzTnQtrBZoq2xFmdO5nFyswD8o@vger.kernel.org, AJvYcCVChhAJEr7Fn4SEBFHhl91z1uF7KXWjFCWgbLyL/wVjgJcoNnArVA4XCE5dHhemw5HSxWTTvWMW2aU=@vger.kernel.org, AJvYcCWWM7PM6v7Wy24Gkx/R4izuEC35hjUOTs3UDjts2M/AXOCisGdZGuGYECGILIBnYPzxaUgtTwYC674=@vger.kernel.org, AJvYcCX40Rl3cfvUhuT6M2R8k9FmiGxk94GeV9A8jjCRLcbnHIlAA9728rL2tAjuAwWw/gWaQ6gqwk80MXsHfwt0+08NJ0H2@vger.kernel.org, AJvYcCXPm+Ty7ILvYZ/ndfdblzPc60oGK5+keAchDb4gp7OGO0/tfGcSEGDAqDxiHDh65LRpxVV5j3On0uG2lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvNjPIdkA6gwjKQloFfa3JQv6GcXVPLkSo7MXU99W+NMo2hQg
	gbhT8PR6lZbI36Dsh56oJHkQE74INFomPNnVjFWuyOXWkwZ48I//pEuJyayFJAp1TgX6tcZPC03
	9s25ICLn5rMK+vpApZDTeFJNzs6OIK5Q=
X-Google-Smtp-Source: AGHT+IGS3DlLDZc5Hp9Wu7ymo9qCnnEjsWp392Wk609kXWdhdzzFbsXXgHOkn/CUlPsxX3QZUGBx4ariAoNkk9utRK4=
X-Received: by 2002:a05:6830:2695:b0:745:a0f0:25c6 with SMTP id
 46e09a7af769-74c702bca54mr7780880a34.10.1757527227849; Wed, 10 Sep 2025
 11:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909191619.2580169-1-superm1@kernel.org> <20250909191619.2580169-2-superm1@kernel.org>
 <CAJZ5v0i6+UaTHDnJE6z-VFuJrXbmfiAr7Gs=z9-xaX9mS7NqGA@mail.gmail.com> <9332e17e-380b-42cc-b078-7c5d9d09d798@kernel.org>
In-Reply-To: <9332e17e-380b-42cc-b078-7c5d9d09d798@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 20:00:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ga0sejxa6DyN_1aCuB-fVsa_w-G1U=RR6kmGVn48QR2Q@mail.gmail.com>
X-Gm-Features: Ac12FXwjW268LpbRAcls9flQhPZhEXycRZTW2tVrYiFw-ZH6X5s316VJMYfwl5Q
Message-ID: <CAJZ5v0ga0sejxa6DyN_1aCuB-fVsa_w-G1U=RR6kmGVn48QR2Q@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] PM: Introduce new PMSG_POWEROFF event
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:48=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/10/25 8:58 AM, Rafael J. Wysocki wrote:
> > On Tue, Sep 9, 2025 at 9:16=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> PMSG_POWEROFF will be used for the PM core to allow differentiating be=
tween
> >> a hibernation or shutdown sequence when re-using callbacks.
> >>
> >> This event should not have wakeups enabled
> >
> > Why?
> >
> > It surely is valid to wake up the system while it is being powered
> > off, especially in the hibernation case.
>
> In the hibernation case - yes you want wakeups.
>
> But in what is perceived as powering off the machine it's not expected
> that you would have wakeups.
>
> If I have a USB mouse connected and set as a wakeup source, I can click
> the mouse and the machine wakes up.  A user wouldn't expect that happens
> with a powered off machine.
>
> That's certainly not how it works today at least.

Sure, but you want to use the same transition mechanism to handle
those two cases.  In one of them, you don't want wakeup events to be
disabled, so you cannot do that at the transition type level.

> >
> > The "poweroff" transition is generally not recoverable, however, so it
> > may be better to complete it and trigger a reboot if wakeup has been
> > signaled.
>
> Hmm, I'm not sure about that.  Back to hypothesizing on the USB mouse cas=
e:
> If I'm entering suspend, the mouse is an enabled wakeup source and I'm
> moving the mouse the suspend should be aborted.
>
> But if I requested the machine to be powered off and and I clicked the
> mouse while powering off that would be an "aborted power off?.
> Wouldn't that be really counterintuitive to reboot instead?

I was talking about the last stage of hibernation, sorry if that
wasn't clear enough.

So in the last stage of hibernation, which also carries out a
"power-off" transition (if run in the "platform" mode that is), you
want wakeups to be enabled, don't you?

But the "power-off" transition is not recoverable in general (IOW, it
cannot be reliably rolled back, at least as of today), it may be
better to complete it and make the kernel load the just created
hibernation image and restore from it in response to a wakeup event.
Something like the latter is already done in the "test_resume"
hibernation mode.

> IE as a user you expect that pressing the power button gets you an off
> machine, not a different result based on other activity.

That's a slightly different case, but if you press the power button
once while hibernation is in progress, you may actually expect to get
back to the pre-hibernation state (or at least hope that this is going
to happen).

