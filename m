Return-Path: <linux-pci+bounces-44283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1788D03F91
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 16:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB22B301DE9D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189A334C04;
	Thu,  8 Jan 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffig8Frt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196D2E6116;
	Thu,  8 Jan 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886341; cv=none; b=ur7ySnRk0iXe/GNhjEgZDJci6kN9zNS2batkRWlX8SQxjuaEXqbhNbcb+Wwo0Yh2QlQVOs2vxK3I2xlMzH2cidcGIsyWPJ4DlJErm27qFw5caz/T53QrvJ6Hi9udINOR83mjC455k6mf3bs2c7VIy+6I/c6XEL53ErVXazsljxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886341; c=relaxed/simple;
	bh=nODPnQ9uRMurJcexhU0AkEFsKCop/ncB8cW0GYwEwHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXhHg4B0e1z0M4EZGW/OPRmrAAxYolQI0QjYOJPBcRI6bmz249AsYCH2d/TZEeaPD/BPeJac7mM3YVuMSH7laqQ5WYfAqsT8KAqhjQ1stNcQq8WL15ZpShitMo5UUtmj6JH2lGdDn4IzmY+De6/KWbJfzrEazBoiiCoYGeRpVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffig8Frt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D057AC116C6;
	Thu,  8 Jan 2026 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767886341;
	bh=nODPnQ9uRMurJcexhU0AkEFsKCop/ncB8cW0GYwEwHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffig8FrtQznSyAHcwxDugdT799R16YhmH6Y1dJHqu9KFu2/aJDz6dSDfAN/2InyPX
	 54sZZECfTWY2QxQmI3u+iKdORZhQfwEtY5eu+eImGUOsqTLIU8huzIuq6dUiiel55Y
	 fO/mZpgbS5Fu7KLtq86stVp98Yc1etYFAzeDPpOEtCIdZ5EP8AuM5TNxUdErwu64cb
	 JiDsH14OeUNeqapepA0tyGsC2U2LIB79020LZiulptJmhZ7u9j9GNssswa8/jf1xja
	 9yDJniEPezNZFT1gsQd9+OuUyNjGrVBetpogN1L3yY5RMDiabjtGQ3cyUEXeGYejRE
	 SaljBtPHaUNfg==
Date: Thu, 8 Jan 2026 15:32:14 +0000
From: Will Deacon <will@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 03/11] coco: guest: arm64: Add support for guest
 initiated TDI bind/unbind
Message-ID: <aV_N_uvCCKxD05RO@willie-the-truck>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
 <20251117140007.122062-4-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117140007.122062-4-aneesh.kumar@kernel.org>

On Mon, Nov 17, 2025 at 07:29:59PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add RHI for VDEV_SET_TDI_STATE
> 
> Note: This is not part of RHI spec. This is a POC implementation
> and will be later converted to correct interface defined by RHI.

Then maybe send this as an RFC given that it doesn't sound like something
we should be merging?

Will

