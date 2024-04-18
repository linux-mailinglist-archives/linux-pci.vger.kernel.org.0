Return-Path: <linux-pci+bounces-6387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8E8A90B3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 03:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4090C1F227D4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024B5684;
	Thu, 18 Apr 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4f71Iha"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08A63BF;
	Thu, 18 Apr 2024 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403995; cv=none; b=YChCBfek7kx0N+IdwyTKpSND1/AazfbpNxi3qNXMY6sli4gWhGhUQJFUZ9+tTMWqS7P3IoUDAz0rRO6GlICFGWnGtmkVoTHZtHVpkQo2r0KVRpX5iKOeEO8GZMKqMnJIDF4CuSCTJFU4AP0NgBiZ9a8IwK/uR1bWgeMJWNK+JcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403995; c=relaxed/simple;
	bh=Q4F2ZtxiPYMoJOfp7gavUjn2ZLtzD+aJZKEOROEWMGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Krerkan/TvExsKnu8Jn4v9KC+3udLowtgZI3FhTjXGefD0zUVdLYfhg6+7y7G/9jvvloXXyFASL/pY5nupIoiUY9dIrK/IVDe/3bd4S4+p5XEBCX2dMla3xIr0KPInXcOui4spQSYAPedJs8bWkPuocolDa8vlrAqvaciMp5RSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4f71Iha; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713403992; x=1744939992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q4F2ZtxiPYMoJOfp7gavUjn2ZLtzD+aJZKEOROEWMGI=;
  b=Z4f71Ihaqfh+zWB7dyYJRu/tw6Xl6vrXTXQTh5x77/wT0xlJpOH8MP6R
   56JRoHNaGRMqGfmshI0kVYRNGaDLRAKNDKTNhQOuQXp+TaUCOx/f5krgK
   R7nGnMSVRLDVl9GIGU5TMPNDSV5IZsLqDsJsC4lZKjPOArvVmGwNNTgM1
   K+e/1lTW/HI03eTjM4pH76UihvXqmGTx5gfDisbwasrKn9mVGOeP9kNop
   X+KISjaRXHtlYc4RtKzmJqJp5UBEf7cqfC8x6wf83GFKj52+2XdmafIU2
   JOjI5AkZNBrExGvgi0OGkkPdR8hGtRyNFm70VdPSIjfiy9Bzp/U1GfO+R
   Q==;
X-CSE-ConnectionGUID: HnaVaoOZSE6TQcH+jp9yQA==
X-CSE-MsgGUID: Ebi5OVuoSOCj63Tq8Pq2UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8788883"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="8788883"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 18:33:11 -0700
X-CSE-ConnectionGUID: JgAsBTwcTbqB10eTts8YwA==
X-CSE-MsgGUID: m8jdm8yZQyevTr1lSoFbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="22870961"
Received: from kglossop-mobl.amr.corp.intel.com (HELO [10.209.94.180]) ([10.209.94.180])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 18:33:11 -0700
Message-ID: <3b5b78e0-dc7e-4e9b-833d-bbb918ff1b2a@linux.intel.com>
Date: Wed, 17 Apr 2024 18:33:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bagasdotme@gmail.com, regressions@lists.linux.dev,
 linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de,
 gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de
References: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
 <20240416043225.1462548-2-kai.heng.feng@canonical.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240416043225.1462548-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/15/24 9:32 PM, Kai-Heng Feng wrote:
> When the power rail gets cut off, the hardware can create some electric
> noise on the link that triggers AER. If IRQ is shared between AER with
> PME, such AER noise will cause a spurious wakeup on system suspend.
>
> When the power rail gets back, the firmware of the device resets itself
> and can create unexpected behavior like sending PTM messages. For this
> case, the driver will always be too late to toggle off features should
> be disabled.
>
> As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> the power will be turned off during suspend process, disable AER service
> and re-enable it during the resume process. This should not affect the
> basic functionality.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> v8:
>  - Add more bug reports.
>
> v7:
>  - Wording
>  - Disable AER completely (again) if power will be turned off
>
> v6:
> v5:
>  - Wording.
>
> v4:
> v3:
>  - No change.
>
> v2:
>  - Only disable AER IRQ.
>  - No more check on PME IRQ#.
>  - Use helper.
>
>  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..bea7818c2d1b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>  #include <linux/delay.h>
>  #include <linux/kfifo.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> +		aer_disable_rootport(rpc);
> +
> +	return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> +		aer_enable_rootport(rpc);
> +
> +	return 0;
> +}
> +
>  /**
>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>   * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver = {
>  	.service	= PCIE_PORT_SERVICE_AER,
>  
>  	.probe		= aer_probe,
> +	.suspend	= aer_suspend,
> +	.resume		= aer_resume,
>  	.remove		= aer_remove,
>  };
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


