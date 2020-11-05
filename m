Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E712A75E8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 04:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgKEDGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 22:06:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:53758 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgKEDGs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 22:06:48 -0500
IronPort-SDR: J+ejqTi4MGwV/QDku4SOwSYqNhunle/7AAn+2ibXg+4zHVjTG7XUu6VVbDWhynF1jaJCYmvOYI
 X2/jJ5lsg5rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="230948029"
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="230948029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:06:47 -0800
IronPort-SDR: creYzwqhMJxDfksMCcGn4+KlP1lLdD60rEDQd8BD0sBAeNAtvwVTkJdU23DOK2/pc8eEY+4l1r
 srSldrWFw+HQ==
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="321036534"
Received: from unknown (HELO [10.252.128.230]) ([10.252.128.230])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:06:47 -0800
Subject: Re: [RFC PATCH] PCI/DPC: Fix info->id initialization in
 dpc_process_error()
To:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>,
        helgaas@kernel.org, linux-pci@vger.kernel.org
References: <20201031100121.21391-1-refactormyself@gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0f4c022a-a669-096c-d318-1e202c9eebbf@linux.intel.com>
Date:   Wed, 4 Nov 2020 19:06:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201031100121.21391-1-refactormyself@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/31/20 3:01 AM, Saheed Olayemi Bolarinwa wrote:
> From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> 
> In the dpc_process_error() path, the error source ID is obtained
> but not stored inside the aer_err_info object. So aer_print_error()
> is not aware of the error source if it gets called.
> 
> Use the obtained valued to initialise info->id
Is it useful for DPC case ? I don't think we set info->error_dev_num for
DPC case right ?

if (info->id && info->error_dev_num > 1 && info->id == id)
  726                 pci_err(dev, "  Error of this Agent is reported first\n");

> 
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
>   drivers/pci/pcie/dpc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba86a317..9f8698812939 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -223,6 +223,7 @@ void dpc_process_error(struct pci_dev *pdev)
>   	else if (reason == 0 &&
>   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>   		 aer_get_device_error_info(pdev, &info)) {
> +		info.id = source;
>   		aer_print_error(pdev, &info);
>   		pci_aer_clear_nonfatal_status(pdev);
>   		pci_aer_clear_fatal_status(pdev);
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
