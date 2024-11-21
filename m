Return-Path: <linux-pci+bounces-17161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF29D4CC4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F0828286E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5071C6F76;
	Thu, 21 Nov 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY03BWrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8621D0F4D
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191925; cv=none; b=n5hJ8zDa1FzI/sQM8S2OzzREWRYU0yKRC27pQBZyfCL0qBNDx9DbFuoE/U4ffEpQ0YtMtZ3wKHoVIMZ8Qk5fz3U3eONMEZiaP5w6Xl3hUON/mottjJ540pSjzrUq1h6+B0CeQUqxTpxnZiOnt1k9vCzY2wt2DqRuarJtDk+wF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191925; c=relaxed/simple;
	bh=5Rh/gyiCNw8yWCeOWdWjAji6m3W2gIQA6Q0WN/PkAEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnY3DYF7haBt8qBHrHWEmMp4JdqiWwMErYv4DShqHPlcNJiuxwpJferEGCnOes+2q3YGv/wRKxFNp/WqZBOwI8Vw5nWGg1GkA63xa0q5ZNQwg+KuxVdvcNDSJSMHsguV0MdOEyMe5+JYCkpsT3VJ5Oz3KN6OQM26hZixXjqurrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY03BWrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0167C4CECC;
	Thu, 21 Nov 2024 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732191924;
	bh=5Rh/gyiCNw8yWCeOWdWjAji6m3W2gIQA6Q0WN/PkAEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HY03BWrA7iWcEr4n2aUTmC/pIf6P+cRMAk7UKOF0faNkUVvEmDGx+PJ/E3xrEZ8XY
	 qNepYHcBLEVe8S3LP6ZXs12yvsRKCNzs/Wl5lNzl4xmIxHVeP2R2+x6hfAnWSJm944
	 otS//K/qY6z9srz4aOCBhzYt16mFvxlMquSm+mahSJP5ciH3zAhumEy3wK9cVMgD5q
	 530UxodVZZM8PtEn706C9NxcgbQwusQ9Ga2fH3dhHkA17D9eOrQoMh3iM9F7X83ifa
	 C7HP6NHS5cFot7feHlFiaJui8jo2MUf2RsTvP0FqVd4fGyjDN+4Se9MRSetLPR10ld
	 tzr99Ivmkal8w==
Message-ID: <c5e84a74-0736-4040-b61d-04a9193195b9@kernel.org>
Date: Thu, 21 Nov 2024 21:25:22 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Add support for capabilities
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 Frank Li <Frank.Li@nxp.com>
References: <20241120155730.2833836-4-cassel@kernel.org>
 <20241120155730.2833836-6-cassel@kernel.org>
 <00f1303d-7ab8-4cea-9491-5f689cbc423b@kernel.org>
 <Zz8i5hoCuTgEVyag@x1-carbon>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zz8i5hoCuTgEVyag@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 21:09, Niklas Cassel wrote:
> Hello Damien,
> 
> On Thu, Nov 21, 2024 at 11:54:48AM +0900, Damien Le Moal wrote:
>> On 11/21/24 00:57, Niklas Cassel wrote:
>>> If running pci_endpoint_test.c (host side) against a version of
>>> pci-epf-test.c (EP side), we will not see any capabilities being set.
>>>
>>> For now, only add the CAP_HAS_ALIGN_ADDR capability.
>>>
>>> If the CAP_HAS_ALIGN_ADDR is set, that means that the EP side supports
>>> reading/writing to an address without any alignment requirements.
>>>
>>> Thus, if CAP_HAS_ALIGN_ADDR is set, make sure that we do not add any
>>> specific padding to the buffers that we allocate (which was only made
>>> in order to get the buffers to satisfy certain alignment requirements).
>>>
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>> ---
>>>  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>> index 3aaaf47fa4ee..ab2b322410fb 100644
>>> --- a/drivers/misc/pci_endpoint_test.c
>>> +++ b/drivers/misc/pci_endpoint_test.c
>>> @@ -69,6 +69,9 @@
>>>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
>>>  #define FLAG_USE_DMA				BIT(0)
>>>  
>>> +#define PCI_ENDPOINT_TEST_CAPS			0x30
>>> +#define CAP_HAS_ALIGN_ADDR			BIT(0)
>>> +
>>>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>>>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
>>>  #define PCI_DEVICE_ID_TI_AM64			0xb010
>>> @@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
>>>  	.unlocked_ioctl = pci_endpoint_test_ioctl,
>>>  };
>>>  
>>> +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
>>> +{
>>> +	struct pci_dev *pdev = test->pdev;
>>> +	struct device *dev = &pdev->dev;
>>> +	u32 caps;
>>> +	bool has_align_addr;
>>> +
>>> +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
>>> +
>>> +	has_align_addr = caps & CAP_HAS_ALIGN_ADDR;
>>> +	dev_dbg(dev, "CAP_HAS_ALIGN_ADDR: %d\n", has_align_addr);
>>> +
>>> +	if (has_align_addr)
>>
>> Shouldn't this be "if (!has_align_addr)" ?
> 
> Nope. Check patch 1/2 in this series.
> 
> +	if (epc->ops->align_addr)
> +		caps |= CAP_HAS_ALIGN_ADDR;
> 
> i.e. if the EP implements the addr_align callback, then we know for sure
> that the EP read/write anywhere.
> 
> 
> However, if even you as the author of the .addr_align callback get confused
> by this, then perhaps we should rename things.
> 
> How about:
> 
> ep_has_align_addr_cb = caps & CAP_HAS_ALIGN_ADDR_CB;
> if (ep_has_align_addr_cb)
> 	test->alignment = 0;

I see my confusion: "has_align_addr" means that the EP handles any address with
the .align_addr method. OK. So what about reversing this to make it clear:

	needs_aligned_address = !(caps & CAP_HAS_ALIGN_ADDR);

	if (!needs_aligned_address)
		test->alignment = 0;

> ep_can_do_unaligned_access = caps & CAP_HAS_UNALIGNED_ACCESS;
> if (ep_can_do_unaligned_access)
> 	test->alignment = 0;

Yes, this one :) I find it less confusing.
Maybe CAP_HAS_UNALIGNED_ACCESS can simply be named CAP_UNALIGNED_ACCESS (i.e.
unaligned accesses is OK and is a capability).

> 
> 
> Do you have any better suggestion?
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research

