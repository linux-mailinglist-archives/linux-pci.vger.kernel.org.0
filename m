Return-Path: <linux-pci+bounces-122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F157F3E54
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469D11C209B4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC88210A;
	Wed, 22 Nov 2023 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtKDK7vZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CC46BB
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56563C433C7;
	Wed, 22 Nov 2023 06:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700635771;
	bh=co/anglSi1fFQO2fJgyZclDdGZ+E3NnGb3jtDuWUJcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NtKDK7vZ5zG50iSrTjXxtw2OOeq8FDzYiwMCWfTE3LJygWndNJ+fyBqHbkCK5Hmoj
	 4q1iqn/18kR2Wue66kojRynM4Bv+GMLmmB+2aA1hkMnMIPZhGoxTpejbkPeIYgMLyA
	 Z0grz3SnNPSztqU+TSQ+w3L1mSNAdDh+fW90/eHNj1+3TFwp5QnjOju+OhrH/wlBwn
	 nNEHphHz+TyAdQyD6oX/tYqKCwZEcbh8AxQUdzO0xMhZRUuiLDdgKQ6uAZkkn6iUKO
	 vaU6G41wHVyfVGVcfEiTn5g/7Tsgalq0whdbmKdsWG9MswQ4zvloQrSchVA+33Bp7s
	 RWzPrPOTdc2WA==
Message-ID: <d7c8ff12-279e-4201-8987-92de01e8ecea@kernel.org>
Date: Wed, 22 Nov 2023 15:49:28 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZV2hZ+0jRQUJqMH6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 15:36, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 03:33:04PM +0900, Damien Le Moal wrote:
>> On 11/22/23 15:23, Christoph Hellwig wrote:
>>> On Wed, Nov 22, 2023 at 03:22:54PM +0900, Damien Le Moal wrote:
>>>> I did not want to go as far as changing all drivers everywhere and limited the
>>>> series to drivers/pci. We could do a coccinel script for everything else.
>>>
>>> Yes.  This is actually even trivial enough for sed :)
>>
>> Surprisingly, only 44 files use PCI_IRQ_LEGACY. Let me see how a patch look
>> with the change.
> 
> As mentioned in reply 1 I think this is perfect for a scripted run
> after -rc1.

You mean 6.8-rc1 next cycle ?

> 
> I'm actually surprised PCI_IRQ_LEGACY is used even 44 times.  There is
> really no point in using the APIs based on PCI_IRQ_ for legacy irqs,
> and the case where it is just supposed as a fallback are covered by
> PCI_IRQ_ALL_TYPES.

I had a closer look and if we want to do this correctly, there is more to do
than just the rename of PCI_IRQ_LEGACY to PCI_IRQ_INTX. There is also
NR_IRQS_LEGACY, some Kconfig options, functions that use "legacy_irq" in there
name, etc. A big chunk is just the rename, but some drivers will need finer
handling as otherwise we'll endup mixing up intx and legacy in the same code,
which is not pretty/confusing.

-- 
Damien Le Moal
Western Digital Research


