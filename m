Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A745F3FDE6D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 17:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343622AbhIAPS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 11:18:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:8286 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245713AbhIAPS5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 11:18:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="218787727"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="218787727"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 08:18:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="532232006"
Received: from anovovic-mobl2.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.7.120])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 08:17:59 -0700
Subject: Re: [PATCH 1/1] PCI: vmd: Do not disable MSI-X remapping if interrupt
 remapping is enabled by IOMMU
To:     Adrian Huang <adrianhuang0701@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Adrian Huang <ahuang12@lenovo.com>
References: <20210901124047.1615-1-adrianhuang0701@gmail.com>
From:   Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <5120b110-693a-79d3-2793-ac53c036897f@intel.com>
Date:   Wed, 1 Sep 2021 09:17:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210901124047.1615-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you Adrian

On 9/1/21 6:40 AM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When enabling VMD in BIOS setup (Ice Lake Processor: Whitley platform),
> the host OS cannot boot successfully with the following error message:
> 
>   nvme nvme0: I/O 12 QID 0 timeout, completion polled
>   nvme nvme0: Shutdown timeout set to 6 seconds
>   DMAR: DRHD: handling fault status reg 2
>   DMAR: [INTR-REMAP] Request device [0x00:0x00.5] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request

I know we'd really prefer to support interrupt remapping with the VMD feature,
and I'm not certain how EIME differs from the interrupt remapping modes that
were tested while developing the VMD feature.

I think this will have to be acceptable for now.

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

> 
> The request device is the VMD controller:
>   # lspci -s 0000:00.5 -nn
>   0000:00:00.5 RAID bus controller [0104]: Intel Corporation Volume
>   Management Device NVMe RAID Controller [8086:28c0] (rev 04)
> 
> `git bisect` points to this offending commit ee81ee84f873 ("PCI:
> vmd: Disable MSI-X remapping when possible"), which disables VMD MSI
> remapping. The IOMMU hardware blocks the compatibility format
> interrupt request because Interrupt Remapping Enable Status (IRES) and
> Extended Interrupt Mode Enable (EIME) are enabled. Please refer to
> section "5.1.4 Interrupt-Remapping Hardware Operation" in Intel VT-d
> spec.
> 
> To fix the issue, VMD driver still enables the interrupt remapping
> irrespective of VMD_FEAT_CAN_BYPASS_MSI_REMAP if the IOMMU subsystem
> enables the interrupt remapping.
> 
> Test configuration is shown as follows:
>   * Two VMD controllers
>     1. 8086:28c0 (Whitley's VMD)
>     2. 8086:201d (Purley's VMD: The issue does not appear in this
>        controller. Just make sure if any side effect occurs.)
>   * w/wo intremap=off
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214219
> Cc: Jon Derrick <jonathan.derrick@intel.com>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/pci/controller/vmd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e3fcdfec58b3..db72932d049f 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -710,7 +711,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
> +	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>  	    offset[0] || offset[1]) {
>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)
> 
