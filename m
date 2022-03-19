Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5B4DEAB1
	for <lists+linux-pci@lfdr.de>; Sat, 19 Mar 2022 21:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbiCSUln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Mar 2022 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCSUln (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Mar 2022 16:41:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624F71C8A9E;
        Sat, 19 Mar 2022 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647722421; x=1679258421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nd8cTOZCZJMffvQJDvB7Hp7HuDrz3fS77J4g0WJHxjQ=;
  b=Dn6/KzYRQYyPshx2VVa7zg9pEHenDXmuUV9DxBANaos/z+H79nWNdGqA
   YT6j/C3FJYxs0yxqdfrDVyTmJeCaMlRyTkFACowFarblZymId+jltf9SY
   2cSfyWhpt7KGXrM0cpGxXeo/HbRp7P/nX1xMtqvKpX0KvR8X+KutAqc6e
   jjbV24AslkSUcmCnqdYsYvgtNHybJx8oDwwxtssoeBMRuNRTP4nWk8kBt
   QJDu4yc9ZgcL2EtzO70fCiAPQWwsmDniIdPuJCRoSRLQEYMfbd8vDCHsa
   m3vbyvR+TlkT7STrjiSOldeDxqxPbqZlajQ023uJ4fq+RNDpDJ3+XCCM3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254894997"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254894997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 13:40:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="542657573"
Received: from llscottx-mobl1.amr.corp.intel.com (HELO [10.209.82.139]) ([10.209.82.139])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 13:40:20 -0700
Message-ID: <aa810b71-89b2-f18e-5564-d65ed421b8d9@linux.intel.com>
Date:   Sat, 19 Mar 2022 13:40:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] PCI/DPC: Disable DPC service when link is in L2/L3
 ready, L2 and L3 state
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
 <20220127025418.1989642-2-kai.heng.feng@canonical.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220127025418.1989642-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/26/22 6:54 PM, Kai-Heng Feng wrote:
> Since TLP and DLLP transmission is disabled for a Link in L2/L3 Ready,
> L2 and L3 (i.e. device in D3hot and D3cold), and DPC depends on AER, so

Better description about the problem would be helpful. I know you
have included a log in AER patch. But a quick summary of the problem
in this patch will make it easier to read the patch.

> also disable DPC here.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>   - Wording change.
>   - Empty line dropped.
> 
>   drivers/pci/pcie/dpc.c | 60 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3e9afee02e8d1..414258967f08e 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -343,13 +343,33 @@ void pci_dpc_init(struct pci_dev *pdev)
>   	}
>   }
>   
> +static void dpc_enable(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev = dev->port;
> +	u16 ctl;
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> +	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> +}
> +
> +static void dpc_disable(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev = dev->port;
> +	u16 ctl;
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> +	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> +}
> +
>   #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
>   static int dpc_probe(struct pcie_device *dev)
>   {
>   	struct pci_dev *pdev = dev->port;
>   	struct device *device = &dev->device;
>   	int status;
> -	u16 ctl, cap;
> +	u16 cap;
>   
>   	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
>   		return -ENOTSUPP;
> @@ -364,10 +384,7 @@ static int dpc_probe(struct pcie_device *dev)
>   	}
>   
>   	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
> -	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> -
> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> -	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> +	dpc_enable(dev);
>   	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>   
>   	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
> @@ -380,22 +397,33 @@ static int dpc_probe(struct pcie_device *dev)
>   	return status;
>   }
>   
> -static void dpc_remove(struct pcie_device *dev)
> +static int dpc_suspend(struct pcie_device *dev)
>   {
> -	struct pci_dev *pdev = dev->port;
> -	u16 ctl;
> +	dpc_disable(dev);
> +	return 0;
> +}
>   
> -	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> -	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
> -	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> +static int dpc_resume(struct pcie_device *dev)
> +{
> +	dpc_enable(dev);
> +	return 0;
> +}
> +
> +static void dpc_remove(struct pcie_device *dev)
> +{
> +	dpc_disable(dev);
>   }
>   
>   static struct pcie_port_service_driver dpcdriver = {
> -	.name		= "dpc",
> -	.port_type	= PCIE_ANY_PORT,
> -	.service	= PCIE_PORT_SERVICE_DPC,
> -	.probe		= dpc_probe,
> -	.remove		= dpc_remove,
> +	.name			= "dpc",
> +	.port_type		= PCIE_ANY_PORT,
> +	.service		= PCIE_PORT_SERVICE_DPC,
> +	.probe			= dpc_probe,
> +	.suspend		= dpc_suspend,
> +	.resume			= dpc_resume,
> +	.runtime_suspend	= dpc_suspend,
> +	.runtime_resume		= dpc_resume,
> +	.remove			= dpc_remove,
>   };
>   
>   int __init pcie_dpc_init(void)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
