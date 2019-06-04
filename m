Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE9347AA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfFDNIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:08:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45171 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfFDNIn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:08:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so1033348wre.12;
        Tue, 04 Jun 2019 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ja42kw7uBfsBKpf4+zCIJaSquw+Aa6YWSyrqsgnB08M=;
        b=iRC5xFX0BivJod9qqeyNu72KEal0IhC2P9gbvWNx1fDr39egx4vc132OVZNMLnvtZu
         i1obPUJS5JevA52HvHcw4enDAflnCsmk6fNQljKes09Ut9y9Tuf5eKXD4/a6JLRxScdm
         g+7YsYXtTfrtBhTbuEqBo8/Bus9LCiHWBod/MNKl/tXFtvdwj+dH8kvhkNIEJspcAkTp
         0VOx7DzMhkg4j2Kz1hZYPLe4c51MRigzZHvQgFGM17lgjj+0H7k7MglQLWSm/Ml/sZ7B
         ulbZGXDgXXRkAt8cW8uwhKeAZVMhMHtRPq1eY/xEjdRhsLrqJS02s/KeayOPtZFJ1gBS
         xygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ja42kw7uBfsBKpf4+zCIJaSquw+Aa6YWSyrqsgnB08M=;
        b=RjW8P9CuHyOCZgy4ODM5BrWn9BdbD4VCbI3e3QT33rf+bFFzDQ789Q+3Vg20/GhOwG
         yuz9BSXnHJoy4fobFugHuurdcaD6/z0D2exot5PAf9/tGM5W1zRmaIO/yHAtpewWQSdv
         BZ/pAgdMVxmfgy3pf8BgSKjznDN1C1XPNHm73XZZLe8nd8Kp1feIQKTSu+58jUi6yn1S
         cNh7D+mg1fc33kdyzRBFkO785a6WqdaO8Ktwmp2HooUibdf4YkpxFQyBjHZQepw7CYpJ
         u/V9ddGFn34UA0S/SBio/N3Unhp1+nQx8nwOQsd/TO6mCjT9VVglOTAt1ojXmyl+1b4D
         ZeWg==
X-Gm-Message-State: APjAAAW+m4aH29VU2miv4EMG+mErEwXycHvZofWq56kpf7MrN2xICKcW
        TeNLCSfEbAJr+EeU5+pfqTzCRSu6
X-Google-Smtp-Source: APXvYqzNuTabDjtD2ebwcUOKc1RGaO4DF4ePev9C+ps4XkQaNqt9/+faB2BX37NLfINaTAhtpCOXUA==
X-Received: by 2002:a5d:4b4a:: with SMTP id w10mr4388732wrs.337.1559653720070;
        Tue, 04 Jun 2019 06:08:40 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v6sm6362452wru.6.2019.06.04.06.08.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 06:08:39 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:08:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 04/28] PCI: tegra: Mask AFI_INTR in runtime suspend
