Return-Path: <linux-pci+bounces-28836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DEACC042
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 08:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898AD16ECB8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F87188907;
	Tue,  3 Jun 2025 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdTO2Z3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5841F948;
	Tue,  3 Jun 2025 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932468; cv=none; b=M5IJwTqSMmVjo94ZFWDGujWpFCgmRl990aToM3QHXNI5JsAbUQrRqVWmnlrlyYr3yVW+s2WAFb4Szi2DpnL2ozYnil+KI7ZiiPfbJCt4gNWoGY+oIazUbCBoMroDq5uF4tuc85+6rFsqdPepKDSdJmuUU80aTW51Z0P84F1S6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932468; c=relaxed/simple;
	bh=9MqeMHm6uVNpV12j4bBrWMR3B7MZ9HzuTUZPD+xW7OA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0QqpHFAwmnRC2kHsyulSmeBvGbhkxyGvog5NVGka+TNSba0dICJmX+RzSGbDd0F0Waghu76KlQxA7J+az2fkFZfuIsUZnSF9TRCQ9gIsYaUksL3Oa7qD2ex0apI6FEg4Wtl1hmU0zEhWbX98RHIBt7TJzYsEKDKKr0A4RZ3Kko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdTO2Z3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA03C4CEEF;
	Tue,  3 Jun 2025 06:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748932468;
	bh=9MqeMHm6uVNpV12j4bBrWMR3B7MZ9HzuTUZPD+xW7OA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SdTO2Z3zlf4UgR6DKp0eB+pBme9bxC3X2Q9H/Hkk3h/RDIQKrWiKPdzFO6JdLE0C6
	 OVTCID8QmWPVUccMVrs74qj0rCVS/mqMr+UaFIUa34VEWFfqXxuxsYdBJu4oHgpyku
	 BeTk69Ek/HQodm2jOeSDmuCzZv54jb+DLWObZJf7c/PwOPZbDi4PzQwYyhbZMw4h2d
	 p+ztFxZ+j/Um1ZYC6N7myThDmtQnrbfmWPG/if+I4GMXS9bC6mthENHJP1Q2pB8G5w
	 3Jy4tiM/uFmjm2hUoWMPxF0E6t21WWvJvOvNz3eJO9/f/CMpo0kL58i7qguJCBRwMR
	 LNkz0B/atY/Dg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 Q)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
In-Reply-To: <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050> <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
Date: Tue, 03 Jun 2025 10:30:30 +0530
Message-ID: <yq5ao6v5ju6p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Mon, Jun 02, 2025 at 04:38:09PM +0530, Aneesh Kumar K.V wrote:
>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>=20
>> >> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
>> >> + * @size: sizeof(struct iommu_vdevice_id)
>> >> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_V=
DEVICE_ALLOC
>> >> + */
>> >> +struct iommu_vdevice_id {
>> >> +	__u32 size;
>> >> +	__u32 vdevice_id;
>> >> +} __packed;
>> >> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE=
_TSM_BIND)
>> >> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVI=
CE_TSM_UNBIND)
>> >
>> > Hello, I see you are talking about the detailed implementation. But
>> > could we firstly address the confusing whether this TSM Bind/Unbind
>> > should be a VFIO uAPI or IOMMUFD uAPI?
>> >
>> > In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
>> > behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
>> > At least TDX Connect cares about this problem now. And the conclusion
>> > seems to be "have a VFIO_DEVICE_BIND(iommufd vdevice id), then have
>> > VFIO reach into iommufd".
>> >
>> > And some further findings [2] indicate this problem may also exist on
>> > AMD when p2p is involved.
>> >
>> > [1]: https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
>> > [2]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-705=
0/
>> >
>>=20
>> Looking at your patch series, I understand the reason you need a vfio
>> ioctl is to call pci_request_regions_exclusive=E2=80=94is that correct?
>
> The immediate reason is to unbind the TDI before unmapping the BAR.
>
>>=20
>> In another thread, I asked whether this might be better handled by
>> pci_tsm instead of vfio. I'd be interested in your thoughts on that.
>>=20
>> I also noticed you want to unbind the TDI before unmapping the BAR in
>> vfio. From what I understand, this should still be possible if we use an
>> iommufd ioctl.
>
> I'm not sure how is that possible.
>

IIUC, what you need is the below interface
int iommufd_device_tsm_unbind(struct iommufd_device *idev) so that vfio
can use vfio_iommufd_tsm_unbind() -> 	iommufd_device_tsm_unbind(vdev->iommu=
fd_device);

