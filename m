Return-Path: <linux-pci+bounces-3122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ACA84A707
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 22:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B851C23089
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10D5FEF1;
	Mon,  5 Feb 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJMZp2uH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28E5FDAC;
	Mon,  5 Feb 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161840; cv=none; b=u/6eQU+6UAtblF1qWRtTePVhO/EldDAI1vmN/sm0NYA5AJ9F/sDtEihyHKGYDBha05wt4eOPcShqXo8e2cpvNwvjLJyrHzXD4U76VyDTEbHuBVNSowVz5z7oR9EauyWNyXs8ikRXohr45rqXFSgsIStKzfDGyMna5mZtg8mr66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161840; c=relaxed/simple;
	bh=lYOVq8gC/3CmtMF6bjXNprwIT8xsEyDvHUPhbIOenuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=scIds38DIcWSjg+kBZem2IG9ScJcZe5MG1keVfSOTUYmMGuYIxz0I0/o5uFTMOZ3KWAEymW2lQJ3H68K0EG/5QfoNi7dEeRUL8rJnMMCUq8yv2x+WAqbtVtF3OWxYlJvzwujnYbVgNJ+ag/IRxjQx4Gno8Rb1BezIEQk0XZ9qI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJMZp2uH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707161838; x=1738697838;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lYOVq8gC/3CmtMF6bjXNprwIT8xsEyDvHUPhbIOenuc=;
  b=FJMZp2uH3up1nIqyx5ljwXE7J8sQdLxvPSUVpa+HEjwUSAE/QxtUdcIY
   68GS/aq8iDOxdwiYK75rL5evdh+xoGcM8IuR3/WT2Sn5/i0mF3t598x1U
   ZDVzWf8QI9JUGPvT6X5MyNnzubptp6JdXe4LM92AEH+5MJtS3cTZAJlkV
   YwX83hIBKospCbJBooCA2XThAYUEFvDEjuTMG/ovQEqOXZW57jkXGZH6j
   07I7lT/itzyInM5zq+lqsu9rajG4+4PXbN84Xiknf/QVmEDSgDiE/M8Pv
   4WsTraPJRjmk2kJ3X+wqFqH4QvR5k2ljZuJ8qgKmtz3+tojZjPRHcbbS/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26039532"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="26039532"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:37:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5423366"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:37:17 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id 83366580D9C;
	Mon,  5 Feb 2024 11:37:16 -0800 (PST)
Message-ID: <dc3fce1400541a269ecee2b2ee33d8f1ec8e52e7.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>
Cc: Johan Hovold <johan@kernel.org>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@endlessos.org
Date: Mon, 05 Feb 2024 11:37:16 -0800
In-Reply-To: <20240203000510.GA738687@bhelgaas>
References: <20240203000510.GA738687@bhelgaas>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-02 at 18:05 -0600, Bjorn Helgaas wrote:
> On Fri, Feb 02, 2024 at 03:11:12PM +0800, Jian-Hong Pan wrote:
> > The remapped PCIe Root Port and NVMe have PCI PM L1 substates
> > capability, but they are disabled originally:
> >=20
> > Here is an example on ASUS B1400CEAE:
> >=20
> > Capabilities: [900 v1] L1 PM Substates
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-P=
M_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us PortTPow=
erOnTime=3D10us
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-=
PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=
=3D0ns
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D10us
> >=20
> > Power on all of the VMD remapped PCI devices and quirk max snoop LTR
> > before enable PCI-PM L1 PM Substates by following "Section 5.5.4 of PCI=
e
> > Base Spec Revision 6.0". Then, PCI PM's L1 substates control are
> > initialized & enabled accordingly.
>=20
> > Also, update the comments of
> > pci_enable_link_state() and pci_enable_link_state_locked() for
> > kernel-doc, too.
>=20
> The aspm.c changes should be in a separate patch.=C2=A0 Presumably the
> aspm.c code change fixes a defect, and that defect can be described in
> that patch.=C2=A0 That fix may be needed for non-VMD situations, and havi=
ng
> it in this vmd patch means it won't be as easy to find and backport.
>=20
> Nit: rewrap commit log to fill 75 columns.
>=20
> > @@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pde=
v,
> > void *userdata)
> > =C2=A0	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> > =C2=A0		return 0;
> > =C2=A0
> > -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > -
> > =C2=A0	pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > =C2=A0	if (!pos)
> > -		return 0;
> > +		goto out_enable_link_state;
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Skip if the max snoop LTR is non-zero, indicating BIOS has se=
t
> > it
> > @@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev=
,
> > void *userdata)
> > =C2=A0	 */
> > =C2=A0	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_re=
g);
> > =C2=A0	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> > -		return 0;
> > +		goto out_enable_link_state;
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Set the default values to the maximum required by the platfor=
m
> > to
> > @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_dev *pde=
v,
> > void *userdata)
> > =C2=A0	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_re=
g);
> > =C2=A0	pci_info(pdev, "VMD: Default LTR value set by driver\n");
>=20
> You're not changing this part, and I don't understand exactly how LTR
> works, but it makes me a little bit queasy to read "set the LTR value
> to the maximum required to allow the deepest power management
> savings" and then we set the max snoop values to a fixed constant.
>=20
> I don't think the goal is to "allow the deepest power savings"; I
> think it's to enable L1.2 *when the device has enough buffering to
> absorb L1.2 entry/exit latencies*.
>=20
> The spec (PCIe r6.0, sec 7.8.2.2) says "Software should set this to
> the platform's maximum supported latency or less," so it seems like
> that value must be platform-dependent, not fixed.
>=20
> And I assume the "_DSM for Latency Tolerance Reporting" is part of the
> way to get those platform-dependent values, but Linux doesn't actually
> use that yet.

