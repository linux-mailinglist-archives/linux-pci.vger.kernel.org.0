Return-Path: <linux-pci+bounces-18811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE899F84CB
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFBA188A81E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 19:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8356A1B041E;
	Thu, 19 Dec 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtqPtCPm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A2155342;
	Thu, 19 Dec 2024 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734637961; cv=none; b=D1OAY8pFNHtVsjIAEsUWT+be3+JmOLJnebq1fc7vsvdOg0fKSZ2sEBUgSVf/9LEi8wBjjFuho7YS/yRMCljGL/yU1Q66cYgl7FEMCMhPOB5BHKhp7PHitpSd9yV0VcCp0JIJUz1j5Swxi/66b4/tcbAEralpCqKyDiVHHaD2yeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734637961; c=relaxed/simple;
	bh=pBH2xtozFGdOHwp8Qrf+Na3F52ENcdh/Qjxb0ZI7ezI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K34IdUN0XSfSjupk0hM98cbTx/1KVXagdg7XpgkPlCoaAtS6kFvwia7FZNYzQAiEkTLCwyk91dOSTxJCMgVqMSIYY0DXoD22FVaDdTDa+ztsfbqLjhufHltlAJv7q8fTN3AB4pO7SSAmyPB85Jh/kHY5oVZB2DHNBLRYvjehQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtqPtCPm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734637959; x=1766173959;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pBH2xtozFGdOHwp8Qrf+Na3F52ENcdh/Qjxb0ZI7ezI=;
  b=jtqPtCPmJIru0ZgwsH9EJWfaMr10fQrYTG/H/4/qfKOCUbB/NhESZR2c
   VB7elpTgQ6C+cdLHAmBEFnRb5BBIku0vOi2YMI3czWTlsqvcdTGQvP1mr
   ikLO7hsBqTTmSNkHghSqDxHS6CzpvACNmk0O5qefcV4Byy35csKF3atVQ
   +Toi3NPHbYYTV1hxZAt+J30bU+QHRMWo+r6PLnT3+aZJqvNwZPCCkdMjN
   8cMFut/m9cWKaLdxK2Kp+QGJtGJgHp5FNEprhjbkIFhRe0w8A2Wp3q6jc
   EeC5fwiruY44jOZkq7nm6r3uYXwpZ7mktiSjIC1YhGckSwqLeDcTkca9g
   w==;
