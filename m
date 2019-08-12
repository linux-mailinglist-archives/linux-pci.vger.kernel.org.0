Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD508A7CF
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHLUEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbfHLUEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:04:47 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8429C214C6;
        Mon, 12 Aug 2019 20:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640285;
        bh=hi0AGVTGOhaYjGDvBSEk0edWVIq4cQFWYQPGIF/eVjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJiCfDpAQyutGFw1hvDU/2Xum6CNPgOserg1T12jeHI+usXi3K6g8isKO0B79J0nM
         75hEvP6a7KIhiCMNycNK60ZRtA7fH9DWto1PMVBRsC3C+52SbpYEGWrTuC+LTmeTpV
         jKz/sMBMN51ocoxPgdE+SsjlF0UAymMO84cYve1A=
Date:   Mon, 12 Aug 2019 15:04:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 3/7] PCI/ATS: Initialize PASID in pci_ats_init()
Message-ID: <20190812181120.GA11785@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5edb0209f7657e0706d4e5305ea0087873603daf.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edb0209f7657e0706d4e5305ea0087873603daf.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 05:06:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently, PASID Capability checks are repeated across all PASID API's.
> Instead, cache the capability check result in pci_pasid_init() and use
> it in other PASID API's. Also, since PASID is a shared resource between
> PF/VF, initialize PASID features with default values in pci_pasid_init().

Split into two patches as for PRI.

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c       | 74 +++++++++++++++++++++++++++++------------
>  include/linux/pci-ats.h |  5 +++
>  include/linux/pci.h     |  1 +
>  3 files changed, 59 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 280be911f190..1f4be27a071d 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -30,6 +30,8 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  
>  	pci_pri_init(dev);
> +

Superfluous blank line; you can remove it.

> +	pci_pasid_init(dev);
>  }
>  
>  /**
> @@ -315,6 +317,40 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
>  #endif /* CONFIG_PCI_PRI */
>  
>  #ifdef CONFIG_PCI_PASID
> +
> +void pci_pasid_init(struct pci_dev *pdev)
> +{
> +	u16 supported;
> +	int pos;
> +
> +	/*
> +	 * As per PCIe r4.0, sec 9.3.7.14, only PF is permitted to
> +	 * implement PASID Capability and all associated VFs can
> +	 * only use it. Since PF already initialized the PASID
> +	 * parameters there is no need to proceed further.
> +	 */
> +	if (pdev->is_virtfn)
> +		return;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
> +
> +	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
> +
> +	/*
> +	 * Enable all supported features. Since PASID is a shared
> +	 * resource between PF/VF, we must not set this feature as
> +	 * a per device property in pci_enable_pasid().

But pci_enable_pasid() *does* set PCI_PASID_CTRL.  Either the comments
or the code needs to be updated.

> +	 */
> +	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, supported);
> +
> +	pdev->pasid_features = supported;
> +	pdev->pasid_cap = pos;
> +}
> +
>  /**
>   * pci_enable_pasid - Enable the PASID capability
>   * @pdev: PCI device structure
> @@ -323,11 +359,13 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
>   * Returns 0 on success, negative value on error. This function checks
>   * whether the features are actually supported by the device and returns
>   * an error if not.
> + *
> + * TODO: Since PASID is a shared resource between PF/VF, don't update
> + * PASID features in the same API as a per device feature.
>   */
>  int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	u16 control, supported;
> -	int pos;
>  
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
> @@ -335,11 +373,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (!pdev->eetlp_prefix_path)
>  		return -EINVAL;
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -	if (!pos)
> +	if (!pdev->pasid_cap)
>  		return -EINVAL;
>  
> -	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
> +	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> +			     &supported);
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
>  	/* User wants to enable anything unsupported? */
> @@ -349,7 +387,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	control = PCI_PASID_CTRL_ENABLE | features;
>  	pdev->pasid_features = features;
>  
> -	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
> +	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
>  
>  	pdev->pasid_enabled = 1;
>  
> @@ -364,16 +402,14 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
>  void pci_disable_pasid(struct pci_dev *pdev)
>  {
>  	u16 control = 0;
> -	int pos;
>  
>  	if (WARN_ON(!pdev->pasid_enabled))
>  		return;
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -	if (!pos)
> +	if (!pdev->pasid_cap)
>  		return;
>  
> -	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
> +	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
>  
>  	pdev->pasid_enabled = 0;
>  }
> @@ -386,17 +422,15 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
>  void pci_restore_pasid_state(struct pci_dev *pdev)
>  {
>  	u16 control;
> -	int pos;
>  
>  	if (!pdev->pasid_enabled)
>  		return;
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -	if (!pos)
> +	if (!pdev->pasid_cap)
>  		return;
>  
>  	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
> -	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
> +	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
>  }
>  EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
>  
> @@ -413,13 +447,12 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
>  int pci_pasid_features(struct pci_dev *pdev)
>  {
>  	u16 supported;
> -	int pos;
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -	if (!pos)
> +	if (!pdev->pasid_cap)
>  		return -EINVAL;
>  
> -	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
> +	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> +			     &supported);
>  
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
> @@ -469,13 +502,12 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>  int pci_max_pasids(struct pci_dev *pdev)
>  {
>  	u16 supported;
> -	int pos;
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -	if (!pos)
> +	if (!pdev->pasid_cap)
>  		return -EINVAL;
>  
> -	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
> +	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> +			     &supported);
>  
>  	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
>  
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 33653d4ca94f..bc7f815d38ff 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -40,6 +40,7 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
>  
>  #ifdef CONFIG_PCI_PASID
>  
> +void pci_pasid_init(struct pci_dev *pdev);

Move to drivers/pci/pci.h.

>  int pci_enable_pasid(struct pci_dev *pdev, int features);
>  void pci_disable_pasid(struct pci_dev *pdev);
>  void pci_restore_pasid_state(struct pci_dev *pdev);
> @@ -48,6 +49,10 @@ int pci_max_pasids(struct pci_dev *pdev);
>  
>  #else  /* CONFIG_PCI_PASID */
>  
> +static inline void pci_pasid_init(struct pci_dev *pdev)
> +{
> +}
> +
>  static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	return -EINVAL;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 56b55db099fc..27224c0db849 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -459,6 +459,7 @@ struct pci_dev {
>  	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
>  #endif
>  #ifdef CONFIG_PCI_PASID
> +	u16		pasid_cap;	/* PASID Capability offset */
>  	u16		pasid_features;
>  #endif
>  #ifdef CONFIG_PCI_P2PDMA
> -- 
> 2.21.0
> 
