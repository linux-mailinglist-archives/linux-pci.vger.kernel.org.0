Return-Path: <linux-pci+bounces-25981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C3A8B2E6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449691905847
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C842253F6;
	Wed, 16 Apr 2025 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsdYmy1R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A81F94C;
	Wed, 16 Apr 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790458; cv=none; b=ZX2T+39b3FrpKxLqoX5ECy8KpCJTeEI9HtTGewA9senDO626YmG7kS5agZ528fnsdN7VJ8FQ9GmC6g20Iyen4aI0mDeDN8P8YDrPZLb/DP7cQuvobGv4uGBr6GOMM1h/8q0PBHPYudcGkDxrZHUrQyKVGjP9ZoXiOYhH1hWqDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790458; c=relaxed/simple;
	bh=OaeQGXsO6kmHJmqkUC48ldZurlI7o6Ga/Bsl2vQOpoI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d+rYXcro80yBmhZMz5ufpwYhzxJRceM50Dcm2E3Qj2N1V6ETjbXGR+WDPU7YX7tjNoQrTNIRfSMZ/0N9ZuLHdm5XL6zJy8u5ZVZryQTVQL2gkHbwduQZGuXo67zkOhKx4iZjvHrMuCW7zTCSz0Ajd9fYbW3sgsvvwSFDFU0yhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsdYmy1R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744790458; x=1776326458;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OaeQGXsO6kmHJmqkUC48ldZurlI7o6Ga/Bsl2vQOpoI=;
  b=SsdYmy1RE15yA1zH67BLauOXbPZIMatrD30ODz92Oht0n7N2dUy8ySOR
   VoRH8J9i8GkKkASJoz8TtXG7YLe8R8OyV4Akym137wiMwMF1b8U/ztjQq
   HiqGDM0l27q9w7tEkHPPx97THtEFBADtNU++B4Qe55m7F4egWIulWmhxO
   rAtVUbW7sVE8Pauk/zOMmT0XclcSjkGa/oNBRR8cDLu+57pWP/QwQPi3D
   bX9AvId70QFhvAAt+EmzJsBXfLiX5EyGp2wrIXqvYRDQ64etm+cfYgzqm
   5l5ebAC59M/wIYaJXJDT6k66MDdhilIWZUZjbiRCJg7XFpESFP8z6jiwW
   Q==;
X-CSE-ConnectionGUID: cHUTI+XaSBmc6ZfVyQztmQ==
X-CSE-MsgGUID: LpKWiHuoQ1KCAwq++CPLFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="68815568"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="68815568"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:00:54 -0700
X-CSE-ConnectionGUID: gU3JjF9yQWSBXDjDMjiubw==
X-CSE-MsgGUID: jTjeyYEMQGmx4wLIB/B9qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130687123"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:00:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Apr 2025 11:00:43 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
    linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, 
    Russ Weight <russ.weight@linux.dev>, 
    Matthew Gerlach <matthew.gerlach@altera.com>, 
    Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org, 
    Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>, 
    Saeed Mahameed <saeedm@nvidia.com>, 
    Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] PCI: pciehp: Ignore Link Down/Up caused by Secondary
 Bus Reset
In-Reply-To: <d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de>
Message-ID: <e42a19a8-4934-69bb-0a79-6748062043ec@linux.intel.com>
References: <cover.1744298239.git.lukas@wunner.de> <d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-810837578-1744790443=:991"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-810837578-1744790443=:991
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Apr 2025, Lukas Wunner wrote:

