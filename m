Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F788AD66
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 06:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfHMEQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 00:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfHMEQc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 00:16:32 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E841E2067D;
        Tue, 13 Aug 2019 04:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565669791;
        bh=KwLkNRfhiRocCSXs2a0TKCl3DF8tGTOsBGkDeVjFNRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCCII4tIJ57+oSpzwILQyDvcq0NiX+6ixYbazw4sv1oB9NRY5JV2ubY4MUpLCeIcV
         h7CFjTW7RpG8CWEdImtTv8Lr0k1GjxsLGb2oGu57ZlElv3XNbWMevpGUsxXnc4qLvz
         IxtNxPIxE4jhgbUtcBgvqhgDTJtLRReAsbNjmXNs=
Date:   Mon, 12 Aug 2019 23:16:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 4/7] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190813041630.GK7302@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 05:06:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> When IOMMU tries to enable Page Request Interface (PRI) for VF device
> in iommu_enable_dev_iotlb(), it always fails because PRI support for
> PCIe VF device is currently broken. Current implementation expects
> the given PCIe device (PF & VF) to implement PRI capability before
> enabling the PRI support. But this assumption is incorrect. As per PCIe
> spec r4.0, sec 9.3.7.11, all VFs associated with PF can only use the
> PRI of the PF and not implement it. Hence we need to create exception
> for handling the PRI support for PCIe VF device.
> 
> Also, since PRI is a shared resource between PF/VF, following rules
> should apply.
> 
> 1. Use proper locking before accessing/modifying PF resources in VF
>    PRI enable/disable call.
> 2. Use reference count logic to track the usage of PRI resource.
> 3. Disable PRI only if the PRI reference count (pri_ref_cnt) is zero.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c   | 143 ++++++++++++++++++++++++++++++++++----------
>  include/linux/pci.h |   2 +
>  2 files changed, 112 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 1f4be27a071d..079dc5444444 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -189,6 +189,8 @@ void pci_pri_init(struct pci_dev *pdev)
>  	if (pdev->is_virtfn)
>  		return;
>  
> +	mutex_init(&pdev->pri_lock);
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>  	if (!pos)
>  		return;
> @@ -221,29 +223,57 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>  {
>  	u16 control, status;
>  	u32 max_requests;
> +	int ret = 0;
> +	struct pci_dev *pf = pci_physfn(pdev);
>  
> -	if (WARN_ON(pdev->pri_enabled))
> -		return -EBUSY;
> +	mutex_lock(&pf->pri_lock);
>  
> -	if (!pdev->pri_cap)
> -		return -EINVAL;
> +	if (WARN_ON(pdev->pri_enabled)) {
> +		ret = -EBUSY;
> +		goto pri_unlock;
> +	}
>  
> -	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
> -	if (!(status & PCI_PRI_STATUS_STOPPED))
> -		return -EBUSY;
> +	if (!pf->pri_cap) {
> +		ret = -EINVAL;
> +		goto pri_unlock;
> +	}
> +
> +	if (pdev->is_virtfn && pf->pri_enabled)
> +		goto update_status;
> +
> +	/*
> +	 * Before updating PRI registers, make sure there is no
> +	 * outstanding PRI requests.
> +	 */
> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_STATUS, &status);
> +	if (!(status & PCI_PRI_STATUS_STOPPED)) {
> +		ret = -EBUSY;
> +		goto pri_unlock;
> +	}
>  
> -	pci_read_config_dword(pdev, pdev->pri_cap + PCI_PRI_MAX_REQ,
> -			      &max_requests);
> +	pci_read_config_dword(pf, pf->pri_cap + PCI_PRI_MAX_REQ, &max_requests);
>  	reqs = min(max_requests, reqs);
> -	pdev->pri_reqs_alloc = reqs;
> -	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
> +	pf->pri_reqs_alloc = reqs;
> +	pci_write_config_dword(pf, pf->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
>  
>  	control = PCI_PRI_CTRL_ENABLE;
> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
>  
> -	pdev->pri_enabled = 1;
> +	/*
> +	 * If PRI is not already enabled in PF, increment the PF
> +	 * pri_ref_cnt to track the usage of PRI interface.
> +	 */
> +	if (pdev->is_virtfn && !pf->pri_enabled) {
> +		atomic_inc(&pf->pri_ref_cnt);
> +		pf->pri_enabled = 1;
> +	}
>  
> -	return 0;
> +update_status:
> +	atomic_inc(&pf->pri_ref_cnt);
> +	pdev->pri_enabled = 1;
> +pri_unlock:
> +	mutex_unlock(&pf->pri_lock);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pri);
>  
> @@ -256,18 +286,30 @@ EXPORT_SYMBOL_GPL(pci_enable_pri);
>  void pci_disable_pri(struct pci_dev *pdev)
>  {
>  	u16 control;
> +	struct pci_dev *pf = pci_physfn(pdev);
>  
> -	if (WARN_ON(!pdev->pri_enabled))
> -		return;
> +	mutex_lock(&pf->pri_lock);
>  
> -	if (!pdev->pri_cap)
> -		return;
> +	if (WARN_ON(!pdev->pri_enabled) || !pf->pri_cap)
> +		goto pri_unlock;
> +
> +	atomic_dec(&pf->pri_ref_cnt);
>  
> -	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, &control);
> +	/*
> +	 * If pri_ref_cnt is not zero, then don't modify hardware
> +	 * registers.
> +	 */
> +	if (atomic_read(&pf->pri_ref_cnt))
> +		goto done;
> +
> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, &control);
>  	control &= ~PCI_PRI_CTRL_ENABLE;
> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
>  
> +done:
>  	pdev->pri_enabled = 0;
> +pri_unlock:
> +	mutex_unlock(&pf->pri_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_pri);
>  
> @@ -277,17 +319,31 @@ EXPORT_SYMBOL_GPL(pci_disable_pri);
>   */
>  void pci_restore_pri_state(struct pci_dev *pdev)
>  {
> -	u16 control = PCI_PRI_CTRL_ENABLE;
> -	u32 reqs = pdev->pri_reqs_alloc;
> +	u16 control;
> +	u32 reqs;
> +	struct pci_dev *pf = pci_physfn(pdev);
>  
>  	if (!pdev->pri_enabled)
>  		return;
>  
> -	if (!pdev->pri_cap)
> +	if (!pf->pri_cap)
>  		return;
>  
> -	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
> +	mutex_lock(&pf->pri_lock);
> +
> +	/* If PRI is already enabled by other VF's or PF, return */
> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, &control);
> +	if (control & PCI_PRI_CTRL_ENABLE)
> +		goto pri_unlock;
> +
> +	reqs = pf->pri_reqs_alloc;
> +	control = PCI_PRI_CTRL_ENABLE;
> +
> +	pci_write_config_dword(pf, pf->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
> +
> +pri_unlock:
> +	mutex_unlock(&pf->pri_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_restore_pri_state);
>  
> @@ -300,18 +356,32 @@ EXPORT_SYMBOL_GPL(pci_restore_pri_state);
>   */
>  int pci_reset_pri(struct pci_dev *pdev)
>  {
> +	struct pci_dev *pf = pci_physfn(pdev);
>  	u16 control;
> +	int ret = 0;
>  
> -	if (WARN_ON(pdev->pri_enabled))
> -		return -EBUSY;
> +	mutex_lock(&pf->pri_lock);
>  
> -	if (!pdev->pri_cap)
> -		return -EINVAL;
> +	if (WARN_ON(pdev->pri_enabled)) {
> +		ret = -EBUSY;
> +		goto done;
> +	}
> +
> +	if (!pf->pri_cap) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	/* If PRI is already enabled by other VF's or PF, return 0 */
> +	if (pf->pri_enabled)
> +		goto done;
>  
>  	control = PCI_PRI_CTRL_RESET;
> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
>  
> -	return 0;
> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
> +done:
> +	mutex_unlock(&pf->pri_lock);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_pri);
>  #endif /* CONFIG_PCI_PRI */
> @@ -475,11 +545,18 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
>  int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>  {
>  	u16 status;
> +	struct pci_dev *pf = pci_physfn(pdev);
> +
> +	mutex_lock(&pf->pri_lock);

I don't believe this lock is necessary.  What is it protecting?

We're only doing a single read of PCI_PRI_STATUS here, and with the
lock, we'll read it either before or after the critical sections in
pci_enable_pri(), pci_disable_pri(), pci_restore_pri_state(), and
pci_reset_pri().

And without the lock, we'll *also* read PCI_PRI_STATUS either before
or after anything in those functions that affects it.

> -	if (!pdev->pri_cap)
> +	if (!pf->pri_cap) {
> +		mutex_unlock(&pf->pri_lock);
>  		return 0;
> +	}
> +
> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_STATUS, &status);
>  
> -	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
> +	mutex_unlock(&pf->pri_lock);
>  
>  	if (status & PCI_PRI_STATUS_PASID)
>  		return 1;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 27224c0db849..3c9c4c82be27 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -455,8 +455,10 @@ struct pci_dev {
>  	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
>  #endif
>  #ifdef CONFIG_PCI_PRI
> +	struct mutex	pri_lock;	/* PRI enable lock */
>  	u16		pri_cap;	/* PRI Capability offset */
>  	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
> +	atomic_t	pri_ref_cnt;	/* Number of PF/VF PRI users */
>  #endif
>  #ifdef CONFIG_PCI_PASID
>  	u16		pasid_cap;	/* PASID Capability offset */
> -- 
> 2.21.0
> 
