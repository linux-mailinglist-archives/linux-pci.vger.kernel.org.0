Return-Path: <linux-pci+bounces-29528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA6AD6C68
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5AB3AD6E4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404322A804;
	Thu, 12 Jun 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0zdtRji"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF931F583D
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721184; cv=none; b=pyoqU6ar+qxY5STgBcV/WdoutAFUbzmHfjl/c2avglVad77DhrGt7+x5SgKIQrVPxNpiJPcTjcgDSG6U6oP95xQ8kvnzFXa+pMFT2H/JsFuR7pWXnuh1AxhlDs7eA8wjuBB+3OQyMJMyyf61+wmHhgHKUOOcmfsEygqL4REdtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721184; c=relaxed/simple;
	bh=itD9k5ydYfxqNmokH1TVplNS+0T+GUbYVycjN5gv6M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKJNLvsSrDdjZP7fBZymwoqRDO7cFxcVYyIRXgO2YyCzsPZqjxIXQdQ6FiSTUAZQJXfbnsYXySnH1EW+jQFSjERErLuvRhRYiBmbltcEe3odQKcOyV7k405fhtGAUZwZdvmD/gyMuDZuIgQPEZc1C/bSOTv00+Ytg7seeBTpklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0zdtRji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F034FC4CEF1
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749721184;
	bh=itD9k5ydYfxqNmokH1TVplNS+0T+GUbYVycjN5gv6M0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H0zdtRjiaJ9lIf3bUp+PXaAuJobxMms+fhuxpkzqG1vQd1EL5sU+NLmIYfh92w6r0
	 yAJ+xkjSnuJDbpGzpA/Wy4mqPkisIBEDyXdfTtKYFyMKwie3sVXgEEAUvz3i/OLL0V
	 iKS4o31lqRbOMe8dAR7jJbU+a1d6lHxwh0vcknshD6xu4o46yt/kdba06gh/s7rg8z
	 15KtV/qpOtY9gBvsBbXth2Bkqy+O4GFOjx7RxozCmJMmJeOROiSrdBBsnMN0v3+7E3
	 s3u3BRgsfSCg0dAUPSOwHjRJKedEz8wEbGAbRN3kSm+JdHXCArCBqooSZa9Q6TOY/9
	 PsI4auKWfw7Tg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-606477d77easo429646eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 02:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXelYWKWxo7cK7C5E1wmWgBjyGc50E1NVm7HFtFgpoHCKrOQNj2//s75c89Ftx0OR5Ef4OfYy6fyK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycnHmLvmVSZ/62MM+owxqIf+3aHaD/JfxKqDLq6e/NwSd4rW7I
	C1RAlCmGgQ2Ur4LYpmynO0fhVtpznPiEmDrUcfJa5P7miz/pvUSSidMhmFjriGuNmfxGSeCs5yR
	lfy0QGhBG/+fempvzAJKAOkqmjSSvWQ0=
X-Google-Smtp-Source: AGHT+IH+FLOCkXAJvaknvZeAKj74qaTVKH+NSbGV8ytjM3Y/kHs0g+u4heGwYtxsU8Rl4gnBIZmpHoexiXFWDl/B5wg=
X-Received: by 2002:a05:6820:5201:b0:610:d11c:896 with SMTP id
 006d021491bc7-610fc4ecae0mr1203448eaf.0.1749721183253; Thu, 12 Jun 2025
 02:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611233117.61810-1-superm1@kernel.org>
In-Reply-To: <20250611233117.61810-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Jun 2025 11:39:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iL29uNcwi=8rB5Yp6UN4i6WFh7twZO=zou2M9yT10erg@mail.gmail.com>
X-Gm-Features: AX0GCFtFkZ8oJ8lwYSz68uWQYi3UmQOQsUprM85OEb1-NukQ2q4snJ8SgS71iDA
Message-ID: <CAJZ5v0iL29uNcwi=8rB5Yp6UN4i6WFh7twZO=zou2M9yT10erg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Set up runtime PM on devices that don't support
 PCI PM
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, rafael@kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 1:31=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") intended to put PCI devices into D0, but in doing so
> unintentionally changed runtime PM initialization not to occur on
> devices that don't support PCI PM.  This caused a regression in vfio-pci
> due to an imbalance with it's use.
>
> Adjust the logic in pci_pm_init() so that even if PCI PM isn't supported
> runtime PM is still initialized.
>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm=
1@kernel.org/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
> Reported-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm=
1@kernel.org/T/#m40d277dcdb9be64a1609a82412d1aa906263e201
> Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v2:
>  * remove pointless return
> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3dd44d1ad829b..160a9a482c732 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3222,14 +3222,14 @@ void pci_pm_init(struct pci_dev *dev)
>         /* find PCI PM capability in list */
>         pm =3D pci_find_capability(dev, PCI_CAP_ID_PM);
>         if (!pm)
> -               return;
> +               goto poweron;
>         /* Check device's ability to generate PME# */
>         pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
>
>         if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
>                 pci_err(dev, "unsupported PM cap regs version (%u)\n",
>                         pmc & PCI_PM_CAP_VER_MASK);
> -               return;
> +               goto poweron;
>         }
>
>         dev->pm_cap =3D pm;
> @@ -3274,6 +3274,7 @@ void pci_pm_init(struct pci_dev *dev)
>         pci_read_config_word(dev, PCI_STATUS, &status);
>         if (status & PCI_STATUS_IMM_READY)
>                 dev->imm_ready =3D 1;
> +poweron:
>         pci_pm_power_up_and_verify_state(dev);
>         pm_runtime_forbid(&dev->dev);
>         pm_runtime_set_active(&dev->dev);
> --
> 2.43.0
>

