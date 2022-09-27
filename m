Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863285ECD20
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 21:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiI0Trs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 15:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiI0Trr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 15:47:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CA61B526E;
        Tue, 27 Sep 2022 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664308066; x=1695844066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eN4jmEX43FC2hynGPrezejUCbvmijBGF9PDOUGgeBks=;
  b=I+dg+eUJ8FafYI8GLIyMEu4FdbY8EcCCBzaKRQHW19dJAVCLGWhv67SG
   hcEb4EyEjYx6CEhtY3HVAuJliaBXlhx0vEgpLNSr2X3Scv8deJhCs3Ly3
   9cFIfVkQTGT5I5JMOhitFZN/Ji3mvQP/FOVReIZCsFprFCQpP+U6/lj6A
   YtjtStsLW9/BH896Jna66azzQqG+cbi5Oz/72PvNull4oRNqT+PWuTECu
   z+NZlcMW4MUvufoRsgz3mTvhSI/y94jqBzKnt9Mev985w1dDQyFTQWlYw
   bC0CoDhs7erOuuaAIyuStt7ouZVUDROEb7k3nMeY+lWSP1wtRWtt/SeBF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281786383"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="281786383"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:39:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="690113946"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="690113946"
Received: from weimingg-mobl.amr.corp.intel.com (HELO [10.212.244.112]) ([10.212.244.112])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:39:11 -0700
Message-ID: <d8123aa3-a5e0-6131-bd0d-109f67923ff2@linux.intel.com>
Date:   Tue, 27 Sep 2022 12:39:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/9] NTB: Change to use
 pci_aer_clear_uncorrect_error_status()
Content-Language: en-US
To:     Zhuo Chen <chenzhuo.1@bytedance.com>, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-4-chenzhuo.1@bytedance.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220927153524.49172-4-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/27/22 8:35 AM, Zhuo Chen wrote:
> Status bits for ERR_NONFATAL errors only are cleared in
> pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
> error status in idt_init_pci(), so we change to use
> pci_aer_clear_uncorrect_error_status().

You mean currently driver does not clear fatal errors now, and it is
a problem? Any error reported?

Also, I am wondering why is it required to clear errors during init
code. Is it a norm?

> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 0ed6f809ff2e..d5f0aa87f817 100644
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
>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
