Return-Path: <linux-pci+bounces-13587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D398F987B5C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 00:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F4B27943
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4481AFB22;
	Thu, 26 Sep 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgqHhmbK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5F1AFB28;
	Thu, 26 Sep 2024 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391129; cv=none; b=C7ipUHzjIGgJiUAWzpof4Q6AxQKGxyHiA3adwDFIaUZxg79hf/CSZiAFcW7T7cutnKbzu5oxjgF+bi5YjAemZqNp+NiLPvOwDo/8wNvHdr5/p22U2YzWo/JA5Gy1WQtb8NqUN3V7ejEYmJRdx2qHU6hsovEOPNvrvR764qbrFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391129; c=relaxed/simple;
	bh=xWSyJmSNI7LoWC9io0Tr2oy4PCGj81bWcyGaTIVCR3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYHIjehVy+H6i+WYFaLFT2sT2oPzhvnPf2FOA7lD9dK2BZC/ktpCY9ww0qtQZuiyPfdTRNlS8E0H0QgjoRrQZkCzFtbiqJMa7xdxSePl5z0a/MnLpJOCTUIEUUJrzsEcOCH8cGjVr9k5wC+xe+rOQaBFeGggMDTmLj8IgatB42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgqHhmbK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727391126; x=1758927126;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xWSyJmSNI7LoWC9io0Tr2oy4PCGj81bWcyGaTIVCR3U=;
  b=QgqHhmbKiV+wN06QMwypEjTDuicG23yr8RzJ77Sjcjk5a8D9ZJNMNKqV
   nw4E29aDCN5z4H54QZJ17sTTe1VPafu17eIKsdpMsE5JxO2SLxNCGJIQA
   +0B2kRKb6stEqAJG1beuNeSfXMrH0sBYuJ03GUl0d3nYH8XiDWPyJoAs0
   8nquGJboh8HebL+YtabC2rmnaRjrwKfOjvLlCDsu7+UNFnXkZWuDLBY0C
   f1oQpSEplET78VJf4gfd2/UcxQoLxvioN69AvaTxBYJDy6hv4ODUEQgVd
   YBplTU82wQsn83WJ/IzRwB8bkDuzx2bubD/khSlGfpJvHD/WzxZ2IcNGq
   g==;
X-CSE-ConnectionGUID: nqDQQt9IRayjMFf1uleE9w==
X-CSE-MsgGUID: 0MJrqqMDSjuWgMiqSIzYew==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37106240"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="37106240"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 15:52:05 -0700
X-CSE-ConnectionGUID: CklOJncpQby2szYTjo+emw==
X-CSE-MsgGUID: Ybj5evWJTAW1w6yJ3BaxAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="72410576"
Received: from inaky-mobl1.amr.corp.intel.com ([10.125.111.247])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 15:52:05 -0700
Message-ID: <0308080557f305710be243380fe5b9da02b8b421.camel@linux.intel.com>
Subject: Re: [PATCH v9 3/3] PCI: vmd: Save/restore PCIe bridge states
 before/after pci_reset_bus()
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux@endlessos.org
Date: Thu, 26 Sep 2024 15:52:04 -0700
In-Reply-To: <44275137-97fc-3da9-c01a-6e747c236c8e@linux.intel.com>
References: <20240924070551.14976-2-jhp@endlessos.org>
	 <20240924072858.15929-3-jhp@endlessos.org>
	 <8050f9d4cb851fc301cc35b4fb5a839ff71fdcae.camel@linux.intel.com>
	 <CAPpJ_ed09KJY9Gw2qGwOHdKFw4-BAMyG6jOyWHnV7brJutwfVw@mail.gmail.com>
	 <44275137-97fc-3da9-c01a-6e747c236c8e@linux.intel.com>
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

On Thu, 2024-09-26 at 13:52 +0300, Ilpo J=C3=A4rvinen wrote:
> On Thu, 26 Sep 2024, Jian-Hong Pan wrote:
>=20
> > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=E6=
=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:51=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >=20
> > > Hi Jian-Hong,
> > >=20
> > > On Tue, 2024-09-24 at 15:29 +0800, Jian-Hong Pan wrote:
> > > > PCI devices' parameters on the VMD bus have been programmed properl=
y
> > > > originally. But, cleared after pci_reset_bus() and have not been
> > > > restored
> > > > correctly. This leads the link's L1.2 between PCIe Root Port and ch=
ild
> > > > device gets wrong configs.
> > > >=20
> > > > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both P=
CIe
> > > > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > > > However, they are configured as different values in this case:
> > > >=20
> > > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> > > > Processor
> > > > PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> > > > =C2=A0 ...
> > > > =C2=A0 Capabilities: [200 v1] L1 PM Substates
> > > > =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ A=
SPM_L1.1+
> > > > L1_PM_Substates+
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us Por=
tTPowerOnTime=3D50us
> > > > =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ =
ASPM_L1.1-
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=
=3D0ns
> > > > =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D0us
> > > >=20
> > > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp W=
D
> > > > Blue
> > > > SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > > > =C2=A0 ...
> > > > =C2=A0 Capabilities: [900 v1] L1 PM Substates
> > > > =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ A=
SPM_L1.1-
> > > > L1_PM_Substates+
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us Por=
tTPowerOnTime=3D10us
> > > > =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ =
ASPM_L1.1-
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=
=3D101376ns
> > > > =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D50us
> > > >=20
> > > > Here is VMD mapped PCI device tree:
> > > >=20
> > > > -+-[0000:00]-+-00.0=C2=A0 Intel Corporation Device 9a04
> > > > =C2=A0| ...
> > > > =C2=A0=C2=A5-[10000:e0]-+-06.0-[e1]----00.0=C2=A0 Sandisk Corp WD B=
lue SN550 NVMe SSD
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A5-17.0=C2=A0 Intel Corporation Tiger Lake-LP SATA Control=
ler
> > > >=20
> > > > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves=
 and
