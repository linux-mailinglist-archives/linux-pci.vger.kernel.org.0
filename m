Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765EB178727
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 01:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCDArI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 19:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgCDArI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 19:47:08 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C2F206E2;
        Wed,  4 Mar 2020 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583282827;
        bh=diuJPD0msX5YpFoYb6xNzZ7AYZRY8vVbqZwfzwXJlmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=evur9zd6hr9qaJH2hXyDD2IYqzy2nR2150ZKP5xifGjPwkD+UeQtfMih1gyGIynHB
         qjfsKbtfvL32MFQCpAdIOGlQnCUyeERY1pCyEDuFe81Uga4e97i7VKf0yFCC2jCSwy
         GWfNHlipv0RIw/1Fps0rwsjwhUqPG8ZESW2Iua4w=
Date:   Tue, 3 Mar 2020 18:47:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v16 5/9] PCI/DPC: Cache DPC capabilities in
 pci_init_capabilities()
Message-ID: <20200304004705.GA184443@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a634b6c6012773e9e668c2110e13a5bd196bb8.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 27, 2020 at 04:59:47PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Since we need to re-use DPC error handling routines in Error Disconnect
> Recover (EDR) driver, move the initalization and caching of DPC
> capabilities to pci_init_capabilities().
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/dpc.c | 32 ++++++++++++++++++++------------
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c2c35f152cde..e57e78b619f8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -448,9 +448,11 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  #ifdef CONFIG_PCIE_DPC
>  void pci_save_dpc_state(struct pci_dev *dev);
>  void pci_restore_dpc_state(struct pci_dev *dev);
> +void pci_dpc_init(struct pci_dev *pdev);
>  #else
>  static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
> +static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 114358d62ddf..57e7f94b98cf 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -249,6 +249,26 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
>  
> +void pci_dpc_init(struct pci_dev *pdev)
> +{

I think you forgot to call this?

> +	u16 cap;
> +
> +	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
> +	if (!pdev->dpc_cap)
> +		return;
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
> +	pdev->dpc_rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT) ? 1 : 0;
> +	if (pdev->dpc_rp_extensions) {
> +		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> +		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> +			pci_err(pdev, "RP PIO log size %u is invalid\n",
> +				pdev->dpc_rp_log_size);
> +			pdev->dpc_rp_log_size = 0;
> +		}
> +	}
> +}
> +
>  #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
>  static int dpc_probe(struct pcie_device *dev)
>  {
> @@ -260,8 +280,6 @@ static int dpc_probe(struct pcie_device *dev)
>  	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
>  		return -ENOTSUPP;
>  
> -	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
> -
>  	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>  					   dpc_handler, IRQF_SHARED,
>  					   "pcie-dpc", pdev);
> @@ -274,16 +292,6 @@ static int dpc_probe(struct pcie_device *dev)
>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>  
> -	pdev->dpc_rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT) ? 1 : 0;
> -	if (pdev->dpc_rp_extensions) {
> -		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> -		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> -			pci_err(pdev, "RP PIO log size %u is invalid\n",
> -				pdev->dpc_rp_log_size);
> -			pdev->dpc_rp_log_size = 0;
> -		}
> -	}
> -
>  	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>  
> -- 
> 2.21.0
> 
