Return-Path: <linux-pci+bounces-33130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F701B15166
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04C87A8F50
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157B5226D1F;
	Tue, 29 Jul 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yZ2dsgwS"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3581E3DCD;
	Tue, 29 Jul 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806912; cv=none; b=Oho2rrDiVlQCXkphuGyNMsUbHmZPj6i5jhpMfSeGfpJUAf1YOvfMBYDXBdx69ZFcAWLATaRo+Kn1NFvdY2hLS8q8zGDRH17jO3EKwbozlHHTElBKkMT00qaFyLLZVATsa/0QD1LBjE6/Fl1x6pCaTCi368WUhp6Ltbf/7/WPFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806912; c=relaxed/simple;
	bh=uhXRJ6IyDLMP9Z15gFI0h8PKRse3tik+B8zWV9ZKNHw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj7zNHros/IAraLuCXtdeBGKRkAcuuINrp1Zus8H6NyQbXJZRcXBaKypaJvTPa5PUzqxRxyOw/Sdwzw2EB8TcE1IZw6Du5JCEQnEntfDWISYAciV7waVaAQXaqqHhSw9sVMAR/yp3CM0HBHT1M2GmgAvzRdxS+t+QpKxLBzOYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yZ2dsgwS; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0AwX89Bu5mpaJMQMiFuogUCn3kOvmWY/Sf9by/FSvZk=;
	b=yZ2dsgwSQzdVfrKvac0jXQyCx6cWRxb36GlCmRC5CDajRPqusjAOezpAtVaURzqbQKRdENCTW
	POB+MKR2i0/5I6t0fozearkXnLIgUgzakVuCdPhCDTfP/VyKigKs1J4J1WUgpQoYDayBH3Ziz6N
	0bYY7+nSvClAxdEe+62rXw0=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4bs1BF3Vs8z1P7K4;
	Wed, 30 Jul 2025 00:33:41 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs16y3n42z67QqC;
	Wed, 30 Jul 2025 00:30:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D1411402EA;
	Wed, 30 Jul 2025 00:35:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 18:35:00 +0200
Date: Tue, 29 Jul 2025 17:34:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <aik@amd.com>, <lukas@wunner.de>, Samuel
 Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven
 Price <steven.price@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	"Marc Zyngier" <maz@kernel.org>, Will Deacon <will@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 08/38] iommufd/tsm: Add tsm_op iommufd ioctls
Message-ID: <20250729173458.00003ca5@huawei.com>
In-Reply-To: <20250728135216.48084-9-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-9-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:21:45 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add operations bind and unbind used to bind a TDI to the secure guest.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Hi Aneesh,

I'm mostly reading this to get head around it rather than fully review
at this point.

A few things inline though that I noticed whilst doing so.

Jonathan

> ---
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  drivers/iommu/iommufd/main.c            |  3 ++
>  drivers/iommu/iommufd/viommu.c          | 50 +++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c        | 10 +++++
>  include/uapi/linux/iommufd.h            | 18 +++++++++
>  5 files changed, 82 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index fce68714c80f..e08186f1d102 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -697,6 +697,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
>  void iommufd_vdevice_abort(struct iommufd_object *obj);
>  int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_hw_queue_destroy(struct iommufd_object *obj);
> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
>  
>  static inline struct iommufd_vdevice *
>  iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)

> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 59f1e1176f7f..c934312e5397 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -162,6 +162,9 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
>  
>  	lockdep_assert_held(&idev->igroup->lock);
>  
> +#ifdef CONFIG_TSM
Can we use stubs for some of this stuff so we don't need ifdefs in as many
places.

> +	tsm_unbind(idev->dev);
> +#endif
>  	if (vdev->destroy)
>  		vdev->destroy(vdev);
>  	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
> @@ -471,3 +474,50 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	iommufd_put_object(ucmd->ictx, &viommu->obj);
>  	return rc;
>  }
> +
> +#ifdef CONFIG_TSM
> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)

Might want to split this out to a separate c file and use stubs in a header to
keep the code clean here.

> +{
> +	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
> +	struct iommufd_vdevice *vdev;
> +	struct kvm *kvm;
> +	int rc = -ENODEV;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	kvm = vdev->viommu->kvm_filp->private_data;
> +	if (kvm) {
> +		/*
> +		 * tsm layer will make take care of parallel calls to tsm_bind/unbind

Wrap comment to say under 80 chars. Or if file goes higher, use a single line
comment.

		  tsm layer will take care ...

(stray 'make')

> +		 */
> +		if (cmd->op == IOMMU_VDEICE_TSM_BIND)
> +			rc = tsm_bind(vdev->idev->dev, kvm, vdev->virt_id);
> +		else if (cmd->op == IOMMU_VDEICE_TSM_UNBIND)
> +			rc = tsm_unbind(vdev->idev->dev);
> +
> +		if (rc) {
> +			rc = -ENODEV;

If we want to eat an error code coming from elsewhere, maybe a comment on why?

> +			goto out_put_vdev;
> +		}
> +	} else {
> +		goto out_put_vdev;

If this always skips the next line, does that imply that line should
have been under if (kvm)?  Maybe this makes more sense in
later patches - if so ignore this comment.

> +	}
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_put_vdev:
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +	return rc;
> +}
> +#else /* !CONFIG_TSM */
> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	return -ENODEV;
> +}
> +#endif
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index bee3cf3226e9..afdb39c6aefd 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -694,6 +694,16 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #if IS_ENABLED(CONFIG_EEH)
>  	eeh_dev_release(vdev->pdev);
>  #endif
> +
> +#if 0

If you really need to do this, add a comment on why if 0

> +	/*
> +	 * destroy vdevice which involves tsm unbind before we disable pci disable
> +	 * A MSE/BME clear will transition the device to error state.
> +	 */
> +	if (core_vdev->iommufd_device)
> +		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);
> +#endif
> +
>  	vfio_pci_core_disable(vdev);
>  
>  	mutex_lock(&vdev->igate);
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 9014c61a97d4..8b1fbf1ef25c 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -57,6 +57,7 @@ enum {

>  /**
> @@ -1127,6 +1128,23 @@ enum iommu_veventq_flag {
>  	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
>  };
>  
> +/**
> + * struct iommu_vdevice_tsm_OP - ioctl(IOMMU_VDEVICE_TSM_OP)
> + * @size: sizeof(struct iommu_vdevice_tsm_OP)

_op I guess?

> + * @op: Either TSM_BIND or TSM_UNBIMD
> + * @flags: Must be 0
> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> + */
> +struct iommu_vdevice_tsm_op {
> +	__u32 size;
> +	__u32 op;
> +	__u32 flags;
> +	__u32 vdevice_id;
> +};
> +#define IOMMU_VDEVICE_TSM_OP	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_OP)
> +#define IOMMU_VDEICE_TSM_BIND		0x1
> +#define IOMMU_VDEICE_TSM_UNBIND		0x2
> +
>  /**
>   * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
>   * @flags: Combination of enum iommu_veventq_flag


