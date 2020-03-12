Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C324183B57
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 22:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCLVcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 17:32:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:36118 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgCLVcY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 17:32:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 14:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; 
   d="scan'208";a="232205234"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2020 14:32:23 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 99C3658010D;
        Thu, 12 Mar 2020 14:32:23 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Austin.Bolen@dell.com, helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200312195319.GA162308@google.com>
 <161a5d15809b47b09200f1806484b907@AUSX13MPC107.AMER.DELL.COM>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <f07d850f-473f-6fa0-81f3-b38a104a5e86@linux.intel.com>
Date:   Thu, 12 Mar 2020 14:29:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <161a5d15809b47b09200f1806484b907@AUSX13MPC107.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/12/20 2:02 PM, Austin.Bolen@dell.com wrote:
> On 3/12/2020 2:53 PM, Bjorn Helgaas wrote:
>> [EXTERNAL EMAIL]
>>
>> On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
>>>> Is any synchronization needed here between the EDR path and the
>>>> hotplug/enumeration path?
>>> If we want to follow the implementation note step by step (in
>>> sequence) then we need some synchronization between EDR path and
>>> enumeration path. But if it's OK to achieve the same end result by
>>> following steps out of sequence then we don't need to create any
>>> dependency between EDR and enumeration paths. Currently we follow
>>> the latter approach.
>> What would the synchronization look like?
>>
>> Ideally I think it would be better to follow the order in the
>> flowchart if it's not too onerous.  That will make the code easier to
>> understand.  The current situation with this dependency on pciehp and
>> what it will do leaves a lot of things implicit.
>>
>> What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
>>
>> IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
>> unbinds the drivers and removes the devices.  If that doesn't happen,
>> and Linux clears the DPC trigger to bring the link back up, will those
>> drivers try to operate uninitialized devices?
>>
>> Does EDR need a dependency on CONFIG_HOTPLUG_PCI_PCIE?
>   From one of Sathya's other responses:
>
> "If hotplug is not supported then there is support to enumerate
> devices via polling  or ACPI events. But a point to note
> here is, enumeration path is independent of error handler path, and
> hence there is no explicit trigger or event from error handler path
> to enumeration path to kick start the enumeration."
>
> The EDR standard doesn't have any dependency on hot-plug. It sounds like
> in the current implementation there's some manual intervention needed if
> hot-plug is not supported?
No, there is no need for manual intervention even in non hotplug
cases.

For ACPI events case, we would rely on ACPI event to kick start the
enumeration.  And for polling model, there is an independent polling
thread which will kick start the enumeration.

Above both enumeration models are totally independent and has
no dependency on error handler thread.

We will decide which model to use based on hardware capability and
_OSC negotiation or kernel command line option.
> Ideally recovery would kick in automatically
> but requiring manual intervention is a good first step.
>
>>> For example, consider the case in flow chart where after sending
>>> success _OST, firmware decides to stop the recovery of the device.
>>>
>>> if we follow the flow chart as is then the steps should be,
>>>
>>> 1. clear the DPC status trigger
>>> 2. Send success code via _OST, and wait for return from _OST
>>> 3. if successful return then enumerate the child devices and
>>> reassign bus numbers.
>>>
>>> In current approach the steps followed are,
>>>
>>> 1. Clear the DPC status trigger.
>>> 2. Send success code via _OST
> Success in step 2 is assuming device trained and config space is
> accessible correct?
yes. we send success code only if the link is trained and on.
> If device was removed or device config space is not
> accessible then failure status should be sent via _OST.
yes.
>
>>> 2. In parallel, LINK UP event path will enumerate the child devices.
>>> 3. if firmware decides not to recover the device, then LINK DOWN
>>> event will eventually remove them again.
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

