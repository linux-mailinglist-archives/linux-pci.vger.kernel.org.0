Return-Path: <linux-pci+bounces-33096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC82B14A1E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B81169FCA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB31266591;
	Tue, 29 Jul 2025 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsu5oJ3D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD19188006;
	Tue, 29 Jul 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777830; cv=none; b=s+PIW4AhkbCcp3iozbQr0p/vQ69TIWFr8XK/3fvsq+tIWaZMQa78yRfyScT6w1iU3Vlcf/Cm1JBSyIu6jlsTz0BM+xlxFhA577YmOPZk219ZZbSEBGsTDwJNAMBG4hwvD29EiVOzEkIh7m0GkPC1smx+ezzFJH3z/ft/Q6q+wL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777830; c=relaxed/simple;
	bh=MfjtUYl24mR11LtrC5LFFMo8uZ0WVFxXpOT8/AgZ2LQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M54+SrCDpmP8Wv+laxuEeFGX5IU3YqLbsSIYhH1+GQGCNaVnQgP/TA/1DmA+dKaHBHgLFXMfA8ptSrgCbhn3VC89onjqfyDM5b7XDJB6h0rRdeMMjLPQ2zZj0KO0sXavPilp1ni+hg1YPOQgGUSL7w1YfArRRYR7yd7h2uTegyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsu5oJ3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B602C4CEEF;
	Tue, 29 Jul 2025 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777829;
	bh=MfjtUYl24mR11LtrC5LFFMo8uZ0WVFxXpOT8/AgZ2LQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Hsu5oJ3DzG2WBuKIEoBTJyi7l+z9l2BEMru6+KxNlbGHxSUyzAPXxlm5xkZXBJfNv
	 QYg6XWKFCKUDc+nMXlgAuCTjcpwSEr5ah2OQkuQsh8n5F+S2E/1wPhbg5KZt5x3ujK
	 sUq9kkx9BR+Jo1FoI97cvHeG9ZQElgQnWK7p5+GzoJ9G9ZfEd+Cx7EDn2Rl/jM+3bi
	 Mkn7CrMJXoF7Z5u8NqJ5ugZH1VfRGebRTSYesj03CHZdi/f4QY6mY5cWNTcgHesmqk
	 FTzDqTDbJKdbIcmUMwou0ndWIiL2jpyBH//IL6yJBORgWdQJQeVr6TjwmAe9uJKQnv
	 sLXDn+dAfxvjg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 07/38] iommufd/viommu: Add support to associate
 viommu with kvm instance
In-Reply-To: <20250728141026.GB26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-8-aneesh.kumar@kernel.org>
 <20250728141026.GB26511@ziepe.ca>
Date: Tue, 29 Jul 2025 14:00:22 +0530
Message-ID: <yq5azfcn9z6p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Jul 28, 2025 at 07:21:44PM +0530, Aneesh Kumar K.V (Arm) wrote:
>
>> +#if IS_ENABLED(CONFIG_KVM)
>> +#include <linux/kvm_host.h>
>> +
>> +static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
>> +{
>> +	int rc =3D -EBADF;
>> +	struct file *filp;
>> +
>> +	filp =3D fget(kvm_vm_fd);
>> +
>> +	if (!file_is_kvm(filp))
>> +		goto err_out;
>> +
>> +	/* hold the kvm reference via file descriptor */
>> +	viommu->kvm_filp =3D filp;
>> +	return 0;
>> +err_out:
>> +	viommu->kvm_filp =3D NULL;
>> +	fput(filp);
>> +	return rc;
>> +}
>> +
>> +static void viommu_put_kvm(struct iommufd_viommu *viommu)
>> +{
>> +	fput(viommu->kvm_filp);
>> +	viommu->kvm_filp =3D NULL;
>> +}
>> +#endif
>
> Missing stub functions for !CONFIG_KVM?
>
> Looks like an OK design otherwise
>
>> @@ -1057,6 +1068,7 @@ struct iommu_viommu_alloc {
>>  	__u32 data_len;
>>  	__u32 __reserved;
>>  	__aligned_u64 data_uptr;
>> +	__u32 kvm_vm_fd;
>
> fds are __s32, they are signed numbers.
>

Thanks for the review comments. I=E2=80=99ll update the patch with the sugg=
ested changes.

-aneesh

