Return-Path: <linux-pci+bounces-36003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1CFB54A00
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC13171FD7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2689E19992C;
	Fri, 12 Sep 2025 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idxOIqHF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DFA41
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673487; cv=none; b=i45y/iJD90Hu6KmiOYEuXGJSv334P9QvpMXllVO4oPKGXS7B/Gqk9jkWJh6o1pmx4ddlQwZKZtn4s41weZv2uOqkT2C/TMAk0Jdknb4jq7mqfzSUefoYydDzp/NnRCEllNVBYiAkXfawVd6M1Bv9g/mUPs8v/Ye82cKOEOM3zDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673487; c=relaxed/simple;
	bh=AdnvVg31OSZgfryVKEqlE/OPedY+eDMp/6UXzz3bqKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg8yKTpZAAkz64M9I7YJLeX56cib7jnkF438l3yDnXyYaHGEoJj3IZJfprOwNtO7VUGTjpqtvWCE+ItNqHtc6C1k9vhzQDMIrx1sVzJizgcI8tuupMP+wlxs82Es6ohy+Fj8072AdS/pOGoQIKHVsE271++hEX4Xh/j1HuTPAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idxOIqHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2F4C4CEF1;
	Fri, 12 Sep 2025 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757673486;
	bh=AdnvVg31OSZgfryVKEqlE/OPedY+eDMp/6UXzz3bqKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=idxOIqHFXsI0eX/9LBCcFunlMhhOcyc+oA7szsekD8Y+duo4FJEFKB6TKkvBFixep
	 fr6P9F7R81Zi7VHF42jKysOJDDAIWFdFoCjjTZqeACVv3giJeWkNQ5Ray1c36Qd61l
	 HLwfhVlTH3BSzD06d+OlqmGBB53wk1Gx6O8gsVNr+dggc2llAe7gZa03ODS4DdLwbE
	 a0QcisNPTT6T+m9QeSw/eJSfYRTFkxc+9Rw4ec+M3jRqIG0Tbk7zqrZ9NIdYT47PX1
	 qORIJCsWWGiwTdRb31ws9Flu1Mso+mh7X2pvhPayjyaZDgW+g1cfD6gqLsnZe1U/bq
	 I20N1lnI8OUdg==
Message-ID: <c7411e4b-83ba-45cb-8d76-37e1d0ad6ddc@kernel.org>
Date: Fri, 12 Sep 2025 19:38:03 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
 <94e8dbce-9e9a-4fe7-b33c-1d451c07eba6@kernel.org>
 <juziivdtvq4lcpugrw6whe7leq324cqspncd2ivojzp3bvm5l7@lhmdfj3lkjob>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <juziivdtvq4lcpugrw6whe7leq324cqspncd2ivojzp3bvm5l7@lhmdfj3lkjob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 18:59, Shinichiro Kawasaki wrote:
> On Sep 12, 2025 / 16:31, Damien Le Moal wrote:
>> On 9/12/25 16:11, Shin'ichiro Kawasaki wrote:
>>> When endpoint controller driver is immature, the fields dma_chan_tx and
>>> dma_chan_rx of the struct pci_epf_test could be NULL even after epf
>>> initialization. However, pci_epf_test_clean_dma_chan() assumes that they
>>> are always non-NULL valid values, and causes kernel panic when the
>>> fields are NULL. To avoid the kernel panic, NULL check the fields before
>>> release.
>>>
>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> ---
>>>  drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++------
>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> index e091193bd8a8..1c29d5dd4382 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> @@ -301,15 +301,20 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
>>>  	if (!epf_test->dma_supported)
>>>  		return;
>>>  
>>> -	dma_release_channel(epf_test->dma_chan_tx);
>>> -	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
>>> +	if (epf_test->dma_chan_tx) {
>>> +		dma_release_channel(epf_test->dma_chan_tx);
>>> +		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
>>> +			epf_test->dma_chan_tx = NULL;
>>> +			epf_test->dma_chan_rx = NULL;
>>> +			return;
>>> +		}
>>>  		epf_test->dma_chan_tx = NULL;
>>> -		epf_test->dma_chan_rx = NULL;
>>> -		return;
>>>  	}
>>
>> Can we simplify here ?
> 
> I'm afraid, no,
> 
>>
>> 	if (epf_test->dma_chan_tx) {
>> 		dma_release_channel(epf_test->dma_chan_tx);
>> 		epf_test->dma_chan_tx = NULL;
> 
> because the line above affects the comparison below.

Arg... Of course ! Sorry about the noise.

> 
>> 		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
>> 			epf_test->dma_chan_rx = NULL;
>> 			return;
>> 		}
>> 	}
>>
>>>  
>>> -	dma_release_channel(epf_test->dma_chan_rx);
>>> -	epf_test->dma_chan_rx = NULL;
>>> +	if (epf_test->dma_chan_rx) {
>>> +		dma_release_channel(epf_test->dma_chan_rx);
>>> +		epf_test->dma_chan_rx = NULL;
>>> +	}
>>>  }
>>>  
>>>  static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research

