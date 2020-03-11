Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284F21815C4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 11:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgCKK2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 06:28:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:1938 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCKK2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 06:28:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 03:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="353855467"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 Mar 2020 03:28:12 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 11 Mar 2020 12:28:11 +0200
Date:   Wed, 11 Mar 2020 12:28:11 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip link training delay for S3 resume
Message-ID: <20200311102811.GA2540@lahna.fi.intel.com>
References: <20200311045249.5200-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311045249.5200-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Mar 11, 2020 at 12:52:49PM +0800, Kai-Heng Feng wrote:
> Commit ad9001f2f411 ("PCI/PM: Add missing link delays required by the
> PCIe spec") added a 1100ms delay on resume for bridges that don't
> support Link Active Reporting.
> 
> The commit also states that the delay can be skipped for S3, as the
> firmware should already handled the case for us.

Delay can be skipped if the firmware provides _DSM with function 8
implemented according to PCI firmwre spec 3.2 sec 4.6.8.

> So let's skip the link training delay for S3, to save 1100ms resume
> time.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci-driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..3050375bad04 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -916,7 +916,8 @@ static int pci_pm_resume_noirq(struct device *dev)
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  	pcie_pme_root_status_cleanup(pci_dev);
>  
> -	if (!skip_bus_pm && prev_state == PCI_D3cold)
> +	if (!skip_bus_pm && prev_state == PCI_D3cold
> +	    && !pm_resume_via_firmware())

So this would need to check for the _DSM result as well. We do evaluate
it in pci_acpi_optimize_delay() (drivers/pci/pci-acpi.c) and that ends
up lowering ->d3cold_delay so maybe check that here.

>  		pci_bridge_wait_for_secondary_bus(pci_dev);
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
> -- 
> 2.17.1
