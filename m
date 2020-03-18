Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503E818A759
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 22:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCRVti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 17:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCRVti (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 17:49:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AB5F20754;
        Wed, 18 Mar 2020 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584568177;
        bh=P5WR7+CCKYuF1D3YjB6Qxj3jRbK8RLNPfWPK6xDhFJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYDwg6ol1Z+QGh9/zDrDHt8bnPDtWLxTMCHZXahQMrF2zKu+dxR/eo1lJ1FPMFmub
         rYxZ8TlyKf1p57qSoAehM9cwXmkd62W+Yj/ZFIe/fzmdsKEaGLM6wI5Isl4w5zHhXz
         i2Fyra1JtidfYnS4VkKmkpnTCTdgAjhqKz+PtDSA=
Date:   Wed, 18 Mar 2020 21:49:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, joro@8bytes.org,
        baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH v2 07/11] iommu/arm-smmu-v3: Use pci_ats_supported()
Message-ID: <20200318214930.GB8477@willie-the-truck>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
 <20200311124506.208376-8-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-8-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 01:45:02PM +0100, Jean-Philippe Brucker wrote:
> The new pci_ats_supported() function checks if a device supports ATS and
> is allowed to use it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4f0a38dae6db..87ae31ef35a1 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2592,26 +2592,14 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
>  	}
>  }
>  
> -#ifdef CONFIG_PCI_ATS
>  static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>  {
> -	struct pci_dev *pdev;
> +	struct device *dev = master->dev;
>  	struct arm_smmu_device *smmu = master->smmu;
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> -
> -	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
> -	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
> -		return false;
>  
> -	pdev = to_pci_dev(master->dev);
> -	return !pdev->untrusted && pdev->ats_cap;
> +	return (smmu->features & ARM_SMMU_FEAT_ATS) && dev_is_pci(dev) &&
> +		pci_ats_supported(to_pci_dev(dev));
>  }
> -#else
> -static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> -{
> -	return false;
> -}
> -#endif

Acked-by: Will Deacon <will@kernel.org>

Cheers for doing this.

Will
