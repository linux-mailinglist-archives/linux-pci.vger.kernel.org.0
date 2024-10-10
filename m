Return-Path: <linux-pci+bounces-14238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9D9994F0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707FD1F2402A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AFE1E47CE;
	Thu, 10 Oct 2024 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eae/Cu9v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AB1E2839;
	Thu, 10 Oct 2024 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598070; cv=none; b=YnxcmHztYgjYHTrm7eOJ5AFOCgLd0MDfgzNpeKSXj7lhjg7cFphMhC0rTaiJZsqUJ0XGsgdwGc4Nih4vsZVhT15frsog2KDHJdCH+hdGxSNKRt0eHxeHLjrGVE/f2suGM2BlnpsLf4sVe/Hs860O0SE9LmogA6WBFngbbQmr2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598070; c=relaxed/simple;
	bh=00l5K9SfK1hW5HpyRetxiwRtURhebXZza77EpqLIza4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RcltIdicutAkR5IxQ3Iv8jwXxV5VpsE6RkBZlS1ujmELCXT5gfHzY5Jj9FwPrZviOZ7hD2beL00RenfGkgLBwBu7I9BrGNu3fxM6dMjcAvjcVrmNINTSMSEHgpVs2C8R+XGqZyF+vz5vPib+Ro9fRBJdmuv5tK65vsSvprRoeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eae/Cu9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0884BC4CEC5;
	Thu, 10 Oct 2024 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728598069;
	bh=00l5K9SfK1hW5HpyRetxiwRtURhebXZza77EpqLIza4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eae/Cu9vBaBKBo6XIMSl6WoFREPmJgo+TzxFgjgvpThDZgr+Rdvd0xY8odAvDvep5
	 iFnWblkpvZ8TaxOIc+p1cNkl5WW9H2Tog4ti3FArjiGwPiG50LemcZ0Cx9z1mwKu70
	 KqGrCC8o5N+j/JHFXsCOSNGb4eK5Db1WpWre3NxymgnA1FjBtfNlUYAdPDEZZaEG0X
	 kheUm6pIQpVAsaDb8l9ywUE/8cKiyXKy9lnwQIo8Z5bn/6DBHK5XyMRggwmHA7HehI
	 CjlS5O3R8yUjQB/fYiZWCHbY8zBdv4Ujs5KxpogKdQ9qQAZ9ATt3AFvQ+XLRZrOoHl
	 6wCghtYRXpwpg==
Date: Thu, 10 Oct 2024 17:07:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] PCI: Constify pci_register_io_range() fwnode_handle
Message-ID: <20241010220747.GA579765@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-1-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:14AM -0500, Rob Herring (Arm) wrote:
> pci_register_io_range() does not modify the passed in fwnode_handle, so
> make it const.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Please ack and I'll take with the rest of the series.

Thank you!

> ---
>  drivers/pci/pci.c   | 2 +-
>  include/linux/pci.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2..4b102bd1cfea 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4163,7 +4163,7 @@ EXPORT_SYMBOL(pci_request_regions_exclusive);
>   * Record the PCI IO range (expressed as CPU physical address + size).
>   * Return a negative value if an error has occurred, zero otherwise
>   */
> -int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
> +int pci_register_io_range(const struct fwnode_handle *fwnode, phys_addr_t addr,
>  			resource_size_t	size)
>  {
>  	int ret = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..11421ae5c558 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1556,7 +1556,7 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
>  			void *alignf_data);
>  
>  
> -int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
> +int pci_register_io_range(const struct fwnode_handle *fwnode, phys_addr_t addr,
>  			resource_size_t size);
>  unsigned long pci_address_to_pio(phys_addr_t addr);
>  phys_addr_t pci_pio_to_address(unsigned long pio);
> 
> -- 
> 2.45.2
> 

