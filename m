Return-Path: <linux-pci+bounces-3340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC65851095
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 11:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904C31C208CB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23412B7E;
	Mon, 12 Feb 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qhhkf8jF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27912B70;
	Mon, 12 Feb 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733304; cv=none; b=Y1eT5YUFQ5vjkQqPjTk2q8KMmJfHmbDXfVGis0ZkbJX5/O7Axm6TUuIkjeTJDgW7dAC/dW2YVcN3+Pa/gZ6+Q5rp5Vil6z1p0mchA9GuNX1OkF9RQYALnLga2cPW8s8oBfTvLPZVAvc01i2dlvtYGS4PP0kQ0aC8LGTX0IN4HLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733304; c=relaxed/simple;
	bh=ubDlvIM3TbnHgIcdCI2fNzw//DINRYbx06IxhkLwtfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJC6Q4yfBhg7vIAneGUyFz/LxHvfwC2l4GAt6hArv91n8WYzJNMkKixlWJ35ad7BVTl2ziQMKlxUgN/7fgqFJ9xYvHXtUi3jOhWQ839GeFLPaH9ETCPqQbc8Y4zM4Oz3lKdpKFFhJ1fJlZC0sMWKMCnMY/0ZmygYp5WTN5Kn20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qhhkf8jF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707733303; x=1739269303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ubDlvIM3TbnHgIcdCI2fNzw//DINRYbx06IxhkLwtfk=;
  b=Qhhkf8jFpjm1n8s7ArwFtLiyaI80A/8sAowFG97LN84k4iDI5DaJRIdI
   3ojRHq/L1qh13FYQ+bXBtqVAmlzZErV5/98iobfcBdRmSMwzgjSDPsEnG
   eLwmPpfnLiKJY/JB5Q5JIMDYtTkwa4lbbLTv7/WlboDSeb6TTxCUEt44D
   ngtjc9r67jQIyXeR9qBEiZ4HCNOKwyENRLf3i2Ov5hizyRw2IdA/xPZJq
   BSisJgNLiY2/VfY8KlQ1ABkuGN8s3TAugtO4NphjSG2ynqGNV9lbEN3CO
   oO1/cdbL2TWR2w9XueZ/6pBOREiJe/5TWO2GBmsB5K4WF/Yb6n0tXuPD/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1587250"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1587250"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:21:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2892994"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.245])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:21:40 -0800
Date: Mon, 12 Feb 2024 10:47:09 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI/AER: Block runtime suspend when handling errors
Message-ID: <ZcnpHdrYRWCMvj1o@linux.intel.com>
References: <20240212083158.76549-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212083158.76549-1-stanislaw.gruszka@linux.intel.com>

On Mon, Feb 12, 2024 at 09:31:58AM +0100, Stanislaw Gruszka wrote:
> PM runtime can be done simultaneously with AER error handling.
> Avoid that by using pm_runtime_get_sync() before and pm_runtime_put()
> after reset in pcie_do_recovery() for all recovering devices.
> 
> pm_runtime_get_sync() will increase dev->power.usage_count counter                                                                                                                                                                          to prevent any possible future request to runtime suspend a device                                                                                                                                                                          It will also resume a device, if it was previously in D3hot state.
> 
I'm sorry, I mangled this somehow. Will repost v3.

Regards
Stanislaw


> I tested with igc device by doing simultaneous aer_inject and
> rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
> and can reproduce:
> 
> igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> pcieport 0000:00:1c.2: AER: subordinate device reset failed
> pcieport 0000:00:1c.2: AER: device recovery failed
> igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 
> The problem disappears when applied this patch.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> RFC -> v1:
>  add runtime callbacks to pcie_do_recovery(), this covers DPC case
>  as well as case of recovering multiple devices under same port.
> 
> v1 -> v2:
>  - add R-b, A-b, cc-stable tags
>  - tweak commit message
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 59c90d04a609..705893b5f7b0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -13,6 +13,7 @@
>  #define dev_fmt(fmt) "AER: " fmt
>  
>  #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
>  	return 0;
>  }
>  
> +static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
> +{
> +	pm_runtime_get_sync(&pdev->dev);
> +	return 0;
> +}
> +
> +static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
> +{
> +	pm_runtime_put(&pdev->dev);
> +	return 0;
> +}
> +
>  static int report_frozen_detected(struct pci_dev *dev, void *data)
>  {
>  	return report_error_detected(dev, pci_channel_io_frozen, data);
> @@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	else
>  		bridge = pci_upstream_bridge(dev);
>  
> +	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
> +
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> @@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pcie_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
>  	}
> +
> +	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>  	pci_info(bridge, "device recovery successful\n");
>  	return status;
>  
>  failed:
> +	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>  	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
>  
>  	/* TODO: Should kernel panic here? */
> -- 
> 2.34.1
> 
> 

