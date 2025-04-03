Return-Path: <linux-pci+bounces-25244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0632A7A951
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DD93A5578
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7EE2517B5;
	Thu,  3 Apr 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJAlDeyA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55B194A60;
	Thu,  3 Apr 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704769; cv=none; b=qTMbbG20A83gfJeXFjRVGfyUS7tKcuHVsswmGI8591DGKD58eyQGhavYqwLDdGms/mRB+eoxXEHjuGKbLqb69cmNHVeeaVxFmoC4nx2zxPkIVf5EAro2kqmwGIKUeLwKuegXFtdFahyviBxo3A3R4I89mf+ak6O1ZsJs7oJEDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704769; c=relaxed/simple;
	bh=cbzVjoQLsQphffMsAY0Ve+ds0CdCgkfMZYkZfjuzjlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM90vN1sM/grSYJIs/AqNAHCcGu/SHoKlXfI9DLz+vx3KVNXMlDMsvvyVeZFeNPy9V753ZKuRA48yzYW4krRSBHWWYxERse8/6JMOfZ8cobzIM5hpQUaZdzNua8NuNQUm3vKVz+UZtseZv5kmbf5liF8hquV0UpdqZSsT7f08v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJAlDeyA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743704768; x=1775240768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cbzVjoQLsQphffMsAY0Ve+ds0CdCgkfMZYkZfjuzjlI=;
  b=NJAlDeyAcBlNGQMNbibJS0L2Fac89Wu4UNxxwyPfLvw8asNhr0KMCtdd
   QPLpp/pTXMqjIO/pxBdfQeOXDxiVnCocAWNU2Yt5rJFguY95mJv0WyRWh
   aizMZm4K3SAxBa67e9oHxeWgnWHgGIff9Dew+31RQJJDUk1qj223dmz95
   7Sx+Ab3ctdn9gWcQez9Bj5ocB/j0Eawes1OUcXtViZkmLBTGcrx7Ou2Wz
   a8cE+nm6Tlw+4PJK1zRQl4E2/vXsYzW7ynnnOnLTZwIbJ/nTBd5lvk9LH
   fKU6FE/4P3wU4z5lEDOP/SZFGnw/u1Xky9lT2kVgqDmM8MQKuYcxcpJxS
   Q==;
X-CSE-ConnectionGUID: eOUcX0j4T4So+XB957rbIw==
X-CSE-MsgGUID: LL7EQW+eRLyO1QGsNiI3aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="62532221"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="62532221"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 11:26:07 -0700
X-CSE-ConnectionGUID: DYX3s5BeQRmgoRyXtOoeJA==
X-CSE-MsgGUID: 1oAxLbY5QgaQQp7nFPq7Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="150288344"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 11:26:04 -0700
Date: Thu, 3 Apr 2025 21:25:59 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de
Subject: Re: [PATCH v1] PCI/AER: Avoid power state transition during system
 suspend
Message-ID: <Z-7Sty6Vg61BGUu0@black.fi.intel.com>
References: <20250403074425.1181053-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403074425.1181053-1-raag.jadav@intel.com>

On Thu, Apr 03, 2025 at 01:14:25PM +0530, Raag Jadav wrote:
> If an error is triggered while system suspend is in progress, any bus
> level power state transition will result in unpredictable error handling.
> Mark skip_bus_pm flag as true to avoid this.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> 
> Ideally we'd want to defer recovery until system resume, but this is
> good enough to prevent device suspend.
> 
> More discussion at [1].
> [1] https://lore.kernel.org/r/Z-38rPeN_j7YGiEl@black.fi.intel.com

I just realized I messed up the link, please use [2] instead.
Apologies for the inconvenience.

[2] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com

>  drivers/pci/pcie/aer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..5acf4efc2df3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1108,6 +1108,12 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	/*
> +	 * Avoid any power state transition if an error is triggered during
> +	 * system suspend.
> +	 */
> +	dev->skip_bus_pm = true;
> +
>  	cxl_rch_handle_error(dev, info);
>  	pci_aer_handle_error(dev, info);
>  	pci_dev_put(dev);
> -- 
> 2.34.1
> 

