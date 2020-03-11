Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3302D182486
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 23:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgCKWNc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 18:13:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:39445 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbgCKWNc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 18:13:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="234841308"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 11 Mar 2020 15:13:31 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 4F4B758033E;
        Wed, 11 Mar 2020 15:13:31 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Austin.Bolen@dell.com, helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200311203326.GA163074@google.com>
 <ddf5d142-09e7-67ee-16e4-37447df6b112@linux.intel.com>
 <868a9cc8b34f428e8f59c1b0213131d7@AUSX13MPC107.AMER.DELL.COM>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <5328126a-7cf0-58c9-7dff-978fe2cae0ee@linux.intel.com>
Date:   Wed, 11 Mar 2020 15:11:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <868a9cc8b34f428e8f59c1b0213131d7@AUSX13MPC107.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/11/20 2:53 PM, Austin.Bolen@dell.com wrote:
> On 3/11/2020 4:27 PM, Kuppuswamy Sathyanarayanan wrote:
>> [EXTERNAL EMAIL]
>>
>> Hi,
>>
>> On 3/11/20 1:33 PM, Bjorn Helgaas wrote:
>>> On Wed, Mar 11, 2020 at 05:27:35PM +0000, Austin.Bolen@dell.com wrote:
>>>> On 3/11/2020 12:12 PM, Bjorn Helgaas wrote:
>>>>> [EXTERNAL EMAIL]
>>>>>
>>>> <SNIP>
>>>>> I'm probably missing your intent, but that sounds like "the OS can
>>>>> read/write AER bits whenever it wants, regardless of ownership."
>>>>>
>>>>> That doesn't sound practical to me, and I don't think it's really
>>>>> similar to DPC, where it's pretty clear that the OS can touch DPC bits
>>>>> it doesn't own but only *during the EDR processing window*.
>>>> Yes, by treating AER bits like DPC bits I meant I'd define the specific
>>>> time windows when OS can touch the AER status bits similar to how it's
>>>> done for DPC in the current ECN.
>>> Makes sense, thanks.
>>>
>>>>>>>> For the normative text describing when OS clears the AER bits
>>>>>>>> following the informative flow chart, it could say that OS clears
>>>>>>>> AER as soon as possible after OST returns and before OS processes
>>>>>>>> _HPX and loading drivers.  Open to other suggestions as well.
>>>>>>> I'm not sure what to do with "as soon as possible" either.  That
>>>>>>> doesn't seem like something firmware and the OS can agree on.
>>>>>> I can just state that it's done after OST returns but before _HPX or
>>>>>> driver is loaded. Any time in that range is fine. I can't get super
>>>>>> specific here because different OSes do different things.  Even for
>>>>>> a given OS they change over time. And I need something generic
>>>>>> enough to support a wide variety of OS implementations.
>>>>> Yeah.  I don't know how to solve this.
>>>>>
>>>>> Linux doesn't actually unload and reload drivers for the child devices
>>>>> (Sathy, correct me if I'm wrong here) even though DPC containment
>>>>> takes the link down and effectively unplugs and replugs the device.  I
>>>>> would *like* to handle it like hotplug, but some higher-level software
>>>>> doesn't deal well with things like storage devices disappearing and
>>>>> reappearing.
>>>>>
>>>>> Since Linux doesn't actually re-enumerate the child devices, it
>>>>> wouldn't evaluate _HPX again.  It would probably be cleaner if it did,
>>>>> but it's all tied up with the whole unplug/replug problem.
>>>> DPC resets everything below it and so to get it back up and running it
>>>> would mean that all buses and resources need to be assigned, _HPX
>>>> evaluated, and drivers reloaded. If those things don't happen then the
>>>> whole hierarchy below the port that triggered DPC will be inaccessible.
>>> Hmm, I think I might be confusing this with another situation.  Sathy,
>>> can you help me understand this?  I don't have a way to actually
>>> exercise this EDR path.  Is there some way the pciehp hotplug driver
>>> gets involved here?
> If the port has hot-plug enabled then DPC trigger will cause the link to
> go down (disabled state) and will generate a DLLSC hot-plug interrupt.
> When DPC is released, the link will become active and generate another
> DLLSC hot-plug interrupt.
Yes, device/driver enumeration and removal will triggered by DLLSC
state change interrupt in pciehp driver.
>
>>> Here's how this seems to work as far as I can tell:
>>>
>>>      - Linux does not have DPC or AER control
>>>
>>>      - Linux installs EDR notify handler
>>>
>>>      - Linux evaluates DPC Enable _DSM
>>>
>>>      - DPC containment event occurs
>>>
>>>      - Firmware fields DPC interrupt
>>>
>>>      - DPC event is not a surprise remove
>>>
>>>      - Firmware sends EDR notification
>>>
>>>      - Linux EDR notify handler evaluates Locate _DSM
>>>
>>>      - Linux reads and logs DPC and AER error information for port in
>>>        containment mode.  [If it was an RP PIO error, Linux clears RP PIO
>>>        error status, which is an asymmetry with the non-RP PIO path.]
>>>
>>>      - Linux clears AER error status (pci_aer_raw_clear_status())
>>>
>>>      - Linux calls driver .error_detected() methods for all child devices
>>>        of the port in containment mode (pcie_do_recovery()).  These
>>>        devices are inaccessible because the link is down.
>>>
>>>      - Linux clears DPC Trigger Status (dpc_reset_link() from
>>>        pcie_do_recovery()).
>>>
>>>      - Linux calls driver .mmio_enabled() methods for all child devices.
>>>
>>> This is where I get lost.  These child devices are now accessible, but
>>> they've been reset, so I don't know how their config space got
>>> restored.  Did pciehp enumerate them?  Did we do something like
>>> pci_restore_state()?  I don't see where either of these happens.
>> AFAIK, AER error status registers  are sticky (RW1CS) and hence
>> will be preserved during reset.
> In our testing, the device directly connected to the port that was
> contained does get reprogrammed and the driver is reloaded.  These are
> hot-plug slots and so might be due to DLLSC hot-plug interrupt when
> containment is released and link goes back to active state.
>
> However, if a switch is connected to the port where DPC was triggered
> then we do not see the whole switch hierarchy being re-enumerated.
Now that I have a hardware to verify this scenario, I will look into
it. I suspect there is a transient state in link status which causes
this disconnect issue. But I think this issue is not related to
EDR support and hence should be reproducible in native handling
as well.
>
> Also, DPC could be enabled on non-hot-plug slots so can't always rely on
> hot-plug to re-init devices in the recovery path.
If hotplug is not supported then there is support to enumerate
devices via polling  or ACPI events. But a point to note
here is, enumeration path is independent of error handler path, and
hence there is no explicit trigger or event from error handler path
to enumeration path to kick start the enumeration.
>
>>> So they want to basically do native AER handling even though firmware
>>> owns AER?  My head hurts.
>> No, Its meant only for clearing AER registers. In EDR path, since
>> OS owns clearing DPC registers, they want to let OS own clearing AER
>> registers as well. Also,  it would give OS a chance to decide whether
>> we want to keep the device on based on error status and history of the
>> device attached.
> Right.  The way it was pitched to me was that the OSVs wanted to
> read/clear the error status bits so they could re-use the code that does
> that when OS natively owns AER/DPC.
>
>>> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

