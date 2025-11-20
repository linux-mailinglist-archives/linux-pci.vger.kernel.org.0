Return-Path: <linux-pci+bounces-41795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CEBC7507B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61A4E362801
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DB393DCA;
	Thu, 20 Nov 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P8suQuB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1936C5B3;
	Thu, 20 Nov 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652135; cv=none; b=IDKtdVRP84i+ONpNiZWMrUXFGpfeSjU9FtOnzagJoYkmfmP7GHi8dAZNoacHsOyXXLtRqYwxtkXBp5b8q4R6YF90BktgssXV/vlMqz4gfufoaZ5UOre7t4QlJahpO3w77CX/K0aiTNkaUIWE4A+NXeJ3Tqm+c0mRFHkypcQbqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652135; c=relaxed/simple;
	bh=HTP7ZG0JLrR72YEpCQPOqmegXIQklqpfc1T/tjAQ2gk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsvW5QIx5I/8+8vW+LKs1EDUB40f3zEWSCdLYYwzA1KxuL+arOQ2tJQXQVWL+I6VANbzsMGTBF1wtQFP6IXlYSI2U6n5pH/Sw+XfobGkPFiuWN37MiJbRZrkPZebkh422iRLS76eesjAHgsXY7G54oANfaOSwatgHfQdC8ZnO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P8suQuB5; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tvyyaDNHmQ2x14W2WTsi4Y3M6d5AXJBaR91q3uubHa8=;
	b=P8suQuB5PwqZjD42T1LpU9x6a8G94VQmb+EdDJjHp0fTt7YXE26W7pr8ZZrt97isNy5JuW9Rz
	ocf1+lQIxqsN3ZKHxy8a8YaH1AUNkjARqjJP5a5D92bNNF0QuEppUN9AcB2CxojIm8BRpYUIz9E
	aBYU43M1xRf+aQpZAtfvHCo=
Received: from frasgout.his.huawei.com (unknown [172.18.146.33])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dC29f6KB8z1vpBc;
	Thu, 20 Nov 2025 23:20:54 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC2B73cfPzJ46Yf;
	Thu, 20 Nov 2025 23:21:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CD101402F1;
	Thu, 20 Nov 2025 23:22:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Nov
 2025 15:22:04 +0000
Date: Thu, 20 Nov 2025 15:22:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 05/11] coco: guest: arm64: Add support for updating
 measurements from device
Message-ID: <20251120152202.00001efb@huawei.com>
In-Reply-To: <20251117140007.122062-6-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-6-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 19:30:01 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Fetch device measurements using RSI_RDEV_GET_MEASUREMENTS. The fetched
> device measurements will be cached in the host.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh

Minor stuff inline.

thanks

Jonathan

> ---
>  arch/arm64/include/asm/rhi.h             | 19 ++++++++
>  drivers/virt/coco/arm-cca-guest/rhi-da.c | 48 ++++++++++++++++++++
>  drivers/virt/coco/arm-cca-guest/rhi-da.h |  2 +
>  drivers/virt/coco/arm-cca-guest/rsi-da.c | 58 ++++++++++++++++++++++++
>  drivers/virt/coco/arm-cca-guest/rsi-da.h |  2 +
>  5 files changed, 129 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
> index 5f140015afc3..ce2ed8a440c3 100644
> --- a/arch/arm64/include/asm/rhi.h
> +++ b/arch/arm64/include/asm/rhi.h
> @@ -42,6 +42,25 @@
>  #define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
>  #define RHI_DA_VDEV_GET_INTERFACE_REPORT SMC_RHI_CALL(0x0052)
>  
> +#define RHI_VDEV_MEASURE_SIGNED		BIT(0)
> +#define RHI_VDEV_MEASURE_RAW		BIT(1)
> +#define RHI_VDEV_MEASURE_EXCHANGE	BIT(2)
Whilst I appreciate the specs are still subject to minor changes, 
it would be very helpful if definitions like the ones above were
all accompanied by a spec reference.

Which is another way of saying I can't find these ones ;)

> +struct rhi_vdev_measurement_params {
> +	union {
> +		u64 flags;
> +		u8 padding0[256];
> +	};
> +	union {
> +		u8 indices[32];
> +		u8 padding1[256];
> +	};
> +	union {
> +		u8 nonce[32];
> +		u8 padding2[256];
> +	};
> +};
> +#define RHI_DA_VDEV_GET_MEASUREMENTS	SMC_RHI_CALL(0x0053)
> +
>  #define RHI_DA_TDI_CONFIG_UNLOCKED		0x0
>  #define RHI_DA_TDI_CONFIG_LOCKED		0x1
>  #define RHI_DA_TDI_CONFIG_RUN			0x2
> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> index f4fb8577e1b5..aa17bb3ee562 100644
> --- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> @@ -200,3 +200,51 @@ int rhi_update_vdev_interface_report_cache(struct pci_dev *pdev)
>  
>  	return ret;
>  }
> +
> +static inline int rhi_vdev_get_measurements(unsigned long vdev_id,
> +					    phys_addr_t vdev_meas_phys,
> +					    unsigned long *cookie)
> +{
> +	unsigned long ret;
> +
> +	struct rsi_host_call *rhi_call __free(kfree) =
> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);