X-CSE-ConnectionGUID: E6u9XAkNTBWcO9W3ASV1oQ==
X-CSE-MsgGUID: X+a8vlORQg2sO5WIjFX1uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="60550964"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="60550964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 11:52:39 -0800
X-CSE-ConnectionGUID: qLBfQ+rERpm/zQ38WY7F+Q==
X-CSE-MsgGUID: TpQ5DL2zQBm6FbzOdR5ZyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98134734"
Received: from dwoodwor-mobl2.amr.corp.intel.com ([10.125.108.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 11:52:38 -0800
Message-ID: <2ed90445e8e39a76e58a37712ca75ba40d121c15.camel@linux.intel.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com, rafael@kernel.org
To: Kenneth Crudup <kenny@panix.com>, Bjorn Helgaas <helgaas@kernel.org>, 
 Nirmal Patel <nirmal.patel@linux.ntel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Vidya Sagar
 <vidyas@nvidia.com>,  Bjorn Helgaas <bhelgaas@google.com>, Andrea Righi
 <andrea.righi@canonical.com>, You-Sheng Yang <vicamo.yang@canonical.com>,
 linux-pm@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Thu, 19 Dec 2024 11:52:37 -0800
In-Reply-To: <28fd68e1-f76f-40a9-89a8-a24d693209c1@panix.com>
References: <20241213230214.GA3434438@bhelgaas>
	 <ffeae6a38215df37d8c109c16fd8b6713687ba77.camel@linux.intel.com>
	 <28fd68e1-f76f-40a9-89a8-a24d693209c1@panix.com>
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

+Rafael

On Thu, 2024-12-19 at 10:17 -0800, Kenneth Crudup wrote:
> I do see that:
>=20
> ----
> [E0] 781 /usr/src/ubuntu-kernel> dmesg | fgrep -i aspm
> [=C2=A0=C2=A0=C2=A0 0.164233] ACPI FADT declares the system doesn't suppo=
rt PCIe ASPM,=20
> so disable it

So, PCIe ASPM refers to OS control of ASPM. Disabling it means the BIOS alo=
ne
controls it, leaving the OS to stick with the defaults programmed into the
controllers by the BIOS. This might happen due to critical bugs in certain =
ASPM
states or simply because the OEM decided to configure it that way. We don't=
 know
the exact reason.

The issue with VMD is that its controllers are hidden from the BIOS, so ASP=
M
defaults are never programmed into them. When PCIe ASPM is disabled, it's
unclear whether this should apply to controllers in VMD mode. To be cautiou=
s, we
avoid modifying ASPM settings in this scenario.

If you want to override this behavior, you can try setting pcie_aspm=3Dforc=
e on
the kernel command line.

David

> [=C2=A0=C2=A0=C2=A0 0.579946] acpi PNP0A08:00: _OSC: OS supports [Extende=
dConfig ASPM=20
> ClockPM Segments MSI EDR HPX-Type3]
> [=C2=A0=C2=A0=C2=A0 0.587377] acpi PNP0A08:00: FADT indicates ASPM is uns=
upported,=20
> using BIOS configuration
> [=C2=A0=C2=A0=C2=A0 1.309826] pci 10000:e0:06.0: enable ASPM for pci brid=
ge behind vmd
> [=C2=A0=C2=A0=C2=A0 1.622705] pci 10000:e1:00.0: can't override BIOS ASPM=
; OS doesn't=20
> have ASPM control
> [110757.878494] pcieport 0000:00:07.0: ASPM: current common clock=20
> configuration is inconsistent, reconfiguring
> [171953.284616] pcieport 0000:00:07.0: ASPM: current common clock=20
> configuration is inconsistent, reconfiguring
> ----
>=20
> On 12/19/24 08:25, David E. Box wrote:
> > Hi Kenneth,
> >=20
> > On Fri, 2024-12-13 at 17:02 -0600, Bjorn Helgaas wrote:
> > > [cc->to: David, Nirmal]
> > >=20
> > > On Fri, Dec 13, 2024 at 02:26:37PM -0800, Kenneth Crudup wrote:
> > > > OK, it looks like the effective change (that's not already containe=
d in
> > > > the
> > > > LTR SNOOP patches already in Linus' master (et al.)) comes from thi=
s
> > > > line
> > > > from the Ubuntu commit 1a0102a0 ("UBUNTU: SAUCE: PCI/ASPM: Enable A=
SPM
> > > > for
> > > > links under VMD domain"):
> > > >=20
> > > > ----
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index 00143f5fb83a..d2ff44e7fbb1 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -688,7 +688,8 @@ static void pcie_aspm_cap_init(struct
> > > > pcie_link_state
> > > > *link, int blacklist)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspm_l1ss_init(lin=
k);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Save default st=
ate */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->aspm_default =3D link->=
aspm_enabled;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->aspm_default =3D parent=
->dev_flags &
> > > > PCI_DEV_FLAGS_ENABLE_ASPM ?
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ASPM_STATE_ALL : link->aspm_enabled;
> > >=20
> > > So I thought the "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)" i=
n
> > > f492edb40b54 would effectively do the same thing:
> > >=20
> > > > > > > > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/lin=
ux/+git/
> > > > > > > > lunar/commit/?id=3D1a0102a08f206149d9abd56c2b28877c878b5526
> > > > > > >=20
> > > > > > > This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under=
 VMD
> > > > > > > domain", which adds "link->aspm_default =3D ASPM_STATE_ALL" f=
or
> > > > > > > device
> > > > > > > IDs 0x9a09 and 0xa0b0.
> > > > > > >=20
> > > > > > > This looks like it should also be handled by upstream f492edb=
40b54
> > > > > > > ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], w=
hich
> > > > > > > adds
> > > > > > > "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".
> > >=20
> > > But I guess it doesn't actually work.=C2=A0 I'm hoping David or Nirma=
l can
> > > figure out why it doesn't because it seems obvious that it's the
> > > intent.
> >=20
> > Is PCIe ASPM disabled? In the kernel log do you see:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 "can't override BIOS ASPM; OS doesn't have ASP=
M control"
> >=20
> > David
> >=20
>=20


