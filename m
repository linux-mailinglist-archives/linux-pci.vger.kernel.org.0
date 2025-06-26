Return-Path: <linux-pci+bounces-30743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D684AE9BD0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E157B0E56
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A4521CC74;
	Thu, 26 Jun 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfiOy7XV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD221771B
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934509; cv=none; b=ftt3aLfIX8jQtZg71Q6fHJNXDkRqanuMlGQ6zoTo9B+h8sU96MtSmtaL5wNmCcb3oyICZm+Zq4Z9ru8umewXDexd08UOTfpEaclPICZByf2KGtFAB5D0tq9ET9X+g4adktqU/EQLF56bHy1fEnWyaEfOt1Ujq2Gncd+e8tE1yQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934509; c=relaxed/simple;
	bh=nMga8Hlx1d8YQZxYJQUUac9Ug2xf3AsX8cJdwsg9p94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldCvSvA9qurVvBZgasDAo2XuVe2UuK55HhdqLAEDSrJIxLuv+q+Es9B7I43LFNSD4D50cP/dgm9Hz3oTu+pOGdc6Fei35WnxrHghroe7Ey5jzOmjCNQ0hCO3L1qbkriX/bPOsmbxpeNilUxxz4ViXCNhr/07doOp9AoznID44qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfiOy7XV; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so1880512276.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750934507; x=1751539307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6smS0W1Hv8ri7J2+gsifIwuwqRILJtZpojLMB8JtnBs=;
        b=LfiOy7XVCmWcTaJlHS0w5LwsI5UBxOkMXgpkK06HXte0uj+hX0bRsYnLhLzhTWsbjt
         oOHLsNWw35cqRdKLIZNDHyS1iPF/sj9ltxfTTRsaHynCz4xjyBdn3Rq8GhfM/rpc5DDp
         lFDCDJv9N8a9kaj07XPnmGkD0W/uV9plIjYLrKlfKHg7jh4Kdx2qREaFbCErR5qdeKCI
         /htZoScJmRMjvRnnjnreuQVs+qLtBp+8JgeBM8FXO0DI5aoNIx8UcRjpAx2m4U9dB/mQ
         gnC2Ac/PZ0gM1PsolHYNP08fsAr5d/VSlDbWJYWr2Vecj+QDMEDHxcX4tzfjULz8Olgf
         FDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750934507; x=1751539307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6smS0W1Hv8ri7J2+gsifIwuwqRILJtZpojLMB8JtnBs=;
        b=ONE+xW9wRUZrPoPjLbxqPIVuN0FjtBWDGWft1bt/+HArNfeQk4p2Vks0kG2TA0gnLf
         lG2p/ztdNk1KbDbqxlKerqUFEqfU3usz15tAmQuZNcmQ6l728uxJjztOYeP6TfYhGijz
         MFGEZEFbzUBaoylLyn0NvNUNEwY/RV+VY6nE4dhdSdwWtKXJMDT/glbT4+0Hu7B5Yqx7
         0Va1+gOo+2sizX/iCpjZeBh0DJR/kFmC42qd4mGfUSXURRJXCBcgE4L7KTmlQDj+gFCk
         Fp+e7sP2WiCRpmc2qwnWjmNOl9lXrMdUTgud5nKLMmZPLfKKNzhxJ55Wr9bKZ+b0k1Py
         jkFg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Z1oLvoFonxsvzg11yIxO1uikJ+h17U0F6hO6Sz1DK/lBVGkZqbaUdSbu3zf3dXY3GgpPRiNyA1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5svSDnvgkxKuRBgrjYGehrJP17c6lxUnoQntKy4SuS3wCznWD
	Wv+Ty+hONwrbX+tPN96GbBwyNW89Mgw9av4b2E7eGzmdt/NG6DqRNFhVL3eYG5XLKX9opYHRQtn
	fa4Dj7d4IBLARBnQILFnI6fkNrOjOCNy6ZfTm3I/wFrzcowC7L7RC
