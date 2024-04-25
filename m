Return-Path: <linux-pci+bounces-6679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70C8B2A75
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 23:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A18281292
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753D41552F5;
	Thu, 25 Apr 2024 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVTBTsUw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D041552EE
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079435; cv=none; b=P9E72b8rYnFk1lfeEJD9o17PAgZnJVzKZabaMmzPvRepdYG1Ir9FKAsJSf8BcSP1WM8mna763Yvgr8+Gql4GGOJkfB6VQhDF+DoBqxvlKARwF+Feywm4OlRDHCVF36YE42e06n2lsKZ2/vsF4PS4uuyofBkDafan3Hm4a97OAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079435; c=relaxed/simple;
	bh=+GuGWw0UTFC6a65lA2q0dTbNroNzyTgF7yBzJFKmW5U=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BilCn1Db16Cg+3BYnUB/XZ46Z7wITMF0TEaRziydM5JdPeAAWcxIIfAIYUJvpgi92gNIGWHN8rE92hJ7eQ+CXA5okRqK3E75fUPH43/oTh23W7aGCFWpntgJqn7hXpz0DoEZpuRcZTcr/L5+8dtYZGke3Z8pUzS6q3nVX66TSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVTBTsUw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714079434; x=1745615434;
  h=date:from:to:subject:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+GuGWw0UTFC6a65lA2q0dTbNroNzyTgF7yBzJFKmW5U=;
  b=cVTBTsUwNPFfj4fQzfWL9HitYN1isnKRuXO910tGbNovyyQ7GXjhhXKE
   IEtvMIYpCc2UbUMRiiMTid8rNFTHrVG54A+sHorzPg+s2g+fN/7ALuu9F
   CTf4SUGh5KvGRs2n8Z56Ms3phZcqoVetAQYUZ8Vsf4lcsfp9eG1gf4UnR
   o7nRnRNeNn0jURbvf4ZvbL1ey3c9M3FYdQROYFk/UD7Mc/ii1FxpnAQtB
   wPMC1RJ7XvvC+slA3hYcYKzIhi4ZA49911X5C8wOpzv9glKT5luV1jg6j
   gSU7UESelEI63s5n/jnz2ccB67cby3ST8xQXilP8AeWtyV/pwGjDeG/0G
   w==;
X-CSE-ConnectionGUID: tWbeM2JUQXiK+hqmLsjHQQ==
X-CSE-MsgGUID: dsBGoof2RWWVDGrDdXlu2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20485737"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="20485737"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 14:10:33 -0700
X-CSE-ConnectionGUID: ZrwHNSpDRwiV+SXvz2uO9A==
X-CSE-MsgGUID: Z8+hWMtGSkO47hyV4j1JSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25301729"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.132.135])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 14:10:33 -0700
Date: Thu, 25 Apr 2024 14:10:31 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: <lpieralisi@kernel.org>, <linux-pci@vger.kernel.org>,
 <paul.e.luse@intel.com>
Subject: Re: [PATCH v4] PCI: vmd: Disable MSI remap only for low MSI count
Message-ID: <20240425141031.000019d4@linux.intel.com>
In-Reply-To: <20240418153121.291534-1-nirmal.patel@linux.intel.com>
References: <20240418153121.291534-1-nirmal.patel@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 11:31:21 -0400
Nirmal Patel <nirmal.patel@linux.intel.com> wrote:

> VMD MSI remapping is disabled by default for all the CPUs with 28c0
> VMD deviceID. We used to disable remapping because drives supported
> more vectors than the VMD so the performance was better without
> remapping. Now with CPUs that support more than 64 (128 VMD MSIx
> vectors for gen5) we no longer need to disable this feature.
> 
> Note, pci_msix_vec_count() failure is translated to ENODEV per typical
> expectations that drivers may return ENODEV when some driver-known
> fundamental detail of the device is missing.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v1->v2: Updating commit message.
> v2->v3: Use VMD MSI count instead of cpu count.
> v3->v4: Updating commit message.
> ---
>  drivers/pci/controller/vmd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index 769eedeb8802..ba63af70bb63 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -34,6 +34,8 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +#define VMD_MIN_MSI_VECTOR_COUNT 64
> +
>  enum vmd_features {
>  	/*
>  	 * Device may contain registers which hint the physical
> location of the @@ -807,13 +809,20 @@ static int
> vmd_enable_domain(struct vmd_dev *vmd, unsigned long features) 
>  	sd->node = pcibus_to_node(vmd->dev->bus);
>  
> +	vmd->msix_count = pci_msix_vec_count(vmd->dev);
> +	if (vmd->msix_count < 0)
> +		return -ENODEV;
> +
>  	/*
>  	 * Currently MSI remapping must be enabled in guest
> passthrough mode
>  	 * due to some missing interrupt remapping plumbing. This is
> probably
>  	 * acceptable because the guest is usually CPU-limited and
> MSI
>  	 * remapping doesn't become a performance bottleneck.
> +	 * Disable MSI remapping only if supported by VMD hardware
> and when
> +	 * VMD MSI count is less than or equal to minimum MSI count.
>  	 */
>  	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +	    vmd->msix_count > VMD_MIN_MSI_VECTOR_COUNT ||
>  	    offset[0] || offset[1]) {
>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)

Gentle ping!

Thanks
nirmal

