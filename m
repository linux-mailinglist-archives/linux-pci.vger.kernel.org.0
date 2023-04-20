Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E190F6E90F4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjDTKuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjDTKuB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 06:50:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BDA83C4;
        Thu, 20 Apr 2023 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681987680; x=1713523680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NHQvgp+/Rj8vc4D0tZlxdL5eAw2LMvWlJhM14S82Uw0=;
  b=IioCUVijN2Q4+VClO06J/q0+p8Bwgw3hVaCf2qewDXg5uo/h3QdwpekI
   WtwVGOa+k42r1EplrhJpL+JjqhTWM//IXobZH3QzdyVds3gxSu9/j/Y3A
   4NBuUgRdZqy2zK0Cwz3uTB6UStUqhfMDS1s3+WqNozsZb9o+7uSv+szqU
   ZHBR/27aWl388l4MOGkuTiGKoS7mBQWUBhwWrkf5t6B0iPCXBoor/3dLY
   B9Uu3DuIvUOeo9CWjkbxeiVSnU2EJBu4GnFHeegf9vaXBqRSWHsW5Dbns
   TiUMoMZRzfhKiPt4mmEcWwSQyM3U7ZvNXof9US8T7ZCphpCJr+CQc5Two
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325307189"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="325307189"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 03:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="866204834"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="866204834"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2023 03:47:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BAB6421E7; Thu, 20 Apr 2023 13:47:40 +0300 (EEST)
Date:   Thu, 20 Apr 2023 13:47:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI/AER: Factor out interrput toggling into
 helpers
Message-ID: <20230420104740.GL66750@black.fi.intel.com>
References: <20230420015830.309845-1-kai.heng.feng@canonical.com>
 <20230420015830.309845-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230420015830.309845-2-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Typo in $subject:

 interrput -> interrupt

On Thu, Apr 20, 2023 at 09:58:28AM +0800, Kai-Heng Feng wrote:
> There are many places that enable and disable AER interrput, so move
> them into helpers.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
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
> -- 
> 2.34.1
