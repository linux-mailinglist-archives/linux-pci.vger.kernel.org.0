Return-Path: <linux-pci+bounces-3207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7B84CE88
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAFE1C2183E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F980052;
	Wed,  7 Feb 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZA6WnA4E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFB8002F;
	Wed,  7 Feb 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321771; cv=none; b=el8glPsHY2IzyUtJW70sDvL7Rt9ir/5uZ4cToTjFVYMXz8vBZEuLUwn/PIfz5Ic98m3AhRrjrvlOEEQod0zNb2cfGlPFxPuwxkC3OhypabvprUqT0uwxeJk1DP22/tGefuaohaR07lH+O3/aSaWYAhtNPTyLaO4uRujFhTN9HLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321771; c=relaxed/simple;
	bh=M611GcMdGJykO0N8Dmv8PbgGyZn3lTmhtUBEPLS0brw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bqj4xV8jrp+6VsNGtM7fD39BnNNJPD8at5qbaPOSORmA/ksCvTyvxqL31ve2mm33dG7bX2OnoO69lVTR+JEKBj9FMGJXF3iENrwsSTzbU7h8Fk2oZ099JbMtK+2dJuEff/cnSH0RVPDcq+sX1OhPKGsU5aXjllA7IyAJhUzuP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZA6WnA4E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707321770; x=1738857770;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=M611GcMdGJykO0N8Dmv8PbgGyZn3lTmhtUBEPLS0brw=;
  b=ZA6WnA4EiriqqO7GmUErIylK0nx72R1/pqaqG9Fgxb0cjtUozwhEPZB3
   SsIYo/zJ6UH6m6s50l1jTNAjE/TTtI0ntdQ/psLwz4DGeAisVgtdvjqfN
   pGMoScENh0Ot+ICAzxXeTz0e3LqR+0R5KNZBjJNX0z1GDiTr9JsQMKoLL
   AGpAY7Y00JBEsFyOiJsWb5kZZ/wNmYHtvl9Fr3FR9LxzFsp4FNm6RDKuM
   H0+yyDlLZVBpQx5hPV0KMlBZTjz1nN5BBJQKhYtYe5GnuHxzQACKHRTbX
   lduyq9xrZMptLxeGL/TT57GYP8xDU+/8VbsVOXYSTrmRwP5PwkODn1n7P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12104204"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12104204"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="38811757"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:02:49 -0800
Received: from hsinjuiy-mobl.amr.corp.intel.com (unknown [10.209.57.193])
	by linux.intel.com (Postfix) with ESMTP id 12A70580D94;
	Wed,  7 Feb 2024 08:02:49 -0800 (PST)
Message-ID: <0e7944d410664153b506ea584d92cd6bb0a93f6a.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] PCI/ASPM: Fix L1SS parameters & only enable
 supported features when enable link state
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
Date: Wed, 07 Feb 2024 08:02:48 -0800
In-Reply-To: <20240207111854.576402-2-jhp@endlessos.org>
References: <20240207111854.576402-2-jhp@endlessos.org>
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

On Wed, 2024-02-07 at 19:18 +0800, Jian-Hong Pan wrote:
> The original __pci_enable_link_state() configs the links directly without=
:
> * Check the L1 substates features which are supported, or not
> * Calculate & program related parameters for L1.2, such as T_POWER_ON,
> =C2=A0 Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD
>=20
> This leads some supported L1 PM substates of the link between VMD remappe=
d
> PCIe Root Port and NVMe get wrong configs when a caller tries to enabled
> them.
>=20
> Here is a failed example on ASUS B1400CEAE with enabled VMD:
>=20
> Capabilities: [900 v1] L1 PM Substates
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
> This patch initializes the link's L1 PM substates to get the supported
> features and programs relating paramters, if some of them are going to be
> enabled in __pci_enable_link_state(). Then, enables the L1 PM substates i=
f
> the caller intends to enable them and they are supported.
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
> =C2=A0drivers/pci/pcie/aspm.c | 12 +++++++-----
> =C2=A01 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a39d2ee744cb..c866971cae70 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1389,14 +1389,16 @@ static int __pci_enable_link_state(struct pci_dev
> *pdev, int state, bool locked)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L0S;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK_STA=
TE_L1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* L1 PM substates require L1 =
*/
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK_STATE_L1=
_1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & ASPM_STATE_L1_2_MA=
SK)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0aspm_l1ss_init(link);

This mixes ASPM_STATE flags with PCIE_LINK_STATE register mapping. This may=
 work
but I don't know if it's intended to. Rather do,

    if (link->default & ASPM_STATE_L1_2_MASK)

after collecting all of the states to be enabled.

I understand that you are calling aspm_l1ss_init() to do the L1.2 calculati=
ons
but it does more than this that you don't need. Maybe it would be more
appropriate to call aspm_calc_l12_info() directly through an additional fun=
ction
that finds the parent and determines both ends of the link support L1SS.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* L1 PM substates require L1 =
and should be in supported list */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & link->aspm_support=
 & PCIE_LINK_STATE_L1_1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L1_1 | ASPM_STAT=
E_L1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK_STATE_L1=
_2)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & link->aspm_support=
 & PCIE_LINK_STATE_L1_2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L1_2 | ASPM_STAT=
E_L1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK_STATE_L1=
_1_PCIPM)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & link->aspm_support=
 & PCIE_LINK_STATE_L1_1_PCIPM)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM | ASP=
M_STATE_L1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK_STATE_L1=
_2_PCIPM)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & link->aspm_support=
 & PCIE_LINK_STATE_L1_2_PCIPM)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM | ASP=
M_STATE_L1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_config_aspm_link(lin=
k, policy_to_aspm_state(link));
> =C2=A0

I don't think these changes are necessary. pcie_config_aspm_link() already
checks link->aspm_capable which was initialized from link->aspm_support.

David

