Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F975A00A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 22:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGSUkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGSUkM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 16:40:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFED1734;
        Wed, 19 Jul 2023 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689799210; x=1721335210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GWyUhw9RLRjcwXrBBTCj4jRGSRu1evn0GbeImxsRUZs=;
  b=SJErFRw9sxPwro8VJDL7aar1zVz8t6jRMQuoUnWYjr9WX8BBU9iEMrzT
   IPcQ0+dWUmmHL7ijWEtUxysoTGkvH9bBnqKp2rompIVaj2W4YjjzAd8LK
   RGxnjFLlWq1ErhdR/Di/xY9B59bpxCbcA/z/2h2OifXqQnsdfIQrzxB3r
   S6tS2szdqGETenzNOfH3RkhthPVLUCZ8wTl8EDmMt0SwFmQz1gWJraGaY
   Z7VKtQqQNXCOxPneCzdD4mxJxcnLiTe5CvmZwnbItwdgZ4r2/8Y73BQYN
   ZUMDP3Rh/bOwRAbJquOhCwPmxfNLc2CSHJORngnZzTshuWI7FLJtJJ3fu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346869416"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346869416"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848172367"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="848172367"
Received: from vijayakr-mobl2.amr.corp.intel.com (HELO [10.212.182.233]) ([10.212.182.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:40:09 -0700
Message-ID: <2ce67c27-ae0e-e40e-4f43-d8e5be13e993@linux.intel.com>
Date:   Wed, 19 Jul 2023 13:40:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] PCI, AER: Export and make pcie_aer_is_native() global
Content-Language: en-US
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230719192313.38591-2-Smita.KoralahalliChannabasappa@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230719192313.38591-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/19/23 12:23 PM, Smita Koralahalli wrote:
> Export and move the declaration of pcie_aer_is_native() to a common header
> file to be reused by cxl/pci module.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>  drivers/pci/pcie/aer.c     | 1 +
>  drivers/pci/pcie/portdrv.h | 2 --
>  include/linux/aer.h        | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..87d90dbda023 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  
>  	return pcie_ports_native || host->native_aer;
>  }
> +EXPORT_SYMBOL_GPL(pcie_aer_is_native);
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 58a2b1a1cae4..1f3803bde7ee 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -29,10 +29,8 @@ extern bool pcie_ports_dpc_native;
>  
>  #ifdef CONFIG_PCIEAER
>  int pcie_aer_init(void);
> -int pcie_aer_is_native(struct pci_dev *dev);
>  #else
>  static inline int pcie_aer_init(void) { return 0; }
> -static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
>  #ifdef CONFIG_HOTPLUG_PCI_PCIE
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 3a3ab05e13fd..94ce49a5f8d5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -45,6 +45,7 @@ struct aer_capability_regs {
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +int pcie_aer_is_native(struct pci_dev *dev);
>  #else
>  static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> @@ -58,6 +59,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
>  void cper_print_aer(struct pci_dev *dev, int aer_severity,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
