Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4681A99F0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896170AbgDOKHo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 06:07:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:26938 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896168AbgDOKHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 06:07:42 -0400
IronPort-SDR: ygNsGP78gNK4RB0HRw8sUDmSvzMEJKY0vwPEdzRcxA/3CTJzToExOkAJ+SnFADnGHC0lgMouee
 y/tHgHX9Nu2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 03:07:42 -0700
IronPort-SDR: EebCVhxBJNMGFCCIJUcJimG8dbFy8SUtdHsZNe9cSASoYoSg7Qs3kyDlU5J/tctuXl4/esOHUE
 NHVUWyDjuO5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="253481850"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 03:07:39 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jOexK-000kMO-2q; Wed, 15 Apr 2020 13:07:42 +0300
Date:   Wed, 15 Apr 2020 13:07:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, p.zabel@pengutronix.de,
        gustavo.pimentel@synopsys.com, eswara.kota@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] PCI: dwc: intel: make intel_pcie_cpu_addr() static
Message-ID: <20200415100742.GR34613@smile.fi.intel.com>
References: <20200415084953.6533-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415084953.6533-1-yanaijie@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 15, 2020 at 04:49:53PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/pci/controller/dwc/pcie-intel-gw.c:456:5: warning: symbol
> 'intel_pcie_cpu_addr' was not declared. Should it be static?

Please, learn how to use get_maintainers.pl to avoid spamming people.
Hint:
	scripts/get_maintainer.pl --git --git-min-percent=67
would give advantage, though it still requires a common sense to be applied.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index fc2a12212dec..2d8dbb318087 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -453,7 +453,7 @@ static int intel_pcie_msi_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> +static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
>  {
>  	return cpu_addr + BUS_IATU_OFFSET;
>  }
> -- 
> 2.21.1
> 

-- 
With Best Regards,
Andy Shevchenko


