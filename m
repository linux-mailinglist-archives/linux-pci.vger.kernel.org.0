Return-Path: <linux-pci+bounces-33326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74934B18B86
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4425615CE
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D4E1FBC92;
	Sat,  2 Aug 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSa/9iUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825621E7C1B;
	Sat,  2 Aug 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754125415; cv=none; b=Uku/4MQqRYa1pKKlXrL+QIsKcasYsDCZD98cDUZlVBzoPCashVDTG6qcR+khldE7ubVg0IibdoNVJjcw79e2Crmkz+4Luh3C68pn7BXrnssRkAeCaeLy4C6RFBHWMIo6BbujTLOlTdSXL2oyb+ay81XVtnNgkciwZedMmXHqrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754125415; c=relaxed/simple;
	bh=B+sLSD/spXOHjS0PWTHttU03+WW1yULv9NwniNHJJPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sllCWRlD7Un1mpRc/IPpNjZIZaJhKWCmmoCxgffDUQER7rAw3T6n9Cv5hWj4HeFJ8wAbeK97eM6Fr140xCgYo4AJlcLVe4KIdUHlXzHMVASmApdsnA9+0JYF31Ydib684HaHg79DdEiJ/RfwE6uHurtHPgtP7YbQw3P+u4HGhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSa/9iUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC25AC4CEEF;
	Sat,  2 Aug 2025 09:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754125415;
	bh=B+sLSD/spXOHjS0PWTHttU03+WW1yULv9NwniNHJJPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bSa/9iUdUGz5mSHzXuDyWCxOGL5I5Q7pp06nQjGP17OPVQ3mqE1TCsIaEggsH3iuf
	 t6Q8O5c7hAUI7lRolFF88ap529irddphG1teWc0XaDzPsIrq2/7LoqDRY/U0w7Nn/a
	 qjyUzM4zP/7/fOgT87W9BRIFgUoihaj84nn5W0Nq34srLhFrqPSMv/BBBzrpvW6lew
	 ouOgQDMOCweSaSmThNFguvWXmUnyvUbMQniSM0+/Z+WQH7g2bk5bActe3XDoi1oXV9
	 d9uGQkqsKXI+c5ETG+DCcIYgUrWwzI6VqRxK7VXQ+AfucnNZiIlTyiEC9NNrXwi53S
	 U79LQX792ty5w==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 08/38] iommufd/tsm: Add tsm_op iommufd ioctls
In-Reply-To: <20250729173458.00003ca5@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-9-aneesh.kumar@kernel.org>
 <20250729173458.00003ca5@huawei.com>
