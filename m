Return-Path: <linux-pci+bounces-38959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AFBFA65F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 08:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017801A02C1B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C783C2F39B9;
	Wed, 22 Oct 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JNWpi4dr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEED2EDD6F;
	Wed, 22 Oct 2025 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116369; cv=none; b=rvqv4hjfA521IzkHtGLOBsqmvfIgz1HeFAFh1AS5DQ4NAYcwwOsGe/R1m++6a3rhDV5uNqP/z4y9GFz2hr0jyKGn9eL9nWCsWjgEEnhTyWop7w8FdOXSv1tfHLOYl920C3KmygWOF9dm8MxT/v+gxAE6hY5nAI5j2cLbpNAO/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116369; c=relaxed/simple;
	bh=1PhaDSP5B4rAtr4f49e8gnfLLbvLxyEIL3t9mFfVw+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9DLAbD/j1Gwv4hQlKFhynHws22zabUeGkV6syYWkMaKuwYC35JVtnmX462XVQxi/A0c2oHM/FQQDjij7IbNCjdCMXOgCDpZwt/YRM16n3OApXu5k6lMpY1dKlh+TbUCCPYFaEZZXoO1K7lTugsKMlv6OYHlLjaTy/ckZSvt9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JNWpi4dr; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cs0QL4pgbz9t8W;
	Wed, 22 Oct 2025 08:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761116362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1fnAapxocpS1PzNNod6wJpD/egeyzDYB/Jrd9dgM4U=;
	b=JNWpi4drdUs+btd7VToiRgbE6iRRVDP3jzDGp4IdtZxspVPgXzrkVyw6XfZ6VoltxsDAme
	2cht2i0/8JrZc9EQ0dSFhPa2tbjjnQ8bG+3qZYq9K+j+DgLoSa0jFlhn5wEEsINMOYgadA
	sWs6weTLZ2y5Br7G+yMjqd7lc9Dj7wFW43WKaehGIb0uF9weDQ4aqUMzGVd23ZJX7dM78D
	6cbkMfzb6nIZozbWJ6FgZD96p/5LwJZg76fWkSFTnYsyFob3539fRhtxakP3+goUS0/BK8
	Tv52QQPI/RSlQl6HSAde3lxR5xApuQkjeJ6zgMcbwp3emdxPI+Dp6eg8agHksg==
Message-ID: <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
Date: Wed, 22 Oct 2025 08:59:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
To: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar" <ravib@amazon.com>
Cc: "mani@kernel.org" <mani@kernel.org>,
 "thippeswamy.havalige@amd.com" <thippeswamy.havalige@amd.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>
References: <20251021212801.GA1224310@bhelgaas>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251021212801.GA1224310@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dacca2ed9550b966657
X-MBO-RS-META: 33d8grajrud4g8etgcmen193gr4s35jn

Hi Bjorn,
Hi Ravi,

On 10/21/25 23:28, Bjorn Helgaas wrote:
> On Tue, Oct 21, 2025 at 08:55:41PM +0000, Bandi, Ravi Kumar wrote:
>>> On Tue, Oct 21, 2025 at 05:46:17PM +0000, Bandi, Ravi Kumar wrote:
>>>>> On Oct 21, 2025, at 10:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Sat, Sep 20, 2025 at 10:52:32PM +0000, Ravi Kumar Bandi wrote:
>>>>>> The pcie-xilinx-dma-pl driver does not enable INTx interrupts
>>>>>> after initializing the port, preventing INTx interrupts from
>>>>>> PCIe endpoints from flowing through the Xilinx XDMA root port
>>>>>> bridge. This issue affects kernel 6.6.0 and later versions.
>>>>>>
>>>>>> This patch allows INTx interrupts generated by PCIe endpoints
>>>>>> to flow through the root port. Tested the fix on a board with
>>>>>> two endpoints generating INTx interrupts. Interrupts are
>>>>>> properly detected and serviced. The /proc/interrupts output
>>>>>> shows:
>>>>>>
>>>>>> [...]
>>>>>> 32:        320          0  pl_dma:RC-Event  16 Level     400000000.axi-pcie, azdrv
>>>>>> 52:        470          0  pl_dma:RC-Event  16 Level     500000000.axi-pcie, azdrv
>>>>>> [...]

First a comment on this IRQ logging:

