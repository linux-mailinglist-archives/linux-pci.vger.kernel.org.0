Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9849C850
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiAZLKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 06:10:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:20697 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233213AbiAZLKJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 06:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643195409; x=1674731409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZ52GxZm2Eq1pzG9AHFhzbjqb/WlLIS9HlqJiBwFpBE=;
  b=P/xu5lStg8ZjB0PZDjIQmkKbyfUFT/EEOGpbQYsJTIVHg8WpC8Gekq5O
   QkP/cDUYf94PcHlMLet3vjUgRHIFKV/NLrWrPLs3AEzkbFukDlmmVlRIJ
   X4WkB1tdU7IYocfNprBeQ9xxv7UtJQJGfIH0FpVGVnEjaCDBwOOR6coHM
   VJSWlfm7M3natB+zV2HFTI+WX+GCI+SoW1ej/SGGTXZ97R98Ux38iT/VB
   CEd2x2NgMltvUm4nLNv88fyt7ZJi/wGGZRD+JelPK3h3Cl3pFyL4ae3oI
   kykrc+u+fefJRiquAcAza5MAiqbO2CPq/aoYGUTHNV16AjFHejDMWKwpH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270980033"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="270980033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 03:10:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="624802639"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 03:10:06 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Jan 2022 13:10:03 +0200
Date:   Wed, 26 Jan 2022 13:10:03 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/DPC: Disable DPC when link is in L2/L3 ready, L2
 and L3 state
Message-ID: <YfEsC94BvFwd5MLy@lahna>
References: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
 <20220126071853.1940111-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126071853.1940111-2-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Jan 26, 2022 at 03:18:52PM +0800, Kai-Heng Feng wrote:
> Since TLP and DLLP transmission is disabled for a Link in L2/L3 Ready,
> L2 and L3, and DPC depends on AER, so also disable DPC here.

Here too I think it is good to mention that the DPC "service" never
implemented the PM hooks in the first place

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

One minor comment below, but other than that looks good,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/pci/pcie/dpc.c | 61 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3e9afee02e8d1..9585c10b7c577 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -343,13 +343,34 @@ void pci_dpc_init(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void dpc_enable(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev = dev->port;
> +	u16 ctl;
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> +

Drop the empty line here.

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
