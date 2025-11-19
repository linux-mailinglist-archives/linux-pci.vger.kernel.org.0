Return-Path: <linux-pci+bounces-41682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662CEC711D5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 411E134ED31
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE72E1F08;
	Wed, 19 Nov 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otkduF27"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFED245012
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586538; cv=none; b=rOvmVE6UBV08BNZiojTtNpeWc0lHqTouWWowqZ3uicZx5deAaKlysR6u6IACpnK5U0PNB9AUwGNkN7fXu24uBv91XJJDcOKEneqTp9KLPfLOv4FDfz46Pxd4Sx6cK3DaJY8CmmgCE07bt8ss1kGqCiringN2CS0y4EeKyQwXGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586538; c=relaxed/simple;
	bh=16ZMTChKTjSpq1K5C21d8JLgJneqgfU+d17xRQO+50Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMLclSLnefAutWzfbJO1pYsph1hHgHXmnT6T+KtejsnHnu4S9ssiNc3K+l6Vb+VXITx7YDl9RruUeRMJoOM7JzphDXCxF+FIxHhj22pC/YlNpIuLYhRW/x85uFh7oBDgkxxe7+KXLqlTAafP6mSEVSObq5RPz6FPSh2/3b3Djts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otkduF27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB776C116C6
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763586537;
	bh=16ZMTChKTjSpq1K5C21d8JLgJneqgfU+d17xRQO+50Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=otkduF27NPeuj9DKNWoIdRslIiTT9935uXGl3u/4xMmUgBaHd1YnbW6P7esDHSmw7
	 6hTdJkbQZM3oNoMlAcUwGLsmNnoZLoqgJiBJ+9HcVhcModTS6oMdaltmiFQS0FiRvi
	 Aw06CiSCqz3WrlqssNU9yoXhjgPTkMpdNQ4DKWARDDXhwlUBBcm9UR0UBxr70NJeFk
	 yYx6SqYL6nD54U7Ct+sY8wCb0HuC/G2MGGsGVK6IbCJYFduWIeuaSDdQ2p1PJnGePJ
	 wR99Xt5Nu/iE0Yzh3wFbwwG1fag1Gt1bssWgARr7Us3Ziia/eZQNRAJ2DLy9Jz1Pve
	 8vhtmES6VRcvQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-450b5338459so72351b6e.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 13:08:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3FoR9klbEEptbqINGrWfXl8m4qjpIDK2+LWx3kN2VvOhvqe9RHYiwTwWmF2Kxt0kC5GFh4Espvoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPy3E1did18yKoqMYTQBdIE76cgCLuP522mdEUsBNcNrNlOKQV
	2WuKtssHOzgnqGHKEDJRkhl745l6RDVgRyiP3CtJ79aMYz161dzhL0IDHNdL/xbG662kmsI+Uv3
	Z6Iys2Ay0id7BxxxaOPWyrgEY1efhHo8=
X-Google-Smtp-Source: AGHT+IHc04nHlgUwT2+nxDos3Jg4thRAorugNdW8jucP4fYf1TIOLd1CqRyUoTwdLt7mI0uTa8AF3kX48Fvs3/j7cF8=
X-Received: by 2002:a05:6808:68c9:10b0:44f:8f02:c75a with SMTP id
 5614622812f47-451000904a8mr176480b6e.1.1763586536919; Wed, 19 Nov 2025
 13:08:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763483367.git.lukas@wunner.de> <094f2aad64418710daf0940112abe5a0afdc6bce.1763483367.git.lukas@wunner.de>
In-Reply-To: <094f2aad64418710daf0940112abe5a0afdc6bce.1763483367.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Nov 2025 22:08:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gPeQUHY_OpnvGPXgkE2dw4D008V2bFrF14tYgisKD6dQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnELAxukPfeKquwawkMHEgp3PlGUnRhS77TwPV0fUbQvNQrwqoD1__2ld0
Message-ID: <CAJZ5v0gPeQUHY_OpnvGPXgkE2dw4D008V2bFrF14tYgisKD6dQ@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 9:59=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> When a PCI device is suspended, it is normally the PCI core's job to save
> Config Space and put the device into a low power state.  However drivers
> are allowed to assume these responsibilities.  When they do, the PCI core
> can tell by looking at the state_saved flag in struct pci_dev:  The flag
> is cleared before commencing the suspend sequence and it is set when
> pci_save_state() is called.  If the PCI core finds the flag set late in
> the suspend sequence, it refrains from calling pci_save_state() itself.
>
> But there are two corner cases where the PCI core neglects to clear the
> flag before commencing the suspend sequence:
>
> * If a driver has legacy PCI PM callbacks, pci_legacy_suspend() neglects
>   to clear the flag.  The (stale) flag is subsequently queried by
>   pci_legacy_suspend() itself and pci_legacy_suspend_late().
>
> * If a device has no driver or its driver has no PCI PM callbacks,
>   pci_pm_freeze() neglects to clear the flag.  The (stale) flag is
>   subsequently queried by pci_pm_freeze_noirq().
>
> The flag may be set prior to suspend if the device went through error
> recovery:  Drivers commonly invoke pci_restore_state() + pci_save_state()
> to restore Config Space after reset.
>
> The flag may also be set if drivers call pci_save_state() on probe to
> allow for recovery from subsequent errors.
>
> The result is that pci_legacy_suspend_late() and pci_pm_freeze_noirq()
> don't call pci_save_state() and so the state that will be restored on
> resume is the one recorded on last error recovery or on probe, not the on=
e
> that the device had on suspend.  If the two states happen to be identical=
,
> there's no problem.
>
> Reinstate clearing the flag in pci_legacy_suspend() and pci_pm_freeze().
> The two functions used to do that until commit 4b77b0a2ba27 ("PCI: Clear
> saved_state after the state has been restored") deemed it unnecessary
> because it assumed that it's sufficient to clear the flag on resume in
> pci_restore_state().  The commit seemingly did not take into account that
> pci_save_state() and pci_restore_state() are not only used by power
> management code, but also for error recovery.

That's right, it didn't.

> Devices without driver or whose driver has no PCI PM callbacks may be in
> runtime suspend when pci_pm_freeze() is called.  Their state has already
> been saved, so don't clear the flag to skip a pointless pci_save_state()
> in pci_pm_freeze_noirq().
>
> None of the drivers with legacy PCI PM callbacks seem to use runtime PM,
> so clear the flag unconditionally in their case.
>
> Fixes: 4b77b0a2ba27 ("PCI: Clear saved_state after the state has been res=
tored")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.32+

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/pci-driver.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 302d61783f6c..327b21c48614 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -629,6 +629,8 @@ static int pci_legacy_suspend(struct device *dev, pm_=
message_t state)
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         struct pci_driver *drv =3D pci_dev->driver;
>
> +       pci_dev->state_saved =3D false;
> +
>         if (drv && drv->suspend) {
>                 pci_power_t prev =3D pci_dev->current_state;
>                 int error;
> @@ -1036,6 +1038,8 @@ static int pci_pm_freeze(struct device *dev)
>
>         if (!pm) {
>                 pci_pm_default_suspend(pci_dev);
> +               if (!pm_runtime_suspended(dev))
> +                       pci_dev->state_saved =3D false;
>                 return 0;
>         }
>
> --
> 2.51.0
>
>

