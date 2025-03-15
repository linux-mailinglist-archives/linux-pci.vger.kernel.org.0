Return-Path: <linux-pci+bounces-23851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD42A631D7
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 19:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25512174BEE
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4C15573F;
	Sat, 15 Mar 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekYYnoCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672A1F5FD;
	Sat, 15 Mar 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064325; cv=none; b=X8Hkt3KY+LuWdg8JiWmkcLsgfdgCrqAhrmTDkrxcppgM396/Bl+om3LgVdb8yeIAhzdxereXxRRCiFryA99ZZI3LVYSG8Do0sQWhnwJS65lgPWUWG8JGGix/xrW11HHReZRAts8QK53ibUDiIutWTGHmYJ9c/lxtxTj5mRSn81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064325; c=relaxed/simple;
	bh=4MhnkjWg/sUNC8gItCM/jiir8SJBGG2nGEGqhQyt2oM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lK9XxtSDeh/AUSoUhqtiUU50FCN/OzJ5yZv8+masGY8rmyf2BNO+xAmTfBk1AbjfDRMa6Pys//xFWuVgKnqcabnS4hLxYZM6JwDSPgSjLJU3S1Mxwfrwqi39mkUBx59XqAlt7iE/sAh2/vVziZHE1kmjZMggNrd+2n2+mqc/Z/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekYYnoCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6E9C4CEE5;
	Sat, 15 Mar 2025 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064325;
	bh=4MhnkjWg/sUNC8gItCM/jiir8SJBGG2nGEGqhQyt2oM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ekYYnoCNuNGq8GKgAHkJLE8+/WhianniML9ojpkV7NZIPXHS3fhqp4CCkOSBn3gQA
	 ZuHm8JMr9eVigUhkdFponK9pava0p8RDgb4Z+lkwOStZiGlX39vdHOpg93tQaNP2gh
	 iW4fFeOxiJy24BUtSlZ5xalyDL6VUSPTlF7LrqzipEmq7Tp1RWxSIV9JjJ7ZVYutXs
	 8mqnsU49tYj9HwhPetAjLwFEMCgOTca6Y9mA1UeSIpyoMWn3BgrWWKdq7hv/IQwqpH
	 gmEH59mi5/Zro2o7LAv991Gw7iEwkFRBxek7djhIgywcvQUxyJuEBxLukwkBWoLru9
	 Dm57qYb49gWOw==
Date: Sat, 15 Mar 2025 13:45:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as
 pci_fixup_header
Message-ID: <20250315184523.GA848225@bhelgaas>
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

On Sat, Mar 15, 2025 at 10:13:19AM +0000, Zhangfei Gao wrote:
> The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> probe path") changes the arm_smmu_probe_device() sequence.

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

The stacktraces definitely help connect the dots but don't integrate
the fixup phases and the timestamps are unnecessary distraction.

I would omit all the above except the first paragraph and include
something like this instead, which shows how arm_smmu_probe_device()
was previously after final fixups and is now between header and final
fixups:

  pci_iov_add_virtfn
    pci_device_add
      pci_fixup_device(pci_fixup_header)      <--
      device_add
        bus_notify
          iommu_bus_notifier
  +         iommu_probe_device
  +           arm_smmu_probe_device
    pci_bus_add_device
      pci_fixup_device(pci_fixup_final)       <--
      device_attach
        driver_probe_device
          really_probe
            pci_dma_configure
              acpi_dma_configure_id
  -             iommu_probe_device
  -               arm_smmu_probe_device

This is the pci_iov_add_virtfn().  The non-SR-IOV case is similar in
that pci_device_add() is called from pci_scan_single_device() in the
generic enumeration path, and pci_bus_add_device() is called later,
after all a host bridge has been enumerated.

> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> [kwilczynski: commit log]
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

You should never include somebody else's Signed-off-by below yours.
You should only add *your own* Signed-off-by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.13#n396

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> v2: Modify commit log
> 
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

