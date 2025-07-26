Return-Path: <linux-pci+bounces-32970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41270B12C70
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB121C20604
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB167DA9C;
	Sat, 26 Jul 2025 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag7TFBYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89B218ACA
	for <linux-pci@vger.kernel.org>; Sat, 26 Jul 2025 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563024; cv=none; b=QrZNyjif1JsNqAY6iv1YMnWwV4a/IhnSEkq9J53GTFaNZ32xVowGr+RFXuCXcvOZrsUgWcM5NTtpf9iZ3+/TpjrC5cYtbO0Qif1+QNID/8adzvK4mfiQKRIZuwF9cqRp1nmFLYpYceJpq61nVfQ+NqP4ER75CEFjaN32GUMVrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563024; c=relaxed/simple;
	bh=YMKmdvynu/sl8iI7T20WB9YknhHIhhrihWe84q+HVxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcT99BjYqrN4TfdIuvcKqG6xfNQX3q0TIRAf/X4PULp/wnAOsthTRXqMPbsyB9g1z3BUZjTq3IlYoxAGIzHPQMvU+qWNRsnyiHT8lS0wGBDTseuD93+xJ2HLsalqt2wwJDR3SGBJOpIkgebhhSqjmM2fNX3HVsoq9b52A9+pHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag7TFBYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7FEC4CEF5
	for <linux-pci@vger.kernel.org>; Sat, 26 Jul 2025 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753563023;
	bh=YMKmdvynu/sl8iI7T20WB9YknhHIhhrihWe84q+HVxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ag7TFBYHWezPfdYcSJlB1IsotUMCQP7lElVNkS2d/+hinNkDsdFP/T0xcLNRIQZFq
	 bTDT+MUT0a1DIc7yhJFh7hQCDF/SCvMQEUu3+s8UOEGZWJsP6tNAY5ht2jo41e+a9p
	 xPP7UREJC2AB37Gl4GPlaV1MKzyLwdpKNrXfs5BpNUAY4ycrjVdZM/adD38pvuIPc1
	 8xTUL9DsmJBu63Zwks12ea8XpX/9SzoRnYutQxX80g3tZfpulyEeFZA5jDdz08Nk3r
	 drvKLdE5A5sP2izg/DerM+t3zWoS0ybdYMeS/oATYk0I4PX7lW1AKk2gOR++ApAeV8
	 3he3TGciUydug==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-615ed9a4f38so1515079eaf.0
        for <linux-pci@vger.kernel.org>; Sat, 26 Jul 2025 13:50:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbIOc6f1hBXrILdlbSahfO0XwIKMIuvDMhmz3d3+vL8aAYBZZcQX6v4Sco5Tw0CwU41AgCdo10ZDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAbBGVr5Da0uihyzGTzmTEDGV7BT6T4aSfoG5UaH9KMIEZOnV
	HxMVz0xxg4Fwq8KdgS502JRGAgcsY008j4hM8EK4KUtz/YcNbeeuvL4nCY4ma0GmvHWKFfZFLmV
	7FslSCSmBffEBM6hjj4xLP85HShqrCwk=
X-Google-Smtp-Source: AGHT+IE89Ul4BFl7BSc9C0dp1ffJtRRN1gCjMtYZkhwoKz7hlbDkY/2VZtlYVxg+IKO9NfHoBmBe9dZ5Js8cS3BEfjg=
X-Received: by 2002:a05:6820:993:b0:611:f244:dfa5 with SMTP id
 006d021491bc7-6190c846465mr4039823eaf.2.1753563022736; Sat, 26 Jul 2025
 13:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752390101.git.lukas@wunner.de> <fe5dcc3b2e62ee1df7905d746bde161eb1b3291c.1752390101.git.lukas@wunner.de>
In-Reply-To: <fe5dcc3b2e62ee1df7905d746bde161eb1b3291c.1752390101.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 26 Jul 2025 22:50:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFQhXVkASt2P9Gv-4HeU6CByGRrQ2uM5aOMWWjznJ6mQ@mail.gmail.com>
X-Gm-Features: Ac12FXxCx4_dk5evIjDx6jUL8Rx17oNIZ2mCNCAwV7LlHWqqg9haWtKTzThyRCM
Message-ID: <CAJZ5v0jFQhXVkASt2P9Gv-4HeU6CByGRrQ2uM5aOMWWjznJ6mQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug
 Capable ports
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Laurent Bigonville <bigon@bigon.be>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, 
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>, 
	Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 4:47=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> pci_bridge_d3_possible() is called from both pcie_portdrv_probe() and
