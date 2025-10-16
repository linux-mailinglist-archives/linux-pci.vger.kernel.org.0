Return-Path: <linux-pci+bounces-38395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E484BE569C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF735655B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383A2DF6E3;
	Thu, 16 Oct 2025 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMO/9uoz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC62DCC08
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647128; cv=none; b=q8f3k/Ri1qpF07xAttXptVXjf1n9vAvS9ZAh6erhacua/5/Mc+ob7Oo7Y1yBL9KkPW3eQduvzoumNIrqU0+xwssxv6L3/l9hT1yEx82li54CkID1N6WAMl9vX33FO5DZflbihj9Yz3sM08ehbAiwf34ntqpjfhSTxsxdTvlvwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647128; c=relaxed/simple;
	bh=XTIlb00y7jKvl1Otn5ZrCsdMlwiiEfx7RWVXZYlBVac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn5cKjbYkI9oN5StfX267vbhSScpqjl2HV8LLOIOfYN62eu5vyYsBz7IUo5UUoGnTSTuJ9YM/UPgnVsvT1xUS6RpAJ5boSPo4oqpz7FCHq9XlMGpCq7o5SfGYdRXc3hqrVYB3LUmnELxIPwe1RZh0hkygiNPSUVnJ1l0y7vV2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMO/9uoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F83C4CEFE
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760647128;
	bh=XTIlb00y7jKvl1Otn5ZrCsdMlwiiEfx7RWVXZYlBVac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IMO/9uoz9402Rq/72H+fzGiweWdOTANK8n3P07wAJEwSUsdk1cojA6DdXdoUReOuM
	 9yRQuePM2+cOtswdJoYIhd/7qJV8nzqzQSJr2+dDcU5u4y1GrU+vcOIl/iZf87rDak
	 1COlMuvVJcUWEIg+dtRJ6YLOZPkcURXFwMbqrTAPjjlOi95k0KYUPg3eegkG/zv7BR
	 +nYcP+d7q9IMmogzk+uLypcyOnxtrMpX2A9mvGunrLvmyGD3Y02hiRRZ7aP6U22+13
	 OJxP5Q7aWOdRqJ+giiFiywbX8RpK9G0JyZn8Azgu8ZdjUv+A+sNGckCq0Jg7xWwDMu
	 RzhQzyAeNNRXA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-43fb60c5f75so288161b6e.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 13:38:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHX9CCIzbf6qfGyvKuoNgbBq8x2RvyKvK54LKkeEHh04qZE+tPBxAomHZ+5tpJa4s/7IWKBYUaM8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6Z/8/+Yzy9H/fqCYrU+oP7Fixvo6kFUXH9KTHhZbJ3sO3vqo
	zNMf5NpfAZ1eGjDZlI1rsf3IYNanyzYSsbMRLgeQkzfCq06g7UbF7WOT8nW+YFkrcwZvBPmW9vb
	YR6cn2a5FBy+wTnrly23oJqlCJEVhn0w=
X-Google-Smtp-Source: AGHT+IHeni4wRtDvxXTKZAACGsTAPxwB1YyN0NYvoLAG+cyBLP79pAf7CDk+uKKMzHt4n9NJ/Pkc8WVtYd2NS5a16ZU=
X-Received: by 2002:a05:6808:6f8e:b0:43f:7dee:468b with SMTP id
 5614622812f47-443a2dcb6d3mr672131b6e.4.1760647127720; Thu, 16 Oct 2025
 13:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3925484.kQq0lBPeGt@rafael.j.wysocki> <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
 <875xce7m11.wl-tiwai@suse.de> <12765144.O9o76ZdvQC@rafael.j.wysocki> <68f14b5b6a92_2a2b10018@dwillia2-mobl4.notmuch>
In-Reply-To: <68f14b5b6a92_2a2b10018@dwillia2-mobl4.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 22:38:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZJFQeBhA7tM-sWuJDtisvrHGjPPdQHrC-eXXF1xJpbA@mail.gmail.com>
X-Gm-Features: AS18NWCN60rGQYTojeNqhxmPLJuY9IXf_MfoZ5rdwA1XGpcY1kgT-SGMUWeS1hQ
Message-ID: <CAJZ5v0iZJFQeBhA7tM-sWuJDtisvrHGjPPdQHrC-eXXF1xJpbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL()
 macro
To: dan.j.williams@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:45=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Rafael J. Wysocki wrote:
> [..]
> > > > [1]: https://lore.kernel.org/all/CAHk-=3Dwhn07tnDosPfn+UcAtWHBcLg=
=3DKqA16SHVv0GV4t8P1fHw@mail.gmail.com/
> > >
> > > Yeah, I myself also find it suboptimal, hence it wasn't really
> > > proposed...  It's a limit of macro, unfortunately.
> >
> > The macro from the $subject patch can be split along the lines of the a=
ppended
> > patch to avoid the "disgusting syntax" issue, although it then becomes =
less
> > attractive as far as I'm concerned.  It still allows the details unrela=
ted to
> > the rest of the code to be hidden though.
> >
> > ---
> >  drivers/acpi/acpi_tad.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/acpi/acpi_tad.c
> > +++ b/drivers/acpi/acpi_tad.c
> > @@ -31,6 +31,12 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Rafael J. Wysocki");
> >
> > +#define PM_RUNTIME_ACQUIRE_ACTIVE(dev)       \
> > +     ACQUIRE(pm_runtime_active_try, pm_runtime_active_guard_var)(dev)
> > +
> > +#define PM_RUNTIME_ACQUIRE_ACTIVE_ERR        \
> > +     ACQUIRE_ERR(pm_runtime_active_try, &pm_runtime_active_guard_var)
> > +
> >  /* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
> >  #define ACPI_TAD_AC_WAKE     BIT(0)
> >  #define ACPI_TAD_DC_WAKE     BIT(1)
> > @@ -264,8 +270,8 @@ static int acpi_tad_wake_set(struct devi
> >       args[0].integer.value =3D timer_id;
> >       args[1].integer.value =3D value;
> >
> > -     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > -     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > +     PM_RUNTIME_ACQUIRE_ACTIVE(dev);
> > +     if (PM_RUNTIME_ACQUIRE_ACTIVE_ERR)
> >               return -ENXIO;
>
> This defeats one of the other motivations for ACQUIRE() vs
> scoped_cond_guard() in that it drops the error code from
> pm_runtime_active_try.

No, it doesn't.  PM_RUNTIME_ACQUIRE_ACTIVE_ERR is that error code.  Or
did I misunderstand what you said?

> Maybe it is the case that failure is always
> -ENXIO, but from a future code evolution standpoint do you want to
> commit to always translating _try errors to a local error code?

No, I don't.

> Btw, was acpi_tad_wake_set() buggy previously for ignoring
> pm_runtime_get_sync() errors, or is it a regression risk now for
> honoring errors?

You may call it buggy strictly speaking, but it just assumed that if
the runtime resume failed, the subsequent operation would just fail
either, so -EIO would be returned to the caller.

This change allows distinguishing resume errors from I/O errors.

