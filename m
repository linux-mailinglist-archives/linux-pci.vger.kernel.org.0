Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E46E975C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjDTOlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDTOlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 10:41:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73A1FE2;
        Thu, 20 Apr 2023 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682001666; x=1713537666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RE2G4G5/kCJbfikj+OrCLHdtm7sx6+e6VafZKC/44Ts=;
  b=M8vVjxZ27wkVtCILbC0nJ6sJ3UdWGxJI9HPOUF0wj+FHCw+/V40FKTO8
   QPCNaKJnFMCUhwzDTON+yMKK/p3fvSv32i3NLXdYuUgbmelkQLM1p9C03
   /OWPFvSrA0JYTIRs74LXi6zfe1wKcVz1HM5ABNIOn2if+UEAXun7v40aF
   EWt1SiYw090mdeu08QS45ZCz+ncHVKAAaG4RFxabdQq+9HSOK0EUamDCR
   JfI04w1duC2wvVByeERgB9zbOHz/RQ4/2ZZj6ow5ZQ+R2lmqXSq1pbn1Z
   EKkgLdQQnLlrq3oebUpPSr1LQMenLJUN44Rjgs83rQfNUlyf+Op+9aNk6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="347621532"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="347621532"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="816039930"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="816039930"
Received: from samuelra-mobl7.amr.corp.intel.com (HELO [10.255.229.46]) ([10.255.229.46])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:41:05 -0700
Message-ID: <ff14e835-1c24-5492-808e-47bca3bf7f74@linux.intel.com>
Date:   Thu, 20 Apr 2023 07:41:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/4] PCI/AER: Factor out interrupt toggling into
 helpers
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
 <20230420125941.333675-2-kai.heng.feng@canonical.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230420125941.333675-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/20/23 5:59 AM, Kai-Heng Feng wrote:
> There are many places that enable and disable AER interrput, so move
> them into helpers.

Add "No functional changes intended"

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> v3:
>  - Correct subject.
> 
> v2:
>  - New patch.
> 
>  drivers/pci/pcie/aer.c | 45 +++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..1420e1f27105 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1227,6 +1227,28 @@ static irqreturn_t aer_irq(int irq, void *context)
>  	return IRQ_WAKE_THREAD;
>  }
>  
> +static void aer_enable_irq(struct pci_dev *pdev)
> +{
> +	int aer = pdev->aer_cap;
> +	u32 reg32;
> +
> +	/* Enable Root Port's interrupt in response to error messages */
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +}
> +
> +static void aer_disable_irq(struct pci_dev *pdev)
> +{
> +	int aer = pdev->aer_cap;
> +	u32 reg32;
> +
> +	/* Disable Root's interrupt in response to error messages */
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +}
> +
>  /**
>   * aer_enable_rootport - enable Root Port's interrupts when receiving messages
>   * @rpc: pointer to a Root Port data structure
> @@ -1256,10 +1278,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
>  
> -	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	aer_enable_irq(pdev);
>  }
>  
>  /**
> @@ -1274,10 +1293,7 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>  	int aer = pdev->aer_cap;
>  	u32 reg32;
>  
> -	/* Disable Root's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	aer_disable_irq(pdev);
>  
>  	/* Clear Root's error status reg */
>  	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> @@ -1372,12 +1388,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	 */
>  	aer = root ? root->aer_cap : 0;
>  
> -	if ((host->native_aer || pcie_ports_native) && aer) {
> -		/* Disable Root's interrupt in response to error messages */
> -		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> -	}
> +	if ((host->native_aer || pcie_ports_native) && aer)
> +		aer_disable_irq(root);
>  
>  	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
>  		rc = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
> @@ -1396,10 +1408,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
>  		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
>  
> -		/* Enable Root Port's interrupt in response to error messages */
> -		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		aer_enable_irq(root);
>  	}
>  
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
