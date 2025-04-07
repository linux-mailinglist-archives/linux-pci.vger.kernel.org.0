Return-Path: <linux-pci+bounces-25426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB4A7EBBA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 20:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B071890AE7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0A9235BF9;
	Mon,  7 Apr 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMGfy4lW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51F221717;
	Mon,  7 Apr 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050149; cv=none; b=B+GgOgmvvi9ksZ1Vr3v22YRMIEYG/2iJhjxjPCoY3oFkrUvFhzBk48OyaUhAdk3XuqYRCEJI5fKgw7hp/0oaQ+oIomBd9lpsaGWIkmfBXMOWunQZSomVzPrwhIQRx+gczZK6T58KkRZMiB4Am67JEqBb+9EUQwkegW/EbVMNBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050149; c=relaxed/simple;
	bh=Vzrl000GH9rO9BEdPNAMz2vKGlrv8PRMcFJ62aJ5frc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mjTDXBGFLgJevuSsYui3NxCsErbxRKnBPFuGUM4YcHt6p4KqArPb4vNsHp8hfYyarseWjMVgpskeGgsRW5hr2Krp613O9t5Ud5pcmHyKiohqL7qj8Tk1scCLgR8qmdtICTMroz85EbkmcE/yjDOIcNKTnkW87yr2Fsm+kZ9/htU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMGfy4lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A33C4CEDD;
	Mon,  7 Apr 2025 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744050148;
	bh=Vzrl000GH9rO9BEdPNAMz2vKGlrv8PRMcFJ62aJ5frc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qMGfy4lWe7Elq23Bz8lvEB5OtcNj0kqjxMrleJjNqBGwOxJAyYdIN0nV+zkV23vmD
	 upTPCbhNFr/hnGc8gee/QkDeOGETOIQsxMPDKltA1adk8+wz+PzG8X2u2yZ2saiSN9
	 x8vsJ8PlouW/h2vOdWSmszA8C/emrG0ASALDtzas9sjY1tEQcTwk2nq41idc4okrW8
	 q71ngcXjOhsSLZYlofhsG8DeYXI3NO4OB76p1LHTACaacniDNXZZLLWzgMc448oBfY
	 H3Z95vGdTpN/BiZ4DOhEI1BXbgn1nT4b+JuUtqyDhRaYhDI7hXN135LsyxIvY++okG
	 mQjkJVG5fLYdA==
Date: Mon, 7 Apr 2025 13:22:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as
 pci_fixup_header
Message-ID: <20250407182227.GA191373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317011352.5806-1-zhangfei.gao@linaro.org>

On Mon, Mar 17, 2025 at 01:13:52AM +0000, Zhangfei Gao wrote:
> The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> probe path") fixed the iommu_probe_device() flow to correctly initialize
> firmware operations, allowing arm_smmu_probe_device() to be invoked
> earlier. This changes the invocation timing of arm_smmu_probe_device
> from the final fixup phase to the header fixup phase.
> 
> pci_iov_add_virtfn
>     pci_device_add
>       pci_fixup_device(pci_fixup_header)      <--
>       device_add
>         bus_notify
>           iommu_bus_notifier
>   +         iommu_probe_device
>   +           arm_smmu_probe_device
>     pci_bus_add_device
>       pci_fixup_device(pci_fixup_final)       <--
>       device_attach
>         driver_probe_device
>           really_probe
>             pci_dma_configure
>               acpi_dma_configure_id
>   -             iommu_probe_device
>   -               arm_smmu_probe_device
> 
> This is the pci_iov_add_virtfn().  The non-SR-IOV case is similar in
> that pci_device_add() is called from pci_scan_single_device() in the
> generic enumeration path, and pci_bus_add_device() is called later,
> after all a host bridge has been enumerated.
> 
> Declare the fixup as pci_fixup_header to ensure the configuration
> happens before arm_smmu_probe_device.
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/for-linus for v6.15, thanks!

Joerg, if you'd rather take it, let me know and I can drop it.

> ---
> v3: modify commit msg, add Acked-by
> v2: modify commit msg
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

