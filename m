Return-Path: <linux-pci+bounces-17055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764309D191F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 20:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DEE1F222E3
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5E1E5707;
	Mon, 18 Nov 2024 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2sKH08it"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25EE1E0DE4;
	Mon, 18 Nov 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959015; cv=none; b=qYskSiY5AM30wSkD+BqcO9rIxZsyE5/6URaHf4nluF0htZcCUV5kHE8D5t5gLG7nasiz5aMIAVntCHbwI7Mc70NhwE+IyJJYtCDOlOg7Xd5Z83CybBT9e32/q1f4gT+P/36YzL3CbWld66kzIduRW0nakFqo0JwzOw6zystgbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959015; c=relaxed/simple;
	bh=0yyNtGrtp5cznIl8PmecqNaoNU9ksI8Py8SDmIoGkto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP+JojxB6Jlv39IlzaMBXCYmUmfl3wWlHyKPiPv1ggLA+1Qgx1fXVIgh1c5X1YlWmmPpPVX3aE09rcSJRNac22oGJOLCjLsuKsH847egHTaLqgles1cgUTql+lnPK1+ro3rPT4PdpePvi2lp9ndKIH8xUqKYM00ObVnVRXxuxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2sKH08it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595B9C4CECC;
	Mon, 18 Nov 2024 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731959014;
	bh=0yyNtGrtp5cznIl8PmecqNaoNU9ksI8Py8SDmIoGkto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2sKH08itkqIS2AZZMbFkXCvzv+0XTQV+w4wplqLeNd3XdpKwnhvRrx/OM+SE4NgJa
	 ZVjqAemKbKqBNhpOBqoFKflcIrEwG7tOB6fHDN1ttbjxAvAyCh3EeMKOTj3IhK7Apc
	 LOXlX/uarf+KOgA+A074KGm0u8JWBqanpz5M2X6I=
Date: Mon, 18 Nov 2024 20:43:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Peraza <jperaza@google.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com,
	dwmw2@infradead.org, helgaas@kernel.org,
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org,
	joro@8bytes.org, jsbarnes@google.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
	oohall@gmail.com, pavel@denx.de, rafael.j.wysocki@intel.com,
	rafael@kernel.org, rajatja@google.com, rajatxjain@gmail.com,
	will@kernel.org
Subject: Re: [v8 PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Message-ID: <2024111818-molecule-pedicure-db1b@gregkh>
References: <20241118193024.2695876-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118193024.2695876-1-jperaza@google.com>

On Mon, Nov 18, 2024 at 07:30:22PM +0000, Joshua Peraza wrote:
> This patchset rebases two previously posted patches supporting
> recognition of Microsoft's DmaProperty.
> 
> v8: Joshua renames untrusted_dma to requires_dma_protection and updates
> some comments, reducing use of the word "trust" to refer to PCI devices
> and matching the word choice in Microsoft's documentation.

So this is the "clarity"?  I'm not sold, sorry.  Again, did you look at
the previous discussions we had about this name?  We don't have to use
Microsoft's term here as it is used differently by Linux today, right?
If you really want to support the DmaProperty, why not just support that
with a new bit as that's something different here, right?

Again, look at what this is supposed to be conveying.  They ability to
DMA to anywhere isn't really the root issue here, or is it?  What is the
threat model you are trying to mitigate?

> v7: Rajat updates a comment with Robin's suggestion. Joshua re-sends and
> Greg requests clarity and documentation on why untrusted_dma is the
> right name.
> 
> v6: Rajat renames pci_dev_has_dma_property and links to Microsoft's
> documentation in the commit message. Robin suggests clarifying a
> comment.
> 
> v5: Rajat changes the name to untrusted_dma. Bjorn suggesting changing
> another function's name pci_acpi_check_for_dma_protection to
> pci_dev_has_dma_property and seeks clarified documentation.
> 
> v4: Rajat changes the name to poses_dma_risk. Christoph suggests this
> name doesn't capture the intent as well as untrusted_dma and Rafael
> agrees.
> 
> v1,v2,v3: Greg suggests that (un)trusted is the wrong word for referring
> to PCI devices, recommending a name something like "platform wants to
> protect dma access for this device."

Or is it?  I said this when?  Just how old is this patch series?

confused,

greg k-h

