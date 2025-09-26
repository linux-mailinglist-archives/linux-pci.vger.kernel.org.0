Return-Path: <linux-pci+bounces-37103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625BDBA4434
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290317BFAE6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B7317C220;
	Fri, 26 Sep 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmu1C13C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B9136E37
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897424; cv=none; b=YRbh3Ipy903XIGiCHH0zIKhzCRuPQgZCbtlBzPRKtnRN1xZtelie2IczE3Ilfknh0RuJFix4QLgv1VoOqHRAPQdtcLfgvPnqd/VtxqsPsClg785ad7wxnfCS6LR30Y9+0H1V/x7FMiPBh7HsUCR0y7rzZSezkVVQS9dLfP9Ow48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897424; c=relaxed/simple;
	bh=McOvrX4wj78cGQOx3sLC5HL9qLBnHjTdzFimT+Exbnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvjuK2D2m1ADBebs0hd78WPVFFC2olvuDiZAbOyBdt6zynYQayfQjsJh5gD9UlLkW9WG5/zwdPh20QFjfZGvkrs2ofEyTbBm+rrbA4JLHQ0nSmw354GF4NlTv7a/w7bSW/Zb93nMPm3B+AcgIJlrF+aHVf9aI5SI/aGNjS0VPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmu1C13C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF312C4CEF7
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897423;
	bh=McOvrX4wj78cGQOx3sLC5HL9qLBnHjTdzFimT+Exbnk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dmu1C13CBUv2QsHVZhhSAnCUe2MrZAiaklExiBdYlYRPOZ7pGkDBGwhwmIovM3yiZ
	 LRSL/hqukAHLEntLR+ze1in3w0K8ZG6QQTNiv+YOwi3gRdbpLUM4+DaXapZX5bK74n
	 4OqsmXiycEHWYuIFSf6RqhwcZb7Ul2iBPALWn/T7jPACGGpz22nC2bqEJ4qNuFqbT4
	 8hMmajP4YEHf+isVrTD/JVY8opAQc3flGupLouvYOBGfOzSv3FYkqGOW+BFAT4/x64
	 XXLOa4ss+8Lzje3nNGWPkwD/BCj/ySlQz/ZPeFj8L0QuS3isCGH/CK8GfcbBw6Kfet
	 I2gkxTp07Uggw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-321289dee84so1183382fac.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 07:37:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOZWKtblPBcUH/xWmrH2YgctF9didee8OZLHqPKIgWFIG/pvTX1XxsXc6YWh0Immm6HJuIldlmkGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRpaWQVtHZLUTKDmizeg6lrbxhiXrSPhW3fUl4ORZdJ7H1Epk
	GvHkUpJ4H0gbuxQIo2PX8v9hei0JU8B8SHbdww15NpE1OPFWjEKVoloXzLo1MythhqbGAse84QI
	OhbFNmN1C18ELzMHeMrEKB7bXWgPceDg=
X-Google-Smtp-Source: AGHT+IHzJ5VHAQN5ur5bEw/qgsV5RKx13TNkFmz4sgYMBFaXxyVEx7NkpTPBLstxWDr8QPcBcnH6NBLLtANIovzyGXY=
X-Received: by 2002:a05:6870:78e:b0:348:7139:66b8 with SMTP id
 586e51a60fabf-35ee8f14033mr4203895fac.38.1758897423016; Fri, 26 Sep 2025
 07:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049058.31r3eYUQgx@rafael.j.wysocki> <2245131.irdbgypaU6@rafael.j.wysocki>
 <20250926144947.00002f75@huawei.com>
In-Reply-To: <20250926144947.00002f75@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 16:36:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gnqoJ8bALZT61ZvTA=chp8y5QBiA7ZpNQ6fFJuQzZUnA@mail.gmail.com>
X-Gm-Features: AS18NWC_urfmTBRO_qa1bgc839FuKdltpjzqgiWLObAMHP3YF4IDfysgJErpYOg
Message-ID: <CAJZ5v0gnqoJ8bALZT61ZvTA=chp8y5QBiA7ZpNQ6fFJuQzZUnA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PCI/sysfs: Use PM runtime class macro for auto
 cleanup in reset_method_store()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 3:49=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 19 Sep 2025 18:38:42 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Takashi Iwai <tiwai@suse.de>
> >
> > The newly introduced class macro can simplify the code.
> >
> > Also, add the proper error handling for the PM runtime get.
> >
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > [ rjw: Adjust subject and error handling ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/pci/pci-sysfs.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
> >               return count;
> >       }
> >
> > -     pm_runtime_get_sync(dev);
> > -     struct device *pmdev __free(pm_runtime_put) =3D dev;
> > +     CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> > +     if (IS_ERR(pmdev))
> > +             return -ENXIO;
> Hi Rafael,
>
> Why this approach rather than treating runtime pm state like a conditiona=
l
> lock (we use it much like one) and using ACQUIRE() / ACQUIRE_ERR()?

Mostly because devices are not locks.

> Ultimately that's a wrapper around the same infrastructure but
> perhaps neater as it removes need to have that explicit magic pmdev.

You'll need to have a magic pmdev or similar regardless IIUC.

Say there is

DEFINE_GUARD(pm_runtime_active, struct device *,
pm_runtime_get_sync(_T), pm_runtime_put(_T))
DEFINE_GUARD_COND(pm_runtime_active, _try, pm_runtime_resume_and_get(_T))

so the user of this will do

ACQUIRE(pm_runtime_active_try, pm)(dev);
if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
        return -ENXIO;

and there's a "magic" pm though pm is not a struct device pointer.

Maybe it's nicer.  I guess people may be more used to dealing with int
error variables.

Let me try this and see how far I can get with this.

> +CC Dan as he can probably remember the discussions around ACQUIRE()
> vs the way you have here better than I can.
>
> In general great that you've done this.  Was on my list too, but I didn't
> get around to actually spinning the patches!   This is going to be
> very useful indeed.

Thanks!

