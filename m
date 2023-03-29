Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B406CF679
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 00:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjC2WiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 18:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjC2WiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 18:38:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD562107;
        Wed, 29 Mar 2023 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680129485; x=1711665485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GpI3ovWk3jaue7Wbt6E0JmII9yy4esmBwePEKdUEv/A=;
  b=FknXXvkbuLSOvYlSBcq6dSIuxvXO+VNmuITRZ3u7d2NGc4Q0zkpcvgIm
   XKYH6Nn5uVrjA/jeSfQpgzQbf4y1JFfnReW4opcwtfg9WbbXfxNuZHw8e
   EhcliEb4NsS1klybgWCzMxutrGrrnAmZqSLhm4kldPOZtniy9HdjOweN+
   Mh6fjPqlLRg3xCDVPngV/uVbYTizxmjxgIWKzeI/9izv6iSP61v8U4Y4p
   onB9xEpsGa8Uaj9k4Ou+syW1Fr0J7oArYxLV4AlOoaaOC/Ko/CC5tzzdy
   KNDeGLoSUqjn9EX53PfjWKBlSQkj6mxDgevxkULeT+WL27iQWH3n5mZUk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339737229"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="339737229"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="748937807"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="748937807"
Received: from tinabao-mobl1.amr.corp.intel.com (HELO [10.209.80.72]) ([10.209.80.72])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:38:05 -0700
Message-ID: <b6fd4af3-18f7-0a7e-96e7-4ca3c4ada279@linux.intel.com>
Date:   Wed, 29 Mar 2023 15:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230329220927.GA3086137@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230329220927.GA3086137@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the review.

On 3/29/23 3:09 PM, Bjorn Helgaas wrote:
> [+cc Jonathan, author of 068c29a248b6]
> 
> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
>> OS owns AER") adds support to clear error status in the Device Status
>> Register(DEVSTA) only if OS owns the AER support. But this change
>> breaks the requirement of the EDR feature which requires OS to cleanup
>> the error registers even if firmware owns the control of AER support.
>>
>> More details about this requirement can be found in PCIe Firmware
>> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
>> If the OS supports the Error Disconnect Recover (EDR) feature and
>> firmware sends the EDR event, then during the EDR recovery window, OS
>> is responsible for the device error recovery and holds the ownership of
>> the following error registers.
>>
>> • Device Status Register
>> • Uncorrectable Error Status Register
>> • Correctable Error Status Register
>> • Root Error Status Register
>> • RP PIO Status Register
>>
>> So call pcie_clear_device_status() in edr_handle_event() if the error
>> recovery is successful.
> 
> IIUC, after ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR)
> support") appeared in v5.7-rc1, DEVSTA was always cleared in this path:
> 
>   edr_handle_event
>     pcie_do_recovery
>       pcie_clear_device_status
> 
> After 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> OS owns AER") appeared in v5.9-rc1, we only clear DEVSTA if the OS
> owns the AER Capability:
> 
>   edr_handle_event
>     pcie_do_recovery
>       if (pcie_aer_is_native(dev))      # <-- new test
>         pcie_clear_device_status
> 
> So in the case where the OS does *not* own AER, and it receives an EDR
> notification, DEVSTA is not cleared when it should be.  Right?

Correct.

> 
> I assume we should have a Fixes: tag here, since this patch should be
> backported to every kernel that contains 068c29a248b6.  Possibly even
> a stable tag, although it's arguable whether it's "critical" per
> Documentation/process/stable-kernel-rules.rst.

Yes. But this error is only reproducible in the EDR use case. So I am not sure
whether it can be considered a critical fix. 

Fixes: 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if OS owns AER")


> 
>> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
> 
> I assume this report was internal, and there's no mailing list post or
> bugzilla issue URL we can include here?

Yes.

> 
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v1:
>>  * Rebased on top of v6.3-rc1.
>>  * Fixed a typo in pcie_clear_device_status().
>>
>>  drivers/pci/pcie/edr.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index a6b9b479b97a..87734e4c3c20 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>  	 */
>>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>>  		pci_dbg(edev, "DPC port successfully recovered\n");
>> +		pcie_clear_device_status(edev);
> 
> It's a little weird to work around a change inside pcie_do_recovery()
> by clearing it here, and that means we clear it twice in the AER
> native case, but I don't see any simpler way to do this, so this seems
> fine as the fix for the current issue.

