Return-Path: <linux-pci+bounces-41929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A8C7F202
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 07:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6362B4E28B1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23842DF709;
	Mon, 24 Nov 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgJO0TOp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0236D516;
	Mon, 24 Nov 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967185; cv=none; b=Jhr5lsZpQ38VMb8fCP8HiiVI/Z5Y9B9a0xUnhHAI3OgyoAGb7bRPVvmdz5tzuVA6+CyJOHQQMSMCoAXOGk1k5UUt+hCXrqS5gltXz6Yky58ZvaKKV6KVluV93P+bzJ4h/lTTjm/cbpetdhTBq8woQvdmLtU7uRojNjdaOMrQvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967185; c=relaxed/simple;
	bh=Cu2gZM8Ea+LBM9J8F6F1G01+nTGJqvtDtgiM++k7TVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DWuvj2veLu3ytvSTAPKYQewkLC/30fyrYOEWkSk4gBtMYLRP+pMNg7K56hAjdNiGIeJl0jstbOloKXcBi6wtvfQVrqW4ce/7NO7caKZSt/Nfb14XY5BuqRZMwmD/+23FU45/rlkl2rcWIHCYEP/kWBdjzMoPA2ERzanEx9dyO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgJO0TOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E646C16AAE;
	Mon, 24 Nov 2025 06:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763967185;
	bh=Cu2gZM8Ea+LBM9J8F6F1G01+nTGJqvtDtgiM++k7TVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RgJO0TOpCqQouLk8XmfYYmcdnNa6mc4fYFKwOb8HrlfyIjxpNTOXg6VLrD2ewZtom
	 EikgBg358yCa35nE7ZaTNi/0yTTFGVq9s5AZfMbUVdajGE884slxxDpoIEjHlG4K9P
	 JHNx7W+YDzzfUH5XL6BdLLYJMsF/LQclWaPMXoyHwWjkxDZ8TLDX9TCY0fi7+F5fVo
	 dhFtkCNeP2TgkY98LTQHoAahmfILYM1fn3PXsi0qW/2GBX+ZuUx1Jrcr66AuWGRUCt
	 gzhyqSTDM5WKnnQWSRl2/1uXiMNq1VBd/tm2mGg7MK4nHzBmv1nKe925s/IQnTO9qj
	 uScNUyuHwEmpA==
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
Subject: Re: [PATCH v2 06/11] coco: guest: arm64: Add support for reading
 cached objects from host
In-Reply-To: <20251120173157.00007fc4@huawei.com>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
 <20251117140007.122062-7-aneesh.kumar@kernel.org>
 <20251120173157.00007fc4@huawei.com>