Date: Sat, 02 Aug 2025 14:33:26 +0530
Message-ID: <yq5afrea9jtt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:21:45 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Add operations bind and unbind used to bind a TDI to the secure guest.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> Hi Aneesh,
>
> I'm mostly reading this to get head around it rather than fully review
> at this point.
>
> A few things inline though that I noticed whilst doing so.
>
> Jonathan
>
>> ---
>>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>>  drivers/iommu/iommufd/main.c            |  3 ++
>>  drivers/iommu/iommufd/viommu.c          | 50 +++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci_core.c        | 10 +++++
>>  include/uapi/linux/iommufd.h            | 18 +++++++++
>>  5 files changed, 82 insertions(+)
>>=20
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iom=
mufd/iommufd_private.h
>> index fce68714c80f..e08186f1d102 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -697,6 +697,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *=
obj);
>>  void iommufd_vdevice_abort(struct iommufd_object *obj);
>>  int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
>>  void iommufd_hw_queue_destroy(struct iommufd_object *obj);
>> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
>>=20=20
>>  static inline struct iommufd_vdevice *
>>  iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>
>> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viom=
mu.c
>> index 59f1e1176f7f..c934312e5397 100644
>> --- a/drivers/iommu/iommufd/viommu.c
>> +++ b/drivers/iommu/iommufd/viommu.c
>> @@ -162,6 +162,9 @@ void iommufd_vdevice_abort(struct iommufd_object *ob=
j)
>>=20=20
>>  	lockdep_assert_held(&idev->igroup->lock);
>>=20=20
>> +#ifdef CONFIG_TSM
> Can we use stubs for some of this stuff so we don't need ifdefs in as many
> places.
>
>> +	tsm_unbind(idev->dev);
>> +#endif
>>  	if (vdev->destroy)
>>  		vdev->destroy(vdev);
>>  	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
>> @@ -471,3 +474,50 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucm=
d *ucmd)
>>  	iommufd_put_object(ucmd->ictx, &viommu->obj);
>>  	return rc;
>>  }
>> +
>> +#ifdef CONFIG_TSM
>> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>
> Might want to split this out to a separate c file and use stubs in a head=
er to
> keep the code clean here.
>
>> +{
>> +	struct iommu_vdevice_tsm_op *cmd =3D ucmd->cmd;
>> +	struct iommufd_vdevice *vdev;
>> +	struct kvm *kvm;
>> +	int rc =3D -ENODEV;
>> +
>> +	if (cmd->flags)
>> +		return -EOPNOTSUPP;
>> +
>> +	vdev =3D container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
>> +					       IOMMUFD_OBJ_VDEVICE),
>> +			    struct iommufd_vdevice, obj);
>> +	if (IS_ERR(vdev))
>> +		return PTR_ERR(vdev);
>> +
>> +	kvm =3D vdev->viommu->kvm_filp->private_data;
>> +	if (kvm) {
>> +		/*
>> +		 * tsm layer will make take care of parallel calls to tsm_bind/unbind
>
> Wrap comment to say under 80 chars. Or if file goes higher, use a single =
line
> comment.
>
> 		  tsm layer will take care ...
>
> (stray 'make')
>
>> +		 */
>> +		if (cmd->op =3D=3D IOMMU_VDEICE_TSM_BIND)
>> +			rc =3D tsm_bind(vdev->idev->dev, kvm, vdev->virt_id);
>> +		else if (cmd->op =3D=3D IOMMU_VDEICE_TSM_UNBIND)
>> +			rc =3D tsm_unbind(vdev->idev->dev);
>> +
>> +		if (rc) {
>> +			rc =3D -ENODEV;
>
> If we want to eat an error code coming from elsewhere, maybe a comment on=
 why?
>
>> +			goto out_put_vdev;
>> +		}
>> +	} else {
>> +		goto out_put_vdev;
>
> If this always skips the next line, does that imply that line should
> have been under if (kvm)?  Maybe this makes more sense in
> later patches - if so ignore this comment.
>
>
>> +	}
>> +	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +
>> +out_put_vdev:
>> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
>> +	return rc;
>> +}
>> +#else /* !CONFIG_TSM */
>> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pc=
i_core.c
>> index bee3cf3226e9..afdb39c6aefd 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -694,6 +694,16 @@ void vfio_pci_core_close_device(struct vfio_device =
*core_vdev)
>>  #if IS_ENABLED(CONFIG_EEH)
>>  	eeh_dev_release(vdev->pdev);
>>  #endif
>> +
>> +#if 0
>
> If you really need to do this, add a comment on why if 0
>
>> +	/*
>> +	 * destroy vdevice which involves tsm unbind before we disable pci dis=
able
>> +	 * A MSE/BME clear will transition the device to error state.
>> +	 */
>> +	if (core_vdev->iommufd_device)
>> +		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);
>> +#endif
>> +
>>  	vfio_pci_core_disable(vdev);
>>

This is something I=E2=80=99d like to get feedback on. According to the TSM
specification, we=E2=80=99re required to unlock before clearing MSE/BME via=
=20
calling `vfio_pci_core_disable(vdev)`.

However, in the current `iommufd` branch, we seem to call
`vdevice_destroy` a bit too late in the sequence to meet this
requirement.


>>  	mutex_lock(&vdev->igate);
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index 9014c61a97d4..8b1fbf1ef25c 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -57,6 +57,7 @@ enum {
>
>>  /**
>> @@ -1127,6 +1128,23 @@ enum iommu_veventq_flag {
>>  	IOMMU_VEVENTQ_FLAG_LOST_EVENTS =3D (1U << 0),
>>  };
>>=20=20
>> +/**
>> + * struct iommu_vdevice_tsm_OP - ioctl(IOMMU_VDEVICE_TSM_OP)
>> + * @size: sizeof(struct iommu_vdevice_tsm_OP)
>
> _op I guess?
>
>> + * @op: Either TSM_BIND or TSM_UNBIMD
>> + * @flags: Must be 0
>> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEV=
ICE_ALLOC
>> + */
>> +struct iommu_vdevice_tsm_op {
>> +	__u32 size;
>> +	__u32 op;
>> +	__u32 flags;
>> +	__u32 vdevice_id;
>> +};
>> +#define IOMMU_VDEVICE_TSM_OP	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_=
OP)
>> +#define IOMMU_VDEICE_TSM_BIND		0x1
>> +#define IOMMU_VDEICE_TSM_UNBIND		0x2
>> +
>>  /**
>>   * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ St=
atus
>>   * @flags: Combination of enum iommu_veventq_flag


Thanks for the review comments. I'll update the patch with the suggested ch=
anges.


-aneesh

