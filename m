Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867B2F32A6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 16:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfKGPPj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 10:15:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:11333 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGPPj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 10:15:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 07:15:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="205700535"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 07 Nov 2019 07:15:37 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iSjVY-0007XA-9U; Thu, 07 Nov 2019 17:15:36 +0200
Date:   Thu, 7 Nov 2019 17:15:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v1] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Message-ID: <20191107151536.GA32742@smile.fi.intel.com>
References: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 11, 2019 at 12:02:30PM +0300, Andy Shevchenko wrote:
> Infinite timeout loops are hard to read. Refactor it
> to plausible 'do {} while ()'.
> 
> Note, the supplied timeout can't be negative for current use,
> though if it's not dividable to 10, we may go below 0,
> that's why type of the parameter is int. And thus, we may move
> the check to the loop condition.
> 
> No functional changes implied.

Bjorn, any comment on this? It would be nice to have in since contributors are
unable to know which style to use. This patch makes similar places follow the
same style.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1a522c1c4177..e397c78ca232 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -68,7 +68,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 slot_status;
>  
> -	while (true) {
> +	do {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>  		if (slot_status == (u16) ~0) {
>  			ctrl_info(ctrl, "%s: no response from device\n",
> @@ -81,11 +81,9 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  						   PCI_EXP_SLTSTA_CC);
>  			return 1;
>  		}
> -		if (timeout < 0)
> -			break;
>  		msleep(10);
>  		timeout -= 10;
> -	}
> +	} while (timeout > 0);
>  	return 0;	/* timeout */
>  }
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


