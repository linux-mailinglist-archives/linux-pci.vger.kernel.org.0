Return-Path: <linux-pci+bounces-32033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D760EB03216
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7FF3A48F0
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CDF27A904;
	Sun, 13 Jul 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLMdBwCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376427877D;
	Sun, 13 Jul 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752424091; cv=none; b=ssHSyWnE+LFO5DvfTnd4N5srCaMi7NurTjiaYJ10SCRrMml4zwDLSrOPt4Hdyf9EkCy0Ms9GthNThz6NcG3CWx/ozfB/IcQbmJuD+PSDA4pA+im1od1j2wByokoWZ+qVPCFkfbMj313mETskHoZ4hV+rAjXTes9+3aM0/70S5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752424091; c=relaxed/simple;
	bh=ifpdTOGwI1rhrSXr9K9a0r6Seeyr+cw10DFMmHo8Udg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=imbcuwzITuOVUSAuoJqFe6nSdskfGZM7LGOsk/PNJsIooUGiEeHgXTiYA/rcz9IyyfmkKG5HJ0l49eGRngG/OMNy0/fgvuzuxzKGLyQ7LNwGyexjs6KdEKk1vG5KlR0PDte+7HwIc2f8Jw7bkNcsNNhBEikBdUBraO6zVwjUg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLMdBwCr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752424090; x=1783960090;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ifpdTOGwI1rhrSXr9K9a0r6Seeyr+cw10DFMmHo8Udg=;
  b=nLMdBwCrcCyfEcUO8sh5hRgaIxVWWpNaOq4YUkyA6uScEptMyQqS43To
   4AL3hjH2AoVteXgbGqq3WgrN/02vpYRKscl9bBtIP6JMM3joFOtDRPmHZ
   oF30Imre+fBLwhOypqmGzWS+A9aq/78jZNNVsqJyUy9hgaBPx5C4+HcbO
   zo8YXswuVappgTfy2DgE/OXq4CKib77yeoqCuanZ/0HgeZfy838RkTNZQ
   cnMPPCqZ5HB6asXn7MRP6qhLDttUVbj1vGx1XvQFvvphlqzxbaCMHtAfN
   tLaW4wpAJ9IqG4/jpH0NYPRTtcYl7M9vi7FCI2Ju87NcYn75/kdrykwnk
   w==;
X-CSE-ConnectionGUID: UdyUvBp3TbS4V2RkqbqTjw==
X-CSE-MsgGUID: +aW+LTBtRnCt5Xra9lRjsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54344672"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="54344672"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 09:28:09 -0700
X-CSE-ConnectionGUID: gK+e7tQVQIOInWqljWHVmA==
X-CSE-MsgGUID: aLHxtV24T2WZICr7KJ1bcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="160767417"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 09:28:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 13 Jul 2025 19:27:57 +0300 (EEST)
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
In-Reply-To: <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>
Message-ID: <9543b1eb-5bd2-bea1-742f-60cbc28bb365@linux.intel.com>
References: <604ffae3-1bfc-0922-b001-f3338880eb21@linux.intel.com> <20250711230013.GA2309106@bhelgaas> <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1313851053-1752424077=:951"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1313851053-1752424077=:951
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 12 Jul 2025, Manivannan Sadhasivam wrote:
> On Fri, Jul 11, 2025 at 06:00:13PM GMT, Bjorn Helgaas wrote:
> > On Fri, Jul 11, 2025 at 04:38:48PM +0300, Ilpo J=C3=A4rvinen wrote:
> >=20
> > > +++ b/include/linux/pci.h
> > > @@ -1826,8 +1826,8 @@ static inline int pcie_set_target_speed(struct =
pci_dev *port,
> > >  #ifdef CONFIG_PCIEASPM
> > >  int pci_disable_link_state(struct pci_dev *pdev, int state);
> > >  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> > > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> >=20
> > AFAICT there's no caller of this at all.  Why do we keep it?
> >=20
>=20
> I'm just working on a series to convert the ath{10/11/12}k drivers to use=
 this
> API instead of modifying LNKCTL register directly:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/wireless/ath/ath12k/pci.c#n961

Great. I assume but "this API" you meant disable/enable link state that=20
are real pair unlike the current pci_enable_link_state()?

Did ath1xk need to do some hw specific register updates when changing ASPM=
=20
state?

I tried to do similar conversion in r8169 (and actually also ath1xk too)=20
but it was a while ago already. If I understood the code correctly, r8169=
=20
seems to write some HW specific registers when changing ASPM state so I=20
would have likely need to add some ops for it to play nice with state=20
changes not originating from the driver itself but from the ASPM driver,=20
which is where the work then stalled.

> > > -int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> >=20
> > We only have two callers of this (pcie-qcom.c and vmd.c, both in
> > drivers/pci/), so it's not clear to me that it needs to be in
> > include/linux/pci.h.
> >=20
> > I'm a little dubious about it in the first place since I don't think
> > drivers should be enabling ASPM states on their own, but pcie-qcom.c
> > and vmd.c are PCIe controller drivers, not PCI device drivers, so I
> > guess we can live with them for now.
> >=20
> > IMO the "someday" goal should be that we get rid of aspm_policy and
> > enable all the available power saving states by default.  We have
> > sysfs knobs that administrators can use if necessary, and drivers or
> > quirks can disable states if they need to work around hardware
> > defects.
>=20
> Yeah, I think the default should be powersave and let the users disable i=
t for
> performance if they want.

I'm certainly not against improvements in this front, but I think we need=
=20
to get rid off custom ASPM disable code from the drivers first.

--=20
 i.

--8323328-1313851053-1752424077=:951--

