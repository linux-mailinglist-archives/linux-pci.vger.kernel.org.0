Return-Path: <linux-pci+bounces-41821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55FC75B99
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 518362F8F8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD56223DD4;
	Thu, 20 Nov 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KPst2i0q"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E71C5D7D;
	Thu, 20 Nov 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659936; cv=none; b=L2/N4/WE87RMqkQGGJe5hc0yP4RN0S35XhJ6Gqt1dyiW5aYF/PW5BPEwd26elr4yYP1sa1GPZRTbAaTGmbF5yrGqucBuHXxrpBDTv72HccIpXklBjVtgZR2p7MRa9oNHAEFfMaStfxYfAjhmGB3eiwHsAB8UOLmiLik78wpM6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659936; c=relaxed/simple;
	bh=9/c+ELr1/fHues8ZWflDDWYNjH0kSYLiJWym/CrYVZw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdROfm/urhWkqQP+fLiTPeamXoJLRHWy3DiKPRqOi7c4MZ3BtOfFaVsEHZ6o9O/nFjSTLlMWDTXFU0kQB4jZMhwtnfcXSeAgcwWvJaclalbn3guG6wjZIFmbpYCW41fzBUzwA+5nlopQzVi9n1f6O1709CFNm+rn4bBdrCuPcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KPst2i0q; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mXOkmgMomugKQo+k2FQLzUzQiiA115Atzcu83W/SPKg=;
	b=KPst2i0qTU8MfV5I+OsuoeDxcG3Lkz28HjMKVG1+Rx8qvyV36gvjwjpYVza1wH324V/YkwW3J
	yIuZNER1Un3TacpmCIV28Xh342p2DRNybKmBqoxha/V/Ny447FpfM3s0+RoV7OujF2BmHLnBn1M
	YWx1ppycWMExhelFp8mPR4U=
Received: from frasgout.his.huawei.com (unknown [172.18.146.33])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dC53X51J1z1P7SP;
	Fri, 21 Nov 2025 01:30:48 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5432vNFzJ46CH;
	Fri, 21 Nov 2025 01:31:15 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 384A71402FD;
	Fri, 21 Nov 2025 01:32:01 +0800 (CST)
Received: from localhost (10.48.159.58) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Nov
 2025 17:32:00 +0000
Date: Thu, 20 Nov 2025 17:31:57 +0000
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
Subject: Re: [PATCH v2 06/11] coco: guest: arm64: Add support for reading
 cached objects from host
