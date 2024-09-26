Return-Path: <linux-pci+bounces-13533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B0986B17
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 04:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABADB1C215E2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F11714B2;
	Thu, 26 Sep 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBwW+7dc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27914C91;
	Thu, 26 Sep 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319119; cv=none; b=ImZenoyJkQRDdRkovDTJ+kVbAEU1WVGGqkm9v+26tp6mMUCVOzHrUP1eQyHnUChUyDL3OgFHpDoAnFf6fupoM1o1KCbon0EF+Lp+aW/dO0YX60xz1/wAGfClI/njlTroduJvWS+XobBO85yHmIyxy8njZ3Tc1MP9WvSDkDtKvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319119; c=relaxed/simple;
	bh=6x5k5kh2NYIZT+bfekCIrgVpCErQu44D3YEWhqWxLdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPL7CCrPfRXSq24PPR91gWhaHrjmAYk2usYekcblBctQ5oZjeD/X3N5HHhqPsBWg40243U5MDEK3N34oJw288jQijuUxlxfK3oSZNxr/CmzfTnF6Zan0JWVfKnhN9Pq3GgZ+bDhx79ePBTj5L516ksIzQ8qsIITY+KaF5kUvn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBwW+7dc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727319115; x=1758855115;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6x5k5kh2NYIZT+bfekCIrgVpCErQu44D3YEWhqWxLdE=;
  b=KBwW+7dcdK+77cXy6XGqIG5Xj1Wfs6H1EmnnYenufG6leJiuXGLAHXzF
   CfUROn1OYnTiD1c/5+eQr3vRvrS7lt5MYwW18yxGVNMEdHExfcGFFm3BT
   IVA0JigC0EpXctREsERyCvK0GNVDBQqHMmPlg8QVw8MOtuEjfD+Num/qb
   OmSr42Kjuq3qSRL3IAcDhT3oDwUMQzJUUhaA4OZW1xXD5owZKEmH4FTa6
   LKkkiFoYhjq/H/+j/tGOeZ+Q/R7zEhh7SPXpMckKwMdbRIkrTIgp1NQTI
   Bb3UPR0470CvAC/wyXgR6k1UMeiatASmU/uPVN+JCyORNkBR16ncxN7aQ
   w==;
X-CSE-ConnectionGUID: r+ZdH6BgQ8aCm2BnPGpdTA==
X-CSE-MsgGUID: LkZggPwHToyRmtei8CKFig==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37068099"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="37068099"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:51:55 -0700
X-CSE-ConnectionGUID: VzK7qaLpROiZDwlnYwskhg==
X-CSE-MsgGUID: sKenbcVNTymBL1ucCCdHww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="72083000"
Received: from cmdeoliv-mobl4.amr.corp.intel.com ([10.125.111.121])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:51:54 -0700
Message-ID: <8050f9d4cb851fc301cc35b4fb5a839ff71fdcae.camel@linux.intel.com>
Subject: Re: [PATCH v9 3/3] PCI: vmd: Save/restore PCIe bridge states
 before/after pci_reset_bus()
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
Date: Wed, 25 Sep 2024 19:51:54 -0700
In-Reply-To: <20240924072858.15929-3-jhp@endlessos.org>
References: <20240924070551.14976-2-jhp@endlessos.org>
	 <20240924072858.15929-3-jhp@endlessos.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jian-Hong,

On Tue, 2024-09-24 at 15:29 +0800, Jian-Hong Pan wrote:
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
r
> PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> =C2=A0 ...
> =C2=A0 Capabilities: [200 v1] L1 PM Substates
> =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1=
.1+ L1_PM_Substates+
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us PortTPowe=
rOnTime=3D50us
> =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L=
1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D0us
>=20
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue
> SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> =C2=A0 ...
> =C2=A0 Capabilities: [900 v1] L1 PM Substates
> =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1=
.1- L1_PM_Substates+
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us PortTPowe=
rOnTime=3D10us
> =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L=
1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D1013=
76ns
> =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D50us
>=20
> Here is VMD mapped PCI device tree:
>=20
> -+-[0000:00]-+-00.0=C2=A0 Intel Corporation Device 9a04
> =C2=A0| ...
> =C2=A0\-[10000:e0]-+-06.0-[e1]----00.0=C2=A0 Sandisk Corp WD Blue SN550 N=
VMe SSD
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \-17.0=C2=A0 Intel Corporation Tiger Lake-LP SATA Controller
>=20
> When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> restores NVMe's state before and after reset. Because bus [e1] has only o=
ne
> device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, when it
> restores the NVMe's state, it also restores the ASPM L1SS between the PCI=
e
> bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's L1SS is
> restored correctly. But, the PCIe bridge's L1SS is restored with the wron=
g
> value 0x0. Becuase, the PCIe bridge's state is not saved before reset.
> That is why pci_restore_aspm_l1ss_state() gets the parent device (PCIe
> bridge)'s saved state capability data and restores L1SS with value 0.
>=20
> So, save the PCIe bridge's state before pci_reset_bus(). Then, restore th=
e
> state after pci_reset_bus(). The restoring state also consumes the saving
> state.
>=20
> Link: https://www.spinics.net/lists/linux-pci/msg159267.html
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v9:
> - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.
>=20
> =C2=A0drivers/pci/controller/vmd.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 11870d1fc818..2820005165b4 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -938,9 +938,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features)
> =C2=A0		if (!list_empty(&child->devices)) {
> =C2=A0			dev =3D list_first_entry(&child->devices,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev, bus_list)=
;

Newline here

> +			/* To avoid pci_reset_bus restore wrong ASPM L1SS
> +			 * configuration due to missed saving parent device's
> +			 * states, save & restore the parent device's states
> +			 * as well.
> +			 */

No text on first line of comment.

    /*
     * To avoid pci_reset_bus restore wrong ASPM L1SS
     * ...
     */

> +			pci_save_state(dev->bus->self);
> =C2=A0			ret =3D pci_reset_bus(dev);
> =C2=A0			if (ret)
> =C2=A0				pci_warn(dev, "can't reset device: %d\n",
> ret);
> +			pci_restore_state(dev->bus->self);

I think Ilpo's point was that pci_save_aspm_l1ss_state() and
pci_restore_aspm_l1ss_state() should be more symmetric. If
pci_save_aspm_l1ss_state() is changed to also handle the state for the devi=
ce
and its parent in the same call, then no change is needed here. But that wo=
uld
only handle L1SS settings and not anything else that might need to be resto=
red
after the bus reset. So I'm okay with it either way.

David

> =C2=A0
> =C2=A0			break;
> =C2=A0		}


