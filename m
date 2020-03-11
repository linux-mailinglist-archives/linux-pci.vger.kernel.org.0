Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB39018207E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgCKSPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 14:15:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:22310 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgCKSPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 14:15:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="231776262"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2020 11:15:07 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id E147758033E;
        Wed, 11 Mar 2020 11:15:06 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>, Austin.Bolen@dell.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200311171203.GA137848@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <c405ec9a-550d-cd97-162f-c41560f40cdf@linux.intel.com>
Date:   Wed, 11 Mar 2020 11:12:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311171203.GA137848@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/11/20 10:12 AM, Bjorn Helgaas wrote:
>
>> I can just state that it's done after OST returns but before _HPX or
>> driver is loaded. Any time in that range is fine. I can't get super
>> specific here because different OSes do different things.  Even for
>> a given OS they change over time. And I need something generic
>> enough to support a wide variety of OS implementations.
> Yeah.  I don't know how to solve this.
>
> Linux doesn't actually unload and reload drivers for the child devices
> (Sathy, correct me if I'm wrong here) even though DPC containment
> takes the link down and effectively unplugs and replugs the device.  I
> would *like* to handle it like hotplug, but some higher-level software
> doesn't deal well with things like storage devices disappearing and
> reappearing.
>
> Since Linux doesn't actually re-enumerate the child devices, it
> wouldn't evaluate _HPX again.  It would probably be cleaner if it did,
> but it's all tied up with the whole unplug/replug problem.
Yes, re-enumeration of child devices is handled by hot-plug path.
AFAIK, with current PCI driver design, I think its very difficult to create
dependency between current DPC handler and hot-plug device
enumeration handler.

>
>>> For child devices of that port, obviously it's impossible to
>>> access AER registers until DPC Trigger Status is cleared, and the
>>> flowchart says the OS shouldn't access them until after _OST.
>>>
>>> I'm actually not sure we currently do *anything* with child device
>>> AER info in the EDR path.  pcie_do_recovery() does walk the
>>> sub-hierarchy of child devices, but it only calls error handling
>>> callbacks in the child drivers; it doesn't do anything with the
>>> child AER registers itself.  And of course, this happens before
>>> _OST, so it would be too early in any case.  But maybe I'm missing
>>> something here.
>> My understanding is that the OS read/clears AER in the case where OS
>> has native control of AER.  Feedback from OSVs is they wanted to
>> continue to do that to keep the native OS controlled AER and FF
>> mechanism similar.  The other way we could have done it would be to
>> have the firmware read/clear AER and report them to OS via APEI.
> When Linux has native control of AER, it reads/clears AER status.
> The flowchart is for the case where firmware has AER control, so I
> guess Linux would not field AER interrupts and wouldn't expect to
> read/clear AER status.  So I *guess* Linux would assume APEI?  But
> that doesn't seem to be what the flowchart assumes.
Yes, in EDR case, based on our current Linux driver design, without
some spec changes it will be very difficult to implement the
clear the AER status of child devices part of the flow chart. This is the
reason why I did not implement that part in current patch set.

I think instead of depending on DPC status trigger to end the EDR
notification window, we should depend on some sort of handshake
between OS and firmware (may be some changes to _OST arg1 0:15 and
use _OST for it). Above change would give us a window to clear the
AER registers properly.
>
>>> BTW, if/when this is updated, I have another question: the _OSC
>>> DPC control bit currently allows the OS to write DPC Control
>>> during that window.  I understand the OS writing the RW1C *Status*
>>> bits to clear them, but it seems like writing the DPC Control
>>> register is likely to cause issues.  The same question would apply
>>> to the AER access we're talking about.
>> We could specify which particular bits can and can't be touched.
>> But it's hard to maintain as new bits are added.  Probably better to
>> add some guidance that OS should read/clear error status, DPC
>> Trigger Status, etc. but shouldn't change masks/severity/control
>> bits/etc.
> Yeah.  I didn't mean at the level of individual bits; I was thinking
> more of status/log/etc vs control registers.  But maybe even that is
> hard, I dunno.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

