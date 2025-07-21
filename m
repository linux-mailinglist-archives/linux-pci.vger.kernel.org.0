Return-Path: <linux-pci+bounces-32623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B8B0BDFC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094FD3A572E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBD1DE4E0;
	Mon, 21 Jul 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fjycfej7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B272616;
	Mon, 21 Jul 2025 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083936; cv=none; b=HTUy8BcB71NFlEf38yOokRmt0uxWu9oxTv0KMB4brwi1xNvuqEeYzO4h576a39o7rLi+z0BIaho+xYM/QLT4cbM/yivLXQ9pYZf3e80QdBj4AwSig623EZcJX/6+YAXXx9LhJ9VMir3wxqWG4WknqweCr35102FeMs2I0DvlA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083936; c=relaxed/simple;
	bh=eLZHN5egYUenvNg0cJ5c8JuotvCBO/2MOsRyXczAFeM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YM7hudmfQMXhyXLhqaM9BlCFUuBmHUdmp6jf41mFr1sdnWI5UpL2Fv6PYUmizzGzTyXF5rIzkTQQfJ+FAM7glJn/8txIbdA6ryxK1o9nEb66jbQfKkZQdFzzxd5vyzlx7YbMaBQLn5RXXPxus6y/0PDs+nVFjILg3s00lPfL2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fjycfej7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753083935; x=1784619935;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eLZHN5egYUenvNg0cJ5c8JuotvCBO/2MOsRyXczAFeM=;
  b=Fjycfej7JalCunZViLqMqpxGkIXPcSu87S0YrGmThOoIuzWbZZiW8wCn
   SAOLi2Sk9o3lsVCfxJFRQnA0vMB2WnliHr1R7fOMO4R3QeT/4HLlwrFCM
   R7fGawXVJRlCbWm+hJapjlzzQEce/wqBS5lWFbp5adpHHE5d9wxdbpDT+
   9D/ybKYeKDtxseQzbKmSMUWwgK+W1AisQRFiXXT9FQ19Q3iHAjquYn3OB
   A2kbLRxhur1gA7T3q7J+6E3/O5QCuqZkNZJg5iQsx7x4eiQRbraL/l2OF
   /8tqnywLwz5oeS8yCxEMNrY0CpFz+wLwNPY6zCpvqahZkKCRiCSXzcBGe
   A==;
