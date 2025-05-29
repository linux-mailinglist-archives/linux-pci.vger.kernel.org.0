Return-Path: <linux-pci+bounces-28653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5680AC7EFC
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0784E64F8
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B61021ABCF;
	Thu, 29 May 2025 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDo+BMm5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E42110;
	Thu, 29 May 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526243; cv=none; b=ibif9wjS6ai5wGvRPzf/tfDLGYl3fA9L19dw7XtuPWoGF+Ad9B3YSbZcTuDt6qYK9QcQP6iwgDNECK3f/sAu8eA5akfWTxwCRjLjoIdZIzi5YKOeE0az37g+AxMI+ocbbX3XHJCJ83DV2jbr2yWqiAI3B+APMqGqbzdQ4ZVbaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526243; c=relaxed/simple;
	bh=edkEV1hSnZUVROOx+TdET1v9ConRvyBLaXZtxX3dM38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYUHJ1kHL305ASruh51/dTZRf1gAhd71MaTM8VcFVDjFs8t1gIi+6N00qvRCdVX9qeu4exvh5MvkOl6+FHhWpKLmdGsGdzLjVZH5PUAD3rgousu4a+yRj8tdPpproFjydz3iTNCl4n2sVS+ucDu4JY/O75bOQD3jR/QOqsmlI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDo+BMm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888D2C4CEE7;
	Thu, 29 May 2025 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748526242;
	bh=edkEV1hSnZUVROOx+TdET1v9ConRvyBLaXZtxX3dM38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WDo+BMm5NfmfIpQpAgN5263RjSeYx078Xws2Sj3qb2IWXUssDdVFyL8+0Z3MhGqm9
	 hPDPuEdrTTAhzMpWXuLmVsWHAdMD21uZf6rntQbV4HhqaxnnNvtlqbxfg8XZ6pdf4w
	 DTji4YZrCV8zFqV3R50L110AqzEpPlsUpVR7O/R+ADLD0984dG40i8s5JR5Q3jlx2E
	 guy487LlYkOaX+cFteCWMOv0Teesp5je2eI5nkmV6yZHvR7a4NpDo3FMvcWXge4lpg
	 yhAdc2Mek2vnAWQGhoFj4OovMWBeF19AjBjuVpGaaICRwTrd3u4h5m9FYmIkMnGwc+
	 DoO4qqhs4T9WA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <20250528165222.GT61950@nvidia.com>
References: <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org> <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org> <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org> <20250528164225.GS61950@nvidia.com>
 <20250528165222.GT61950@nvidia.com>
Date: Thu, 29 May 2025 19:13:54 +0530
Message-ID: <yq5a1ps75y79.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Wed, May 28, 2025 at 01:42:25PM -0300, Jason Gunthorpe wrote:
>> > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
>> > +{
>> > +	struct iommu_vdevice_id *cmd =3D ucmd->cmd;
>> > +	struct iommufd_vdevice *vdev;
>> > +	int rc =3D 0;
>> > +
>> > +	vdev =3D container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
>> > +					       IOMMUFD_OBJ_VDEVICE),
>> > +			    struct iommufd_vdevice, obj);
>> > +	if (IS_ERR(vdev))
>> > +		return PTR_ERR(vdev);
>> > +
>> > +	rc =3D tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);
>>=20
>> Yeah, that makes alot of sense now, you are passing in the KVM for the
>> VIOMMU and both the vBDF and pBDF to the TSM layer, that should be
>> enough for it to figure out what to do. The only other data would be
>> the TSM's VIOMMU handle..
>
> Actually it should also check that the viommu type is compatible with
> the TSM, somehow.
>
> The way I imagine this working is userspace would create a=20
> IOMMU_VIOMMU_TYPE_TSM_VTD (for example) viommu object which will do a
> TSM call to setup the secure vIOMMU
>
> Then when you create a VDEVICE against the IOMMU_VIOMMU_TYPE_TSM_VTD
> it will do a TSM call to create the secure vPCI function attached to
> the vIOMMU and register the vBDF. [1]
>

Don=E2=80=99t we create the vdevice before the guest starts? If I
understand correctly, we expect tsm_bind to be triggered by the guest=E2=80=
=99s
request=E2=80=94specifically, when it writes to /sys/bus/pci/devices/X/tsm/=
connect.

-aneesh