Message-ID: <20190604130838.GR16519@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-5-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Qexx6XJGNEACt6j"
Content-Disposition: inline
In-Reply-To: <20190516055307.25737-5-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--0Qexx6XJGNEACt6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 11:22:43AM +0530, Manikanta Maddireddy wrote:
> AFI_INTR is unmasked in tegra_pcie_enable_controller(), mask it to avoid
> unwanted interrupts raised by AFI after pex_rst is asserted.
>=20
> Following sequence triggers such scenario,
>  - tegra_pcie_remove() triggers runtime suspend
>  - pex_rst is asserted in runtime suspend
>  - PRSNT_MAP bit field in RP_PRIV_MISC register changes from EP_PRSNT to
>    EP_ABSNT
>  - This is sensed by AFI and triggers "Slot present pin change" interrupt
>  - tegra_pcie_isr() function accesses AFI register when runtime suspend
>    is going through power off sequence
>=20
> rmmod pci-tegra
>  pci_generic_config_write32: 108 callbacks suppressed
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4c may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x9c may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x88 may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x90 may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4 may corr=
upt adjacent RW1C bits
>  igb 0002:04:00.1: removed PHC on enP2p4s0f1
>  igb 0002:04:00.0: removed PHC on enP2p4s0f0
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4c may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x9c may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x88 may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x90 may cor=
rupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4 may corr=
upt adjacent RW1C bits
>  rcu: INFO: rcu_preempt self-detected stall on CPU
>  SError Interrupt on CPU0, code 0xbf000002 -- SError
>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next=
-20190405-00027-gcd8110499e6f-dirty #42
>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
>  pstate: 20000085 (nzCv daIf -PAN -UAO)
>  pc : tegra_pcie_isr+0x58/0x178 [pci_tegra]
>  lr : tegra_pcie_isr+0x40/0x178 [pci_tegra]
>  sp : ffff000010003da0
>  x29: ffff000010003da0 x28: 0000000000000000
>  x27: ffff8000f9e61000 x26: ffff000010fbf420
>  x25: ffff000011427f93 x24: ffff8000fa600410
>  x23: ffff00001129d000 x22: ffff00001129d000
>  x21: ffff8000f18bf3c0 x20: 0000000000000070
>  x19: 00000000ffffffff x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000
>  x15: 0000000000000000 x14: ffff000008d40a48
>  x13: ffff000008d40a30 x12: ffff000008d40a20
>  x11: ffff000008d40a10 x10: ffff000008d40a00
>  x9 : ffff000008d409e8 x8 : ffff000008d40ae8
>  x7 : ffff000008d40ad0 x6 : ffff000010003e58
>  x5 : ffff8000fac00248 x4 : 0000000000000000
>  x3 : ffff000008d40b08 x2 : fffffffffffffff8
>  x1 : ffff000008d3f4e8 x0 : 00000000ffffffff
>  Kernel panic - not syncing: Asynchronous SError Interrupt
>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next=
-20190405-00027-gcd8110499e6f-dirty #42
>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
>  Call trace:
>   dump_backtrace+0x0/0x158
>   show_stack+0x14/0x20
>   dump_stack+0xa8/0xcc
>   panic+0x140/0x2f4
>   nmi_panic+0x6c/0x70
>   arm64_serror_panic+0x74/0x80
>   __pte_error+0x0/0x28
>   el1_error+0x84/0xf8
>   tegra_pcie_isr+0x58/0x178 [pci_tegra]
>   __handle_irq_event_percpu+0x70/0x198
>   handle_irq_event_percpu+0x34/0x88
>   handle_irq_event+0x48/0x78
>   handle_fasteoi_irq+0xb4/0x190
>   generic_handle_irq+0x24/0x38
>   __handle_domain_irq+0x5c/0xb8
>   gic_handle_irq+0x58/0xa8
>   el1_irq+0xb8/0x180
>   cpuidle_enter_state+0x138/0x358
>   cpuidle_enter+0x18/0x20
>   call_cpuidle+0x1c/0x48
>   do_idle+0x230/0x2d0
>   cpu_startup_entry+0x20/0x28
>   rest_init+0xd4/0xe0
>   arch_call_rest_init+0xc/0x14
>   start_kernel+0x444/0x470
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4: No change
>=20
> V3:
> * Update the commit log and comment to reflect why this fix is required
> * MSI interrupt is not disabled
>=20
> V2: This is new patch in V2
>=20
>  drivers/pci/controller/pci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index bb3c0af9c830..d0e517f084a1 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1622,6 +1622,15 @@ static int tegra_pcie_disable_msi(struct tegra_pci=
e *pcie)
>  	return 0;
>  }
> =20
> +static void tegra_pcie_disable_interrupts(struct tegra_pcie *pcie)
> +{
> +	u32 value;
> +
> +	value =3D afi_readl(pcie, AFI_INTR_MASK);
> +	value &=3D ~AFI_INTR_MASK_INT_MASK;
> +	afi_writel(pcie, value, AFI_INTR_MASK);
> +}
> +
>  static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
>  				      u32 *xbar)
>  {
> @@ -2466,6 +2475,11 @@ static int __maybe_unused tegra_pcie_pm_suspend(st=
ruct device *dev)
>  		tegra_pcie_pme_turnoff(port);
> =20
>  	tegra_pcie_disable_ports(pcie);
> +	/*

Use a blank line before block-style comments (and typically comments in
general) for better readability.

Other than than:

Acked-by: Thierry Reding <treding@nvidia.com>

> +	 * AFI_INTR is unmasked in tegra_pcie_enable_controller(), mask it to
> +	 * avoid unwanted interrupts raised by AFI after pex_rst is asserted.
> +	 */
> +	tegra_pcie_disable_interrupts(pcie);
> =20
>  	if (pcie->soc->program_uphy) {
>  		err =3D tegra_pcie_phy_power_off(pcie);
> --=20
> 2.17.1
>=20

--0Qexx6XJGNEACt6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2bVMACgkQ3SOs138+
s6Gn0Q/+IV7+AniIum44ShgAwkcVOVySNa6cNQem8a0reLjG6j7sJi/ILtm3UYb+
NfnXjIbCP8xYBu7WD902NWZHyzk2byXonUAPHETYnMDTM3I0VjI0HdlHO0LqHhDi
WGIlOJeReM3fINf6N7xUgDsZO+xj/mPQoeIABX9LaU0K2ZxQiodVL7WxB/18V+Mc
KiVDUbqONpvL0nLvtArjghwtCfLQaUDPikPjOSC9CaqC7UOvREEE9L5JU9jF5Bhr
gmjy/NO8OHuoo0i/BqDPBmjcLpPDxqbpxRYgEyctFqIKGL7lSoUYfHJDT4CiQH75
UqAVIGvWNPEXOtpj56QR2al4LgW00riohF3MgUEEc1OIrbedK8hx+fQ3VJe0mXYB
ZFmOF0wOQH3MU/U6qbltBYUbtbVCbOsTcbFjcBlWnXcmLHqSapJn0qbHVcigrvfN
lo/iZP0luqFCyI6cTNLvRPPKQmmcPqaTka+1gCZW3mKBsaYHxgJGEbs2woNHGAr0
SIJrqD61fy//GVKodgStlP4RcPWBmavnvC0JeDftkTgZk3BkEoqJwKWxBOn6eI15
pZ+xpZoylzz3qlxCUih+G0OIz8enRztkbSAweSNaEiWBrsdS5VACTWV/ka1q271S
ma3jPVsSKDdpC/bq3lazBn1Vlz8+FAPDDEnHL21ZFtNEC3i/Grk=
=rSAz
-----END PGP SIGNATURE-----

--0Qexx6XJGNEACt6j--
