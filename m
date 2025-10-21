Return-Path: <linux-pci+bounces-38922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57BBF7913
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7C818956F6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2EB3446DC;
	Tue, 21 Oct 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BjyOKm5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49032A1B2
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062573; cv=none; b=YOULP3cbbNs/70GheBCBqqrLss1JeblOO3HC4rVa5VPXsiU4WiTml9o7YStI/Z2rfD+h9Ui5SiORRX3qRshSgXfjrvaWTcFrnv9rjpfTy7+vwgiD6rEqtIUjUenkC/RFA6ah9ZYOXSsNNMYKid+3PhjFvCcW4rFdB2JgeUhruMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062573; c=relaxed/simple;
	bh=nOo/aZA4bi60IV5o+eWOioEduTx5lhGGFzyAznPPE7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEole7/5H/Y24KzhBJfkb9k2k5Zq/A87W2JRFbzF6e50BWeGp4oS6YzmBnUzKgd5DOau4tyoAdWpvexEXTp4YGiBka7qooLExgu0wups/rdXWNxBdJ7jB6UETFrdtPyFu2dLSBPT8StlghMU+H+UyFLqnHB0t5TbWfl+LcDwUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BjyOKm5O; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4crcWk3t0Tz9tT9;
	Tue, 21 Oct 2025 18:02:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761062562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRe7E2t/P9GQjAhVh5qQWP7KC1yaS/9j/2/8stw93NU=;
	b=BjyOKm5Owgi93DPSIVWbHueYgSV8DmYSPPsqqhJa5ehkWpoaNW5zBCb+N4psTl/8WHqjog
	bEHwZb8A9m1Dm7rtmB0L1OfWMH9eW4E49hU6sqignjLRshAyljCYcu9QyMtJ4rJmMIQguh
	dJZN2BMrWH5j4TfwfNNoA/v9XT9BtwbEagHrowrwcn6iNAr7hMvYUGWQdrwHklbQe1x9o2
	8u1nrTb5IoKQyTEeEjdunNA7+Jt1mJJevdCWgnnpHaI/8N1vyxzn3vMY95iJyFOPwhLu9I
	Mqu+xhdmdeoVs1+LvNbaOmBkddIrY5rKxybv5kPxqu8blXwDjX4/fipFvvrlLg==
Message-ID: <14a93b96-c641-41cb-9ab4-ae6cc7c4af1f@mailbox.org>
Date: Tue, 21 Oct 2025 18:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ
 handling
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>,
 Manivannan Sadhasivam <mani@kernel.org>, Ravi Kumar Bandi
 <ravib@amazon.com>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251021155347.GA1191808@bhelgaas>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251021155347.GA1191808@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 059b992879bd8c08881
X-MBO-RS-META: 98kfz6i54bqxg841j8cpqazs9ok538ci

Hi Bjorn,

On 10/21/25 17:53, Bjorn Helgaas wrote:
> On Tue, Oct 21, 2025 at 05:43:22PM +0200, Stefan Roese wrote:
>> While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
>> on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
>> the NVMe interrupts are not delivered to the host CPU resulting in
>> timeouts while probing.
>>
>> Debugging has shown, that the hwirq numbers passed to this device driver
>> (1...4, 1=INTA etc) need to get adjusted to match the numbers in the
>> controller registers bits (0...3).
>>
>> This patch now adds pci_irqd_intx_xlate to the INTx IRQ domain ops,
>> handling this IRQ number translation correctly.
> 
> s/pcie-xilinx-dma-pl:/xilinx-xdma:/  # in subject
> s/has shown, that/has shown that/
> s/This patch now adds/Add/
> s/pci_irqd_intx_xlate/pci_irqd_intx_xlate()/
> 
> We'll do this when applying, no need to repost for this.

Okay, thanks.
> I wonder how many other drivers have this issue.
> pci_irqd_intx_xlate() is used only by:
> 
>    dwc/pci-dra7xx.c
>    pcie-altera.c
>    pcie-xilinx-nwl.c
>    pcie-xilinx.c
>    pcie-xilinx-dma-pl.c   # this patch
> 
> Is there something different about these drivers that means they need
> it when all the others don't?

I can't really tell. I'm pretty sure that this driver also needs
pci_irqd_intx_xlate():

pcie-xilinx-cpm.c

I can't test it right now though. Perhaps in a few weeks though.

My best guess is, that legacy PCI IRQs are very rarely (not at all?)
used and therefor tested these days. On our ZynqMP / Versal platforms 
this is currently sometimes used, as the RP does not support MSI-X
(only MSI which is very unfortunate - and legacy of course). So it
might be that some other drivers are missing this intx_xlate as well.
Should be easy to test by booting with pci=nomsi.

Thanks,
Stefan
>> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
>> Cc: Sean Anderson <sean.anderson@linux.dev>
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: Ravi Kumar Bandi <ravib@amazon.com>
>> Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> v2:
>> - Use pci_irqd_intx_xlate to handle this IRQ number translation as suggested
>>    by Sean (thanks again)
>>
>>   drivers/pci/controller/pcie-xilinx-dma-pl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>> index 84888eda990b2..80095457ec531 100644
>> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
>> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>> @@ -370,6 +370,7 @@ static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain,
>>   /* INTx IRQ Domain operations */
>>   static const struct irq_domain_ops intx_domain_ops = {
>>   	.map = xilinx_pl_dma_pcie_intx_map,
>> +	.xlate = pci_irqd_intx_xlate,
>>   };
>>   
>>   static irqreturn_t xilinx_pl_dma_pcie_msi_handler_high(int irq, void *args)
>> -- 
>> 2.51.1
>>



