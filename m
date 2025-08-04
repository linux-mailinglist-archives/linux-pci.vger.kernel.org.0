Return-Path: <linux-pci+bounces-33397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B94B1AADB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E6E3AF7FD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02F286881;
	Mon,  4 Aug 2025 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp0Fu428"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AB238C07;
	Mon,  4 Aug 2025 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346351; cv=none; b=TXumgqjRCqs0zczvC+2c/5Nc68skvXW20BFZbNcpXuNi29gc7s4Hj8LkhPMjoh1HjXSYoYjIRtw8BqWkQDjFsS1iItcyINC7nI3MPqI83X8WzzIA5x52OdGfSVnBLpytwTPalQGgn2d34K5AehtQAPEWHGVSEJYbS1n9lp8GiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346351; c=relaxed/simple;
	bh=enMaGTMAABbWaOPEGi4GPcRf3wbgYEldr1JGJGzL5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d5lNCKU05+lwnX4Y7vOZfjYB0zN2cwh5uUv/+7gIt4lnNWM25KMTh1lx6kgDrHJ+KtBwDjr+rzLqGt+ZAfT3dLUWkxGIMiYWNM707KQE4i6mT+Z0L3aOBjyaGNmB3sAuUUU1cAYTv9HW6FwnTs5f0sJO8p2UldYUPrnByp5xQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp0Fu428; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F3AC4CEE7;
	Mon,  4 Aug 2025 22:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346351;
	bh=enMaGTMAABbWaOPEGi4GPcRf3wbgYEldr1JGJGzL5m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Pp0Fu428NDuVpNiSRNjvByoTRFtmuOHLiyeTEej7y/QmQQD2UoHTtSOLyLJOOuOVD
	 UhjlBwVcNfCms6iqzxm/r6qHjrqcBgjOiSPIQ9ZKBShVl5tbiFFqpuOzxcIfddWytx
	 j3MUpoEwOy3o0Nirnyiroh427CdZfqchpCMINfF8Z7bF1Qb0GuYehdYb2CWK3Cbxzx
	 G/B+cxa+EEFf7qgzDnV5QDb+kSFLkpT5Gw3Y5XlCOeXwBxrvggaPD2dLvMfRac3w9t
	 5faLPOdixH6tKJPhVGF/7SIDOZE96eNjrpLLm1a2wJuE/Pc9uUcB0rBowZYXmcoiAN
	 R+jE28AaKdMaw==
Date: Mon, 4 Aug 2025 17:25:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 08/38] iommufd/tsm: Add tsm_op iommufd ioctls
Message-ID: <20250804222549.GA3645807@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-9-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:45PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add operations bind and unbind used to bind a TDI to the secure guest.

> +++ b/include/uapi/linux/iommufd.h

> +#define IOMMU_VDEVICE_TSM_OP	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_OP)
> +#define IOMMU_VDEICE_TSM_BIND		0x1
> +#define IOMMU_VDEICE_TSM_UNBIND		0x2

s/VDEICE/VDEVICE/

