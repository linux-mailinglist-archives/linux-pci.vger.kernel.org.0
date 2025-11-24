Return-Path: <linux-pci+bounces-41928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B2C7F064
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 07:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690BC3A490D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 06:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C884256C88;
	Mon, 24 Nov 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiJTm6Rj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40A14A8E;
	Mon, 24 Nov 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965135; cv=none; b=KOME79MvqruqCH2XhCoSOBwdVMEA3c7W9oQkYztLyR/IDuYlG8InD4rIcUKOi5UH2zjHApRxePeAoIgnnD25+14BbwZ9zI1v1SnyghU7mDMkSfx1oCPkv8phvaaT2ho1nanQyjX/f/n7PPwOGoQAra9LW8p6OmqlGdooMs9yx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965135; c=relaxed/simple;
	bh=VgRzO/uJhZP6huikodYKZ1hLtAT1aBCud7BEPC+JdeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvpruycYdQvWBmL6Ap+Bu9K8tkTyJLoN91C0Vh6XtPx2LmxGXRWzQABCwQTaPUW/P6x9J4wHk8zMawJGm0SP7Dq89ycm0IYGoLzsV9p6mrq/wVFI8qU6SZiVkR/Wx5G+jYmUsSEEhKEw0rHKJrvNAavtLm5OSfSXXKI4Q40yne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiJTm6Rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBB3C4CEF1;
	Mon, 24 Nov 2025 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763965134;
	bh=VgRzO/uJhZP6huikodYKZ1hLtAT1aBCud7BEPC+JdeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qiJTm6RjpMNKHW3pqTAN9Msso8SBtt2/ouGPHGZh/Z6KJrUAPvJ9oRA6Z0gfbMpaL
	 bRT4mq9lfiux1anGMzGI9NBDMCOzLBEjCT6o5QyMOkI0PBvhDVJoIG9ynDbZLwWnyJ
	 OV2VVIktOvl9q/lnvtAPIe89AiWAirpimyJYTPBLBEF2mrDcCIMGCrQ2B6Lf+JngoJ
	 u6V2XMJrpDWoCGYyXLswwi0/5uf2olkkInn+c/ysKYgCsMA/N2u50JavBuMxoO7Vwg
	 kc3zUH18hlU8tte9whFGkkcfnXVHmYoa6CjdLOcrnrPQjVnijGGIQBCKiO4COTwdCS
	 AQdWv5eYUjgZg==
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
Subject: Re: [PATCH v2 05/11] coco: guest: arm64: Add support for updating
 measurements from device
In-Reply-To: <20251120152202.00001efb@huawei.com>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
 <20251117140007.122062-6-aneesh.kumar@kernel.org>
 <20251120152202.00001efb@huawei.com>
Date: Mon, 24 Nov 2025 11:48:45 +0530
Message-ID: <yq5a4iqklzqy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 17 Nov 2025 19:30:01 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Fetch device measurements using RSI_RDEV_GET_MEASUREMENTS. The fetched
>> device measurements will be cached in the host.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Hi Aneesh
>
> Minor stuff inline.
>
> thanks
>
> Jonathan
>
>> ---
>>  arch/arm64/include/asm/rhi.h             | 19 ++++++++
>>  drivers/virt/coco/arm-cca-guest/rhi-da.c | 48 ++++++++++++++++++++
>>  drivers/virt/coco/arm-cca-guest/rhi-da.h |  2 +
>>  drivers/virt/coco/arm-cca-guest/rsi-da.c | 58 ++++++++++++++++++++++++
>>  drivers/virt/coco/arm-cca-guest/rsi-da.h |  2 +
>>  5 files changed, 129 insertions(+)
>>=20
>> diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
>> index 5f140015afc3..ce2ed8a440c3 100644
>> --- a/arch/arm64/include/asm/rhi.h
>> +++ b/arch/arm64/include/asm/rhi.h
>> @@ -42,6 +42,25 @@
>>  #define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
>>  #define RHI_DA_VDEV_GET_INTERFACE_REPORT SMC_RHI_CALL(0x0052)
>>=20=20
>> +#define RHI_VDEV_MEASURE_SIGNED		BIT(0)
>> +#define RHI_VDEV_MEASURE_RAW		BIT(1)
>> +#define RHI_VDEV_MEASURE_EXCHANGE	BIT(2)
> Whilst I appreciate the specs are still subject to minor changes,=20
> it would be very helpful if definitions like the ones above were
> all accompanied by a spec reference.
>
> Which is another way of saying I can't find these ones ;)
>

