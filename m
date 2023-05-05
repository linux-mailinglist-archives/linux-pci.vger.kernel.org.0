Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6166F7B3B
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 04:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEECvj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 22:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEECvi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 22:51:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153612094;
        Thu,  4 May 2023 19:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683255097; x=1714791097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SDFdhdekvxyYCofffHMf6rRfIuAVFmPIluPrsnQHPEE=;
  b=BykX//U80LZ0972eWKBejUvbB9+JObcK4lBuhH5tXHQXxUNNnucnhvb1
   f7h1oWHk0NeBO/7OzGA8x4GGYDjqNfG7Vje3n3CpPO7ZwFlSGsbiw2UCS
   DOsakabxPmnj7utBwcUvkM9rKRkT/tZd7ix7+dt1z6KDrgPfqvn4j09qV
   qSi7nxoFPcib+MgMq5C46dkxlANtUZnuZp19PjR1ss+ahqqv6mhgZdrIN
   U+0RbKdOOFN67AQvxQnc24DFXx+k2DVHjK2DqhQX92+2X3UHxt30pN4NJ
   xGEHCZH+eqYQnRh6bYVK4XIsKYa81/JXzq4kMbtgn/7dqJ7uVqqIKxto7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="347934038"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="347934038"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 19:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="841484488"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="841484488"
Received: from syusufpa-mobl.gar.corp.intel.com (HELO [10.209.115.128]) ([10.209.115.128])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 19:51:36 -0700
Message-ID: <2f32591a-77d8-f620-46bf-825074ba24c2@linux.intel.com>
Date:   Thu, 4 May 2023 19:51:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] PCI/ASPM: fix UAF by disable ASPM for link when child
 function is removed
To:     Ding Hui <dinghui@sangfor.com.cn>, bhelgaas@google.com
Cc:     vidyas@nvidia.com, david.e.box@linux.intel.com,
        kai.heng.feng@canonical.com, michael.a.bottini@linux.intel.com,
        rajatja@google.com, qinzongquan@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230504123418.4438-1-dinghui@sangfor.com.cn>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230504123418.4438-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/4/23 5:34 AM, Ding Hui wrote:

Maybe you can use the following title?

"PCI/ASPM: Fix UAF by disabling ASPM for link when child function is removed

> If the Function 0 of a Multi-Function device is software removed,
> a freed downstream pointer will be left in struct pcie_link_state,
> and then when pcie_config_aspm_link() be invoked from any path,
> we will trigger use-after-free.
> 
> Based on the PCIe spec about ASPM Control (PCIe r6.0, sec 7.5.3.7),

As per PCIe spec r6.0, sec 7.5.3.7, it is recommended

> for Multi-Function Devices (including ARI Devices), it is recommended
> that software program the same value in all Functions. For ARI
> Devices, ASPM Control is determined solely by the setting in Function 0.
> 
> So we can just disable ASPM of the whole component if any child
> function is removed, the downstream pointer will be avoided from
> use-after-free, that will also avoid other potential corner cases.
> 
> Fixes: b5a0a9b59c81 ("PCI/ASPM: Read and set up L1 substate capabilities")
> Debugged-by: Zongquan Qin <qinzongquan@sangfor.com.cn>

Any bugzilla link with error log and reproduction steps?

> Suggestion-by: Bjorn Helgaas <bhelgaas@google.com>

Suggested-by?

> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>  drivers/pci/pcie/aspm.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..1bf8306141aa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1010,18 +1010,17 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
> -	/*
> -	 * All PCIe functions are in one slot, remove one function will remove
> -	 * the whole slot, so just wait until we are the last function left.
> -	 */
> -	if (!list_empty(&parent->subordinate->devices))
> -		goto out;
>  
>  	link = parent->link_state;
>  	root = link->root;
>  	parent_link = link->parent;
>  
> -	/* All functions are removed, so just disable ASPM for the link */
> +	/*
> +	 * Any function is removed (including software removing), just
> +	 * disable ASPM for the link, in case we can not configure the same
> +	 * setting for all functions.

How about following?

/*
 * For any function removed, disable ASPM for the link. See PCIe r6.0,
 * sec 7.7.3.7 for details.
 */

> +	 * See PCIe r6.0, sec 7.5.3.7.
> +	 */
>  	pcie_config_aspm_link(link, 0);
>  	list_del(&link->sibling);
>  	/* Clock PM is for endpoint device */
> @@ -1032,7 +1031,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  		pcie_update_aspm_capable(root);
>  		pcie_config_aspm_path(parent_link);
>  	}
> -out:
> +
>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
