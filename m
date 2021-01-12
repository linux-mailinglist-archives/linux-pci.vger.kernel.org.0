Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3E2F3682
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391760AbhALRDM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 12:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391743AbhALRDM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 12:03:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 941122311B;
        Tue, 12 Jan 2021 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610470951;
        bh=u3YAk8tJDd0MtgxLEfhIWKvQfuFzbUKBa4f66KHwhYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZJ+2sq2qTWeWBLWHzkhOhPkTtz2MfYFGSJ1KT564skIqTBB3kYFrVjm1ID3tou+WI
         HjkUofZqZsN1Uv3HWOJEJW9bXlxa/PrOhFW1LEzkGlljSLFJfolE59yPCQBg3EJnmr
         giCItS/4Zrs/UI0o1Bp9rLxw6PoQdhRJ60ZQiVamAZ8zBXhefkcz7AVaDDFAjopqW5
         0DttEnHBUoXZIRamgeIwyJ+V5+npbmfKikTCn4vmb3QpgL4UqjeYlX/hGWMZKkIPf4
         iu9/oRNbKzQrvbE97FXQhNmDmp2zfpuIlxashxw7qXZdtuZ5/g7czup2anEA+fR4n/
         igVdxT9nFoexA==
Date:   Tue, 12 Jan 2021 11:02:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add a quirk to enable SVA for HiSilicon chip
Message-ID: <20210112170230.GA1838341@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610434192-27995-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 02:49:52PM +0800, Zhangfei Gao wrote:
> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> actually on the AMBA bus. These fake PCI devices can not support tlp
> and have to enable SMMU stall mode to use the SVA feature.
> 
> Add a quirk to set dma-can-stall property and enable tlp for these devices.

s/tlp/TLP/

I don't think "enable TLP" really captures what's going on here.  You
must be referring to the fact that you set pdev->eetlp_prefix_path.

That is normally set by pci_configure_eetlp_prefix() if the Device
Capabilities 2 register has the End-End TLP Prefix Supported bit set
*and* all devices in the upstream path also have it set.

The only place we currently test eetlp_prefix_path is in
pci_enable_pasid().  In PCIe, PASID is implemented using the PASID TLP
prefix, so we only enable PASID if TLP prefixes are supported.

If I understand correctly, a PASID-like feature is implemented on AMBA
without using TLP prefixes, and setting eetlp_prefix_path makes that
work.

I don't think you should do this by setting eetlp_prefix_path because
TLP prefixes are used for other features, e.g., TPH.  Setting
eetlp_prefix_path implies these devices can also support things like
TLP, and I don't think that's necessarily true.

Apparently these devices have a PASID capability.  I think you should
add a new pci_dev bit that is specific to this idea of "PASID works
without TLP prefixes" and then change pci_enable_pasid() to look at
that bit as well as eetlp_prefix_path.

It seems like dma-can-stall is a separate thing from PASID?  If so,
this should be two separate patches.

If they can be separated, I would probably make the PASID thing the
first patch, and then the "dma-can-stall" can be on its own as a
broken DT workaround (if that's what it is) and it's easier to remove
that if it become obsolete.

> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
> Property dma-can-stall depends on patchset
> https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/
> 
> drivers/pci/quirks.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e..a27f327 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1825,6 +1825,31 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
>  
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
>  
> +static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
> +{
> +	struct property_entry properties[] = {
> +		PROPERTY_ENTRY_BOOL("dma-can-stall"),
> +		{},
> +	};
> +
> +	if ((pdev->revision != 0x21) && (pdev->revision != 0x30))
> +		return;
> +
> +	pdev->eetlp_prefix_path = 1;
> +
> +	/* Device-tree can set the stall property */
> +	if (!pdev->dev.of_node &&
> +	    device_add_properties(&pdev->dev, properties))

Does this mean "dma-can-stall" *can* be set via DT, and if it is, this
quirk is not needed?  So is this quirk basically a workaround for an
old or broken DT?

> +		pci_warn(pdev, "could not add stall property");
> +}
> +

Remove this blank line to follow the style of the rest of the file.

> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
> +
>  /*
>   * It's possible for the MSI to get corrupted if SHPC and ACPI are used
>   * together on certain PXH-based systems.
> -- 
> 2.7.4
> 
