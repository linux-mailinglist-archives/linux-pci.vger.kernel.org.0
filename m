Return-Path: <linux-pci+bounces-27715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39647AB6B1D
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714D43B3B30
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7A8278170;
	Wed, 14 May 2025 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAVJvTnQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3108278172;
	Wed, 14 May 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224592; cv=none; b=Oorihrd5xqoD5OwThmvenHL8qkUOAM3ElJG0loHqnTobkfAY38UFDw94iGv5dcVPE1rSZ703r8aEe7BCgY7VqMFTmTm5WEOGkdY2GfHGklgfhD1OEtg20YcxzVbGgG0zVrpf+54hqAyRAQN91UMCUkWrVhTzz1yqzlEwerDRko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224592; c=relaxed/simple;
	bh=G+zX7yuG29hH5z39xxu37DP3nN6P2PRPMHIngMLxze0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ejvuQzPq8j/Q+2ACuyxanbZwgnkBPFoannC+U78ZZrBUwx+atFvzwaeSdDJc+c75deNG/a7eCjhK6Wsl/bc3L9jrmAuoWydOKbA8mIeLsohdeXJ/vbAStQYt8v+g3lJGHwveiBGFJIapVvMHAIDRldfBm/9P3E03gkd7vYH3mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAVJvTnQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747224591; x=1778760591;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G+zX7yuG29hH5z39xxu37DP3nN6P2PRPMHIngMLxze0=;
  b=OAVJvTnQaQRv27Jwy9muP3Gwsn3o/QQeLZm5mlObsw1EMBfkEeBSK3TP
   V9Yoy0Fb7endq3LH97WTP+Hbr8/PsmMeK/ozu9dEgBrq4YKhDoFzIh23t
   N1sZFeI+0J2kYDbpovhd3wt+leNCr8Yb+enVYHspQR+xFtKJS2/ICQ/cS
   dXjx3Ylj83qnZp/USlfr3xpYqFis5YZ5tVKv8BLA6X8SxqdZ/WzS2k3i/
   HO60UJ/GXDyQl5etBahZOOk/91zskaRuIXpqswEs9qBMxoc8xeHsN933v
   I09Q1L0STCXpqOyOkDhdpI3EUfnwPQW8svFJMU2RvOuug4p/xR1n1KdYD
   A==;
X-CSE-ConnectionGUID: cLUXxFV1RfSNLSlsTmbG0w==
X-CSE-MsgGUID: EcOwjA+MRPSPnI584Ithhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52925403"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="52925403"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:09:51 -0700
X-CSE-ConnectionGUID: 2d6TnqmwRcSXrkWWQZURaQ==
X-CSE-MsgGUID: gLyib5SOTgyckvMioRYUuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="168964151"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.231])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:09:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 May 2025 15:09:44 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Move reset and restore related code to
 reset-restore.c
In-Reply-To: <aCSB9Y5OwNkdiuez@wunner.de>
Message-ID: <096fbf51-cbbf-67ca-862d-9563f88d7f2d@linux.intel.com>
References: <20250512120900.1870-1-ilpo.jarvinen@linux.intel.com> <aCRBFWHKa02Hu-ec@wunner.de> <7c8ebe5d-a5be-6aba-1b84-15dd2f32b52f@linux.intel.com> <aCSB9Y5OwNkdiuez@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1317786367-1747224584=:1054"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1317786367-1747224584=:1054
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 14 May 2025, Lukas Wunner wrote:

> On Wed, May 14, 2025 at 02:29:42PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 14 May 2025, Lukas Wunner wrote:
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -69,15 +69,7 @@ struct pci_pme_device {
> > > >   */
> > > >  #define PCI_RESET_WAIT 1000 /* msec */
> > >=20
> > > I'd move PCI_RESET_WAIT, pci_dev_wait() and
> > > pci_bridge_wait_for_secondary_bus() to reset.c as well.
> > > Then pci_dev_d3_sleep() is the only function which is no longer stati=
c.
> >=20
> > Okay I'll move those as well but that static statement is not exactly=
=20
> > true, I'll these need to do these as well:
> >=20
> > - move pci_bus_max_d3cold_delay() along with=20
> >   pci_bridge_wait_for_secondary_bus() to keep that static, or turn that
> >   into a non-static.
> >=20
> > - make pcie_wait_for_link_delay() non-static.
>=20
> Sorry, missed that.  In that case I suggest moving pcie_wait_for_link()
> as well.  It is already non-static.  Then you can keep the static on
> pcie_wait_for_link_delay().
>
> Per PCIe r6.2 sec 5.8, a transition from D3cold to D0uninitialized
> implies a Fundamental Reset.  That could serve as a creative
> justification in the commit message or in the code comment at the
> top of reset.c why it contains D3cold-related functions. ;)

Great, this is mushrooming fast :-).

That implies making pcie_wait_for_link_status() non-static, regardless of=
=20
location or moving also pcie_retrain_link() which I suppose can't really=20
be excused to reside in reset.c :-). Now that I think about it, I recall=20
I ran across this problem which is why the split ended where it was in=20
this submission.

Maybe, it would make sense to have not only reset.c but also link.c=20
(for waiting, retraining, and link speed related functions). Those two=20
files (link.c and reset.c) are kind of inter-related still but the=20
interface between looks relatively sane and should be one-way (I think, I=
=20
didn't attempt this dual split yet).

--=20
 i.

--8323328-1317786367-1747224584=:1054--

