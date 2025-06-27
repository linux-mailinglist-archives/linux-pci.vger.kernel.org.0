Return-Path: <linux-pci+bounces-30910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F8FAEB3F4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0683B2FC7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C829B78E;
	Fri, 27 Jun 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV39J278"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A296296169;
	Fri, 27 Jun 2025 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019099; cv=none; b=HCkCJomS0yXd1PaGOnSMu4ATCv0jpvugmyVXwoe/WxHY44ctE5SWjkJ1VTajkit1S8L5EqY9ivO5jmxWko64lzf2qztj7A1GTghiINViXyxvDqyHXNPF706TGiPPBAVRWYSty06CsMmzYHGBxUxEhKUgI5jtlEjfqt3q46F+VCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019099; c=relaxed/simple;
	bh=pr2TNql3hThXDgKAMavYEjtYW0R2AuC56+PsUT6h0KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irDVyOV0uIKaeCJHgW8rS7w4Qj64rOeKlLAHTZKT36Ddao1BVNXUbd5drV/Kvkn+dcfNmu/eufw/zGi7HcmhaMC6nBmaB2pVScYpuzeqdZc2Qv9pmEa06p+WF3OlibCYE3cxuslB+nKeOizcson/gKOzVLPc6EPJ5ahleifRzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV39J278; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD3C4CEE3;
	Fri, 27 Jun 2025 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751019098;
	bh=pr2TNql3hThXDgKAMavYEjtYW0R2AuC56+PsUT6h0KM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TV39J278LTRvqD8rrIg+Hd0RqL6WeXmBCn2DAw1OfyDj23QebGFe3sUfJReZqRcrW
	 JgCK09LtgcsOFwmnASa7Zi7ixZXQiQBBfPhG8rE5Ngzpkl7m6OZiVxvCrgOyUg4cZs
	 viMsK9m8XxX3V92FQbgRrIEM5Xegnw5IA46TzVY0Fp7pYGsNa9tD2WbrzvF/AFQ6w9
	 UkK1+4+T9h+UnAYSY2N9+7pziG9PNY86mEGs9FMxEbhT7TeRqpq/Osq/HanTTex7Fj
	 atM5b+Rk+3gzxmo75psJ8vGhb1mibKUb9PPRhbUYr2Lk69RhOU9r7MVSmjndLhLrUi
	 4b5wQzr1Y+tyQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60d5c665fceso944356eaf.1;
        Fri, 27 Jun 2025 03:11:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm2iTtsncjUWAge49SQ6spg1VjnLgV1Hswl3g1cmYMIYS80ek3Hxx6fOab5GgW9fiXQo/PldNS9JIH@vger.kernel.org, AJvYcCVCmJQGTxI/5w51V1Nvbmzu00rHyFwNW3caFAD3qvRhUAHHEO+rPDxs1tvGfOzqZnu/zuSF+kOIZFtE@vger.kernel.org, AJvYcCW6Hm3rlM0hyxYd+ZC5lxcSeEfGeg2XbXP2Zolk74AD7MOG+dzQfScyROZGaPAQD16QVdVlklG8UVI=@vger.kernel.org, AJvYcCXtF345dz+XwmjzzwliCZSXkoVzosqlJ4fh2HoljjWPKK8v1pAkV8/ACb7nFSWdYe9UnREoD9XTYQbLbvnr@vger.kernel.org
X-Gm-Message-State: AOJu0YwFH7u4/A/IuWmhAaosqZUxEFto7dPBUmsvHlQTb8vynA/nwCFG
	eM+WIrqlGWAdDrLCDeEvqTn3wM8UtClphl0Eqp5tF8k79jMCICQ9qAusXgj5Ei9lYz+88TbICdt
	12CkCH61P6ans4rLDWMH/00b9qTA95sg=
X-Google-Smtp-Source: AGHT+IHKFy5vLlUe15/yzSikt6vQUk2IusHi96SQuGMqrHseBGhPTAoSr+tw0f3d70e/5HH6fGJ5+Fd0mksP129g1KY=
X-Received: by 2002:a05:6820:2085:b0:611:5132:6296 with SMTP id
 006d021491bc7-611b90e52d6mr1561486eaf.4.1751019097776; Fri, 27 Jun 2025
 03:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1952931.CQOukoFCf9@rjwysocki.net> <20250626205923.GA1639790@bhelgaas>
In-Reply-To: <20250626205923.GA1639790@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 12:11:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jH8m06r1thobzxHsQFwYUkY_6jPyQViXGFY6PsUFThow@mail.gmail.com>
X-Gm-Features: Ac12FXwA8xkD7X7FbWDgBnwmFupdV7LVC82L0ibNqUcSI1XeVBkaSPJjLUn0ua0
Message-ID: <CAJZ5v0jH8m06r1thobzxHsQFwYUkY_6jPyQViXGFY6PsUFThow@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] PCI: PM: Set power.strict_midlayer in pci_pm_init()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:59=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, Jun 26, 2025 at 08:15:05PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The PCI bus type does not expect its runtime PM callbacks,
> > pci_pm_runtime_suspend() and pci_pm_runtime_resume(), to be invoked at
> > any point during system-wide suspend and resume, so make it express
> > that expectation by setting power.strict_midlayer for all PCI devices
> > in pci_pm_prepare() and clear it in pci_pm_complete().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Previous PM-related patches in drivers/pci/ use a subject line like:
>
>   PCI/PM: ...

Sure.

> Would be cool if there were hints about what
> dev_pm_set_strict_midlayer() means.  Maybe the comment in
> get_callback() is enough, but it takes a little work to find it.

OK, I can add a kerneldoc comment to it.

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> > ---
> >
> > v1 -> v2:
> >    * Set and clear the new flag in "prepare" and "complete" to allow
> >      pm_runtime_force_suspend() invoked from driver remove callbacks to
> >      work.
> >    * Update subject and changelog.
> >
> > ---
> >  drivers/pci/pci-driver.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -708,6 +708,8 @@
> >       struct pci_dev *pci_dev =3D to_pci_dev(dev);
> >       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> >
> > +     dev_pm_set_strict_midlayer(dev, true);
> > +
> >       if (pm && pm->prepare) {
> >               int error =3D pm->prepare(dev);
> >               if (error < 0)
> > @@ -749,6 +751,8 @@
> >               if (pci_dev->current_state < pre_sleep_state)
> >                       pm_request_resume(dev);
> >       }
> > +
> > +     dev_pm_set_strict_midlayer(dev, false);
> >  }
> >
> >  #else /* !CONFIG_PM_SLEEP */
> >
> >
> >
>

