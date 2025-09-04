Return-Path: <linux-pci+bounces-35420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3185B4307A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 05:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7848C1B207FD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 03:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337B27A917;
	Thu,  4 Sep 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vvkWt0wf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A67227EAA;
	Thu,  4 Sep 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956749; cv=none; b=BUuxH4eky1xPqMunUe2pY/uaJ+i/fwsidT7bVcQkjVQSNmE972pkz6GPON9lwZziLSyaZPUV/vk7U/8Wg1pVFZtEmzlE6mJrcc6+lbcth8fuXfxbUBnS756FOJVhIDXY7SuvwQWV65rBXvuHUdPUz4H5xYPqA00aTkMeC6ycaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956749; c=relaxed/simple;
	bh=s8Z7qxTjauNv6Dl0ffASnjRCLbgYBaQ0AP6W7nh3FQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2u9hBchTNw1f8zy9S/JEEAdP5LNnFODLptlPNs1ms6KyvAyrOhRs+lmwc2VJUMfPJK/o1ycDrPdNjDToBSI8KQhLSP7dCK821XlWKBufmRaTMRCL7/EG2paCGRX2FVWz6esAgas3Ni2WuMZ5EKIWeas1TKXea6JvwOsyc5K0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vvkWt0wf; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cHQ5Y3x66z9tDb;
	Thu,  4 Sep 2025 05:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756956737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNAknFXw21/tPDsTAK3kuhxs9dbCYpAzmKYlGBfaWv8=;
	b=vvkWt0wfzK/mI1nIaZOzhggvVNKuJPIYgRduC3AGFo5UuYLm9WUCfAB+gOqnC9vlj0ENSg
	tjGwWBtNqMVeRi8z9KB12FgYzQqj2MxAmxGXaso8T4GFvCnc9L0mo/O1494SFlggO9n5+Z
	SyBl0SsF88F6VsBp3xR/FC79QFY1RHVHDw9t+BrtHELJG30LQjtm/YRke5KHAZi8a+n95G
	5+Lg5d12QBzCtNxi42aaXG5TyOmY6ljCdpudozelKOQTKfZBHfbo/5seHA5huwiaKeWznb
	GCnxlA/z/ZGEUBnwP/2SHQvj2v59sCcd8h9+cmH81GdexMC1NuFrEdlmIdci6A==
Message-ID: <4b8ee973-5201-4936-a248-6f145b958f45@mailbox.org>
Date: Thu, 4 Sep 2025 05:32:15 +0200
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 85f65b13faec526c24b
X-MBO-RS-META: 9ni1csdgaqjbcur4df53n9hsc1aoq8d1

On 9/4/25 4:40 AM, Damien Le Moal wrote:

Hello Damien,

>> @@ -1050,7 +1051,13 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>   		if (bar == test_reg_bar)
>>   			continue;
>>   
>> -		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
>> +		test_bar_size = bar_size[bar];
>> +
>> +		bar_fixed_size = epc_features->bar[bar].fixed_size;
>> +		if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size)
>> +			test_bar_size = min(bar_size[bar], bar_fixed_size);
> 
> I think this can be simplified to:
> 
> 		if (epc_features->bar[bar].type == BAR_FIXED)
> 			test_bar_size = epc_features->bar[bar].fixed_size;
> 		else
> 			test_bar_size = bar_size[bar];
> 
> because if the bar type is BAR_FIXED, then the size of the bar can only be its
> fixed size.
That is correct, however, please consider the following case:

- The BAR under test is BAR4 , therefore the size requested by this 
driver is bar_size[4] = 131072 Bytes
- The BAR4 on a hypothetical hardware is a fixed size BAR , 262144 Bytes 
large

With your proposed change, the "test_bar_size" would end up being 262144 
Bytes , instead of 131072 Bytes without your proposed change , which I 
think is not the desired behavior.

What do you think ?

