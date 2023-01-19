Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC33672FCE
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 04:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjASD4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 22:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjASDxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 22:53:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0346D5C
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 19:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674100336; x=1705636336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9LcZBYGDhBOOdba4bfvLDoiPsfgsdNgi8ugQN5xCxek=;
  b=Zm05sUtkM0PYDr1i/96o+hscgG6+ShCAD7vedsZOuJI5v3+FNeyeEvjT
   wwP1k6PkqpqhXvrxTBEAd6zabY1oTAnQVpC+g/XUKcInTv3KoTzCkfzVR
   r9d8+ve5RzaSzd56hc7LORxJzcYu6aB9DhfH2n1oJpGn1271lOPNf6QGZ
   ppcz9fYiGaWnygycZykrOVNsDC6XUr3jmB/zRbBkXOQW/er8azTSoMwAP
   fIPez3LXUl9Ri7t0zhIVnCe34WhDUdM3KwXBUi0jjwei8LP2kufsOaaTQ
   DqhVFgYMpsqb320yacJJac/1gLg6pEPCRRSuhQfdFny9XYB2K5l3jj0Ph
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="305558733"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="305558733"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 19:49:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661981566"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661981566"
Received: from bakersax-mobl.amr.corp.intel.com (HELO [10.209.33.66]) ([10.209.33.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 19:49:06 -0800
Message-ID: <001efe2e-0ae8-e3fe-f872-d5401ec802c9@linux.intel.com>
Date:   Wed, 18 Jan 2023 19:49:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/9] PCI/AER: Remove redundant Device Control Error
 Reporting Enable
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stefan Roese <sr@denx.de>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>
References: <20230118234612.272916-1-helgaas@kernel.org>
 <20230118234612.272916-2-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230118234612.272916-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/18/23 3:46 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The following bits in the PCIe Device Control register enable sending of
> ERR_COR, ERR_NONFATAL, or ERR_FATAL Messages (or reporting internally in
> the case of Root Ports):
> 
>   Correctable Error Reporting Enable
>   Non-Fatal Error Reporting Enable
>   Fatal Error Reporting Enable
>   Unsupported Request Reporting Enable
> 
> These enable bits are set by pci_enable_pcie_error_reporting(), and since
> f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"), we
> do that in this path during enumeration:
> 
>   pci_init_capabilities
>     pci_aer_init
>       pci_enable_pcie_error_reporting
> 
> Previously, the AER service driver also traversed the hierarchy when
> claiming a Root Port, enabling error reporting for downstream devices, but
> this is redundant.
> 
> Remove the code that enables this error reporting in the AER .probe() path.
> Also remove similar code that disables error reporting in the AER .remove()
> path.
> 
> Note that these Device Control Reporting Enable bits do not control
> interrupt generation.  That's done by the similarly-named bits in the AER
> Root Error Command register, which are still set by aer_probe() and cleared
> by aer_remove(), since the AER service driver handles those interrupts.
> See PCIe r6.0, sec 6.2.6.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/aer.c | 48 ------------------------------------------
>  1 file changed, 48 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 625f7b2cafe4..b7b69e0c778c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1224,42 +1224,6 @@ static irqreturn_t aer_irq(int irq, void *context)
>  	return IRQ_WAKE_THREAD;
>  }
>  
> -static int set_device_error_reporting(struct pci_dev *dev, void *data)
> -{
> -	bool enable = *((bool *)data);
> -	int type = pci_pcie_type(dev);
> -
> -	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
> -	    (type == PCI_EXP_TYPE_RC_EC) ||
> -	    (type == PCI_EXP_TYPE_UPSTREAM) ||
> -	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
> -		if (enable)
> -			pci_enable_pcie_error_reporting(dev);
> -		else
> -			pci_disable_pcie_error_reporting(dev);
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * set_downstream_devices_error_reporting - enable/disable the error reporting  bits on the root port and its downstream ports.
> - * @dev: pointer to root port's pci_dev data structure
> - * @enable: true = enable error reporting, false = disable error reporting.
> - */
> -static void set_downstream_devices_error_reporting(struct pci_dev *dev,
> -						   bool enable)
> -{
> -	set_device_error_reporting(dev, &enable);
> -
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> -		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
> -	else if (dev->subordinate)
> -		pci_walk_bus(dev->subordinate, set_device_error_reporting,
> -			     &enable);
> -
> -}
> -
>  /**
>   * aer_enable_rootport - enable Root Port's interrupts when receiving messages
>   * @rpc: pointer to a Root Port data structure
> @@ -1289,12 +1253,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
>  
> -	/*
> -	 * Enable error reporting for the root port device and downstream port
> -	 * devices.
> -	 */
> -	set_downstream_devices_error_reporting(pdev, true);
> -
>  	/* Enable Root Port's interrupt in response to error messages */
>  	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> @@ -1313,12 +1271,6 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>  	int aer = pdev->aer_cap;
>  	u32 reg32;
>  
> -	/*
> -	 * Disable error reporting for the root port device and downstream port
> -	 * devices.
> -	 */
> -	set_downstream_devices_error_reporting(pdev, false);
> -
>  	/* Disable Root's interrupt in response to error messages */
>  	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
