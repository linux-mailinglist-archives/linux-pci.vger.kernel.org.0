Return-Path: <linux-pci+bounces-1201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EDA8197DA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA80B247A7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 04:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D917C4;
	Wed, 20 Dec 2023 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjpFOAr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3111715
	for <linux-pci@vger.kernel.org>; Wed, 20 Dec 2023 04:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3080C433C8;
	Wed, 20 Dec 2023 04:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703047312;
	bh=fz0LA/XlOpEEojEtQbPUl5nV8aZvIzF9DPdiW4C1zw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QjpFOAr7TYzghRmNR/athyLWVKMRqJs0WxBQb0DM3ZtwcNpp31kZsgeXYeWpX54v+
	 MWh8phtLF5vnUA/w0hkGJ/QJpo8Fv4EIvJAI4XS1nDodQaQVwump85eIezNwCtQtWU
	 kuri3GjTBBsPb/tJZWqp3OMqonoWH8wg9ZEXSC65xb02SirEQSxm6etI7w+NrVstyV
	 WgZwtr3yh3IZzD07upLeZePr0ZUtjN9yEoR/gNp5uKYAJpdLeRTKizvF0CwpD7OnC2
	 Lz77vCBrT/12dhdI1mBgVRoc7Sjx7wlvNXRiXoBte+S9j3+8pG2CcsFGutX/eOTIa/
	 4abCxDEzUTK6g==
Message-ID: <60026c3d-49b6-403c-a5aa-7030d3ce349d@kernel.org>
Date: Wed, 20 Dec 2023 13:41:50 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-7-dlemoal@kernel.org> <ZV2c3oAHtmmYgSGn@infradead.org>
 <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
 <ZV2eY8iH41eOSgIZ@infradead.org>
 <d8e64422-d332-4c99-88bc-85f6e2077c32@kernel.org>
 <ZV2hZ+0jRQUJqMH6@infradead.org>
 <d7c8ff12-279e-4201-8987-92de01e8ecea@kernel.org>
 <ZV2lq6PcYwL5uCHr@infradead.org>
 <3bb1f206-b709-4e74-a381-e01a8ad72e6e@kernel.org>
 <ZYFrTTDizjf9ME2M@lpieralisi>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZYFrTTDizjf9ME2M@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/23 19:07, Lorenzo Pieralisi wrote:
> On Wed, Nov 22, 2023 at 03:59:47PM +0900, Damien Le Moal wrote:
>> On 11/22/23 15:54, Christoph Hellwig wrote:
>>> On Wed, Nov 22, 2023 at 03:49:28PM +0900, Damien Le Moal wrote:
>>>>> As mentioned in reply 1 I think this is perfect for a scripted run
>>>>> after -rc1.
>>>>
>>>> You mean 6.8-rc1 next cycle ?
>>>
>>> Yes.  6.7-rc1 is over :)
>>
>> OK.
>>
>> Bjorn,
>>
>> I can resend without this patch, or maybe you can drop it when applying. Let me
>> know what you prefer.
> 
> Krzysztof diligently made me notice, thanks.
> 
> I have now dropped it and repushed out the resulting irq-clean-up
> branch.

OK. Thanks. I will work on removing what remains of "legacy" naming once
everything is in linux next.

-- 
Damien Le Moal
Western Digital Research


