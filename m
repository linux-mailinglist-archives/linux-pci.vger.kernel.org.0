Return-Path: <linux-pci+bounces-18484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C19F2A44
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A086188489E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D0182;
	Mon, 16 Dec 2024 06:45:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD227A48
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331546; cv=none; b=jaONsoRulfNQt1T5+hfWR6U/rvyCQzm76ZCXaf15lSuV6IqhJznpQB2VHZNRBug9p6khtS8qnX9iunsuhf1bIRYldDUADhVh2mJR3FvoHj7V+ZE29KCplHUvc0fDwXOQfI0nLGWdIh1xlGWgXP5bW25VQcT3+3ieEsJlLY2KeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331546; c=relaxed/simple;
	bh=9BueBnQki/AAW6UW/r1n5zHlW5BqQwQiM+tdbjvX7Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJZxsl/jebw3/n8GG0rHe6JuxLjqwbYBemyq5ddHudY7mViWIErck2jL1s8FQwQgw0L3n+5J1cjQL0g5fI5SnJ4auGobxqyVFP6IieIf6W7pSEBgTUtR2ox6jz1W8eWGKAXg9Or13AkOrt+q7W3tNzwe/LDwKtScwDY0UFFZnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7E23D30001EA0;
	Mon, 16 Dec 2024 07:45:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6AF794A8153; Mon, 16 Dec 2024 07:45:39 +0100 (CET)
Date: Mon, 16 Dec 2024 07:45:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <niks@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v2 1/3] PCI: Assume 2.5 GT/s if Max Link Speed
 is undefined
Message-ID: <Z1_MkwPmT_5axOGh@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
 <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
 <6ccb04cb47da39770e62ebf3f540698e4412ae0a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccb04cb47da39770e62ebf3f540698e4412ae0a.camel@kernel.org>

On Sun, Dec 15, 2024 at 10:17:46PM +0100, Niklas Schnelle wrote:
> On Sun, 2024-12-15 at 11:20 +0100, Lukas Wunner wrote:
> > Broken PCIe devices may not set any of the bits in the Link Capabilities
> > Register's "Max Link Speed" field.  Assume 2.5 GT/s in such a case,
> > which is the lowest possible PCIe speed.  It must be supported by every
> > device per PCIe r6.2 sec 8.2.1.
[...]
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6233,6 +6233,13 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
> >  	u32 lnkcap2, lnkcap;
> >  	u8 speeds;
> >  
> > +	/* A device must support 2.5 GT/s (PCIe r6.2 sec 8.2.1) */
> > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > +	if (!(lnkcap & PCI_EXP_LNKCAP_SLS)) {
> > +		pci_info(dev, "Undefined Max Link Speed; assume 2.5 GT/s\n");
> > +		return PCI_EXP_LNKCAP2_SLS_2_5GB;
> > +	}
> > +
> >  	/*
> >  	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
> >  	 * Speeds Vector to allow using SLS Vector bit defines directly.
> 
> I feel like this patch goes a bit against the idea of this being more
> future proof. Personally, I kind of expect that any future devices
> which may skip support for lower speeds would start with skipping 2.5
> GT/s and a future PCIe spec might allow this.
> 
> In that case with the above code we end up assuming 2.5 GT/s which
> won't work while the Supported Link Speeds Vector could contain
> supported speeds with the assumption that when in doubt software relies
> on that (PCIe r6.2 sec 7.5.3.18) and it might even be future spec
> conformant.
> 
> So I think instead of assuming 2.5 GT/s I was thinking of something
> like the diff below (on top of this series).
[...]
> @@ -6238,10 +6235,11 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	 */
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>  	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> -
>  	/* Ignore speeds higher than Max Link Speed */
> -	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS,
> -			  PCI_EXP_LNKCAP2_SLS_2_5GB);
> +	if (max_bits)
> +		speeds &= GENMASK(max_bits, PCI_EXP_LNKCAP2_SLS_2_5GB);
> +	else
> +		pci_info(dev, "Undefined Max Link Speed; relying on LnkCap2\n");

I see.  Right now assuming 2.5 GT/s is the most conservative approach.
We may have to revisit this once the PCIe spec does allow gaps in the
Supported Link Speeds.  Then again, I'm not aware of any broken devices
that actually *have* an undefined Max Link Speed, so this patch is a
safety measure to avoid the GENMASK() inversion in patch [2/3].

Thanks,

Lukas