> > > > restores NVMe's state before and after reset. Because bus [e1] has =
only
> > > > one
> > > > device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, whe=
n it
> > > > restores the NVMe's state, it also restores the ASPM L1SS between t=
he
> > > > PCIe
> > > > bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's L1=
SS is
> > > > restored correctly. But, the PCIe bridge's L1SS is restored with th=
e
> > > > wrong
> > > > value 0x0. Becuase, the PCIe bridge's state is not saved before res=
et.
> > > > That is why pci_restore_aspm_l1ss_state() gets the parent device (P=
CIe
> > > > bridge)'s saved state capability data and restores L1SS with value =
0.
> > > >=20
> > > > So, save the PCIe bridge's state before pci_reset_bus(). Then, rest=
ore
> > > > the
> > > > state after pci_reset_bus(). The restoring state also consumes the
> > > > saving
> > > > state.
> > > >=20
> > > > Link: https://www.spinics.net/lists/linux-pci/msg159267.html
> > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > ---
> > > > v9:
> > > > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD
> > > > instead.
> > > >=20
> > > > =C2=A0drivers/pci/controller/vmd.c | 7 +++++++
> > > > =C2=A01 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/=
vmd.c
> > > > index 11870d1fc818..2820005165b4 100644
> > > > --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -938,9 +938,16 @@ static int vmd_enable_domain(struct vmd_dev *v=
md,
> > > > unsigned long features)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!list_empty(&child->devices)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D list_f=
irst_entry(&child->devices,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev, bus_list);
> > >=20
> > > Newline here
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* To avoid pci_rese=
t_bus restore wrong ASPM L1SS
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * configuratio=
n due to missed saving parent
> > > > device's
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * states, save=
 & restore the parent device's
> > > > states
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as well.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > >=20
> > > No text on first line of comment.
> >=20
> > Oops!=C2=A0 Thanks
> >=20
> > > =C2=A0=C2=A0=C2=A0 /*
> > > =C2=A0=C2=A0=C2=A0=C2=A0 * To avoid pci_reset_bus restore wrong ASPM =
L1SS
> > > =C2=A0=C2=A0=C2=A0=C2=A0 * ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0 */
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_save_state(dev->=
bus->self);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_re=
set_bus(dev);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_warn(dev, "can't reset device: %d=C2=
=A5n",
> > > > ret);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_restore_state(de=
v->bus->self);
> > >=20
> > > I think Ilpo's point was that pci_save_aspm_l1ss_state() and
> > > pci_restore_aspm_l1ss_state() should be more symmetric. If
> > > pci_save_aspm_l1ss_state() is changed to also handle the state for th=
e
> > > device
> > > and its parent in the same call, then no change is needed here. But t=
hat
> > > would
> > > only handle L1SS settings and not anything else that might need to be
> > > restored
> > > after the bus reset. So I'm okay with it either way.
>=20
> Why would something else need to be restored? The spec explicitly says th=
e=20
> bus reset should not cause config changes on the parent other than=20
> to status bits.
>=20
> Based on what is seen so far, the problem here is not the reset itself=
=20
> breaking parent's config but ASPM code restoring values from state beyond=
=20
> what it had saved and thus it programs pseudogarbage into the L1SS=20
> settings.

I see. This must be an earlier state. If I had to guess, the parent (maybe =
the
child too) were saved before L1SS was configured and only the child was sav=
ed
during the bus reset leading to a mismatch in what was restored.

David

>=20
> > Yes, that made me think the whole day before I sent out this patch. I
> > do not know what is the best reset bus procedure, especially how other
> > drivers reset the bus.
> >=20
> > If trace the code path:
> > pci_reset_bus()
> > =C2=A0 __pci_reset_bus()
> > =C2=A0=C2=A0=C2=A0 pci_bus_reset()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_bus_save_and_disable_locked()
> >=20
> > pci_bus_save_and_disable_locked()'s comment shows "Save and disable
> > devices from the top of the tree down while holding the @dev mutex
> > lock for the entire tree". I think that means the PCI(e) bridge should
> > save state first, then the following bus' devices. However, VMD resets
> > the child device (10000:e1:00.0 NVMe)'s bus first and only saves the
> > child device (10000:e1:00.0 NVMe)'s state. It does not visit the tree
> > from the top to down. So, it misses the PCIe bridge.=C2=A0 Therefore, I
> > make it save & restore its parent (10000:e0:06.0 PCIe bridge)'s state
> > as compensation.
>=20
> The problem with your fix is it only takes care of part of the cases (i.e=
.=20
> VMD). But there are other callers of pci_reset_bus() which would also=20
> restore incorrect L1SS settings, no?
>=20
> I'd suggest making the L1SS code symmetric on this, even if it means=20
> saving the register value twice when walking the tree downwards (it seems=
=20
> harmless to write the same value twice).
>=20