This may indeed be the best way but we need to double check with our BIOS f=
olks.
AFAIK BIOS writes the LTR values directly so there hasn't been a need to us=
e
this _DSM. But under VMD the ports are hidden from BIOS which is why we add=
ed it
here. I've brought up the question internally to find out how Windows handl=
es
the DSM and to get a recommendation from our firmware leads.

>=20
> I assume that setting the max values incorrectly may lead to either
> being too conservative, so we don't use L1.2 when we could, or too
> aggressive, so we use L1.2 when we shouldn't, and the device loses
> data because it doesn't have enough internal buffering to absorb the
> entry/exit delays.
>=20
> This paper has a lot of background and might help answer some of my
> questions:
> https://www.intel.co.za/content/dam/doc/white-paper/energy-efficient-plat=
forms-white-paper.pdf
>=20
> > +out_enable_link_state:
> > +	/*
> > +	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
> > +	 * Section 5.5.4 of PCIe Base Spec Revision 6.0
> > +	 */
> > +	pci_set_power_state_locked(pdev, PCI_D0);
> > +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>=20
> Hmmm.=C2=A0 PCIE_LINK_STATE_ALL includes ASPM L1.2.=C2=A0 We may do this =
even if
> the device doesn't have an LTR Capability.=C2=A0 ASPM L1.2 cannot work
> without LTR.
>=20
> I only took a quick look but was not convinced that
> pci_enable_link_state() does the right thing when we enable
> PCIE_LINK_STATE_ALL (including ASPM L1.2) on a device that doesn't
> have LTR.=C2=A0 I think it *should* decline to set PCI_L1SS_CTL1_ASPM_L1_=
2,
> but I'm not sure it does.=C2=A0 Can you double check that path?=C2=A0 May=
be
> that's another defect in aspm.c.

It doesn't currently decline. The same scenario happens when the user selec=
ts
powersupersave. If a device advertises L1.2 with the capable registers set,=
 it
should also have the LTR register present. But it doesn't hurt to check.

David

>=20
> > @@ -1164,6 +1164,8 @@ static int __pci_enable_link_state(struct pci_dev
> > *pdev, int state, bool locked)
> > =C2=A0		link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM |
> > ASPM_STATE_L1;
> > =C2=A0	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > =C2=A0		link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM |
> > ASPM_STATE_L1;
> > +	if (state & ASPM_STATE_L1_2_MASK)
> > +		aspm_l1ss_init(link);
> > =C2=A0	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > =C2=A0
> > =C2=A0	link->clkpm_default =3D (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;


