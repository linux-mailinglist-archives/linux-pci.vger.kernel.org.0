Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F25141482
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAQW4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 17:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgAQW4H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 17:56:07 -0500
Received: from localhost (187.sub-174-234-133.myvzw.com [174.234.133.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E92621D56;
        Fri, 17 Jan 2020 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579301766;
        bh=CWecaCz+3cpDlm8YlyE4B6sbx15L8F/2ceqDO53Fg1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t3ZC+R9U23lctpqQnFRlaO5o65vDhMZwIr4BKiUhIv5o631gRwJ5iOwYFd2oHFY/I
         0aw1vBg9S+uJ+VGIRotIeoTmwZvTZNEi9aXJpRMfaGUM/zJdGmzfzfFyVpT5SlvgXz
         EkDotAfE4RPlBpwHpnmrJWZoybA9JN4Xp1Lla6u4=
Date:   Fri, 17 Jan 2020 16:56:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v12 5/8] PCI/AER: Allow clearing Error Status Register in
 FF mode
Message-ID: <20200117220902.GA139245@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4fa9c6253fd2bfc49746f98e4024fb4980c8936.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 12, 2020 at 02:43:59PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 System Firmware Intermediary
> (SFI) _OSC and DPC Updates ECR
> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled
> "DPC Event Handling Implementation Note", page 10, Error Disconnect
> Recover (EDR) support allows OS to handle error recovery and clearing
> Error Registers even in FF mode. So create exception for FF mode checks
> in pci_cleanup_aer_uncorrect_error_status(), pci_aer_clear_fatal_status()
> and pci_cleanup_aer_error_status_regs() functions when its being called
> from DPC code path.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/PCI/pcieaer-howto.rst       |  2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
>  drivers/ntb/hw/idt/ntb_hw_idt.c           |  2 +-
>  drivers/pci/pci.c                         |  2 +-
>  drivers/pci/pci.h                         |  2 +-
>  drivers/pci/pcie/aer.c                    | 16 ++++++++--------
>  drivers/pci/pcie/dpc.c                    |  4 ++--
>  drivers/pci/pcie/err.c                    |  2 +-
>  drivers/scsi/lpfc/lpfc_attr.c             |  2 +-
>  include/linux/aer.h                       | 12 ++++++++----
>  10 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 18bdefaafd1a..184c966b61cb 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -243,7 +243,7 @@ messages to root port when an error is detected.
>  
>  ::
>  
> -  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
> +  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev, bool ff_check);
>  
>  pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
>  error status register.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 69bff085acf7..8378dbf3500b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3491,7 +3491,7 @@ static pci_ers_result_t ice_pci_err_slot_reset(struct pci_dev *pdev)
>  			result = PCI_ERS_RESULT_DISCONNECT;
>  	}
>  
> -	err = pci_cleanup_aer_uncorrect_error_status(pdev);
> +	err = pci_cleanup_aer_uncorrect_error_status(pdev, 1);
>  	if (err)
>  		dev_dbg(&pdev->dev,
>  			"pci_cleanup_aer_uncorrect_error_status failed, error %d\n",
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index dcf234680535..9023308be2de 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2675,7 +2675,7 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	if (ret != 0)
>  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
>  	else /* Cleanup uncorrectable error status before getting to init */
> -		pci_cleanup_aer_uncorrect_error_status(pdev);
> +		pci_cleanup_aer_uncorrect_error_status(pdev, 1);
>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);

> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 63366344acff..5bd72d9343f6 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -280,8 +280,8 @@ static void dpc_process_error(struct dpc_dev *dpc)
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
>  		aer_print_error(pdev, &info);
> -		pci_cleanup_aer_uncorrect_error_status(pdev);
> -		pci_aer_clear_fatal_status(pdev);
> +		pci_cleanup_aer_uncorrect_error_status(pdev, 0);
> +		pci_aer_clear_fatal_status(pdev, 0);
>  	}
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */

> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 4ff82b36a37a..5b37efd29e20 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -4810,7 +4810,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	if (phba->hba_flag & HBA_AER_ENABLED)
> -		rc = pci_cleanup_aer_uncorrect_error_status(phba->pcidev);
> +		rc = pci_cleanup_aer_uncorrect_error_status(phba->pcidev, 1);
>  
>  	if (rc == 0)
>  		return strlen(buf);
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index fa19e01f418a..f4f49df500ad 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -44,8 +44,10 @@ struct aer_capability_regs {
>  /* PCIe port driver needs this function to enable AER */
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> -int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
> -int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
> +int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev,
> +					   bool ff_check);

IIUC your intent is that drivers should only call this with
ff_check=1, and only the single case in dpc.c should call it with
ff_check=0.  But the existence of that parameter creates an
opportunity for drivers to do it wrong.

The "ff_check==0" case needs to be internal to drivers/pci and not
even visible to drivers.  E.g., you can leave the interface of
pci_cleanup_aer_uncorrect_error_status() alone and make it call
internal-to-PCI function.

There should be no changes to drivers or the documentation.

> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev,
> +				      bool ff_check);

Same for this.

pci_cleanup_aer_error_status_regs() is only used inside drivers/pci
anyway, so should probably be moved out of linux/aer.h.

>  void pci_save_aer_state(struct pci_dev *dev);
>  void pci_restore_aer_state(struct pci_dev *dev);
>  #else
> @@ -57,11 +59,13 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> -static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
> +static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev,
> +							 bool ff_check)
>  {
>  	return -EINVAL;
>  }
> -static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> +static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev,
> +						    bool ff_check)
>  {
>  	return -EINVAL;
>  }
> -- 
> 2.21.0
> 
