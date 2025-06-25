Return-Path: <linux-pci+bounces-30653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90378AE8EB4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F362189AD47
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E31D63F8;
	Wed, 25 Jun 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV5mIpiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F51FC8;
	Wed, 25 Jun 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879852; cv=none; b=UGXkhNm6N4R7HVXBGgdPtVXrITX+kQdxRB+I0IW4+5dQMPUGkbT3DDcW3TxjTiiniP1H1SdhgQ187vcJpTC4Jr2iBM5UFJlPfG8r+0w9H1lc9B4d7lqaNJ8srHfddKlFejDskvZoADgKk3kJc7BZsRkuGCqFYsaVSHvRMi2wkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879852; c=relaxed/simple;
	bh=kO65dAHnQp+PU83lwNWkVqWyPP2Y2P3dLaWu4SMKm6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utwX+13RQZolk6uXigJivBr+Vw7EOAgXZuYr3eRsEuFMVvCVxuokc1I2dzdpMSy7Q+q27YfEeugRqOasglDARBedQ59lU8/dlynq9ecA9hQuxxAClwFUMH/NMems2acC2zzx078JVZbk/aeGUIN8BkcZfkmuuDOb6RbIVdL1JYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV5mIpiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5280C4CEF2;
	Wed, 25 Jun 2025 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750879850;
	bh=kO65dAHnQp+PU83lwNWkVqWyPP2Y2P3dLaWu4SMKm6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kV5mIpiCbNYc92SSA+KhRHKHXX0Y9Z32DAGu7ap14GmVghMngA3KLFPy+wTqt7rZK
	 mhNeEDCWt9/pGaVFm3FeGzx03n0kt1WVLm37AgvwPpwyqpD7prp2qv2fbC6yyz05Uh
	 F8m6eGhQggRl8RgEaALVU1gDBsGmkvXp8Lkdz0a0ovk7LJqFrsyQH2jyKb/HJay2N/
	 MsJZfwCKSs45Vg2gD2BkX2A/HfJj64XNWNOBjJ0rpz7zqMybMI1ZLC9N4knJQf96bM
	 bB9L/NHIDB1lPNMhNK6oGvosM9yxhQfvVBGCpgc1ZY1fx3Zb91oBYqpQ1mg1eLp9Y/
	 UxRnN+jW5qU1w==
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31329098ae8so306494a91.1;
        Wed, 25 Jun 2025 12:30:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7b0ByJXVW03OKcJ0C0es3miEnIYeJyB8dUyD7KEEhhopx8Te1wXoKotCwEUfyhUblCZZL4UsFCGX1@vger.kernel.org, AJvYcCXR+743St18VpR5wOtRgkhXUizwqlFh5uaaHAclEs1ppPrGNrCJujeITsed5HTmwe7bzL3Rd83e4QLm@vger.kernel.org
X-Gm-Message-State: AOJu0YxAve5YrdZljhQoLfzusTaCnqI+hLNFjG8QdDAAR32q1qVlcg4V
	fBmp/0mKzaMWe5vdAQ1LLWu/qmRWa0sSUE61a4NdjXfPX6qVdHp5kX4aoD7QhmeXnmg0qHlB5DL
	rAOEJ4t+y/Gbj5m0wOAa8TTADAn8X/EU=
X-Google-Smtp-Source: AGHT+IFZxoGQJBwArHD9j7ZG6j6ZYaPZIOhp2boEC9mYL9ddF3T9EfRpq6x2nDFMRVOi0crx5Wi65CyhSN9sasvZQI0=
X-Received: by 2002:a17:90b:53c3:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-316d69d00damr1253668a91.8.1750879850200; Wed, 25 Jun 2025
 12:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <3306233.5fSG56mABF@rjwysocki.net>
In-Reply-To: <3306233.5fSG56mABF@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Jun 2025 21:30:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihX2jmXF7V42Up1LEb4rekEhS-X6OtZJWJNZW+PCdKZw@mail.gmail.com>
X-Gm-Features: AX0GCFsWXPrWGVsLJRKTdHePDPNaXAj6S-xiXdSQpz6lwx4Y0HM0cGh_ihc5ZcM
Message-ID: <CAJZ5v0ihX2jmXF7V42Up1LEb4rekEhS-X6OtZJWJNZW+PCdKZw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PM: Check power.needs_force_resume in pm_runtime_force_suspend()
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This should be [PATCH v1 2/9], but it obviously doesn't apply without
the [1/9], so please regard it as the second one in the series.

Sorry about the confusion.

On Wed, Jun 25, 2025 at 9:25=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
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
>  drivers/base/power/runtime.c |   21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1975,7 +1975,7 @@
>         int ret;
>
>         pm_runtime_disable(dev);
> -       if (pm_runtime_status_suspended(dev))
> +       if (pm_runtime_status_suspended(dev) || dev->power.needs_force_re=
sume)
>                 return 0;
>
>         callback =3D RPM_GET_CALLBACK(dev, runtime_suspend);
> @@ -1990,15 +1990,16 @@
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

