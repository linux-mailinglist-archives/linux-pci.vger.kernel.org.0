Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AF183BD7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLWBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 18:01:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:57083 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgCLWBl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 18:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 15:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; 
   d="scan'208";a="354231414"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2020 15:01:40 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 7A42A58033E;
        Thu, 12 Mar 2020 15:01:40 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200312195319.GA162308@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <951fc29a-1462-ef46-d9a2-5e1cd50bf90a@linux.intel.com>
Date:   Thu, 12 Mar 2020 14:59:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312195319.GA162308@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/12/20 12:53 PM, Bjorn Helgaas wrote:
> On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
>>> Is any synchronization needed here between the EDR path and the
>>> hotplug/enumeration path?
>> If we want to follow the implementation note step by step (in
>> sequence) then we need some synchronization between EDR path and
>> enumeration path. But if it's OK to achieve the same end result by
>> following steps out of sequence then we don't need to create any
>> dependency between EDR and enumeration paths. Currently we follow
>> the latter approach.
> What would the synchronization look like?
we might need some way to disable the enumeration path till
we get response from firmware.

In native hot plug case, I think we can do it in two ways.

1. Disable hotplug notification in slot ctl registers.
     (pcie_disable_notification())
2. Some how block hotplug driver from processing the new
     events (not sure how feasible its).

Following method 1 would be easy, But I am not sure whether
its alright to disable them randomly. I think, unless we
clear the status as well, we might get some issues due to stale
notification history.

For ACPI event case, I am not sure whether we have some
communication protocol in place to disable receiving ACPI
events temporarily.

For polling model, we need to disable to the polling
timer thread till we receive _OST response from firmware.
>
> Ideally I think it would be better to follow the order in the
> flowchart if it's not too onerous.
None of the above changes will be pretty and I think it will
not be simple as well.
>   That will make the code easier to
> understand.  The current situation with this dependency on pciehp and
> what it will do leaves a lot of things implicit.
>
> What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
>
> IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
> unbinds the drivers and removes the devices.

>   If that doesn't happen,
> and Linux clears the DPC trigger to bring the link back up, will those
> drivers try to operate uninitialized devices?
I don't think this will happen. In DPC reset_link before we bring
up the device we wait for link to go down first
using pcie_wait_for_link(pdev, false) function.
>
> Does EDR need a dependency on CONFIG_HOTPLUG_PCI_PCIE?
No, enumeration can happen other ways as well (ACPI events, polling, etc).
>
>> For example, consider the case in flow chart where after sending
>> success _OST, firmware decides to stop the recovery of the device.
>>
>> if we follow the flow chart as is then the steps should be,
>>
>> 1. clear the DPC status trigger
>> 2. Send success code via _OST, and wait for return from _OST
>> 3. if successful return then enumerate the child devices and
>> reassign bus numbers.
>>
>> In current approach the steps followed are,
>>
>> 1. Clear the DPC status trigger.
>> 2. Send success code via _OST
>> 2. In parallel, LINK UP event path will enumerate the child devices.
>> 3. if firmware decides not to recover the device, then LINK DOWN
>> event will eventually remove them again.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

