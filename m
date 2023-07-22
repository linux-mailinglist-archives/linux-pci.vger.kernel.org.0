Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E1575D81A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jul 2023 02:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGVARI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 20:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVARH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 20:17:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDB1705;
        Fri, 21 Jul 2023 17:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689985027; x=1721521027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sVDYsKmJrI+FgtLdiHgy/Ei0RS4XwTYvF/jSUYneT+A=;
  b=B00VZbgLEZ8ng38GYURQGDno/fWt7Q/rikXkw0u8nDY+N9rMhBvP3FUk
   WSNzXi+CshSrnaeO6urfPeO1k3hVBnh1ZaBMGUlG50sEo/Xk4p/366E8Q
   28UQYVWFjcdltXcxQVFd5Hz4GaGXJT7r7B+sCaRF3giwHD+KhXAI5aMhV
   k0PJqW/PB0INcZmJRYi7i5Ri+cCh7wLmnvfAVGtwOitq6Ldj2Zo8EyAyx
   taP/8rNkqC7/RYVeykdftRcCXR9Dx2V2NMuSBsd1+RVDkO4WL90fU3Ckj
   JzpBQS0objUvlSpXtXmcwXmsYgIrMDSSPkG9bwlyQQHO0+2XiKNfY9g7r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369808751"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="369808751"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 17:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="719025040"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="719025040"
Received: from cthomas-mobl1.amr.corp.intel.com (HELO [10.209.99.41]) ([10.209.99.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 17:17:06 -0700
Message-ID: <d94a39e3-1822-1f3f-1118-6b2346f5e738@linux.intel.com>
Date:   Fri, 21 Jul 2023 17:17:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] cxl/pci: Replace host_bridge->native_aer with
 pcie_aer_is_native()
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
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-4-Smita.KoralahalliChannabasappa@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230721214740.256602-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/21/23 2:47 PM, Smita Koralahalli wrote:
> Reuse pcie_aer_is_native() to determine the native AER ownership.

Although it is straightforward, IMO, the commit log should include
few words about *why* you are making this change.

For example, usage of host_bride->native_aer does not cover command
line override of AER ownership. So use pcie_aer_is_native() to
determine the ownership.

With that fixed,

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Replaced pcie_aer_is_native() at a later stage for automated
> 	backports.
> ---
>  drivers/cxl/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2323169b6e5f..44a21ab7add5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
> -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	void __iomem *addr;
>  	u32 orig_val, val, mask;
> @@ -542,7 +541,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  	}
>  
>  	/* BIOS has PCIe AER error control */
> -	if (!host_bridge->native_aer)
> +	if (!pcie_aer_is_native(pdev))
>  		return 0;
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