Date: Mon, 24 Nov 2025 12:22:56 +0530
Message-ID: <yq5a1plnncqf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 17 Nov 2025 19:30:02 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Teach rsi_device_start() to pull the interface report and device
>> certificate from the host by querying size, sharing a decrypted buffer
>> for the read, copying the payload to private memory. Also track the
>> fetched blobs in struct cca_guest_dsc so later stages can hand them to
>> the attestation flow.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  arch/arm64/include/asm/rhi.h             |  7 +++
>>  drivers/virt/coco/arm-cca-guest/rhi-da.c | 80 ++++++++++++++++++++++++
>>  drivers/virt/coco/arm-cca-guest/rhi-da.h |  1 +
>>  drivers/virt/coco/arm-cca-guest/rsi-da.h |  8 +++
>>  4 files changed, 96 insertions(+)
>>=20
>> diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
>> index ce2ed8a440c3..738470dfb869 100644
>> --- a/arch/arm64/include/asm/rhi.h
>> +++ b/arch/arm64/include/asm/rhi.h
>> @@ -39,6 +39,13 @@
>>  				 RHI_DA_FEATURE_VDEV_SET_TDI_STATE)
>>  #define RHI_DA_FEATURES			SMC_RHI_CALL(0x004B)
>>=20=20
>> +#define RHI_DA_OBJECT_CERTIFICATE		0x1
>> +#define RHI_DA_OBJECT_MEASUREMENT		0x2
>> +#define RHI_DA_OBJECT_INTERFACE_REPORT		0x3
>> +#define RHI_DA_OBJECT_VCA			0x4
>> +#define RHI_DA_OBJECT_SIZE		SMC_RHI_CALL(0x004C)
>> +#define RHI_DA_OBJECT_READ		SMC_RHI_CALL(0x004D)
>> +
>>  #define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
>>  #define RHI_DA_VDEV_GET_INTERFACE_REPORT SMC_RHI_CALL(0x0052)
>>=20=20
>> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coc=
o/arm-cca-guest/rhi-da.c
>> index aa17bb3ee562..d29aee0fca58 100644
>> --- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
>> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
>> @@ -248,3 +248,83 @@ int rhi_update_vdev_measurements_cache(struct pci_d=
ev *pdev,
>>=20=20
>>  	return ret;
>>  }
>> +
>> +int rhi_read_cached_object(int vdev_id, int da_object_type, void **obje=
ct, int *object_size)
>> +{
>> +	int ret;
>> +	int max_data_len;
>> +	struct page *shared_pages;
>> +	void *data_buf_shared, *data_buf_private;
>> +	struct rsi_host_call *rhicall;
>> +
>> +	rhicall =3D kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
>> +	if (!rhicall)
>> +		return -ENOMEM;
>> +
>> +	rhicall->imm =3D 0;
>> +	rhicall->gprs[0] =3D RHI_DA_OBJECT_SIZE;
>> +	rhicall->gprs[1] =3D vdev_id;
>> +	rhicall->gprs[2] =3D da_object_type;
>> +
>> +	ret =3D rsi_host_call(virt_to_phys(rhicall));
>> +	if (ret !=3D RSI_SUCCESS) {
>> +		ret =3D -EIO;
>> +		goto err_return;
>> +	}
>> +
>> +	if (rhicall->gprs[0] !=3D RHI_DA_SUCCESS) {
>> +		ret =3D -EIO;
>> +		goto err_return;
>> +	}
>> +
>> +	/* validate against the max cache object size used on host. */
>> +	max_data_len =3D rhicall->gprs[1];
>> +	if (max_data_len > MAX_CACHE_OBJ_SIZE || max_data_len =3D=3D 0) {
>> +		ret =3D -EIO;
>> +		goto err_return;
>> +	}
>> +	*object_size =3D max_data_len;
>
> I raise this below, but not sure why this is set way before setting
> *object.  Can set it later and use max_data_len which I think is
> clearer naming anyway.
>
>> +
>> +	data_buf_private =3D kmalloc(*object_size, GFP_KERNEL);
>> +	if (!data_buf_private) {
>> +		ret =3D -ENOMEM;
>> +		goto err_return;
>> +	}
>> +
>> +	shared_pages =3D alloc_shared_pages(NUMA_NO_NODE, GFP_KERNEL, max_data=
_len);
>> +	if (!shared_pages) {
>> +		ret =3D -ENOMEM;
>> +		goto err_shared_alloc;
>> +	}
>> +	data_buf_shared =3D page_address(shared_pages);
>> +
>> +	rhicall->imm =3D 0;
>> +	rhicall->gprs[0] =3D RHI_DA_OBJECT_READ;
>> +	rhicall->gprs[1] =3D vdev_id;
>> +	rhicall->gprs[2] =3D da_object_type;
>> +	rhicall->gprs[3] =3D 0; /* offset within the data buffer */
>> +	rhicall->gprs[4] =3D max_data_len;
>> +	rhicall->gprs[5] =3D virt_to_phys(data_buf_shared);
>> +	ret =3D rsi_host_call(virt_to_phys(rhicall));
>> +	if (ret !=3D RSI_SUCCESS || rhicall->gprs[0] !=3D RHI_DA_SUCCESS) {
>> +		ret =3D -EIO;
>> +		goto err_rhi_call;
>> +	}
>> +
>> +	memcpy(data_buf_private, data_buf_shared, *object_size);
>
> Given data_buf_private() only seems useful if we aren't in an error
> condition, why not move allocation to here and use kmemdup() ?
>
>> +	free_shared_pages(shared_pages, max_data_len);
>> +
>> +	*object =3D data_buf_private;
>> +	kfree(rhicall);
>> +	return 0;
>> +
>> +err_rhi_call:
>> +	free_shared_pages(shared_pages, max_data_len);
>> +err_shared_alloc:
>> +	kfree(data_buf_private);
>> +err_return:
>> +	*object =3D NULL;
>
> Is it necessary to zero the passed in variable given this function never
> touched it and is returning an error. If it is, can you do that unconditi=
onally
> at start of function and override only on success?
>
>> +	*object_size =3D 0;
>
> Likewise for the size - I'm not sure why you set that much earlier
> than *object.
>
> With those two gone, this feels like it would be well suited for
> some __free magic to handle everything here.
> You will need to deal with the free_shared_pages() though which will
> require an extra structure definition and helpers to wrap up what
> is allocated - similar to what tdx_page_array_alloc does (though without
> the bulk aspects of that)
>
> http://lore.kernel.org/all/20251117022311.2443900-7-yilun.xu@linux.intel.=
com/
>
> Or given the shared page stuff is the inner most aspect anyway you could
> just do a helper function from alloc_shared_pages to free_shared_pages
> calls so that you can call that free_shared_pages unconditionally before
> checking return value.
>
> Note that if you do go with DEFINE_FREE() you 'could' pass in the storage.
> I objected to that elsewhere but there is precedence.  So have a
> struct shared_pages {
> 	struct page *page;
> 	size_t order;
> }
> define one on the stack and pass it in so that you avoid an extra allocat=
ion.
> Not a pattern I particularly like though and this isn't expected to be
> a particularly fast path so I'd just dynamically allocate a struct shared=
_pages
> inside alloc_shared_pages.
>
>
>> +	kfree(rhicall);
>> +	return ret;
>> +}

