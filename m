Return-Path: <linux-pci+bounces-38984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD0BFB56D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0DBD508609
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BF31BCAB;
	Wed, 22 Oct 2025 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D+1jIRY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7731986D;
	Wed, 22 Oct 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127885; cv=none; b=QSQ90uc9nnrQSF08lYt4EZqZwlDKEEAY9ZRdxtMMm8EOfdeOxZgBsN4I4xPxo4oD/dV6ZYB7+WAGXDA545jGrqpCaBL8L1gFP4sU1RovypbIvLwMxO60NlyGKn3w+2EVLrq7a6g8bNKJYWroAy4FD+s7ny3XDrTNbNRkBw2sfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127885; c=relaxed/simple;
	bh=8nT9flPf5qon1yPzsy3KjUgmUVkgGig8MR1UYbAqBwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+HAyDNQcmS+Mcw25JG7DeIonyr3XTkFT2Z8Uf1mX+2ZWsE2MbYBD9686lxH18A31YPITI2sdoejS7/4F+/i7AXqQIwItWxPlPX0VekVsNqgIaLadGnGYRJ9Yz+BfKFCVwEcOb/IRlavba0D4EaPfAoYSPdqwgk4drIxAIg3EC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D+1jIRY/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cs4gq684qz9v0N;
	Wed, 22 Oct 2025 12:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761127879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ErvLn3u13mo4+A7grjM/q3sRkW0BQpX3vsMWipwQUM=;
	b=D+1jIRY/qt+EBqGUAR3NXM2AsqlKgjlM/BTg8sMLQiM5u1u+byYNE18exsy4C+MQVgIcjl
	hpgaUch6HVHvmx9PgkXvGdXm2eAAxX/2/B4Dg9R/363jX1VqnJ4+XIGgWMgn7fhPKR7oSF
	uC2OpGl1qy4XLJ3hJEGy5P9opH2NpLtbNpN1WUA7mGVFLcwGwEhxotpOz+3yiFoA2cNtmM
	+FJ5eegI93g+P+PQzp0PtH1oUoj9kLVKB3exlFksFFrVWpGPxqnRfSC2hzcE4mA/rMeJ5b
	ZgNyJpqZiFS273wDiGaJddErtnHadCUz1YzoZOn1Wx6IHObcvH8ihpi40w2ezg==
Message-ID: <bdedc85c-c82e-4513-9bfd-c6d41f945e75@mailbox.org>
Date: Wed, 22 Oct 2025 12:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
 "mani@kernel.org" <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar"
 <ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <SN7PR12MB72017ACEC56064C19C1B62938BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <SN7PR12MB72017ACEC56064C19C1B62938BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 84f8ab374c5d70fa5a1
X-MBO-RS-META: 1o1btwbatmz1tkqkx9fohdr8r5qskgi6

