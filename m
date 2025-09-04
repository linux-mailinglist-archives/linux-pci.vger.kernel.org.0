Return-Path: <linux-pci+bounces-35469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E5B4448A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D6D7BFB21
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2113126D2;
	Thu,  4 Sep 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LjXuITN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E013126D6;
	Thu,  4 Sep 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007350; cv=none; b=a40k1O6BfGSj37ummEsgJJvnrj1V4e2Gw9V3I7ygYF1Dwr7BlcMQuYKGB5f9W1EzTV5cBXCr5LQ0i+SHcNsNTAwJOPSvVXqmcdJ5uef02ZgtOdh9THYcDkw2/rxGs0LmzHrPv7o9Q7jMW7cxzOjiAHP5YKzBeW1gkqO2i4Meqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007350; c=relaxed/simple;
	bh=I5l8HeIeL8M4xT4ZLCPiFE/LiBzoMDGO0Wa0gTJRy/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBh01YQSAoyUGfLd4OCyDkLSW3zpilkY72SMJQtkEKeDieQtPOBH4/847vL+eNgDSuBMD1RMBosLdgbwRedp8tE+OlFa5Dva05qQeuJCKk+Ox/GWVNWFw4xjHU/JDlAeoLZYuKvlYXAYSzk+puazrhLHyH1XVyWe1aVBPlks+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LjXuITN9; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cHmpm4Q4Lz9tNK;
	Thu,  4 Sep 2025 19:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757007344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e95i9l9G/Z4xlkgEuINxoEkC5v++NR7rDqNrFRZm2JM=;
	b=LjXuITN9FWthrTCnuHvooWLXHnEDH833SSN8sq57FCu+DwTehQ7hICYnrsyV5SfaN0TcJ2
	AGSf60FHpE/55ThMi+wJLrjak5UXl7QwooT+RICq9VnBjspQWkJ2UMJtjZIIuTwrUf1mh/
	o4MS9v3p5wzIobW8Mqk0SN1M1gygjZNVCQ1tJ4gImZsErczRYoHRxlPvH4eYpEz+5rrzzM
	f+zK3cjBeJX2gYlZujmOKZpAjDJwFVZofMmG8567hkTDzFm7+oPQp/NXSAOW4EmzYaYkUq
	v61PdH+iUR5S45XX9gQ10LHcRpbQudx8IZFwNMMzmoi6YNHUz/34sKm9NXJcew==
Message-ID: <99657eb0-e70d-4db3-ac09-6d15c0eb73dd@mailbox.org>
Date: Thu, 4 Sep 2025 19:35:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
To: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Wang Jiang <jiangwang@kylinos.cn>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
 <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
 <4b8ee973-5201-4936-a248-6f145b958f45@mailbox.org>
 <d7bf992f-0342-450d-8830-f0523ac11e2a@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d7bf992f-0342-450d-8830-f0523ac11e2a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c8d87fa5fccde935584
X-MBO-RS-META: ubo3kjpnaoagjj5r5jczyk6kyyg9t6fo

On 9/4/25 5:39 AM, Damien Le Moal wrote:
> On 9/4/25 12:32 PM, Marek Vasut wrote:
>> On 9/4/25 4:40 AM, Damien Le Moal wrote:
>>
>> Hello Damien,
>>
>>>> @@ -1050,7 +1051,13 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>>>            if (bar == test_reg_bar)
>>>>                continue;
>>>>    -        base = pci_epf_alloc_space(epf, bar_size[bar], bar,
>>>> +        test_bar_size = bar_size[bar];
>>>> +
>>>> +        bar_fixed_size = epc_features->bar[bar].fixed_size;
>>>> +        if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size)
>>>> +            test_bar_size = min(bar_size[bar], bar_fixed_size);
>>>
>>> I think this can be simplified to:
>>>
>>>          if (epc_features->bar[bar].type == BAR_FIXED)
>>>              test_bar_size = epc_features->bar[bar].fixed_size;
>>>          else
>>>              test_bar_size = bar_size[bar];
>>>
>>> because if the bar type is BAR_FIXED, then the size of the bar can only be its
>>> fixed size.
>> That is correct, however, please consider the following case:
>>
>> - The BAR under test is BAR4 , therefore the size requested by this driver is
>> bar_size[4] = 131072 Bytes
>> - The BAR4 on a hypothetical hardware is a fixed size BAR , 262144 Bytes large
>>
>> With your proposed change, the "test_bar_size" would end up being 262144
>> Bytes , instead of 131072 Bytes without your proposed change , which I think is
>> not the desired behavior.
>>
>> What do you think ?
> 
> The bar size for the test is arbitrary. If the bar being tested is not a fixed
> bar, anything is OK. But in the case of a fixed bar, you can only use the fixed
> bar size so we should force that.
OK, understood. I'll run tests on V2 and then submit a V2.

Thanks !