I'm not sure we need a new struct here, since other shared pages do have
type like struct rhi_vdev_measurement_params. The read-cached object is
the only exception.

That said, I=E2=80=99ve updated the other allocation to use __free() as sug=
gested.

int rhi_read_cached_object(int vdev_id, int da_object_type, void **object, =
int *object_size)
{
	int ret;
	int max_data_len;
	void *data_buf_shared;
	struct page *shared_pages;

	*object_size =3D 0;
	*object =3D NULL;

	struct rsi_host_call *rhicall __free(kfree) =3D
		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
	if (!rhicall)
		return -ENOMEM;

	rhicall->imm =3D 0;
	rhicall->gprs[0] =3D RHI_DA_OBJECT_SIZE;
	rhicall->gprs[1] =3D vdev_id;
	rhicall->gprs[2] =3D da_object_type;

	ret =3D rsi_host_call(virt_to_phys(rhicall));
	if (ret !=3D RSI_SUCCESS)
		return -EIO;

	if (rhicall->gprs[0] !=3D RHI_DA_SUCCESS)
		return -EIO;

	/* validate against the max cache object size used on host. */
	max_data_len =3D rhicall->gprs[1];
	if (max_data_len > MAX_CACHE_OBJ_SIZE || max_data_len =3D=3D 0)
		return -EIO;

	shared_pages =3D alloc_shared_pages(NUMA_NO_NODE, GFP_KERNEL, max_data_len=
);
	if (!shared_pages)
		return -ENOMEM;

	data_buf_shared =3D page_address(shared_pages);

	rhicall->imm =3D 0;
	rhicall->gprs[0] =3D RHI_DA_OBJECT_READ;
	rhicall->gprs[1] =3D vdev_id;
	rhicall->gprs[2] =3D da_object_type;
	rhicall->gprs[3] =3D 0; /* offset within the data buffer */
	rhicall->gprs[4] =3D max_data_len;
	rhicall->gprs[5] =3D virt_to_phys(data_buf_shared);
	ret =3D rsi_host_call(virt_to_phys(rhicall));
	if (ret !=3D RSI_SUCCESS || rhicall->gprs[0] !=3D RHI_DA_SUCCESS) {
		free_shared_pages(shared_pages, max_data_len);
		return -EIO;
	}

	void *data_buf_private __free(kvfree) =3D
		kvmemdup(data_buf_shared, max_data_len, GFP_KERNEL);
	/* free the shared pages irrespective of error condition */
	free_shared_pages(shared_pages, max_data_len);
	if (!data_buf_private)
		return -ENOMEM;

	*object =3D data_buf_private;
	*object_size =3D max_data_len;
	return 0;
}

