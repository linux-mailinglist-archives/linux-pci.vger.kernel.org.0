Return-Path: <linux-pci+bounces-31389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEEFAF735F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B4D168671
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6B2DE6E2;
	Thu,  3 Jul 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFWotAxj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9335946
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544700; cv=none; b=I9HR1ClOdZbjKdXE+HaDKHkRmTh1azdSFSIEbfGRMIyJGaO5PIK+z1gyRlgmyWKcXASeS5kKuxPZBTa8DoTQ09Tgk0Luy8pUnpGd6RtHN8bCEEh2KddDLhoa6CdZ8rlR1H7EP8Oh4A9ylqvJ5SoqiAFBdjgkcTG1oBl8cTYIqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544700; c=relaxed/simple;
	bh=tTTdlEewKCi0CTLElzQyiWxso5YfLRW42VSoFBaIyxo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PGdvjgkqb+1M/AeJLTqma4ymbqsgwZ6o+F8ndz5ItRS80rXOCcuK2YGbjU/dgyWJB2NsH8tOshia8qtxuJdoy+agaUT3D7xNlNgsmJODXj5Z5heGBCey4Y4sTK/4Zlqo1BYuQSj+IhQLTDlEsOZJzUq3eulH8Zp1eIpGv1WSJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFWotAxj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751544699; x=1783080699;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tTTdlEewKCi0CTLElzQyiWxso5YfLRW42VSoFBaIyxo=;
  b=RFWotAxjXVTyJmhtkftxQthqdI+wcHjXtBimfeYsepCC7YnI9GlSxfsR
   Df/JXPrO9o+oQfS8XMUK0IdaHa0psu1AC86Il+9QKHM6bCPFNYD1OnLfy
   wkByWw4LpQ9sHcqkW8yMSkqlQYjczWt3vVJ6u8fUSNsWw//EI8M2yE7dd
   aEhOoVZu97rkENmjF4YjtTO29el8KD9BN9D+6V1hAoKlTh9WaiEjobjo4
   WTkLL9mnEoIicLjmOSnui4ejCQqT6nEqQEUaBEFwpkQSsNy9X+wgYa+/k
   mu9C7RzqkySqAHcIBW/Ydc9/XsxTCZosFH/7CAC5XvJzCPRGYfmLMXdCB
   g==;
X-CSE-ConnectionGUID: Z/o6ZS2uRk2ou680fNM6sQ==
X-CSE-MsgGUID: 8eV1QRf8TYWYoffgIs+N6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53836397"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53836397"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:11:36 -0700
X-CSE-ConnectionGUID: FueEwQYqTQ+2uyJlipLz8Q==
X-CSE-MsgGUID: aXzFt1wTRfyoG11Ry5y6Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="185371624"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:11:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Jul 2025 15:11:30 +0300 (EEST)
To: Matthew W Carlis <mattc@purestorage.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com, ashishk@purestorage.com, 
    macro@orcam.me.uk, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH v2 1/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <20250702052430.13716-2-mattc@purestorage.com>
Message-ID: <eb43f8c8-cf36-0c94-e87d-78d8ef8efb9c@linux.intel.com>
References: <20250702052430.13716-1-mattc@purestorage.com> <20250702052430.13716-2-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-399375908-1751544690=:2373"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-399375908-1751544690=:2373
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Jul 2025, Matthew W Carlis wrote:

Hi Matthew,

I have a few simple style related comments to the patch itself and=20
questions about this scenario below.

The wording in the shortlog (in subject) sounds a bit clumsy to me,=20
perhaps change it to something like this:

PCI: Don't use Target Speed quirk if device is not ASM2824

>   The pcie_failed_link_retrain() was added due to a behavior observed wit=
h
> a very specific set of circumstances which are in a comment above the
> function. The "quirk" is supposed to force the link down to Gen1 in the
> case where LTSSM is stuck in a loop or failing to train etc. The problem
> is that this "quirk" is applied to any bridge & it can often write the
> Gen1 TLS (Target Link Speed) when it should not. Leaving the port in
> a state that will result in a device linking up at Gen1 when it should no=
t.
>   Incorrect action by pcie_failed_link_retrain() has been observed with a
> variety of different NVMe drives using U.2 connectors & in multiple diffe=
rent
> hardware designs. Directly attached to the root port, downstream of a
> PCIe switch (Microchip/Broadcom) with different generations of Intel CPU.
> All of these systems were configured without power controller capability.
> They were also all in compliance with the Async Hot-Plug Reference model =
in
> PCI Express=C2=AE Base Specification Revision 6.0 Appendix I. for OS cont=
rolled
> DPC Hot-Plug.
>   The issue appears to be more likely to hit to be applied when using
> OOB PD (out-of band presence detect), but has also been observed without
> OOB PD support ('DLL State Changed' or 'In-Band PD').
>   Powering off or power cycling the slot via an out-of-band power control
> mechanism with OOB PD is extremely likely to hit since the kernel would
> see that slot presence is true. Physical Hot-insertion is also extremly

extremely

> likely to hit this issue with OOB PD with U.2 drives due to timing
> between presence assertion and the actual power-on/link-up of the NVMe
> drive itself. When the device eventually does power-up the TLS would
> have been left forced to Gen1. This is similarly true to the case of
> power cycling or powering off the slot.
>   Exact circumstances for when this issue has been hit in a system withou=
t
> OOB PD due hasn't been fully understood to due having less reproductions
> as well as having reverted this patch for this configurations.

Paragraphs should be separated with empty lines and started without spaces=
=20
as indent.

This description did not answer to the key question, why does=20
pcie_lbms_seen() returns true in these case which is required for 2.5GT/s=
=20
to be set for the bridge? Is it a stale indication? Would LBMS get=20
cleared but quirk runs too soon to see that?

Is this mainly related to some artificial test that rapidly fires event=20
after another (which is known to confuse the quirk)? ...I mean, you say=20
"extremely likely".

I suppose when the problem occurs and the bridge remains at 2.5GT/s, is it=
=20
possible to restore the higher speed using the pcie_cooling device=20
associated with the bridge / bwctrl? You can find the correct cooling=20
device with this:

grep -H . /sys/class/thermal/cooling_device*/type | grep PCIe_

=2E..and then write to cur_state.

> Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
> ---
>  drivers/pci/quirks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d7f4ee634263..39bb0c025119 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -100,6 +100,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  =09};
>  =09u16 lnksta, lnkctl2;
>  =09int ret =3D -ENOTTY;

As per the coding style, please add an empty line after the local=20
variables.

> +=09if (!pci_match_id(ids, dev))
> +=09=09return ret;

--=20
 i.

--8323328-399375908-1751544690=:2373--

