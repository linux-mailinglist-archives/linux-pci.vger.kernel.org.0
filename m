Return-Path: <linux-pci+bounces-13634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3922989FC5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 12:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F8A1C217E9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC818C014;
	Mon, 30 Sep 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5feyn7w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404818BB9E;
	Mon, 30 Sep 2024 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693408; cv=none; b=dCDh32x3yj3vSDv4e5fFbNZVnW7Xu72aR19m3yWLd388AZBbuSkfBgCW377foWoNbzqsuWYHgxcFPkn7mjoZ0tSjEhPRlybN9zoErj9M1fMSGObqj++CtCq9x5AE0CXk8pnG0eOdj83xnl2d2FUOZ1Ptd7Nyg5S6xAIIaRhqtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693408; c=relaxed/simple;
	bh=JuK/F2G0f9reVtS1XFQCexpKDja04762L2xBEQufO/w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E1xBGr3GqmSDWvkR1pYj+SvUmK+neK6P9MT08Zezdy1UR0iJChhVjfqFP3bIQV86srSQK8V/zkeVZkkt7eVOxtdbMP2Wx+k25OyRNkWSt8aUr5pRWl2FA1jJ1xPNORu/YEgLQi7AXEKLixpYN7/cpZJqut3//nf4X/iEFTmp++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5feyn7w; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727693407; x=1759229407;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JuK/F2G0f9reVtS1XFQCexpKDja04762L2xBEQufO/w=;
  b=h5feyn7wd9QKB7mT6OTh4TS+O5I/jC62ETJcwA1irKeWpdNT4gTj4+iP
   m8qFLc6+30P3t1T2STA3EiEW3hAYdPD/KlPt1yM6UzyD6s6vCBEWD/co1
   PotFrNenFC/Y3heGs3+MM/t7Er/2L8pf4z20fQeI9r4HQPuYf/acOV2iq
   AYa/fCqLqOMJwehkel7bO3Ss6wz8vrv9rLEOIyFGHFUfuLqSQovqFJSAd
   EXDWJRVEEbp3xI3L5W8HV5OgCK4e6D8fUhksOHC+KjzJDC3yvUMomqVMH
   naVbuU9EZSe3EWSksAADS/sUYyXemsCDTfFi5oiIqsJBHGDRRT00Rwmng
   w==;
X-CSE-ConnectionGUID: 89CrAwmwT8qfwrmlH158Qw==
X-CSE-MsgGUID: 6YesXnfLRICORtv6b0DCrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26283030"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26283030"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:50:06 -0700
X-CSE-ConnectionGUID: VDux0oGzSsKF2yBuQDaxKA==
X-CSE-MsgGUID: yZI44t+VTAS51i+sg4YOXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="110743950"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:50:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Sep 2024 13:49:59 +0300 (EEST)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
    David Box <david.e.box@linux.intel.com>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v11 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
In-Reply-To: <20240930084953.13454-2-jhp@endlessos.org>
Message-ID: <828d2fc0-e594-ad3e-b653-2c0acc1223b3@linux.intel.com>
References: <20240930082530.12839-2-jhp@endlessos.org> <20240930084953.13454-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2081136472-1727693399=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2081136472-1727693399=:938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 30 Sep 2024, Jian-Hong Pan wrote:

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

> The bus [e1] has only one
> NVMe device, so the NVMe's parent PCIe bridge is missed to be saved.

This is still misleading because "only one NVMe device" is not the=20
reason why the parent's state is not saved.

> However, when it restores the NVMe's state, ASPM code restores L1SS for
> both the parent bridge and the NVMe in pci_restore_aspm_l1ss_state().
> Although the NVMe's L1SS is restored correctly, the parent bridge's L1SS =
is
> restored with a wrong value 0x0. Because, the parent bridge's L1SS was no=
t

Again, please join these sentences.

> saved by pci_save_aspm_l1ss_state() before reset.
>=20
> So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
> the parent's L1SS configuration, too. This is symmetric on
> pci_restore_aspm_l1ss_state().
>=20
> Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6Sd=
S4eG9oGpEX1wmnMLkQ@mail.gmail.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspe=
nd/resume")
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

This tag should appear before signed-off-by.

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
> v11:
> - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
>   which is same as the original pci_configure_aspm_l1ss
> - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
>   both child and parent devices
> - Smooth the commit message
>=20
>  drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index bd0a8a05647e..17cdf372f7e0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
>  =09=09=09ERR_PTR(rc));
>  }
> =20
> -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  {
>  =09struct pci_cap_saved_state *save_state;
>  =09u16 l1ss =3D pdev->l1ss;
> @@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  =09pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
>  }
> =20
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +{
> +=09struct pci_dev *parent;
> +
> +=09__pci_save_aspm_l1ss_state(pdev);
> +
> +=09/*
> +=09 * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's L1
> +=09 * substate configuration, if the parent has not saved state.
> +=09 */
> +=09if (!pdev->bus || !pdev->bus->self)
> +=09=09return;
> +
> +=09parent =3D pdev->bus->self;
> +=09if (!parent->state_saved)
> +=09=09__pci_save_aspm_l1ss_state(parent);
> +}

The code change looks good!

--=20
 i.

--8323328-2081136472-1727693399=:938--

