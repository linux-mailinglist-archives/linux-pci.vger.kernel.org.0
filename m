Return-Path: <linux-pci+bounces-35809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C47B5188E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB901C85485
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DA320CBF;
	Wed, 10 Sep 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9FWv5d5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B7320A3E;
	Wed, 10 Sep 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512735; cv=none; b=JgJ2sajg0sB/KmxC4X6Rn2MrwFdcBBCZR2uCblf5pU1wYOMpw8QhqMXkQgN/C0HwrZyhL/uYvORwSgMGyugi6VOEqO6SrCh8SKznMO7vRTt8k2yUqdEVnKK7qRBf7NGNb68nsKpZBecspe8YzI3TGnN1iECg6BVHZTzJEAtLdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512735; c=relaxed/simple;
	bh=3519NgJS5af1Ajj9Vhlr8KZ7E/Y4HYs8va70a7vghxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctT40cuOADklYwQ8DXAuVJp0f4EAahciThD64Sg2ckwyK6JZp5nx2IerTkF3c6JmRI4VMIZf1YRCTpfPjmVkCP8kza17UeVoBv2e2NlqB6aNtXXqYDFL9z7mVJQP8zV3L5DFPzc3EbDZxgYCcLzeYmc2YOoCVpMAkKtGIe4pHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9FWv5d5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8684C113CF;
	Wed, 10 Sep 2025 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757512733;
	bh=3519NgJS5af1Ajj9Vhlr8KZ7E/Y4HYs8va70a7vghxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P9FWv5d5a8NYpbSbgR7Ik8dp74uUr4fNWCQpXBHcctk/mkG0E1DvOINiwc1soE4jg
	 +BAa7Ud7DObaRmnvBvmQzi0/kpjzlbK2hW9oN9n0vpFM9L5xQ9djr2wuE921sodxEx
	 WgA0plNJGmVfalbNkjdqpQGLM54PiOIikmBPUA/6lcJa+k/PegVPG6Tstzawxbxcym
	 +JfOZale0lcvdD1/9K4pK4rksymUyVQ2WLCvpaM2g1bKSmlxq3S2mGA+3oTUDDgPKN
	 o2H2tmjphxvcy4BVnlh43b3VDrX4EC2Y8ORT05YlhsB98jGNErvFFjT3LDyTRVT1nj
	 nXGjYQ6RsCMbw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74595f3852cso4259627a34.0;
        Wed, 10 Sep 2025 06:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCbi+h/e82gg0kHa/bCGe4eGvBo/MujUnhhSuU/4u0/SNC+8v31efMzulF/Y5eI8bqZLUfJANntPZ2nA==@vger.kernel.org, AJvYcCV5Hm+/F3mLOyWzbqNz2OS/PPuZRADDTjGhQR0eBMN4cYb9FdjxfexSVKLFn+vd3ZC0JOahHV6STF2W@vger.kernel.org, AJvYcCVAgZOuL/8fqAQLCX9r6F8g5RF1zyi/KeTvuQQGhMsakA5GmO6CcYZtOHcjLfDki/eB0KLVWQ+6P4GFnebs5fZ5vnGg@vger.kernel.org, AJvYcCWvn8wgzwKI62oyN9ROCtI0uxzqJI/s5tQzVNApXeP3NsDmRqpAJjP1UCTYwaB1ut0pXXVinDiGc70=@vger.kernel.org, AJvYcCXn5L3M6CXrKx7Kt2UEbagRJZtSg/ytOaKvQPblXA8LTEGoMxsR2G8oRemUbu9j+hpCrZOlxpNrh3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlU9qZyDojHQWvd3v3oKND/XL5tNf5h4t8ct5HHwDQNvxltw++
	Up2XWN1wFg9LYn18/jC5XQYhUXatSikp/YG0tYiU3vmDkD2XmkYhGEiuYMAqonFFMZ1HlcQpLQF
	IuBh6ZliiClE3vwU7gy4hADu0vIub49I=
X-Google-Smtp-Source: AGHT+IH7BCb6LYGInN6fRifU1PN2pCzvvU+aj27/RQrKYfBGkk+A//ewx0ANkkYnwGiqVgrG/auhpbNo5qaSgs9mrTo=
X-Received: by 2002:a05:6830:67fb:b0:746:d9af:6664 with SMTP id
 46e09a7af769-74c74ec0cb2mr7381703a34.20.1757512732743; Wed, 10 Sep 2025
 06:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909191619.2580169-1-superm1@kernel.org> <20250909191619.2580169-2-superm1@kernel.org>
In-Reply-To: <20250909191619.2580169-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 15:58:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6+UaTHDnJE6z-VFuJrXbmfiAr7Gs=z9-xaX9mS7NqGA@mail.gmail.com>
X-Gm-Features: Ac12FXxslvL9eXXrmgBCzhpzNxr-VzxsKkb6k4uN3mry0ap06Tvs7qCSO374gMM
Message-ID: <CAJZ5v0i6+UaTHDnJE6z-VFuJrXbmfiAr7Gs=z9-xaX9mS7NqGA@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] PM: Introduce new PMSG_POWEROFF event
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Tue, Sep 9, 2025 at 9:16=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> PMSG_POWEROFF will be used for the PM core to allow differentiating betwe=
en
> a hibernation or shutdown sequence when re-using callbacks.
>
> This event should not have wakeups enabled

Why?

It surely is valid to wake up the system while it is being powered
off, especially in the hibernation case.

The "poweroff" transition is generally not recoverable, however, so it
may be better to complete it and trigger a reboot if wakeup has been
signaled.

