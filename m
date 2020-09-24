Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C630D277520
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIXPWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgIXPWG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 11:22:06 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4966C20BED;
        Thu, 24 Sep 2020 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600960925;
        bh=4TbkOT/GggLxxE2NNVd/zaYCkfjd2TGSzd9JNR24sGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P2BjPiPIaVzcMfkeIDn8FdAjDUgvLl1r6+ZcmQolM3BpcI2k88Z6GplWoHSXeb/5Y
         m7Hr14bldTj6msNkYEbWEFWf//EmZ7MxJjJ+NWkMbskPXYDMVxDaM6JLoBTwEdC+nV
         Ba4eYQmYoif8fps9erNXPt+7uOxhQdWm6qAMFF20=
Date:   Thu, 24 Sep 2020 10:22:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Message-ID: <20200924152203.GA2320481@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821131540.2801801-6-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 03:15:39PM +0200, Jean-Philippe Brucker wrote:
> Platforms without device-tree nor ACPI can provide a topology
> description embedded into the virtio config space. Parse it.
> 
> Use PCI FIXUP to probe the config space early, because we need to
> discover the topology before any DMA configuration takes place, and the
> virtio driver may be loaded much later. Since we discover the topology
> description when probing the PCI hierarchy, the virtual IOMMU cannot
> manage other platform devices discovered earlier.

> +struct viommu_cap_config {
> +	u8 bar;
> +	u32 length; /* structure size */
> +	u32 offset; /* structure offset within the bar */

s/the bar/the BAR/ (to match comment below).

> +static void viommu_pci_parse_topology(struct pci_dev *dev)
> +{
> +	int ret;
> +	u32 features;
> +	void __iomem *regs, *common_regs;
> +	struct viommu_cap_config cap = {0};
> +	struct virtio_pci_common_cfg __iomem *common_cfg;
> +
> +	/*
> +	 * The virtio infrastructure might not be loaded at this point. We need
> +	 * to access the BARs ourselves.
> +	 */
> +	ret = viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &cap);
> +	if (!ret) {
> +		pci_warn(dev, "common capability not found\n");

Is the lack of this capability really an error, i.e., is this
pci_warn() or pci_info()?  The "device doesn't have topology
description" below is only pci_dbg(), which suggests that we can live
without this.

Maybe a hint about what "common capability" means?

> +		return;
> +	}
> +
> +	if (pci_enable_device_mem(dev))
> +		return;
> +
> +	common_regs = pci_iomap(dev, cap.bar, 0);
> +	if (!common_regs)
> +		return;
> +
> +	common_cfg = common_regs + cap.offset;
> +
> +	/* Perform the init sequence before we can read the config */
> +	ret = viommu_pci_reset(common_cfg);

I guess this is some special device-specific reset, not any kind of
standard PCI reset?

> +	if (ret < 0) {
> +		pci_warn(dev, "unable to reset device\n");
> +		goto out_unmap_common;
> +	}
> +
> +	iowrite8(VIRTIO_CONFIG_S_ACKNOWLEDGE, &common_cfg->device_status);
> +	iowrite8(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER,
> +		 &common_cfg->device_status);
> +
> +	/* Find out if the device supports topology description */
> +	iowrite32(0, &common_cfg->device_feature_select);
> +	features = ioread32(&common_cfg->device_feature);
> +
> +	if (!(features & BIT(VIRTIO_IOMMU_F_TOPOLOGY))) {
> +		pci_dbg(dev, "device doesn't have topology description");
> +		goto out_reset;
> +	}
> +
> +	ret = viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &cap);
> +	if (!ret) {
> +		pci_warn(dev, "device config capability not found\n");
> +		goto out_reset;
> +	}
> +
> +	regs = pci_iomap(dev, cap.bar, 0);
> +	if (!regs)
> +		goto out_reset;
> +
> +	pci_info(dev, "parsing virtio-iommu topology\n");
> +	ret = viommu_parse_topology(&dev->dev, regs + cap.offset,
> +				    pci_resource_len(dev, 0) - cap.offset);
> +	if (ret)
> +		pci_warn(dev, "failed to parse topology: %d\n", ret);
> +
> +	pci_iounmap(dev, regs);
> +out_reset:
> +	ret = viommu_pci_reset(common_cfg);
> +	if (ret)
> +		pci_warn(dev, "unable to reset device\n");
> +out_unmap_common:
> +	pci_iounmap(dev, common_regs);
> +}
> +
> +/*
> + * Catch a PCI virtio-iommu implementation early to get the topology description
> + * before we start probing other endpoints.
> + */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1040 + VIRTIO_ID_IOMMU,
> +			viommu_pci_parse_topology);
> -- 
> 2.28.0
> 
