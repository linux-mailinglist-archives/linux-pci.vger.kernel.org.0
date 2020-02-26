Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31ED16F9EC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 09:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBZIpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 03:45:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgBZIpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 03:45:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 730B97C1AE6C45ED5204;
        Wed, 26 Feb 2020 16:44:54 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 16:44:53 +0800
Subject: Re: [PATCH v4 23/26] iommu/arm-smmu-v3: Add stall support for
 platform devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-24-jean-philippe@linaro.org>
CC:     <mark.rutland@arm.com>, <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        <robh+dt@kernel.org>, <zhangfei.gao@linaro.org>, <will@kernel.org>,
        <christian.koenig@amd.com>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <db6fc8c2-2ff3-631f-2294-c1b49acd27aa@huawei.com>
Date:   Wed, 26 Feb 2020 16:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200224182401.353359-24-jean-philippe@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2020/2/25 2:23, Jean-Philippe Brucker wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>
> The SMMU provides a Stall model for handling page faults in platform
> devices. It is similar to PCI PRI, but doesn't require devices to have
> their own translation cache. Instead, faulting transactions are parked and
> the OS is given a chance to fix the page tables and retry the transaction.
>
> Enable stall for devices that support it (opt-in by firmware). When an
> event corresponds to a translation error, call the IOMMU fault handler. If
> the fault is recoverable, it will call us back to terminate or continue
> the stall.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 271 ++++++++++++++++++++++++++++++++++--
>   drivers/iommu/of_iommu.c    |   5 +-
>   include/linux/iommu.h       |   2 +
>   3 files changed, 269 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 6a5987cce03f..da5dda5ba26a 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -374,6 +374,13 @@
>   #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
>   #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
>   
[...]
> +static int arm_smmu_page_response(struct device *dev,
> +				  struct iommu_fault_event *unused,
> +				  struct iommu_page_response *resp)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {0};
> +	struct arm_smmu_master *master = dev_iommu_fwspec_get(dev)->iommu_priv;
Here can use 'dev_to_master' ?

Cheers,
Zaibo

.
> +	int sid = master->streams[0].id;
> +
> +	if (master->stall_enabled) {
> +		cmd.opcode		= CMDQ_OP_RESUME;
> +		cmd.resume.sid		= sid;
> +		cmd.resume.stag		= resp->grpid;
> +		switch (resp->code) {
> +		case IOMMU_PAGE_RESP_INVALID:
> +		case IOMMU_PAGE_RESP_FAILURE:
> +			cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
> +			break;
> +		case IOMMU_PAGE_RESP_SUCCESS:
> +			cmd.resume.resp = CMDQ_RESUME_0_RESP_RETRY;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		/* TODO: insert PRI response here */
> +		return -ENODEV;
> +	}
> +
> +	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> +	/*
> +	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
> +	 * RESUME consumption guarantees that the stalled transaction will be
> +	 * terminated... at some point in the future. PRI_RESP is fire and
> +	 * forget.
> +	 */
> +
> +	return 0;
> +}
> +
[...]

