Return-Path: <linux-pci+bounces-11867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234295814E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39872821F5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38914B075;
	Tue, 20 Aug 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNRbL3C1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B6A29;
	Tue, 20 Aug 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143574; cv=none; b=fycueJiBrY48VXM70XFubujyvgdlgayEuuLYlHeWyDtPMxVDxl/kNNwztz5GWNNXWDZUl7BpBQa8cbUAh5blLC5cGCUVJiXDu29TT4c5o1qP8ctuVpXw9tPAahShu/6m7UZZ2SA6X72Q1VZ+R05qv2B61bTP1neiKl+MKV1KJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143574; c=relaxed/simple;
	bh=vJRfFNFc2TMJc9JfV4v5ekW9SpNa0cAb40oyHPArhrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzCwfUleMAHFopj8nPdS2aViFvwycjuJ+NVfBc1uGmHOpWfnUrfEF86NxBqeoEJwNnzPCDfuAkZoFS+ZzhUtW8huSEcL0XTcwVdm2ax6QRsm74XrXX1f4OCigRAiQqupxB92W/QJOjhQWeHawsDk0MIOhGHbOJXG+MBe+QP1OAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNRbL3C1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB158C4AF09;
	Tue, 20 Aug 2024 08:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143574;
	bh=vJRfFNFc2TMJc9JfV4v5ekW9SpNa0cAb40oyHPArhrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNRbL3C1ZiyETzBXM1M9cIK9AgGopjVDjyYsueTRGGSEFdp4nv9uLVxwZosPIMzXl
	 d7VwfhJdGl9wKQ6L3nkfUlkfGtyRep9rdwHZGEs4NqCy91+du3W1n8gpTHmHLNlMY7
	 lPTuPYiZD0rH+vMrXZtEU0gzZuLRbHgPy+yhtJBipKSfXNaQGjVhUHP2T9aZx8AVcW
	 OxpY+vxYv0sDKCljCBPC/nojW7s/wbGX8jsHWiGieqUshuBpijm/567Yw+olVweTwH
	 uYwrJbH3dTVTsEykfrAoDaTFEZga4b47vViuz33Da52zCKdXWsqSljndwGJ6ZjbxQa
	 iijgXYDqIjsWw==
Message-ID: <f1575ee3-02c1-4736-a0b5-817e20190d2f@kernel.org>
Date: Tue, 20 Aug 2024 17:46:11 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PCI: endpoint: pci-epf-test: Call
 pci_epf_test_raise_irq() on failed DMA check
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820071100.211622-1-rick.wertenbroek@gmail.com>
 <20240820071100.211622-2-rick.wertenbroek@gmail.com>
 <54451b81-b503-4072-807a-af2f0b914ec2@kernel.org>
 <CAAEEuhpt_WnxOZeYsMxjwTGZm-FJKoj3at-qPgyAH6D76P9wOA@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAAEEuhpt_WnxOZeYsMxjwTGZm-FJKoj3at-qPgyAH6D76P9wOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/20/24 17:43, Rick Wertenbroek wrote:
> On Tue, Aug 20, 2024 at 10:18 AM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 8/20/24 16:10, Rick Wertenbroek wrote:
>>> The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/pci-epf_test.c
>>> is meant to be used in a PCI endpoint device connected to a host computer
>>> with the host side driver: /drivers/misc/pci_endpoint_test.c.
>>>
>>> The host side driver can request read/write/copy transactions from the
>>> endpoint function and expects an IRQ from the endpoint function once
>>> the read/write/copy transaction is finished. These can be issued with or
>>> without DMA enabled. If the host side driver requests a read/write/copy
>>> transaction with DMA enabled and the endpoint function does not support
>>> DMA, the endpoint would only print an error message and wait for further
>>> commands without sending an IRQ because pci_epf_test_raise_irq() is
>>> skipped in pci_epf_test_cmd_handler(). This results in the host side
>>> driver hanging indefinitely waiting for the IRQ.
>>>
>>> Call pci_epf_test_raise_irq() when a transfer with DMA is requested but
>>> DMA is unsupported. The host side driver will no longer hang but report
>>> an error on transfer (printing "NOT OKAY") thanks to the checksum because
>>> no data was moved.
>>>
>>> Clarify the error message in the endpoint function as "Cannot ..." is
>>> vague and does not state the reason why it cannot be done.
>>>
>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>> ---
>>>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> index 7c2ed6eae53a..b02193cef06e 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> @@ -649,7 +649,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>>
>>>       if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
>>>           !epf_test->dma_supported) {
>>> -             dev_err(dev, "Cannot transfer data using DMA\n");
>>> +             dev_err(dev, "DMA transfer not supported\n");
>>
>> Should we set the FAIL status flag here ?
>> E.g.:
>>                  reg->status |= STATUS_READ_FAIL;
>>
>> Note: I have no idea why the status flags are different for the different
>> operations. We should really have a single SUCCESS/FAIL flag common to all
>> operations. So I think we could just do:
>>
>>                 reg->status |= STATUS_READ_FAIL | STATUS_WRITE_FAIL |
>>                         STATUS_COPY_FAIL;
>>
>> here, or go back to your v1 and handle the failure in each operation function to
>> set the correct flag.
>>
> 
> Good catch, indeed with the check outside of the functions, the status
> FAIL bits are not set. I think setting the status as a combined fail
> flag makes sense, however, it conveys the idea that read/write/copy
> failed whereas only one of them actually failed.
> 
> I agree that a single status SUCCESS/FAIL flag would be simpler. But
> changing this would require changes on both sides (EP & RC) and will
> reduce compatibility between EP and RC side driver versions, so I
> would refrain from changing this.
> 
>  I think I still prefer the v1/v2 code because even as it has a little
> bit of duplication it is clear and sets the correct FAIL bit without
> extra logic whereas here we either set all FAIL bits or have to add
> extra logic.
> 
> Thank you for spotting this.

Agree, v1 is cleaner in that respect, despite the duplicated checks.
So my review tag stands :)

Mani ? Thoughts ?

> 
>>> +             pci_epf_test_raise_irq(epf_test, reg);
>>>               goto reset_handler;
>>>       }
>>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research
>>
> 
> Best regards,
> Rick

-- 
Damien Le Moal
Western Digital Research


