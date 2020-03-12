Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65906183BE1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCLWEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 18:04:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:40625 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgCLWEd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 18:04:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 15:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; 
   d="scan'208";a="277987570"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2020 15:04:32 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 0C64C58010D;
        Thu, 12 Mar 2020 15:04:32 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200312215230.GA195113@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <e710fd4c-4c0e-448a-6791-beed334536ce@linux.intel.com>
Date:   Thu, 12 Mar 2020 15:02:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312215230.GA195113@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/12/20 2:52 PM, Bjorn Helgaas wrote:
> On Thu, Mar 12, 2020 at 02:29:58PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Hi,
>>
>> On 3/12/20 2:02 PM, Austin.Bolen@dell.com wrote:
>>> On 3/12/2020 2:53 PM, Bjorn Helgaas wrote:
>>>> On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>>> On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
>>>>>> Is any synchronization needed here between the EDR path and the
>>>>>> hotplug/enumeration path?
>>>>> If we want to follow the implementation note step by step (in
>>>>> sequence) then we need some synchronization between EDR path and
>>>>> enumeration path. But if it's OK to achieve the same end result by
>>>>> following steps out of sequence then we don't need to create any
>>>>> dependency between EDR and enumeration paths. Currently we follow
>>>>> the latter approach.
>>>> What would the synchronization look like?
>>>>
>>>> Ideally I think it would be better to follow the order in the
>>>> flowchart if it's not too onerous.  That will make the code easier to
>>>> understand.  The current situation with this dependency on pciehp and
>>>> what it will do leaves a lot of things implicit.
>>>>
>>>> What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
>>>>
>>>> IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
>>>> unbinds the drivers and removes the devices.  If that doesn't happen,
>>>> and Linux clears the DPC trigger to bring the link back up, will those
>>>> drivers try to operate uninitialized devices?
>>>>
>>>> Does EDR need a dependency on CONFIG_HOTPLUG_PCI_PCIE?
>>>    From one of Sathya's other responses:
>>>
>>> "If hotplug is not supported then there is support to enumerate
>>> devices via polling  or ACPI events. But a point to note
>>> here is, enumeration path is independent of error handler path, and
>>> hence there is no explicit trigger or event from error handler path
>>> to enumeration path to kick start the enumeration."
>>>
>>> The EDR standard doesn't have any dependency on hot-plug. It sounds like
>>> in the current implementation there's some manual intervention needed if
>>> hot-plug is not supported?
>> No, there is no need for manual intervention even in non hotplug
>> cases.
>>
>> For ACPI events case, we would rely on ACPI event to kick start the
>> enumeration.  And for polling model, there is an independent polling
>> thread which will kick start the enumeration.
> I'm guessing the ACPI case works via hotplug_is_native(): if
> CONFIG_HOTPLUG_PCI_PCIE=n, pciehp_is_native() returns false, and
> acpiphp manages hotplug.
>
> What if CONFIG_HOTPLUG_PCI_ACPI=n also?
If none of the auto scans are enabled then we might need some
manual trigger ( rescan). But this would be needed in native
DPC case as well.
>
> Where is the polling thread?
drivers/pci/hotplug/pciehp_hpc.c
>
>> Above both enumeration models are totally independent and has
>> no dependency on error handler thread.
> I see they're currently independent from the EDR thread, but it's not
> clear to me that there's no dependency.  After all, both EDR and the
> hotplug paths are operating on the same devices at roughly the same
> time, so we should have some story about what keeps them from getting
> in each other's way.
>
>> We will decide which model to use based on hardware capability and
>> _OSC negotiation or kernel command line option.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

