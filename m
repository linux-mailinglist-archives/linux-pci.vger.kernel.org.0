Return-Path: <linux-pci+bounces-41927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DBC7F013
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 06:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF783A53F6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041921ABD7;
	Mon, 24 Nov 2025 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V05MYAE7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FB4A21;
	Mon, 24 Nov 2025 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763962944; cv=none; b=mwk0Pxv9DSb69buxeL4dSZQf523xVw/q8EM1+yXLZvNjg8XQiAKLrE7rF1DDUIW2fz2BGohPwa5vRRhucIEjsjiiYuc2zvuJbKdEaQghE0tqUJwL9LHSU6/EMTfzhW4wlUsCyOd+y20NbOBga9F4aMKO/wGejTU1EQsNq8OLxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763962944; c=relaxed/simple;
	bh=fCANZX8ArOxktHRpk6JudluNGFV1x3UGO2dKTaEN+t4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DR4f0kSQk+fzd+NnQJIk89+oIdwiQjrgy+NqlVBqF2P2JJgRKZ0C0tDFyYPZIfVNU8NgtLEeMni0hYKjk4bPzQ0sdCVTT1BAVwIV4bZJkwt47DZmLVW37wEwA/SL/TZxNCqjgzpcRZZ1i4ZP7oI+0nRaxGy1g3+Z9RacUfHKaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V05MYAE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66486C4CEF1;
	Mon, 24 Nov 2025 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763962943;
	bh=fCANZX8ArOxktHRpk6JudluNGFV1x3UGO2dKTaEN+t4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V05MYAE7Bazc+evT+axIb7qR+/slkoAej8f+d7dvjiC27t2eZoB0MAb6hNhrZ9DWG
	 WVjzYD1+cN2Hs1tqFjsJm5nvYBS8x8wfCZYUjxNpsCk35YW9G3/YRRlPA64WIx5ExR
	 TC3Z5JFva+HOHfVmiK7jvIO6ZRCXCIJJNUM4IIx5t5JPRrx4UmxpP4nRCqh0OTu38L
	 JFSQ/HnoM23XUUiMztGm+ormEH0JF3AyFpu01yNeQCdc9LT7RXMAQVdTiiOxAQXN0C
	 C4bAIYfTRTxtRGBhaNuB0JYnrt5u5x1cGeVz60ztd3ln+cRFznijVjNpJYeporhjgn
	 915EvaezKbsvA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 04/11] coco: guest: arm64: Add support for updating
 interface reports from device
In-Reply-To: <20251119155444.00002925@huawei.com>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
 <20251117140007.122062-5-aneesh.kumar@kernel.org>
 <20251119155444.00002925@huawei.com>
Date: Mon, 24 Nov 2025 11:12:13 +0530
Message-ID: <yq5a7bvgm1fu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 17 Nov 2025 19:30:00 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Support collecting interface reports using RSI calls. The fetched
>> interface report will be cached in the host.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
>> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> index f4c9e529c43e..7988ff6d4b2e 100644
>> --- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> @@ -212,6 +212,12 @@ static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pde
>>  	if (ret)
>>  		return ERR_PTR(-EIO);
>>  
>> +	ret = cca_update_device_object_cache(pdev, cca_dsc);
>> +	if (ret) {
>> +		cca_device_unlock(pdev);
>> +		return ERR_PTR(-EIO);
>
> Why not return ERR_PTR(ret);
>
>> +	}
>> +
>>  	return &no_free_ptr(cca_dsc)->pci.base_tsm;
>>  }
>>  
>> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
>> index 3430d8df4424..f4fb8577e1b5 100644
>> --- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
>> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
>> @@ -156,3 +156,47 @@ int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state)
>>  
>>  	return ret;
>>  }
>> +
>> +static inline int rhi_vdev_get_interface_report(unsigned long vdev_id,
>> +						unsigned long *cookie)
>> +{
>> +	unsigned long ret;
>> +
>> +	struct rsi_host_call *rhi_call __free(kfree) =
>> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
>> +	if (!rhi_call)
>> +		return -ENOMEM;
>> +
>> +	rhi_call->imm = 0;
>> +	rhi_call->gprs[0] = RHI_DA_VDEV_GET_INTERFACE_REPORT;
>> +	rhi_call->gprs[1] = vdev_id;
>> +
>> +	ret = rsi_host_call(virt_to_phys(rhi_call));
>
> Given every rsi_host_call I've seen in here is passed
> output of virt_to_phys() maybe a wrapper that does that is worthwhile?
>
> rsi_host_call_va() or something like that.
>

how about static inline unsigned long rsi_host_call(struct rsi_host_call *rhi_call)


>
>> +	if (ret != RSI_SUCCESS)
>> +		return -EIO;
>> +
>> +	*cookie = rhi_call->gprs[1];
>> +	return map_rhi_da_error(rhi_call->gprs[0]);
>> +}
>
>
>> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
>> index d1f4641a0fa1..fd4792a50daf 100644
>> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
>> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
>> @@ -31,4 +31,6 @@ static inline int rsi_vdev_id(struct pci_dev *pdev)
>>  
>>  int cca_device_lock(struct pci_dev *pdev);
>>  int cca_device_unlock(struct pci_dev *pdev);
>> +int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc);
>> +
>
> If the blank line makes sense, should have been in previous patch.
>
>>  #endif

