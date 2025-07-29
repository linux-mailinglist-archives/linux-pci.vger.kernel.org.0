Return-Path: <linux-pci+bounces-33094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180CBB14A03
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CFE18A2FFC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48327E1DC;
	Tue, 29 Jul 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRdeohwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD34136348;
	Tue, 29 Jul 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777402; cv=none; b=OJslwfqQJuUVhmMYMWd2Vy88bjedi6GtcPFbGLgSHlwtt3YdS5/1oJfCN8A0nZtRXotRlqcqti+avOT9mOW/Y1KHPG86IMguoEiP+ku7t9d36hi98jLmuil9hPmcWYnZbeVxkqS8oQzGanJaUKQBo53Cgl6pEO7F6BGgIQ+Yugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777402; c=relaxed/simple;
	bh=Mi2Uvf2FddisuYEcMTdmOzIi0nnlwedNbEXfEGZ6n+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3AO/vSV7Qg4lmyuY+cYVhhZUVS9hGO0v3xMRNEHSd4aFUgtBZtYgVyOPIWvzRUqMVZ9IUAKZF53o7g3C3ljZMC+F7gyfWVqb+cDZUvEfzrJ83XIQDKbXmtmVfqfzqX1opbBt0ahNMG2x83Kx2EMi2cY/wm6CbjrGHGNlPWjUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRdeohwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B502C4CEEF;
	Tue, 29 Jul 2025 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777398;
	bh=Mi2Uvf2FddisuYEcMTdmOzIi0nnlwedNbEXfEGZ6n+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SRdeohwFGI1KMuFQHqkLd+SYzL2X8AV3SyodvrLjC1Iu/1AoucisGFRdVx0RNdtQY
	 j/+/NphOfDRy37bseqcpF5Fq6AJeedUYsW8uMi8kWZZTOQbNK0gDJmcVtqqwoZIMl8
	 bNV6H2GTYKsvq7eqxu+9Zjkp4p/QG+KtU+zRxRGyKh/p0YrwSsgbr1F6CxcWMaMWD5
	 YAsgFSPFb8RKxNxnEDmmxZjApHuyhem7JGae4dnhghwEBmZ/kT8nv9bkr64rq2fcCz
	 jY+7/TQHkFLqUWSG7/uZmW7lJps3Yg/UfgLfL/TkNZSJriyYw/17yx6xEWbc6hsOXL
	 0VVGPO63brHzA==
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
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
In-Reply-To: <20250728143318.GD26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
Date: Tue, 29 Jul 2025 13:53:10 +0530
Message-ID: <yq5a5xfbbe35.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>>  	return crypt_ops->decrypt(addr, numpages);
>>  }
>>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
>> +
>> +bool force_dma_unencrypted(struct device *dev)
>> +{
>> +	if (dev->tdi_enabled)
>> +		return false;
>
> Is this OK? I see code like this:
>
> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> 		phys_addr_t phys)
> {
> 	if (force_dma_unencrypted(dev))
> 		return phys_to_dma_unencrypted(dev, phys);
> 	return phys_to_dma(dev, phys);
>
> What are the ARM rules for generating dma addreses?
>
> 1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
>    and do "top bit IBA set"
>
> 2) Device is T=1, memory is encrypted, use the phys_to_dma() normally
>
> 3) Device it T=1, memory is uncrypted, use the phys_to_dma()
>    normally??? Seems odd, I would have guessed the DMA address sould
>    be the same as case #1?
>
> Can you document this in a comment?
>

If a device is operating in secure mode (T=1), it is currently assumed
that only access to private (encrypted) memory is supported. It is
unclear whether devices would need to perform DMA to shared
(unencrypted) memory while operating in this mode, as TLPs with T=1 are
generally expected to target private memory.

Based on this assumption, T=1 devices will always access
private/encrypted memory, while T=0 devices will be restricted to
shared/unencrypted memory.

>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 4940db137fff..d62e0dd9d8ee 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -688,6 +688,7 @@ struct device {
>>  #ifdef CONFIG_IOMMU_DMA
>>  	bool			dma_iommu:1;
>>  #endif
>> +	bool			tdi_enabled:1;
>>  };
>
> I would give the dev->tdi_enabled a clearer name, maybe
> dev->encrypted_dma_supported ?
>
> Also need to think carefully of a bitfield is OK here, we can't
> locklessly change a bitfield so need to audit that all members are set
> under, probably, the device lock or some other single threaded hand
> waving. It seems believable it is like that but should be checked out,
> and add a lockdep if it relies on the device lock.
>

Will check and update the patch.

-aneesh