> so update PMSG_NO_WAKEUP() to match it as well.

No, please.

> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v7:
>  * Reword commit
> v5:
>  * Re-order and split
>  * Add tags
> v4:
>  * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@ker=
nel.org/
> ---
>  drivers/base/power/main.c    | 7 +++++++
>  include/linux/pm.h           | 5 ++++-
>  include/trace/events/power.h | 3 ++-
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 2ea6e05e6ec90..86661c94e8cef 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -99,6 +99,8 @@ static const char *pm_verb(int event)
>                 return "restore";
>         case PM_EVENT_RECOVER:
>                 return "recover";
> +       case PM_EVENT_POWEROFF:
> +               return "poweroff";
>         default:
>                 return "(unknown PM event)";
>         }
> @@ -369,6 +371,7 @@ static pm_callback_t pm_op(const struct dev_pm_ops *o=
ps, pm_message_t state)
>         case PM_EVENT_FREEZE:
>         case PM_EVENT_QUIESCE:
>                 return ops->freeze;
> +       case PM_EVENT_POWEROFF:
>         case PM_EVENT_HIBERNATE:
>                 return ops->poweroff;
>         case PM_EVENT_THAW:
> @@ -403,6 +406,7 @@ static pm_callback_t pm_late_early_op(const struct de=
v_pm_ops *ops,
>         case PM_EVENT_FREEZE:
>         case PM_EVENT_QUIESCE:
>                 return ops->freeze_late;
> +       case PM_EVENT_POWEROFF:
>         case PM_EVENT_HIBERNATE:
>                 return ops->poweroff_late;
>         case PM_EVENT_THAW:
> @@ -437,6 +441,7 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_=
ops *ops, pm_message_t stat
>         case PM_EVENT_FREEZE:
>         case PM_EVENT_QUIESCE:
>                 return ops->freeze_noirq;
> +       case PM_EVENT_POWEROFF:
>         case PM_EVENT_HIBERNATE:
>                 return ops->poweroff_noirq;
>         case PM_EVENT_THAW:
> @@ -1370,6 +1375,8 @@ static pm_message_t resume_event(pm_message_t sleep=
_state)
>                 return PMSG_RECOVER;
>         case PM_EVENT_HIBERNATE:
>                 return PMSG_RESTORE;
> +       case PM_EVENT_POWEROFF:
> +               return PMSG_ON;
>         }
>         return PMSG_ON;
>  }
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index cc7b2dc28574c..892bd93f13dad 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -507,6 +507,7 @@ const struct dev_pm_ops name =3D { \
>   * RECOVER     Creation of a hibernation image or restoration of the mai=
n
>   *             memory contents from a hibernation image has failed, call
>   *             ->thaw() and ->complete() for all devices.
> + * POWEROFF    System will poweroff, call ->poweroff() for all devices.
>   *
>   * The following PM_EVENT_ messages are defined for internal use by
>   * kernel subsystems.  They are never issued by the PM core.
> @@ -537,6 +538,7 @@ const struct dev_pm_ops name =3D { \
>  #define PM_EVENT_USER          0x0100
>  #define PM_EVENT_REMOTE                0x0200
>  #define PM_EVENT_AUTO          0x0400
> +#define PM_EVENT_POWEROFF      0x0800
>
>  #define PM_EVENT_SLEEP         (PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
>  #define PM_EVENT_USER_SUSPEND  (PM_EVENT_USER | PM_EVENT_SUSPEND)
> @@ -551,6 +553,7 @@ const struct dev_pm_ops name =3D { \
>  #define PMSG_QUIESCE   ((struct pm_message){ .event =3D PM_EVENT_QUIESCE=
, })
>  #define PMSG_SUSPEND   ((struct pm_message){ .event =3D PM_EVENT_SUSPEND=
, })
>  #define PMSG_HIBERNATE ((struct pm_message){ .event =3D PM_EVENT_HIBERNA=
TE, })
> +#define PMSG_POWEROFF  ((struct pm_message){ .event =3D PM_EVENT_POWEROF=
F, })
>  #define PMSG_RESUME    ((struct pm_message){ .event =3D PM_EVENT_RESUME,=
 })
>  #define PMSG_THAW      ((struct pm_message){ .event =3D PM_EVENT_THAW, }=
)
>  #define PMSG_RESTORE   ((struct pm_message){ .event =3D PM_EVENT_RESTORE=
, })
> @@ -568,7 +571,7 @@ const struct dev_pm_ops name =3D { \
>
>  #define PMSG_IS_AUTO(msg)      (((msg).event & PM_EVENT_AUTO) !=3D 0)
>  #define PMSG_NO_WAKEUP(msg)    (((msg).event & \
> -                               (PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) !=
=3D 0)
> +                               (PM_EVENT_FREEZE | PM_EVENT_QUIESCE | PM_=
EVENT_POWEROFF)) !=3D 0)
>  /*
>   * Device run-time power management status.
>   *
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 82904291c2b81..370f8df2fdb4b 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -179,7 +179,8 @@ TRACE_EVENT(pstate_sample,
>                 { PM_EVENT_HIBERNATE, "hibernate" }, \
>                 { PM_EVENT_THAW, "thaw" }, \
>                 { PM_EVENT_RESTORE, "restore" }, \
> -               { PM_EVENT_RECOVER, "recover" })
> +               { PM_EVENT_RECOVER, "recover" }, \
> +               { PM_EVENT_POWEROFF, "poweroff" })
>
>  DEFINE_EVENT(cpu, cpu_frequency,
>
> --
> 2.43.0
>

