Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B802FF132
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbhAUQ6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 11:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732160AbhAUQ5x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 11:57:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D5223A51;
        Thu, 21 Jan 2021 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611248229;
        bh=7NqW+561qsjMOCC/bfVRpec8+rgmHi6zGR3uVlBcjfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H4VresKbjlKd6LVrJLsRqAbZWXKv7KnjWA7lVSLdAysd0pjkZGPCso16qXdFZZmx3
         vqPT7ECr0Bh+oKxDv4KffXwcuiA4KweMipR0LebDE6MRtX9nX04lN+sX7ya8I1rlrf
         R4rNYp//C/hOJWCBject85rrTkI/wf9K5W5BwOAKh7+WmfztxuB53gcOVwxF52MkhO
         2pkXr7fCtqd4Qv7DLcIy9gPIckRNAHW8pzns85JlJRmM+kZmJrsj/ROQSgd8UW6oI2
         nTOv1hWUyarbh0Bnu52ZqCUUm+giPfyKKiJSBL84jjJPT1KLlDz0RhppKCU1OuKQAZ
         q43Cw/C7Dya7A==
Date:   Thu, 21 Jan 2021 10:57:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: set dma-can-stall for HiSilicon chip
Message-ID: <20210121165706.GA2663152@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610960316-28935-4-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 18, 2021 at 04:58:36PM +0800, Zhangfei Gao wrote:
> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> actually on the AMBA bus. These fake PCI devices can support SVA via
> SMMU stall feature, by setting dma-can-stall for ACPI platforms.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
> Property dma-can-stall depends on patchset
> https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/
> 
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 873d27f..b866cdf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1827,10 +1827,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
>  
>  static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>  {
> +	struct property_entry properties[] = {
> +		PROPERTY_ENTRY_BOOL("dma-can-stall"),
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

What's the purpose of adding the "dma-can-stall" property?  I don't
see any reference to that property in the tree or in this series.  If
this is related to some other series that uses it, perhaps this part
should be moved to that series?

>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> -- 
> 2.7.4
> 
