Return-Path: <linux-pci+bounces-35846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2DB51F7A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 19:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224BE7BE33F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2169431D377;
	Wed, 10 Sep 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6NDtd5A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346A24A058;
	Wed, 10 Sep 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526533; cv=none; b=Omi43LN6BX5sNXr5PvC0sWHIAQfrKuKzPwZ/Ye596LckL5wR2a/kTFpU5ueeArJvRbMIS3alkcWqvffMfaL+IyIq4BPkdlkQeZ+cZmJyOuxhvzTEDC8ap4bBeRH+FMn85KOrSpq793VUFS6NWXIRpYg4hw3+qInEjuDgiJykW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526533; c=relaxed/simple;
	bh=JWkrCD/pUkyX9wjEhNii7+JjAOcFy0ueHFktHUQ0t80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9CZy39Ya0I9YHv2n8oB37u4DFd8enq/3lAhc5ExD16no1xbpe8OhAITHQrjVmcZdrNyE5JCQ9Ix0Q3S1g+i6wavRI4ISPlkwjoifU1ZGjtM3/O/TU44k0EEjajZ1BlhWHKYJKLX3P1tzft60FzrmDvpIF6tcQJqFZU5srcIZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6NDtd5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F4C4CEF0;
	Wed, 10 Sep 2025 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757526531;
	bh=JWkrCD/pUkyX9wjEhNii7+JjAOcFy0ueHFktHUQ0t80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d6NDtd5AvkZ3cAyHiBAlhsfdUR3l9P2CxyKtdFH5/bGkhOLVPbOeOSka+H44aAKBn
	 K/b1NClF/FVpo7KBFx/V6Lm5W5MqD3jLJcAVwJCwgIma8vkBVngnmL3Rjg5giNXbss
	 GcsrEwC0wzJF6OlEkbBWdmv+S0xN55czfk1SKsmU5/bbzGwquE1FQ5KxZoNXHh5bV3
	 DhGcyt2/rm+pcCmSKnhUsCXHRHPuR077rJpQCJTHoPfmo/sQQB/OcdvpLSzJcPI+M4
	 51KrcuUa7vVoDJFlhhzMvuXO6Gnwfuyuu9tRoBj4EhQG7+YAxu+jIXI6IOdaSG5+ac
	 HAEB2JxbRjDDg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-62177052206so2196064eaf.1;
        Wed, 10 Sep 2025 10:48:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVCiY7YEmXf//AT1snrQyk+A/aJW8w2XGIckcuFszwUAJDsTtyEMkwD8IIYXomJKtwdHCnzzWPJZ+K2OWD3ZoveaQQ@vger.kernel.org, AJvYcCVrGWYqk/k7ifUeAO2pyWzAdslqNLbDBmuncjgG6nx4ZkOj3mD5v8/treVwvO3N38V7AmYoPBHw/cc=@vger.kernel.org, AJvYcCXG6A7fBmrreliZ9tos2HRvpDmHXkZ8ZGysm3FHnnIHMaNhwMsBz1x7wGWGZBe5kDBxFFSk80BGNrk=@vger.kernel.org, AJvYcCXbdhzvfztzdZSsxvyp6U+6+yuFU178kxwiISf4arEFHoiRX92rn8LIX2ivHs0H08+jtG+20583R8CXdA==@vger.kernel.org, AJvYcCXdfG23CaRvalcussxjsbJp3CUQ4OYMRY0y7jxtmhl1MLNqnCOPdBFWf7j2lhsddxSmIW9vDU7bsN76@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoa/xa7IStNgGaGWsn6v+mpLhncvW1UNMyeKQZUPOdYWRl7RC
	EtzQ0i2dNlaiVh/N/ctTeugJEpa/ikku4V33HVP6+80Yr9RkyD3Xo8CfSVx9cwE4FXfAer3nWUm
	kf6RUah09wy4e7f/dBnozb+b9I7cqWyc=
X-Google-Smtp-Source: AGHT+IHIQIF5cP+OhlL3KucdzEwULKP8UbyHlNW3Z/2yYgUbnpkKJtfuorEsV1W09cBVlr7j0fot96/NnMtI6HNTGd4=
X-Received: by 2002:a05:6820:221c:b0:621:75a2:6791 with SMTP id
 006d021491bc7-6217897ccc2mr7019038eaf.0.1757526530846; Wed, 10 Sep 2025
 10:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909191619.2580169-1-superm1@kernel.org> <20250909191619.2580169-8-superm1@kernel.org>
In-Reply-To: <20250909191619.2580169-8-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 19:48:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8Hq4nfrkEPKByesAZ7SmKz4N8Cm9H_AmK_fez=0QtWw@mail.gmail.com>
X-Gm-Features: Ac12FXyd_vL1lzVAXI-I3rJHVcPaSI6vkfuoiTOhlX1EtvOyF4XzkNpq89iEtOs
Message-ID: <CAJZ5v0g8Hq4nfrkEPKByesAZ7SmKz4N8Cm9H_AmK_fez=0QtWw@mail.gmail.com>
Subject: Re: [PATCH v7 07/12] PCI/PM: Run bridge power up actions as part of
 restore phase
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:16=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Suspend resume actions will check the state of the device and whether
> bus PM should be skipped.  These same actions make sense during hibernati=
on
> image restore.

Not really (see below).

They kind of would have made sense in the error code path attempting
to roll back the power-off transition, but I'm not sure if this is
worth the hassle because it would require ->restore() to be able to
handle two different cases without knowing which case it is handling.

>  Apply them there as well.
>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v7:
>  * Reword title
> v5:
>  * Split out patch
> ---
>  drivers/pci/pci-driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 571a3809f163a..fb6f1f60b2f1f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1246,10 +1246,15 @@ static int pci_pm_restore_noirq(struct device *de=
v)
>  {
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> +       pci_power_t prev_state =3D pci_dev->current_state;

In the hibernation restore case, pci_dev->current_state is irrelevant
because the system has gone through the entire init in the BIOS and
boot loader, and the boot (restore) kernel before the control goes
back to the image kernel which runs the ->restore() callbacks.  It may
have changed three times since it was set during power-off.

> +       bool skip_bus_pm =3D pci_dev->skip_bus_pm;

This one is irrelevant either in that case.

>
>         pci_pm_default_resume_early(pci_dev);
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>
> +       if (!skip_bus_pm && prev_state =3D=3D PCI_D3cold)
> +               pci_pm_bridge_power_up_actions(pci_dev);
> +
>         if (pci_has_legacy_pm_support(pci_dev))
>                 return 0;
>
> --

