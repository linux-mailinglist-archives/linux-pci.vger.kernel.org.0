Return-Path: <linux-pci+bounces-33753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A1B20C91
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E97C6813FE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF422DEA73;
	Mon, 11 Aug 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh2nbCeb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9AF25743D;
	Mon, 11 Aug 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923387; cv=none; b=RkICAHaVdm7gqh6XHCUOVjRHheX2mvoRJnLimP6lm5fcJLmIwMm45qVOe6KA7IgUK+py6GM0z7Iw0/tFcgnOvJg1FKc9wMBmjehXP4iDmeH+L0a/1MNbpsFNk/x1kT9FhpdrLtoEqiKO5zE//gmKhNBRizoIsQ20aWfqYuyYJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923387; c=relaxed/simple;
	bh=me89jiMprQ5Zfiw9QonH62Pq97r457WJa6dHcXh9NPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIQRdNlinOa/4l+boSdP1VTJiNAr08thJpcyTMMWMGyIxOBoEIOrhcAq9kV2SxTrpj6t4nlKu5E6Ju4UYyxEwejB/ONfM2ComLYCTsUEKsbTnPw2QCCvYPw8duNXWDJRk5jBNY9eE/r/EWWHMZO+HvfpRtkVnbyk5Qq4WoqUtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh2nbCeb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754923386; x=1786459386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=me89jiMprQ5Zfiw9QonH62Pq97r457WJa6dHcXh9NPk=;
  b=Rh2nbCebKa+PEnSV+G31SLtvFIssv562mKIPOca23tr/V1KakMvWvaQ8
   cHl19j3p6FYnKHYfYgoBufxza0rfXy+BbVyeNj1ro2atf0s7VF3HztTZG
   KXcCfFW0IjcyMEOT1bdctDbi6UepSwQ/FT8vfFv0XsGvVAFBuCPPUWMi1
   HrkDIh0RxGP2MFfRFG9bgnz04ob4i1VzshWXQTZQWLBJVVfmunjgHHi/Y
   x8sp4imvMZAbE8vTNz1pIhkvtaPATSAa9go1dQ7fVrnFErWyyZBekEb7P
   mmsH0A3H1vW31WZdA8jJcJDUqTGCYYdcc5N9CSCa0bjCItz82x3RD2DrS
   g==;
X-CSE-ConnectionGUID: UFyMPzLjRZK8B8EviDJGnA==
X-CSE-MsgGUID: t6BN4IZ8QV6UmjQyz5rw2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="60979444"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60979444"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 07:43:05 -0700
X-CSE-ConnectionGUID: uUJwsGcLSpa/qUF38eVxZA==
X-CSE-MsgGUID: EpLjJDPRSZe32SqLyedxFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165566177"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 11 Aug 2025 07:43:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B0FD194; Mon, 11 Aug 2025 16:43:00 +0200 (CEST)
Date: Mon, 11 Aug 2025 16:43:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH 3/4] irqchip/sg2042-msi: Fix broken affinity setting
Message-ID: <aJoBdHlV6ZKcFry5@black.igk.intel.com>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807112326.748740-4-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 07, 2025 at 07:23:24PM +0800, Inochi Amaoto wrote:
> When using NVME on SG2044, the NVME always complains "I/O tag XXX
> (XXX) QID XX timeout, completion polled", which is caused by the
> broken handler of the sg2042-msi driver.
> 
> As PLIC driver can only setting affinity when enabling, the sg2042-msi
> does not properly handled affinity setting previously and enable irq in
> an unexpected executing path.
> 
> Since the PCI template domain supports irq_startup/irq_shutdown, set
> irq_chip_[startup/shutdown]_parent for irq_startup/irq_shutdown. So
> the irq can be started properly.

> Fixes: e96b93a97c90 ("irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller")
> Reported-by: Han Gao <rabenda.cn@gmail.com>

Closes ?

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

...

>  #define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> -				   MSI_FLAG_USE_DEF_CHIP_OPS)
> +				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
> +				   MSI_FLAG_PCI_MSI_MASK_PARENT |\

Can we indent \ to be on the same column (using TABs)?

> +				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)

...

>  #define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> -				   MSI_FLAG_USE_DEF_CHIP_OPS)
> +				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
> +				   MSI_FLAG_PCI_MSI_MASK_PARENT |\
> +				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)

Ditto.

-- 
With Best Regards,
Andy Shevchenko



