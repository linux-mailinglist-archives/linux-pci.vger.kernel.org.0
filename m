Return-Path: <linux-pci+bounces-33998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B46B25727
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C329C1885AC2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB530146B;
	Wed, 13 Aug 2025 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T09MuAme"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F2301463
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126113; cv=none; b=JKSz7QAm2mOlmm8xrhDrNwV7LlWtM3DDtedVEjxK16BM2H0JUXGEJl6q5t5HcXV3gZcJcmwbCRXlXSFlMAjiqMRNPCpzLa2lX5x4ifXeWrCJRnAWp0SIHfbD3fxWppKguSrE3uYAxo/q2ubztwQYLXXTDrDZ6R/K64HBPe8fCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126113; c=relaxed/simple;
	bh=W2L9yzRV2c5O9B7IEtrjF8WUFbxs5s8QKfHx3/oiOIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRzAQSJFn4dkumiw/KsJ6BMvmFkrKj5GGJCx32bLRh5hNfKg5+7pxpwlaeOELyqQdjMXXdB4Pu1BBmaGJewOk2nILo+M1J4RI14GIPHG3qFHrp3Z0BRUxRDEVncjO2WdbAOv0kWhNyNRRa2flHEg1wDNrxZNPBCgmTw2UGsRrYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T09MuAme; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755126111; x=1786662111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W2L9yzRV2c5O9B7IEtrjF8WUFbxs5s8QKfHx3/oiOIQ=;
  b=T09MuAmeENTUDkaSVeGpHloNVRdgDSkCLywYtjNRwKAhAE94fPTPxDFG
   WPiagJ21I0GZVv/K2BwHXt5yVwlm/AbZMmMdxRPYSVrQJmF4egDmcmvpU
   APdl1qjSzrdWPYagQSuRlqd0OXIFIogleanjwq1xVjAMAlpBtbqXXlin8
   Xl+F9geORijVJ0aWrIcqQmbWDI5QNAh0+0LVyEzgmVcLzKNq1DHKI44BZ
   pQBjHBm6NVh9NyCkFf5DMWcqehBVckiB3nXmPdN1pERpwMG2UEpu6CklG
   A6O6Tt3K8hiGcmgSWV4KS3TaeSK0/Cdozx22iLw8SitRZdEqhxvTjN432
   Q==;
X-CSE-ConnectionGUID: jYk4MZCMQG6nWi1rgMldaw==
X-CSE-MsgGUID: /7uBtEBzSXqD7pW+oQQazg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57304147"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57304147"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 16:01:51 -0700
X-CSE-ConnectionGUID: sl5NCfc+T2iQoqPkdGLMHQ==
X-CSE-MsgGUID: vjLDRcRHTk2RnazkJtkl1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166245339"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 16:01:50 -0700
Received: from [10.124.222.231] (unknown [10.124.222.231])
	by linux.intel.com (Postfix) with ESMTP id EE6C020B571C;
	Wed, 13 Aug 2025 16:01:48 -0700 (PDT)
Message-ID: <f0b59604-ae4d-4afe-8522-a8fbe5568e96@linux.intel.com>
Date: Wed, 13 Aug 2025 16:01:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] PCI/ERR: Fix uevent on failure to recover
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 "Sean C. Dardis" <sean.c.dardis@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
References: <cover.1755008151.git.lukas@wunner.de>
 <68fc527a380821b5d861dd554d2ce42cb739591c.1755008151.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <68fc527a380821b5d861dd554d2ce42cb739591c.1755008151.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/12/25 10:11 PM, Lukas Wunner wrote:
> Upon failure to recover from a PCIe error through AER, DPC or EDR, a
> uevent is sent to inform user space about disconnection of the bridge
> whose subordinate devices failed to recover.
>
> However the bridge itself is not disconnected.  Instead, a uevent should
> be sent for each of the subordinate devices.
>
> Only if the "bridge" happens to be a Root Complex Event Collector or
> Integrated Endpoint does it make sense to send a uevent for it (because
> there are no subordinate devices).
>
> Right now if there is a mix of subordinate devices with and without
> pci_error_handlers, a BEGIN_RECOVERY event is sent for those with
> pci_error_handlers but no FAILED_RECOVERY event is ever sent for them
> afterwards.  Fix it.
>
> Fixes: 856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org  # v4.16+
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/err.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index e795e5ae6b03..21d554359fb1 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -108,6 +108,12 @@ static int report_normal_detected(struct pci_dev *dev, void *data)
>   	return report_error_detected(dev, pci_channel_io_normal, data);
>   }
>   
> +static int report_perm_failure_detected(struct pci_dev *dev, void *data)
> +{
> +	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> +	return 0;
> +}
> +
>   static int report_mmio_enabled(struct pci_dev *dev, void *data)
>   {
>   	struct pci_driver *pdrv;
> @@ -272,7 +278,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   failed:
>   	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
>   
> -	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
> +	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
>   
>   	pci_info(bridge, "device recovery failed\n");
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


