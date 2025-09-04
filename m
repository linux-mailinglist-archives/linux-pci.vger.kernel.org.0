Return-Path: <linux-pci+bounces-35421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACA5B43086
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 05:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988B05E4424
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 03:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5A286898;
	Thu,  4 Sep 2025 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgv1JQSd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6481CBEB9;
	Thu,  4 Sep 2025 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756957369; cv=none; b=QSGVs1RSs+U4gxHt3APCH5lRS91tHrBw8n5K9FOA/fURH/Hd8FbWGHxVWikyNJchN9aR4w4lXbrY/4rtXt0BuDnAkAxRjyoaqvcdwG7YiJQMMG2jESDKpJd20/ZMyKl+XucdHVbarH/R745uPIyBkMDebLVuQZoujwpgqBftRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756957369; c=relaxed/simple;
	bh=K0JrEhJK//gSOD3e3hCCpFFjeNprd+OX8hXlrerK1yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNGfeTFTJNu2egB35IF0/PttlWXlaUA8M4J3kDihSPlE5pULZykJHwNpBcckm5M8u518QfozAhDDHB7dTuZRzDRLQJQ3qYWCbibXrsvRDtJplJv4SBppJrx+GMFNmak3K+4odj0wuILLlxclzBjjiuKYm6ZJiPXZl4Gn6/ergmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgv1JQSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3AFC4CEF0;
	Thu,  4 Sep 2025 03:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756957368;
	bh=K0JrEhJK//gSOD3e3hCCpFFjeNprd+OX8hXlrerK1yQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zgv1JQSd39vfeef/fpzYQtGQL7z6PVFDTxro9c+JvAeCUqGg5d0H+FcfPqrUiq47P
	 kjjMMr60Z3y4WKPSu7+0mlHZlQGPcvXOq/b6GrDTlEcGkGA3boWgIOLgTR0WkCsja2
	 dxQRBITCkRtZOtR8Ms9xDEWUMO5DwNiPubtX6d4edwHyFBgSZ0+TSKuf7sQ0EbaoZ+
	 qu06/g4PNXAs/yWEmDfbpsdYTiYf0ZVliqSGXnC8WHpFqNQBVC/bCtOA+YSWPn7Ok5
	 2dIfPeQHIqWwKdNIWIedQauVJ6GLFrxwfeoOuatcbEmsNEl43PuEVQdngAxO/so44l
	 y0mL+qWrINgBA==
Message-ID: <d7bf992f-0342-450d-8830-f0523ac11e2a@kernel.org>
Date: Thu, 4 Sep 2025 12:39:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
To: Marek Vasut <marek.vasut@mailbox.org>, linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Wang Jiang <jiangwang@kylinos.cn>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
 <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
 <4b8ee973-5201-4936-a248-6f145b958f45@mailbox.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <4b8ee973-5201-4936-a248-6f145b958f45@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 12:32 PM, Marek Vasut wrote:
> On 9/4/25 4:40 AM, Damien Le Moal wrote:
> 
> Hello Damien,
> 
>>> @@ -1050,7 +1051,13 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>>           if (bar == test_reg_bar)
>>>               continue;
>>>   -        base = pci_epf_alloc_space(epf, bar_size[bar], bar,
>>> +        test_bar_size = bar_size[bar];
>>> +
>>> +        bar_fixed_size = epc_features->bar[bar].fixed_size;
>>> +        if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size)
>>> +            test_bar_size = min(bar_size[bar], bar_fixed_size);
>>
>> I think this can be simplified to:
>>
>>         if (epc_features->bar[bar].type == BAR_FIXED)
>>             test_bar_size = epc_features->bar[bar].fixed_size;
>>         else
>>             test_bar_size = bar_size[bar];
>>
>> because if the bar type is BAR_FIXED, then the size of the bar can only be its
>> fixed size.
> That is correct, however, please consider the following case:
> 
> - The BAR under test is BAR4 , therefore the size requested by this driver is
> bar_size[4] = 131072 Bytes
> - The BAR4 on a hypothetical hardware is a fixed size BAR , 262144 Bytes large
> 
> With your proposed change, the "test_bar_size" would end up being 262144
> Bytes , instead of 131072 Bytes without your proposed change , which I think is
> not the desired behavior.
> 
> What do you think ?

The bar size for the test is arbitrary. If the bar being tested is not a fixed
bar, anything is OK. But in the case of a fixed bar, you can only use the fixed
bar size so we should force that.


-- 
Damien Le Moal
Western Digital Research

