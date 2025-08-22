Return-Path: <linux-pci+bounces-34553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF0B3174D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB13A9871
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683B2FA0E8;
	Fri, 22 Aug 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ/hJM65"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EC26AA83;
	Fri, 22 Aug 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864755; cv=none; b=sBB2xp93zKUsRmeq7RQlvHHBED6F8f2nyEG9GJvkUQHHl4djGlYHvh4/rlZngqbvTnITyKhCSHZtYMRvyvDkIit+9ipWkZq+AMUM+wOeyJsUMZ0id0zV4Q3L7QnXB1HWvFXkhQ6liQa+JuBPIQ5Ow5CcNHGm2boflHVWKQOxeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864755; c=relaxed/simple;
	bh=Mvlhke7au8nGa00IzO2RzEm3fIj7Edm3O+hsRfIg+ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrMMCdxIiS1O4vd/IexEY8YGA32E1bSIA05nzKeDoI/C1rZ68z39+fCBkpjESZHlYQ6Vkd6UoxWcYOmKde62jHfHs1dUX1qLgy7RUbfMko3dTSEUl1arYOzCdDKRZqnZersEGibD7lnMrIJoacqmxs/zWmB/XFUDPrphbY0odoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ/hJM65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E26EC116D0;
	Fri, 22 Aug 2025 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864755;
	bh=Mvlhke7au8nGa00IzO2RzEm3fIj7Edm3O+hsRfIg+ls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DJ/hJM65J+NCFa1TR5Dzswdt1VlqaxAIr2rbSaUK5lyCoW/1SHcWBmpakCWQpe0/8
	 UX22OmteeeRRiSGMKwtiJsyUzZuLgNujW/6hz4Cu9RlFArf7ibC3F3hUM7kuq3Bb5H
	 qLwo9QNYlSIzkaov0FGDLEHP6so3NAdg6rG0ZMtNkrQZwp4R5z8dPEZ4ywAr/48QBB
	 VuDgucp12mpfu0EkX6EYJHEB6FM5UOMUxP38bNs6WTgO6B0WCWjz1CCshug4Gv7SQ0
	 gS/U72b83dz8cm2+sEhVT8Bsdx5n1BEju/bNKAApd8f/LKadkBRi8+S173ithqY5gT
	 2PFRLNTXsunAg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74381e0a227so1300659a34.0;
        Fri, 22 Aug 2025 05:12:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPHCTLIQdp5HuSQay+rk6kkRDdesOZJhrCtFOrKuqR9ufEkfSLy8L7D168yW6oKvcjgnPMCSeyqn4f@vger.kernel.org, AJvYcCUzoCcIJq3xfzG0KbxpotD+XZFHy08dt04BjNjftG7C7g8F4cty80wkMZ1FRR50vgvaoHCDaMyGLug=@vger.kernel.org, AJvYcCWh6XmjFwHLDD9qnbcnTdhl3FhSGRxfgwJA7pqF5uuzOynsXvJLWjJ5HtvttFuJZqzwQeUtgyL/5z0WpJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJs2n1h7C65vNCoH+dqqVaF8EIPVPGqn3h2V9O4aGukBlOD0fW
	CFiRxsaVUPCT3ZfNYBxvP04xZzow857VjBL/JrvqnaOQEEs4ibf1l1P1K36MzmARsnd2iZoTEKW
	eWBTDGT6lNy8UA2xfs2M2fHeD4V4rzUM=
X-Google-Smtp-Source: AGHT+IGPTpgPF+noT41oenFI55ABOzE3DiKUOVCZpppLYQJmDzi7qRjEr+Rz30/G1XGCMW9IbNfNxTBAw4Szqy9D81k=
X-Received: by 2002:a05:6871:b07:b0:314:b6a6:6865 with SMTP id
 586e51a60fabf-314dce990afmr1106523fac.51.1755864754268; Fri, 22 Aug 2025
 05:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822031159.4005529-1-david.e.box@linux.intel.com>
In-Reply-To: <20250822031159.4005529-1-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 14:12:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jbc0xdwBkxa3uHmTmvpnBp+qcWre26-Q-Nd2UVa_=v5Q@mail.gmail.com>
X-Gm-Features: Ac12FXz-lwMcvSAAACv7p53RSiJ2hdwWX_YxUGSg9_tH6u3CXa2DSvqXRGmaRCw
Message-ID: <CAJZ5v0jbc0xdwBkxa3uHmTmvpnBp+qcWre26-Q-Nd2UVa_=v5Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	mani@kernel.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:12=E2=80=AFAM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> defaults. Devices in such domains may therefore run without the intended
> power management.
>
> Add a host-bridge mechanism that lets controller drivers supply their own
> defaults. A new aspm_default_link_state field in struct pci_host_bridge i=
s
> set via pci_host_set_default_pcie_link_state(). During link initializatio=
n,
> if this field is non-zero, ASPM and CLKPM defaults come from it instead o=
f
> BIOS.
>
> This enables drivers like VMD to align link power management with platfor=
m
> expectations and avoids embedding controller-specific quirks in ASPM core
> logic.
>
> Link: https://patchwork.ozlabs.org/project/linux-pci/patch/20250720190140=
.2639200-1-david.e.box%40linux.intel.com/
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

