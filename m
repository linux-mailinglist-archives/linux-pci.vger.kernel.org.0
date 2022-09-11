Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC35B5003
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIKQWa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIKQWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 12:22:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F62F2C11B;
        Sun, 11 Sep 2022 09:22:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so11122587lfr.2;
        Sun, 11 Sep 2022 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=EgY+Z705O4suJvukCCPtWA2N+D2XlhHDKIYahAzgXfE=;
        b=BmmZ4SgQ+gV1m+2oov3uezzE/Yh01aFABXA00Sc09aQ9MRBqC1nuZx69ZRs0BRXqIl
         43YzltavWtiqZkGJ/G+wiOegrxTCd1DrkXAeUVXjkmiC4QWtL9k/flVcKxjdGHoZ1SHg
         ARzBXq5J4bxLfDgO3Sk8yAnEL3qRDJV/wqsDjHoWB0pe4sbxkIPkzN3+H9wIcqnnbCLV
         ncvI0u8pyYwI4ZcQGIE+JqWxN0NZMnAYDOQLOjQ4lR39MWTZLtltiHGe552QddeGBv0H
         42LbF3yB5glV94Lo7BXocQUh9GWzMji79PssLyF5fS0P02Jlei7x09G5xyP90w9RGLWd
         NkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EgY+Z705O4suJvukCCPtWA2N+D2XlhHDKIYahAzgXfE=;
        b=kQU2nYCOS0H2VpygbGu8Q5JAWYVLzufGCYXrXzk6L2yRSI80nc0eQTW1HWhDxUJxJp
         c5fRXk4XverkMR6pslvA3Yt/kmB6dqgUu1YgT+mtxB2/EX3QR78TIrms5L3agYwQ8HVG
         a2a3yv5nw9+tPSMUCAvukuBHEY3jfF3A7Qkn2up5hcYQwLADPxydkUt11pQR6Twp2+S4
         YjC2jRzLlTB+HDQ+1CVHxfPP51QliUv6vPUzjQ9a56VmO0MHRxBbZTppgaRjdyFBiwNe
         30sD7dFPJpBqI8N6mP25xef0zavRkd1s2dObZ7J8RExpoGCcN/g5fIjPT4q+zkrOEnbS
         1emg==
X-Gm-Message-State: ACgBeo1sRBUwlfZUTwKvJfzYd9b0SLb4oD4qZJDKIomWiHfDpBAiiJra
        4uR6Nxn2lQu28+bZYk3Z6vM=
X-Google-Smtp-Source: AA6agR41IBbwg862n94+M1v0MnrA/lqbcoKZkX380EdYgwZuiDZV0EqtblRup3Un9z+1cTbUjTvavA==
X-Received: by 2002:a05:6512:239c:b0:497:938e:2c99 with SMTP id c28-20020a056512239c00b00497938e2c99mr7361403lfv.416.1662913329699;
        Sun, 11 Sep 2022 09:22:09 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id o10-20020ac24e8a000000b00492ddaaac29sm653958lfr.205.2022.09.11.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:22:09 -0700 (PDT)
Date:   Sun, 11 Sep 2022 19:22:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/AER: Use pci_aer_clear_uncorrect_error_status()
 to clear uncorrectable error status
Message-ID: <20220911162206.5f2uctuotuddqpre@mobilestation>
References: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
 <20220901181634.99591-2-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901181634.99591-2-chenzhuo.1@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zhuo

On Fri, Sep 02, 2022 at 02:16:32AM +0800, Zhuo Chen wrote:
> Status bits for ERR_NONFATAL errors only are cleared in
> pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
> error status in ntb_hw_idt.c and lpfc_attr.c. So we add
> pci_aer_clear_uncorrect_error_status() and change to use it.

What about the next drivers

drivers/scsi/lpfc/lpfc_attr.c
drivers/crypto/hisilicon/qm.c
drivers/net/ethernet/intel/ice/ice_main.c

which call the pci_aer_clear_nonfatal_status() method too?

> 
> Use pci_aer_clear_nonfatal_status() in dpc_process_error(), which has
> no functional changes.
> 
> Since pci_aer_clear_nonfatal_status() is used only internally, move
> its declaration to the PCI internal header file. Also, no one cares
> about return value of pci_aer_clear_nonfatal_status(), so make it void.
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c |  4 ++--
>  drivers/pci/pci.h               |  2 ++
>  drivers/pci/pcie/aer.c          | 23 ++++++++++++++++++-----
>  drivers/pci/pcie/dpc.c          |  3 +--
>  drivers/scsi/lpfc/lpfc_attr.c   |  4 ++--
>  include/linux/aer.h             |  4 ++--
>  6 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 733557231ed0..de1dbbc5b9de 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	ret = pci_enable_pcie_error_reporting(pdev);
>  	if (ret != 0)
>  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");

> -	else /* Cleanup nonfatal error status before getting to init */
> -		pci_aer_clear_nonfatal_status(pdev);
> +	else /* Cleanup uncorrectable error status before getting to init */
> +		pci_aer_clear_uncorrect_error_status(pdev);

From the IDT NTB PCIe initialization procedure point of view both of
these methods are equivalent. So for the IDT NTB part:

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e10cdec6c56e..574176f43025 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -686,6 +686,7 @@ void pci_aer_init(struct pci_dev *dev);
>  void pci_aer_exit(struct pci_dev *dev);
>  extern const struct attribute_group aer_stats_attr_group;
>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
> +void pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pci_aer_clear_status(struct pci_dev *dev);
>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>  #else
> @@ -693,6 +694,7 @@ static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> +static inline void pci_aer_clear_nonfatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  #endif
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7952e5efd6cf..d2996afa80f6 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -251,13 +251,13 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>  
> -int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> +void pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 status, sev;
>  
>  	if (!pcie_aer_is_native(dev))
> -		return -EIO;
> +		return;
>  
>  	/* Clear status bits for ERR_NONFATAL errors only */
>  	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> @@ -265,10 +265,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  	status &= ~sev;
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> -
> -	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
>  
>  void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  {
> @@ -286,6 +283,22 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
>  
> +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 status;
> +
> +	if (!pcie_aer_is_native(dev))
> +		return -EIO;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> +	if (status)
> +		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
> +
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
>   * @dev: the PCI device
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3e9afee02e8d..7942073fbb34 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
>  		aer_print_error(pdev, &info);
> -		pci_aer_clear_nonfatal_status(pdev);
> -		pci_aer_clear_fatal_status(pdev);
> +		pci_aer_clear_uncorrect_error_status(pdev);
>  	}
>  }
>  
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 3caaa7c4af48..1ed8d1640325 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -4712,7 +4712,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
>   * Description:
>   * If the @buf contains 1 and the device currently has the AER support
>   * enabled, then invokes the kernel AER helper routine
> - * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
> + * pci_aer_clear_uncorrect_error_status() to clean up the uncorrectable
>   * error status register.
>   *
>   * Notes:
> @@ -4738,7 +4738,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	if (phba->hba_flag & HBA_AER_ENABLED)
> -		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
> +		rc = pci_aer_clear_uncorrect_error_status(phba->pcidev);
>  
>  	if (rc == 0)
>  		return strlen(buf);
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 97f64ba1b34a..f638ad955deb 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -44,7 +44,7 @@ struct aer_capability_regs {
>  /* PCIe port driver needs this function to enable AER */
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> -int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
>  void pci_save_aer_state(struct pci_dev *dev);
>  void pci_restore_aer_state(struct pci_dev *dev);
>  #else
> @@ -56,7 +56,7 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> -static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> +static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> -- 
> 2.30.1 (Apple Git-130)
> 