sizeof(*rhi_call) slightly preferred.

> +	if (!rhi_call)
> +		return -ENOMEM;
> +
> +	rhi_call->imm = 0;
> +	rhi_call->gprs[0] = RHI_DA_VDEV_GET_MEASUREMENTS;
> +	rhi_call->gprs[1] = vdev_id;
> +	rhi_call->gprs[2] = vdev_meas_phys;
> +
> +	ret = rsi_host_call(virt_to_phys(rhi_call));
> +	if (ret != RSI_SUCCESS)
> +		return -EIO;
> +
> +	*cookie = rhi_call->gprs[1];
> +	return map_rhi_da_error(rhi_call->gprs[0]);
> +}
> +


> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> index c8ba72e4be3e..aa6e13e4c0ea 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/mem_encrypt.h>
>  #include <asm/rsi_cmds.h>
>  
>  #include "rsi-da.h"
> @@ -35,9 +36,50 @@ int cca_device_unlock(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +struct page *alloc_shared_pages(int nid, gfp_t gfp_mask, unsigned long min_size)
> +{
> +	int ret;
> +	struct page *page;
> +	/* We should normalize the size based on hypervisor page size */
> +	int page_order = get_order(min_size);
> +
> +	/* Always request for zero filled pages */

Not sure the comment is necessary given the visible flag.
If you were saying 'why' then a comment would be fine, but this is just
repeating what we can see in the code.

> +	page = alloc_pages_node(nid, gfp_mask | __GFP_ZERO, page_order);
> +
> +	if (!page)
> +		return NULL;
> +
> +	ret = set_memory_decrypted((unsigned long)page_address(page),
> +				   1 << page_order);
> +	/*
> +	 * If set_memory_decrypted() fails then we don't know what state the
> +	 * page is in, so we can't free it. Instead we leak it.
> +	 * set_memory_decrypted() will already have WARNed.
> +	 */
> +	if (ret)
> +		return NULL;
> +
> +	return page;
> +}
> +
> +int free_shared_pages(struct page *page, unsigned long min_size)
> +{
> +	int ret;
> +	/* We should normalize the size based on hypervisor page size */
> +	int page_order = get_order(min_size);
> +
> +	ret = set_memory_encrypted((unsigned long)page_address(page), 1 << page_order);
> +	/* If we fail to mark it encrypted don't free it back */
> +	if (!ret)
> +		__free_pages(page, page_order);
> +	return ret;
If failing to mark it encrypted is an error I'd find it easier to read this if it were
out of line.

	ret = set_memory...
	if (ret)
		return ret;

	__free_pages();

	return 0;

This is just a preference as someone who reads a lot of code.  Having error handling
as the out of line path is more common and so what my brain (and other reviewers)
has long been trained to expect.

> +}
> +
>  int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc)
>  {
>  	int ret;
> +	struct page *shared_pages;
> +	struct rhi_vdev_measurement_params *dev_meas;
>  
>  	ret = rhi_update_vdev_interface_report_cache(pdev);
>  	if (ret) {
> @@ -45,5 +87,21 @@ int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *d
>  		return ret;
>  	}
>  
> +	shared_pages = alloc_shared_pages(NUMA_NO_NODE, GFP_KERNEL, sizeof(struct rhi_vdev_measurement_params));

Perhaps sizeof(*dev_meas) would be both shorter and clearer.

> +	if (!shared_pages)
> +		return -ENOMEM;
> +
> +	dev_meas = (struct rhi_vdev_measurement_params *)page_address(shared_pages);
> +	/* request for signed full transcript */
> +	dev_meas->flags = RHI_VDEV_MEASURE_SIGNED | RHI_VDEV_MEASURE_EXCHANGE;
> +	/* request all measurement block. Set bit 254 */
> +	dev_meas->indices[31] = 0x40;
> +	ret = rhi_update_vdev_measurements_cache(pdev, dev_meas);
> +
> +	free_shared_pages(shared_pages, sizeof(struct rhi_vdev_measurement_params));

It might be worth appropriate DEFINE_FREE() magic to to stash the size away
and simplify this a tiny bit. Kind of depends on whether this is a one off
or those helpers are going to get a reasonable amount of use.

> +	if (ret) {
> +		pci_err(pdev, "failed to get device measurement (%d)\n", ret);
> +		return ret;
> +	}
>  	return 0;
>  }

