Return-Path: <linux-pci+bounces-38209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C070EBDE75B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B21921C67
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA6731A80D;
	Wed, 15 Oct 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="mhmFUvRx"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E998321F27
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531199; cv=none; b=emz8Ph1dX4CAHOUidUlp5UzeM+aSWotrET7gZOMUqNIjXMRhxgtpqUBS93DvENvSiD00g0X7lZuhVSFyf9KVFdWG2BKjPxI4ZCjwmKzYF7hsVA74N96Yj3u8E/n201DA8WPFgc041SltVpob5UazNZeHmYnJdQ6zUQ6suhj0JTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531199; c=relaxed/simple;
	bh=aMj4sClbUjM8FuyMzRtwUnv9ZgBdqUUIDZ4c/TEyBtE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bIKyANFpB6z9veJrbMQtxSyT/AVP76pyn81J66auY130da60fAGt++ZF07UA2/2rh+ZTcSYo+t0ZhaGjuA/ec2CmD1g+62RiFk8z0oRlg9qyeOf7oJcVtgVABDRFrYQag30kxK0bxejju6uBw80YetSLvVo/AsUTi9hXr4CFnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=mhmFUvRx; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1760531193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDcV3lL652QbBLMnHbavqNgqzG0RCaogCT38JOEzm/M=;
	b=mhmFUvRxh3egXLqDYFZYCkKBkJjbjPug1peJGFtU0/GYZ96HpY3qh0br1P0G6FHje4E3VE
	Jc08O9gtpde6LaaMd8UJanoxdA6MQerLn++S/zJa/v0+Z68+LnfkZ0VP4TgEIOTHg1f+cA
	9wn3Gt0nihnR8o427AW5CV5Wqwpia/fVfwlbaSijXnyC3bnb6KHq7YY/Dtjzq9qAifddO5
	eXrqXccEBE443kI+kJUkI1lzKnAJ4YMmXWm/gMMtaxGClttGhzXObpUvOVf2CfYCMrYKLh
	vj2xTAcuObzV4yfNNSRaLdeMguwFSd0TVbmX/24+hKI+fKIuYulgiEDkAhelag==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 14:26:30 +0200
Message-Id: <DDIW7ZP5K1VR.2I7VW56B9CZLF@cknow-tech.com>
Cc: <manivannan.sadhasivam@oss.qualcomm.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Manivannan Sadhasivam" <mani@kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, "David E. Box"
 <david.e.box@linux.intel.com>, "Kai-Heng Feng"
 <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Chia-Lin Kao"
 <acelan.kao@canonical.com>, "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>, "FUKAUMI Naoki" <naoki@radxa.com>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com> <20251014184905.GA896847@bhelgaas>
In-Reply-To: <20251014184905.GA896847@bhelgaas>
X-Migadu-Flow: FLOW_OUT

On Tue Oct 14, 2025 at 8:49 PM CEST, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
>> I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
>> Rockchip RK3588(S) SoC.
>>=20
>> When running Linux v6.18-rc1 or linux-next since 20250924, the kernel ei=
ther
>> freezes or fails to probe M.2 Wi-Fi modules. This happens with several
>> different modules I've tested, including the Realtek RTL8852BE, MediaTek
>> MT7921E, and Intel AX210.
>>=20
>> I've found that reverting the following commit (i.e., the patch I'm repl=
ying
>> to) resolves the problem:
>> commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
>
> Thanks for the report, and sorry for the regression.
>
> Since this affects several devices from different manufacturers and (I
> assume) different drivers, it seems likely that there's some issue
> with the Rockchip end, since ASPM probably works on these devices in
> other systems.  So we should figure out if there's something wrong
> with the way we configure ASPM, which we could potentially fix, or if
> there's a hardware issue and we need some king of quirk to prevent
> usage of ASPM on the affected platforms.
>
> Can you collect a complete dmesg log when booting with
>
>   ignore_loglevel pci=3Dearlydump dyndbg=3D"file drivers/pci/* +p"
>
> and the output of "sudo lspci -vv"?

I have a Rock 5B as well, but I don't have a Wi-Fi module, but I do have
a NVMe drive connected. That boots fine with 6.17, but I end up in a
rescue shell with 6.18-rc1. I haven't verified that it's caused by the
same commit, but it does sound plausible.

On this device, the NVMe isn't strictly needed (I used it to compile my
kernels on), so I added 'noauto' to the NVMe line in /etc/fstab ... and
that made it boot successfully into 6.18-rc1. Then running the 'mount'
command wrt that NVMe drive failed with this message:

  EXT4-fs (nvme0n1p1): unable to read superblock