These lines do NOT refer to the INTx IRQ(s) but the controller internal
"events" (errors etc). Please see this log for INTx on my Versal
platform with pci_irqd_intx_xlate added:

  24:          0          0  pl_dma:RC-Event   0 Level     LINK_DOWN
  25:          0          0  pl_dma:RC-Event   3 Level     HOT_RESET
  26:          0          0  pl_dma:RC-Event   8 Level     CFG_TIMEOUT
  27:          0          0  pl_dma:RC-Event   9 Level     CORRECTABLE
  28:          0          0  pl_dma:RC-Event  10 Level     NONFATAL
  29:          0          0  pl_dma:RC-Event  11 Level     FATAL
  30:          0          0  pl_dma:RC-Event  20 Level     SLV_UNSUPP
  31:          0          0  pl_dma:RC-Event  21 Level     SLV_UNEXP
  32:          0          0  pl_dma:RC-Event  22 Level     SLV_COMPL
  33:          0          0  pl_dma:RC-Event  23 Level     SLV_ERRP
  34:          0          0  pl_dma:RC-Event  24 Level     SLV_CMPABT
  35:          0          0  pl_dma:RC-Event  25 Level     SLV_ILLBUR
  36:          0          0  pl_dma:RC-Event  26 Level     MST_DECERR
  37:          0          0  pl_dma:RC-Event  27 Level     MST_SLVERR
  38:         94          0  pl_dma:RC-Event  16 Level     84000000.axi-pcie
  39:         94          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1

The last line shows the INTx IRQs here ('pl_dma:INTx' vs 'pl_dma:RC-
Event').

More below...

>>>>>>
>>>>>> Changes since v1::
>>>>>> - Fixed commit message per reviewer's comments
>>>>>>
>>>>>> Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Ravi Kumar Bandi <ravib@amazon.com>
>>>>>
>>>>> Hi Ravi, obviously you tested this, but I don't know how to reconcile
>>>>> this with Stefan's INTx fix at
>>>>> https://lore.kernel.org/r/20251021154322.973640-1-stefan.roese@mailbox.org
>>>>>
>>>>> Does Stefan's fix need to be squashed into this patch?
>>>>
>>>> Sure, we can squash Stefan’s fix into this.
>>>
>>> I know we *can* squash them.
>>>
>>> I want to know why things worked for you and Stefan when they
>>> *weren't* squashed:
>>>
>>>   - Why did INTx work for you even without Stefan's patch.  Did you
>>>     get INTx interrupts but not the right ones, e.g., did the device
>>>     signal INTA but it was received as INTB?
>>
>> I saw that interrupts were being generated by the endpoint device,
>> but I didn’t specifically check if they were correctly translated in
>> the controller. I noticed that the new driver wasn't explicitly
>> enabling the interrupts, so my first approach was to enable them,
>> which helped the interrupts flow through.
> 
> OK, I'll assume the interrupts happened but the driver might not have
> been able to handle them correctly, e.g., it was prepared for INTA but
> got INTB or similar.
> 
>>>   - Why did Stefan's patch work for him even without your patch.  How
>>>     could Stefan's INTx work without the CSR writes to enable
>>>     interrupts?
>>
>> I'm not entirely sure if there are any other dependencies in the
>> FPGA bitstream. I'll investigate further and get back to you.
> 
> Stefan clarified in a private message that he had applied your patch
> first, so this mystery is solved.

Yes. I applied Ravi's patch first and still got no INTx delivered
to the nvme driver. That's what me triggered to dig deeper here and
resulted in this v2 patch with pci_irqd_intx_xlate added.

BTW:
I re-tested just now w/o Ravi's patch and the INTx worked. Still I think
Ravi's patch is valid and should be applied...
>>>   - Why you mentioned "kernel 6.6.0 and later versions."
>>>   8d786149d78c appeared in v6.7, so why would v6.6.0 would be
>>>   affected?
>>
>> Apologies for not clearly mentioning the version earlier. This is
>> from the linux-xlnx tree on the xlnx_rebase_v6.6 branch, which
>> includes the new Xilinx root port driver with QDMA support:
>> https://github.com/Xilinx/linux-xlnx/blob/xlnx_rebase_v6.6_LTS/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>
>> In earlier versions, the driver was:
>> https://github.com/Xilinx/linux-xlnx/blob/xlnx_rebase_v6.1_LTS_2023.1_update/drivers/pci/controller/pcie-xdma-pl.c
>> This older driver had no issues with interrupts.
>>
>> The new driver introduced in v6.7 and later is a rewrite of the old
>> one, now with QDMA support, which has issues with INTx interrupts.
> 
> OK, this sounds like out-of-tree history that is not relevant in the
> mainline kernel, so Mani did the right thing in omitting it.
> 
> I think the best thing to do is to squash Stefan's patch into this one
> so we end up with a single patch that makes INTx work correctly.
> 
> Ravi and Stefan, does that seem OK to you?

Yes, please either apply both separately or squash them. Whatever you
prefer.

Many thanks,
Stefan
>>>>>> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>>>>> @@ -659,6 +659,12 @@ static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
>>>>>>              return err;
>>>>>>      }
>>>>>>
>>>>>> +     /* Enable interrupts */
>>>>>> +     pcie_write(port, XILINX_PCIE_DMA_IMR_ALL_MASK,
>>>>>> +                XILINX_PCIE_DMA_REG_IMR);
>>>>>> +     pcie_write(port, XILINX_PCIE_DMA_IDRN_MASK,
>>>>>> +                XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>>>> +
>>>>>>      return 0;
>>>>>> }
>>

