Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5070FC03
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjEXQzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEXQzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 12:55:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D6E9;
        Wed, 24 May 2023 09:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7523563F5B;
        Wed, 24 May 2023 16:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95706C433D2;
        Wed, 24 May 2023 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684947319;
        bh=i/ViLVESTquMbf7XVtp4F0icq/QV6S+BFeqm22e+61U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EZn4dBLJYKJzDw7GesfFrqT4utUECzX6nO7T3TpfZcHs1CQvoJf5MeVErPxNNaqak
         XsZijdRDLtayXV9sdJVnqXjT1ZV9MZZtjnt2JqHfZae4vxCshvlZ5umB8dP0xC7XZh
         beUap4J8hQlOB4ctvDUXAQeo7ZW0HRT0aymipgZYe+KN2G+hA1VVtE90rgIvu3kxSD
         aQ8ox4tcKRTtVtwTdLalwbp5c4D561p5yeYETflhbfaF5WKEdqwuMaW6rWq0DRIrhS
         PZQGYjl/waU/OBP9UwZkNd7JuGxti7O1YDcJqDGqvhlDB9QH9kmZ9BQbw9G2u6/HZ9
         KhPh3uCe2p1Kg==
Date:   Wed, 24 May 2023 11:55:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 18/23] PCI/AER: Refactor cper_print_aer() for use by
 CXL driver module
Message-ID: <ZG5BdvAP1OuQVTWz@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523232214.55282-19-terry.bowman@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23, 2023 at 06:22:09PM -0500, Terry Bowman wrote:
> The CXL driver plans to use cper_print_aer() for logging restricted CXL
> host (RCH) AER errors. cper_print_aer() is not currently exported and
> therefore not usable by the CXL driver built as a loadable module. Export
> the cper_print_aer() function making it available.
> 
> The CONFIG_ACPI_APEI_PCIEAER kernel config is currently used to enable
> cper_print_aer(). cper_print_aer() logs the AER registers and is
> useful in PCIE AER logging outside of APEI. Remove the
> CONFIG_ACPI_APEI_PCIEAER dependency to enable cper_print_aer().
> 
> The cper_print_aer() function name implies CPER specific use but is useful
> in non-CPER cases as well. Rename cper_print_aer() to pci_print_aer().
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/aer.c | 9 +++++----
>  include/linux/aer.h    | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..d3344fcf1f79 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -771,9 +771,10 @@ int cper_severity_to_aer(int cper_severity)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(cper_severity_to_aer);
> +#endif
>  
> -void cper_print_aer(struct pci_dev *dev, int aer_severity,
> -		    struct aer_capability_regs *aer)
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer)
>  {
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
> @@ -812,7 +813,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
> -#endif
> +EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
>  
>  /**
>   * add_error_device - list device to be handled
> @@ -1009,7 +1010,7 @@ static void aer_recover_work_func(struct work_struct *work)
>  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>  			continue;
>  		}
> -		cper_print_aer(pdev, entry.severity, entry.regs);
> +		pci_print_aer(pdev, entry.severity, entry.regs);
>  		if (entry.severity == AER_NONFATAL)
>  			pcie_do_recovery(pdev, pci_channel_io_normal,
>  					 aer_root_reset);
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 97f64ba1b34a..8f124b904314 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -64,7 +64,7 @@ static inline void pci_save_aer_state(struct pci_dev *dev) {}
>  static inline void pci_restore_aer_state(struct pci_dev *dev) {}
>  #endif
>  
> -void cper_print_aer(struct pci_dev *dev, int aer_severity,
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
> -- 
> 2.34.1
> 
