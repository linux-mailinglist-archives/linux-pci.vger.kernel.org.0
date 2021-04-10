Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4435AECA
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhDJPVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 11:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJPVU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Apr 2021 11:21:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DB57611C2;
        Sat, 10 Apr 2021 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618068065;
        bh=+Qmc8k9G7vMTnKZ+bWVMEMwIV3SSxAOpo2eWKe1OI34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UYd9OmxHnb7appWRQ8iQL3leCzRl37H7nnLSzWqLc5ErqDRhZq1iza6dr8VUk4IxC
         n8SObzrC7tABlMkRHQBHuF2DKuEn7EbZZgscLt17p3s9nXzo6gUd0dBvNSuV95/33K
         081+K+wmtAAb7RiAG6pIp9heu5SnLsbyrTZbC7xYMPHxFXEfBMHURIQoZTygoN8doh
         MWVWSC5PqA2Gp5ydRke/4DD00qyO7BaQhkr4Ou/hOrFiLhKr+rCf0WH0QTkRYHL58a
         m6ffahp4Jxp5Iitd8kL/aWFyXlXqlxYmhIuhAFOEc28o/9vTlR610h1pWAILDsxnSw
         Ral1EREVDwCpw==
Date:   Sat, 10 Apr 2021 10:21:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, kbusch@kernel.org,
        sean.v.kelley@intel.com, qiuxu.zhuo@intel.com,
        prime.zeng@huawei.com, linuxarm@openeuler.org
Subject: Re: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc
 service
Message-ID: <20210410152103.GA2043340@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612356795-32505-2-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 08:53:15PM +0800, Yicong Yang wrote:
> Per Downstream Port Containment Related Enhancements ECN[1],
> Table 4-6 Interpretation of _OSC Control Field Returned Value,
> for bit 7 of _OSC control return value:
> 
>   "If firmware allows the OS control of this feature, then,
>   in the context of the _OSC method the OS must ensure that
>   Downstream Port Containment ERR_COR signaling is disabled
>   as described in the PCI Express Base Specification."
> 
> and PCI Express Base Specification Revision 4.0 Version 1.0
> section 6.2.10.2, Use of DPC ERR_COR Signaling:
> 
>   "...DPC ERR_COR signaling is primarily intended for use by
>   platform firmware..."
> 
> Currently we don't set DPC ERR_COR enable bit, but explicitly
> clear the bit to ensure it's disabled.
> 
> [1] Downstream Port Containment Related Enhancements ECN,
>     Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
>     https://members.pcisig.com/wg/PCI-SIG/document/12888
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Anybody want to chime in and review this?  Sometimes I feel like a
one-man band :)

> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba8..5cc8ef3 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>  
> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> +	ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>  	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>  
> -- 
> 2.8.1
> 
