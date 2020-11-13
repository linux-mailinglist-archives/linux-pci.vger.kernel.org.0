Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F682B287F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 23:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKMWXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 17:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKMWXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 17:23:42 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1568207DE;
        Fri, 13 Nov 2020 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605306221;
        bh=GTuPcqEWVM+VGI2FMkFJFWknqieSxgBdfJx/huPl714=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L9yhbjdstA2Y7+3ZeEDEsD9GjOfKd+YBOAqAQoYcnQYdDy9Bj3ETKsd0z4dh4uXyF
         XcPXq47j39zuMAUg/64vMz4FnE63VM8/+mz1832k9E7s1MwLLJ/2XRICWkUkk/RuUy
         qrj9/eZADLxzhLQA7F+AKMgKEzPkL5yKXL8flDtY=
Date:   Fri, 13 Nov 2020 16:23:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, lorenzo.pieralisi@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI/ASPM: Save/restore ASPM-L1SS controls for
 suspend/resume
Message-ID: <20201113222339.GA1138933@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024190442.871-1-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 25, 2020 at 12:34:42AM +0530, Vidya Sagar wrote:
> Previously ASPM L1-Sub-States control registers (CTL1 and CTL2) weren't
> saved and restored during suspend/resume leading to ASPM-L1SS
> configuration being lost post resume.
> 
> Save the ASPM-L1SS control registers so that the configuration is retained
> post resume.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Applied to pci/aspm for v5.11, thanks!

I tidied up pci_restore_aspm_l1ss_state() so it does the checking the
same way as pci_save_aspm_l1ss_state().

> ---
> v1:
> * It would be really good if someone can verify it on a non tegra194 platform
> 
>  drivers/pci/pci.c       |  7 +++++++
>  drivers/pci/pci.h       |  4 ++++
>  drivers/pci/pcie/aspm.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a458c46d7e39..034497264bde 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1551,6 +1551,7 @@ int pci_save_state(struct pci_dev *dev)
>  		return i;
>  
>  	pci_save_ltr_state(dev);
> +	pci_save_aspm_l1ss_state(dev);
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
>  	return pci_save_vc_state(dev);
> @@ -1656,6 +1657,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	 * LTR itself (in the PCIe capability).
>  	 */
>  	pci_restore_ltr_state(dev);
> +	pci_restore_aspm_l1ss_state(dev);
>  
>  	pci_restore_pcie_state(dev);
>  	pci_restore_pasid_state(dev);
> @@ -3319,6 +3321,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>  	if (error)
>  		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>  
> +	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> +					    2 * sizeof(u32));
> +	if (error)
> +		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> +
>  	pci_allocate_vc_save_buffers(dev);
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..8d2135f61e36 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -565,11 +565,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>  #endif
>  
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..d965bbc563ed 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -742,6 +742,47 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  				PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>  
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int aspm_l1ss;
> +	u32 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!aspm_l1ss)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> +	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> +}
> +
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int aspm_l1ss;
> +	u32 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state || !aspm_l1ss)
> +		return;
> +
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +}
> +
>  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  {
>  	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> -- 
> 2.17.1
> 
