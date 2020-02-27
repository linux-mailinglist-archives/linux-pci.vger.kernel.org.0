Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C241729CA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 21:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgB0Uz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 15:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgB0Uz4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 15:55:56 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83ED2468E;
        Thu, 27 Feb 2020 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582836956;
        bh=mGZf4nreP1kLtOs7P+f9h+8BDVGo9bsN87tYjSdZFZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N8ERNRm8Ml+eL2KAwMkCrdz7z8d89W/UaFjFnl/ihldRxJobDPgykvzz30oaRDx/x
         p07rXmQLCmbkc/uCwN2pZGMFwcB0WV5HHEOlnsDTUMKOP0cYK+2FpvDTrvH4UiCEgr
         b5EDbMuOMKzTjanCN7qZpeSpTsKDWpkixrxmGUV4=
Date:   Thu, 27 Feb 2020 14:55:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        yi.l.liu@intel.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 24/26] PCI/ATS: Add PRI stubs
Message-ID: <20200227205554.GA131305@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224182401.353359-25-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 07:23:59PM +0100, Jean-Philippe Brucker wrote:
> The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
> support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
> unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
> adding more #ifdefs to the SMMU driver.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci-ats.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index f75c307f346d..e9e266df9b37 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -28,6 +28,14 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>  void pci_disable_pri(struct pci_dev *pdev);
>  int pci_reset_pri(struct pci_dev *pdev);
>  int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> +#else /* CONFIG_PCI_PRI */
> +static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> +{ return -ENODEV; }
> +static inline void pci_disable_pri(struct pci_dev *pdev) { }
> +static inline int pci_reset_pri(struct pci_dev *pdev)
> +{ return -ENODEV; }
> +static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{ return 0; }
>  #endif /* CONFIG_PCI_PRI */
>  
>  #ifdef CONFIG_PCI_PASID
> -- 
> 2.25.0
> 