Message-ID: <20251120173157.00007fc4@huawei.com>
In-Reply-To: <20251117140007.122062-7-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-7-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 19:30:02 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Teach rsi_device_start() to pull the interface report and device
> certificate from the host by querying size, sharing a decrypted buffer
> for the read, copying the payload to private memory. Also track the
> fetched blobs in struct cca_guest_dsc so later stages can hand them to
> the attestation flow.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/rhi.h             |  7 +++
>  drivers/virt/coco/arm-cca-guest/rhi-da.c | 80 ++++++++++++++++++++++++
>  drivers/virt/coco/arm-cca-guest/rhi-da.h |  1 +
>  drivers/virt/coco/arm-cca-guest/rsi-da.h |  8 +++
>  4 files changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
> index ce2ed8a440c3..738470dfb869 100644
> --- a/arch/arm64/include/asm/rhi.h
> +++ b/arch/arm64/include/asm/rhi.h
> @@ -39,6 +39,13 @@
>  				 RHI_DA_FEATURE_VDEV_SET_TDI_STATE)
>  #define RHI_DA_FEATURES			SMC_RHI_CALL(0x004B)
>  
> +#define RHI_DA_OBJECT_CERTIFICATE		0x1
> +#define RHI_DA_OBJECT_MEASUREMENT		0x2
> +#define RHI_DA_OBJECT_INTERFACE_REPORT		0x3
> +#define RHI_DA_OBJECT_VCA			0x4
> +#define RHI_DA_OBJECT_SIZE		SMC_RHI_CALL(0x004C)
> +#define RHI_DA_OBJECT_READ		SMC_RHI_CALL(0x004D)
> +
>  #define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
>  #define RHI_DA_VDEV_GET_INTERFACE_REPORT SMC_RHI_CALL(0x0052)
>  
> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> index aa17bb3ee562..d29aee0fca58 100644
> --- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> @@ -248,3 +248,83 @@ int rhi_update_vdev_measurements_cache(struct pci_dev *pdev,
>  
>  	return ret;
>  }
> +
> +int rhi_read_cached_object(int vdev_id, int da_object_type, void **object, int *object_size)
> +{
> +	int ret;
> +	int max_data_len;
> +	struct page *shared_pages;
> +	void *data_buf_shared, *data_buf_private;
> +	struct rsi_host_call *rhicall;
> +
> +	rhicall = kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
> +	if (!rhicall)
> +		return -ENOMEM;
> +
> +	rhicall->imm = 0;
> +	rhicall->gprs[0] = RHI_DA_OBJECT_SIZE;
> +	rhicall->gprs[1] = vdev_id;
> +	rhicall->gprs[2] = da_object_type;
> +
> +	ret = rsi_host_call(virt_to_phys(rhicall));
> +	if (ret != RSI_SUCCESS) {
> +		ret = -EIO;
> +		goto err_return;
> +	}
> +
> +	if (rhicall->gprs[0] != RHI_DA_SUCCESS) {
> +		ret = -EIO;
> +		goto err_return;
> +	}
> +
> +	/* validate against the max cache object size used on host. */
> +	max_data_len = rhicall->gprs[1];
> +	if (max_data_len > MAX_CACHE_OBJ_SIZE || max_data_len == 0) {
> +		ret = -EIO;
> +		goto err_return;
> +	}
> +	*object_size = max_data_len;

I raise this below, but not sure why this is set way before setting
*object.  Can set it later and use max_data_len which I think is
clearer naming anyway.

> +
> +	data_buf_private = kmalloc(*object_size, GFP_KERNEL);
> +	if (!data_buf_private) {
> +		ret = -ENOMEM;
> +		goto err_return;
> +	}
> +
> +	shared_pages = alloc_shared_pages(NUMA_NO_NODE, GFP_KERNEL, max_data_len);
> +	if (!shared_pages) {
> +		ret = -ENOMEM;
> +		goto err_shared_alloc;
> +	}
> +	data_buf_shared = page_address(shared_pages);
> +
> +	rhicall->imm = 0;
> +	rhicall->gprs[0] = RHI_DA_OBJECT_READ;
> +	rhicall->gprs[1] = vdev_id;
> +	rhicall->gprs[2] = da_object_type;
> +	rhicall->gprs[3] = 0; /* offset within the data buffer */
> +	rhicall->gprs[4] = max_data_len;
> +	rhicall->gprs[5] = virt_to_phys(data_buf_shared);
> +	ret = rsi_host_call(virt_to_phys(rhicall));
> +	if (ret != RSI_SUCCESS || rhicall->gprs[0] != RHI_DA_SUCCESS) {
> +		ret = -EIO;
> +		goto err_rhi_call;
> +	}
> +
> +	memcpy(data_buf_private, data_buf_shared, *object_size);

Given data_buf_private() only seems useful if we aren't in an error
condition, why not move allocation to here and use kmemdup() ?

> +	free_shared_pages(shared_pages, max_data_len);
> +
> +	*object = data_buf_private;
> +	kfree(rhicall);
> +	return 0;
> +
> +err_rhi_call:
> +	free_shared_pages(shared_pages, max_data_len);
> +err_shared_alloc:
> +	kfree(data_buf_private);
> +err_return:
> +	*object = NULL;

Is it necessary to zero the passed in variable given this function never
touched it and is returning an error. If it is, can you do that unconditionally
at start of function and override only on success?

> +	*object_size = 0;

Likewise for the size - I'm not sure why you set that much earlier
than *object.

With those two gone, this feels like it would be well suited for
some __free magic to handle everything here.
You will need to deal with the free_shared_pages() though which will
require an extra structure definition and helpers to wrap up what
is allocated - similar to what tdx_page_array_alloc does (though without
the bulk aspects of that)

http://lore.kernel.org/all/20251117022311.2443900-7-yilun.xu@linux.intel.com/

Or given the shared page stuff is the inner most aspect anyway you could
just do a helper function from alloc_shared_pages to free_shared_pages
calls so that you can call that free_shared_pages unconditionally before
checking return value.

Note that if you do go with DEFINE_FREE() you 'could' pass in the storage.
I objected to that elsewhere but there is precedence.  So have a
struct shared_pages {
	struct page *page;
	size_t order;
}
define one on the stack and pass it in so that you avoid an extra allocation.
Not a pattern I particularly like though and this isn't expected to be
a particularly fast path so I'd just dynamically allocate a struct shared_pages
inside alloc_shared_pages.


> +	kfree(rhicall);
> +	return ret;
> +}



