Return-Path: <linux-pci+bounces-13599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F058098830A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 13:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC21282D3C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6E17ADFF;
	Fri, 27 Sep 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGmsG4Vo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E982488;
	Fri, 27 Sep 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727435822; cv=none; b=mgkiJkHdzR0bv1rw7XEVOAiQNsLgvyEnmh3YN1F7Hw/1747leInkkxtmvttig8Xd2RSDM/GdekCVouyjVEIZDXCozqW/hQEm8ZBkTXPlat9k2vDR76ZKfsYIpg+CGs8kaOaQdnMnsJnveYtidEwj5gRXAROvArAyVr1vg5hEo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727435822; c=relaxed/simple;
	bh=cnJM+E8jPuaOwm3l36DtHQZW0XW+rwgvrnTBcES9sgk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dHavDJmkiLtklEEbWEDG2JcLVVrG+N7vGU6qJG/2zoWUvoS2N/VcN0eTxwu5ylhsD98j9moNkJv4Nt22FO1JmWHXLxvzaEVutsxCVW4Ouig35f5p27liIWnd4gebkfEDQK7k+PeCOy4uYoqQVTZMTn8AqZ4Ny4VY8+gOcJ3+AGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGmsG4Vo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727435821; x=1758971821;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cnJM+E8jPuaOwm3l36DtHQZW0XW+rwgvrnTBcES9sgk=;
  b=KGmsG4VoAW058B2fcEn4WJxiPPs0oSy9+X5SgGs+dtpCrUkajF9C5LRa
   yJtwQH58hJyAAAArR/0fWOYxHGMjW1RuOaGkN6ipPMtZG4VaEdVecNr1i
   io7MV0usRkPAcQ93TbXqOEqxn8oNgYQtPV96hAzBTybhgh5Lrj5lAgKdR
   Z9X92rL7k1AdOFSJwOCCrzXIseL/R1dSnaC95jYi2eY6226bJGNQug83j
   LZNB5x6/0tDfYZeQoQOgLTavTryqHfGFeOHj1kDWTtSx25TAGUkuEeFQg
   BdECrrLmKKrxFyabyyxWFHyyQH5RFrCJhzKLiAL7ApW5evcuQ+koTgg8W
   g==;
X-CSE-ConnectionGUID: ZbnhjsiERkq3M8BthAt4rw==
X-CSE-MsgGUID: z/vKt3LESOC3/Z6heOcNiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="51991000"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="51991000"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 04:17:00 -0700
X-CSE-ConnectionGUID: FwMmTBUNRAyRuayWL9xkUA==
X-CSE-MsgGUID: ee6BMitiRRCtHHZ4Eu6DOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72583708"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 04:16:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 27 Sep 2024 14:16:52 +0300 (EEST)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
    David Box <david.e.box@linux.intel.com>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v10 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
In-Reply-To: <20240927103723.24622-2-jhp@endlessos.org>
Message-ID: <a6502c65-770b-4dee-3fab-2ec58c277404@linux.intel.com>
References: <20240927103231.24244-2-jhp@endlessos.org> <20240927103723.24622-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1628269038-1727435812=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1628269038-1727435812=:961
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 27 Sep 2024, Jian-Hong Pan wrote:

