Return-Path: <linux-pci+bounces-23822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD528A62BDC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175A4176EEC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBDE1F5859;
	Sat, 15 Mar 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzEbg2K/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057B1DF964;
	Sat, 15 Mar 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742038405; cv=none; b=mrJLjdYJ63l+VknBC+4LPoz/cbpen5mEdR3TQ+l2RbX6jbzjvRpIbgYyuDXFt8VuTQc+14us2NiXi9i0txPyMk9KQp+lFK9Wb1T/ftvR93ji3ZZ7DCZAe/HyjcGah7U4TOrjEb8CNaPIHTkVsxrEEailiecyspDaDV0bObhb+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742038405; c=relaxed/simple;
	bh=BDQZv8lqGd0hrzPUX9cD3C3T2p2eEFtU7Po6FV9qw9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unTCGZt9GrhS9wPw1gCBGI1giQdPrnKHyEPnDjTb8gRoCd8xEq2RspHxH1Xweg8Rhg2/XnaGFvNQArIxtNEY9bXHnH6yOQuQXyk+5ffkNadEfbPj5j1xdLJZr5++oOqXjlTxN4HEa2kLYe/y82VA+ExkOkXkjd9TIEXX34bKYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzEbg2K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBF6C4CEE5;
	Sat, 15 Mar 2025 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742038405;
	bh=BDQZv8lqGd0hrzPUX9cD3C3T2p2eEFtU7Po6FV9qw9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzEbg2K/OtQilABgbv56DY4XMePLhgi85vZyujxGFyAHFw5FONRAM9wd8ZrReatgJ
	 c06KMQpFqXdqoruiW0SzV4NLVrFIobIuv5SbxLn4ocCTovcJSUAlWaBjdD0wXFAoHe
	 fW3dvqB+VpME8Y4CPlLPANi864328+b5OuImxVS7Hh2PrIeAfWSS7lDrQ9/hPkFiXL
	 QLR6HWIdHmnRHMXALrQ/tqvW9MyoENeLLqEsy8rurrV8vucFWmVoxQj4sEfScr0MhR
	 K4XeFIVlUvJyQHPdOyadx8wekPo5+do9T1dN8kr2So8FqQeBCiq60nK7WVzeKwMkRQ
	 Jop/2Tv3AXIIA==
Date: Sat, 15 Mar 2025 20:33:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as
 pci_fixup_header
Message-ID: <20250315113323.GA3547675@rocinante>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
 <20250315101319.5269-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315101319.5269-1-zhangfei.gao@linaro.org>

Hello,

> The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> probe path") changes the arm_smmu_probe_device() sequence.
> 
> The arm_smmu_probe_device() is now called earlier via pci_device_add(),
> which calls pci_fixup_device() at the "pci_fixup_header" phase, while
> originally it was called from the pci_bus_add_device(), which called
> pci_fixup_device() at the "pci_fixup_final" phase.
> 
> The callstack before:
> [ 1121.314405]  arm_smmu_probe_device+0x48/0x450
> [ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
> [ 1121.314412]  iommu_probe_device+0x40/0x90
> [ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
> [ 1121.314417]  pci_dma_configure+0xf8/0x108
> [ 1121.314421]  really_probe+0x78/0x278
> [ 1121.314425]  __driver_probe_device+0x80/0x140
> [ 1121.314427]  driver_probe_device+0x48/0x130
> [ 1121.314430]  __device_attach_driver+0xc0/0x108
> [ 1121.314432]  bus_for_each_drv+0x8c/0xf8
> [ 1121.314435]  __device_attach+0x104/0x1a0
> [ 1121.314437]  device_attach+0x1c/0x30
> [ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
> [ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300
> 
> And after:
> [  215.072859]  arm_smmu_probe_device+0x48/0x450
> [  215.072871]  __iommu_probe_device+0xc0/0x468
> [  215.072875]  iommu_probe_device+0x40/0x90
> [  215.072877]  iommu_bus_notifier+0x38/0x68
> [  215.072879]  notifier_call_chain+0x80/0x148
> [  215.072886]  blocking_notifier_call_chain+0x50/0x80
> [  215.072889]  bus_notify+0x44/0x68
> [  215.072896]  device_add+0x580/0x768
> [  215.072898]  pci_device_add+0x1e8/0x568
> [  215.072906]  pci_iov_add_virtfn+0x198/0x300
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> [kwilczynski: commit log]
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

So, this will go through the IOMMU three, correct?  Once Bjorn adds his "Acked-by" tag.

Just want to make sure.

	Krzysztof

