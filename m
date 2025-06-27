Return-Path: <linux-pci+bounces-30914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C97AEB578
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697791BC4BB2
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346C2980A5;
	Fri, 27 Jun 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAuVz6pF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73539339A8;
	Fri, 27 Jun 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021585; cv=none; b=nli1R21PfGL8yu9I2kPQjuYusuf1vHlqc3seir8jwuM63aPIEGUejkpttmPy3jTBlRW+hKJzLD47v5VKMBhXTmSuFhTMVG1odiKpfMLRLKSZ0L0/ZBJ+lx9KoYiEY0p/WyOYDut8ewnYo5y/HFu6xP5UJtYH9a1tMsN9m6pAwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021585; c=relaxed/simple;
	bh=K4XpAjTa7+hKIgq7u8CKdwP6yqA/xD2glJZeavWK7Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaXUwSiWyuiBwxKcwxJCowpUrri8lpRr/B8ipgAIi3A2GxGpRV59rruR40eFwMjFciMWKlF6MwH3i/rf6h9lLflNO1UxHGcjl8HhpjsSq+E1HSubMZ0TwATS0CBhlyr7xCnlqpioq7jwra9w5I1a9dICqxhRKBye6sDjbGfT0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAuVz6pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8387C4CEF2;
	Fri, 27 Jun 2025 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021584;
	bh=K4XpAjTa7+hKIgq7u8CKdwP6yqA/xD2glJZeavWK7Ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uAuVz6pFEKbocjVvpbM6rYL/y1pxfzqTeU2lLOucXiyZXaJ3jN1l8fdzoid8Urxf1
	 c5eT03JfanyIx54HrwoMNYnwdoJf1xOUtF3S5btvG7vtAqgfk8lsC0MKbw3lXJxQ/x
	 NNYdMzpoA8/RUSZ4tgiezTHDp7Ei8kBaS98afaDDtNCw9CDig/kyrw6bL55cofD7hN
	 WP+q4Nw+tf+aBceGBbhGETZfJUfjeJgMnsT0w6YvWpIGdKd0dPF8UTzAgxvWQAUtN8
	 1HBF8jpNJGVLUlvUJq/r8tk7tdYwy6WrrjXySE+fqWjxoiKDlWljQtlju26uoy4hvI
	 DeCUGez17OFLg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-40b1c099511so1201451b6e.0;
        Fri, 27 Jun 2025 03:53:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBttQevcfvqNpdtE4zsh2qLVAexTFFYGNsHSgm8H/znDN9g0DTfE6LMaXO20KyEgtUisACYdVPv9PD@vger.kernel.org, AJvYcCVPsudfaOFdzS/DjkFKsj7hjAcIFTOjBKkbBXww8eeK2Yb31xj80KVwQzp3TT/GDPWnBK0vYWYY729P@vger.kernel.org
X-Gm-Message-State: AOJu0YyIM7911X5Ng02AOboLTOeFZ77GbNXg8+kfQ1ySj4os2ugXXmWF
	ozgjcxPvWX4Dgd40ixkWNA+taOYX6Gq2MDx9J54uWsPgKkPwCLc7/y3JBdrNc54/sBjEzUbMJYK
	HVQcbmkF3UcVTx/3iIupI05kw7lCc52s=
X-Google-Smtp-Source: AGHT+IGF5o3JdiAyonVr5J6bCA8gf3fqFl/nAXMHCfe9W09f17nIkklyMepiatGdtSYaCw/7Ez4+TL6U4SyEGXl6bDI=
X-Received: by 2002:a05:6808:2124:b0:407:a0ea:a233 with SMTP id
 5614622812f47-40b1caac7b6mr5565686b6e.10.1751021584137; Fri, 27 Jun 2025
 03:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5015172.GXAFRqVoOG@rjwysocki.net> <2336655.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2336655.iZASKD2KPV@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 12:52:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4AMFfyBugjBwQOV=xY-Hq5kL_vB7Gwrj06N8vo6GQtg@mail.gmail.com>
X-Gm-Features: Ac12FXwpg9AnVFZosYa_eZDnu0_6_9S_gG---O66k8-4K1sDgRQ8bmySwBdfXks
Message-ID: <CAJZ5v0h4AMFfyBugjBwQOV=xY-Hq5kL_vB7Gwrj06N8vo6GQtg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] PM: Check power.needs_force_resume in pm_runtime_force_suspend()
To: Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:15=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add a power.needs_force_resume check to pm_runtime_force_suspend() so
> it need not rely on the runtime PM status of the device when deciding
> whether or not to return early.
>
> With the new check in place, pm_runtime_force_suspend() will also skip
> devices with the runtime PM status equal to RPM_ACTIVE if they have
> power.needs_force_resume set, so it won't need to change the RPM
> status of the device to RPM_SUSPENDED in addition to setting
> power.needs_force_resume in the case when pm_runtime_need_not_resume()
> return false.
>
> This allows the runtime PM status update to be removed from
> pm_runtime_force_resume(), so the runtime PM status remains unchanged
> between the pm_runtime_force_suspend() and pm_runtime_force_resume()
> calls.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2: Corresponds to patch [2/9] (that was posted as [0/9] by mistake=
) in v1.
>
> ---
>  drivers/base/power/runtime.c |   21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1973,7 +1973,7 @@
>         int ret;
>
>         pm_runtime_disable(dev);
> -       if (pm_runtime_status_suspended(dev))
> +       if (pm_runtime_status_suspended(dev) || dev->power.needs_force_re=
sume)
>                 return 0;
>
>         callback =3D RPM_GET_CALLBACK(dev, runtime_suspend);
> @@ -1988,15 +1988,16 @@
>         /*
>          * If the device can stay in suspend after the system-wide transi=
tion
>          * to the working state that will follow, drop the children count=
er of
> -        * its parent, but set its status to RPM_SUSPENDED anyway in case=
 this
> -        * function will be called again for it in the meantime.
> +        * its parent and the usage counters of its suppliers.  Otherwise=
, set
> +        * power.needs_force_resume to let pm_runtime_force_resume() know=
 that
> +        * the device needs to be taken care of and to prevent this funct=
ion
> +        * from handling the device again in case the device is passed to=
 it
> +        * once more subsequently.
>          */
> -       if (pm_runtime_need_not_resume(dev)) {
> +       if (pm_runtime_need_not_resume(dev))
>                 pm_runtime_set_suspended(dev);
> -       } else {
> -               __update_runtime_status(dev, RPM_SUSPENDED);
> +       else
>                 dev->power.needs_force_resume =3D true;
> -       }

I kind of see that this change may confuse other things looking at the
PM runtime status to determine whether or not the device needs to be
suspended that possibly run after pm_runtime_force_suspend().

I'm also not quite sure why I thought that this patch would be
necessary in this series because the [5/9] should just work without
it.

Please disregard it unless you see why it is needed here.

>
>         return 0;
>
> @@ -2029,12 +2030,6 @@
>         if (!dev->power.needs_force_resume)
>                 goto out;
>
> -       /*
> -        * The value of the parent's children counter is correct already,=
 so
> -        * just update the status of the device.
> -        */
> -       __update_runtime_status(dev, RPM_ACTIVE);
> -
>         callback =3D RPM_GET_CALLBACK(dev, runtime_resume);
>
>         dev_pm_disable_wake_irq_check(dev, false);
>
>
>
>