On 10/22/25 12:04, Havalige, Thippeswamy wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Mani,
> 
>> -----Original Message-----
>> From: mani@kernel.org <mani@kernel.org>
>> Sent: Wednesday, October 22, 2025 3:25 PM
>> To: Stefan Roese <stefan.roese@mailbox.org>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>; Bandi, Ravi Kumar
>> <ravib@amazon.com>; Havalige, Thippeswamy
>> <thippeswamy.havalige@amd.com>; lpieralisi@kernel.org;
>> bhelgaas@google.com; linux-pci@vger.kernel.org; kwilczynski@kernel.org;
>> robh@kernel.org; Simek, Michal <michal.simek@amd.com>; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> stable@vger.kernel.org; Sean Anderson <sean.anderson@linux.dev>
>> Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
>>
>> On Wed, Oct 22, 2025 at 08:59:19AM +0200, Stefan Roese wrote:
>>> Hi Bjorn,
>>> Hi Ravi,
>>>
>>> On 10/21/25 23:28, Bjorn Helgaas wrote:
>>>> On Tue, Oct 21, 2025 at 08:55:41PM +0000, Bandi, Ravi Kumar wrote:
>>>>>> On Tue, Oct 21, 2025 at 05:46:17PM +0000, Bandi, Ravi Kumar wrote:
>>>>>>>> On Oct 21, 2025, at 10:23 AM, Bjorn Helgaas <helgaas@kernel.org>
>> wrote:
>>>>>>>> On Sat, Sep 20, 2025 at 10:52:32PM +0000, Ravi Kumar Bandi
>> wrote:
>>>>>>>>> The pcie-xilinx-dma-pl driver does not enable INTx
>>>>>>>>> interrupts after initializing the port, preventing INTx
>>>>>>>>> interrupts from PCIe endpoints from flowing through the
>>>>>>>>> Xilinx XDMA root port bridge. This issue affects kernel 6.6.0 and
>> later versions.
>>>>>>>>>
>>>>>>>>> This patch allows INTx interrupts generated by PCIe
>>>>>>>>> endpoints to flow through the root port. Tested the fix on
>>>>>>>>> a board with two endpoints generating INTx interrupts.
>>>>>>>>> Interrupts are properly detected and serviced. The
>>>>>>>>> /proc/interrupts output
>>>>>>>>> shows:
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>> 32:        320          0  pl_dma:RC-Event  16 Level     400000000.axi-
>> pcie, azdrv
>>>>>>>>> 52:        470          0  pl_dma:RC-Event  16 Level     500000000.axi-
>> pcie, azdrv
>>>>>>>>> [...]
>>>
>>> First a comment on this IRQ logging:
>>>
>>> These lines do NOT refer to the INTx IRQ(s) but the controller
>>> internal "events" (errors etc). Please see this log for INTx on my
>>> Versal platform with pci_irqd_intx_xlate added:
>>>
>>>   24:          0          0  pl_dma:RC-Event   0 Level     LINK_DOWN
>>>   25:          0          0  pl_dma:RC-Event   3 Level     HOT_RESET
>>>   26:          0          0  pl_dma:RC-Event   8 Level     CFG_TIMEOUT
>>>   27:          0          0  pl_dma:RC-Event   9 Level     CORRECTABLE
>>>   28:          0          0  pl_dma:RC-Event  10 Level     NONFATAL
>>>   29:          0          0  pl_dma:RC-Event  11 Level     FATAL
>>>   30:          0          0  pl_dma:RC-Event  20 Level     SLV_UNSUPP
>>>   31:          0          0  pl_dma:RC-Event  21 Level     SLV_UNEXP
>>>   32:          0          0  pl_dma:RC-Event  22 Level     SLV_COMPL
>>>   33:          0          0  pl_dma:RC-Event  23 Level     SLV_ERRP
>>>   34:          0          0  pl_dma:RC-Event  24 Level     SLV_CMPABT
>>>   35:          0          0  pl_dma:RC-Event  25 Level     SLV_ILLBUR
>>>   36:          0          0  pl_dma:RC-Event  26 Level     MST_DECERR
>>>   37:          0          0  pl_dma:RC-Event  27 Level     MST_SLVERR
>>>   38:         94          0  pl_dma:RC-Event  16 Level     84000000.axi-pcie
>>>   39:         94          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1
>>>
>>> The last line shows the INTx IRQs here ('pl_dma:INTx' vs 'pl_dma:RC-
>>> Event').
>>>
>>> More below...
>>>
>>>>>>>>>
>>>>>>>>> Changes since v1::
>>>>>>>>> - Fixed commit message per reviewer's comments
>>>>>>>>>
>>>>>>>>> Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA
>>>>>>>>> Root Port driver")
>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>> Signed-off-by: Ravi Kumar Bandi <ravib@amazon.com>
>>>>>>>>
>>>>>>>> Hi Ravi, obviously you tested this, but I don't know how to
>>>>>>>> reconcile this with Stefan's INTx fix at
>>>>>>>> https://lore.kernel.org/r/20251021154322.973640-1-stefan.roe
>>>>>>>> se@mailbox.org
>>>>>>>>
>>>>>>>> Does Stefan's fix need to be squashed into this patch?
>>>>>>>
>>>>>>> Sure, we can squash Stefan’s fix into this.
>>>>>>
>>>>>> I know we *can* squash them.
>>>>>>
>>>>>> I want to know why things worked for you and Stefan when they
>>>>>> *weren't* squashed:
>>>>>>
>>>>>>    - Why did INTx work for you even without Stefan's patch.  Did you
>>>>>>      get INTx interrupts but not the right ones, e.g., did the device
>>>>>>      signal INTA but it was received as INTB?
>>>>>
>>>>> I saw that interrupts were being generated by the endpoint device,
>>>>> but I didn’t specifically check if they were correctly translated
>>>>> in the controller. I noticed that the new driver wasn't explicitly
>>>>> enabling the interrupts, so my first approach was to enable them,
>>>>> which helped the interrupts flow through.
>>>>
>>>> OK, I'll assume the interrupts happened but the driver might not
>>>> have been able to handle them correctly, e.g., it was prepared for
>>>> INTA but got INTB or similar.
>>>>
>>>>>>    - Why did Stefan's patch work for him even without your patch.  How
>>>>>>      could Stefan's INTx work without the CSR writes to enable
>>>>>>      interrupts?
>>>>>
>>>>> I'm not entirely sure if there are any other dependencies in the
>>>>> FPGA bitstream. I'll investigate further and get back to you.
>>>>
>>>> Stefan clarified in a private message that he had applied your patch
>>>> first, so this mystery is solved.
>>>
>>> Yes. I applied Ravi's patch first and still got no INTx delivered to
>>> the nvme driver. That's what me triggered to dig deeper here and
>>> resulted in this v2 patch with pci_irqd_intx_xlate added.
>>>
>>> BTW:
>>> I re-tested just now w/o Ravi's patch and the INTx worked. Still I
>>> think Ravi's patch is valid and should be applied...
>>
>> How come INTx is working without the patch from Ravi which enabled INTx
>> routing in the controller? Was it enabled by default in the hardware?
> 
> Can you please cross-check the interrupt-map property in the device tree? Currently, the driver isn’t translating (pci_irqd_intx_xlate) the INTx number.
> 
> Here’s required DT property:
> 
> interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
>                  <0 0 0 2 &pcie_intc_0 1>,
>                  <0 0 0 3 &pcie_intc_0 2>,
>                  <0 0 0 4 &pcie_intc_0 3>;

Here the auto-generated DT property (Vivado 2025.1) for our design:

         interrupt-map = <0 0 0 1 &psv_pcie_intc_0 1>,
                         <0 0 0 2 &psv_pcie_intc_0 2>,
                         <0 0 0 3 &psv_pcie_intc_0 3>,
                         <0 0 0 4 &psv_pcie_intc_0 4>;

So we should manually "fix" the auto-generated DT instead? I would
rather like to skip such a step, as this is error prone with frequent
updates from the FPGA bistream design.

Thanks,
Stefan


