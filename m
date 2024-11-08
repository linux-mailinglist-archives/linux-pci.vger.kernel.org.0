Return-Path: <linux-pci+bounces-16322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1A9C1C0D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 12:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68080281F4D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41811E2831;
	Fri,  8 Nov 2024 11:19:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5481E285C;
	Fri,  8 Nov 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064740; cv=none; b=eSr4YUcHqDU4QijD3WoWhhwX/4qghEfqnKrDfTn26sMOCe6HdhP13iLpbxwaKL/ivkDao5r0nK3wzpCDcrfpLFQ48E/rBTegxzTSx6RshRCqi70bJl/hxE7LWg2Ol35BbbYbrEAtOILXIw4vzxtnQ4Wr5I7iekfvEXu37hAfnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064740; c=relaxed/simple;
	bh=lzajTq3NPaWceLttO7cSJGMerS6oHXpB7S54deIwj4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfn4PjEN03lsJs+9rYvXI/kiNVFnjgvLgj527JX7Dss8OjhkAm1Ivq7K1Z2n/phALwZXoLPhhHa1AOUvc3fUOz9ueD9Fwiy/IHhjNsLnhes7Z8FHB+6ixyVtMU0fTmVFF0izehLWBClraMYGKBSl/6aKSGhPwH4ndy1Tlm1IA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 388BE102CFECE;
	Fri,  8 Nov 2024 12:11:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1035C31BA42; Fri,  8 Nov 2024 12:11:57 +0100 (CET)
Date: Fri, 8 Nov 2024 12:11:57 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>, bhelgaas@google.com,
	macro@orcam.me.uk, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC] PCI: Fix the issue of link speed downgrade after link
 retraining
Message-ID: <Zy3x_QK0vZHOFZvF@wunner.de>
References: <20241107143758.12643-1-guojinhui.liam@bytedance.com>
 <20241107153438.GA1614749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107153438.GA1614749@bhelgaas>

[+cc Maciej, Ilpo]

On Thu, Nov 07, 2024 at 09:34:38AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2024 at 10:37:58PM +0800, Jinhui Guo wrote:
> > The link speed is downgraded to 2.5 GT/s when a Samsung NVMe device
> > is hotplugged into a Intel PCIe root port [8086:0db0].
> > 
> > ```
> > +-[0000:3c]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
> > |           ...
> > |           +02.0-[3d]----00.0  Samsung Electronics Co Ltd Device a80e
> > ```
> > 
> > Some printing information can be obtained when the issue emerges.
> > "Card present" is reported twice via external interrupts due to
> > a slight tremor when the Samsung NVMe device is plugged in.
> > The failure of the link activation for the first time leads to
> > the link speed of the root port being mistakenly downgraded to 2.5G/s.
> > 
> > ```
> > [ 8223.419682] pcieport 0000:3d:02.0: pciehp: Slot(1): Card present
> > [ 8224.449714] pcieport 0000:3d:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
> > [ 8225.518723] pcieport 0000:3d:02.0: pciehp: Slot(1): Card present
> > [ 8225.518726] pcieport 0000:3d:02.0: pciehp: Slot(1): Link up
> > ```
> > 
> > To avoid wrongly setting the link speed to 2.5GT/s, only allow
> > specific pcie devices to perform link retrain.

With which kernel version are you seeing this?

A set of fixes for the 2.5GT/s retraining feature appeared in v6.12-rc1,
specifically f68dea13405c ("PCI: Revert to the original speed after PCIe
failed link retraining").

Have you tested whether the latest v6.12 rc is still affected?

Thanks,

Lukas

> > Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > ---
> >  drivers/pci/quirks.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index dccb60c1d9cc..59858156003b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -91,7 +91,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> >  	int ret = -ENOTTY;
> >  
> >  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
> > -	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> > +	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting ||
> > +		!pci_match_id(ids, dev))
> >  		return ret;
> >  
> >  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> > @@ -119,8 +120,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> >  	}
> >  
> >  	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> > -	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> > -	    pci_match_id(ids, dev)) {
> > +	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
> >  		u32 lnkcap;
> >  
> >  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> > -- 
> > 2.20.1

