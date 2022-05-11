Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D15236FB
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 17:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbiEKPUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiEKPUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 11:20:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154FD20D4FF;
        Wed, 11 May 2022 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652282402; x=1683818402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQuR+HgvaEKC/2b83oaJxBCQ61N54Tef7qI8lAy9YJM=;
  b=ejfPFawcbSiyWFPUBEyQCMakRPPDx5E4idD4E7O0hnw93/W+0DUVHnLs
   u3ugMtIrW63pE9MtWV9XQfTOU0GW4QYdNIoWxmXFrabFqiK1e2L7nFj1I
   pIQusSn8w2UM7g14v5+BHHPaEr4W7SQwAkAengp2rDh4XZRtCnNLn/8f9
   eUTu5i8w6ZwqMcqGGKeHFh96Vihws4MkgHoRxIWGIvGBfVIdITi/gFKPJ
   V2hqCc8TNSKWGw7w2NBFQUwmd2fb9m0yfia8v6wuohuOaQiwaKfDGyT7l
   +lJPbPeSiOBhEoN5OGI5ZOZYvHVXo/Sml9w25esmdPFtcQJD1o2f5vEjp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257272999"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="257272999"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:19:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="697620911"
Received: from jmpurse-mobl.amr.corp.intel.com (HELO [10.255.230.30]) ([10.255.230.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:19:54 -0700
Message-ID: <41f62ad1-fee7-3509-f670-b62db8c37843@linux.intel.com>
Date:   Wed, 11 May 2022 08:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3] PCI/AER: Handle Multi UnCorrectable/Correctable errors
 properly
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20220418150237.1021519-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220418150237.1021519-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 4/18/22 8:02 AM, Kuppuswamy Sathyanarayanan wrote:
> Currently the aer_irq() handler returns IRQ_NONE for cases without bits
> PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
> assumption is incorrect.
> 
> Consider a scenario where aer_irq() is triggered for a correctable
> error, and while we process the error and before we clear the error
> status in "Root Error Status" register, if the same kind of error
> is triggered again, since aer_irq() only clears events it saw, the
> multi-bit error is left in tact. This will cause the interrupt to fire
> again, resulting in entering aer_irq() with just the multi-bit error
> logged in the "Root Error Status" register.
> 
> Repeated AER recovery test has revealed this condition does happen
> and this prevents any new interrupt from being triggered. Allow to
> process interrupt even if only multi-correctable (BIT 1) or
> multi-uncorrectable bit (BIT 3) is set.
> 
> Also note that, for cases with only multi-bit error is set, since this
> is not the first occurrence of the error, PCI_ERR_ROOT_ERR_SRC may have
> zero or some junk value. So we cannot cleanly process this error
> information using aer_isr_one_error(). All we are attempting with this
> fix is to make sure error interrupt processing can continue in this
> scenario.
> 
> This error can be reproduced by making following changes to the
> aer_irq() function and by executing the given test commands.
> 
>   static irqreturn_t aer_irq(int irq, void *context)
>           struct aer_err_source e_src = {};
> 
>           pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS,
> 				&e_src.status);
>   +       pci_dbg(pdev->port, "Root Error Status: %04x\n",
>   +		e_src.status);
>           if (!(e_src.status & AER_ERR_STATUS_MASK))
>                   return IRQ_NONE;
> 
>   +       mdelay(5000);
> 
>   # Prep injection data for a correctable error.
>   $ cd /sys/kernel/debug/apei/einj
>   $ echo 0x00000040 > error_type
>   $ echo 0x4 > flags
>   $ echo 0x891000 > param4
> 
>   # Root Error Status is initially clear
>   $ setpci -s <Dev ID> ECAP0001+0x30.w
>   0000
> 
>   # Inject one error
>   $ echo 1 > error_inject
> 
>   # Interrupt received
>   pcieport <Dev ID>: AER: Root Error Status 0001
> 
>   # Inject another error (within 5 seconds)
>   $ echo 1 > error_inject
> 
>   # You will get a new IRQ with only multiple ERR_COR bit set
>   pcieport <Dev ID>: AER: Root Error Status 0002
> 
> Currently, the above issue has been only reproduced in the ICL server
> platform.
> 
> [Eric: proposed reproducing steps]
> Fixes: 4696b828ca37 ("PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/")
> Reported-by: Eric Badger <ebadger@purestorage.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 

Any comments on this patch? I'm wondering whether you are expecting any
changes to be done to it. Please let me know.

> Changes since v2:
>   * Added more details to the commit log.
>   * Rebased on v5.18-rc1.
> 
> Changes since v1:
>   * Added Fixes tag.
>   * Included reproducing steps proposed by Eric.
> 
>   drivers/pci/pcie/aer.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b27..7952e5efd6cf 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -101,6 +101,11 @@ struct aer_stats {
>   #define ERR_COR_ID(d)			(d & 0xffff)
>   #define ERR_UNCOR_ID(d)			(d >> 16)
>   
> +#define AER_ERR_STATUS_MASK		(PCI_ERR_ROOT_UNCOR_RCV |	\
> +					PCI_ERR_ROOT_COR_RCV |		\
> +					PCI_ERR_ROOT_MULTI_COR_RCV |	\
> +					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
> +
>   static int pcie_aer_disable;
>   static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>   
> @@ -1196,7 +1201,7 @@ static irqreturn_t aer_irq(int irq, void *context)
>   	struct aer_err_source e_src = {};
>   
>   	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, &e_src.status);
> -	if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
> +	if (!(e_src.status & AER_ERR_STATUS_MASK))
>   		return IRQ_NONE;
>   
>   	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_ERR_SRC, &e_src.id);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
