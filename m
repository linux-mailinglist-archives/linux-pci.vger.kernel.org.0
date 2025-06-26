Return-Path: <linux-pci+bounces-30705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2AAAE9B16
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910C53B40A2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5D221F39;
	Thu, 26 Jun 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0Ry1Z2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55D21A458
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933267; cv=none; b=sEIbRB855v09cpg5KvKoVf95LYhX3lcmE7CFGyUsrQv8kue9nqogAmR+z7VUgzf4tEdp6h+LPbAvYmiYrejvi+wZn2J5vFvl5RRXA9CgDbDj1G1KmTJfqbHCLl+/vLd21+woWiDousRD5XOOIwLotTUaTUMjj5QaJOjMGc/1Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933267; c=relaxed/simple;
	bh=c08UXPYZtjpEMhL4kGvfOaWGJO+poU22yY2ilFqSmcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcEoXI/h4Ss09bqNm0nFCJ3m8/e+DWBQUd12UrA83Rzvjs/UbLyszyXTXeii0KBZa+mDKRmyAjFVMGUT4JRJjrdk+PvSd7DnkObi+zVbB4fYPC1g06QAdLZ1PfWruzfsFrW0kXZ+4/b8Vm8MerxDtn/R2UDb7op5q2FU9yRKK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0Ry1Z2r; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso678921276.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750933265; x=1751538065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgWe1yEUe01r1E8Tw1sTfxB+GfHH0ZziUvZh1CX89D4=;
        b=j0Ry1Z2rbrHJ+ZMvicemzIgGcSDadTcbHP3hHnFupm7bwKB+1XyO2EgBX32uMDgBOG
         2mbz9ms0z3BUkx6d2Dt4mfp60k9dTQyO5Ft4WV6ZOioSbXFbLittcGKI83+08NqhM9gp
         +pyBuETk9YzhYzlEEyqRB5Lok9YIoMMN8a9t0OoEf6HsS5pIBqvTJGF3ZHaBFNaNIggW
         cH/eoY85HSVulwaAjccdTn+0il4MRKcNKKHNbQssidnyJM/kcNjpHwvIje+dhdTwXZ5e
         sF1Pnasi/hgGsqMMyrvct6YbCM14/wGAfbULuJPQJabimZjQzyz7yfWtxy6M1aysRcTf
         HGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933265; x=1751538065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgWe1yEUe01r1E8Tw1sTfxB+GfHH0ZziUvZh1CX89D4=;
        b=eg0XYE9RqTdLgq6z6TcvvwtVuapIkVjqRwtq7smrcaC4PquNjMB2R1OxEoxwLIIMwm
         F/p5HGn+BfuiXeWg/etZOKnCdY52RYz07rh+k5K625Nvp3k9PmwGabkzx9vKOQF5fZt9
         duxn06dJt/77H9pawJ26CAEh8hug6VI8AhWrQZMZutOFztWt4sgOKmHL+7NQDel87nfR
         dQCIrkUzu9gJtwFMBBPv6sq9nBC0RNW1IzfFBHMSFyXyEoE+NcOA7v8osbeZ/XLg6RVj
         tGgvx0GeZ+alKjXx8F9B+AbQN92GVDf0rnStull2UcskN5wOKOQOf8JNMGPLqLzoyGDY
         JCeA==
X-Forwarded-Encrypted: i=1; AJvYcCX3I66ZnW10PBz888F5XBUkhDE74lbLT/tT1dTAnsGWJN7OkZDxTam6DdmK27ZMFmEPyH8GiV1exYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kuK/2FUWXFvcbst0UWRPlnhGQGlASfkqFt5+WK1R/uK8EAiC
	+xkyMTPS7wrm4PaEmSOeOn3iRIaOV2gFJnPUgI23chrx7YRw0iB00jcYHvQWugYqgptZ2D/ioY+
	NVnir3fk+F2O7e+2KdFfJulrdt03EvMhOo0PFkk02+A==
X-Gm-Gg: ASbGncsJe0RND8matorRmhqbQc1AUI+b4rrr27KfXjX60kuJ7bRvo8uM62s5Vq/+h0C
	Rqk7Ss0bcbxKsYOoRRHIEhFZ4cA+WuMp3Ej/3si4PvRxCGN2XMWjKV8hXxrGmxusjsrzzrRk+Di
	t1t7/iEVjjNeerbcUZxzq9yZy+scWd6wqNsRNdLaKRJ7c6
X-Google-Smtp-Source: AGHT+IEyk3mms1+5t/8MuCL0xllpmb6YLFcWeRD/hQ0f5nW0B1ALuSQjWxbP5EYpCLmojQnL9hQoN2Or3EhNmCkqm78=
X-Received: by 2002:a05:6902:2b90:b0:e84:2adb:2548 with SMTP id
 3f1490d57ef6-e86017a744amr8247814276.24.1750933265396; Thu, 26 Jun 2025
 03:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <2045419.usQuhbGJ8B@rjwysocki.net>
 <CAPDyKFq8ea+YogkAExUOBc2TEqi1z9WZswqgP29bLbursFUApg@mail.gmail.com>
 <CAJZ5v0h-9UnvhrQ7YaaYPG5CktwV-i+ZeqAri8OhJQb4TVp82w@mail.gmail.com>
 <CAPDyKFoW5ag69LBnxvP5oGH1VAErBn17CAOzh=MX2toxAHwLxA@mail.gmail.com> <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:20:29 +0200
X-Gm-Features: Ac12FXxpBZ3tZsz4pEVg98bpJK1QwSul4p2Gdnai6PYvcQNw3Uyzytb7ot0tbss
Message-ID: <CAPDyKFpnvg3w9B_R7F-xrhXU+upFSJv5c=buVR5FyFnqoach_g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] PM: Move pm_runtime_force_suspend/resume() under CONFIG_PM_SLEEP
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 at 12:13, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Thu, 26 Jun 2025 at 11:41, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Jun 26, 2025 at 11:38=E2=80=AFAM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > >
> > > > On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Since pm_runtime_force_suspend/resume() and pm_runtime_need_not_r=
esume()
> > > > > are only used during system-wide PM transitions, there is no reas=
on to
> > > > > compile them in if CONFIG_PM_SLEEP is unset.
> > > > >
> > > > > Accordingly, move them all under CONFIG_PM_SLEEP and make the sta=
tic
> > > > > inline stubs for pm_runtime_force_suspend/resume() return an erro=
r
> > > > > to indicate that they should not be used outside CONFIG_PM_SLEEP.
> > > > >
> > > >
> > > > Just realized that there seems to be some drivers that actually mak=
e
> > > > use of pm_runtime_force_suspend() from their ->remove() callbacks.
> > > >
> > > > To not break them, we probably need to leave this code to stay unde=
r CONFIG_PM.
> > >
> > > OK, pm_runtime_force_suspend() need not be under CONFIG_PM_SLEEP.
> > > That's not the case for the other two functions though AFAICS.
> >
> > Right, but maybe better to keep them to avoid confusion?
>
> There really is no point holding pm_runtime_need_not_resume() outside
> CONFIG_PM_SLEEP and pm_runtime_force_resume() really should not be
> used anywhere outside system resume flows.

Right, I am fine moving it if you insist.

>
> > At least the corresponding flag is needed.
>
> What flag do you mean?  If pm_runtime_force_suspend() does not go
> under CONFIG_PM_SLEEP, needs_force_resume will not go under it either
> (so I'll drop the next patch altogether).

Yes, that's my point. needs_force_resume needs to stay within CONFIG_PM.

Kind regards
Uffe

