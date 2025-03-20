Return-Path: <linux-pci+bounces-24231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86191A6A81B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D961B18803DC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4315C158;
	Thu, 20 Mar 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="On/C8O9r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D16175D50
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479689; cv=none; b=Zvti5dx5usqf2y3+su9lwbFxsvm8hluE0NLf4z0Dwfo9wNy7PokrZ0UcXd2g3NGV+0AV6O5c2pOQGtoD+Q/TSOIVyvP/Gl4vzk0VGcvV9rBkN0I0NIAvuGI8++VylkgafXORSDXKeOiNg9FIxggLQ96Y88jdDDsUs/qzsbo20xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479689; c=relaxed/simple;
	bh=L0Ns8xc3Q3br2dzt9w3k8ad2LcmDXSY7pM/vbS+5JgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WH2kS8h8UmA5NakQx5Af98Cv/jH7UrRQoPox2cVR9sS0Mn4n0koX2xzA+VCqvmik8avtCnuZjN4uG7js6IPwbQfCPsJm6uSluaTj8GkToo6R1pKW6oEqmOSUkvAJkfHHa84IYsgc2+XwXilm+3GFfHSroUeZ/QfDadz4oZW6A+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=On/C8O9r; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54298ec925bso1388365e87.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479685; x=1743084485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GW+AIfrfnZlEZ1i2OuNqT9lfOEs4AghqG0/GPy1/W3c=;
        b=On/C8O9rXttjcYWYlOWQy4uTRiUWM0xg4khUKT1PVzl9wCvMe9bj/y9u0NcPEM9t3R
         AGes0+esE1XGt1N+lpskxCKptKiPLWCrdED4dPXwpty+E2ihF1FjpMzytzq0oY2z0CSD
         khOYQW3nMnfKbyF+VBdK29DN23yo8+YSV24KD9Np9QAt7R7GJeGlZTDtsQ/Gw3/HUQag
         bd5SIvmTpjCzTfmQnRVy4RMHe8I6XFpz7YvLpVcao/UCxFaMpksC6qU49h/l0RjbXgHk
         EqtO9QEceXf60YVqMpyFmI3ZiUQD9G8jLWp5zHq2a9jP3u3hQXYgOAzPAVMSGwiOhSHb
         hwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479685; x=1743084485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW+AIfrfnZlEZ1i2OuNqT9lfOEs4AghqG0/GPy1/W3c=;
        b=wgQJpMzGMZf4IZIL5uTKC4XwCqD5h+uEUcQLCTxHh+BljdBTLYmIVnjucrpdL2iOu7
         UpvrL5QJmgdef2f5cqL+fbouiL//psshU4Wb76Bgz8H7pBTMA20bQ0ezUCh/A8QNhtze
         KUVmrMi4m2GZSuPctYPfSPOXvqvCyrtsJ8hrVIY8nTah2Nsa16rb/djKazPQdH1bPP+x
         jq6ujoQY+C7RiQXMIky1t578Gx8/itRjYam70Brqab+zhRMpqryrPu9EwIY/HOWWRaf7
         c4/L30NMHLbq+OEbD/wRsNqVmxjXYBapqYseygpnY3WjbfI9ejFZNpTsAHL8x4l65N+p
         gIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfxGRNKMgFeFl4gkKvZf92GmjYvGtGMNHWVxZWLL0RRMw8Au9U+vxV+UOzqBenvGbVqhWTMhiDpYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLHF90hLGRBLxS6RPjE08wgGat3iCDkyP3svF7XV9WVFbB2Dqd
	p3NslgJHYyAo1HsH/fcCqLikxN5exUoN2nbBL70F2Ngclya7tzImoQI3pFdEZNPE0loEThdvIRL
	BPShTCHzCN92EY3uoeOh9BYAQsSJoUPXCxbJIYQ==
X-Gm-Gg: ASbGncsxVuuJkduWlj3nfjLiJGONnV11MeViRyWWIJGaI7j/kpZii1YEkz6nbivWgjU
	IEBcv2qCCSG2p572ZqrxxMJFNJcohBUzyrvx4SuqjKBbtT2WXyAEVQtOqzFdBcRNQNsHuLECYko
	Mhf3jcW2Xl3VObO7zs4Z+mO0qXelFpeGs=
X-Google-Smtp-Source: AGHT+IE0nZc36emahZKbVDAnCMDyH/ywSdu+VkMSO0TuJrJF/3VJxt+BWvKKWZTm/hV640C6sCQwdH4kYd9L7GQ0dLg=
X-Received: by 2002:a05:6512:238f:b0:549:b0f3:439b with SMTP id
 2adb3069b0e04-54ad062afbbmr1432242e87.16.1742479684999; Thu, 20 Mar 2025
 07:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315101032.5152-1-zhangfei.gao@linaro.org> <20250317011352.5806-1-zhangfei.gao@linaro.org>
In-Reply-To: <20250317011352.5806-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 20 Mar 2025 22:07:52 +0800
X-Gm-Features: AQ5f1JpZtpDjBufurDoU0Dm8aec8lXWg1YWzfL8ksZ4Km8I3bD8mNe2JhE6E6Y0
Message-ID: <CABQgh9H3POdKGsphA42C+i2_z9xCHHfSm4ULkMVmFyKBm9bWtA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
To: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Joerg

On Mon, 17 Mar 2025 at 09:14, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
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

Would you mind take a look at this patch

Bjorn suggested
"I think there's some value in keeping fixes close to whatever needs to
be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
to merge the fix the same way."

Thanks


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
>             device_create_managed_software_node(&pdev->dev, properties, NULL))
>                 pci_warn(pdev, "could not add stall property");
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

