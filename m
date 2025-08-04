Return-Path: <linux-pci+bounces-33399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4CB1AAE5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C671B7AEFA7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B0B238C07;
	Mon,  4 Aug 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+xLZVfw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B74286881;
	Mon,  4 Aug 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346439; cv=none; b=ScQfadEixOCL564zVAdBGCsg0K0FjB1u2bysb+QqHjG/TBlonRvUHCtDkArzO2tK5sxnbR2cDaOEapIwoGObXa6dddJLAThlLlVDDdt0ye5k5p97z4soX+lbAnXtl+lDDdGud+BMmAy5TCwMFw+Yf5X/7j+hK24em+HyzSsLkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346439; c=relaxed/simple;
	bh=/6AYP4YSYHRSYlltEcNIffw44ha6OxTtWKs9RKl5J4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jImD3W7RayRSxzdUk+K8eDozwpnDEfFGAmvEyzqVkKjofYh3c7b9KNXUK0wWzDcDV31ESLf42a9YaG2SC5qg4tkGIjymgHbX5DaDuPIZqwvLmP0zmJDCCG/b5ftMF7CATpk0y1yiRvOxIRoDWG8biQue8GyfCEZaTyQn4zKC2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+xLZVfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75699C4CEE7;
	Mon,  4 Aug 2025 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346438;
	bh=/6AYP4YSYHRSYlltEcNIffw44ha6OxTtWKs9RKl5J4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m+xLZVfwlzcEycpTDbH+hemEdRPxASgiONteZDEJinVFBONwoQ/8pOFi4ZXtCt1k6
	 NzXK9+2+vXMumpu8AZXwfCKljWRGKOHULoTpd2wowKCDv+AgTcTrqszUw15GL6bAPE
	 xTybkjVvZPHbSDV1pFYhZ7ynBM7CmsMIJvjD7md2SaALBa0e7byHN3XE3nHtiLOIrs
	 0SAn4WaucynlsJ+0nr+mt4f0Sz8lZaUwk66g8d412WTfqXuqgSjJtBmw7kkUlv9I2j
	 1wXDiQ16NnXLrHcxOjJyai8sDF7uGHqhac+U1IhFxnOc0/5q1/MfD+DRG8ia0zbauJ
	 QE5vGxA+Icm3w==
Date: Mon, 4 Aug 2025 17:27:17 -0500
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
Subject: Re: [RFC PATCH v1 37/38] coco: guest: arm64: Add support for
 fetching device measurements
Message-ID: <20250804222717.GA3645398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-38-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:22:14PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Fetch device measurements using RSI_RDEV_GET_MEASUREMENTS.

> +++ b/arch/arm64/include/asm/rsi_smc.h

> +struct rsi_device_measurements_params {
> +	union {
> +		struct {
> +			u64 flags;
> +			u8 indices[32];
> +			u8 nounce[32];

s/nounce/nonce/ ?

