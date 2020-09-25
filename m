Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA51278ED9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgIYQk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 12:40:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:59775 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgIYQk0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 12:40:26 -0400
IronPort-SDR: S6Cc/jld4fbCqJ9WFHDuTgkTJiYpL6D+GOjvKZ6VTmNO0d3njEPMxj0Q9ycKe1ty3cL4pmE81w
 FQpgV+K5CGFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="223179522"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="223179522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:25 -0700
IronPort-SDR: Z+Yc73fM95djGruhbCqV/iSdayfy3k2jRivEjN95lh17YdEX3AKY4yVL8hTDLtqQ0TG5CONkpn
 uv+nC6d25+rQ==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="413872107"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kLmmE-001urC-Vk; Fri, 25 Sep 2020 15:24:38 +0300
Date:   Fri, 25 Sep 2020 15:24:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH 1/5] PCI: define a function to check and wait till port
 finish DPC handling
Message-ID: <20200925122438.GB3956970@smile.fi.intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-2-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925023423.42675-2-haifeng.zhao@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:34:19PM -0400, Ethan Zhao wrote:
> Once root port DPC capability is enabled and triggered, at the beginning
> of DPC is triggered, the DPC status bits are set by hardware and then
> sends DPC/DLLSC/PDC interrupts to OS DPC and pciehp drivers, it will
> take the port and software DPC interrupt handler 10ms to 50ms (test data
> on ICX platform & stable 5.9-rc6) to complete the DPC containment procedure
> till the DPC status is cleared at the end of the DPC interrupt handler.
> 
> We use this function to check if the root port is in DPC handling status
> and wait till the hardware and software completed the procedure.

>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/resource_ext.h>

> +#include <linux/delay.h>

Keep it sorted?

>  #include <uapi/linux/pci.h>

...

> +#ifdef CONFIG_PCIE_DPC
> +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev)
> +{
> +	u16 cap = pdev->dpc_cap, status;
> +	u16 loop = 0;
> +
> +	if (!cap) {

> +		pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n");

But why? Is this feature mandatory to have? Then the same question about
ifdeffery, otherwise it's pretty normal to not have a feature, right?

> +		return false;
> +	}
> +	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);

> +	while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> +		msleep(10);
> +		loop++;
> +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	}

Can we have rather something like readx_poll_timeout() for PCI and use them here?

> +	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> +		pci_dbg(pdev, "Out of DPC status %x, time cost %d ms\n", status, loop*10);
> +		return true;
> +	}
> +	pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> +	return false;
> +}
> +#else
> +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev)
> +{
> +	return true;
> +}
> +#endif
>  #endif /* LINUX_PCI_H */
> -- 
> 2.18.4
> 

-- 
With Best Regards,
Andy Shevchenko


