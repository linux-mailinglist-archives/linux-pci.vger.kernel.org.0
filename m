Return-Path: <linux-pci+bounces-38794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760BBF2FBB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 121B04E9991
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC68232395;
	Mon, 20 Oct 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI+7gosY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630001DE4E0;
	Mon, 20 Oct 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985872; cv=none; b=dUb0jcWLOlZ+9irp5ZET2KhpCjBKKuO9JU696AaC77z9jzTEOeGIgTp+FfaF0VCVbfC45+/mAYGzwu9utvWPlgh4ylDyiYjgy4mkFNoTOZ/qrDNqFMh2GnyFi3/XtDHP2VffD7rcVk0AyV/3Fi+grNwmhTZYwCbBGOJNWigNy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985872; c=relaxed/simple;
	bh=2ObGbCiinnX3wPS7uUgNt+y3BLvTCTRExvI5scP0FeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pP0j5ndQqu73f9pcWNo613fync64BE0sV957CgPxuLN7dIBjC7ni/te5gRk6NgLHFxtx9PuuGAt/dJUd+TFO3Oo8HJMXZ1Q6jZpolCTFPva9gFXb9FyVFyL2fGAIjEAtN8WbdmFKO04ihVhsnCHFBJ2DN2zzV4VaLDBNeWeH+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dI+7gosY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760985870; x=1792521870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ObGbCiinnX3wPS7uUgNt+y3BLvTCTRExvI5scP0FeU=;
  b=dI+7gosY09WFwNGrU7uaozGrF305QY9ApwovOghaYXwo0GJePflyBJ+9
   +JpHXxccb5v/s1iOaP/t59yy90NkWXvND7QNA1G8tVZRdLvnnxzQtqrTL
   E+fqQTStSd079OV2p0Q+3hbmXaZaPC6x0rFFEHm5o2dQU5uUWmdqEOBP1
   CTd87kbG62d5h97jOzVqGBRwf39PNR6VyGcvwL1/TF/vKZEfXc16NFy4A
   m+aweD89/eSVgGykNu8uVP5FWcdhflndrA6htj9qqp+oidDY0sg5UJXFK
   KTfySpm++hzlhVw7nEEwakBuAJ4Gpy4y6OQc4hBJmTnY0nyq2NqvQC+Wl
   Q==;
X-CSE-ConnectionGUID: aQB4V1ZCRASj/r5GJEN8Ug==
X-CSE-MsgGUID: OvG+3ukBTdqaFu8MnpqGyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63147251"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="63147251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:44:30 -0700
X-CSE-ConnectionGUID: d3FDiBHcSTm/bxR2PbwNyw==
X-CSE-MsgGUID: sqgpukQaQ9i3T7zLdkbnzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="187416595"
Received: from skuppusw-desk2.jf.intel.com (HELO [10.165.154.101]) ([10.165.154.101])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:44:30 -0700
Message-ID: <8cfebb7f-e557-493f-9458-f770fd459d06@linux.intel.com>
Date: Mon, 20 Oct 2025 11:44:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] PCI/AER: Clear both AER fatal and non-fatal status
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com, lukas@wunner.de
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-6-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20251015024159.56414-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/14/25 19:41, Shuai Xue wrote:
> The DPC driver clears AER fatal status for the port that reported the
> error, but not for the downstream device that deteced the error.  The
> current recovery code only clears non-fatal AER status, leaving fatal
> status bits set in the error device.
>
> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
> status in the error device, ensuring all AER status bits are properly
> cleared after recovery.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---

I think it needs to go to stable tree. Any Fixes: commit ?

>   drivers/pci/pcie/err.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 097990094b71..28c5ca7d86ce 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -290,7 +290,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	 */
>   	if (pcie_aer_is_native(dev)) {
>   		pcie_clear_device_status(dev);
> -		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_raw_clear_status(dev);
>   	}
>   
>   	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

