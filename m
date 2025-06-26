Return-Path: <linux-pci+bounces-30744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A05AE9C09
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124B63A55FD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E5272814;
	Thu, 26 Jun 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO3ISG0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490472727FE;
	Thu, 26 Jun 2025 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935577; cv=none; b=JcQ2pMVo6D67YYIfauzGBbNMXggHy4RSMDa9MvL7nTIJLEZJkhzvO8Ckvg7q22tite7AkERDKj6UHzEj+zden/AZLOS9wwzFMVGlD83u57FXWMT1zOApWEvOoheJgCMP5C/f0Tij6NM0k2sZk8WQfKEhsNK36VcAhID4uIp1XhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935577; c=relaxed/simple;
	bh=+dnfNjkqjX5KLN7SnWD0Dst7Xn0aAkIyOGApXAie9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsOQqchaKKKBaKSGaVP1+N1CW+s/8BXRkk8fuTYk9BS/tvOkC1tTAbp8Rjk49fJSZUa3mQA5hH3q/tRq0r9HMvkTu6KzyH7FU/eVRyUeGYoDSS/GemxaVC9JILEVq/hN46AenQqrpEQQ54+bT/oXAVqBHJ/zG+csLE3SMYnID8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO3ISG0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1976C4CEEE;
	Thu, 26 Jun 2025 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750935576;
	bh=+dnfNjkqjX5KLN7SnWD0Dst7Xn0aAkIyOGApXAie9OY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rO3ISG0ofqV5TlQR3rZYDgcoTr2D+SCneBfkiURALzk9ixerSy6WZSHgkd/nwvozp
	 leotQl/rSx5I7ZzvCaxg2UBpDcy4d5/0YWgWz9oZObB2K45XZA+AG5YSf2LxGXNhCg
	 J3nc18lXBNBwE+Az8t29w6BgDfGu0PKjJ+NymeGnejkwOJYyqFqjbfgPtoX65hjTmc
	 S43EBevSDlJqdkwKCpZPmeG+b13z54ab1Q6ncY1FF8AP1DtDgFkYezR6Q0gZexGlVA
	 5qz+YZYwkvyNe39I4JRpcUo+UkWVQCU6b/drPZPcmD3I3KXvoXBuC3wiySuLEijJ4O
	 25oNYChpDmpKg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60bd30dd387so434356eaf.3;
        Thu, 26 Jun 2025 03:59:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJo1hR+bUdc3/KwvI0GxWNBY4LkgyLYXYjnclcVfLiZ15woZK/ZUz5OIv22Oewxo6j7y4Y+eorO4/l@vger.kernel.org, AJvYcCWCqHgDDcQSu0Y0chmZg0K44iG3lklJw1gHDOTFUC1OnyuEC4wzAWou6eZKCijDgTIEffeqdMogeWQ=@vger.kernel.org, AJvYcCWV9hr52pldXRMD56zfKPdxILihNgW8sBg9mHlSDzBbT5Wy4FdV1zxMbvHfJ+rj31049IMakicEt0fk/gY7@vger.kernel.org, AJvYcCWwoA01QirdIepucLeo+e7TX9F64ps9m349yJE1pHwZiNXT5pRhiWUJ9gdf7IiqCet1Y0pClAnxqEBX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53ASr5HYfSAa4h3CoN7/SIV57X9dEfxcR3EAn9Ol6569oFBCv
	Oq2zLMOa0gXdM2pz6z7a6tzyZYL3gLTsMAIGT4hxxmdSamUs2bJUJjfY7/dABHN0tp5w1FUL/uh
	smtIGjwjhDL4KslruK42eW2n7wGdaCrM=
