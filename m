Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4829C18F1F3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCWJkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 05:40:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:19187 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgCWJkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 05:40:02 -0400
IronPort-SDR: +hM3gcXNSyXgze6q/R6QleYizux/LUhR2Ue6t+Ek2GU9xnQatJAhLBEzKf1g4doKyUvx+HPUxo
 NpcKR79v5HwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 02:40:00 -0700
IronPort-SDR: xmxN2ajOd6VbnVo/Cz+E6OoGYmuawIf2FUgK9W4Xw8QEmo2ktljX1GcdgLY9Wu7YMbhaUyUOt4
 GFTccGzzXfww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="scan'208";a="239876643"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2020 02:39:57 -0700
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Evan Green <evgreen@chromium.org>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
 <87d0974akk.fsf@nanos.tec.linutronix.de>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com>
Date:   Mon, 23 Mar 2020 11:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87d0974akk.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20.3.2020 11.52, Thomas Gleixner wrote:
> Mathias,
> 
> Mathias Nyman <mathias.nyman@linux.intel.com> writes:
>> I can reproduce the lost MSI interrupt issue on 5.6-rc6 which includes
>> the "Plug non-maskable MSI affinity race" patch.
>>
>> I can see this on a couple platforms, I'm running a script that first generates
>> a lot of usb traffic, and then in a busyloop sets irq affinity and turns off
>> and on cpus:
>>
>> for i in 1 3 5 7; do
>> 	echo "1" > /sys/devices/system/cpu/cpu$i/online
>> done
>> echo "A" > "/proc/irq/*/smp_affinity"
>> echo "A" > "/proc/irq/*/smp_affinity"
>> echo "F" > "/proc/irq/*/smp_affinity"
>> for i in 1 3 5 7; do
>> 	echo "0" > /sys/devices/system/cpu/cpu$i/online
>> done
>> trace snippet: 
>>       <idle>-0     [001] d.h.   129.676900: xhci_irq: xhci irq
>>       <idle>-0     [001] d.h.   129.677507: xhci_irq: xhci irq
>>       <idle>-0     [001] d.h.   129.677556: xhci_irq: xhci irq
>>       <idle>-0     [001] d.h.   129.677647: xhci_irq: xhci irq
>>       <...>-14     [001] d..1   129.679802: msi_set_affinity: direct update msi 122, vector 33 -> 33, apicid: 2 -> 6
> 
> Looks like a regular affinity setting in interrupt context, but I can't
> make sense of the time stamps

I think so, everything worked normally after this one still.

> 
>>       <idle>-0     [003] d.h.   129.682639: xhci_irq: xhci irq
>>       <idle>-0     [003] d.h.   129.702380: xhci_irq: xhci irq
>>       <idle>-0     [003] d.h.   129.702493: xhci_irq: xhci irq
>>  migration/3-24    [003] d..1   129.703150: msi_set_affinity: direct update msi 122, vector 33 -> 33, apicid: 6 -> 0
> 
> So this is a CPU offline operation and after that irq 122 is silent, right?

Yes, after this irq 122 was silent.

> 
>>  kworker/0:0-5     [000] d.h.   131.328790: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>>  kworker/0:0-5     [000] d.h.   133.312704: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>>  kworker/0:0-5     [000] d.h.   135.360786: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>>       <idle>-0     [000] d.h.   137.344694: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>>  kworker/0:0-5     [000] d.h.   139.128679: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>>  kworker/0:0-5     [000] d.h.   141.312686: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>>  kworker/0:0-5     [000] d.h.   143.360703: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>>  kworker/0:0-5     [000] d.h.   145.344791: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
> 
> That kworker context looks fishy. Can you please enable stacktraces in
> the tracer so I can see the call chains leading to this? OTOH that's irq
> 121 not 122. Anyway moar information is always useful.
> 
> And please add the patch below.
> 

Full function trace with patch is huge, can be found compressed at

https://drive.google.com/drive/folders/19AFZe32DYk4Kzxi8VYv-OWmNOCyIY6M5?usp=sharing

xhci_traces.tgz contains:
trace_full: full function trace. 
trace: timestamp  ~48.29 to ~48.93 of trace above, section with last xhci irq
trace_prink_only: only trace_printk() of "trace" above

This time xhci interrupts stopped after
migration/3-24    [003] d..1    48.530271: msi_set_affinity: twostep update msi, irq 122, vector 33 -> 34, apicid: 6 -> 4

Thanks
-Mathias
