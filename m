Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9089153821
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBESaZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 13:30:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:64364 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgBESaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 13:30:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 10:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="264318712"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by fmsmga002.fm.intel.com with ESMTP; 05 Feb 2020 10:30:24 -0800
Date:   Wed, 5 Feb 2020 10:28:00 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v13 1/8] PCI/ERR: Update error status after reset_link()
Message-ID: <20200205182800.GB112031@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <cover.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c9937c2fbd3d6c65bca92899254cb4f85136c8cc.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9937c2fbd3d6c65bca92899254cb4f85136c8cc.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Sat, Jan 18, 2020 at 08:00:30PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> reset_link() to recover from fatal errors. But during fatal error
> recovery, if the initial value of error status is
> PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> even after successful recovery (using reset_link()) pcie_do_recovery()
> will report the recovery result as failure. So update the status of
> error after reset_link().

Since this patch has no dependency on EDR, can we merge it first?

> 
> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/err.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index b0e6048a9208..71639055511e 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -204,9 +204,11 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  	else
>  		pci_walk_bus(bus, report_normal_detected, &status);
>  
> -	if (state == pci_channel_io_frozen &&
> -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> -		goto failed;
> +	if (state == pci_channel_io_frozen) {
> +		status = reset_link(dev, service);
> +		if (status != PCI_ERS_RESULT_RECOVERED)
> +			goto failed;
> +	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
> -- 
> 2.21.0
> 

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
