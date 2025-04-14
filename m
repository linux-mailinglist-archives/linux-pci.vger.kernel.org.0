Return-Path: <linux-pci+bounces-25836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88BA88433
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A363BB3F7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F82DF3E8;
	Mon, 14 Apr 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHiW4w+f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6427F749;
	Mon, 14 Apr 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637554; cv=none; b=IOym9eTS8DiaoX4GfUvb1/Qq4QkRmZ0HYa8mlDmoOQZ80QoY9gaFkBxXRCP6m8kuZjAzZBSDqYQxwYFU/xenBE0dRUK35Ne9HPegH8J52DN9QblW+zImk1JQqsnw/kJxhozzlvoBaZVBRpKjRooB9GFCOaBsR9i4YtpIpDWUTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637554; c=relaxed/simple;
	bh=5rpwZL3saIM37cQKShOpFfzgL6jV+2otoyRflp0Z4uo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Febp7KAqWr+wYpyIZq6kJ1Pnscx+GQDK4LhylDpdzh5cCGoxR3YBm5vPg962KRa79UCjNQlbApl3w182qo34T5ZQGi4l6D4SmQyxseWFWjVdsBhcslvhYUdxV6zVzkwoFs1sWEsJQQfQfYF7u4j4X5YXLHeTzIfw4BfpZYDHDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHiW4w+f; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744637553; x=1776173553;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5rpwZL3saIM37cQKShOpFfzgL6jV+2otoyRflp0Z4uo=;
  b=VHiW4w+fB83bB9/3nPVXiLSCRO49Z9ScuYGEV4pl2KY3y/EtTplXyYxd
   wHe/xie2+TX52iBMOcmdTIEFDTFlj0JG385KUWgovR8Ov4Kjvg7L51Dkb
   GO6RuA/290kEaDmagBSTjU8FV+QoCFaKd5dfR8xTbcj5Q3Q67yFR03zrg
   ATYyH2fxHJzmzvLbYQWxG/rkkrrojFAU7pkVfFSoOc3bcq1hEUti9NfW2
   ROnuOP2/mp+qb7jFJHFiKD0F+I6unFr4CfVoRdDPjW+lgqpERfKQq976p
   hcrWjiLuLJ42ay0263qcVvemzfQnT+UoXLegIJaDV3gGpn7daUua2wV8f
   w==;
