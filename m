Return-Path: <linux-pci+bounces-9811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45392781F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA8C1C21544
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7FB1B11E9;
	Thu,  4 Jul 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep7+sx7/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6461B010A;
	Thu,  4 Jul 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102757; cv=none; b=r/Sl/kwxFsIYUsoCMXAeWg6W/5uKPXlwjErzU7Io/YCZzEN1LtCuUCYrV3p95sgFNtXTWL5hxV8BMQ62TnNw3O09jfZ7KQNL9I7d6pqOvyJXPx+36nDInnWvh4WZYBl1SVIvWMHyD7GXWmuMMzaFiQbZFNo1NUN7fqIObKfJ9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102757; c=relaxed/simple;
	bh=YUUaox4QmEDxktmHdK7cEJhex29ZOYDxVznfPTuSThk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unaA8j+QVn/glpz+cndpU6Icv/WvXTVSC25E373EazQkCPCa+wB0D9+DaQoWFsF2lxOd3r5zdAzck5UgfWYd6mWAJQ/3a6kEU+/pAw85Vpcc8IcF7KUHRLWb/cHrmsdsHhCsnHb9sx/ZDWJIMpC1AzBNBR1HMlYYghRps0Ynxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep7+sx7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BA7C4AF0D;
	Thu,  4 Jul 2024 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102756;
	bh=YUUaox4QmEDxktmHdK7cEJhex29ZOYDxVznfPTuSThk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ep7+sx7/U+a3JxROBWJy6PYSDV4eOSDAMdRwK8A32iMc9lfmXlx1R5Qzb+pdZSHHy
	 UJQvhMhJhuw/YwRpoxmwSYWIJbH85JatxZf65aDs0Kivz8dL98GHtGfsmWJSSX76Bm
	 zfIM1BwXura0tiP3JZk/S+k/Z3bXRPkrW1qHwT/likboAN2ZinR5uGrVi7MqyaJg5a
	 JTPK74vUKgRKqt7r9CBgZb3OkVASfOkMkLMA8bh0m+2MQo5Ol9aVSrRHpR+j6NFrKP
	 C3hM4CgpL8jbs5OZ+5NtK6Ey5RqwENMIJ/29nDjnje8kWHTcKfTriQy4oz9g/7XfPq
	 1kkdG91zSKzwQ==
From: Will Deacon <will@kernel.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Enable PCIe ATS for devicetree boot
Date: Thu,  4 Jul 2024 15:18:58 +0100
Message-Id: <172010124265.2651905.5967081185838500176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240607105415.2501934-2-jean-philippe@linaro.org>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Jun 2024 11:54:13 +0100, Jean-Philippe Brucker wrote:
> Before enabling Address Translation Support (ATS) in endpoints, the OS
> needs to confirm that the Root Complex supports it. Obtain this
> information from the firmware description since there is no architected
> method. ACPI provides a bit via IORT tables, so add the devicetree
> equivalent.
> 
> Since v1 [1] I added the review and ack tags, thanks all. This should be
> ready to go via the IOMMU tree.
> 
> [...]

Applied to iommu (pci/ats), thanks!

[1/3] dt-bindings: PCI: generic: Add ats-supported property
      https://git.kernel.org/iommu/c/40929e8e5449
[2/3] iommu/of: Support ats-supported device-tree property
      https://git.kernel.org/iommu/c/86e02a88bedc
[3/3] arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
      https://git.kernel.org/iommu/c/6bac3388889c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