> When a Secondary Bus Reset is issued at a hotplug port, it causes a Data
> Link Layer State Changed event as a side effect.  On hotplug ports using
> in-band presence detect, it additionally causes a Presence Detect Changed
> event.
>=20
> These spurious events should not result in teardown and re-enumeration of
> the device in the slot.  Hence commit 2e35afaefe64 ("PCI: pciehp: Add
> reset_slot() method") masked the Presence Detect Changed Enable bit in th=
e
> Slot Control register during a Secondary Bus Reset.  Commit 06a8d89af551
> ("PCI: pciehp: Disable link notification across slot reset") additionally
> masked the Data Link Layer State Changed Enable bit.
>=20
> However masking those bits only disables interrupt generation (PCIe r6.2
> sec 6.7.3.1).  The events are still visible in the Slot Status register
> and picked up by the IRQ handler if it runs during a Secondary Bus Reset.
> This can happen if the interrupt is shared or if an unmasked hotplug even=
t
> occurs, e.g. Attention Button Pressed or Power Fault Detected.
>=20
> The likelihood of this happening used to be small, so it wasn't much of a
> problem in practice.  That has changed with the recent introduction of
> bandwidth control in v6.13-rc1 with commit 665745f27487 ("PCI/bwctrl:
> Re-add BW notification portdrv as PCIe BW controller"):
>=20
> Bandwidth control shares the interrupt with PCIe hotplug.  A Secondary Bu=
s
> Reset causes a Link Bandwidth Notification, so the hotplug IRQ handler
> runs, picks up the masked events and tears down the device in the slot.
>=20
> As a result, Joel reports VFIO passthrough failure of a GPU, which Ilpo
> root-caused to the incorrect handling of masked hotplug events.
>=20
> Clearly, a more reliable way is needed to ignore spurious hotplug events.
>=20
> For Downstream Port Containment, a new ignore mechanism was introduced by
> commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").
> It has been working reliably for the past four years.
>=20
> Adapt it for Secondary Bus Resets.
>=20
> Introduce two helpers to annotate code sections which cause spurious link
> changes:  pci_hp_ignore_link_change() and pci_hp_unignore_link_change()
> Use those helpers in lieu of masking interrupts in the Slot Control
> register.
>=20
> Introduce a helper to check whether such a code section is executing
> concurrently and if so, await it:  pci_hp_spurious_link_change()
> Invoke the helper in the hotplug IRQ thread pciehp_ist().  Re-use the
> IRQ thread's existing code which ignores DPC-induced link changes unless
> the link is unexpectedly down after reset recovery or the device was
> replaced during the bus reset.
>=20
> That code block in pciehp_ist() was previously only executed if a Data
> Link Layer State Changed event has occurred.  Additionally execute it for
> Presence Detect Changed events.  That's necessary for compatibility with
> PCIe r1.0 hotplug ports because Data Link Layer State Changed didn't exis=
t
> before PCIe r1.1.  DPC was added with PCIe r3.1 and thus DPC-capable
> hotplug ports always support Data Link Layer State Changed events.
> But the same cannot be assumed for Secondary Bus Reset, which already
> existed in PCIe r1.0.
>=20
> Secondary Bus Reset is only one of many causes of spurious link changes.
> Others include runtime suspend to D3cold, firmware updates or FPGA
> reconfiguration.  The new pci_hp_{,un}ignore_link_change() helpers may be
> used by all kinds of drivers to annotate such code sections, hence their
> declarations are publicly visible in <linux/pci.h>.  A case in point is
> the Mellanox Ethernet driver which disables a firmware reset feature if
> the Ethernet card is attached to a hotplug port, see commit 3d7a3f2612d7
> ("net/mlx5: Nack sync reset request when HotPlug is enabled").  Going
> forward, PCIe hotplug will be able to cope gracefully with all such use
> cases once the code sections are properly annotated.
>=20
> The new helpers internally use two bits in struct pci_dev's priv_flags as
> well as a wait_queue.  This mirrors what was done for DPC by commit
> a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").  That ma=
y
> be insufficient if spurious link changes are caused by multiple sources
> simultaneously.  An example might be a Secondary Bus Reset issued by AER
> during FPGA reconfiguration.  If this turns out to happen in real life,
> support for it can easily be added by replacing the PCI_LINK_CHANGING fla=
g
> with an atomic_t counter incremented by pci_hp_ignore_link_change() and
> decremented by pci_hp_unignore_link_change().  Instead of awaiting a zero
> PCI_LINK_CHANGING flag, the pci_hp_spurious_link_change() helper would
> then simply await a zero counter.
>=20
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Reported-by: Joel Mathew Thomas <proxy0@tutamail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219765
> Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 69 ++++++++++++++++++++++++++++=
++++++
>  drivers/pci/hotplug/pciehp_hpc.c       | 35 ++++++-----------
>  drivers/pci/pci.h                      |  3 ++
>  include/linux/pci.h                    |  8 ++++
>  4 files changed, 92 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug=
/pci_hotplug_core.c
> index d30f131..d8c5856 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -492,6 +492,75 @@ void pci_hp_destroy(struct hotplug_slot *slot)
>  }
>  EXPORT_SYMBOL_GPL(pci_hp_destroy);
> =20
> +static DECLARE_WAIT_QUEUE_HEAD(pci_hp_link_change_wq);
> +
> +/**
> + * pci_hp_ignore_link_change - begin code section causing spurious link =
changes
> + * @pdev: PCI hotplug bridge
> + *
> + * Mark the beginning of a code section causing spurious link changes on=
 the
> + * Secondary Bus of @pdev, e.g. as a side effect of a Secondary Bus Rese=
t,
> + * D3cold transition, firmware update or FPGA reconfiguration.
> + *
> + * Hotplug drivers can thus check whether such a code section is executi=
ng
> + * concurrently, await it with pci_hp_spurious_link_change() and ignore =
the
> + * resulting link change events.
> + *
> + * Must be paired with pci_hp_unignore_link_change().  May be called bot=
h
> + * from the PCI core and from Endpoint drivers.  May be called for bridg=
es
> + * which are not hotplug-capable, in which case it has no effect because
> + * no hotplug driver is bound to the bridge.
> + */
> +void pci_hp_ignore_link_change(struct pci_dev *pdev)
> +{
> +=09set_bit(PCI_LINK_CHANGING, &pdev->priv_flags);
> +=09smp_mb__after_atomic(); /* pairs with implied barrier of wait_event()=
 */
> +}
> +
> +/**
> + * pci_hp_unignore_link_change - end code section causing spurious link =
changes
> + * @pdev: PCI hotplug bridge
> + *
> + * Mark the end of a code section causing spurious link changes on the
> + * Secondary Bus of @pdev.  Must be paired with pci_hp_ignore_link_chang=
e().
> + */
> +void pci_hp_unignore_link_change(struct pci_dev *pdev)
> +{
> +=09set_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
> +=09mb(); /* ensure pci_hp_spurious_link_change() sees either bit set */
> +=09clear_bit(PCI_LINK_CHANGING, &pdev->priv_flags);
> +=09wake_up_all(&pci_hp_link_change_wq);

This change should have added these:

#include <linux/bitops.h>
#include <linux/wait.h>

#include <asm/barrier.h>

--
 i.
--8323328-810837578-1744790443=:991--

