Return-Path: <linux-pci+bounces-3124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF484A834
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 22:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF71F2C220
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10B13AA40;
	Mon,  5 Feb 2024 21:00:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07513AA55;
	Mon,  5 Feb 2024 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166859; cv=none; b=A5/bUK6JprjAYGWLPfRKtLUv/fBF8C86j0c2mnUOe89h6Avjh4z5QJ+us8QCwELJc5BFqGXDTzoqR4ndkGynNT6LvVEMSDR8io8LfifaoXcOno7cqBGMRwuYo5CY07+luuxMjlFW/TU6Ptucy2rV1W6/7Ou/i0UhN83e4thrbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166859; c=relaxed/simple;
	bh=l7FKlQD4v/fJVXaU/OVBxRPRgbK/LzZpdgmDxiaFLwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnltEvniwnq+5KwNs3UNzh2dFB0adQKaxATvSARBlyXNhBYN/dHyd/5tWdk5oBT3HcQPjDBHoUNxfkl2KybN29WQYYsJJe6+w9Z9T3j+Yx9+UnCV1JrWCqvEhQrKhBm++PfOcy5GUeYAd4O8pfZ6plTOKQwB6ilKgAuqnTFXB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5958d3f2d8aso2105291eaf.1;
        Mon, 05 Feb 2024 13:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166857; x=1707771657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jku9UYOIfNdVYt5yPuZzKf2+d2g+eXjQefMhJuaJpZk=;
        b=rYmrftu/ak0yufSz9fauIU4UWe/Nf6N+TYlvQN0SlNPkwlc8CFrQfYZ1YyFJf+6+IW
         UGr+fDhgAo5lnf/c2jkC/hzekPS6mbtT+Qk57Joq1qYzFoiwsFtMe8u1/G/nd9riRQJE
         AZmDGSTa9XabQc0tyleog5oF8Zvba7visC3Wq3P0I6TEbge2w8CofWx+pLBFE2fP4NPX
         CDBUHgZHOrRw2GbgrVVYSeHY+5KtQDsNkPtfO496XjKCmZcdio9W9GTpJ7djrhkJRIPp
         G5IHrgYBSagvMIWTioW4acFQgRbldaliVTTi8yg37iadHy78hsld7NhXkyEjgSzHw1Tj
         AsQA==
X-Gm-Message-State: AOJu0YwblCZzeukdLggOgvf5Wk+nio4XgLS0Sz2GvpmqY15jLRkF9V+E
	KqiNVjVVMZuNGva/nm20cRGYocJDX96KCk8KA581IDgQ05KQL6Lb7Duf0PJBv9/CNoYM82DrZcz
	BTry81NbCijOYbKv46eiiQNE4JzM=
X-Google-Smtp-Source: AGHT+IFVPUaP3KcFrhXuLa4e8qtunVlUE77Cz+Kusnj4//X+Z/lkQj/jHV5Q37e9yZUd+69EaQ8Ec4FLGSPxGNbGLMU=
X-Received: by 2002:a05:6871:5310:b0:218:f6be:b097 with SMTP id
 hx16-20020a056871531000b00218f6beb097mr825641oac.5.1707166856790; Mon, 05 Feb
 2024 13:00:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>
 <20240130001436.GA488226@bhelgaas> <ZbtmB2GXPIwW1fLl@linux.intel.com>
 <CAJZ5v0gsojXKwQk4CL9ZpENcFs7X9pywfwNG-_ech5_G8pHRVw@mail.gmail.com> <ZcE0wWb6/CGFTKi/@linux.intel.com>
