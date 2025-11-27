Return-Path: <linux-pci+bounces-42199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF44C8E56C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053643A72F6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672DA21A425;
	Thu, 27 Nov 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGADcATq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E61EB9FA
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247924; cv=none; b=FJNeJhhxiVncQP3qx9UdxRvSn028ftK4Sytp93gMcW3WW56hXJOT9K3cpyCzMaRjURW+RnKWbBjlAVDLeC5oqCilPRqHIEuAMr3THKlVx4BJgJrsf4EgODr5UNJ3A5PC2o8iCWWC66bXMBsrNp5WV85GReXfzX2mIF1z00N9CVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247924; c=relaxed/simple;
	bh=RqG39jWJboJ3J2PHqXsCUlZnk7m8OLGCs0ly8p4o4OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXN2w4APgFXAMcYumaBU1hZUNW4syOrlvHJW9hKjSXX2iCju+HuS91nkjkSLu1PqIUFQp74uw0kH3CkjV7BAwM90pTGD4HxXLnxMnLwfuQ1WWyX0YAuTgzfYOOY5/LwmNHaHfMAymeQr/Thc3YQ5QL1OGaaAo9B11dqyAtB1Xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGADcATq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3DEC4CEFB
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764247923;
	bh=RqG39jWJboJ3J2PHqXsCUlZnk7m8OLGCs0ly8p4o4OM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DGADcATqOvlRALiYh1igVxDQkXNAkV97iGCuv9HAb9hUd8cw++BPxfNXUcjnKU7hQ
	 fjCru0OCKqy6zA1t7+XXZ+T5F32lSKsDNXaAaWj7gQIUydTkDxc22zwFG5Z3FB07xx
	 Pp0CdP4QC5P6H964IApfhurP6i6uGFwQsz5fS3/Lx6bBRuQrJ7mpGSdhDz75b+ErUK
	 +EyJHeCx+P8HOyc5JSYbjWerUnmSk+AKTjUxmmbrjbcZ/1FwVv4TbJnU7KxZFQP01H
	 RfDL2P20FPXFdMOss+eXJRuGmP6vSb30q1fF1e1ElkBOcWQIeZD0Gsq5+FkZTRvHLJ
	 QUFfnCO4zpb0Q==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6579872f00dso334607eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 04:52:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWG4lCn4P1RhiN2C/5UjPRuXYsQhJ1U5xqR8h60YAipZfZIEcgTma0sprgClsNWudOFtzF/AlLKoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8fHrNd1VEt5AJIzXQl6ILKIZE2X3+4GmwIxef5n6RUz9XtOU
	ayspeQyUNHeznJI8aoXbFeF07MBnB/zansonWxSiGZO32c0EOSP2QLEae3wZMgGngQY+7WSj7in
	3X0VfhNGtsm4tuW9Z34+xSXMdjgJvLIM=
X-Google-Smtp-Source: AGHT+IF6/lZT+nTgbNvZTUiXIDmW9q54rZMUqwpRjYNk8wrYCqvyIwoku1OnSoBAAGpVXY/jQlB82nISjHSkqQX97+w=
X-Received: by 2002:a05:6820:2017:b0:657:5cc3:f38 with SMTP id
 006d021491bc7-657908538bcmr8095666eaf.0.1764247923143; Thu, 27 Nov 2025
 04:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aSb3Qt6n55Fsl7IF@wunner.de> <20251126234603.GA2832326@bhelgaas> <aSgEnt12QQLXCfWr@wunner.de>
In-Reply-To: <aSgEnt12QQLXCfWr@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 13:51:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iusQ0_d26tuQS7fSdQNwFKWuZn7185MrAj=kJ-2=4byg@mail.gmail.com>
X-Gm-Features: AWmQ_bmj9EZZXbEixlhBnrAkhfgIC-kpDvLYVESJrO_qON4uVsjhWj5sjc2KpM0
Message-ID: <CAJZ5v0iusQ0_d26tuQS7fSdQNwFKWuZn7185MrAj=kJ-2=4byg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI/PM: Reinstate clearing state_saved in legacy
 and !pm codepaths
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, 
	Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 8:58=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Nov 26, 2025 at 05:46:03PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 26, 2025 at 01:49:06PM +0100, Lukas Wunner wrote:
> > > In the patch, I made the "pci_dev->state_saved =3D false" assignment
> > > conditional on !pm_runtime_suspended() in the "freeze" codepath.
> > > I didn't do the same in the legacy codepath because none of the
> > > drivers using legacy PM callbacks seem to be using runtime PM.
> >
> > Maybe it's moot because we hope there will be no new users of PCI
> > legacy PM with runtime PM, but I don't think there's anything to
> > *prevent* that or to protect against out-of-tree drivers.
> >
> > The implicit assumption that there are no such drivers makes it look
> > like there's something magic involving state_saved, legacy PM, and
> > runtime PM.  It might be worth doing the same in the legacy PM path
> > just for readability.
>
> Drivers having both legacy callbacks and modern callbacks (including
> runtime PM callbacks) cause emission of a WARN splat in
> pci_has_legacy_pm_support().
>
> Drivers need to activate runtime PM by dropping a runtime PM reference
> on probe (see the code comment in local_pci_probe()).  In theory a
> driver could have legacy callbacks but no modern callbacks and still
> use runtime PM by calling pm_runtime_put_noidle() on probe.  So I
> compiled a list of drivers implementing legacy callbacks (included
> at the end of this e-mail for reference), grep'ed through them
> for any "pm_runtime" occurrences and found none.
>
> Hence it seems very unlikely that drivers using legacy callbacks and
> runtime PM exist.  We probably shouldn't accommodate for such use cases
> but should rather try to incentivize conversion to modern callbacks.

Agreed.

What about adding a WARN_ON(pm_runtime_enabled(dev)) to the "legacy"
suspend/hibernation callback paths?

> When compiling the list I sadly noticed that new drivers do exist
> which use legacy callbacks.  A case in point is:
>
> drivers/net/ethernet/google/gve/gve_main.c
>
> ... which started using legacy callbacks in 2021 with commit 974365e51861
> ("gve: Implement suspend/resume/shutdown").
>
> I guess there is no real incentive to convert to modern PM callbacks and
> finding someone who has the hardware and can test patches is hard
> (most drivers are for ATA, some for really old 1990s hardware).
> Plus, a lot of detailed knowledge about PCI PM is necessary to avoid
> breakage, making this a task that can't easily be delegated to new
> contributors.  And everyone with the knowledge is overworked already.
> So we keep dragging this tech debt along which complicates codepaths. :(

While I agree that this is the case, I'm not sure what can be done to
address this problem, realistically.

