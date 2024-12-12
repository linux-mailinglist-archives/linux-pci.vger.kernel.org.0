Return-Path: <linux-pci+bounces-18347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C253D9EFF0A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 23:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D725B163F66
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3631DAC83;
	Thu, 12 Dec 2024 22:14:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AF189B91
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041644; cv=none; b=LD4Lf6fit7+zoc7XxrtdqZlTho533wYYOasUHZiy5fY6jdeTl+Rc/SUppBJKPNWCBefHmjdRkK55HvnLb7PMFyS+k7REk9K1/IM6//ryePpClkNp5RXODrGoSlVLciB43jnaKtPLvQp9e/XrnVu+lLnJ5nkzMHP2p6RYN8kvlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041644; c=relaxed/simple;
	bh=TDpUgAcSptc94rpoyHMZE2ZBXsvm2I7tYMCoQrcYIVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1U+/hjsVuXL1BdfgCnWQJJiaMsdxpuUFBi8vknU6yfAXxagKCQKx8G4evQc/s4SpTwdK9iWtrTLLRLgLsJX7tjVPHyc/3x5dSRWzbokj/61gj7xLPqjO5i3eSHyq61YXCExPWKuccn4vONcD3sFLUE7l78SKqpcVk/IgR3s8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C4429300000A6;
	Thu, 12 Dec 2024 23:13:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AE4422109C6; Thu, 12 Dec 2024 23:13:58 +0100 (CET)
Date: Thu, 12 Dec 2024 23:13:58 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Niklas Schnelle <niks@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
Message-ID: <Z1tgJoTRnldq8NYE@wunner.de>
References: <e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
 <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com>

On Thu, Dec 12, 2024 at 04:33:23PM +0200, Ilpo Järvinen wrote:
> On Thu, 12 Dec 2024, Lukas Wunner wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
> >  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> >  	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> >  
> > +	/* Ignore speeds higher than Max Link Speed */
> > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > +	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
> 
> Why do you start GENMASK() from 0th position? That's the reserved bit.
> (I doesn't exactly cause a misbehavior to & the never set 0th bit but
> it is slightly confusing).

GENMASK() does a BUILD_BUG_ON(l > h) and if a broken PCIe device
does not set any bits in the PCI_EXP_LNKCAP_SLS field, I'd risk
doing a GENMASK(0, 1) here, fulfilling the l > h condition.

Granted, the BUILD_BUG_ON() only triggers if l and h can be
evaluated at compile time, which isn't the case here.

Still, I felt uneasy risking any potential future breakage.
Including the reserved bit 0 is harmless because it's forced to
zero by the earlier "speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS"
expression.


> I suggest to get that either from PCI_EXP_LNKCAP2_SLS_2_5GB or 
> PCI_EXP_LNKCAP2_SLS (e.g. with __ffs()) and do not use literal at all
> to make it explicit where it originates from.

Pardon me for being dense but I don't understand what you mean.

Thanks,

Lukas