X-CSE-ConnectionGUID: 4/6filuwSqS4Zbl2Zvhr8w==
X-CSE-MsgGUID: CBiAdUC5Tl2UFBYcA7vocQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="57473273"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57473273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:32:32 -0700
X-CSE-ConnectionGUID: tBkVkIf9RpOxQ7fduC1LtQ==
X-CSE-MsgGUID: Kejime/sRsqMObIkgRmaOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134794580"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:32:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Apr 2025 16:32:23 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
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
Message-ID: <1f31f485-a273-5437-ff85-28b6f16f496b@linux.intel.com>
References: <cover.1744298239.git.lukas@wunner.de> <d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-245958957-1744637543=:10563"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-245958957-1744637543=:10563
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
> +}
> +
> +/**
> + * pci_hp_spurious_link_change - check for spurious link changes
> + * @pdev: PCI hotplug bridge
> + *
> + * Check whether a code section is executing concurrently which is causi=
ng
> + * spurious link changes on the Secondary Bus of @pdev.  Await the end o=
f the
> + * code section if so.
> + *
> + * Return %true if such a code section has been executing concurrently,

Return:

And I think it's assumed to be the last, not in the middle of the=20
function's description.

> + * otherwise %false.  Also return %true if such a code section has not b=
een
> + * executing concurrently, but at least once since the last invocation o=
f this
> + * function.
> + *
> + * May be called by hotplug drivers to check whether a link change is sp=
urious
> + * and can be ignored.
> + *
> + * Because a genuine link change may have occurred in-between a spurious=
 link
> + * change and the invocation of this function, hotplug drivers should pe=
rform
> + * sanity checks such as retrieving the current link state and bringing =
down
> + * the slot if the link is down.
> + */
> +bool pci_hp_spurious_link_change(struct pci_dev *pdev)
> +{
> +=09wait_event(pci_hp_link_change_wq,
> +=09=09   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
> +
> +=09return test_and_clear_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
> +}
> +
>  static int __init pci_hotplug_init(void)
>  {
>  =09int result;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index 388fbed..c98d310 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -592,21 +592,21 @@ bool pciehp_device_replaced(struct controller *ctrl=
)
>  =09return false;
>  }
> =20
> -static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> -=09=09=09=09=09  struct pci_dev *pdev, int irq,
> -=09=09=09=09=09  u16 ignored_events)
> +static void pciehp_ignore_link_change(struct controller *ctrl,
> +=09=09=09=09      struct pci_dev *pdev, int irq,
> +=09=09=09=09      u16 ignored_events)
>  {
>  =09/*
>  =09 * Ignore link changes which occurred while waiting for DPC recovery.
>  =09 * Could be several if DPC triggered multiple times consecutively.
> +=09 * Also ignore link changes caused by Secondary Bus Reset etc.

Comma before etc.

>  =09 */
>  =09synchronize_hardirq(irq);
>  =09atomic_and(~ignored_events, &ctrl->pending_events);
>  =09if (pciehp_poll_mode)
>  =09=09pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>  =09=09=09=09=09   ignored_events);
> -=09ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n"=
,
> -=09=09  slot_name(ctrl));
> +=09ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored\n", slot_name(ctrl));
> =20
>  =09/*
>  =09 * If the link is unexpectedly down after successful recovery,
> @@ -762,9 +762,11 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> =20
>  =09/*
>  =09 * Ignore Link Down/Up events caused by Downstream Port Containment
> -=09 * if recovery from the error succeeded.
> +=09 * if recovery succeeded, or caused by Secondary Bus Reset,
> +=09 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
>  =09 */
> -=09if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
> +=09if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
> +=09    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
>  =09    ctrl->state =3D=3D ON_STATE) {
>  =09=09u16 ignored_events =3D PCI_EXP_SLTSTA_DLLSC;
> =20
> @@ -772,7 +774,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  =09=09=09ignored_events |=3D events & PCI_EXP_SLTSTA_PDC;
> =20
>  =09=09events &=3D ~ignored_events;
> -=09=09pciehp_ignore_dpc_link_change(ctrl, pdev, irq, ignored_events);
> +=09=09pciehp_ignore_link_change(ctrl, pdev, irq, ignored_events);
>  =09}
> =20
>  =09/*
> @@ -937,7 +939,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_sl=
ot, bool probe)
>  {
>  =09struct controller *ctrl =3D to_ctrl(hotplug_slot);
>  =09struct pci_dev *pdev =3D ctrl_dev(ctrl);
> -=09u16 stat_mask =3D 0, ctrl_mask =3D 0;
>  =09int rc;
> =20
>  =09if (probe)
> @@ -945,23 +946,11 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_=
slot, bool probe)
> =20
>  =09down_write_nested(&ctrl->reset_lock, ctrl->depth);
> =20
> -=09if (!ATTN_BUTTN(ctrl)) {
> -=09=09ctrl_mask |=3D PCI_EXP_SLTCTL_PDCE;
> -=09=09stat_mask |=3D PCI_EXP_SLTSTA_PDC;
> -=09}
> -=09ctrl_mask |=3D PCI_EXP_SLTCTL_DLLSCE;
> -=09stat_mask |=3D PCI_EXP_SLTSTA_DLLSC;
> -
> -=09pcie_write_cmd(ctrl, 0, ctrl_mask);
> -=09ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -=09=09 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
> +=09pci_hp_ignore_link_change(pdev);
> =20
>  =09rc =3D pci_bridge_secondary_bus_reset(ctrl->pcie->port);
> =20
> -=09pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
> -=09pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
> -=09ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -=09=09 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
> +=09pci_hp_unignore_link_change(pdev);
> =20
>  =09up_write(&ctrl->reset_lock);
>  =09return rc;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99c..7db798b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -227,6 +227,7 @@ static inline bool pcie_downstream_port(const struct =
pci_dev *dev)
> =20
>  /* Functions for PCI Hotplug drivers to use */
>  int pci_hp_add_bridge(struct pci_dev *dev);
> +bool pci_hp_spurious_link_change(struct pci_dev *pdev);
> =20
>  #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
>  void pci_create_legacy_files(struct pci_bus *bus);
> @@ -557,6 +558,8 @@ static inline int pci_dev_set_disconnected(struct pci=
_dev *dev, void *unused)
>  #define PCI_DPC_RECOVERED 1
>  #define PCI_DPC_RECOVERING 2
>  #define PCI_DEV_REMOVED 3
> +#define PCI_LINK_CHANGED 4
> +#define PCI_LINK_CHANGING 5
> =20
>  static inline void pci_dev_assign_added(struct pci_dev *dev)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e8e3fd..833b54f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1848,6 +1848,14 @@ static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return fals=
e; }
>  #endif
> =20
> +#ifdef CONFIG_HOTPLUG_PCI
> +void pci_hp_ignore_link_change(struct pci_dev *pdev);
> +void pci_hp_unignore_link_change(struct pci_dev *pdev);
> +#else
> +static inline void pci_hp_ignore_link_change(struct pci_dev *pdev) { }
> +static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
> +#endif
> +
>  #ifdef CONFIG_PCIEAER
>  bool pci_aer_available(void);
>  #else
>=20

Just nits above.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-245958957-1744637543=:10563--

