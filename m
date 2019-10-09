Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61901D1CF6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 01:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJIXoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 19:44:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:36281 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbfJIXoB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="193027202"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2019 16:44:00 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id EEC7E5802BC;
        Wed,  9 Oct 2019 16:43:59 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 1/2] iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20191009224551.179497-1-helgaas@kernel.org>
 <20191009224551.179497-2-helgaas@kernel.org>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <76ec2ac0-129e-ef65-8229-6405020fdc9f@linux.intel.com>
Date:   Wed, 9 Oct 2019 16:42:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009224551.179497-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/9/19 3:45 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> When CONFIG_INTEL_IOMMU_SVM=y, iommu_enable_dev_iotlb() calls PRI
> interfaces (pci_reset_pri() and pci_enable_pri()), but those are only
> implemented when CONFIG_PCI_PRI is enabled.
>
> Previously INTEL_IOMMU_SVM selected PCI_PASID but not PCI_PRI, so the state
> of PCI_PRI depended on whether AMD_IOMMU (which selects PCI_PRI) was
> enabled or PCI_PRI was enabled explicitly.
>
> The behavior of iommu_enable_dev_iotlb() should not depend on whether
> AMD_IOMMU is enabled.  Make it predictable by having INTEL_IOMMU_SVM select
> PCI_PRI so iommu_enable_dev_iotlb() always uses the full implementations of
> PRI interfaces.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e3842eabcfdd..b183c9f916b0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -207,6 +207,7 @@ config INTEL_IOMMU_SVM
>   	bool "Support for Shared Virtual Memory with Intel IOMMU"
>   	depends on INTEL_IOMMU && X86
>   	select PCI_PASID
> +	select PCI_PRI
>   	select MMU_NOTIFIER
>   	help
>   	  Shared Virtual Memory (SVM) provides a facility for devices

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

