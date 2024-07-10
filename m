Return-Path: <linux-pci+bounces-10079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F6392D38C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 15:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5119B2623A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E0193090;
	Wed, 10 Jul 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6oiQjnY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7A193084;
	Wed, 10 Jul 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619783; cv=none; b=JJ1nAubXItIIaISwVZkrYijVGjoP/citWvXswJSqIvUG5d8owXwZZ2CiqACl5NdM6nlsrJLnVPiWLWi733mdbxMEGciZ27BW9UAgk0N5Dsz+MHmMv5ffC1mVzHvQvBujxW1kfle9sEAiAs+yHtv9OIM1EZNEC5Nae8CHQYQcHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619783; c=relaxed/simple;
	bh=fuXMVkWyrerG/1nXJKcGST2x4v3d06yRSgKfepDkGY8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SHQNb9tDj+w+gAfZg/GvRJF14MH01jTpoxBfoOlpvwNbmd53bQ5hGlV3ResW4mIlP+mXNQQxAseGMkebpFJkRflbrnzxokJ1FOsmcWaZTxKSI/V/3AXt0GZm4ZjY+WUB5lt3zjhKHyVZcIT7Z2lAaeiqWg/HJWmTkOddybQxi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6oiQjnY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720619782; x=1752155782;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fuXMVkWyrerG/1nXJKcGST2x4v3d06yRSgKfepDkGY8=;
  b=e6oiQjnYfUQZeblyJLKHl1TmKiY3QCfgC8OOFUWJXrxT3LDFTTIa0gRJ
   dazzB1Ts/roXiUKCQnfjbO2ljQQ16Pavm5TtQboStq0HU1ZXOzEpDiuNp
   dV+aQ2/dZd7SZPNRPcPp4h2r9LJ+lvyHLw+q/ZPDb8q2K5YZd8G2k/xbV
   Eh1o+k3gUJoVmNL6sREJ+GDjkxK/c8Jx1FStVD+XksnBY8XSY3s0IK/Xt
   1CWLfXDyTp++MsIJ7vnMDlB559tTc1LGHMOPlgTnHWOB4lqO8rMyOXISo
   iqbul1rACD0GVoSZ9ndNY8d2jGscUgnnsypceyD+Q8Byh/tzp9EuuUo1V
   g==;
X-CSE-ConnectionGUID: odiyrHWBQmGKVC2O2l+ZLg==
X-CSE-MsgGUID: rDSjfWZVRCikiayJ9MmgjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17640577"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17640577"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:56:21 -0700
X-CSE-ConnectionGUID: NBZCDRhkSpWq9hiCLl4gPA==
X-CSE-MsgGUID: nrSqZ0R0TYqnxSpVmBbP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48103461"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.125])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:56:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Jul 2024 16:56:15 +0300 (EEST)
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] PCI: align small (<4k) BARs
In-Reply-To: <20240709133610.1089420-7-stewart.hildebrand@amd.com>
Message-ID: <302bd9a7-41cb-7b04-4acd-a4a96d5dfe2f@linux.intel.com>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com> <20240709133610.1089420-7-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jul 2024, Stewart Hildebrand wrote:

> Issues observed when small (<4k) BARs are not 4k aligned are:
> 
> 1. Devices to be passed through (to e.g. a Xen HVM guest) with small
> (<4k) BARs require each memory BAR to be page aligned. Currently, the
> only way to guarantee this alignment from a user perspective is to fake
> the size of the BARs using the pci=resource_alignment= option. This is a
> bad user experience, and faking the BAR size is not always desirable.
> See the comment in drivers/pci/pci.c:pci_request_resource_alignment()
> for further discussion.
> 
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

SZ_4K

+ add #include for it if its not yet included by the .c file.

-- 
 i.


