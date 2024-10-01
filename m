Return-Path: <linux-pci+bounces-13687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B0598C100
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B387287F9B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76161CC160;
	Tue,  1 Oct 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1yUDxJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F631CC154;
	Tue,  1 Oct 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794865; cv=none; b=KOp7PtaG9eysppYa8dgYXJjhN2pXL49vOPiqR2pk2dAad5fLGsWvxUaUbIIgKXZGegRpjykILhlLZlHq7Gr4ewxNeRI9tla/3Xl7C7x/6fhitOp8TfrlWMLBOp9CACSaqkDZB8cbTnYIKsUEDJx0I77Pe1Oum4JpbQeYcFGZYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794865; c=relaxed/simple;
	bh=1tLlMeiFBW2HxX8QD+VoQVyMTNRgr0xF9elLgst9neg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F4LK+VfVv7lbUzEUGR6HrbBxXliCcomHGIzewocO6OWvsrccf3BJLFwZDmwiim/Et2NoRm4mZRbYk03n9kU3WCKOBJpF2uVn/DCOO3UzUjTiTagqIwPgd0jrFq2skWYgFlJ3Qx3iuovrgDn7YKhXZfkIkOKZoVX7FeB2vPXWQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1yUDxJ+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727794864; x=1759330864;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1tLlMeiFBW2HxX8QD+VoQVyMTNRgr0xF9elLgst9neg=;
  b=n1yUDxJ+HMdnl4YlmVjVUpRaNLprjfFfhyXwFYd+pUQ4qng2EKcWvfXY
   LG02oSjHHhLqqgZlnEssUZFtce/06jOT0mK8wGhrDrMeZPXgwGXFdClS3
   TQNjEWqwp6i5BJqci6cswIbc5iBrMI5BHV6tPzctN4676hWIPT89gU07h
   lunwlymtgfdgrErZubOCd34Eqs8yoLftv94QzjaBfmcEjHB7f+Oll0307
   kHqYDy3nd6+qATu6qjfslKWvx+2Y3ZR6SDx0zn5JNIgz6meNHsmQJoIN4
   Rbn1jVyJobuaaV9FVXNFJxtZheFkyclH7GRHQznOas8yR1fKel0gidFPt
   w==;
X-CSE-ConnectionGUID: uQPUx1MYSISvoKWtHSMZ4w==
X-CSE-MsgGUID: pweeRZtERamcl2Kd+xDzmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26812399"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26812399"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:01:03 -0700
X-CSE-ConnectionGUID: 7iO5mCcCS/SMcKSdBU2k/Q==
X-CSE-MsgGUID: j+Q2cE9CQKGwWSwjfauz8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="111164895"
Received: from fpallare-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:01:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 1 Oct 2024 18:00:56 +0300 (EEST)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
    David Box <david.e.box@linux.intel.com>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
In-Reply-To: <20241001083438.10070-8-jhp@endlessos.org>
Message-ID: <d2ec2de3-171f-e4b6-213d-f900b84b47cd@linux.intel.com>
References: <20241001083438.10070-2-jhp@endlessos.org> <20241001083438.10070-8-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1362662974-1727794856=:945"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1362662974-1727794856=:945
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Oct 2024, Jian-Hong Pan wrote:

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
> restores NVMe's state before and after reset. Then, when it restores the
> NVMe's state, ASPM code restores L1SS for both the parent bridge and the
> NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> correctly. But, the parent bridge's L1SS is restored with a wrong value 0=
x0
> because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_state=
()
> before reset.
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
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


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
> v12:
> - Update the commit message
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
> +
>  void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
>  {
>  =09struct pci_cap_saved_state *pl_save_state, *cl_save_state;
>=20
--8323328-1362662974-1727794856=:945--

