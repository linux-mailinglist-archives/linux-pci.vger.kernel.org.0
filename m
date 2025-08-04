Return-Path: <linux-pci+bounces-33344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2AB19AD4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E533B4978
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EFC86359;
	Mon,  4 Aug 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSsTk+5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB42904;
	Mon,  4 Aug 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754282719; cv=none; b=ewnzwRtxGdb/fsJNa7cvyk2qOTHpQMhdU/D5XQFeZZP2vPeqwQjyH6OL/M9c6pTGRUXsVbrXN38jVnIHyYB47GorV7xUc/I7mZCJJOvXztxOvLXs5csEHOIlqREcyHxzQkyOIDYzv8So9t4UdY6FIM9BlSaCqS16P8paygiJvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754282719; c=relaxed/simple;
	bh=TGTXUGxqDNAWkyTMzYCMuxksT2t2vY+Q1un+rO56sgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LEZYwJ4yyv8fgFdZ4WXeqExqXjpY4hbrrWEocGDt0hII4NeKHLOSPuG1KnOSe2sMK5hO+13+h6exzSo0MSl9NURlt7NiJNR7j7aMdCwZ8v7rMJXfjw+D/mMJkMbP77+A/pz5qXqKIW6azUO9AemoE3pxhsN2CsNPfs8nhDCCUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSsTk+5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61AEC4CEE7;
	Mon,  4 Aug 2025 04:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754282719;
	bh=TGTXUGxqDNAWkyTMzYCMuxksT2t2vY+Q1un+rO56sgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NSsTk+5qyy30NYRn0m3D1/aPKBsPvecm8nNc0gOrfsTYFvrsZxTtxayRgKUmnrb9v
	 9Et39/TKggIGyYGWGTIbbF3bDfUAZvYnSD9QbqRbNq7Nn6obd2gkElC4GQ21k3LUV3
	 jAawqUKuGig/p75Y2jilubTA21Khx/nLazVxv+1fiNQJyKyytoPpR4g+9d+hIG2Rhc
	 wy2EG1/DX1ojm4kQr1pSoodVumRit8fwB9gx7WKXUywi+WgLPKQmJsljEr7huiDy9q
	 qFbruxBaglj6UGw3fb8tEmt+1k8h5X3YHjeEsihqDe9sn1zzsEbkKobSAOz5iYHc2a
	 bE7Txf5oRgO4Q==
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
Subject: Re: [RFC PATCH v1 21/38] coco: host: arm64: Add support for virtual
 device communication
In-Reply-To: <20250730151358.00003f84@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-22-aneesh.kumar@kernel.org>
 <20250730151358.00003f84@huawei.com>
Date: Mon, 04 Aug 2025 10:15:12 +0530
Message-ID: <yq5awm7j8zl3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:21:58 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Add support for vdev_communicate with RMM.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> One minor comment.
>
>> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
>> index 41314db1d568..8635f361bbe8 100644
>> --- a/drivers/virt/coco/arm-cca-host/rmm-da.c
>> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
>> @@ -207,8 +207,14 @@ static int __do_dev_communicate(int type, struct pci_tsm *tsm)
>
> Can type parameter be an enum so we can see all cases are covered?
>

Sure, will update the patch

>
>>  	if (type == PDEV_COMMUNICATE)
>>  		ret = rmi_pdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
>>  					   virt_to_phys(comm_data->io_params));
>> -	else
>> -		ret = RMI_ERROR_INPUT;
>> +	else {
>> +		struct cca_host_tdi *host_tdi = container_of(tsm->tdi, struct cca_host_tdi, tdi);
>> +
>> +		ret = rmi_vdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
>> +					   virt_to_phys(host_tdi->rmm_vdev),
>> +					   virt_to_phys(comm_data->io_params));
>> +	}

-aneesh

