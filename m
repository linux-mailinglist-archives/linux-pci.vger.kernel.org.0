Return-Path: <linux-pci+bounces-2923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118A8459AB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD501C21447
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6815D46C;
	Thu,  1 Feb 2024 14:10:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD945336F;
	Thu,  1 Feb 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796649; cv=none; b=bzG3PH7QVZcqTN9GY547GCrSHtGSkLPf2XYoJjUEp8PoO6PnSiq4tRdERTv64GU34skEAWXosKlcwyAo/p2TfV+43j5HTrhTl/CegXEtAQGNXD6ruHH/4+yW7xuueAlT0GwW5jSVyKP4zyvBl8v8EjzpisEJO3TBxww2I2LZOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796649; c=relaxed/simple;
	bh=ZzJAnFopgXtUp/MZ8wd6y70eEPMK4Crhr3GzEyKhfrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMxQ9+SI61ec3Vu1TgxqlxIolW3l4FeoE9CYz16GIJcbBnZeJGX8p/MpxuuOxEbjvKwfQEipFCTOuxbdkFu5rMGccJMunsiK+m07Agg082vvuGn0eHrqxAa9xcgn1WCj0ugmwelu7KU1XdChNWvWjTSU+sfQ42K543gdZsThEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5958d3f2d8aso318037eaf.1;
        Thu, 01 Feb 2024 06:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796647; x=1707401447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUcoutuuYV0W/tmDttHwWrWuMEiVRzV2LcjUCK9ipgY=;
        b=KXMIaLqgOa1PS7qRulpYF0MUjtnzzQCfkuy2VkjecPlBhcz84cUq3BrvbUkc958IjQ
         bAHK9jhSO78wk/+J9t008ySCNqe0wyqNAcUwPpkhRXvQGZIH3pPDBDrNAy+dwdyymYCc
         8CX/LPQg+XlqlmbsFTnfgMg4/ytSdKE+8OgaPLR1JoiWBjaBnBLYMZVPnfk4QaSKAQdU
         uLAvpa5EsibA4gmBUEP+r25WGx654tasgVl1o/BaSDJYyQNsNLf81QRfR5ysbsHu1VmF
         cGftPXQj+dGSceWsu1aOAzlbHFswwJnyZLbRG+kglCF/z8eCOYKulY7EHSslSrBKGWtI
         VU7w==
X-Gm-Message-State: AOJu0YzUkiWsDz5uYXQEiYL1qPVsgf4U1bHt6TXVaQxsN1Zki46L1fHc
	nHPU4eCaCv9iWaj4VG0/wksRDNDyGfhcSOJeNnXHJ8qGCyzfbQGNpY0Ggk+7Jsfisod0v4kbdlL
	Ww93P4fgKEI+oTh4N/1nCm83E/Tw=
X-Google-Smtp-Source: AGHT+IHk7NH4+5X8+SjrpcskygqQU0nqIiHtCph5BgiOqmchBJ3x7Xscx2ILUrQGQIyUl3tSFor++yAUhH8YGbSRYHI=
X-Received: by 2002:a4a:ee92:0:b0:599:a348:c582 with SMTP id
 dk18-20020a4aee92000000b00599a348c582mr2800787oob.1.1706796646993; Thu, 01
 Feb 2024 06:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>
 <20240130001436.GA488226@bhelgaas> <ZbtmB2GXPIwW1fLl@linux.intel.com>
In-Reply-To: <ZbtmB2GXPIwW1fLl@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 15:10:35 +0100
Message-ID: <CAJZ5v0gsojXKwQk4CL9ZpENcFs7X9pywfwNG-_ech5_G8pHRVw@mail.gmail.com>
Subject: Re: [RFC] PCI/AER: Block runtime suspend when handling errors
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:36=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Mon, Jan 29, 2024 at 06:14:36PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 23, 2024 at 10:00:16AM +0100, Stanislaw Gruszka wrote:
> > > PM runtime can be done simultaneously with AER error handling.
> > > Avoid that by using pm_runtime_get_sync() just after pci_dev_get()
> > > and pm_runtime_put() just before pci_dev_put() in AER recovery
> > > procedures.
> >
> > I guess there must be a general rule here, like "PCI core must use
> > pm_runtime_get_sync() whenever touching the device asynchronously,
> > i.e., when it's doing something unrelated to a call from the driver"?
>
> Clear rules would be nice, that's for sure.
>
> > Probably would apply to all subsystem cores, not just PCI.
>
> If they have something similar like AER.
>
> > > I'm not sure about DPC case since I do not see get/put there. It
> > > just call pci_do_recovery() from threaded irq dcd_handler().
> > > I think pm_runtime* should be added to this handler as well.
> >
> > s/dcd_handler/dpc_handler/
> >
> > I'm guessing the "threaded" part really doesn't matter; just the fact
> > that this is in response to an interrupt, not something directly
> > called by a driver?
>
> Yes. I added "threaded" just to emphasis that it's safe to add sleeping
> functions there. In context of possible solution, not related to
> the problem itself.
>
> > > pm_runtime_get_sync() will increase dev->power.usage_count counter to
> > > prevent any rpm actives. When there is suspending pending, it will wa=
it
> > > for it and do the rpm resume. Not sure if that problem, on my testing
> > > I did not encounter issues with that.
> >
> > Sorry, I didn't catch your meaning here.
> I tired to write two things:
>
> First, pm_runtime_get_sync() after exit prevents possibility of
> runtime suspend, so we are sure device will not be powered off
>
> Second, if during pm_runtime_get_sync(), there is pending attempt
> to suspend device, it will be synchronized and device will
> be resumed.

Not exactly.  pm_runtime_get_sync() will resume the device
synchronously no matter what.

> This can be problematic as device is in error state.

If this is a real possibility (I mean, device in a low-power state and
in an error state at the same time), it would be better to call
__pm_runtime_disable(dev, false) instead of pm_runtime_get_sync(), as
that would prevent runtime PM from changing the device state.

> But at least from software perspective we should end in device
> being in active state and then we can perform reset of it.

I'm not sure about this.  It may be better to power-cycle the device
in D3hot instead of attempting to put it into D0 beforehand.

