Return-Path: <linux-pci+bounces-27955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD673ABBB52
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B533517836D
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0612749EB;
	Mon, 19 May 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rn7q29cf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66930274656;
	Mon, 19 May 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651320; cv=none; b=OVrIEX2qO46EC/gUPxQDtDXQlVM/WpopoS2Ii3+E3YH9ZywOJLidmpufMvLXxMV1rfzy/iNNd1rKv+iwEWS2XOJhFIX1DgNtfz4Ud0yi7EfvIuWEIYlKoMkmRgNkmgAJ3gO6EuAjVshfp/5v1LWFa1EoiyGJIgzvpaMEeKaQFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651320; c=relaxed/simple;
	bh=WwdWSDzHYkwFYjUjNLqQ7dTd0+b4+asbHn//f9+h/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR4vbPyTb4kVKq/jn+5ObtOwfYe1C6g2RK2YiD9N1m0NzzzygOKNeLgsbnNVTvxmhVabwsQUNN4lCV/w8s8HRp0LA6VqVDmLVUsdFGW6TOlZNC70ZaZJ1r2tsWpHTmiwclUOREI71snlDvaNVt+07HPCumL/1fof7IiUc+9cLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rn7q29cf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747651318; x=1779187318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WwdWSDzHYkwFYjUjNLqQ7dTd0+b4+asbHn//f9+h/z4=;
  b=Rn7q29cfOQYGEkBAR/oTQ8fdjbj28nTP/WXiNHdHpPrxOmDd1/caStAN
   5Tv9sQWIulPqkddkYA9uRLoDZ9vJvphx7U0TASj40znc8N7gxIyoZxp7h
   1nOOXiVcChsQUyHwXuAJXNgKacmAT2SzFmF2e6aj7+m1pR7IYBZpnE/Ie
   11NK3ihVH8qvbzW0vlkwZlKS2d9d/uXqirkxnRfzS3HIwITbgwH+Tj4O5
   NkhhUo9ZBLyFi0plhzHEYs1MRVvhpgBD61ugPWCSaHLS7cEpctl5rLG9/
   oqDBw0IuaHhmh5DL186P/52vNp9oFLPhOct7qfjQ8v+UoPf5tuj+gPII0
   g==;
X-CSE-ConnectionGUID: /vLTRnN8SlKhSKpU6wgALQ==
X-CSE-MsgGUID: ANoeMXuAR1W1tap6dlU3Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="48657721"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="48657721"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 03:41:57 -0700
X-CSE-ConnectionGUID: oUqXr90sQfCsQ0lxJh+iXQ==
X-CSE-MsgGUID: VJV/wwbTSwy/hsPTBHueXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="170243692"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 03:41:54 -0700
Date: Mon, 19 May 2025 13:41:51 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de, aravind.iddamsetty@linux.intel.com,
	superm1@kernel.org, benato.denis96@gmail.com
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCsK743YSuahPtnH@black.fi.intel.com>
References: <20250519102808.4130271-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519102808.4130271-1-raag.jadav@intel.com>

On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
> If error status is set on an AER capable device, most likely either the
> device recovery is in progress or has already failed. Neither of the
> cases are well suited for power state transition of the device, since
> this can lead to unpredictable consequences like resume failure, or in
> worst case the device is lost because of it. Leave the device in its
> existing power state to avoid such issues.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> 
> v2: Synchronize AER handling with PCI PM (Rafael)
> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>     Elaborate "why" (Bjorn)
> v4: Rely on error status instead of device status
>     Condense comment (Lukas)

Since pci_aer_in_progress() is changed I've not included Rafael's tag with
my understanding of this needing a revisit. If this was a mistake, please
let me know.

Denis, Mario, does this fix your issue?

> More discussion on [1].
> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> 
>  drivers/pci/pci.c      |  9 +++++++++
>  drivers/pci/pcie/aer.c | 13 +++++++++++++
>  include/linux/aer.h    |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..a20018692933 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/aer.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -1539,6 +1540,14 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>  	   || (state == PCI_D2 && !dev->d2_support))
>  		return -EIO;
>  
> +	/*
> +	 * If error status is set on an AER capable device, it is not well
> +	 * suited for power state transition. Leave it in its existing power
> +	 * state to avoid issues like unpredictable resume failure.
> +	 */
> +	if (pci_aer_in_progress(dev))
> +		return -EIO;
> +
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>  		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..617fbac0d38a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -237,6 +237,19 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>  
> +bool pci_aer_in_progress(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 cor, uncor;
> +
> +	if (!pcie_aer_is_native(dev))
> +		return false;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &cor);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor);
> +	return cor || uncor;
> +}
> +
>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
>  	int rc;
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..e6a380bb2e68 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +bool pci_aer_in_progress(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -- 
> 2.34.1
> 