In AER native case, edr_handle_event() will never be triggered. So it
won't be cleared twice.

Other way is to add a new parameter to pcie_do_recovery(..., edr) and use
it to conditionally call pcie_clear_device_status(). But I think current
way is less complex.

edr_handle_event
  pcie_do_recovery(..., edr=1)
    if (pcie_aer_is_native(dev) || edr)
      pcie_clear_device_status

> 
> Question though: in the AER native case, pcie_do_recovery() calls
> both:
> 
>   pcie_clear_device_status() and
>   pci_aer_clear_nonfatal_status()
> 
> In this patch, you only call pcie_clear_device_status().  Do you care
> about pci_aer_clear_nonfatal_status(), too?

Yes, we care about it. Since we call dpc_process_error() in EDR handler,
it will eventually clear error status via pci_aer_clear_nonfatal_status()
and pci_aer_clear_fatal_status() within dpc_process_error().

> 
> The overall design for clearing status has gotten pretty complicated
> as we've added error handling methods (firmware-first, DPC, EDR), and
> there are so many different places and cases that it's hard to be sure
> we do them all correctly.
> 
> I don't really know how to clean this up, so I'm just attaching my
> notes about the current state:

Good summary! I can see a lot of overlap in clearing
PCI_ERR_UNCOR_STATUS and PCI_EXP_DEVSTA.

> 
>   - AER native handling:
> 
>     handle_error_source
>       if (info->severity == AER_CORRECTABLE)
>         clear PCI_ERR_COR_STATUS              <--
>         if (pcie_aer_is_native(dev))
>           pdrv->err_handler->cor_error_detected()
>           pcie_clear_device_status
>             clear PCI_EXP_DEVSTA              <--
>       else
>         pcie_do_recovery
>           pcie_clear_device_status
>             clear PCI_EXP_DEVSTA              <--
>           pci_aer_clear_nonfatal_status
>             clear PCI_ERR_UNCOR_STATUS        <--
> 
>   - Firmware-first handling: status is cleared by firmware before
>     event is reported to OS via HEST
> 
>   - DPC native handling:
> 
>     dpc_handler
>       dpc_process_error
>         if (rp_extensions)
>           dpc_process_rp_pio_error
>             clear PCI_EXP_DPC_RP_PIO_STATUS   <--
>         else if (...)
>           pci_aer_clear_nonfatal_status
>             clear PCI_ERR_UNCOR_STATUS        <--
>           pci_aer_clear_fatal_status
>             clear PCI_ERR_UNCOR_STATUS        <--
>       pcie_do_recovery
>         if (AER native)
>           pcie_clear_device_status
>             clear PCI_EXP_DEVSTA              <--
>           pci_aer_clear_nonfatal_status
>             clear PCI_ERR_UNCOR_STATUS        <--
> 
>   - EDR event handling:
> 
>     edr_handle_event
>       dpc_process_error
>         if (rp_extensions)
>           dpc_process_rp_pio_error
>             clear PCI_EXP_DPC_RP_PIO_STATUS   <--
>         else if (...)
>           pci_aer_clear_nonfatal_status
>             clear PCI_ERR_UNCOR_STATUS        <--
>           pci_aer_clear_fatal_status
>             clear PCI_ERR_UNCOR_STATUS        <--
>       pci_aer_raw_clear_status
>         clear PCI_ERR_ROOT_STATUS             <--
>         clear PCI_ERR_COR_STATUS              <--
>         clear PCI_ERR_UNCOR_STATUS            <--
>       pcie_do_recovery
>         if (AER native)
>           pcie_clear_device_status
>             clear PCI_EXP_DEVSTA              <--
>           pci_aer_clear_nonfatal_status
>             clear PCI_ERR_UNCOR_STATUS        <--
>       if (PCI_ERS_RESULT_RECOVERED)
>         pcie_clear_device_status
>           clear PCI_EXP_DEVSTA                <--
> 
>>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
>>  	} else {
>>  		pci_dbg(edev, "DPC port recovery failed\n");
>> -- 
>> 2.34.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