X-Gm-Gg: ASbGncvNVlLkFwZEL3ZtjJ5JsygOhYCsoUeVddZY2BesoMeF5CrqfOce2auyb9KpGTr
	w05iVxnksORA4ZPfaRozZ9T44y+W0oqRGuYRzlu6so+KrVqRdt94jebxEk5aJqus3h+htz1bEPB
	a+DGWuZwKK5cXtiQJhzWenKW1NyDrOnskPnoZufdi889zb
X-Google-Smtp-Source: AGHT+IHlcCR9Jque2M5f7A2Se7ACxnVKmY2chOHS36SADEkUcKjizS/3bQ31EnnCoHr4T6PMwYyajw8366/m4yuUyAY=
X-Received: by 2002:a05:6902:1893:b0:e87:a1f2:5ccb with SMTP id
 3f1490d57ef6-e87a1f25e37mr1038329276.19.1750934506681; Thu, 26 Jun 2025
 03:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <CAPDyKFpZVdf2EnZE_u1xDKB7=Nd98a_ajYimQhLBu6jYwJhJFA@mail.gmail.com>
 <CAJZ5v0irk8n0MzRm=u8k=+Mtq84r7JsazS10DsvHO4ktgW=AMQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0irk8n0MzRm=u8k=+Mtq84r7JsazS10DsvHO4ktgW=AMQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:41:10 +0200
X-Gm-Features: Ac12FXylM7_NHVK9qHL5zh8NJNZgaIJfq0i5vr57JOQ0VZWL8G55_18t0MWABxQ
Message-ID: <CAPDyKFq7gydO0uioA53LqXk-N+Bjp4bwkaRRzMeWv+F=zpy2Jw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 at 12:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 12:31=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wro=
te:
> > >
> > > Hi Everyone,
> > >
> > > This series addresses a couple of issues related to the integration o=
f runtime
> > > PM with system sleep I was talking about at the OSMP-summit 2025:
> > >
> > > https://lwn.net/Articles/1021332/
> > >
> > > Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
> > > pm_runtime_force_suspend/resume() due to some conflicting expectation=
s
> > > about the handling of device runtime PM status between these function=
s
> > > and the PM core.
> > >
> > > Also pm_runtime_force_suspend/resume() currently cannot be used in PC=
I
> > > drivers and in drivers that collaborate with the general ACPI PM doma=
in
> > > because they both don't expect their mid-layer runtime PM callbacks t=
o
> > > be invoked during system-wide suspend and resume.
> > >
> > > Patch [1/9] is a preparatory cleanup changing the code to use 'true' =
and
> > > 'false' as needs_force_resume flag values for consistency.
> > >
> > > Patch [2/9] makes pm_runtime_force_suspend() check needs_force_resume=
 along
> > > with the device's runtime PM status upfront, and bail out if it is se=
t,
> > > which allows runtime PM status updates to be eliminated from both tha=
t function
> > > and pm_runtime_force_resume().
> > >
> > > Patch [3/9] causes the smart_suspend flag to be taken into account by
> > > pm_runtime_force_resume() which allows it to resume devices with smar=
t_suspend
> > > set whose runtime PM status has been changed to RPM_ACTIVE by the PM =
core at
> > > the beginning of system resume.  After this patch, drivers that use
> > > pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND=
 which
> > > may be useful, for example, if devices handled by them are involved i=
n
> > > dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.
> > >
> > > The next two patches, [4-5/9], put pm_runtime_force_suspend/resume()
> > > and needs_force_resume under CONFIG_PM_SLEEP for consistency and also
> > > because using them outside system-wide PM transitions really doesn't =
make
> > > sense.
> > >
> > > Patch [6/9] makes the code for getting a runtime PM callback for a de=
vice
> > > a bit more straightforward in preparation for the subsequent changes.
> >
> > I can't find this one. Seems like you did not submit it.
> >
> > Perhaps make a resend and fixup the patch-numbering too?
>
> I'm going to send a v2, but the patch in question is here (wrong number):
>
> https://lore.kernel.org/linux-acpi/3306233.5fSG56mABF@rjwysocki.net/

No, that's patch2 (which was named pacth0). :-) Nevermind, I think we
made some progress so I am awaiting a v2 before continuing my reviews.

Kind regards
Uffe

