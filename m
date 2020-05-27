Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F311E4CF4
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391938AbgE0SSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 14:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391932AbgE0SSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 14:18:45 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF692075A;
        Wed, 27 May 2020 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590603524;
        bh=IlJRE+s/Xn0kFANnhdpCDcIhPKRLpygy8ad6xlPlHjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nIx2hX8lM30uXBDTL7TuhND9kQ3G+qZ++mUq5WECUp59CfqdUpYK43QoUK7AXlVPf
         KxTUevqFBycL9TlKq7SmWveEDn1K/rg1pDaaEGJos75PWipKFqulr3bGwuDJBHuVi1
         7/+Jn7myhnHFa+KsZWLZ+HqvliJJB2ISAncHJDyU=
Date:   Wed, 27 May 2020 13:18:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200527181842.GA256680@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 07:49:07PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI but are actually on the AMBA bus,
> and they need fixup in drivers/pci/quirks.c handling iommu_fwnode.
> Here introducing PCI_FIXUP_IOMMU, which is called after iommu_fwnode
> is allocated, instead of reusing PCI_FIXUP_FINAL since it will slow
> down iommu probing as all devices in fixup final list will be
> reprocessed, suggested by Joerg, [1]

Is this slowdown significant?  We already iterate over every device
when applying PCI_FIXUP_FINAL quirks, so if we used the existing
PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
adding two more iterations to the loop in pci_do_fixups() that tries
to match quirks against the current device.  I doubt that would be a
measurable slowdown.

> For example:
> Hisilicon platform device need fixup in
> drivers/pci/quirks.c handling fwspec->can_stall, which is introduced in [2]
> 
> +static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
> +{
> +    struct iommu_fwspec *fwspec;
> +
> +    pdev->eetlp_prefix_path = 1;
> +    fwspec = dev_iommu_fwspec_get(&pdev->dev);
> +    if (fwspec)
> +        fwspec->can_stall = 1;
> +}
> +
> +DECLARE_PCI_FIXUP_IOMMU(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> +DECLARE_PCI_iFIXUP_IOMMU(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva); 
> 
> [1] https://www.spinics.net/lists/iommu/msg44591.html
> [2] https://www.spinics.net/lists/linux-pci/msg94559.html

If you reference these in the commit logs, please use lore.kernel.org
links instead of spinics.

> Zhangfei Gao (2):
>   PCI: Introduce PCI_FIXUP_IOMMU
>   iommu: calling pci_fixup_iommu in iommu_fwspec_init
> 
>  drivers/iommu/iommu.c             | 4 ++++
>  drivers/pci/quirks.c              | 7 +++++++
>  include/asm-generic/vmlinux.lds.h | 3 +++
>  include/linux/pci.h               | 8 ++++++++
>  4 files changed, 22 insertions(+)
> 
> -- 
> 2.7.4
> 