The below iommufd changes can get that

static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
{
	if (mutex_lock_interruptible(&vdev->mutex) !=3D 0)
		return NULL;
	return &vdev->mutex;
}
DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))

static struct mutex *idev_lock(struct iommufd_device *idev)
{
	if (mutex_lock_interruptible(&idev->igroup->lock) !=3D 0)
		return NULL;
	return &idev->igroup->lock;
}
DEFINE_FREE(idev_unlock, struct mutex *, if (_T) mutex_unlock(_T))

int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
{
	struct iommu_vdevice_tsm_bind *cmd =3D ucmd->cmd;
	struct iommufd_vdevice *vdev;
	struct iommufd_device *idev;
	struct mutex *ilock __free(idev_unlock) =3D NULL;
	struct mutex *vlock __free(vdev_unlock) =3D NULL;
	struct kvm *kvm;
	int rc =3D 0;

	if (cmd->flags)
		return -EOPNOTSUPP;

	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
	if (IS_ERR(idev))
		return PTR_ERR(idev);

	vdev =3D container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
					       IOMMUFD_OBJ_VDEVICE),
			    struct iommufd_vdevice, obj);
	if (IS_ERR(vdev)) {
		rc =3D PTR_ERR(vdev);
		goto out_put_idev;
	}

	ilock =3D idev_lock(idev);
	if (!ilock) {
		rc =3D -EINTR;
		goto out_put_vdev;
	}

	if (idev->vdev) {
		/* if it is already bound */
		rc =3D -EINVAL;
		goto out_put_vdev;
	}

	vlock =3D vdev_lock(vdev);
	if (!vlock) {
		rc =3D -EINTR;
		goto out_put_vdev;
	}

	if (WARN_ON(vdev->idev)) {
		rc =3D -EINVAL;
		goto out_put_vdev;
	}

	kvm =3D vdev->viommu->kvm_filp->private_data;
	if (kvm) {
		/*
		 * tsm layer will make take care of parallel calls to tsm_bind/unbind
		 */
		rc =3D tsm_bind(vdev->dev, kvm, vdev->id);
		if (rc) {
			rc =3D -ENODEV;
			goto out_put_vdev;
		}
	} else {
		rc =3D -ENODEV;
		goto out_put_vdev;
	}
	idev->vdev =3D vdev;
	vdev->idev =3D idev;
	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));

out_put_idev:
	iommufd_put_object(ucmd->ictx, &idev->obj);
out_put_vdev:
	iommufd_put_object(ucmd->ictx, &vdev->obj);
	return rc;
}

static int iommufd_vdevice_tsm_unbind(struct iommufd_vdevice *vdev)
{
	int rc =3D -EINVAL;
	struct mutex *lock __free(vdev_unlock) =3D vdev_lock(vdev);
	if (!lock)
		return -EINTR;

	if (!vdev->idev) {
		tsm_unbind(vdev->dev);
		vdev->idev =3D NULL;
		rc =3D 0;
	}
	return rc;
}

/**
 * iommufd_device_tsm_unbind - Move a device out of TSM bind state
 * @idev: device to detach
 *
 * Undo iommufd_device_tsm_bind(). This removes all Confidential Computing
 * configurations, Once this completes the device is unlocked (TDISP
 * CONFIG_UNLOCKED).
 */
int iommufd_device_tsm_unbind(struct iommufd_device *idev)
{
	struct mutex *lock __free(idev_unlock) =3D idev_lock(idev);
	if (!lock)
		return -EINTR;

	if (!idev->vdev)
		return -EINVAL;

	iommufd_vdevice_tsm_unbind(idev->vdev);
	idev->vdev =3D NULL;
	return 0;
}
EXPORT_SYMBOL_NS_GPL(iommufd_device_tsm_unbind, "IOMMUFD");

int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd)
{
	struct iommu_vdevice_tsm_unbind *cmd =3D ucmd->cmd;
	struct iommufd_vdevice *vdev;
	int rc =3D 0;

	vdev =3D container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
					       IOMMUFD_OBJ_VDEVICE),
			    struct iommufd_vdevice, obj);
	if (IS_ERR(vdev))
		return PTR_ERR(vdev);

	rc =3D iommufd_device_tsm_unbind(vdev->idev);
	if (rc) {
		rc =3D -ENODEV;
		goto out_put_vdev;
	}
	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));

out_put_vdev:
	iommufd_put_object(ucmd->ictx, &vdev->obj);
	return rc;
}


