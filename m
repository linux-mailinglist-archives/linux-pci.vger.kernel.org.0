Return-Path: <linux-pci+bounces-124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC917F3E7B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0847E2819C8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76D14F9D;
	Wed, 22 Nov 2023 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv6ROEJ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD469156CE
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F42C433C7;
	Wed, 22 Nov 2023 06:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700636390;
	bh=JNS80U7Zp2gQTubPxCkH5v5BQ20tt82AZXDTBCaU7dY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rv6ROEJ3ya/Uktuyt6skezrs2RfbjJk1V3sQ9hvJAhk6Kq7fecZC0at38mXrAQJuz
	 1Em+DGmOUV4TSd8nvwRqRAmpPVC2dA816x13ay6Bq5Fg5tqKp2izTPQaII2UxPhh8Y
	 McZHzenCyMWIaAtP8bI0atCZJ4ft2ZZHuCNMrwT/nOqEaiN7YlKVa84YMtb5d4UNgJ
	 NKspEf3rNe79+GTnbGVOPG2p07mtoEBOr3CZK+RFp6bTyQl4hEkwyWzIs7kcxbPfY9
	 zQq2ykALXh3QgQNkZxVne+oqkGM0d+ortQVkTXIziIyCX3oF0/CcxWD3Cqk3HevWx7
	 vqryN3QGwsAeA==
Message-ID: <3bb1f206-b709-4e74-a381-e01a8ad72e6e@kernel.org>
Date: Wed, 22 Nov 2023 15:59:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZV2lq6PcYwL5uCHr@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 15:54, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 03:49:28PM +0900, Damien Le Moal wrote:
>>> As mentioned in reply 1 I think this is perfect for a scripted run
>>> after -rc1.
>>
>> You mean 6.8-rc1 next cycle ?
> 
> Yes.  6.7-rc1 is over :)

OK.

Bjorn,

I can resend without this patch, or maybe you can drop it when applying. Let me
know what you prefer.

-- 
Damien Le Moal
Western Digital Research


