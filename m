Return-Path: <linux-pci+bounces-33347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F8B19BB0
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 08:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5504E0512
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A421C9E0;
	Mon,  4 Aug 2025 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY0Nkycm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BC1519B4;
	Mon,  4 Aug 2025 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290094; cv=none; b=EySG06otyc6S0IWqvBCrO4cUXDssgyuzFioy2LiaiSIHY0V3FPzOWNySEgdOhWvVmg0nxOiZhY90YQFH6dBPXC+JEgv2u0MuBnXQc/yZRd1Ufrc33GR3tAs7wB6vVuCm8V8xyBIsz1lv1DcE1lrCjEI+WoGKDue+UqUegZGeWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290094; c=relaxed/simple;
	bh=7b86ktl8Kd0dNQLOTWgRUpclUkbnkV3ZihCMNpnAaRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QFm6EP6oBhpgLauAuA+Nfhqi4MB8TasbuaBsl6tDwo4DjE/9YkzS6D0rVWkZLsCmF+UIS30YReKT+fzRA0fJMUWgK97M2xnfnMhzd/7571o9/cNr8cjZo9ieHXvmTdHqt0EjwZIuTGtZ+y9Ikriyw2dlH33PXe3dAs2zmG4Rbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY0Nkycm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B7FC4CEE7;
	Mon,  4 Aug 2025 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754290093;
	bh=7b86ktl8Kd0dNQLOTWgRUpclUkbnkV3ZihCMNpnAaRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GY0Nkycm5qevIDou3p+1brViZOgczNuE4HEDy0N39Jl8GOJ69Cfsy6Aum8tw0Vw8z
	 LbFnT8qZlQIjRGAMWqFHIQ5tur6L4bVyILkZoCtEhXqFbFF5ZdsEy3RAUJuB4eQE54
	 B57Cz4cTNIwX333ANSyNwErqcEFLEuK8Ai7Lq26MS1T/+JxsDxvzufg3pHMpj7QMbE
	 Ya9W0lTz/1ngEsLskj+weOU57dU+MOnq0bNR21BG1AQQY4ixcqIkfzWtoUJglLboE+
	 NSmCVuF3TA5ytDIN6KMDIl4dhu5zOrYQfq6DAp6wtR8/c3eQhrRurRfxqEvEHzRW6o
	 JY3gjIyU/7TbA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 38/38] coco: guest: arm64: Add support for
 fetching device info
In-Reply-To: <20250731113653.000000cd@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-39-aneesh.kumar@kernel.org>
 <20250731113653.000000cd@huawei.com>
Date: Mon, 04 Aug 2025 12:18:06 +0530
Message-ID: <yq5ao6sv8tw9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:22:15 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>

...

>> +	return ret;
>> +}
>> +
>>  int rsi_device_lock(struct pci_dev *pdev)
>>  {
>>  	unsigned long ret;
>>  	unsigned long tdisp_version;
>>  	struct rsi_device_measurements_params *rsi_dev_meas;
>> +	struct rsi_device_info *dev_info;
>>  	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
>>  	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
>>  		PCI_DEVID(pdev->bus->number, pdev->devfn);
>> @@ -252,8 +344,44 @@ int rsi_device_lock(struct pci_dev *pdev)
>>  		return -EIO;
>>  	}
>>  
>> +	/* RMM expects sizeof(dev_info) (512 bytes) aligned address */
>> +	dev_info = kmalloc(sizeof(*dev_info), GFP_KERNEL);
>
> Use a __free(kfree) here (and direct returns on errors) given it's freed
> in all paths and we don't care if it is freed before or after verifying the digests.
>
> I'm being slow today, but what in that enforces the alignment?  I guess
> it's that the structure happens to be big enough that it happens naturally?
>
> I'd allocate max(512, sizeof(*dev_info)) to make it explicitly the case.
>

yes, struct rsi_device_info is 512 bytes.

>
>> +	if (!dev_info) {
>> +		ret = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	ret = rsi_rdev_get_info(vdev_id, dsm->instance_id, virt_to_phys(dev_info));
>> +	if (ret != RSI_SUCCESS) {
>> +		pci_err(pdev, "failed to get device digests (%lu)\n", ret);
>> +		ret = -EIO;
>> +		kfree(dev_info);
>> +		goto err_out;
>> +	}
>> +
>> +	dsm->dev_info.attest_type   = dev_info->attest_type;
>> +	dsm->dev_info.cert_id       = dev_info->cert_id;
>> +	dsm->dev_info.hash_algo     = dev_info->hash_algo;
>> +	memcpy(dsm->dev_info.cert_digest, dev_info->cert_digest, SHA512_DIGEST_SIZE);
>> +	memcpy(dsm->dev_info.meas_digest, dev_info->meas_digest, SHA512_DIGEST_SIZE);
>> +	memcpy(dsm->dev_info.report_digest, dev_info->report_digest, SHA512_DIGEST_SIZE);
>> +
>
> Can't you memcpy the whole thing in one go?
>

yes. But won't that be confusing? Is there a difference?
Also struct dsm_device_info is not same as struct rsi_device_info. We
don't need to keep all that padding in dsm_device_info.

>
>> +	kfree(dev_info);
>> +	/*
>> +	 * Verify that the digests of the provided reports match with the
>> +	 * digests from RMM
>> +	 */
>> +	ret = verify_digests(dsm);
>> +	if (ret) {
>> +		pci_err(pdev, "device digest validation failed (%ld)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +err_out:
> I'll always grumble about these.  To me it always makes the code
> less readable. Some others disagree though ;( 
>>  	return ret;
>>  }
>> +
>
> Looks like this should have been in an earlier patch.
>
>>  static inline unsigned long rsi_rdev_start(struct pci_dev *pdev,
>>  					   unsigned long vdev_id, unsigned long inst_id)
>>  {
>> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
>> index f26156d9be81..e8953b8e85a3 100644
>> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
>> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
>> @@ -10,6 +10,7 @@
>>  #include <linux/pci-tsm.h>
>>  #include <asm/rsi_smc.h>
>>  #include <asm/rhi.h>
>> +#include <crypto/sha2.h>
>>  
>>  struct pci_tdisp_device_interface_report {
>>  	u16 interface_info;
>> @@ -33,6 +34,17 @@ struct pci_tdisp_mmio_range {
>>  #define TSM_INTF_REPORT_MMIO_RESERVED		GENMASK(15, 4)
>>  #define TSM_INTF_REPORT_MMIO_RANGE_ID		GENMASK(31, 16)
>>  
>> +struct dsm_device_info {
>> +	u64 flags;
>> +	u64 attest_type;
>> +	u64 cert_id;
>> +	u64 hash_algo;
>> +	u8 cert_digest[SHA512_DIGEST_SIZE];
>> +	u8 meas_digest[SHA512_DIGEST_SIZE];
>> +	u8 report_digest[SHA512_DIGEST_SIZE];
>> +};
>> +
>
> One probably enough.
>
>> +
>>  struct cca_guest_dsc {
>>  	struct pci_tsm_pf0 pci;
>>  	unsigned long instance_id;
>> @@ -42,6 +54,7 @@ struct cca_guest_dsc {
>>  	int certificate_size;
>>  	void *measurements;
>>  	int measurements_size;
>> +	struct dsm_device_info dev_info;
>>  };
>>  
>>  static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)

-aneesh