The RHI spec update is still pending. In the meantime, the relevant
details can be found in the RMI spec under section B4.4.69, which
describes the RmiVdevMeasureFlags type. I=E2=80=99ll update the cover lette=
r to
reference the specific spec details that these patches are based on.

>
>> +struct rhi_vdev_measurement_params {
>> +	union {
>> +		u64 flags;
>> +		u8 padding0[256];
>> +	};
>> +	union {
>> +		u8 indices[32];
>> +		u8 padding1[256];
>> +	};
>> +	union {
>> +		u8 nonce[32];
>> +		u8 padding2[256];
>> +	};
>> +};
>> +#define RHI_DA_VDEV_GET_MEASUREMENTS	SMC_RHI_CALL(0x0053)
>> +
>>  #define RHI_DA_TDI_CONFIG_UNLOCKED		0x0
>>  #define RHI_DA_TDI_CONFIG_LOCKED		0x1
>>  #define RHI_DA_TDI_CONFIG_RUN			0x2
>> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coc=
o/arm-cca-guest/rhi-da.c
>> index f4fb8577e1b5..aa17bb3ee562 100644
>> --- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
>> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
>> @@ -200,3 +200,51 @@ int rhi_update_vdev_interface_report_cache(struct p=
ci_dev *pdev)
>>=20=20
>>  	return ret;
>>  }
>> +
>> +static inline int rhi_vdev_get_measurements(unsigned long vdev_id,
>> +					    phys_addr_t vdev_meas_phys,
>> +					    unsigned long *cookie)
>> +{
>> +	unsigned long ret;
>> +
>> +	struct rsi_host_call *rhi_call __free(kfree) =3D
>> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
>
> sizeof(*rhi_call) slightly preferred.
>
>> +	if (!rhi_call)
>> +		return -ENOMEM;
>> +
>> +	rhi_call->imm =3D 0;
>> +	rhi_call->gprs[0] =3D RHI_DA_VDEV_GET_MEASUREMENTS;
>> +	rhi_call->gprs[1] =3D vdev_id;
>> +	rhi_call->gprs[2] =3D vdev_meas_phys;
>> +
>> +	ret =3D rsi_host_call(virt_to_phys(rhi_call));
>> +	if (ret !=3D RSI_SUCCESS)
>> +		return -EIO;
>> +
>> +	*cookie =3D rhi_call->gprs[1];
>> +	return map_rhi_da_error(rhi_call->gprs[0]);
>> +}
>> +
>
>
>> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coc=
o/arm-cca-guest/rsi-da.c
>> index c8ba72e4be3e..aa6e13e4c0ea 100644
>> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
>> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
>> @@ -4,6 +4,7 @@
>>   */
>>=20=20
>>  #include <linux/pci.h>
>> +#include <linux/mem_encrypt.h>
>>  #include <asm/rsi_cmds.h>
>>=20=20
>>  #include "rsi-da.h"
>> @@ -35,9 +36,50 @@ int cca_device_unlock(struct pci_dev *pdev)
>>  	return 0;
>>  }
>>=20=20
>> +struct page *alloc_shared_pages(int nid, gfp_t gfp_mask, unsigned long =
min_size)
>> +{
>> +	int ret;
>> +	struct page *page;
>> +	/* We should normalize the size based on hypervisor page size */
>> +	int page_order =3D get_order(min_size);
>> +
>> +	/* Always request for zero filled pages */
>
> Not sure the comment is necessary given the visible flag.
> If you were saying 'why' then a comment would be fine, but this is just
> repeating what we can see in the code.
>
>> +	page =3D alloc_pages_node(nid, gfp_mask | __GFP_ZERO, page_order);
>> +
>> +	if (!page)
>> +		return NULL;
>> +
>> +	ret =3D set_memory_decrypted((unsigned long)page_address(page),
>> +				   1 << page_order);
>> +	/*
>> +	 * If set_memory_decrypted() fails then we don't know what state the
>> +	 * page is in, so we can't free it. Instead we leak it.
>> +	 * set_memory_decrypted() will already have WARNed.
>> +	 */
>> +	if (ret)
>> +		return NULL;
>> +
>> +	return page;
>> +}
>> +
>> +int free_shared_pages(struct page *page, unsigned long min_size)
>> +{
>> +	int ret;
>> +	/* We should normalize the size based on hypervisor page size */
>> +	int page_order =3D get_order(min_size);
>> +
>> +	ret =3D set_memory_encrypted((unsigned long)page_address(page), 1 << p=
age_order);
>> +	/* If we fail to mark it encrypted don't free it back */
>> +	if (!ret)
>> +		__free_pages(page, page_order);
>> +	return ret;
> If failing to mark it encrypted is an error I'd find it easier to read th=
is if it were
> out of line.
>
> 	ret =3D set_memory...
> 	if (ret)
> 		return ret;
>
> 	__free_pages();
>
> 	return 0;
>
> This is just a preference as someone who reads a lot of code.  Having err=
or handling
> as the out of line path is more common and so what my brain (and other re=
viewers)
> has long been trained to expect.
>
>> +}
>> +
>>  int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_gue=
st_dsc *dsc)
>>  {
>>  	int ret;
>> +	struct page *shared_pages;
>> +	struct rhi_vdev_measurement_params *dev_meas;
>>=20=20
>>  	ret =3D rhi_update_vdev_interface_report_cache(pdev);
>>  	if (ret) {
>> @@ -45,5 +87,21 @@ int cca_update_device_object_cache(struct pci_dev *pd=
ev, struct cca_guest_dsc *d
>>  		return ret;
>>  	}
>>=20=20
>> +	shared_pages =3D alloc_shared_pages(NUMA_NO_NODE, GFP_KERNEL, sizeof(s=
truct rhi_vdev_measurement_params));
>
> Perhaps sizeof(*dev_meas) would be both shorter and clearer.
>
>> +	if (!shared_pages)
>> +		return -ENOMEM;
>> +
>> +	dev_meas =3D (struct rhi_vdev_measurement_params *)page_address(shared=
_pages);
>> +	/* request for signed full transcript */
>> +	dev_meas->flags =3D RHI_VDEV_MEASURE_SIGNED | RHI_VDEV_MEASURE_EXCHANG=
E;
>> +	/* request all measurement block. Set bit 254 */
>> +	dev_meas->indices[31] =3D 0x40;
>> +	ret =3D rhi_update_vdev_measurements_cache(pdev, dev_meas);
>> +
>> +	free_shared_pages(shared_pages, sizeof(struct rhi_vdev_measurement_par=
ams));
>
> It might be worth appropriate DEFINE_FREE() magic to to stash the size aw=
ay
> and simplify this a tiny bit. Kind of depends on whether this is a one off
> or those helpers are going to get a reasonable amount of use.
>

something like

static inline void vdev_meas_params_free(struct rhi_vdev_measurement_params=
 *params)
{
	struct page *pages =3D virt_to_page(params);

	free_shared_pages(pages, sizeof(struct rhi_vdev_measurement_params));
}
DEFINE_FREE(vdev_meas_params_free, struct rhi_vdev_measurement_params *, if=
 (_T) vdev_meas_params_free(_T))


>
>> +	if (ret) {
>> +		pci_err(pdev, "failed to get device measurement (%d)\n", ret);
>> +		return ret;
>> +	}
>>  	return 0;
>>  }

-aneesh

