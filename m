Return-Path: <linux-pci+bounces-18361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2BB9F077A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 10:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DAC164B96
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10BC1B0F2E;
	Fri, 13 Dec 2024 09:16:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F51AF0C4
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081385; cv=none; b=aDMRfxhFqfOiJ6z/dhf3eKSHaj3F6gb9ASJqReaHWUOXW4C4lxLrCXvDHcq6xMF1z3FJW5/xN0RohPvMFNYs4lrpyVSfaLTwT5fEuiwPWUCrxP5rMMs5Zo8cDm2GetvjNEqChUl/1veJQQvP1K5cSjPwwm2vTcd4noatggZOTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081385; c=relaxed/simple;
	bh=UtWAH8NJFWVtJPto0HfM6O5eHub/C6BxMzJi6+gBBC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4mDvirEGiXEc/GJBAa1rf6l+rPQqWvhfWhP7gBZGIZ3Pm+K31aommR/XZKZif85RIwvo8M59QHolw+u0V+a5Ez8holMQx9Lo016l/Q2IiJVffrWSGRtazd0K0JEXg1lx9tHYDn2EbN0zt1XH37LaHVeeQ6PHbMu/qpLlp8T830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id BEA612800B6EB;
	Fri, 13 Dec 2024 10:16:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AC8D23210B8; Fri, 13 Dec 2024 10:16:19 +0100 (CET)
Date: Fri, 13 Dec 2024 10:16:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
Message-ID: <Z1v7Y2L1ovwRJnxK@wunner.de>
References: <e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
 <20241212161103.GA3345227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212161103.GA3345227@bhelgaas>

On Thu, Dec 12, 2024 at 10:11:03AM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 12, 2024 at 09:56:16AM +0100, Lukas Wunner wrote:
> > The Supported Link Speeds Vector in the Link Capabilities 2 Register
> > indicates the *supported* link speeds.  The Max Link Speed field in
> > the Link Capabilities Register indicates the *maximum* of those speeds.
> > 
> > Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderbolt
> > controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as maximum.
> > Ilpo recalls seeing this inconsistency on more devices.
> > 
> > pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> > and will thus incorrectly deem higher speeds as supported.  Fix it.
> > 
> > Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> > Reported-by: Niklas Schnelle <niks@kernel.org>
> > Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org/
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Looks like you want this in v6.13?  Can we make commit log more
> explicit as to why we need it there?  Is this change enough to resolve
> the boot hang Niklas reported?

This is more like a "we're not conforming to the spec" kind of fix,
but also happens to be a prerequisite to fixing Niklas' boot hang.

Another user-visible issue addressed here is that we're exposing an
incorrect value in the sysfs "max_link_speed" attribute on devices
such as the JHL7540 Thunderbolt controller mentioned in the commit
message.

Thanks,

Lukas

> > ---
> >  drivers/pci/pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 35dc9f2..b730560 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
> >  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> >  	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> >  
> > +	/* Ignore speeds higher than Max Link Speed */
> > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > +	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
> > +
> >  	/* PCIe r3.0-compliant */
> >  	if (speeds)
> >  		return speeds;
> >  
> > -	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > -
> >  	/* Synthesize from the Max Link Speed field */
> >  	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
> >  		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
> > -- 
> > 2.43.0

