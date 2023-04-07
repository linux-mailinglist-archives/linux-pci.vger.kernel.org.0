Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC6C6DA880
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 07:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjDGFb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 01:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDGFbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 01:31:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52EA276;
        Thu,  6 Apr 2023 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680845481; x=1712381481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BzrHG8kA7JDXpMW7eSiFK9ffQIbGPJr8XjUS+y6nfIs=;
  b=YT7XQ9Ve+dQ2IXDNBysdVNB7f/JvhGeBZ7ISaeW+77pXGAZIItbhYOYB
   ckiyB5Op73LiDMqRHCLTGwhDIVx46rWM9E0s7YqonWAtjAgZUlblwrDpk
   iuXd4eG2lbQy7HE9QnwKTm2pzBdS1XTDz7RII7tIyal5P7aRezj5n4gKe
   kFu3CUHoYn+OKLlLMekeolFfwiddBqvHVbJ1L8vs6W1EAkPcxonoaOzL7
   8/G/+g9/oyA159/7RfK3Lk3Y5L7zWLmTpbGZtMuXh+4mYpSeLeKIUKePx
   4SuR8AQLViClDWupbS/qtS+EBsaaaZB9DFQqWv8oZLTchDQizVq5bp76q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="322572524"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="322572524"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 22:31:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="798594289"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="798594289"
Received: from iban-mobl1.amr.corp.intel.com (HELO [10.212.231.125]) ([10.212.231.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 22:31:21 -0700
Message-ID: <18ccb5e6-0bc3-82ab-0c54-653ccd994c7b@linux.intel.com>
Date:   Thu, 6 Apr 2023 22:31:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Natu, Mahesh" <mahesh.natu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406222135.GA3743643@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230406222135.GA3743643@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 4/6/23 3:21 PM, Bjorn Helgaas wrote:
> On Thu, Apr 06, 2023 at 02:52:02PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 4/6/23 2:07 PM, Bjorn Helgaas wrote:
>>> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
>>>> OS owns AER") adds support to clear error status in the Device Status
>>>> Register(DEVSTA) only if OS owns the AER support. But this change
>>>> breaks the requirement of the EDR feature which requires OS to cleanup
>>>> the error registers even if firmware owns the control of AER support.
>>>>
>>>> More details about this requirement can be found in PCIe Firmware
>>>> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
>>>> If the OS supports the Error Disconnect Recover (EDR) feature and
>>>> firmware sends the EDR event, then during the EDR recovery window, OS
>>>> is responsible for the device error recovery and holds the ownership of
>>>> the following error registers.
>>>>
>>>> • Device Status Register
>>>> • Uncorrectable Error Status Register
>>>> • Correctable Error Status Register
>>>> • Root Error Status Register
>>>> • RP PIO Status Register
>>>>
>>>> So call pcie_clear_device_status() in edr_handle_event() if the error
>>>> recovery is successful.
>>>>
>>>> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> ---
>>>>
>>>> Changes since v1:
>>>>  * Rebased on top of v6.3-rc1.
>>>>  * Fixed a typo in pcie_clear_device_status().
>>>>
>>>>  drivers/pci/pcie/edr.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>>>> index a6b9b479b97a..87734e4c3c20 100644
>>>> --- a/drivers/pci/pcie/edr.c
>>>> +++ b/drivers/pci/pcie/edr.c
>>>> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>>>  	 */
>>>>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>>>>  		pci_dbg(edev, "DPC port successfully recovered\n");
>>>> +		pcie_clear_device_status(edev);
>>>>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
>>>
>>> The implementation note in PCI Firmware r3.3, sec 4.6.12, shows the OS
>>> clearing error status *after* _OST is evaluated.
>>>
>>> On the other hand, the _OSC DPC control bit in table 4-6 says that if
>>> the OS does not have DPC control, it can only write the Device Status
>>> error bits between the EDR Notify and invoking _OST.
>>>
>>> Is one of those wrong, or am I missing something?
>>
>> Agree. It is conflicting info. IMO, the argument that the OS is allowed to
>> clear the error registers during the EDR windows makes more sense. If OS
>> is allowed to touch error registers owned by firmware after that window,
>> it would lead to race conditions.
>>
>> Mahesh, let us know your comments. Maybe we need to fix this in the firmware
>> specification.
> 
> My assumption was this sequence is something like this, where firmware
> *can't* collect error status from devices below the Downstream Port
> because DPC has been triggered and they are not accessible:
> 
>   - Hardware triggers DPC in a Downstream Port
>   - Firmware fields error interrupt
>   - Firmware captures Downstream Port error info (devices below are
>     not accessible because of DPC)
>   - Firmware sends EDR Notify to OS
>   - OS brings Downstream Port out of DPC
>   - OS collects error status from devices below Downstream Port
>   - OS evaluates _OST
>   - Firmware captures error status from devices below Downstream Port
> 
> But that doesn't explain why *firmware* could not clear the error
> status of those devices after it captures it.
> 
> I guess the flowchart *does* show firmware clearing the error status
> in the "do not continue recovery" path.

In this patch, we are clearing the port error status. So I think it is
fine to do it in EDR window. Agree?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
