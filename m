Return-Path: <linux-pci+bounces-10009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB8292C024
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3651C239C4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A211B4C3A;
	Tue,  9 Jul 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsryhlAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812581B47C6;
	Tue,  9 Jul 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542116; cv=none; b=JcCSnbuIBtXg16cPl/3Cz6gtzif6amXLlXX25MQ1tHA/WKRiILvsuXET5/RMU+jteF3vGaFTZlU+0ozVPDACHhedEB+g1wIziQxoiQ+NbaKcdjDE5rYlNF7UNc90vPKMxanO0LiDZ2aVtPbCC/ArUq+KidRfttziuvVyYcJQ2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542116; c=relaxed/simple;
	bh=9Gcw21XytUn5kvBs9uu7DBexRcY56exFFjtUr3t699k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LR2eBEqBvjNk0c+dC1+Kz12ijmRw0e4QItTij5nmZNmA8nsob2qlav+itKPXV3gMeroxHpcDSP2U1CY3s+kLEBxHsNr95aAOQ8PDeoGPvCRNuta8M40uSRMj9C9egWrN1g8IpTq2/v6uF/8s1EkNZ6m1sf9kSF6pkAS9D6bhyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsryhlAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38363C32782;
	Tue,  9 Jul 2024 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542116;
	bh=9Gcw21XytUn5kvBs9uu7DBexRcY56exFFjtUr3t699k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fsryhlAU8McMtVI0ObeJxYWgTWf3CZ+c3jtBxSQ0lvW4w31TM72q1Vra5slo085y6
	 HyuwO6rW9GvZ+Qj9IDGSjAM7prFMNbVFZnN1vmYgtQZpKF501gayYCHQJ2Nbhi77C7
	 rX1gOlqqiV4yzP6/WYRisT/NQGr2aWjBfM1/W8U6iTkPnbTI8wpZgA5A8eQjY++G31
	 4AmqRBd3vEHOejCeHFBP66VWvPeF0jVFHuZrIELtYhp586/Txg3HgwDx6gDq4tAvl1
	 dGdpvJ7nJoYWHoxcEuGmGfci23P6hXShiQHEwCWO33yXWK8LJ5aJ8R0MGJPdy5xTbE
	 E4RrqgZ/8JGog==
Date: Tue, 9 Jul 2024 11:21:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] PCI: align small (<4k) BARs
Message-ID: <20240709162154.GA175839@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709133610.1089420-7-stewart.hildebrand@amd.com>

On Tue, Jul 09, 2024 at 09:36:03AM -0400, Stewart Hildebrand wrote:
> Issues observed when small (<4k) BARs are not 4k aligned are:
> 
> 1. Devices to be passed through (to e.g. a Xen HVM guest) with small
> (<4k) BARs require each memory BAR to be page aligned. Currently, the
> only way to guarantee this alignment from a user perspective is to fake
> the size of the BARs using the pci=resource_alignment= option. This is a
> bad user experience, and faking the BAR size is not always desirable.
> See the comment in drivers/pci/pci.c:pci_request_resource_alignment()
> for further discussion.

Include the relevant part of this discussion directly here so this log
is self-contained.  Someday that function will change, which will make
this commit log less useful.

> 2. Devices with multiple small (<4k) BARs could have the MSI-X tables
> located in one of its small (<4k) BARs. This may lead to the MSI-X
> tables being mapped in the same 4k region as other data. The PCIe 6.1
> specification (section 7.7.2 MSI-X Capability and Table Structure) says
> we probably shouldn't do that.
> 
> To improve the user experience, and increase conformance to PCIe spec,
> set the default minimum resource alignment of memory BARs to 4k. Choose
> 4k (rather than PAGE_SIZE) for the alignment value in the common code,
> since that is the value called out in the PCIe 6.1 spec, section 7.7.2.
> The new default alignment may be overridden by arches by implementing
> pcibios_default_alignment(), or by the user with the
> pci=resource_alignment= option.
> 
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> Preparatory patches in this series are prerequisites to this patch.
> ---
>  drivers/pci/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9f7894538334..e7b648304383 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6453,7 +6453,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
>  
>  resource_size_t __weak pcibios_default_alignment(void)
>  {
> -	return 0;
> +	/*
> +	 * Avoid MSI-X tables being mapped in the same 4k region as other data
> +	 * according to PCIe 6.1 specification section 7.7.2 MSI-X Capability
> +	 * and Table Structure.
> +	 */
> +	return 4 * 1024;
>  }
>  
>  /*
> -- 
> 2.45.2
> 

