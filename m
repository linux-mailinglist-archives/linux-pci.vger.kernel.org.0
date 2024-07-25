Return-Path: <linux-pci+bounces-10777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA16893BDBE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84FC6B212BE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2356172BB2;
	Thu, 25 Jul 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm0G8Db2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE43101F2;
	Thu, 25 Jul 2024 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895227; cv=none; b=c+Oab4CRQWwBIvURFQ8zBnwycPFWOTIxIhwVwSQMCERFWmyECb69SzS+glOVq+rineKUMaVUSvHbV1aI47/znfBG4Jy4Dl47VzoCoBlMQM0vyHFbPCmV42XI0Z6catMY2UjS+i2g2NYng0fHFHYGIAYap2sfZfPwGw6/dl8eVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895227; c=relaxed/simple;
	bh=MwePGutbbT7PIK/0uTad53W1JrjZIaN1M6GqaEtCdUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7rrkngnbmtMmR8APWLDKAjikEkSmlR5v+8AY1FMhdIi5136Vx61DnnqPFDiqhGGJCcnLNC7PzvoIGb2nUO2G/fXEvFb2xHr3wH6/zw49kthDQ5XlHuMIxpcWGH8dW1eB/iMi4nbWOvgm7c0IMMiRAM6CxbeLDd8n88TLkBOqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm0G8Db2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDCAC116B1;
	Thu, 25 Jul 2024 08:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721895226;
	bh=MwePGutbbT7PIK/0uTad53W1JrjZIaN1M6GqaEtCdUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fm0G8Db2vgIy3zmLfXjGqBj7ODGbUQvMLxT6PCT44WevvpCYO3VNkwLYh1SF+X4T7
	 1h99WMKKQsxxYT3M86IdnFKtLAVGVh0eAD7uYLDWQUCYujpOqv1XweMBhUHKbWiXql
	 /k9QVK+jDguxu4i7Ui6otwSHTrSuu5VEMa3M8x2BA2S5CvOUUAZH4dEJ+WhTskrXWD
	 WvqCSR1R2qwGKMIxDUNCq3oRSRqPo/8hYRuf1QK6Ab1zVxEuYb5FSiZxIOZS4z7kjf
	 9m0hY7tQUnszuALfJUe1DS42g3lY3bsQgv61LFu3re9OwZNK4uQfdMyYB5/0PeSMRi
	 MhaMF2DIpvwqQ==
Message-ID: <1b5847da-780f-47fa-a7a3-2d71f5905334@kernel.org>
Date: Thu, 25 Jul 2024 17:13:43 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>, rick.wertenbroek@heig-vd.ch,
 alberto.dassatti@heig-vd.ch, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan> <20240725053348.GN2317@thinkpad>
 <b2dab6f8-8d95-4055-8960-d2dabb5cf98d@kernel.org>
 <20240725074032.GA2770@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240725074032.GA2770@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/24 16:40, Manivannan Sadhasivam wrote:
>> Using DT for endpoint functions is nonsense in my opinion: if something needs to
>> be configured, an epf has the configfs interface to get the information it may
>> need. And forcing EPF to have DT node is not scalable anyway.
>>
> 
> Why? We are not using to DT to configure anything. If you try to use DT for that
> purpose then it would be wrong. DT is meant to provide hardware description. In
> this case, the EPF DT node can be used to describe the BAR address that is
> allocated (fixed) in the hardware. I did propose this in the previous Plumbers
> conf [1]. As I said earlier, this information is coming from the EPC node right
> now for MHI which has a hardware entity, but moving it to the dedicated EPF node
> would be the correct approach for scalability.

That does not make any sense. If we have a controller that has fixed addresses
for bars, then that is a hw property and that can go into the epc (PCI
controller) node. EPF is a software driver which has absolutely no business
having DT properties. configfs is made for that. And for special EPF drivers
that work only with particular controllers, e.g. your MHI EPF driver, the epf
can access properties of the epc if it needs information about the hardware
(e.g. a fixed bar address). The epf does not need to have its own node at ll in
the DT.

As a parallel, think of a DT describing a storage controller. The DT does not
describe the storage itself and much less the file system on that storage,
simply because everything can be probed at runtime from the controller DT and
the controller driver. Same thing here. EPF drivers go on top of EPC drivers and
their DT node describing the HW.

> 
> And ofc, that DT node *cannot* be used for anything else (like describing
> VID:PID in configfs etc...). As a nice side effect of the EPF node, we can get
> rid of configfs to create the link between EPC and EPF and start the controller.
> Again, this won't be applicable to non-hw backed EPF.
> 
>> So assuming you meant EPC, I am not sure if defining a fixed bar address in the
>> DT works for all cases. E.g. said address may depend on other hardware on the
>> platform (ex: memory nodes). So the ->get_bar() EPC operation that Rick is
>> proposing makes a lot more sense to me and will can be scaled to many many
>> configurations. Given that the EPF will (indirectly) call that operation, some
>> epf dependent parameters could even be passed.
>>
>> And I agree (I think we all do) that combing alloc bar and get bar under a
>> single API is a lot cleaner. Though I am not a big fan of the name
>> pci_epc_alloc_set_bar() as it implies an allocation, which may not be the case
>> for fixed bars. So a simpler and more generic name like pci_epf_set_bar(),
>> pci_epf_init_bar(), pci_epf_config_bar()... would be way better in my opinion.
>>
> 
> Well, the EPF driver doesn't need to know if the underlying address if fixed or
> dynamic IMO. It should just request BAR memory and the EPC core/controller
> drivers should take care of that.

Yes, I agree, and that is why I said that the name pci_epc_alloc_set_bar() is
not great because it implies allocation of memory, which may not always be
needed depending on the controller and may be on the function driver (e.g. fixed
bars using special memory).


-- 
Damien Le Moal
Western Digital Research