In-Reply-To: <ZcE0wWb6/CGFTKi/@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Feb 2024 22:00:45 +0100
Message-ID: <CAJZ5v0hLXS1EJZgUPn_i6Sp1RNJ2tH1oJ6AKvAQAM4Um_bwHPA@mail.gmail.com>
Subject: Re: [RFC] PCI/AER: Block runtime suspend when handling errors
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 9:11=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Thu, Feb 01, 2024 at 03:10:35PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 1, 2024 at 10:36=E2=80=AFAM Stanislaw Gruszka
> > <stanislaw.gruszka@linux.intel.com> wrote:
> > >
> > > On Mon, Jan 29, 2024 at 06:14:36PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Jan 23, 2024 at 10:00:16AM +0100, Stanislaw Gruszka wrote:
> > > > > PM runtime can be done simultaneously with AER error handling.
> > > > > Avoid that by using pm_runtime_get_sync() just after pci_dev_get(=
)
> > > > > and pm_runtime_put() just before pci_dev_put() in AER recovery
> > > > > procedures.
> > > >
> > > > I guess there must be a general rule here, like "PCI core must use
> > > > pm_runtime_get_sync() whenever touching the device asynchronously,
> > > > i.e., when it's doing something unrelated to a call from the driver=
"?
> > >
> > > Clear rules would be nice, that's for sure.
> > >
> > > > Probably would apply to all subsystem cores, not just PCI.
> > >
> > > If they have something similar like AER.
> > >
> > > > > I'm not sure about DPC case since I do not see get/put there. It
> > > > > just call pci_do_recovery() from threaded irq dcd_handler().
> > > > > I think pm_runtime* should be added to this handler as well.
> > > >
> > > > s/dcd_handler/dpc_handler/
> > > >
> > > > I'm guessing the "threaded" part really doesn't matter; just the fa=
ct
> > > > that this is in response to an interrupt, not something directly
> > > > called by a driver?
> > >
> > > Yes. I added "threaded" just to emphasis that it's safe to add sleepi=
ng
> > > functions there. In context of possible solution, not related to
> > > the problem itself.
> > >
> > > > > pm_runtime_get_sync() will increase dev->power.usage_count counte=
r to
> > > > > prevent any rpm actives. When there is suspending pending, it wil=
l wait
> > > > > for it and do the rpm resume. Not sure if that problem, on my tes=
ting
> > > > > I did not encounter issues with that.
> > > >
> > > > Sorry, I didn't catch your meaning here.
> > > I tired to write two things:
> > >
> > > First, pm_runtime_get_sync() after exit prevents possibility of
> > > runtime suspend, so we are sure device will not be powered off
> > >
> > > Second, if during pm_runtime_get_sync(), there is pending attempt
> > > to suspend device, it will be synchronized and device will
> > > be resumed.
> >
> > Not exactly.  pm_runtime_get_sync() will resume the device
> > synchronously no matter what.
> >
> > > This can be problematic as device is in error state.
> >
> > If this is a real possibility (I mean, device in a low-power state and
> > in an error state at the same time), it would be better to call
> > __pm_runtime_disable(dev, false) instead of pm_runtime_get_sync(), as
> > that would prevent runtime PM from changing the device state.
>
> __pm_runtime_disable(dev, false) does not work as reliable in my
> test as pm_runtime_get_sync(), the
>
> igc 0000:02:00.0: Unable to change power state from D3hot to D0, device i=
naccessible
>
> message disappears, but sill have:
>
> igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> pcieport 0000:00:1c.2: AER: subordinate device reset failed
> pcieport 0000:00:1c.2: AER: device recovery fail

But what exactly do you do?

(1) __pm_runtime_disable(dev, false)
(2) Check power state
     (a) If D0 (and device runtime-active), proceed
     (b) If > D0, remove power (if possible) and put into D0

or something else?

> > > But at least from software perspective we should end in device
> > > being in active state and then we can perform reset of it.
> >
> > I'm not sure about this.  It may be better to power-cycle the device
> > in D3hot instead of attempting to put it into D0 beforehand.
>
> Me nigher, but in pci_reset_function() and similar resetting
> procedures we always call pci_dev_save_and_disable() before
> actual reset and it set device in D0, so I think it's ok to do so.

OK