> PCI devices' parameters on the VMD bus have been programmed properly
> originally. But, cleared after pci_reset_bus() and have not been restored
> correctly. This leads the link's L1.2 between PCIe Root Port and child
> device gets wrong configs.
>=20
> Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> bridge and NVMe device should have the same LTR1.2_Threshold value.
> However, they are configured as different values in this case:
>=20
> 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processo=
r PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
>   ...
>   Capabilities: [200 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subst=
ates+
>       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
>     L1SubCtl2: T_PwrOn=3D0us
>=20
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue=
 SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
>   ...
>   Capabilities: [900 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Subst=
ates+
>       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
>     L1SubCtl2: T_PwrOn=3D50us
>=20
> Here is VMD mapped PCI device tree:
>=20
> -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
>  | ...
>  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
>               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
>=20
> When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> restores NVMe's state before and after reset.

> Because bus [e1] has only one
> device: 10000:e1:00.0 NVMe.

This is incomplete sentence. And I don't understand why the number of=20
devices is relevant. Perhaps just drop it?

> The PCIe bridge is missed.

Unclear what this refers to (I know what you mean but please write it=20
so that other reading this 10 years from now will also get what is
missed).

> However, when it
> restores the NVMe's state, it also restores the ASPM L1SS between the PCI=
e
> bridge and the NVMe by pci_restore_aspm_l1ss_state().=20

"it also restores ..." -> "ASPM code restores L1SS for both the parent=20
bridge and the NVMe in pci_restore_aspm_l1ss_state()."

> The NVMe's L1SS is
> restored correctly. But, the PCIe bridge's L1SS is restored with the wron=
g
> value 0x0 [1]. Because, the parent device (PCIe bridge)'s L1SS is not sav=
ed

Join these sentences without . and drop the comma.

I'd say "was not saved" because at that point it occurred clearly before=20
the restore.

> by pci_save_aspm_l1ss_state() before reset. That is why
> pci_restore_aspm_l1ss_state() gets the parent device (PCIe bridge)'s save=
d
> state capability data and restores L1SS with value 0.

This last sentence seems duplicated.
=20
> So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
> the parent's L1SS configuration, too. This is symmetric on
> pci_restore_aspm_l1ss_state().
>=20
> [1]: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS=
4eG9oGpEX1wmnMLkQ@mail.gmail.com/

Just put this into Link tag.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394

Closes: ?

Fixes tag is also missing.

Add:

Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v9:
> - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.
>=20
> v10:
> - Drop the v9 fix about drivers/pci/controller/vmd.c
> - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state(=
)
>   and pci_restore_aspm_l1ss_state()
>=20
>  drivers/pci/pcie/aspm.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index bd0a8a05647e..823aaf813978 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -81,24 +81,47 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> =20
>  void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  {
> -=09struct pci_cap_saved_state *save_state;
> -=09u16 l1ss =3D pdev->l1ss;
> +=09struct pci_cap_saved_state *pl_save_state, *cl_save_state;
> +=09struct pci_dev *parent;
>  =09u32 *cap;
> =20
>  =09/*
>  =09 * Save L1 substate configuration. The ASPM L0s/L1 configuration
>  =09 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
>  =09 */
> -=09if (!l1ss)
> +=09if (!pdev->l1ss)
>  =09=09return;
> =20
> -=09save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> -=09if (!save_state)
> +=09cl_save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> +=09if (!cl_save_state)
>  =09=09return;
> =20
> -=09cap =3D &save_state->cap.data[0];
> -=09pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
> -=09pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> +=09cap =3D &cl_save_state->cap.data[0];
> +=09pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> +=09pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> +
> +=09/*
> +=09 * If here is a parent device and it has not saved state, save parent=
's
> +=09 * L1 substate configuration, too. This is symmetric on
> +=09 * pci_restore_aspm_l1ss_state().
> +=09 */
> +=09if (!pdev->bus || !pdev->bus->self)
> +=09=09return;
> +
> +=09parent =3D pdev->bus->self;
> +=09if (!parent->l1ss)
> +=09=09return;
> +
> +=09pl_save_state =3D pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS)=
;
> +=09if (!pl_save_state)
> +=09=09return;
> +
> +=09if (parent->state_saved)
> +=09=09return;

This decision can be made before even reading the pl_saved_state.

> +
> +=09cap =3D &pl_save_state->cap.data[0];
> +=09pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++);
> +=09pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++);

This approach duplicates code and that seems unnecessary to me.

Could you instead leave the current function (nearly?) as is and use it as=
=20
a helper for a new pci_save_aspm_l1ss_state() which calls the helper first=
=20
for the pdev and then for its parent (if needed). Or do I miss something=20
why that is not possible?

--=20
 i.

--8323328-1628269038-1727435812=:961--

