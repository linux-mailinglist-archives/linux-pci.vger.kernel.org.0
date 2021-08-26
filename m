Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9543F8DCE
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhHZS1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235411AbhHZS1N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 14:27:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFB3160E8B;
        Thu, 26 Aug 2021 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630002386;
        bh=EZpMOg5uZ1atXvNVcFF6zwuiJW5v8+/QZHYkgJs2j6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=buwDYdn5zc5hloF3bxX0SYWf2fzfQ7RzdOt11hfvqxj17/h0aMMpG8EdJZscQ6Jjh
         Y4qp9zx8oFP4d92shWmbTOshfgKQdyH1rqeNba9uUTZJOB35GwehS28Gsaq5vNfvRo
         zhWT+s6kXwO7uL2Eh5o59zQZVNV3FKw/ApFGxMVLC5Qcd4cnFNlQz2aVUA21o6T5Y7
         6BGau5kyHzeh88+J60uI2R7gYOZD8oVLWyHAHBHtIYXgPCcvaDN732uczKR1h1sT0Z
         rVxFELzRLj8MwUA8j5+raFYiFH7t+tr3K8oOQ7qsxGNbo10FnlYuFk7x9/nCDHk/Ag
         MSss7+zGpmGOQ==
Date:   Thu, 26 Aug 2021 13:26:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 3/3] PCI: Set dma-can-stall for HiSilicon chips
Message-ID: <20210826182624.GA3694827@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626144876-11352-4-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Will, Robin, Joerg, hoping for an ack]

On Tue, Jul 13, 2021 at 10:54:36AM +0800, Zhangfei Gao wrote:
> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> actually on the AMBA bus. These fake PCI devices can support SVA via
> SMMU stall feature, by setting dma-can-stall for ACPI platforms.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 5d46ac6..03b0f98 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1823,10 +1823,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
>  
>  static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>  {
> +	struct property_entry properties[] = {
> +		PROPERTY_ENTRY_BOOL("dma-can-stall"),

"dma-can-stall" is used in arm_smmu_probe_device() to help set
master->stall_enabled.

I don't know the implications, so it'd be nice to get an ack from a
maintainer of that code.

> +		{},
> +	};
> +
>  	if (pdev->revision != 0x21 && pdev->revision != 0x30)
>  		return;
>  
>  	pdev->pasid_no_tlp = 1;
> +
> +	/*
> +	 * Set the dma-can-stall property on ACPI platforms. Device tree
> +	 * can set it directly.
> +	 */
> +	if (!pdev->dev.of_node &&
> +	    device_add_properties(&pdev->dev, properties))
> +		pci_warn(pdev, "could not add stall property");
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> -- 
> 2.7.4
> 