No issues found, so

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

There is a very minor nit below, but it has no bearing on the above.

> ---
>
> Changes in V1 from RFC:
>
>   -- Rename field to aspm_dflt_link_state since it stores
>      PCIE_LINK_STATE_XXX flags, not a policy enum.
>   -- Move the field to struct pci_host_bridge since it's being applied to
>      the entire host bridge per Mani's suggestion.
>   -- During testing noticed that clkpm remained disabled and this was
>      also handled by the formerly used pci_enable_link_state(). Add a
>      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
>
> Changes in V2:
>
>   -- Host field name changed to aspm_default_link_state.
>   -- Added get/set functions for aspm_default_link_state. Only the
>      setter is exported. Added a kernel-doc describing usage and
>      particulars around meaning of 0.
>
>  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci.h     |  9 +++++++++
>  2 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 919a05b97647..b4f0b4805a35 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -373,6 +373,39 @@ static void pcie_set_clkpm(struct pcie_link_state *l=
ink, int enable)
>         pcie_set_clkpm_nocheck(link, enable);
>  }
>
> +/**
> + * pci_host_set_default_pcie_link_state - set controller-provided defaul=
t ASPM/CLKPM mask
> + * @host: host bridge on which to apply the defaults
> + * @state: PCIE_LINK_STATE_XXX flags
> + *
> + * Allows a PCIe controller driver to specify the default ASPM and/or
> + * Clock Power Management (CLKPM) link state mask that will be used
> + * for links under this host bridge during ASPM/CLKPM capability init.
> + *
> + * The value is consumed in pcie_aspm_cap_init() and pcie_clkpm_cap_init=
()
> + * to override the firmware-discovered defaults.
> + *
> + * Interpretation of aspm_default_link_state:
> + *   - Nonzero: bitmask of PCIE_LINK_STATE_* values to be used as defaul=
ts
> + *   - Zero:    no override provided; ASPM/CLKPM defaults fall back to
> + *              values discovered in hardware/firmware
> + *
> + * Note: zero is always treated as "unset", not as "force ASPM/CLKPM off=
".
> + */
> +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +                                         unsigned int state)
> +{
> +       host->aspm_default_link_state =3D state;
> +}
> +EXPORT_SYMBOL_GPL(pci_host_set_default_pcie_link_state);
> +
> +static u32 pci_host_get_default_pcie_link_state(struct pci_dev *parent)

The parameter need not be called "parent".

> +{
> +       struct pci_host_bridge *host =3D pci_find_host_bridge(parent->bus=
);
> +
> +       return host ? host->aspm_default_link_state : 0;
> +}
> +
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blackl=
ist)
>  {
>         int capable =3D 1, enabled =3D 1;
> @@ -394,7 +427,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_sta=
te *link, int blacklist)
>                         enabled =3D 0;
>         }
>         link->clkpm_enabled =3D enabled;
> -       link->clkpm_default =3D enabled;
> +       if (pci_host_get_default_pcie_link_state(link->pdev) & PCIE_LINK_=
STATE_CLKPM)
> +               link->clkpm_default =3D 1;
> +       else
> +               link->clkpm_default =3D enabled;
>         link->clkpm_capable =3D capable;
>         link->clkpm_disable =3D blacklist ? 1 : 0;
>  }
> @@ -866,7 +902,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state=
 *link, int blacklist)
>         }
>
>         /* Save default state */
> -       link->aspm_default =3D link->aspm_enabled;
> +       link->aspm_default =3D pci_host_get_default_pcie_link_state(paren=
t);
> +       if (!link->aspm_default)
> +               link->aspm_default =3D link->aspm_enabled;
>
>         /* Setup initial capable state. Will be updated later */
>         link->aspm_capable =3D link->aspm_support;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860..8947cbaf9fa6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -620,6 +620,10 @@ struct pci_host_bridge {
>         unsigned int    size_windows:1;         /* Enable root bus sizing=
 */
>         unsigned int    msi_domain:1;           /* Bridge wants MSI domai=
n */
>
> +#ifdef CONFIG_PCIEASPM
> +       unsigned int    aspm_default_link_state;        /* Controller-pro=
vided default */
> +#endif
> +
>         /* Resource alignment requirements */
>         resource_size_t (*align_resource)(struct pci_dev *dev,
>                         const struct resource *res,
> @@ -1849,6 +1853,8 @@ int pci_disable_link_state(struct pci_dev *pdev, in=
t state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>  int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +                                         unsigned int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  bool pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1861,6 +1867,9 @@ static inline int pci_enable_link_state(struct pci_=
dev *pdev, int state)
>  { return 0; }
>  static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int=
 state)
>  { return 0; }
> +static inline void
> +pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +                                    unsigned int state) { }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>  static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return fals=
e; }
>
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> --
> 2.43.0
>

