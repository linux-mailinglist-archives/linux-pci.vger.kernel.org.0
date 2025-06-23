Return-Path: <linux-pci+bounces-30359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E04AE3BD8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331F5188B99B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47E8239581;
	Mon, 23 Jun 2025 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFR4cj6p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12F2367AE;
	Mon, 23 Jun 2025 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673500; cv=none; b=lyMbm0VEeb7BNBD25j+kxiotj1JKuhZIRJDqR71sndH6DeYrGBRCl4l3RS6L3yQtCs5+TENUM+YZfTbHJWgn+VX9iymK/MldHZxpsCS0mIBU2kK5UIVSLvgAIQnfU/+1vklXYBY7Deo3kvqBvdwzBxSr1lKJyeby+IMD46hwC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673500; c=relaxed/simple;
	bh=7CMmvVWrOvPvaUVXR7U/d1vb15DwjUiucFimpY8AR5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPhrQkA63sjGreqHFeO8j1ywi4k1ckyq18kzf4I/aG22eqVbkKonfYtaIyFTiw+vBDYt3C3ZoGy4qHrUL+ZRRFNDgc+1oBOPb4BVTM0y5HdWb6xvd6ET2eGP4cmfHQht9P1NmFrJ0NK+duMED3NdNJ9k7OPdtvkwIEfFAj8Un38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFR4cj6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B64C4CEF4;
	Mon, 23 Jun 2025 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750673500;
	bh=7CMmvVWrOvPvaUVXR7U/d1vb15DwjUiucFimpY8AR5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PFR4cj6pFwLph255TJvmKCJwUxLfEu4Ivm6rsbMP02TPIM0WChi3AptbbxLG6K1lz
	 fjP14kGxGZDoozPZEcMF1zsS8sL/CvX6O9mJSPW9UqwEjsYcdei03B11JBhmuxfR1K
	 sOh8AAGbDE090NGAxmBAX5TA554hkLC5N4iarJMz3uI/gaOS1qQ05WPxfkHpuaTxY/
	 y9D2NAOC+6xSeLmJW2C2QoG2Ur8neawcK3LSzr/1aIh/OVL2yncO7w/wkXs+fKNXBS
	 x4hCLh572PdhwHPAhUQn6u2XelBxkSUpRmyMvA8zSs0aBy6DfBZySyiYdFS7dvhc//
	 HWH7+JLpJHnwQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73a64e126d9so3816572a34.0;
        Mon, 23 Jun 2025 03:11:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTJYajSO0UWW9ti79Q/PR0HTbuSZVJ+Ze/dQf5MO3iPCS3ugS6QOGAqLMxTzKGRPICTslFKCrJ2t4=@vger.kernel.org, AJvYcCXNFKzeeJrZ7Nf5GLPqftSqEWtHkUXX3tfzegKcZxm39wvqeZj/oen8cgioxE1ovT4CV3YtVbgB/R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMoAzxX+NbGQ2NNnNc4mT97pAFnOz/zQaSoIYCCJXMVONq1/56
	9e12aMJ6zCiq/YMtNcKhQwiRAbeeApZiK3fgseLsSwEcm0AofPpy1e9YfKxWV+T4lWrwClJra3a
	hVu53FRbA+4A7lvlhEXOF3561oIE3Yos=
X-Google-Smtp-Source: AGHT+IFufck0IGgiQmbCjYR2b/oSSlacpS7SpHlNAodJ6486zrI0mNFpjtadNLgQNvMKOaNvZeuregyNXVcYHvoY5IQ=
X-Received: by 2002:a05:6870:c0cd:b0:2d4:edac:d9a9 with SMTP id
 586e51a60fabf-2eeee370cd0mr7468980fac.10.1750673499586; Mon, 23 Jun 2025
 03:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620025535.3425049-1-superm1@kernel.org> <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de> <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de> <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de> <aFkEI2jXg7YiwL7b@wunner.de> <aFkm8njX-NEIiTcv@wunner.de>
In-Reply-To: <aFkm8njX-NEIiTcv@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 12:11:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
X-Gm-Features: AX0GCFtf0PqFxRVbbtiTyJ9HaU7UKz-gbXqpfJHVIJCK5uK5KU2pV_oJDtuQ-wU
Message-ID: <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
To: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:05=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Mon, Jun 23, 2025 at 09:37:07AM +0200, Lukas Wunner wrote:
> > On Mon, Jun 23, 2025 at 08:43:25AM +0200, Lukas Wunner wrote:
> > > On Sun, Jun 22, 2025 at 01:39:26PM -0500, Mario Limonciello wrote:
> > > > > > On 6/21/25 2:05 PM, Lukas Wunner wrote:
> > > > > > > So the refcount decrement happens in pcie_portdrv_probe() and
> > > > > > > the refcount increment happens in pcie_portdrv_remove().
> > > > > > > Both times it's conditional on pci_bridge_d3_possible().
> > > > > > > Does that return a different value on probe versus remove?
> > > >
> > > > I did this check and yes specifically on this PCIe port with the un=
derflow
> > > > the d3 possible lookup returns false during pcie_portdrv_remove(). =
 It
> > > > returns true during pcie_portdrv_probe().
> > >
> > > That's not supposed to happen.  The expectation is that
> > > pci_bridge_d3_possible() always returns the same value.
> >
> > I'm wondering if the patch below fixes the issue?
>
> Refined patch below with proper commit message,
> also avoids a compiler warning caused by an unused variable.
>
> -- >8 --
>
> From: Lukas Wunner <lukas@wunner.de>
> Subject: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug capab=
le
>  ports
>
> pcie_portdrv_probe() and pcie_portdrv_remove() both call
> pci_bridge_d3_possible() to determine whether to use runtime power
> management.  The underlying assumption is that pci_bridge_d3_possible()
> always returns the same value because otherwise a runtime PM reference
> imbalance occurs.
>
> That assumption falls apart if the device is inaccessible on ->remove()
> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> which accesses Config Space to determine whether the device is Hot-Plug
> Capable.   An inaccessible device generally returns "all ones" for such
> Config Read Requests.  Hence the device may seem Hot-Plug Capable on
> ->remove() even though it wasn't on ->probe().
>
> Use the cached copy of the Hot-Plug Capable bit to avoid the Config Space
> access and the resulting runtime PM ref imbalance.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

LGTM

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/pci-acpi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e4..8859cce 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -816,13 +816,11 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  bool pciehp_is_native(struct pci_dev *bridge)
>  {
>         const struct pci_host_bridge *host;
> -       u32 slot_cap;
>
>         if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>                 return false;
>
> -       pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> -       if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> +       if (!bridge->is_hotplug_bridge)
>                 return false;
>
>         if (pcie_ports_native)
> --
> 2.47.2
>
>

