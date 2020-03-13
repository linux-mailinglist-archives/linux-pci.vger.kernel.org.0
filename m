Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841151840D5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 07:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgCMGWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 02:22:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:23735 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgCMGWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 02:22:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 23:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,547,1574150400"; 
   d="scan'208";a="416195912"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.251.228.67]) ([10.251.228.67])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 23:22:14 -0700
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200312223222.GA200236@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4d06c72d-7f77-84d5-4163-187bc62b903a@linux.intel.com>
Date:   Thu, 12 Mar 2020 23:22:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312223222.GA200236@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/12/2020 3:32 PM, Bjorn Helgaas wrote:
> On Thu, Mar 12, 2020 at 02:59:15PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Hi Bjorn,
>>
>> On 3/12/20 12:53 PM, Bjorn Helgaas wrote:
>>> On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>> On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
>>>>> Is any synchronization needed here between the EDR path and the
>>>>> hotplug/enumeration path?
>>>> If we want to follow the implementation note step by step (in
>>>> sequence) then we need some synchronization between EDR path and
>>>> enumeration path. But if it's OK to achieve the same end result by
>>>> following steps out of sequence then we don't need to create any
>>>> dependency between EDR and enumeration paths. Currently we follow
>>>> the latter approach.
>>> What would the synchronization look like?
>> we might need some way to disable the enumeration path till
>> we get response from firmware.
>>
>> In native hot plug case, I think we can do it in two ways.
>>
>> 1. Disable hotplug notification in slot ctl registers.
>>      (pcie_disable_notification())
>> 2. Some how block hotplug driver from processing the new
>>      events (not sure how feasible its).
>>
>> Following method 1 would be easy, But I am not sure whether
>> its alright to disable them randomly. I think, unless we
>> clear the status as well, we might get some issues due to stale
>> notification history.
>>
>> For ACPI event case, I am not sure whether we have some
>> communication protocol in place to disable receiving ACPI
>> events temporarily.
>>
>> For polling model, we need to disable to the polling
>> timer thread till we receive _OST response from firmware.
>>>
>>> Ideally I think it would be better to follow the order in the
>>> flowchart if it's not too onerous.
>> None of the above changes will be pretty and I think it will
>> not be simple as well.
>>>    That will make the code easier to
>>> understand.  The current situation with this dependency on pciehp and
>>> what it will do leaves a lot of things implicit.
>>>
>>> What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
>>>
>>> IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
>>> unbinds the drivers and removes the devices.
>>
>>>   If that doesn't happen, and Linux clears the DPC trigger to bring
>>>   the link back up, will those drivers try to operate uninitialized
>>>   devices?
>>
>> I don't think this will happen. In DPC reset_link before we bring up
>> the device we wait for link to go down first using
>> pcie_wait_for_link(pdev, false) function.
> 
> I understand that, but these child devices were reset when DPC
> disabled the link.  When the link comes back up, their BARs contain
> zeros.
> 
> If CONFIG_HOTPLUG_PCI_PCIE=y, the DLLSC interrupt will cause pciehp to
> unbind the driver.  It seems like the unbind races with the EDR notify
> handler. '

Agree. But even if there is a race condition, after clearing DPC trigger
status, if hotplug driver properly removes/re-enumerates the driver then
the end result will still be same. There should be no functional impact.

  If pciehp unbinds the driver before edr_handle_event() calls
> pcie_do_recovery(), this seems fine -- we'll call dpc_reset_link(),
> which brings up the link, we won't call any driver callbacks because
> there's no driver, and another DLLSC interrupt will cause pciehp to
> re-enumerate, which will re-initialize the device, then rebind the
> driver.
> 
> If the EDR notify handler runs before pciehp unbinds the driver,
In the above case, from the kernel perspective device is still 
accessible and IIUC, it will try to recover it in pcie_do_recovery()
using one of the callbacks.

int (*mmio_enabled)(struct pci_dev *dev);
int (*slot_reset)(struct pci_dev *dev);
void (*resume)(struct pci_dev *dev);

One of these callbacks will do pci_restore_state() to restore the
device, and IO will not attempted in these callbacks until the device
is successfully recovered.

> couldn't EDR bring up the link and call driver .mmio_enabled() before
> the device has been initialized?
Calling mmio_enabled in this case should not be a problem right ?

Please check the following content from 
Documentation/PCI/pci-error-recovery.rst. IIUC (following content), IO 
will not be attempted until
the device is successfully re-configured.

STEP 2: MMIO Enabled
--------------------
This callback is made if all drivers on a segment agree that they can
try to recover and if no automatic link reset was performed by the HW.
If the platform can't just re-enable IOs without a slot reset or a link
reset, it will not call this callback, and instead will have gone
directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)


> 
> If CONFIG_HOTPLUG_PCI_PCIE=n and CONFIG_HOTPLUG_PCI_ACPI=y, I could
> believe that the situations are similar to the above.
> 
> What if CONFIG_HOTPLUG_PCI_PCIE=n and CONFIG_HOTPLUG_PCI_ACPI=n?  Then
> I assume there's nothing to unbind the driver, so pcie_do_recovery()
> will call the driver .mmio_enabled() and other recovery callbacks on a
> device that hasn't been initialized?

probably in .slot_reset() callback device config will be restored and it
will make the device functional again.

Also since in above case hotplug is not supported, topology change will
not be supported.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
