Return-Path: <linux-pci+bounces-28457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071DAC50DE
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 16:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE3F3A8CE4
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37027876E;
	Tue, 27 May 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D96sDg0L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FF27700B;
	Tue, 27 May 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355977; cv=none; b=Bs8clK7et0nzYPjZrZ2bF8xxhpaUE++M6/TIEkwp4LrQcXjth8XOoiMkr1vkbXnIrC2z/aDDYKlahu9R6596WDEPewqumSP9V7UdQ+EwwR70EcMUb8vDc35t9I++lj21DxWhwIfyjqoTd1+aikBqA2vmbtDf0DKmnbuS21vuuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355977; c=relaxed/simple;
	bh=4XMz/MiAjg7uAz8Md+uFaZ0tusZ1Av7gcFrAhZ+9+AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5P2ANRO6avRaAd7JagZREBa3tUtc7f8uRlvldOdRiKH4Vi1PthcNxWH9sTlxBMOYhWZwk4mT8Ed4C0p73SKE+3qhDxrZUF89iSdgNGONSlHZ4YhNW+1z9eDZWBc2zTCHaAcyfqZqD/00RSLYSn3fsau6tjp2SWAEAo+l1K40i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D96sDg0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07652C4CEE9;
	Tue, 27 May 2025 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748355976;
	bh=4XMz/MiAjg7uAz8Md+uFaZ0tusZ1Av7gcFrAhZ+9+AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D96sDg0L31PIPHhmrCNnaTR9sI+Xg1lBi+fvCPUv/oLFESWOUEIb31wuAemy0ObY+
	 CyoLBVaIM2w2mafTBL8QMbnv1BchEY7BcBVS+IX13orNDhPuvgCDoDFq0jApK0PHXg
	 UBxzPCDebORcfLV/Yjyka7QRdCZmt6FdtgXmF76OsIbL5QJV3vcmEQw862SdwRsw1N
	 8ippepjsBYMMEMpkDzRmiSGpLJeq1fDShvnUvGNqzjz+h/J4+eeHaiVxqGWPVx0Z/i
	 b/Mld+mDuFDx98zRTEvFr57WhuotEMmyHfOLPINAI5cuCz/e/WdXFe7zFM5yr6YgoO
	 32PaiLIPJnsxA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <20250527130610.GN61950@nvidia.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org> <20250527130610.GN61950@nvidia.com>
Date: Tue, 27 May 2025 19:56:09 +0530
Message-ID: <yq5a8qmiruym.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, May 27, 2025 at 05:18:01PM +0530, Aneesh Kumar K.V wrote:
>> > yeah, I guess, there is a couple of places like this
>> >
>> > git grep pci_dev drivers/iommu/iommufd/
>> >
>> > drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
>> > drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
>> >
>> > Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,
>> 
>> Getting the kvm reference is tricky here.
>
> The KVM will come from the viommu object, passed in by userspace that
> is the plan at least.. If you are not presenting a viommu to the guest
> then I imagine we would still have some kind of NOP viommu object..
>

I assume you are not suggesting using IOMMU_VIOMMU_ALLOC? That would
break the ABI, which we need to maintain.

Instead, my approach uses VFIO_DEVICE_BIND_IOMMUFD to associate the KVM
context. The vfio device file descriptor had already been linked to the
KVM instance via KVM_DEV_VFIO_FILE_ADD.

Through VFIO_DEVICE_BIND_IOMMUFD, we inherit the necessary KVM details
and pass them along to iommufd_device, and subsequently to
iommufd_vdevice, using IOMMU_VDEVICE_ALLOC.

>
> We need an association between the viommu and vdevice to tell the TSM
> world what it is when we tell the TSM to create the vPCI function..
>
> There is a missing ioctl in this sequence, you have to register the
> vdev with the viommu to create a vPCI function, and that may trigger a
> TSM call too.
>
> The registration should link the vdev to the viommu and then you can
> get the viommu's kvm for a later bind.
>
>> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_vdevice_id *cmd = ucmd->cmd;
>> +	struct iommufd_vdevice *vdev;
>> +	int rc = 0;
>> +
>> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
>> +					       IOMMUFD_OBJ_VDEVICE),
>> +			    struct iommufd_vdevice, obj);
>> +	if (IS_ERR(vdev))
>> +		return PTR_ERR(vdev);
>> +
>> +	rc = tsm_bind(vdev->dev, vdev->kvm, vdev->id);
>> +	if (rc) {
>> +		rc = -ENODEV;
>> +		goto out_put_vdev;
>> +	}
>> +
>> +	/* locking? */
>> +	vdev->tsm_bound = true;
>> +	refcount_inc(&vdev->obj.users);
>
> This refcount isn't going to work, it will make an error close()
> crash..
>
> You need to auto-unbind on destruction I think.

Can you elaborate on that? if vdevice is tsm_bound,
iommufd_vdevice_destroy() do call tsm_unbind in the changes I shared.

-aneesh