X-CSE-ConnectionGUID: JzKLagIITia+9itZUUYvmA==
X-CSE-MsgGUID: chWX/P6sTBGzjjvnzHk7BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="54392859"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="54392859"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:45:34 -0700
X-CSE-ConnectionGUID: UziwiWreSA6l/pK30EZxeQ==
X-CSE-MsgGUID: 5Ocwu8UCTz6aRdvWjYPCmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="159107555"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:45:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 10:45:21 +0300 (EEST)
To: Manivannan Sadhasivam <mani@kernel.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
In-Reply-To: <gwpn5no4i2wwwk3qo4tcgp6z6floo6k2ymzfuucg3tbwtmccte@ydsupmrd2nqu>
Message-ID: <85c2894c-ca05-6238-aeb6-a1e81897132a@linux.intel.com>
References: <604ffae3-1bfc-0922-b001-f3338880eb21@linux.intel.com> <20250711230013.GA2309106@bhelgaas> <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w> <9543b1eb-5bd2-bea1-742f-60cbc28bb365@linux.intel.com>
 <gwpn5no4i2wwwk3qo4tcgp6z6floo6k2ymzfuucg3tbwtmccte@ydsupmrd2nqu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1487026172-1753083921=:945"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1487026172-1753083921=:945
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Jul 2025, Manivannan Sadhasivam wrote:
> On Sun, Jul 13, 2025 at 07:27:57PM GMT, Ilpo J=C3=A4rvinen wrote:
> > On Sat, 12 Jul 2025, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 11, 2025 at 06:00:13PM GMT, Bjorn Helgaas wrote:
> > > > On Fri, Jul 11, 2025 at 04:38:48PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > >=20
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -1826,8 +1826,8 @@ static inline int pcie_set_target_speed(str=
uct pci_dev *port,
> > > > >  #ifdef CONFIG_PCIEASPM
> > > > >  int pci_disable_link_state(struct pci_dev *pdev, int state);
> > > > >  int pci_disable_link_state_locked(struct pci_dev *pdev, int stat=
e);
> > > > > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> > > >=20
> > > > AFAICT there's no caller of this at all.  Why do we keep it?
> > > >=20
> > >=20
> > > I'm just working on a series to convert the ath{10/11/12}k drivers to=
 use this
> > > API instead of modifying LNKCTL register directly:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/net/wireless/ath/ath12k/pci.c#n961
> >=20
> > Great. I assume but "this API" you meant disable/enable link state that=
=20
> > are real pair unlike the current pci_enable_link_state()?
> >=20
>=20
> Yes. I actually based my series on top of this series, but I guess I shou=
ld just
> merge the API change patch to my series as it is relatively small compare=
d to
> this one (so it will get merged quicker).
>=20
> > Did ath1xk need to do some hw specific register updates when changing A=
SPM=20
> > state?
> >=20
>=20
> Fortunately, no.
>=20
> > I tried to do similar conversion in r8169 (and actually also ath1xk too=
)=20
> > but it was a while ago already. If I understood the code correctly, r81=
69=20
> > seems to write some HW specific registers when changing ASPM state so I=
=20
> > would have likely need to add some ops for it to play nice with state=
=20
> > changes not originating from the driver itself but from the ASPM driver=
,=20
> > which is where the work then stalled.
> >=20
>=20
> ath driver changes are straightforward, but I need to add an inline funct=
ion to
> convert lnkctl setting to aspm states:
>=20
> static inline int ath_pci_aspm_state(u16 lnkctl)
> {
> =09int state =3D 0;
>=20
> =09if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> =09=09state |=3D PCIE_LINK_STATE_L0S;
> =09if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> =09=09state |=3D PCIE_LINK_STATE_L1;
>=20
> =09return state;
> }
>=20
> Currently, it is in ath/ath.h, but if you feel that we should move it to
> include/linux/pci.h, let me know!
>=20
> > > > > -int pci_enable_link_state_locked(struct pci_dev *pdev, int state=
);
> > > >=20
> > > > We only have two callers of this (pcie-qcom.c and vmd.c, both in
> > > > drivers/pci/), so it's not clear to me that it needs to be in
> > > > include/linux/pci.h.
> > > >=20
> > > > I'm a little dubious about it in the first place since I don't thin=
k
> > > > drivers should be enabling ASPM states on their own, but pcie-qcom.=
c
> > > > and vmd.c are PCIe controller drivers, not PCI device drivers, so I
> > > > guess we can live with them for now.
> > > >=20
> > > > IMO the "someday" goal should be that we get rid of aspm_policy and
> > > > enable all the available power saving states by default.  We have
> > > > sysfs knobs that administrators can use if necessary, and drivers o=
r
> > > > quirks can disable states if they need to work around hardware
> > > > defects.
> > >=20
> > > Yeah, I think the default should be powersave and let the users disab=
le it for
> > > performance if they want.
> >=20
> > I'm certainly not against improvements in this front, but I think we ne=
ed=20
> > to get rid off custom ASPM disable code from the drivers first.
> >=20
>=20
> It would be difficult IMO as drivers have their own usecases. For instanc=
e, the
> ath drivers need to disable ASPM states to avoid issues during firmware
> download. Then they need to enable ASPM back once the firmware is up and
> running.

I understand and I didn't meant that we should disallow drivers from=20
touching ASPM state. I just meant we should convert the drivers to=20
do such state changes using the ASPM driver (through disable/enable API)=20
rather than what they currently do with LNKCTL directly behind the ASPM=20
driver's back.

--=20
 i.

--8323328-1487026172-1753083921=:945--

