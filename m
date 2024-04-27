Return-Path: <linux-pci+bounces-6709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F98B42FE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 02:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2048C1C20C92
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 00:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478D64B;
	Sat, 27 Apr 2024 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2sDE8Np"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52742376;
	Sat, 27 Apr 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176187; cv=none; b=XfHVm3biDHh0WEUPLXmKstHrAIEICCOI6FbYL3BfITThindEdKslpuLSlChBjzKinXIIcPygCP5BH3FNhdc93fB7texbNv2NvuJ+goBL4xOZoOlIsiNgnjangYDz8FnOHOgfJhA3coF+AKEl5lcihQ5Zei21P6RZFlfxb6e4U6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176187; c=relaxed/simple;
	bh=eEy9hWrcjmaRZAADOiXkvcSV7CKAi438k7HWQoSN2y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACcA9oJXG9SsCjqkLdtcAYfP1DEYlinciXs+F//UdQ8SnqNaUnN44dnWJh0tHI94IKNuMgeCAXDUQzxbmML2PJ58XnYBlEhMV9zUZ4eZgXhgfClsLpRIByIot1f56lrS30YbrAM8RVw5nfISv7CvUrqJMe4+/wIxf0qPmA+AwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2sDE8Np; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714176186; x=1745712186;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eEy9hWrcjmaRZAADOiXkvcSV7CKAi438k7HWQoSN2y4=;
  b=I2sDE8Np8AkL3SR2+fncpTTmwoIabrubJwgoJ+494whneJe58QmRzm3V
   9i6f3gJG41OYVD8PS5RV+xRMYwTHUTLoTYfqub3MwMC0XXLQpi/nsz4iz
   fDv1+X4I1KqGtrhjFPbMyJCgJRAjLafr2yBCMBDWpA/cov44oethPCsEU
   JO5T+OaHC1i+CGNnWQoCZfoLJPfeC5Nc7QV0cvRmOvds8aC7dCfCrXk3s
   WgMjuT4/kvwUy1UrQ5MsIdKOctMk3dJAyYgj+j3TSxOX4X6sz5/L9qCjB
   QVOmRrhiAzYRgIjWmC8TEN8fjR/qexcQWCe+c1GxCTGSJKpSbYRj4QtyV
   A==;
X-CSE-ConnectionGUID: brr9kpbTT1+5I7/uU4pCOw==
X-CSE-MsgGUID: gDSScBprSdmoy1F4gUBXyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10461550"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="10461550"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 17:03:05 -0700
X-CSE-ConnectionGUID: B7O9s9ezT0+ZAPtXeeLvSQ==
X-CSE-MsgGUID: lBPjA/mLQruJFssuD9Lc5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="30382898"
Received: from ckshirot-mobl1.amr.corp.intel.com ([10.209.32.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 17:03:04 -0700
Message-ID: <f111371300624b6f94f0746dbae66bd49f405eea.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 17:03:03 -0700
In-Reply-To: <20240424110223.21799-2-jhp@endlessos.org>
References: <20240424110223.21799-2-jhp@endlessos.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jian-Hong,

On Wed, 2024-04-24 at 19:02 +0800, Jian-Hong Pan wrote:
> Currently, when enable link's L1.2 features with __pci_enable_link_state(=
),
> it configs the link directly without ensuring related L1.2 parameters, su=
ch
> as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have been
> programmed.
>=20
> This leads the link's L1.2 between PCIe Root Port and child device gets
> wrong configs when a caller tries to enabled it.
>=20
> Here is a failed example on ASUS B1400CEAE with enabled VMD:
>=20
> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe
> Controller (rev 01) (prog-if 00 [Normal decode])
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 Capabilities: [200 v1] L1 PM Substates
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_=
L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us PortTPowerO=
nTime=3D50us
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM=
_L1.1- ASPM_L1.2+ ASPM_L1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D45us LTR1.2_Threshold=
=3D101376ns
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D50us
>=20
> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 =
NVMe
> SSD (rev 01) (prog-if 02 [NVM Express])
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 Capabilities: [900 v1] L1 PM Substates
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_=
L1.1- ASPM_L1.2+ ASPM_L1.1-
> L1_PM_Substates+
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us PortTPowerO=
nTime=3D10us
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM=
_L1.1- ASPM_L1.2+ ASPM_L1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D=
0ns
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D10us
>=20
> According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the PCI=
e
> Root Port and the child NVMe, they should be programmed with the same
> LTR1.2_Threshold value. However, they have different values in this case.
>=20
> Invoke aspm_calc_l12_info() to program the L1.2 parameters properly befor=
e
> enable L1.2 bits of L1 PM Substates Control Register in
> __pci_enable_link_state().
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2:
> - Prepare the PCIe LTR parameters before enable L1 Substates
>=20
> v3:
> - Only enable supported features for the L1 Substates part
>=20
> v4:
> - Focus on fixing L1.2 parameters, instead of re-initializing whole L1SS
>=20
> v5:
> - Fix typo and commit message
> - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> =C2=A0 aspm_get_l1ss_cap()"
>=20
> =C2=A0drivers/pci/pcie/aspm.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c55ac11faa73..553327dee991 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
> =C2=A0static int __pci_enable_link_state(struct pci_dev *pdev, int state,=
 bool
> locked)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pcie_link_state *l=
ink =3D pcie_aspm_get_link(pdev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_dev *child =3D link=
->downstream, *parent =3D link->pdev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 parent_l1ss_cap, child_l1s=
s_cap;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!link)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> @@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(struct pci_dev
> *pdev, int state, bool locked)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM | ASP=
M_STATE_L1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK_STA=
TE_L1_2_PCIPM)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM | ASP=
M_STATE_L1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure L1.2 parameters: Com=
mon_Mode_Restore_Times, T_POWER_ON and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LTR_L1.2_THRESHOLD are prog=
rammed properly before enable bits for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * L1.2, per PCIe r6.0, sec 5.=
5.4.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & link->aspm_capable=
 & ASPM_STATE_L1_2_MASK) {

This is still mixing PCIE_LINK_STATE flags with ASPM_STATE flags. 'state' s=
hould
not even matter. The timings should always be calculated and programmed as =
long
as L1_2 is capable. That way the timings are ready even if L1_2 isn't being
enabled now (in case the user enables it later).

David

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_config_aspm_link(lin=
k, policy_to_aspm_state(link));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link->clkpm_default =3D (=
state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;


