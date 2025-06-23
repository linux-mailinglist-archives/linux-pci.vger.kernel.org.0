Return-Path: <linux-pci+bounces-30433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DBAE4BA6
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E041899E5B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28AF288511;
	Mon, 23 Jun 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ4bKFHq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE526D4CE
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698916; cv=none; b=SYfKMtKDzqgYBnfIFW9NDp4qHqeeHmZEqBr4bGx5kHXfbI5u7J4N/Yw3uohAh62NHWlywgAbwX6jD0rFm6aTvLJXruPBgMdY02O//C786m78qtnqmi0iNaraGVJDHSQTZV0ZFzqm5xgy6KbY7hkUpQmAQf44jCn0s4Qp9Va5TKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698916; c=relaxed/simple;
	bh=OAfTq9xTIcwEl3496GnWlPVzp2QzGcTrh7OgFk5/1T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOyq1eefNbwLH7pY6cneLJx92eI5G/ZrGYRoHk3g9shW2wWmsKOCbJtAb/FFQvoeqP+3rxLR/y6X8CYVbGIp1kq6UGOCc2OX7KXsJim4zercyqUZbkUptG0XNfO7IzJKKqwyQuvZ1eGaAEtiX6apSPcQ9TqPcCTAD074RCwFAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ4bKFHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BEDC4AF09
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750698916;
	bh=OAfTq9xTIcwEl3496GnWlPVzp2QzGcTrh7OgFk5/1T0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OQ4bKFHqwCRYYXbbwMbIyCVKgFtna1ocreQcs5tYkxz0rcb2tY6Ned7UYyU0D7+Yw
	 7BZegEIlr3l9ESK3CgpVkziDyQzjYYUv98BU5UsFvWtU9+rN59CvWwZD5axBdCPfYT
	 QTfsCNi4Saewlo2qWeAgGaJK23+IxosnRHIAJSLHu7/iXPXGK5J0Wvc5oJ3JkO4OfB
	 Egz8ia4pkD0i3SVaELtLjcfoqd84LraeNnQqL43AbIOfWbjrBvBi1DfL8FuE713mxz
	 D7RLvbDI3yDLVvSDw2fBO+Xx4SXCzJ6WANhaJuehSIhD5Lnio2MhDihiI1tUkXx9X5
	 nz37S37UqLQnw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60634f82d1aso964844eaf.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 10:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUffQ2bBAX24X9iJt7f6AT0/ieZbowKISRgunDh1VFBFt/cL8A4xrnhuKlCkS9dzyUNxmVfUnFcd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNcb6HYtq0tSkOzhLB4PJiWpDQp5f3XUZm9eu5Cu8Hq0YGxkj
	gLCIBAvY0LKsq71X15PpJX5SgWhqsz4SaRgKz6IYTwyeN4ISgNR7wMShhPZrB5XhI5Ghx+seWZ/
	6GobB+vUCKVUR8YLRhMhllUKepx/bUz4=
X-Google-Smtp-Source: AGHT+IHH7vu/q6t0IByNctMeFLnSHBdx8WlOh9DJfNMCiklZe00Sij5RllesFhD0mIv0A7ynVl0nY1DlcJu/sEDCZBY=
X-Received: by 2002:a05:6820:2112:b0:611:7a48:abd3 with SMTP id
 006d021491bc7-6117a48b027mr4474064eaf.3.1750698915502; Mon, 23 Jun 2025
 10:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
In-Reply-To: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 19:15:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpz=-D8yZfvGdUPHm0wSi25s7SNXuZ8_5=hPD6e3S0oA@mail.gmail.com>
X-Gm-Features: AX0GCFsR0_4gRr7J3LCKRvoJgFzGefx2i4v9zDMUIdhTPu8bxeyGR1YHgtfS8zs
Message-ID: <CAJZ5v0jpz=-D8yZfvGdUPHm0wSi25s7SNXuZ8_5=hPD6e3S0oA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Laurent Bigonville <bigon@bigon.be>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 7:08=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
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
> Capable.   An inaccessible device returns "all ones", which is converted
> to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> longer seems Hot-Plug Capable on ->remove() even though it was on
> ->probe().
>
> The resulting runtime PM ref imbalance causes errors such as:
>
>   pcieport 0000:02:04.0: Runtime PM usage count underflow!
>
> The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.
> pci_bridge_d3_possible() only calls pciehp_is_native() if that flag is
> set.  Re-checking the bit in pciehp_is_native() is thus unnecessary.
>
> However pciehp_is_native() is also called from hotplug_is_native().  Move
> the Config Space access to that function.  The function is only invoked
> from acpiphp_glue.c, so move it there instead of keeping it in a publicly
> visible header.
>
> Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220216
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.=
org/
> Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel=
.org/T/#u
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.18+

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks!

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++++++
>  drivers/pci/pci-acpi.c             |  5 -----
>  include/linux/pci_hotplug.h        |  4 ----
>  3 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 5b1f271c6034..ae2bb8970f63 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -50,6 +50,21 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus);
>  static void hotplug_event(u32 type, struct acpiphp_context *context);
>  static void free_bridge(struct kref *kref);
>
> +static bool hotplug_is_native(struct pci_dev *bridge)
> +{
> +       u32 slot_cap;
> +
> +       pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> +
> +       if (slot_cap & PCI_EXP_SLTCAP_HPC && pciehp_is_native(bridge))
> +               return true;
> +
> +       if (shpchp_is_native(bridge))
> +               return true;
> +
> +       return false;
> +}
> +
>  /**
>   * acpiphp_init_context - Create hotplug context and grab a reference to=
 it.
>   * @adev: ACPI device object to create the context for.
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..57bce9cc8a38 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -816,15 +816,10 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
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
> -               return false;
> -
>         if (pcie_ports_native)
>                 return true;
>
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index ec77ccf1fc4d..02efeea62b25 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -102,8 +102,4 @@ static inline bool pciehp_is_native(struct pci_dev *b=
ridge) { return true; }
>  static inline bool shpchp_is_native(struct pci_dev *bridge) { return tru=
e; }
>  #endif
>
> -static inline bool hotplug_is_native(struct pci_dev *bridge)
> -{
> -       return pciehp_is_native(bridge) || shpchp_is_native(bridge);
> -}
>  #endif
> --
> 2.47.2
>

