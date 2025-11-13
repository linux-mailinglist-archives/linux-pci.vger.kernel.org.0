Return-Path: <linux-pci+bounces-41182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15254C5A018
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0AF64E286B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 20:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872AF320387;
	Thu, 13 Nov 2025 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvfIZLd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62501315D29
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066959; cv=none; b=SlupN1zX1oSqhvz49p2fx2ZecWP7UrvbTzM6eiyxz70FPrrmFm1WbHQKFcp4GjjReCvbqWhCtvUqvx04gakmJRT31fHITp3M9OoWGA/JUQZuvx64POavF16O/hCt2fN0tuIz/eZFolATLCxOe19KmubHHyp8sQDV5p7+1ppXhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066959; c=relaxed/simple;
	bh=EPLxhXO88cqccq1mPagqYGrejUHoFDLiArdjyg3Q4AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jH7ettbgdluvfi2BI6KW0+rWZ0LSh7lXcGzfeFgxgZvDCP5SF5JRfPLhhpcDbHGtJ+siTBy6jt12ml8EPvuL/r0dh94AQ2YmL4vpvDVB3PwkSGCEweGLMWd8sA6QfNUSKRMYLkBeL8Kr6BHxaDEkvoglonIZlAN47L+Tu+ulnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvfIZLd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42984C2BCAF
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763066959;
	bh=EPLxhXO88cqccq1mPagqYGrejUHoFDLiArdjyg3Q4AY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QvfIZLd4HTnup0ZMtaGA/lNKtFA4b2Nq2CQ6iixuM/2w3GhWk34S6/0lkFS7kfrLz
	 YsoTj9CwVgvrXnOHfwmLwtGc2W6qzLqti6TyK/KhFIpIdbXEj1KsVT+FpKcpvy4CB2
	 OZUUoM0WX3QpDm8qJO4icWt80PfmGg5v2OrxaMpw+KxDT9MwpAqFi15hhOHHT/QYlI
	 9vaDM+kI1/iB/dcvVjYcHV3haLw83n2YWaGW5Hoof3DEJKJwnnHfunyf5KlaNdUZlx
	 k+wMziFz0sx8IGX5nSQo04krncs4ARBANHLI16UjkKHe2g/EkRijpXmLCmiDltFqnW
	 YNejq+VtwfpUA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-656b52c0f88so486116eaf.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 12:49:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRxzsHT9DdZAYiRtxGBszclRkNA7T0HNc6eqk5QnTiun5lzDp7CtwkHlaDT4OwCs9/2/s65N2dzq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFn57AbHVnCJ9UWJK6LalPz6sMYKFfK0nheUbGd9XzuNSzz2r
	9RDrIk0bq4s/5WDcGyjXUQDRkgyciE9W1skmAfbqcXEUj8ZRDGcIRHg440FPN/U+OsNujd1uOxV
	MEP1FG7pgg1Qw9C+MDmwSn1LsLB0klBY=
X-Google-Smtp-Source: AGHT+IFwpjmkzTtdNC78gv8DWtXRXf7ZYpQ6PtpdSfXZY/SuePzaNDE3JPoucOxGQGfHuxcykzaK7k0EtIbv9uBiEr0=
X-Received: by 2002:a05:6808:891a:20b0:450:d2b:d80d with SMTP id
 5614622812f47-45097587d0fmr285198b6e.43.1763066958394; Thu, 13 Nov 2025
 12:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760274044.git.lukas@wunner.de> <070a03221dbec25f478d36d7bc76e0da81985c5d.1760274044.git.lukas@wunner.de>
In-Reply-To: <070a03221dbec25f478d36d7bc76e0da81985c5d.1760274044.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 21:49:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hE31RqZ19oN_11cKYnLY_CP0KccTGwa9ViT4UmR+6rfg@mail.gmail.com>
X-Gm-Features: AWmQ_bnCbyYw_3lIyx6vhiRISpeG2Rm90g8CMXSUM0RGtBN2XV9EuW1_hG_yvts
Message-ID: <CAJZ5v0hE31RqZ19oN_11cKYnLY_CP0KccTGwa9ViT4UmR+6rfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Ensure error recoverability at all times
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, 
	Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com, 
	Dave Jiang <dave.jiang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 3:30=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> When the PCI core gained power management support in 2002, it introduced