The log of my attempts can be found here:
https://paste.sr.ht/~diederik/f435eb258dca60676f7ac5154c00ddfdc24ac0b7

> When the kernel freezes, can you give us any information about where,
> e.g., a log or screenshot?

For me, there is no kernel freeze. I ended up in a rescue shell as it
couldn't mount the NVMe drive. As described above, when not letting it
auto-mount that drive, the boot completed normally.

> Do you know if any platforms other than Radxa ROCK 5A/5B have this
> problem?

I do have a NanoPi R5S (rk3568) which also has a NVMe drive attached,
but that one is mounted on /var ...

> #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM=
 states for devicetree platforms")
> #regzbot dup-of: https://github.com/chzigotzky/kernels/issues/17
>
>> On 9/23/25 01:16, Manivannan Sadhasivam via B4 Relay wrote:
>> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>> >=20
>> > So far, the PCI subsystem has honored the ASPM and Clock PM states set=
 by
>> > the BIOS (through LNKCTL) during device initialization, if it relies o=
n the
>> > default state selected using:
>> >=20
>> > * Kconfig: CONFIG_PCIEASPM_DEFAULT=3Dy, or
>> > * cmdline: "pcie_aspm=3Doff", or
>> > * FADT: ACPI_FADT_NO_ASPM
>> >=20
>> > This was done conservatively to avoid issues with the buggy devices th=
at
>> > advertise ASPM capabilities, but behave erratically if the ASPM states=
 are
>> > enabled. So the PCI subsystem ended up trusting the BIOS to enable onl=
y the
>> > ASPM states that were known to work for the devices.
>> >=20
>> > But this turned out to be a problem for devicetree platforms, especial=
ly
>> > the ARM based devicetree platforms powering Embedded and *some* Comput=
e
>> > devices as they tend to run without any standard BIOS. So the ASPM sta=
tes

I noticed in Naoki's log that it had lines mentioning 'BIOS', but I do
not. Naoki's log is wrt Rock 5A, while mine is wrt Rock 5B. I don't
suspect that's very relevant though.

Cheers,
  Diederik

>> > on these platforms were left disabled during boot and the PCI subsyste=
m
>> > never bothered to enable them, unless the user has forcefully enabled =
the
>> > ASPM states through Kconfig, cmdline, and sysfs or the device drivers
>> > themselves, enabling the ASPM states through pci_enable_link_state() A=
PIs.
>> >=20
>> > This caused runtime power issues on those platforms. So a couple of
>> > approaches were tried to mitigate this BIOS dependency without user
>> > intervention by enabling the ASPM states in the PCI controller drivers
>> > after device enumeration, and overriding the ASPM/Clock PM states
>> > by the PCI controller drivers through an API before enumeration.
>> >=20
>> > But it has been concluded that none of these mitigations should really=
 be
>> > required and the PCI subsystem should enable the ASPM states advertise=
d by
>> > the devices without relying on BIOS or the PCI controller drivers. If =
any
>> > device is found to be misbehaving after enabling ASPM states that they
>> > advertised, then those devices should be quirked to disable the proble=
matic
>> > ASPM/Clock PM states.
>> >=20
>> > In an effort to do so, start by overriding the ASPM and Clock PM state=
s set
>> > by the BIOS for devicetree platforms first. Separate helper functions =
are
>> > introduced to override the BIOS set states by enabling all of them if
>> > of_have_populated_dt() returns true. To aid debugging, print the overr=
idden
>> > ASPM and Clock PM states as well.
>> >=20
>> > In the future, these helpers could be extended to allow other platform=
s
>> > like VMD, newer ACPI systems with a cutoff year etc... to follow the p=
ath.
>> >=20
>> > Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelga=
as
>> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualco=
mm.com>
>> > Link: https://patch.msgid.link/20250916-pci-dt-aspm-v1-1-778fe907c9ad@=
oss.qualcomm.com
>> > ---
>> >   drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++=
+--
>> >   1 file changed, 40 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> > index 919a05b9764791c3cc469c9ada62ba5b2c405118..cda31150aec1b67b6a48b6=
0569222ea3d1c3d41f 100644
>> > --- a/drivers/pci/pcie/aspm.c
>> > +++ b/drivers/pci/pcie/aspm.c
>> > @@ -15,6 +15,7 @@
>> >   #include <linux/math.h>
>> >   #include <linux/module.h>
>> >   #include <linux/moduleparam.h>
>> > +#include <linux/of.h>
>> >   #include <linux/pci.h>
>> >   #include <linux/pci_regs.h>
>> >   #include <linux/errno.h>
>> > @@ -235,13 +236,15 @@ struct pcie_link_state {
>> >   	u32 aspm_support:7;		/* Supported ASPM state */
>> >   	u32 aspm_enabled:7;		/* Enabled ASPM state */
>> >   	u32 aspm_capable:7;		/* Capable ASPM state with latency */
>> > -	u32 aspm_default:7;		/* Default ASPM state by BIOS */
>> > +	u32 aspm_default:7;		/* Default ASPM state by BIOS or
>> > +					   override */
>> >   	u32 aspm_disable:7;		/* Disabled ASPM state */
>> >   	/* Clock PM state */
>> >   	u32 clkpm_capable:1;		/* Clock PM capable? */
>> >   	u32 clkpm_enabled:1;		/* Current Clock PM state */
>> > -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>> > +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
>> > +					   override */
>> >   	u32 clkpm_disable:1;		/* Clock PM disabled */
>> >   };
>> > @@ -373,6 +376,18 @@ static void pcie_set_clkpm(struct pcie_link_state=
 *link, int enable)
