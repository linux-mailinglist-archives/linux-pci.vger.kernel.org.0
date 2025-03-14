Return-Path: <linux-pci+bounces-23766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C92A61638
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0B63BD30D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D61F4288;
	Fri, 14 Mar 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHDAiM1a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850917BA1;
	Fri, 14 Mar 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969720; cv=none; b=XrgOHuIuvayk/O3KxIaCnG6JQ23upjX1HMOH+baTq5f8nJhnC5OV/RdUqBsCSpjKlPgdkf24e6TBau3IjE5//8CfWoJq7Fu7o9wR8oFFUja1bJGpeYqkpCFu4HWph+935fPng2DneBlpx1otlm/sgX/Rqg4/AvodzBnIA51hbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969720; c=relaxed/simple;
	bh=qacwLMXEjK4JiAeQUDhcWTm+NvQjfOcrIm90WEytWiw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rKZrmDxqe/VuJ4JS1CCT+tI0RV5ec4xL75R1F20xZ0n7lX1+LZqniPK+FP8JsXH9WmdjHrEKqLBOmQEeLi2r+QMj+HMdRaUnHJtBhEyy4seDfj/0kvKnxHuhcRys1kW3HdyCGDeS4g900Z/LkuUmel782lrSZqxMck1+0NZUBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHDAiM1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A47C4CEE3;
	Fri, 14 Mar 2025 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741969720;
	bh=qacwLMXEjK4JiAeQUDhcWTm+NvQjfOcrIm90WEytWiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CHDAiM1aDnT3szq7ftDBDnaAdHDDBIQ98/keYo+H+7vMVZx61RWig11YvJclVWX1S
	 jyUqBYWhp3aUnhRewlVXzyEe5IYMWsVNOIl5w5pfSkYmwff0mZWeAPjj6WutzVlWNX
	 eFMj6GS4/Xtpzx45NAci9LFsVNyGoynHWLaSVaxp4Urqyt1M9kuZQ21fsL5v7wkWdF
	 kM+tLiSgDIKAuaShZ6xLTo4oB1oQ8dqxxGfrbJfT52Sb1Vm30FlAq+9hS/zlGPrWQK
	 sf3IoE9FOdjFgg2mk0txcThab/0Vl2s0DH2rpxtaqMnYoVa8scwyZv/JBxGTuD9A1x
	 FvUJJAskcC2gA==
Date: Fri, 14 Mar 2025 11:28:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
Message-ID: <20250314162838.GA781747@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071058.6713-1-zhangfei.gao@linaro.org>

On Fri, Mar 14, 2025 at 07:10:58AM +0000, Zhangfei Gao wrote:
> "bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
> changes arm_smmu_probe_device sequence.

Normal commit reference style is:

  bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")

bcb81ac6ae3c is not a valid upstream commit.  It does appear in
next-20250314, incorporated via f5a5f66e2791 ("Merge branches
'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 's390', 'core',
'intel/vt-d' and 'amd/amd-vi' into next") from
git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git.

I think there's some value in keeping fixes close to whatever needs to
be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
to merge the fix the same way.

Unless there's a rebase to merge this change before bcb81ac6ae3c, this
probably needs a "Fixes:" tag so people who backport bcb81ac6ae3c have
a hint that this quirk change should be backported along with it.

> From
> pci_bus_add_device(virtfn)
> -> pci_fixup_device(pci_fixup_final, dev)
> -> arm_smmu_probe_device
> 
> To
> pci_device_add(virtfn, virtfn->bus)
> -> pci_fixup_device(pci_fixup_header, dev)
> -> arm_smmu_probe_device

This doesn't include enough detail to show the change.  I don't know
the path to arm_smmu_probe_device() and how it relates to
pci_bus_add_device() and pci_device_add().

> So declare the fixup as pci_fixup_header to take effect
> before arm_smmu_probe_device.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/pci/quirks.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f840d611c450..a9759889ff5e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1991,12 +1991,12 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>  	    device_create_managed_software_node(&pdev->dev, properties, NULL))
>  		pci_warn(pdev, "could not add stall property");
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
>  
>  /*
>   * It's possible for the MSI to get corrupted if SHPC and ACPI are used
> -- 
> 2.25.1
> 

