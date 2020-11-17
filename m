Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71B2B6FBE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgKQUKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 15:10:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:47971 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKQUKl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 15:10:41 -0500
IronPort-SDR: RTY3pewITNH9P1e29O3A2kOgtnuq8tzLhs23QpPHnp5MEIWD6/7PT1PpQ8lxXxAYLrAeCwFZ1L
 xImRK6L/w6wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158033899"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158033899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:10:38 -0800
IronPort-SDR: 4OHLaR8PqVGEgsWMQQj6l6s8DzfRVg7aJFG0PVgrL4/tln6zbSbJ9OYLdIvjXPwiKeK6L6inPO
 mAtn4U7GFG3A==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544192441"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:10:38 -0800
Subject: Re: [PATCH v11 05/16] PCI/ERR: Rename reset_link() to
 reset_subordinates()
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-6-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <80f4244a-5d1a-7b47-3f89-d97d0a589b30@linux.intel.com>
Date:   Tue, 17 Nov 2020 12:10:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-6-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/17/20 11:19 AM, Sean V Kelley wrote:
> reset_link() appears to be misnamed.  The point is to reset any devices
> below a given bridge, so rename it to reset_subordinates() to make it clear
> that we are passing a bridge with the intent to reset the devices below it.
> 
> [bhelgaas: fix reset_subordinate_device() typo, shorten name]
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20201002184735.1229220-5-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pci.h      | 4 ++--
>   drivers/pci/pcie/err.c | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12dcad8f3635..3c4570a3058f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -572,8 +572,8 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>   
>   /* PCI error reporting and recovery */
>   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> -			pci_channel_state_t state,
> -			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
> +		pci_channel_state_t state,
> +		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
>   
>   bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>   #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..db149c6ce4fb 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -147,8 +147,8 @@ static int report_resume(struct pci_dev *dev, void *data)
>   }
>   
>   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> -			pci_channel_state_t state,
> -			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> +		pci_channel_state_t state,
> +		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>   {
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>   	struct pci_bus *bus;
> @@ -165,9 +165,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	pci_dbg(dev, "broadcast error_detected message\n");
>   	if (state == pci_channel_io_frozen) {
>   		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> +		status = reset_subordinates(dev);
>   		if (status != PCI_ERS_RESULT_RECOVERED) {
> -			pci_warn(dev, "link reset failed\n");
> +			pci_warn(dev, "subordinate device reset failed\n");
>   			goto failed;
>   		}
>   	} else {
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
