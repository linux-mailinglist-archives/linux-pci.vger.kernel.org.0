Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E424A2E8A6
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 01:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfE2XDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 19:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfE2XDg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 19:03:36 -0400
Received: from localhost (15.sub-174-234-174.myvzw.com [174.234.174.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B06242E6;
        Wed, 29 May 2019 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559171015;
        bh=FHAF+9hLXRbuhRtbAY40XrpXY2ugiszkj6oUa84mIhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTFy69qjf/Kwl4fzfh3XKGruqgT2JJGg8NqeCyR+CyhAOHFzBrnuYXM60C5hbp3Hb
         qNpZQg9zugljDne4d1uZ21CuwmBg06sSlaZqg4t+79XHMrpizBK/fiFnlRzY52PJG6
         46TnmfIfl1lDZ/woSGRdXwSpDfraukEnq0G4N5Q0=
Date:   Wed, 29 May 2019 18:03:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v2 2/5] PCI/ATS: Add PASID support for PCIe VF devices
Message-ID: <20190529230334.GF28250@google.com>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <078b169334b4996d03d8608f205942c061590681.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078b169334b4996d03d8608f205942c061590681.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 06, 2019 at 10:20:04AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> When IOMMU tries to enable PASID for VF device in
> iommu_enable_dev_iotlb(), it always fails because PASID support for PCIe
> VF device is currently broken in PCIE driver. Current implementation
> expects the given PCIe device (PF & VF) to implement PASID capability
> before enabling the PASID support. But this assumption is incorrect. As
> per PCIe spec r4.0, sec 9.3.7.14, all VFs associated with PF can only
> use the PASID of the PF and not implement it.
> 
> Since PASID is shared between PF/VF devices, following rules should
> apply.
> 
> 1. Enable PASID in VF only if its already enabled in PF.

s/its/it's/ (same comment applies to PRI patch, IIRC)

> 2. Enable PASID in VF only if the requested features matches with PF
> config, otherwise return error.
> 3. When enabling/disabling PASID for VF, instead of configuring the PF
> registers just increase/decrease the usage count (pasid_ref_cnt).
> 4. Disable PASID in PF (configuring the registers) only if pasid_ref_cnt
> is zero.
> 5. When reading PASID features/settings for VF, use registers of
> corresponding PF.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h |  1 +
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 5582e5d83a3f..e7a904e347c3 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -345,6 +345,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	u16 control, supported;
>  	int pos;
> +	struct pci_dev *pf;
>  
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
> @@ -353,7 +354,33 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  		return -EINVAL;
>  
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -	if (!pos)
> +
> +	if (pdev->is_virtfn) {
> +		/*
> +		 * Per PCIe r4.0, sec 9.3.7.14, VF must not implement
> +		 * Process Address Space ID (PASID) Capability.
> +		*/
> +		if (pos) {
> +			dev_err(&pdev->dev, "VF must not implement PASID\n");
> +			return -EINVAL
> +		}

Same comment as for PRI.

> +		/* Since VF shares PASID with PF, use PF config */
> +		pf = pci_physfn(pdev);
> +
> +		/* If VF config does not match with PF, return error */
> +		if (!pf->pasid_enabled || pf->pasid_features != features)
> +			return -EINVAL;
> +
> +		pdev->pasid_features = features;

I don't think this is used for VFs.

> +		pdev->pasid_enabled = 1;
> +
> +		/* Increment PF PASID refcount */
> +		atomic_inc(&pf->pasid_ref_cnt);
> +
> +		return 0;
> +	}
> +
> +	if (pdev->is_physfn && !pos)
>  		return -EINVAL;
>  
>  	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
> @@ -382,10 +409,27 @@ void pci_disable_pasid(struct pci_dev *pdev)
>  {
>  	u16 control = 0;
>  	int pos;
> +	struct pci_dev *pf;
>  
>  	if (WARN_ON(!pdev->pasid_enabled))
>  		return;
>  
> +	/* All VFs PASID should be disabled before disabling PF PASID*/

Add space at end of comment.

> +	if (atomic_read(&pdev->pasid_ref_cnt))
> +		return;
> +
> +	if (pdev->is_virtfn) {
> +		/* Since VF shares PASID with PF, use PF config. */

Most single-line, single-sentence comments here do not include a
trailing period.

> +		pf = pci_physfn(pdev);
> +
> +		/* Decrement PF PASID refcount */
> +		atomic_dec(&pf->pasid_ref_cnt);
> +
> +		pdev->pasid_enabled = 0;
> +
> +		return;
> +	}
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return;
> @@ -408,6 +452,9 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
>  	if (!pdev->pasid_enabled)
>  		return;
>  
> +	if (pdev->is_virtfn)
> +		return;
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return;
> @@ -432,6 +479,9 @@ int pci_pasid_features(struct pci_dev *pdev)
>  	u16 supported;
>  	int pos;
>  
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return -EINVAL;
> @@ -488,6 +538,9 @@ int pci_max_pasids(struct pci_dev *pdev)
>  	u16 supported;
>  	int pos;
>  
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return -EINVAL;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 699c79c99a39..2a761ea63f8d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -454,6 +454,7 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_PCI_PASID
>  	u16		pasid_features;
> +	atomic_t	pasid_ref_cnt;	/* Number of VFs with PASID enabled */
>  #endif
>  #ifdef CONFIG_PCI_P2PDMA
>  	struct pci_p2pdma *p2pdma;
> -- 
> 2.20.1
> 
