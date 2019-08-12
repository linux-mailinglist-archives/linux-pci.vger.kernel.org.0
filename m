Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617E78A7D6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfHLUFM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfHLUFM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:05:12 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2A0214C6;
        Mon, 12 Aug 2019 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640310;
        bh=5FzscgA9Lz09h5al5eQNGLK6KBM1ZTFFMlqtbO4bRzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QggEPBdc9O4R+cCEOpdwd5mYtgCobyP9CPniHaXcX53ySz1qH5EPbqiCRphHct9rH
         /ECoDO6VnMjCbOv+qg6F4Fy8zSl1eKj0PqO5MA04EL53vO6amAn3SlopAJFQsDfmBo
         rksBTZtrJh0+dluXYSx82EAwI8MMyjd7GEGJSwNs=
Date:   Mon, 12 Aug 2019 15:05:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 5/7] PCI/ATS: Add PASID support for PCIe VF devices
Message-ID: <20190812200508.GM11785@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d10b5f08212a42c4a710ec649bffe082599dbb46.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10b5f08212a42c4a710ec649bffe082599dbb46.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 05:06:02PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
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
> Also, since PASID is a shared resource between PF/VF, following rules
> should apply.
> 
> 1. Use proper locking before accessing/modifying PF resources in VF
>    PASID enable/disable call.
> 2. Use reference count logic to track the usage of PASID resource.
> 3. Disable PASID only if the PASID reference count (pasid_ref_cnt) is zero.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c   | 113 ++++++++++++++++++++++++++++++++++----------
>  include/linux/pci.h |   2 +
>  2 files changed, 90 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 079dc5444444..9384afd7d00e 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -402,6 +402,8 @@ void pci_pasid_init(struct pci_dev *pdev)
>  	if (pdev->is_virtfn)
>  		return;
>  
> +	mutex_init(&pdev->pasid_lock);
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return;
> @@ -436,32 +438,57 @@ void pci_pasid_init(struct pci_dev *pdev)
>  int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	u16 control, supported;
> +	int ret = 0;
> +	struct pci_dev *pf = pci_physfn(pdev);
>  
> -	if (WARN_ON(pdev->pasid_enabled))
> -		return -EBUSY;
> +	mutex_lock(&pf->pasid_lock);
>  
> -	if (!pdev->eetlp_prefix_path)
> -		return -EINVAL;
> +	if (WARN_ON(pdev->pasid_enabled)) {
> +		ret = -EBUSY;
> +		goto pasid_unlock;
> +	}
>  
> -	if (!pdev->pasid_cap)
> -		return -EINVAL;
> +	if (!pdev->eetlp_prefix_path) {
> +		ret = -EINVAL;
> +		goto pasid_unlock;
> +	}
>  
> -	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> -			     &supported);
> +	if (!pf->pasid_cap) {
> +		ret = -EINVAL;
> +		goto pasid_unlock;
> +	}
> +
> +	if (pdev->is_virtfn && pf->pasid_enabled)
> +		goto update_status;
> +
> +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
>  	/* User wants to enable anything unsupported? */
> -	if ((supported & features) != features)
> -		return -EINVAL;
> +	if ((supported & features) != features) {
> +		ret = -EINVAL;
> +		goto pasid_unlock;
> +	}
>  
>  	control = PCI_PASID_CTRL_ENABLE | features;
> -	pdev->pasid_features = features;
> -
> +	pf->pasid_features = features;
>  	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
>  
> -	pdev->pasid_enabled = 1;
> +	/*
> +	 * If PASID is not already enabled in PF, increment pasid_ref_cnt
> +	 * to count PF PASID usage.
> +	 */
> +	if (pdev->is_virtfn && !pf->pasid_enabled) {
> +		atomic_inc(&pf->pasid_ref_cnt);
> +		pf->pasid_enabled = 1;
> +	}
>  
> -	return 0;
> +update_status:
> +	atomic_inc(&pf->pasid_ref_cnt);
> +	pdev->pasid_enabled = 1;
> +pasid_unlock:
> +	mutex_unlock(&pf->pasid_lock);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pasid);
>  
> @@ -472,16 +499,29 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
>  void pci_disable_pasid(struct pci_dev *pdev)
>  {
>  	u16 control = 0;
> +	struct pci_dev *pf = pci_physfn(pdev);
> +
> +	mutex_lock(&pf->pasid_lock);
>  
>  	if (WARN_ON(!pdev->pasid_enabled))
> -		return;
> +		goto pasid_unlock;
>  
> -	if (!pdev->pasid_cap)
> -		return;
> +	if (!pf->pasid_cap)
> +		goto pasid_unlock;
>  
> -	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
> +	atomic_dec(&pf->pasid_ref_cnt);
>  
> +	if (atomic_read(&pf->pasid_ref_cnt))
> +		goto done;
> +
> +	/* Disable PASID only if pasid_ref_cnt is zero */
> +	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
> +
> +done:
>  	pdev->pasid_enabled = 0;
> +pasid_unlock:
> +	mutex_unlock(&pf->pasid_lock);
> +
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_pasid);
>  
> @@ -492,15 +532,25 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
>  void pci_restore_pasid_state(struct pci_dev *pdev)
>  {
>  	u16 control;
> +	struct pci_dev *pf = pci_physfn(pdev);
>  
>  	if (!pdev->pasid_enabled)
>  		return;
>  
> -	if (!pdev->pasid_cap)
> +	if (!pf->pasid_cap)
>  		return;
>  
> +	mutex_lock(&pf->pasid_lock);
> +
> +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, &control);
> +	if (control & PCI_PASID_CTRL_ENABLE)
> +		goto pasid_unlock;
> +
>  	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
> -	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
> +	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
> +
> +pasid_unlock:
> +	mutex_unlock(&pf->pasid_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
>  
> @@ -517,15 +567,22 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
>  int pci_pasid_features(struct pci_dev *pdev)
>  {
>  	u16 supported;
> +	struct pci_dev *pf = pci_physfn(pdev);
> +
> +	mutex_lock(&pf->pasid_lock);
>  
> -	if (!pdev->pasid_cap)
> +	if (!pf->pasid_cap) {
> +		mutex_unlock(&pf->pasid_lock);
>  		return -EINVAL;
> +	}
>  
> -	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP,
>  			     &supported);
>  
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
> +	mutex_unlock(&pf->pasid_lock);
> +
>  	return supported;
>  }
>  EXPORT_SYMBOL_GPL(pci_pasid_features);
> @@ -579,15 +636,21 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>  int pci_max_pasids(struct pci_dev *pdev)
>  {
>  	u16 supported;
> +	struct pci_dev *pf = pci_physfn(pdev);
> +
> +	mutex_lock(&pf->pasid_lock);
>  
> -	if (!pdev->pasid_cap)
> +	if (!pf->pasid_cap) {
> +		mutex_unlock(&pf->pasid_lock);
>  		return -EINVAL;
> +	}
>  
> -	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> -			     &supported);
> +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
>  
>  	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
>  
> +	mutex_unlock(&pf->pasid_lock);
> +
>  	return (1 << supported);
>  }
>  EXPORT_SYMBOL_GPL(pci_max_pasids);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3c9c4c82be27..4bfcca045afd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -461,8 +461,10 @@ struct pci_dev {
>  	atomic_t	pri_ref_cnt;	/* Number of PF/VF PRI users */
>  #endif
>  #ifdef CONFIG_PCI_PASID
> +	struct mutex	pasid_lock;	/* PASID enable lock */

I think these locks are finer-grained than necessary.  I'm not sure
it's worth having two mutexes for every device (one for PRI and
another for PASID).  Is there really a performance benefit for having
two?

Do it (or do they) need to be in struct pci_dev?  You only use the PF
mutexes, so maybe it could be in the struct pci_sriov, which I think
is only one per PF.

>  	u16		pasid_cap;	/* PASID Capability offset */
>  	u16		pasid_features;
> +	atomic_t	pasid_ref_cnt;	/* Number of VFs with PASID enabled */
>  #endif
>  #ifdef CONFIG_PCI_P2PDMA
>  	struct pci_p2pdma *p2pdma;
> -- 
> 2.21.0
> 
