Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DCF6DB65B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDGWTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDGWTf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 18:19:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182447ECB;
        Fri,  7 Apr 2023 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680905974; x=1712441974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6DSVlaos7BHVUBQVGsySr1TyxGXHaJWFPPV4zCk0y/o=;
  b=Z4p61XBXzV06I5sO1fodWA68/ydDY7IqGepz1tmkS3+vcyyOKp9WLUR1
   RXgejcT7W8nqWPRbn+MObuDxzDwBsegLWvFU8j3aMxjdsTGnKy8P4D+wW
   rqTFVA2YtJG5E7Cd3IGgJsKlHfCz/DcesXFqVK4ZYCffK6iJtcEVr2owf
   corG68x0BTyiouZgB/iJmg1gePZ1gCqNS9qBUbQb3l8zkiAf7MFvux7iv
   3bCeDhDOOV0JFTdPqbJWqmDC3jxImdUeOJpjmY/NEWXk6siRZ+U1NI/1c
   O/H3tP1HLLcPTHA3nI5rYZQJ0F8ih1A53/fS33I1vw3dJZ0x4R+yoQSvb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="405900650"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="405900650"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 15:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="811530332"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="811530332"
Received: from ssingh6-mobl2.amr.corp.intel.com (HELO [10.212.218.166]) ([10.212.218.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 15:19:33 -0700
Message-ID: <cc7cc268-f614-beaf-da5a-a4db9137c38a@linux.intel.com>
Date:   Fri, 7 Apr 2023 15:19:32 -0700
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
References: <20230407164615.GA3802863@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230407164615.GA3802863@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 4/7/23 9:46 AM, Bjorn Helgaas wrote:
> On Thu, Apr 06, 2023 at 10:31:20PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 4/6/23 3:21 PM, Bjorn Helgaas wrote:
>>> On Thu, Apr 06, 2023 at 02:52:02PM -0700, Sathyanarayanan Kuppuswamy wrote:
>>>> On 4/6/23 2:07 PM, Bjorn Helgaas wrote:
>>>>> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>>>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
>>>>>> OS owns AER") adds support to clear error status in the Device Status
>>>>>> Register(DEVSTA) only if OS owns the AER support. But this change
>>>>>> breaks the requirement of the EDR feature which requires OS to cleanup
>>>>>> the error registers even if firmware owns the control of AER support.
>>>>>>
>>>>>> More details about this requirement can be found in PCIe Firmware
>>>>>> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
>>>>>> If the OS supports the Error Disconnect Recover (EDR) feature and
>>>>>> firmware sends the EDR event, then during the EDR recovery window, OS
>>>>>> is responsible for the device error recovery and holds the ownership of
>>>>>> the following error registers.
>>>>>>
>>>>>> • Device Status Register
>>>>>> • Uncorrectable Error Status Register
>>>>>> • Correctable Error Status Register
>>>>>> • Root Error Status Register
>>>>>> • RP PIO Status Register
>>>>>>
>>>>>> So call pcie_clear_device_status() in edr_handle_event() if the error
>>>>>> recovery is successful.
>>>>>>
>>>>>> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
>>>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>>> ---
>>>>>>
>>>>>> Changes since v1:
>>>>>>  * Rebased on top of v6.3-rc1.
>>>>>>  * Fixed a typo in pcie_clear_device_status().
>>>>>>
>>>>>>  drivers/pci/pcie/edr.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>>>>>> index a6b9b479b97a..87734e4c3c20 100644
>>>>>> --- a/drivers/pci/pcie/edr.c
>>>>>> +++ b/drivers/pci/pcie/edr.c
>>>>>> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>>>>>  	 */
>>>>>>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>>>>>>  		pci_dbg(edev, "DPC port successfully recovered\n");
>>>>>> +		pcie_clear_device_status(edev);
>>>>>>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
>>>>>
>>>>> The implementation note in PCI Firmware r3.3, sec 4.6.12, shows the OS
>>>>> clearing error status *after* _OST is evaluated.
>>>>>
>>>>> On the other hand, the _OSC DPC control bit in table 4-6 says that if
>>>>> the OS does not have DPC control, it can only write the Device Status
>>>>> error bits between the EDR Notify and invoking _OST.
>>>>>
>>>>> Is one of those wrong, or am I missing something?
>>>>
>>>> Agree. It is conflicting info. IMO, the argument that the OS is allowed to
>>>> clear the error registers during the EDR windows makes more sense. If OS
>>>> is allowed to touch error registers owned by firmware after that window,
>>>> it would lead to race conditions.
>>>>
>>>> Mahesh, let us know your comments. Maybe we need to fix this in the firmware
>>>> specification.
>>>
>>> My assumption was this sequence is something like this, where firmware
>>> *can't* collect error status from devices below the Downstream Port
>>> because DPC has been triggered and they are not accessible:
>>>
>>>   - Hardware triggers DPC in a Downstream Port
>>>   - Firmware fields error interrupt
>>>   - Firmware captures Downstream Port error info (devices below are
>>>     not accessible because of DPC)
>>>   - Firmware sends EDR Notify to OS
>>>   - OS brings Downstream Port out of DPC
>>>   - OS collects error status from devices below Downstream Port
>>>   - OS evaluates _OST
>>>   - Firmware captures error status from devices below Downstream Port
>>>
>>> But that doesn't explain why *firmware* could not clear the error
>>> status of those devices after it captures it.
>>>
>>> I guess the flowchart *does* show firmware clearing the error status
>>> in the "do not continue recovery" path.
>>
>> In this patch, we are clearing the port error status. So I think it is
>> fine to do it in EDR window. Agree?
> 
> Ah, right, of course, thanks for pulling me back out of the weeds!
> Yes, I do agree.

Thanks.

> 
> An EDR notification is issued on a bus device that is still present,
> i.e., a DPC port or parent, but child devices have been disconnected
> (ACPI v6.3, sec 5.6.6).

IMO, instead of bus device, we can call it as root port or down stream
port. Please check the PCI firmware specification, r3.3, section 4.3.13.

Firmware may wish to issue Error Disconnect Recover notification on a port
that is parent of the port that experienced the containment event.

So it is either a downstream port or a root port.

> 
> So in edr_handle_event(), pdev is the bus device that receives the
> notification, edev is a bus device (possibly the same as pdev, or
> possibly a child, but one that is still present), and child devices of
> edev have been disconnected.
> 
> Prior to 068c29a248b6, pcie_do_recovery(edev) always cleared DEVSTA
> for edev.  Afterwards it only clears DEVSTA if the OS owns AER.  This
> patch makes edr_handle_event() clear DEVSTA for edev (the Port
> device).
> 
> I had been looking at the bottom blue OS "Clear error status, ..." box
> in the PCI Firmware implementation note, but that's the wrong one.
> This is actually the "Clear port error status, bring Port out of DPC,
> ..." box higher up.  That's clearly before _OST and thus inside the
> window.

Correct.

> 
> That box *does* suggest clearing the port error status before bringing
> the port out of DPC, and we're doing it in the opposite order:
> 
>   edr_handle_event(pdev)
>     edev = acpi_dpc_port_get(pdev)
>     # Both pdev and edev are present; pdev is same as edev or a
>     # parent of edev; children of edev are disconnected
>     dpc_process_error(edev)
>     pcie_do_recovery(edev, dpc_reset_link)
>       if (state == pci_channel_io_frozen)
>         dpc_reset_link                  # (reset_subordinates)
>           pci_write_config_word(PCI_EXP_DPC_STATUS_TRIGGER) # exit DPC
>       if (AER native)
>         pcie_clear_device_status(edev)
>           clear PCI_EXP_DEVSTA          # doesn't happen
>     if (PCI_ERS_RESULT_RECOVERED)
>       pcie_clear_device_status
>         clear PCI_EXP_DEVSTA            # added by this patch
> 
> Does it matter?  I dunno, but I don't *think* so.  We really don't
> care about the value of PCI_EXP_DEVSTA anywhere except
> pci_wait_for_pending_transaction(), which isn't applicable here.  And
> I don't think the fact that it probably has an Error Detected bit set
> when exiting DPC is a problem.

Agree that it is not a fatal issue. But leaving the stale error state
is something that needs to be fixed.

> 
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
