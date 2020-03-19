Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985C918BE2E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 18:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCSRhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 13:37:32 -0400
Received: from foss.arm.com ([217.140.110.172]:39494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgCSRhc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 13:37:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B4D30E;
        Thu, 19 Mar 2020 10:37:31 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB83A3F305;
        Thu, 19 Mar 2020 10:37:30 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:37:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Qiujun Huang <hqjagain@gmail.com>, anders.roxell@linaro.org,
        vidyas@nvidia.com
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dwc: fix compile err for pcie-tagra194
Message-ID: <20200319173710.GA7433@e121166-lin.cambridge.arm.com>
References: <1584621380-21152-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584621380-21152-1-git-send-email-hqjagain@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 19, 2020 at 08:36:20PM +0800, Qiujun Huang wrote:
> make allmodconfig
> ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make: *** [sub-make] Error 2
> 
> need to export the symbols.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
>  1 file changed, 3 insertions(+)

I have squashed this in with the original patch.

@Vidya: is this something we missed in the review cycle ? Asking just
to make sure it was not me who made a mistake while merging the code.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 4233c43..60d62ef 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -18,6 +18,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  
>  	pci_epc_linkup(epc);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
>  
>  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  {
> @@ -25,6 +26,7 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  
>  	pci_epc_init_notify(epc);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
>  
>  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
>  				   int flags)
> @@ -535,6 +537,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>  
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
> -- 
> 1.8.3.1
> 