> pcie_portdrv_remove() to determine whether runtime power management shall
> be enabled (on probe) or disabled (on remove) on a PCIe port.
>
> The underlying assumption is that pci_bridge_d3_possible() always returns
> the same value, else a runtime PM reference imbalance would occur.  That
> assumption is not given if the PCIe port is inaccessible on remove due to
> hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(), which
> accesses Config Space to determine whether the port is Hot-Plug Capable.
> An inaccessible port returns "all ones", which is converted to "all
> zeroes" by pcie_capability_read_dword().  Hence the port no longer seems
> Hot-Plug Capable on remove even though it was on probe.
>
> The resulting runtime PM ref imbalance causes warning messages such as:
>
>   pcieport 0000:02:04.0: Runtime PM usage count underflow!
>
> Avoid the Config Space access (and thus the runtime PM ref imbalance) by
> caching the Hot-Plug Capable bit in struct pci_dev.
>
> The struct already contains an "is_hotplug_bridge" flag, which however is
> not only set on Hot-Plug Capable PCIe ports, but also Conventional PCI
> Hot-Plug bridges and ACPI slots.  The flag identifies bridges which are
> allocated additional MMIO and bus number resources to allow for hierarchy
> expansion.
>
> The kernel is somewhat sloppily using "is_hotplug_bridge" in a number of
> places to identify Hot-Plug Capable PCIe ports, even though the flag
> encompasses other devices.  Subsequent commits replace these occurrences
> with the new flag to clearly delineate Hot-Plug Capable PCIe ports from
> other kinds of hotplug bridges.
>
> Document the existing "is_hotplug_bridge" and the new "is_pciehp" flag
> and document the (non-obvious) requirement that pci_bridge_d3_possible()
> always returns the same value across the entire lifetime of a bridge,
> including its hot-removal.
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

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/pci-acpi.c | 4 +---
>  drivers/pci/pci.c      | 6 +++++-
>  drivers/pci/probe.c    | 2 +-
>  include/linux/pci.h    | 6 ++++++
>  4 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..efe478e5073e 100644
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
> +       if (!bridge->is_pciehp)
>                 return false;
>
>         if (pcie_ports_native)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..23d8fe98ddf9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3030,8 +3030,12 @@ static const struct dmi_system_id bridge_d3_blackl=
ist[] =3D {
>   * pci_bridge_d3_possible - Is it possible to put the bridge into D3
>   * @bridge: Bridge to check
>   *
> - * This function checks if it is possible to move the bridge to D3.
>   * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
> + *
> + * Return: Whether it is possible to move the bridge to D3.
> + *
> + * The return value is guaranteed to be constant across the entire lifet=
ime
> + * of the bridge, including its hot-removal.
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..cf50be63bf5f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1678,7 +1678,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
>
>         pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
>         if (reg32 & PCI_EXP_SLTCAP_HPC)
> -               pdev->is_hotplug_bridge =3D 1;
> +               pdev->is_hotplug_bridge =3D pdev->is_pciehp =3D 1;
>  }
>
>  static void set_pcie_thunderbolt(struct pci_dev *dev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..d56d0dd80afb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -328,6 +328,11 @@ struct rcec_ea;
>   *                     determined (e.g., for Root Complex Integrated
>   *                     Endpoints without the relevant Capability
>   *                     Registers).
> + * @is_hotplug_bridge: Hotplug bridge of any kind (e.g. PCIe Hot-Plug Ca=
pable,
> + *                     Conventional PCI Hot-Plug, ACPI slot).
> + *                     Such bridges are allocated additional MMIO and bu=
s
> + *                     number resources to allow for hierarchy expansion=
.
> + * @is_pciehp:         PCIe Hot-Plug Capable bridge.
>   */
>  struct pci_dev {
>         struct list_head bus_list;      /* Node in per-bus list */
> @@ -451,6 +456,7 @@ struct pci_dev {
>         unsigned int    is_physfn:1;
>         unsigned int    is_virtfn:1;
>         unsigned int    is_hotplug_bridge:1;
> +       unsigned int    is_pciehp:1;
>         unsigned int    shpc_managed:1;         /* SHPC owned by shpchp *=
/
>         unsigned int    is_thunderbolt:1;       /* Thunderbolt controller=
 */
>         /*
> --
> 2.47.2
>

