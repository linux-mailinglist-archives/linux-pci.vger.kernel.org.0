Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7CA2B6FCD
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 21:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbgKQULc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 15:11:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:46452 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgKQULa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 15:11:30 -0500
IronPort-SDR: JE8O67fg1jAPcxVb5m1fMoXduGaffjKNN3TYUYgCT2QlipTggWPxuNC6O9wC5Ft19bXn5t8rWO
 v0tfRzxOh/Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158775999"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158775999"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:11:30 -0800
IronPort-SDR: UiI97zKusUtzHTje+aBHIAjU+aOkuuk3tFn3Y+iCiRXZagpqlayuTrPm+mEDchuAR9zzGGSpLB
 xBFjx5nYNkEQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544192746"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:11:29 -0800
Subject: Re: [PATCH v11 06/16] PCI/ERR: Simplify by using
 pci_upstream_bridge()
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-7-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9df63e69-4ef0-9560-68c4-d3f4130b965c@linux.intel.com>
Date:   Tue, 17 Nov 2020 12:11:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-7-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/20 11:19 AM, Sean V Kelley wrote:
> Use pci_upstream_bridge() in place of dev->bus->self.  No functional change
> intended.
> 
> [bhelgaas: split to separate patch]
> Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pcie/err.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index db149c6ce4fb..05f61da5ed9d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -159,7 +159,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	 */
>   	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>   	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> -		dev = dev->bus->self;
> +		dev = pci_upstream_bridge(dev);
Makes it easier to read.
>   	bus = dev->subordinate;
>   
>   	pci_dbg(dev, "broadcast error_detected message\n");
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
