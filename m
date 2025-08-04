Return-Path: <linux-pci+bounces-33396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50150B1AAC4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C57C189FDEA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0123D28F;
	Mon,  4 Aug 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQCzSAzM"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C23FC52
	for <linux-pci@vger.kernel.org>; Mon,  4 Aug 2025 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345471; cv=none; b=W4AbLGPSTJtfifIwZGhuDd/8D1fqLWJfpTyaQNzLek2x+Xu9YWI9FjV/ksUXkiGOxEycbS32irN2Z3nuvirR1hCe1iC8yVZiHSHyFTRz1OpUHZyHcZ8aG4r1evP5rWn+a6Pf6IYEfidvYDsX4mVb22lv5o62MFoA7I/YF9PmtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345471; c=relaxed/simple;
	bh=YOQw+2IJtgxIyptpLVeHAzzhkZpHjMznGSJnrlgXQcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEHGqvYQ0AFbSbfjjhUzzaxKxogFzgK2bHBzAWK9qrMo5dy3k3ED8TSBoLqEB1Hm7mt1Iv4IggL27G5LBoBGaQNzxIHVNOQjl1jmGZSlNCMZvzOY5JwYlRAsEdABACXnUFh+JahuGdssVDi2reD/EhaGs+dtQxYT5vd9Y1SCZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQCzSAzM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23d9f128-af95-41b1-a5b9-3c69d2df8ab8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754345455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rJEkvOzsQ6EFHSRcMaMoGcS2ovBd6hOPz5m8PrRwWI=;
	b=MQCzSAzM9MtpuH1VkSfE1ljT2IPHeHO7okXvjU9cogjVB4O6H2Q+YevKPEbGK2O/6DNpxS
	G1vgw/qjx78W+LGLPAA+ZaMtM5+/UzfBOig78/IpeIUf04tywS8DZ+tul357p8/VuYEiQa
	nv9zOBGf5D1+dyrGwXynyOjLIEBHMKE=
Date: Mon, 4 Aug 2025 18:10:48 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] pci: nwl: Unhandled AER correctable error
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Michal Simek <michal.simek@amd.com>, Brian Norris
 <briannorris@chromium.org>, Minghuan Lian <minghuan.Lian@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250804205702.GA3640524@bhelgaas>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250804205702.GA3640524@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/4/25 16:57, Bjorn Helgaas wrote:
> [+cc more folks who might be interested in AER with non-standard
> interrupts]
> 
> On Fri, Aug 01, 2025 at 01:43:19PM -0400, Sean Anderson wrote:
>> Hi,
>> 
>> AER correctable errors are pretty rare. I only saw one once before and
>> came up with commit 78457cae24cb ("PCI: xilinx-nwl: Rate-limit misc
>> interrupt messages") in response. I saw another today and,
>> unfortunately, clearing the correctable AER bit in MSGF_MISC_STATUS is
>> not sufficient to handle the IRQ. It gets immediately re-raised,
>> preventing the system from making any other progress. I suspect that it
>> needs to be cleared in PCI_ERR_ROOT_STATUS. But since the AER IRQ never
>> gets delivered to aer_irq, those registers never get tickled.
>> 
>> The underlying problem is that pcieport thinks that the IRQ is going to
>> be one of the MSIs or a legacy interrupt, but it's actually a native
>> interrupt:
>> 
>>            CPU0       CPU1       CPU2       CPU3       
>>  42:          0          0          0          0     GICv2 150 Level     nwl_pcie:misc
>>  45:          0          0          0          0  nwl_pcie:legacy   0 Level     PCIe PME, aerdrv
>>  46:         25          0          0          0  nwl_pcie:msi 524288 Edge      nvme0q0
>>  47:          0          0          0          0  nwl_pcie:msi 524289 Edge      nvme0q1
>>  48:          0          0          0          0  nwl_pcie:msi 524290 Edge      nvme0q2
>>  49:         46          0          0          0  nwl_pcie:msi 524291 Edge      nvme0q3
>>  50:          0          0          0          0  nwl_pcie:msi 524292 Edge      nvme0q4
>> 
>> In the above example, AER errors will trigger interrupt 42, not 45.
>> Actually, there are a bunch of different interrupts in MSGF_MISC_STATUS,
>> so maybe nwl_pcie_misc_handler should be an interrupt controller
>> instead? But even then pcie_port_enable_irq_vec() won't figure out the
>> correct IRQ. Any ideas on how to fix this?
>> 
>> Additionally, any tips on actually triggering AER/PME stuff in a
>> consistent way? Are there any off-the-shelf cards for sending weird PCIe
>> stuff over a link for testing? Right now all I have 
> 
> This is definitely a problem.  We have had some discussion about this
> in the past, but haven't quite achieved critical mass to solve this in
> a generic way.  Here are some links:
> 
>   https://lore.kernel.org/linux-pci/20250702223841.GA1905230@bhelgaas/t/#u
>   https://lore.kernel.org/linux-pci/1464242406-20203-1-git-send-email-po.liu@nxp.com/

Thanks for the links. Toggling PERST does seem to reliably cause
correctable errors (however "correctable" they may actually be in
practice). With the patch I posted on the other branch of this chain I
now get

[   43.041610] pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
[   43.050693] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[   43.061477] pcieport 0000:00:00.0:   device [10ee:d011] error status/mask=00000001/0000e000
[   43.069842] pcieport 0000:00:00.0:    [ 0] RxErr                 

Whether or not that's the right fix, at least I can test things :)

--Sean

