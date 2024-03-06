Return-Path: <linux-pci+bounces-4542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DB872C47
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 02:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C06AB20F65
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1E63D9;
	Wed,  6 Mar 2024 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hr6S1wl1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD06FB8;
	Wed,  6 Mar 2024 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689061; cv=none; b=LW+V1zPFkk8EdBkyS8CsIwUaf+8xnZrNeXyaNvD4IuWmPIerACEilnd4JnAiiTmuR74/7f8x8YDEN60g6xzBxOZBNyEFsJuGtb88g0UjUCpbbrp2FJJRG+In73bBEvHIMYptXK0OxRKWlmvavhftpxUXh/Sz0VZfCFpJm8c8Skg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689061; c=relaxed/simple;
	bh=lwaJiedob5FjeCFBQo1p0B88jPm61ksE34kgp3U7OKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/Dd2sfrRTnwhjlutm4HvrjL/TbfcqcmJWpbkDZRD+3WHiDg9JqJ2ooAdpnZxo4xM7aaFvdAiH3i8wcf59d3fPs59xM/JuZzqGqDTh5KW+WHqvv4F1IZOPbAMBat0HEBvvrxuqEzAHbfMc0eItlsl8IAHu2Klbkzmz3l59nk2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hr6S1wl1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709689059; x=1741225059;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lwaJiedob5FjeCFBQo1p0B88jPm61ksE34kgp3U7OKs=;
  b=Hr6S1wl12rQO6mqX41+3QAWq9qMyIvkz4eQvSOi9vuW+Rw+ak/gEB1rF
   aqCdhsYfI/wVgLGXYjvVQu3TXIdV2X9dys0RpwjcprcS+pO6o4rY+dOp4
   5WSwgj29NouX+Ok2gUEoCMt0ySIpVzexhhvoi617CoftuGeG4CIYF4n5W
   LfLkd1Y+HXAzTtcb3R70Bz0JvXOB0abRnyDFE0OgRyvbHKGYGl+0HGgxn
   m2CXrrGHGCL3ostlH269ib8iWQ2I+jXrWkRRcahQSVXDAFU5yLHriPHHH
   Q0vzXtdM9rs+ZHTzUNdUEJClPStG/57PlODzv1N84pimRNzYFsJL/nKVY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8099917"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="8099917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:37:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9552132"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:37:39 -0800
Received: from kgoverx-mobl1.amr.corp.intel.com (unknown [10.209.23.213])
	by linux.intel.com (Postfix) with ESMTP id 416A5580DA0;
	Tue,  5 Mar 2024 17:37:38 -0800 (PST)
Message-ID: <2fe4d50f4e5690ffaf4134b1c21dc40cacfafe5b.camel@linux.intel.com>
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, macro@orcam.me.uk, ajayagarwal@google.com, 
 ilpo.jarvinen@linux.intel.com, hkallweit1@gmail.com,
 johan+linaro@kernel.org,  xueshuai@linux.alibaba.com,
 linux-pci@vger.kernel.org,  linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com,  kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
Date: Tue, 05 Mar 2024 17:37:38 -0800
In-Reply-To: <20240305220342.GA552530@bhelgaas>
References: <20240305220342.GA552530@bhelgaas>
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

On Tue, 2024-03-05 at 16:03 -0600, Bjorn Helgaas wrote:
> [+to Sathy, David in case you want to update your Reviewed-by]
>=20
> On Thu, Feb 22, 2024 at 11:14:36PM +0530, Vidya Sagar wrote:
> > Many PCIe device drivers save the configuration state of their respecti=
ve
> > devices during probe and restore the same when their 'slot_reset' hook
> > is called through PCIe Error Recovery Handler.
> >=20
> > If the system has a change in ASPM policy after the driver's probe is
> > called and before error event occurred, 'slot_reset' hook restores the
> > PCIe configuration state to what it was at the time of probe but not to
> > what it was just before the occurrence of the error event.
> > This effectively leads to a mismatch in the ASPM configuration between
> > the device and its upstream parent device.
> >=20
> > Update the saved configuration state of the device with the latest info
> > whenever there is a change w.r.t ASPM policy.
> >=20
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>=20
> > -void pci_save_aspm_state(struct pci_dev *pdev);
> > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
>=20
> I rebased this again on top of my pci/aspm updates to remove the need
> for the rename above.
>=20
> > +static void pci_save_aspm_state(struct pci_dev *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_cap_saved_state *=
save_state;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 *cap;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pci_is_pcie(dev))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0save_state =3D pci_find_save=
d_cap(dev, PCI_CAP_ID_EXP);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!save_state)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cap =3D (u16 *)&save_state->=
cap.data[0];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_capability_read_word(de=
v, PCI_EXP_LNKCTL, &cap[1]);
>=20
> And I changed this part so it only updates the PCI_EXP_LNKCTL_ASPMC
> bits, not the entire LNKCTL.
>=20
> Updating the entire saved register probably wouldn't *break* anything,
> but it could randomly hide other LNKCTL changes depending on whether
> or not ASPM configuration was changed in the interim.=C2=A0 For example:
>=20
> =C2=A0 - driver .probe() saves LNKCTL
> =C2=A0 - LNKCTL changes some non-ASPMC thing via setpci or other mechanis=
m
> =C2=A0 - save_state updated via pcie_config_aspm_link()
>=20
> A restore in .slot_reset() would restore different LNKCTL values for
> the non-ASPMC change depending on whether pcie_config_aspm_link() was
> used.
>=20
> I applied it on pci/aspm for v6.9.=C2=A0 Please take a look and make sure
> it still does what you need:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=3Da=
spm&id=3Da6315434436d587f70e489e6365c5b7e20176a71
>=20
> Sathy and David, I didn't add your Reviewed-by because I didn't want
> to presume that you were OK with my changes.=C2=A0 But I'd be more than
> happy to add them if you take a look.
>=20
> Bjorn
>=20
> > +}
> > +
> > =C2=A0void pci_aspm_get_l1ss(struct pci_dev *pdev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Read L1 PM substate =
capabilities */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pdev->l1ss =3D pci_find=
_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
> > =C2=A0}
> > =C2=A0
> > -void pci_save_aspm_state(struct pci_dev *pdev)
> > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_cap_saved_st=
ate *save_state;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 l1ss =3D pdev->l1ss=
;
> > @@ -309,10 +325,12 @@ static void pcie_set_clkpm_nocheck(struct
> > pcie_link_state *link, int enable)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_bus *linkbus=
 =3D link->pdev->subordinate;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 val =3D enable ? PC=
I_EXP_LNKCTL_CLKREQ_EN : 0;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry(child, &=
linkbus->devices, bus_list)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry(child, &=
linkbus->devices, bus_list) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_capability_clear_and_set_word(child, PCI_EX=
P_LNKCTL,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 PCI_EXP_LNKCTL_CLKREQ_EN,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pci_save_aspm_state(child);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link->clkpm_enabled =3D=
 !!enable;
> > =C2=A0}
> > =C2=A0
> > @@ -931,6 +949,12 @@ static void pcie_config_aspm_link(struct
> > pcie_link_state *link, u32 state)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_config_aspm_dev(parent, upstream);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_enabled =3D =
state;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Update latest ASPM config=
uration in saved context */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_save_aspm_state(link->do=
wnstream);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_save_aspm_l1ss_state(lin=
k->downstream);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_save_aspm_state(parent);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_save_aspm_l1ss_state(par=
ent);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void pcie_config_aspm_path(struct pcie_link_state *link)
> > --=20
> > 2.25.1
> >=20

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

