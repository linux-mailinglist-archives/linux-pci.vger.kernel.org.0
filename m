Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE596B1668
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 00:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCHXRq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 18:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHXRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 18:17:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901836425F;
        Wed,  8 Mar 2023 15:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678317464; x=1709853464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sug+GHVZucDNAK16IdE3wvx1ebCCm01/Zjw8vc4FhGk=;
  b=YchA4QTcFIUdu4RfgaY19kSGMLrVHZFzlFBr08iEKmeIXFfNqDo87LBx
   4OwZjZ0aPyJiIljMcvOKSO8AGD++KBFRrduJV6CV6EWa3O51GWwsDMW7z
   btLTEZeW9ZE4OGfVqMHw1RgAYDkiFMXvRAfwDfyV7WvkqhxVpKjE0I4qd
   tKxscDbceb9RPCbNPNLIBfTsj0zxssQB2dvHrVfp6TdqpUuwFblju7z+F
   oau+sv8jYMTRFhBbvmHz8HyQAbaBcL3AeQst16h9r7vKRAE4UTcGadSrx
   AMJF1Ec5t99hhhvzxNZVtT61JYSjc/XK6D4a3BHFP8JxzJOQBey6VqTYb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="401132236"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="401132236"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 15:17:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="670511809"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="670511809"
Received: from mcastane-mobl1.amr.corp.intel.com (HELO [10.212.187.9]) ([10.212.187.9])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 15:17:43 -0800
Message-ID: <5fd1b1c2-c0b4-e93d-819b-61b2968fec6c@linux.intel.com>
Date:   Wed, 8 Mar 2023 15:17:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230215200532.3126937-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230215200532.3126937-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Gentle ping!

On 2/15/23 12:05 PM, Kuppuswamy Sathyanarayanan wrote:
> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> OS owns AER") adds support to clear error status in the Device Status
> Register(DEVSTA) only if OS owns the AER support. But this change
> breaks the requirement of the EDR feature which requires OS to cleanup
> the error registers even if firmware owns the control of AER support.
> 
> More details about this requirement can be found in PCIe Firmware
> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
> If the OS supports the Error Disconnect Recover (EDR) feature and
> firmware sends the EDR event, then during the EDR recovery window, OS
> is responsible for the device error recovery and holds the ownership of
> the following error registers.
> 
> • Device Status Register
> • Uncorrectable Error Status Register
> • Correctable Error Status Register
> • Root Error Status Register
> • RP PIO Status Register
> 
> So call pcie_clear_device_status() in edr_handle_event() if the error
> recovery is successful.

Any comments on this patch?

> 
> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/edr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index a6b9b479b97a..33d7776ea748 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  	 */
>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>  		pci_dbg(edev, "DPC port successfully recovered\n");
> +		pcie_clear_device_status(dev);
>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
>  	} else {
>  		pci_dbg(edev, "DPC port recovery failed\n");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
