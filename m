Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E69B192EE9
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgCYRJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 13:09:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:42413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgCYRJv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 13:09:51 -0400
IronPort-SDR: b1wZgmq4U0PR1vG3WfBGSVRYgrghXZI1dx0Qi9R2EvLYDTk+K+IRqh9E2d0iTTt+M5aF+pfQeM
 KI8FN7+tTMWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 10:09:50 -0700
IronPort-SDR: hkSGMtQR0ySPV7Kryx4a6i6GozWm4P2oEVvZ7upTapfukzqByFxn5sMFWij2JU3xN/e/pL/fUC
 TncrRd0DLTqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="240679884"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2020 10:09:47 -0700
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
To:     Evan Green <evgreen@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
 <87d0974akk.fsf@nanos.tec.linutronix.de>
 <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com>
 <87r1xjp3gn.fsf@nanos.tec.linutronix.de>
 <f8057cbc-4814-5083-cddd-d4eb1459529f@linux.intel.com>
 <878sjqfvmi.fsf@nanos.tec.linutronix.de>
 <CAE=gft6Fbibu17H+OfHZjmvHxboioFj09hAmozebc1TE_EqH5g@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <8bd2f4ea-9f2d-8cd3-1384-e1c8e34bea17@linux.intel.com>
Date:   Wed, 25 Mar 2020 19:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft6Fbibu17H+OfHZjmvHxboioFj09hAmozebc1TE_EqH5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24.3.2020 18.17, Evan Green wrote:
> 
> Another experiment would be to try my old patch in [1]. I'm not
> advocating for this patch as a solution, Thomas and Bjorn have
> convinced me that it will break the rest of the world. But your PCI
> device 0xa3af seems to be Comet Lake. I was also on Comet Lake. So I'd
> expect to at least see it mask your problem. Again, if it didn't, that
> might be an interesting datapoint.
> 
> [1] https://lore.kernel.org/lkml/20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid/
> 

Yes I'm testing on a Comet Lake, oddly your patch doesn't mask the problem.
Did a few rounds, seems that xhci interrupts don't always stop when both vector
and apicid are updated. Sometimes just apicid update triggers it.

(tail of) round 1:
          <idle>-0     [001] d.h.   249.040051: xhci_irq: xhci irq
          <idle>-0     [001] d.h.   249.040122: do_IRQ: vector: 33 desc ffff9e84075b1800
          <idle>-0     [001] d.h.   249.040125: xhci_irq: xhci irq
     migration/1-14    [001] d..1   249.045231: msi_set_affinity: direct update msi 123, vector 33 -> 33, apicid: 2 -> 6
     migration/3-24    [003] d..1   249.069563: msi_set_affinity: twostep update msi, irq 123, vector 33 -> 35, apicid: 6 -> 0
          <idle>-0     [000] d.h.   250.294934: do_IRQ: vector: 33 desc ffff9e84066df200
          <idle>-0     [000] d.h.   250.294940: msi_set_affinity: direct update msi 122, vector 33 -> 33, apicid: 0 -> 0
          <idle>-0     [000] d.h.   252.276099: do_IRQ: vector: 33 desc ffff9e84066df200
round 2:
          <idle>-0     [001] d.h.    75.580577: do_IRQ: vector: 33 desc ffffa0449d084a00
          <idle>-0     [001] d.h.    75.580578: xhci_irq: xhci irq
          <idle>-0     [001] d.h.    75.580639: do_IRQ: vector: 33 desc ffffa0449d084a00
          <idle>-0     [001] d.h.    75.580640: xhci_irq: xhci irq
           <...>-14    [001] d..1    75.585814: msi_set_affinity: direct update msi 123, vector 33 -> 33, apicid: 2 -> 6
     migration/3-24    [003] d..1    75.606381: msi_set_affinity: direct update msi 123, vector 33 -> 33, apicid: 6 -> 0
          <idle>-0     [000] d.h.    76.275792: do_IRQ: vector: 35 desc ffffa04486009a00

round 3:
          <idle>-0     [001] d.h.   117.383266: xhci_irq: xhci irq
          <idle>-0     [001] d.h.   117.383407: do_IRQ: vector: 33 desc ffff92515d0d5800
          <idle>-0     [001] d.h.   117.383410: xhci_irq: xhci irq
     migration/1-14    [001] d..1   117.388527: msi_set_affinity: direct update msi 123, vector 33 -> 33, apicid: 2 -> 6
     migration/3-24    [003] d..1   117.413877: msi_set_affinity: direct update msi 123, vector 33 -> 33, apicid: 6 -> 0
          <idle>-0     [000] d.h.   119.290474: do_IRQ: vector: 35 desc ffff92514757b600

round 4:
          <idle>-0     [003] d.h.   147.950569: do_IRQ: vector: 33 desc ffff976fdd04ca00
          <idle>-0     [003] d.h.   147.950569: xhci_irq: xhci irq
          <idle>-0     [003] d.h.   147.950689: do_IRQ: vector: 33 desc ffff976fdd04ca00
          <idle>-0     [003] d.h.   147.950690: xhci_irq: xhci irq
     migration/3-24    [003] d..1   147.951368: msi_set_affinity: direct update msi 123, vector 33 -> 33, apicid: 6 -> 0
          <idle>-0     [000] d.h.   148.491193: do_IRQ: vector: 35 desc ffff976fdcc9da00
          <idle>-0     [000] d.h.   148.491198: msi_set_affinity: direct update msi 122, vector 35 -> 35, apicid: 0 -> 0

-Mathias

