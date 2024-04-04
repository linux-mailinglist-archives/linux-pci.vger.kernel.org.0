Return-Path: <linux-pci+bounces-5645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6CE897DCD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 04:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C0528A83F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA9282E2;
	Thu,  4 Apr 2024 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayh00Toi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C81CD35;
	Thu,  4 Apr 2024 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198441; cv=none; b=I1GW8aUaP2tRru7IXaaBIEmOJVJI7HdfAUicMWNe4g35Oz4qJQFP/xf4fAGY9Ke9WYiVUmZI29OB3mW4+lwWX6IHCsPx272HXTW3jK3lC/JAnmJu+w0zkyZf+ja9dQ1PqazMwt2kERMqRunCvDvDjoR3ic3PBARiCFi8wacYKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198441; c=relaxed/simple;
	bh=nWBOnkzfJqiTI89c9fyFiP7jWvqgYA/ILTaVMO7uAq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh0u3aDVFdGBZ+7OQSIsOX+6jA9tgV6EC5Oys9Y21auJ05isBhXiG/FKMXBMgP13WByhLPW9UG+YJZUkuH6d+oBlrTd1u7l9VrazkPO12kSFQXN9WCMnB4lzz17xreRzVi1Xea9CBU5bQJKPJieYs0uEbVMztWkaVKgyinrCz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayh00Toi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E71C433F1;
	Thu,  4 Apr 2024 02:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712198441;
	bh=nWBOnkzfJqiTI89c9fyFiP7jWvqgYA/ILTaVMO7uAq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ayh00ToiXPZtL5GJsl3/F863u9O6MDDsWUSAWLT2VQZj1MHKal3sR/IBHAbb0f6Ci
	 JsxvWGs1kdf89k7OFvQLUAhsdCU3oHE6isB4+ulHtquiQST5tkXJV03+J6NZYpa1Gm
	 GttpkAjIdO6MgjxhgpG+sZkog6YrkWlfeu5Kh6zRaf9GM2o7EZuTsIoYI+yzDLSq29
	 d+y11ZOd9agspXCKFKVZr6NO7e0cGe+3oYJ5Sgkvazd2T2M/13Gr/7796bWHJNyasw
	 cYKFNVnhnC2JenmWLxcJ9U2KTUzc78JkCYMO9FO8HAREKkAuFxLSDNiJKVxEAJCWYx
	 y/Jm9xkiA7ZwQ==
Message-ID: <62ae8487-b768-424e-b6a5-a5f31b3b55bb@kernel.org>
Date: Thu, 4 Apr 2024 11:40:37 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] PCI: endpoint: Decouple EPC and PCIe bus
 specific events
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-2-970dbe90b99d@linaro.org>
 <45b2db99-2d03-469b-aa37-bc6c63cef141@kernel.org>
 <20240403142650.GA72531@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240403142650.GA72531@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 23:26, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 09:14:20AM +0900, Damien Le Moal wrote:
>> On 4/2/24 00:50, Manivannan Sadhasivam wrote:
>>> Currently, 'struct pci_epc_event_ops' has a bunch of events that are sent
>>> from the EPC driver to EPF driver. But those events are a mix of EPC
>>> specific events like core_init and PCIe bus specific events like LINK_UP,
>>> LINK_DOWN, BME etc...
>>>
>>> Let's decouple them to respective structs (pci_epc_event_ops,
>>> pci_epc_bus_event_ops) to make the separation clear.
>>
>> I fail to see the benefits here. The event operation names are quite clear and,
>> in my opinion, it is clear if an event op applies to the controller or to the
>> bus/link. If anything, "core_init" could a little more clear, so renaming that
>> "ep_controller_init" or something like that (clearly spelling out what is being
>> initialized) seems enough to me. Similarly, the "bme" op name is very criptic.
>> Renaming that to "bus_master_enable" would go a long way clarifying the code.
>> For link events, "link_up", "link_down" are clear. So I think there is no need
>> to split the event op struct like this. Renaming the ops is better.
>>
>> Note that I am not opposed to this patch, but I think it is just code churn
>> that does not really bring any fundamental improvement. Regardless, renaming
>> "core_init" and "bme" ops is I think desired.
>>
> 
> Niklas shared the same view during v1, but I hate to see the events being mixed
> in a single ops. Especially that it will confuse the developers who are not
> familiar with the EP subsystem.
> 
> But since the argument is coming twice, I've decided to drop this for now and
> just rename the 'core_init' callback to 'epc_init' and name the deinit callback
> as 'epc_deinit'.

Sounds good. Please also rename the completely unclear "bme" operation. Spell it
out to be clear.

-- 
Damien Le Moal
Western Digital Research


