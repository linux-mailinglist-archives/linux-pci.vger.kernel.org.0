Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5971C72A6AF
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 01:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjFIX0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 19:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjFIX0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 19:26:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F38830E5
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686353198; x=1717889198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kqx56AXAe8keTxivAyKt/JyMWeH5yvXcotP8xCOyL24=;
  b=g24bcTU0M+7rTQNyoA0c73DeCRAJvTBhpv1CIqvPrWqjWBoJMs7ZWNO2
   pP3LNlpDW9tCNA/OEtCFkwg90BmymK1fy8rVOVtlxQ1qHLO0opLSNpTLL
   RpCh7CbKexbHPS+boVzvZQ5hjvhuhtXTrSbUP5N8IADzYc0t5uVYunZVs
   7ELJmXq8LNDzV3bi7zqtq8ycXamZVCkNtp6pxqkx8DfCF6fecTSDaB6/Y
   X8deE12uzFN55cmHoEh4fOZzw2Eyvs6U+0OGfJeUyOFkzAbNfObccYtKa
   UvjLFGcDLwh6WzpMwS/UlScBB1aoYc53SDbJ7eedv5Gbs8Sf0NRM2jw7i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342382049"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="342382049"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="780476886"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="780476886"
Received: from morganhu-mobl.amr.corp.intel.com (HELO [10.212.133.89]) ([10.212.133.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:26:37 -0700
Message-ID: <fff1fef4-b87b-03bc-5d6d-f40d38ba6454@linux.intel.com>
Date:   Fri, 9 Jun 2023 16:26:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] PCI: Unexport pci_save_aer_state()
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230609222500.1267795-1-helgaas@kernel.org>
 <20230609222500.1267795-2-helgaas@kernel.org>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230609222500.1267795-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/9/23 3:24 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_save_aer_state() and pci_restore_aer_state() are only used in
> drivers/pci, so don't expose them to the rest of the kernel.  No functional
> change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pci.h   | 4 ++++
>  include/linux/aer.h | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2475098f6518..a97a735e6623 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -686,6 +686,8 @@ extern const struct attribute_group aer_stats_attr_group;
>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pci_aer_clear_status(struct pci_dev *dev);
>  int pci_aer_raw_clear_status(struct pci_dev *dev);
> +void pci_save_aer_state(struct pci_dev *dev);
> +void pci_restore_aer_state(struct pci_dev *dev);
>  #else
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
> @@ -693,6 +695,8 @@ static inline void pci_aer_exit(struct pci_dev *d) { }
>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
> +static inline void pci_save_aer_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>  #endif
>  
>  #ifdef CONFIG_ACPI
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 97f64ba1b34a..3a3ab05e13fd 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -45,8 +45,6 @@ struct aer_capability_regs {
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> -void pci_save_aer_state(struct pci_dev *dev);
> -void pci_restore_aer_state(struct pci_dev *dev);
>  #else
>  static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> @@ -60,8 +58,6 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> -static inline void pci_save_aer_state(struct pci_dev *dev) {}
> -static inline void pci_restore_aer_state(struct pci_dev *dev) {}
>  #endif
>  
>  void cper_print_aer(struct pci_dev *dev, int aer_severity,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
