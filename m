Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06C31BFFD4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgD3PNp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 11:13:45 -0400
Received: from foss.arm.com ([217.140.110.172]:57250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgD3PNp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 11:13:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73B4101E;
        Thu, 30 Apr 2020 08:13:44 -0700 (PDT)
Received: from [10.37.12.139] (unknown [10.37.12.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DCB23F68F;
        Thu, 30 Apr 2020 08:13:36 -0700 (PDT)
Subject: Re: [PATCH v6 10/25] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
To:     jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-11-jean-philippe@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ecec4f36-041f-0068-3863-106f9a082c62@arm.com>
Date:   Thu, 30 Apr 2020 16:18:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200430143424.2787566-11-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/30/2020 03:34 PM, Jean-Philippe Brucker wrote:
> The SMMUv3 driver would like to read the MMFR0 PARANGE field in order to
> share CPU page tables with devices. Allow the driver to be built as
> module by exporting the read_sanitized_ftr_reg() cpufeature symbol.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   arch/arm64/kernel/cpufeature.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9fac745aa7bb2..5f6adbf4ae893 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -841,6 +841,7 @@ u64 read_sanitised_ftr_reg(u32 id)
>   	BUG_ON(!regp);
>   	return regp->sys_val;
>   }
> +EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
>   
>   #define read_sysreg_case(r)	\
>   	case r:		return read_sysreg_s(r)
> 

