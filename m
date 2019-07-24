Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DEE73203
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfGXOns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 10:43:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:10045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfGXOnr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jul 2019 10:43:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 07:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="321361039"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2019 07:43:45 -0700
Subject: Re: Titan Ridge xHCI may stop to working after re-plugging the dock
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Lin <kent.lin@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
References: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com>
 <1562759399.5312.6.camel@suse.com> <87pnm6sd10.fsf@linux.intel.com>
 <77580193-D67B-48B1-8528-03ED4E7E8D64@canonical.com>
 <87blxqs3fh.fsf@linux.intel.com>
 <749516DB-65B6-4D59-8C77-7883649D1F25@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <8113f4a4-e96e-9b73-cd7a-1dbb800d68bb@linux.intel.com>
Date:   Wed, 24 Jul 2019 17:45:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <749516DB-65B6-4D59-8C77-7883649D1F25@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22.7.2019 12.44, Kai-Heng Feng wrote:
>>>>>> Hi Mika and Mathias,
>>>>>>
>>>>>> I’ve filed a bug [1] which renders docking station unusable.
>>>>>>
>>>>>> I am not sure it's a bug in PCI, Thunderbolt or xHCI so raise the issue
>>>>>> to
>>>>>> you both.
>>>>>>
>>>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=203885
>>>>>>
>>>>>> Kai-Heng
>>>>>
>>>
>>> I upgraded the system firmware, TBT firmware and docking station firmware
>>> to latest, and used latest mainline kernel.
>>> Now the issue can be reproduced at the very first time I plugged the
>>> docking station.
>>>
> 
> Request log attached to Bugzilla.
> 

After docking station unplug we see Transfer errors from
devices connected to Titan Ridge xHC, driver tries to recover, fails,
usb devices are disconnected.

After this xhci driver runtime suspends xHC controller as runtime pm is allowed
by default for Titan Ridge xHC controllers.

Interesting parts from log:

>>> Unplug Docking Station <<<

[  328.102279] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on endpoint
[  328.118279] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on endpoint
[  328.134291] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on endpoint
[  328.150355] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on endpoint
[  328.166342] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on endpoint
[  332.178710] usb usb4-port2: Cannot enable. Maybe the USB cable is bad?
[  332.178765] usb 4-2: USB disconnect, device number 35
[  332.178769] usb 4-2.3: USB disconnect, device number 36
[  332.179973] usb 4-2.4: USB disconnect, device number 37
[  332.414618] xhci_hcd 0000:39:00.0: set port remote wake mask, actual port 0 status  = 0xe0002a0
[  332.414639] xhci_hcd 0000:39:00.0: set port remote wake mask, actual port 1 status  = 0xe0002b0
[  332.414693] xhci_hcd 0000:39:00.0: xhci_hub_status_data: stopping port polling.
[  332.414703] xhci_hcd 0000:39:00.0: xhci_suspend: stopping port polling.
[  332.414719] xhci_hcd 0000:39:00.0: // Setting command ring address to 0x487da9001

>>> Plug Docking Station <<<

[  346.455568] pci_raw_set_power_state: 25 callbacks suppressed
[  346.455574] xhci_hcd 0000:39:00.0: Refused to change power state, currently in D3
[  346.539451] xhci_hcd 0000:39:00.0: enabling device (0000 -> 0002)
[  346.539482] xhci_hcd 0000:39:00.0: // Setting command ring address to 0x487da903f
[  346.539487] xhci_hcd 0000:39:00.0: WARN: xHC restore state timeout
[  346.539489] xhci_hcd 0000:39:00.0: PCI post-resume error -110!
[  346.539490] xhci_hcd 0000:39:00.0: HC died; cleaning up

>>> We don't have 0000:39:00 anymore <<<

When docking station is plugged back we try to resume Titan Ridge xHC,
PCI log shows that changing power state to D0 failed, xHC is still in D3.
Resume process continues anyway, and xhci driver tries to restore state, but fails.
Usb core will assume HC died if the pci resume callback failed

Does disabling runtime PM for Titan Ridge xHC help?

-Mathias