X-Google-Smtp-Source: AGHT+IFlHK0qqu+LJQSDSOqsz2M0dO3rmVztJx4oRIo33VonBpawvIFL8ydYaYNmO/FgSVPMw29dHyBQ2yKsGcxIF9c=
X-Received: by 2002:a05:6820:4b95:b0:611:a799:cb65 with SMTP id
 006d021491bc7-611a799cd7amr2629973eaf.2.1750935576092; Thu, 26 Jun 2025
 03:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <CAPDyKFpZVdf2EnZE_u1xDKB7=Nd98a_ajYimQhLBu6jYwJhJFA@mail.gmail.com>
 <CAJZ5v0irk8n0MzRm=u8k=+Mtq84r7JsazS10DsvHO4ktgW=AMQ@mail.gmail.com> <CAPDyKFq7gydO0uioA53LqXk-N+Bjp4bwkaRRzMeWv+F=zpy2Jw@mail.gmail.com>
In-Reply-To: <CAPDyKFq7gydO0uioA53LqXk-N+Bjp4bwkaRRzMeWv+F=zpy2Jw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 12:59:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4Q+cqMKNnBDaFsnj4zSH_iKV+EDz9BnfF23cATkczYA@mail.gmail.com>
X-Gm-Features: Ac12FXy7ca52AM2RImFpx6abJFvTiPZiAAJMqD4JzF_OcnCrx84Phr2euW0aKIA
Message-ID: <CAJZ5v0g4Q+cqMKNnBDaFsnj4zSH_iKV+EDz9BnfF23cATkczYA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:41=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Thu, 26 Jun 2025 at 12:34, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Jun 26, 2025 at 12:31=E2=80=AFPM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > >
> > > On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> > > >
> > > > Hi Everyone,
> > > >
> > > > This series addresses a couple of issues related to the integration=
 of runtime
> > > > PM with system sleep I was talking about at the OSMP-summit 2025:
> > > >
> > > > https://lwn.net/Articles/1021332/
> > > >
> > > > Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
> > > > pm_runtime_force_suspend/resume() due to some conflicting expectati=
ons
> > > > about the handling of device runtime PM status between these functi=
ons
> > > > and the PM core.
> > > >
> > > > Also pm_runtime_force_suspend/resume() currently cannot be used in =
PCI
> > > > drivers and in drivers that collaborate with the general ACPI PM do=
main
> > > > because they both don't expect their mid-layer runtime PM callbacks=
 to
> > > > be invoked during system-wide suspend and resume.
> > > >
> > > > Patch [1/9] is a preparatory cleanup changing the code to use 'true=
' and
> > > > 'false' as needs_force_resume flag values for consistency.
> > > >
> > > > Patch [2/9] makes pm_runtime_force_suspend() check needs_force_resu=
me along
> > > > with the device's runtime PM status upfront, and bail out if it is =
set,
> > > > which allows runtime PM status updates to be eliminated from both t=
hat function
> > > > and pm_runtime_force_resume().
> > > >
> > > > Patch [3/9] causes the smart_suspend flag to be taken into account =
by
> > > > pm_runtime_force_resume() which allows it to resume devices with sm=
art_suspend
> > > > set whose runtime PM status has been changed to RPM_ACTIVE by the P=
M core at
> > > > the beginning of system resume.  After this patch, drivers that use
> > > > pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPE=
ND which
> > > > may be useful, for example, if devices handled by them are involved=
 in
> > > > dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND=
.
> > > >
> > > > The next two patches, [4-5/9], put pm_runtime_force_suspend/resume(=
)
> > > > and needs_force_resume under CONFIG_PM_SLEEP for consistency and al=
so
> > > > because using them outside system-wide PM transitions really doesn'=
t make
> > > > sense.
> > > >
> > > > Patch [6/9] makes the code for getting a runtime PM callback for a =
device
> > > > a bit more straightforward in preparation for the subsequent change=
s.
> > >
> > > I can't find this one. Seems like you did not submit it.
> > >
> > > Perhaps make a resend and fixup the patch-numbering too?
> >
> > I'm going to send a v2, but the patch in question is here (wrong number=
):
> >
> > https://lore.kernel.org/linux-acpi/3306233.5fSG56mABF@rjwysocki.net/
>
> No, that's patch2 (which was named pacth0). :-) Nevermind, I think we
> made some progress so I am awaiting a v2 before continuing my reviews.

OK

