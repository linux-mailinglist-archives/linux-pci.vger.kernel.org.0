Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEFE182521
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 23:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgCKWoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 18:44:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:61420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbgCKWoN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 18:44:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="389412091"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2020 15:44:12 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id E6B875804A0;
        Wed, 11 Mar 2020 15:44:11 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200311221324.GA195204@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <162f65bc-b963-653f-67d5-4de2abb26366@linux.intel.com>
Date:   Wed, 11 Mar 2020 15:41:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311221324.GA195204@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/11/20 3:13 PM, Bjorn Helgaas wrote:
> On Wed, Mar 11, 2020 at 02:25:18PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> On 3/11/20 1:33 PM, Bjorn Helgaas wrote:
>>> On Wed, Mar 11, 2020 at 05:27:35PM +0000, Austin.Bolen@dell.com wrote:
>>>> On 3/11/2020 12:12 PM, Bjorn Helgaas wrote:
>>>> <SNIP>
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
>>>
>>> Here's how this seems to work as far as I can tell:
>>>
>>>     - Linux does not have DPC or AER control
>>>
>>>     - Linux installs EDR notify handler
>>>
>>>     - Linux evaluates DPC Enable _DSM
>>>
>>>     - DPC containment event occurs
>>>
>>>     - Firmware fields DPC interrupt
>>>
>>>     - DPC event is not a surprise remove
>>>
>>>     - Firmware sends EDR notification
>>>
>>>     - Linux EDR notify handler evaluates Locate _DSM
>>>
>>>     - Linux reads and logs DPC and AER error information for port in
>>>       containment mode.  [If it was an RP PIO error, Linux clears RP PIO
>>>       error status, which is an asymmetry with the non-RP PIO path.]
>>>
>>>     - Linux clears AER error status (pci_aer_raw_clear_status())
>>>
>>>     - Linux calls driver .error_detected() methods for all child devices
>>>       of the port in containment mode (pcie_do_recovery()).  These
>>>       devices are inaccessible because the link is down.
>>>
>>>     - Linux clears DPC Trigger Status (dpc_reset_link() from
>>>       pcie_do_recovery()).
>>>
>>>     - Linux calls driver .mmio_enabled() methods for all child devices.
>>>
>>> This is where I get lost.  These child devices are now accessible, but
>>> they've been reset, so I don't know how their config space got
>>> restored.  Did pciehp enumerate them?  Did we do something like
>>> pci_restore_state()?  I don't see where either of these happens.
>> AFAIK, AER error status registers  are sticky (RW1CS) and hence
>> will be preserved during reset.
> I'm not concerned about the AER registers.  I'm wondering about bus
> numbers & windows (for bridges), BAR settings, MSI programming, etc.:
> all the normal stuff the driver expects.  Or do we actually detach the
> driver, remove the device, hot-add the device, re-enumerate, and
> rebind the driver?
Yes, link down event removes the device and detaches the
driver. It will re-added once the link comes up. Please check
the pciehp_handle_presence_or_link_change() and
pciehp_unconfigure_device() for details.
>
>>> So they want to basically do native AER handling even though firmware
>>> owns AER?  My head hurts.
>> No, it's meant only for clearing AER registers. In EDR path, since
>> OS owns clearing DPC registers, they want to let OS own clearing AER
>> registers as well. Also, it would give OS a chance to decide
>> whether we want to keep the device on based on error status and
>> history of the device attached.
> It's obviously not meant "only for clearing AER registers" if the OS
> is going to decide things based on the error status.  How is deciding
> things and clearing AER registers different from native AER handling?
In EDR case,  firmware *first* detects error events and decides whether
to attempt recovery or to notify OS. Even after you recovered the device
firmware can decide whether to keep the link on or off. This is the main
difference between native vs EDR model.

But, once OS receives receives notification then it can attempt recovery and
error handling similar to native model.
>
> This sort of makes a mockery of the idea of "AER ownership".  But I
> guess the spec doesn't actually say anything that limits OS access to
> the AER capability, even if firmware retains "control".  It does
> restrict *firmware* from modifying the AER cap if it grants control
> to the OS, but not the other way around.
>
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

