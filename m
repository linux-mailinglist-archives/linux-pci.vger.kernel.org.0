Return-Path: <linux-pci+bounces-3895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B642F86057D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922A728239D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EB12D218;
	Thu, 22 Feb 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2UHzjR7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96573F20;
	Thu, 22 Feb 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640102; cv=none; b=KJ2W6EclxRBZz86Ra3eRLLITq2EsJ4kYsT2wj0ykCQtjkncMvmwFbFrh4DJeK+9sBTq9qhpeBmLSP4wFKzdrSJdCv3asYljKEki4ttRRRLfyVjbh1hwhO81o0ZWS4nsDypd6vmz/QDk/q8Mhn6/Ou1NNIPNnRWKvUsP1yw/E5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640102; c=relaxed/simple;
	bh=cGR6QfVp36GMgGkFzkzQQaTyVm1xEpIt1P0nxWtQPBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MF2PG0poQHAlpGg4uWwdF0kpEFIJFzDskoSYHMXcHJWuOHrY9RAN8nBXfULxX9vzDQ0v4k/xQHfoBR1StZz7kbgp0c5ucxz75KFPmYe9TGtz3Ik7qqir+KqctRHDUjXmj/eNjOl0MnDVNltBx2fOd4rhANR3Tz7MIrKbcFXpvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2UHzjR7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708640101; x=1740176101;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cGR6QfVp36GMgGkFzkzQQaTyVm1xEpIt1P0nxWtQPBo=;
  b=Q2UHzjR7bfoqlyiWWQGds/5mXTi3b3o7JeZnaiz+gLCucj0l1JVTejcB
   FQ1YLFaIoUOuf5H0QODzwpyq9Uqu43gcDZu+Bpp3iOYU3ZghdV30JzDNp
   10X7fuSRnZTU+fYEAKhIOJBYuaF6E8ln6amFKkEXCP5zV62c/BAd2UUGQ
   aXsZTUC1nuxw1erqcDdZ9HPG1M32X4vAK/Pk8dB+U0BUODWoweFDSbeBn
   ojhVDrYZtoREjTBYcVnThVtdyhzcIDTfdhIx6FiAnoyKtqkhkKjJiygT7
   hGXqZZyj+k5NI+q+MfPsNDyFOqirDzI+YP84rfg8KLxO4de6Xe5FYilO6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13611153"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13611153"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:15:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10244497"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:14:59 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id CD33A580DB2;
	Thu, 22 Feb 2024 14:14:58 -0800 (PST)
Message-ID: <e5260a4ae90e3907978b47492622678270ad50b7.camel@linux.intel.com>
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com, macro@orcam.me.uk,
  ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
 hkallweit1@gmail.com,  johan+linaro@kernel.org, xueshuai@linux.alibaba.com,
 linux-pci@vger.kernel.org,  linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com,  kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
Date: Thu, 22 Feb 2024 14:14:58 -0800
In-Reply-To: <057c9a17-bbf2-49c5-b7ee-d3357d5b5100@linux.intel.com>
References: <20240222185434.GA24540@bhelgaas>
	 <057c9a17-bbf2-49c5-b7ee-d3357d5b5100@linux.intel.com>
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

On Thu, 2024-02-22 at 11:54 -0800, Kuppuswamy Sathyanarayanan wrote:
>=20
> On 2/22/24 10:54 AM, Bjorn Helgaas wrote:
> > On Thu, Feb 22, 2024 at 10:20:06AM -0800, Kuppuswamy Sathyanarayanan wr=
ote:
> > > On 2/22/24 9:44 AM, Vidya Sagar wrote:
> > > > Many PCIe device drivers save the configuration state of their
> > > > respective
> > > > devices during probe and restore the same when their 'slot_reset' h=
ook
> > > > is called through PCIe Error Recovery Handler.
> > > >=20
> > > > If the system has a change in ASPM policy after the driver's probe =
is
> > > > called and before error event occurred, 'slot_reset' hook restores =
the
> > > > PCIe configuration state to what it was at the time of probe but no=
t to
> > > > what it was just before the occurrence of the error event.
> > > > This effectively leads to a mismatch in the ASPM configuration betw=
een
> > > > the device and its upstream parent device.
> > > >=20
> > > > Update the saved configuration state of the device with the latest =
info
> > > > whenever there is a change w.r.t ASPM policy.
> > > >=20
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > ---
> > > > V4:
> > > > * Rebased on top of pci/aspm branch
> > > >=20
> > > > V3:
> > > > * Addressed sathyanarayanan.kuppuswamy's review comments
> > > >=20
> > > > V2:
> > > > * Rebased on top of the tree code
> > > > * Addressed Bjorn's review comments
> > > >=20
> > > > =C2=A0drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++++--
> > > > =C2=A03 files changed, 28 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index cfc5b84dc9c9..3db606ba9344 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -1648,7 +1648,7 @@ static int pci_save_pcie_state(struct pci_dev
> > > > *dev)
> > > > =C2=A0	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
> > > > =C2=A0	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
> > > > =C2=A0
> > > > -	pci_save_aspm_state(dev);
> > > > +	pci_save_aspm_l1ss_state(dev);
> > > > =C2=A0	pci_save_ltr_state(dev);
> > > > =C2=A0
> > > > =C2=A0	return 0;
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index b217e74966eb..9fe78eb8b07d 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -95,7 +95,7 @@ void pci_msix_init(struct pci_dev *dev);
> > > > =C2=A0bool pci_bridge_d3_possible(struct pci_dev *dev);
> > > > =C2=A0void pci_bridge_d3_update(struct pci_dev *dev);
> > > > =C2=A0void pci_aspm_get_l1ss(struct pci_dev *pdev);
> > > > -void pci_save_aspm_state(struct pci_dev *pdev);
> > > > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
> > > is this rename a review request? It is not clear from the commit log
> > > why you are doing it?
> > David's changes already on pci/aspm added pci_save_aspm_state(), but
> > it actually only saves L1SS data, and Vidya needs to save the non-L1SS
> > data also.
> >=20
> > I think I'm going to rework David's changes a little bit so this is
> > named pci_save_aspm_l1ss_state() from the beginning so we won't need
> > the rename here.

Ack

>=20
> Got it.
>=20
> Change wise, this patch looks fine to me.
>=20
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

LGTM too.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>


