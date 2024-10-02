Return-Path: <linux-pci+bounces-13703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E698C9BE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 02:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4708F1C220FE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 00:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BED2F34;
	Wed,  2 Oct 2024 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfeocBO3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5782629C;
	Wed,  2 Oct 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827342; cv=none; b=pddbwmg545sj9ko1W4yp/+2YEo5HmQFuOwUHaqKats2OnzpkznPjnI1RwebipuQp9P4hWGcbLw7Mbkkfs++6+v2GimGuJIb0xwAXjBjxFWlk4JpdIFmq3fJigHWe/mhgtrNjP+AtDyupbb7fvX1XS8Q4JfcPPo6pE7ssotGfXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827342; c=relaxed/simple;
	bh=iv4ChqlTseBJ8ORFUqV6b7ZrNnjE6BxkpYbXYRHPPic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MyeUWKKb59IOHlaj4MqTZ/LEpPyisybW2Gzgl0vJfusbaimlpzLqEYhyMZuJJw2DRihTu0LwpkgRCO+vik1ZYXT5nPE8+XEVbRUyieIoKRqYlg28qNUsdIEqMIPpxHTgZMEE2BU+gPSXkqAbMzD2A51DbxdjzFJfRRHWDFyQz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfeocBO3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727827341; x=1759363341;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iv4ChqlTseBJ8ORFUqV6b7ZrNnjE6BxkpYbXYRHPPic=;
  b=hfeocBO3qRkh5f2GnNnKrS+yRaVlqzyUWaklRCFYlsw64mHM+S+SpRTo
   jLD5YF74J/bV1UD0LO3vaH5CHt4DTFmORppev8Vsn8Woaedt30K2zzbDW
   ucN2pHZ7cPoRIWb+XLAGY2G55esJqLC/yIGJIJ45/0SFDH1U1iYq3qIKI
   sU/Frt1W/qlaVBzICDOhNruXpsnT+/IFW27dw0r0RY7AWga6qYpSAMweA
   y2k80plTM3APlH9NfzE2YV6QwKbA7IC8r6BEh8/FgsUA7laiAMw+2Dqei
   Y4kikRkK8GMqr3vLf3DO3v47lNmN7eP6S5OP1ZEu6mARVcFF7digv13av
   w==;
X-CSE-ConnectionGUID: hKc+gsDfTY69gVaUJ9K6Pg==
X-CSE-MsgGUID: 1z/z+9l/TNas0F3ohdR36w==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="52393331"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="52393331"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:02:20 -0700
X-CSE-ConnectionGUID: vaBkCI5jRMuIjcYmzIcmbA==
X-CSE-MsgGUID: V20rOYA+TL+wwGisCtiSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="74643152"
Received: from iherna2-mobl4.amr.corp.intel.com ([10.125.109.6])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:02:19 -0700
Message-ID: <f6745fbafbcb25a560bf7e342523570a4158136a.camel@linux.intel.com>
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
Date: Tue, 01 Oct 2024 17:02:09 -0700
In-Reply-To: <20241001083438.10070-8-jhp@endlessos.org>
References: <20241001083438.10070-2-jhp@endlessos.org>
	 <20241001083438.10070-8-jhp@endlessos.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jian-Hong,

On Tue, 2024-10-01 at 16:34 +0800, Jian-Hong Pan wrote:
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
> Link:
> https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9o=
GpEX1wmnMLkQ@mail.gmail.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume")
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v9:
> - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.
>=20
> v10:
> - Drop the v9 fix about drivers/pci/controller/vmd.c
> - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state(=
)
> =C2=A0 and pci_restore_aspm_l1ss_state()
>=20
> v11:
> - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
> =C2=A0 which is same as the original pci_configure_aspm_l1ss
> - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
> =C2=A0 both child and parent devices
> - Smooth the commit message
>=20
> v12:
> - Update the commit message
>=20
> =C2=A0drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
> =C2=A01 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index bd0a8a05647e..17cdf372f7e0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> =C2=A0			ERR_PTR(rc));
> =C2=A0}
> =C2=A0
> -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> =C2=A0{
> =C2=A0	struct pci_cap_saved_state *save_state;
> =C2=A0	u16 l1ss =3D pdev->l1ss;
> @@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> =C2=A0	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> =C2=A0}
> =C2=A0
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent;
> +
> +	__pci_save_aspm_l1ss_state(pdev);
> +
> +	/*
> +	 * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's L1
> +	 * substate configuration, if the parent has not saved state.
> +	 */
> +	if (!pdev->bus || !pdev->bus->self)
> +		return;
> +
> +	parent =3D pdev->bus->self;
> +	if (!parent->state_saved)
> +		__pci_save_aspm_l1ss_state(parent);
> +}
> +
> =C2=A0void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
> =C2=A0{
> =C2=A0	struct pci_cap_saved_state *pl_save_state, *cl_save_state;

This took a while to debug and find a solution. Thanks for continuing to wo=
rk on
this.

Reviewed-by: David E. Box <david.e.box@linux.intel.com

