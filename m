Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA442A35BE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBVDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 16:03:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:13122 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgKBVDu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 16:03:50 -0500
IronPort-SDR: FAPs1q039TcIJvoHedofd9Nry6pQhzSrM2NXbHhhbNQhU0lIaFDMXE1M8hVgrBXbfbzeXk/aaM
 Lbqwy6ZbmUgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="169054654"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="169054654"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 13:03:49 -0800
IronPort-SDR: cjrnBwfD6Cv0W1Cz1TfVFi4CFmmoEBQHoWx4+PHz5rGHbHzIDZrG0kqS3y+ykElKjFj1P9S+z/
 PRdK287dMjig==
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="470521444"
Received: from lginuga-mobl.amr.corp.intel.com (HELO [10.255.228.220]) ([10.255.228.220])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 13:03:49 -0800
Subject: Re: [PATCH v4 5/6] PCI/ACPI: Replace open coded variant of
 resource_union()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
 <20201102210025.53520-6-andriy.shevchenko@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <510543c4-0abe-7582-32cd-404656e818d8@linux.intel.com>
Date:   Mon, 2 Nov 2020 13:03:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102210025.53520-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/2/20 1:00 PM, Andy Shevchenko wrote:
> Since we have resource_union() helper, let's utilize it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/acpi/pci_root.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index c12b5fb3e8fb..0bf072cef6cf 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -722,9 +722,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>   			 * our resources no longer match the ACPI _CRS, but
>   			 * the kernel resource tree doesn't allow overlaps.
>   			 */
> -			if (resource_overlaps(res1, res2)) {
> -				res2->start = min(res1->start, res2->start);
> -				res2->end = max(res1->end, res2->end);
> +			if (resource_union(res1, res2, res2)) {
>   				dev_info(dev, "host bridge window expanded to %pR; %pR ignored\n",
>   					 res2, res1);
>   				free = true;
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