>> >   	pcie_set_clkpm_nocheck(link, enable);
>> >   }
>> > +static void pcie_clkpm_override_default_link_state(struct pcie_link_s=
tate *link,
>> > +						   int enabled)
>> > +{
>> > +	struct pci_dev *pdev =3D link->downstream;
>> > +
>> > +	/* Override the BIOS disabled Clock PM state for devicetree platform=
s */
>> > +	if (of_have_populated_dt() && !enabled) {
>> > +		link->clkpm_default =3D 1;
>> > +		pci_info(pdev, "Clock PM state overridden: ClockPM+\n");
>> > +	}
>> > +}
>> > +
>> >   static void pcie_clkpm_cap_init(struct pcie_link_state *link, int bl=
acklist)
>> >   {
>> >   	int capable =3D 1, enabled =3D 1;
>> > @@ -395,6 +410,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_s=
tate *link, int blacklist)
>> >   	}
>> >   	link->clkpm_enabled =3D enabled;
>> >   	link->clkpm_default =3D enabled;
>> > +	pcie_clkpm_override_default_link_state(link, enabled);
>> >   	link->clkpm_capable =3D capable;
>> >   	link->clkpm_disable =3D blacklist ? 1 : 0;
>> >   }
>> > @@ -788,6 +804,26 @@ static void aspm_l1ss_init(struct pcie_link_state=
 *link)
>> >   		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
>> >   }
>> > +static void pcie_aspm_override_default_link_state(struct pcie_link_st=
ate *link)
>> > +{
>> > +	struct pci_dev *pdev =3D link->downstream;
>> > +	u32 override;
>> > +
>> > +	/* Override the BIOS disabled ASPM states for devicetree platforms *=
/
>> > +	if (of_have_populated_dt()) {
>> > +		link->aspm_default =3D PCIE_LINK_STATE_ASPM_ALL;
>> > +		override =3D link->aspm_default & ~link->aspm_enabled;
>> > +		if (override)
>> > +			pci_info(pdev, "ASPM states overridden: %s%s%s%s%s%s\n",
>> > +				 (override & PCIE_LINK_STATE_L0S) ? "L0s+, " : "",
>> > +				 (override & PCIE_LINK_STATE_L1) ? "L1+, " : "",
>> > +				 (override & PCIE_LINK_STATE_L1_1) ? "L1.1+, " : "",
>> > +				 (override & PCIE_LINK_STATE_L1_2) ? "L1.2+, " : "",
>> > +				 (override & PCIE_LINK_STATE_L1_1_PCIPM) ? "L1.1 PCI-PM+, " : "",
>> > +				 (override & PCIE_LINK_STATE_L1_2_PCIPM) ? "L1.2 PCI-PM+" : "");
>> > +	}
>> > +}
>> > +
>> >   static void pcie_aspm_cap_init(struct pcie_link_state *link, int bla=
cklist)
>> >   {
>> >   	struct pci_dev *child =3D link->downstream, *parent =3D link->pdev;
>> > @@ -868,6 +904,8 @@ static void pcie_aspm_cap_init(struct pcie_link_st=
ate *link, int blacklist)
>> >   	/* Save default state */
>> >   	link->aspm_default =3D link->aspm_enabled;
>> > +	pcie_aspm_override_default_link_state(link);
>> > +
>> >   	/* Setup initial capable state. Will be updated later */
>> >   	link->aspm_capable =3D link->aspm_support;
>> >=20
>>=20
>>=20
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


