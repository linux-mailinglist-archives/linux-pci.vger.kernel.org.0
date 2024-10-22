Return-Path: <linux-pci+bounces-14969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C79A979F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EAD1F20F69
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 04:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34D186A;
	Tue, 22 Oct 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHgKUbHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA917FE
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570546; cv=none; b=TMtuvgrLf3iLEW4uXCT4X+tQaKuWqXiwXOz7Fa6O1LE6xK+RTBc8v2DtbmepTLloK20UGwyYeyLU24re4mwyo1pxmiUS6hROoyAqoMmm/s3rfwLuHiR4HNpPK+82Te78SP43p7g/uokq+8IxoYqby7v4V1AdqqT2TzTnK2HYrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570546; c=relaxed/simple;
	bh=R89j/voqRlcB/gFnZuFQvc/4d5Gx9uqtTD2yQ82JhrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB8kfdVotW3nqnprSZSipwqp790jAEzk1Agc4N/OIg9fy/YRiRwFcuiuyhLEI5ETyhk5nn4ZfjkLX+26csOLAXBWIWO4kkJDm3jcPIIHfQ1fovFmamb75NFSHKFgLw6on5OiKk/KPVQJqqEZREvaUAt7czF27RI957DOKiouvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHgKUbHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E680C4CEC3;
	Tue, 22 Oct 2024 04:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729570546;
	bh=R89j/voqRlcB/gFnZuFQvc/4d5Gx9uqtTD2yQ82JhrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GHgKUbHy7PEpwWmn6Zht4ytPOHrcRBQZZS1rThhM+c6tLr21BIjzcfsNDJlcEelb3
	 +kL0Mw2dMXgkhijoUz2vYwSjN3+TZ8QC5qxujFpjvZUFGFvSQhBghbWj4nCs9lbZTq
	 gSXFwtSD2s1DES9qouU47OXjBhkf0i40hBKAS5Yps4JA7NCNk16Z22IP1y+hH1u8j2
	 AuibvNm3XS0e3tSN0NAEGIRCAoHyvLZu1/w7K/pvvEiuXA5rdBuVBVzUVexJoKlQ7L
	 VDHLpo6daaBF2elbutFdRpv1N60keKh0dVx/qf8jjEpvh2IkmZ4eoXGeBuXaMia2El
	 TerOnjwU3kNsA==
Message-ID: <bb16f96a-94d2-44bd-9856-41ef1da2fa64@kernel.org>
Date: Tue, 22 Oct 2024 13:15:44 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI endpoint: pci-epf-test is broken on big-endian
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-pci@vger.kernel.org
References: <ZxYHoi4mv-4eg0TK@ryzen.lan>
 <e6baa8a2-7c1c-4905-86a3-fb02c64637a6@kernel.org>
 <20241022032624.trhqdgpewaesnje5@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241022032624.trhqdgpewaesnje5@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 12:26, Manivannan Sadhasivam wrote:
>>> Looking at pci-endpoint-test however, it does all its accesses using
>>> readl() and writel(), and if you look at the implementations of
>>> readl()/writel():
>>> https://github.com/torvalds/linux/blob/v6.12-rc4/include/asm-generic/io.h#L181-L184
>>>
>>> They convert to CPU native after reading, and convert to little-endian
>>> before writing, so pci-endpoint-test (RC side driver) is okay, it is
>>> just pci-epf-test (EP side driver) that is broken.
>>
>> That in itself is another problem. The use of readl/writel for things in the EPF
>> BAR memory is also *wrong*, because that memory is NOT a real mmio memory. We
>> should be using READ_ONCE()/WRITE_ONCE() to treat the BAR as volatile memory but
>> not use readl/writel.
>>
> 
> Not at all. The memory returned by pci_ioremap_bar() is annotated with __iomem,
> which means it should *only* be accessed with the relevant accessors like
> readl(), ioread32() etc... The memory is still treated as MMIO, so all the
> restrictions (alignment) applies to it also.

You are talking about the host (RC side) ? I was talking about the EP side...

pci_epf_alloc_space() returns a "void *" pointer, and the same is true for the
dma_alloc_coherent() call that actually allocates the BAR space. So on the EP, a
BAR memory should be treated as regular memory, but "volatile" since it can
change under the driver (due to the host writing to the BAR). Hence
READ_ONCE()/WRITE_ONCE() is the correct way to access a BAR on the endpoint.

And yes, readl() and friends are for the PCI RC (host) side, that I know.

Sorry about the confusing comment. I was thinking about the EP while reading
Niklas's comment :)

-- 
Damien Le Moal
Western Digital Research

