Return-Path: <linux-pci+bounces-26002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC48A906A2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A601318933F4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C821B87E9;
	Wed, 16 Apr 2025 14:38:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6913010C;
	Wed, 16 Apr 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814293; cv=none; b=oCknJtX1dPH5a/Tpg0/okE6gaY71g+FfN11eTwsInGVmqZ2onHDLgpjsODJOCwCoHGAN4yFX0TP9+TAlwLcpE53KjO0t9+w40B25WHTChj+QUEf/DprggD1gavXgiuN/cuQh69bWnhMP/vCfoT8w6iVAH73RYm8ryGWZx9GRXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814293; c=relaxed/simple;
	bh=doVRRvVe6WEmfRp+vwpcnTHqA9pAD2XGe1+hyb7lzFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMCPXb/+sZjiIwq88AxVGG0wMzCpo+IMJQ/nerwrc7uIep2MUiH3OLnnZ0diGj7L5nH4trFF6GjuAoWbVE4TFfNjsgmdbQuYPQJksmHZXe6HZdcA0I+YH+OdJ0orlUQMJ+JOwdGT3I+unSEr1QUTkWnh+6Rt6w69MvkwLrZ/3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E372F2C06039;
	Wed, 16 Apr 2025 16:38:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D4BF0173A2F; Wed, 16 Apr 2025 16:38:01 +0200 (CEST)
Date: Wed, 16 Apr 2025 16:38:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	dingwei@marvell.com, cassel@kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/ERR: Add support for resetting the slot in a
 platforms specific way
Message-ID: <Z__AyQeZmXiNwT7c@wunner.de>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
 <20250404-pcie-reset-slot-v1-2-98952918bf90@linaro.org>
 <Z--cY5Uf6JyTYL9y@wunner.de>
 <3dokyirkf47lqxgx5k2ybij5b5an6qnceifsub3mcmjvzp3kdb@sm7f2jxxepdc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dokyirkf47lqxgx5k2ybij5b5an6qnceifsub3mcmjvzp3kdb@sm7f2jxxepdc>

On Tue, Apr 15, 2025 at 07:03:17PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 04, 2025 at 10:46:27AM +0200, Lukas Wunner wrote:
> > On Fri, Apr 04, 2025 at 01:52:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > When the PCI error handling requires resetting the slot, reset it
> > > using the host bridge specific 'reset_slot' callback if available
> > > before calling the 'slot_reset' callback of the PCI drivers.
> > > 
> > > The 'reset_slot' callback is responsible for resetting the given slot
> > > referenced by the 'pci_dev' pointer in a platform specific way and
> > > bring it back to the working state if possible. If any error occurs
> > > during the slot reset operation, relevant errno should be returned.
> > 
> > This feels like something that should be plumbed into
> > pcibios_reset_secondary_bus(), rather than pcie_do_recovery().
> 
> I did consider that, but didn't go for it since there was no platform
> reset code present in that function. But I will try to use it as I
> don't have a strong preference to do reset slot in pcie_do_recovery().

The only platform overriding pcibios_reset_secondary_bus() is powerpc,
and it only does that on PowerNV.

I think you could continue to stick with the approach of adding a
->reset_slot() callback to struct pci_host_bridge, but it would
be good if at the same time you could convert PowerNV to use the
newly introduced callback as well.  And then remove the way to
override the reset procedure via pcibios_reset_secondary_bus().

All pci_host_bridge's which do not define a ->reset_slot() could be
assigned a default callback which just calls pci_reset_secondary_bus().

Alternatively, pcibios_reset_secondary_bus() could be made to invoke the
pci_host_bridge's ->reset_slot() callback if it's not NULL, else
pci_reset_secondary_bus().  And in that case, the __weak attribute
could be removed as well as the powerpc-specific version of
pcibios_reset_secondary_bus().

I guess what I'm trying to say is, you don't *have* to plumb this
into pcibios_reset_secondary_bus().  In fact, having a host bridge
specific callback could be useful if the SoC contains several
host bridges which require different callbacks to perform a reset.

I just want to make sure that the code remains maintainable,
i.e. we don't have two separate ways to override how a bus reset
is performed.

Thanks,

Lukas