> pci_save_state() and pci_restore_state() helpers to restore Config Space
> after a D3hot or D3cold transition, which implies a Soft or Fundamental
> Reset (PCIe r7.0 sec 5.8):
>
>   https://git.kernel.org/tglx/history/c/a5287abe398b
>
> In 2006, EEH and AER were introduced to recover from errors by performing
> a reset.  Because errors can occur at any time, drivers began calling
> pci_save_state() on probe to ensure recoverability.
>
> In 2009, recoverability was foiled by commit c82f63e411f1 ("PCI: check
> saved state before restore"):  It amended pci_restore_state() to bail out
> if the "state_saved" flag has been cleared.  The flag is cleared by
> pci_restore_state() itself, hence a saved state is now allowed to be
> restored only once and is then invalidated.  That doesn't seem to make
> sense because the saved state should be good enough to be reused.
>
> Soon after, drivers began to work around this behavior by calling
> pci_save_state() immediately after pci_restore_state(), see e.g. commit
> b94f2d775a71 ("igb: call pci_save_state after pci_restore_state").
> Hilariously, two drivers even set the "saved_state" flag to true before
> invoking pci_restore_state(), see ipr_reset_restore_cfg_space() and
> e1000_io_slot_reset().
>
> Despite these workarounds, recoverability at all times is not guaranteed:
> E.g. when a PCIe port goes through a runtime suspend and resume cycle,
> the "saved_state" flag is cleared by:
>
>   pci_pm_runtime_resume()
>     pci_pm_default_resume_early()
>       pci_restore_state()
>
> ... and hence on a subsequent AER event, the port's Config Space cannot b=
e
> restored.  Riana reports a recovery failure of a GPU-integrated PCIe
> switch and has root-caused it to the behavior of pci_restore_state().
> Another workaround would be necessary, namely calling pci_save_state() in
> pcie_port_device_runtime_resume().
>
> The motivation of commit c82f63e411f1 was to prevent restoring state if
> pci_save_state() hasn't been called before.  But that can be achieved by
> saving state already on device addition, after Config Space has been
> initialized.  A desirable side effect is that devices become recoverable
> even if no driver gets bound.  This renders the commit unnecessary, so
> revert it.
>
> Reported-by: Riana Tauro <riana.tauro@intel.com> # off-list
> Tested-by: Riana Tauro <riana.tauro@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Proof that removing the check in pci_restore_state() makes no
> difference for the PCI core:
>
> * The only relevant invocations of pci_restore_state() are in
>   drivers/pci/pci-driver.c
> * One invocation is in pci_restore_standard_config(), which is
>   always called conditionally on "if (pci_dev->state_saved)".
>   So the check at the beginning of pci_restore_state() which
>   this patch removes is an unnecessary duplication.
> * Another invocation is in pci_pm_default_resume_early(), which
>   is called from pci_pm_resume_noirq(), pci_pm_restore_noirq()
>   and pci_pm_runtime_resume().  Those functions are only called
>   after prior calls to pci_pm_suspend_noirq(), pci_pm_freeze_noirq(),
>   and pci_pm_runtime_suspend(), respectively.  And all of them
>   call pci_save_state().  So the "if (!dev->state_saved)" check
>   in pci_restore_state() never evaluates to true.
> * A third invocation is in pci_pm_thaw_noirq().  It is only called
>   after a prior call to pci_pm_freeze_noirq(), which invokes
>   pci_save_state().  So likewise the "if (!dev->state_saved)" check
>   in pci_restore_state() never evaluates to true.
>
>  drivers/pci/bus.c   | 7 +++++++
>  drivers/pci/pci.c   | 3 ---
>  drivers/pci/probe.c | 2 --
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index f26aec6..4318568 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -358,6 +358,13 @@ void pci_bus_add_device(struct pci_dev *dev)
>         pci_bridge_d3_update(dev);
>
>         /*
> +        * Save config space for error recoverability.  Clear state_saved
> +        * to detect whether drivers invoked pci_save_state() on suspend.
> +        */
> +       pci_save_state(dev);
> +       dev->state_saved =3D false;
> +
> +       /*
>          * If the PCI device is associated with a pwrctrl device with a
>          * power supply, create a device link between the PCI device and
>          * pwrctrl device.  This ensures that pwrctrl drivers are probed
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd06..2f0da5d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1855,9 +1855,6 @@ static void pci_restore_rebar_state(struct pci_dev =
*pdev)
>   */
>  void pci_restore_state(struct pci_dev *dev)
>  {
> -       if (!dev->state_saved)
> -               return;
> -

So after this change, is there any mechanism to clear state_saved
after a suspend-resume cycle so that the next cycle is not confused by
seeing it set?

>         pci_restore_pcie_state(dev);
>         pci_restore_pasid_state(dev);
>         pci_restore_pri_state(dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c83e75a..c7c7a3d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2747,8 +2747,6 @@ void pci_device_add(struct pci_dev *dev, struct pci=
_bus *bus)
>
>         pci_reassigndev_resource_alignment(dev);
>
> -       dev->state_saved =3D false;
> -
>         pci_init_capabilities(dev);
>
>         /*
> --

