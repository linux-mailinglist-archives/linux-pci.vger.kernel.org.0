Return-Path: <linux-pci+bounces-7119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B08BD065
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F751F24FDA
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4827715219E;
	Mon,  6 May 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3PDVwHX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54183613D;
	Mon,  6 May 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006145; cv=none; b=TYQ9fNDNXWtzfy42S3Oe6Gja/WL31C6Uum839eYwuHJmPvPlj4O7jAPQa2e5GMv0FinXKtI7lN3kIgs3YFkPbwmp0YhaOzU63J75Kfc4mLcyrGZ6+XlUnooMKHdk9bUe3Acvp63Rt70RsIyaUT9zxcAj1efnHR80j/nXb4nFM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006145; c=relaxed/simple;
	bh=e7HTaiEOkmkyJLnFpjteHG7h39udIJBpDlEILJ0M2T0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c01CfVzxXdforLp8x6Ry38OH11KqyDlinfGhXMi/9qtGiwpScyMavWxnaAKUsnbPYz8Wx717LLcbLa1PCtYj+HotoaZD2Sf0wv/61OtlpNl0s0gbj26ZtzGywnTuV6XGZX7/r3LjJuzgLxIfmFAHh0RiMOPHzaQU7nV+HyRIZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3PDVwHX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715006144; x=1746542144;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=e7HTaiEOkmkyJLnFpjteHG7h39udIJBpDlEILJ0M2T0=;
  b=F3PDVwHXQHBh2uUprIcf6AvgWs5P4y9pq3zwq+r7d1YmItzMZSjK0VJ9
   yJfm2uekJxDxjSLWavP+BEWCiHeYc1ic/E6D3fwB6KPSyjteX15w1SYRY
   1NW34aoz1DNfVAGWOaXD1vpA6iSZnGxcHPCNiqITea2zQoWKFMU+kSNtQ
   UBxRZDlF+hJ5KOriLt0L228f0rU/glMxGnO1+yt3KzIBO3WzWOqfn9Bva
   o49xGa+YbOa7rQURes7IQRTSP8Ap70WxEj8A7JlN9NS9bsz5S1/2tYOAv
   RhDOCGZ5IXZ0Qb4VK2bZE5odzq7j14b0oCOSUFNY+8QZh/ujK/9KYsJs0
   g==;
X-CSE-ConnectionGUID: XnpfjLGvSrSqhF3TFI6fZA==
X-CSE-MsgGUID: TUT9evfoTISSYy2T1kQoow==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14535896"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="14535896"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:35:43 -0700
X-CSE-ConnectionGUID: A40k2weoTG65ZydoWdBO0w==
X-CSE-MsgGUID: l0S3Bw+/R/2Wl8ZHpd+pBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28184155"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:35:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 17:35:34 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
In-Reply-To: <20240503225305.GA1609388@bhelgaas>
Message-ID: <816d5e04-1af7-884c-1ec2-ad70c18068a7@linux.intel.com>
References: <20240503225305.GA1609388@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1733933349-1715004351=:1111"
Content-ID: <c4cc418c-1dd3-ce34-6759-6c90ef46b8f8@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1733933349-1715004351=:1111
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a6b0eafc-f653-302c-44ae-97c6bf23ef83@linux.intel.com>

On Fri, 3 May 2024, Bjorn Helgaas wrote:

> On Fri, Apr 12, 2024 at 04:36:34PM +0300, Ilpo J=E4rvinen wrote:
> > pcie_read_tlp_log() handles only 4 TLP Header Log DWORDs but TLP Prefix
> > Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
> >=20
> > Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> > TLP Prefix Log. The layout of relevant registers in AER and DPC
> > Capability is not identical because the offsets of TLP Header Log and
> > TLP Prefix Log vary so the callers must pass the offsets to
> > pcie_read_tlp_log().
>=20
> I think the layouts of the Header Log and the TLP Prefix Log *are*
> identical, but they are at different offsets in the AER Capability vs
> the DPC Capability.  Lukas and I have both stumbled over this.

I'll try to reword it once again.

The way it's spec'ed, there actually also a small difference in sizes too=
=20
(PCIe r6 7.9.14.13 says DPC one can be < 4 DWs whereas AER on is always 4=
=20
DWs regardless of the number of supported E-E Prefixes) so I'll just=20
rewrite it so it doesn't focus just on the offset.

> Similar and more comments at:
> https://lore.kernel.org/r/20240322193011.GA701027@bhelgaas

I'm really sorry, I missed those comments and only focused on that ixgbe=20
part.

> > Convert eetlp_prefix_path into integer called eetlp_prefix_max and
> > make is available also when CONFIG_PCI_PASID is not configured to
> > be able to determine the number of E-E Prefixes.
>=20
> s/make is/make it/
>=20
> I think this could be a separate patch.

Sure, I can make it own patch.

> > --- a/include/linux/aer.h
> > +++ b/include/linux/aer.h
> > @@ -20,6 +20,7 @@ struct pci_dev;
> > =20
> >  struct pcie_tlp_log {
> >  =09u32 dw[4];
> > +=09u32 prefix[4];
> >  };
> > =20
> >  struct aer_capability_regs {
> > @@ -37,7 +38,9 @@ struct aer_capability_regs {
> >  =09u16 uncor_err_source;
> >  };
> > =20
> > -int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_=
log *log);
> > +int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> > +=09=09      unsigned int tlp_len, struct pcie_tlp_log *log);
> > +unsigned int aer_tlp_log_len(struct pci_dev *dev);
>=20
> I think it was a mistake to expose pcie_read_tlp_log() outside
> drivers/pci, and I don't think we should expose aer_tlp_log_len()
> either.

Ah, my intention was to remove the exposure but I only ended up removing=20
the actual EXPORT and didn't realize I should have also moved the=20
prototype into another header.

I'll add also a patch to remove pcie_read_tlp_log() EXPORT too but I'm=20
wondering now whether I should also move these function(s) into=20
pcie/aer.c (or somewhere else that is only build if AER is enabled) since=
=20
there won't be callers ourside of AER/DPC?

> We might be stuck with exposing struct pcie_tlp_log since it looks
> like ras_event.h uses it.

Yes.

--=20
 i.
--8323328-1733933349-1715004351=:1111--

