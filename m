Return-Path: <linux-pci+bounces-14936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3709A6096
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ADB280D51
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6213198A0C;
	Mon, 21 Oct 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L36Q1KKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CB1799F
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504154; cv=none; b=Mm95JL/ACjhb6j3HVOXPMcSUeJTJWMp0CfYkXTotoc58TlzrleP5acBoTDTOKooAFjrydBrIg92W79BXQyo45lN33FywWC/v7DEJojFNcRR930GRtD3vFeTCyleHLqjAVWAo5J2gyC5UADgkjKDe4N8sh/lBuCP36rk9ocDqlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504154; c=relaxed/simple;
	bh=1xOsRMcKqDJcV3UAHe9Z0F1Aakl6aayX+U2Zco1j9zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icvQdzUDSD2Vkjp8UeNOMPe8ifMR66RRtpG3FzAa+egnvnt4NB/XzZZDzhTc95XlDMwDz2Lw/2Ol3eatI3yuEs8kmRzxCmBqcaLwP4HKuJNkgy2sj8OkOY51Osi6hpCSCaMRxJgkaiJuVOGmHWsJ0sxHsez5fOY31UenWS8xPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L36Q1KKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73857C4CEC3;
	Mon, 21 Oct 2024 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729504154;
	bh=1xOsRMcKqDJcV3UAHe9Z0F1Aakl6aayX+U2Zco1j9zQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L36Q1KKUrBaWgACTGMqMyj6m6itgM9XmAH/+NrbIuFVVHPA9u3n6Bzdf05jAh3FBa
	 ClmtGWP3fbnHYrG5/8I5It+WHvvetpl73OcBTRpQUHAdPcC7vuT6fNj7OpoRZ8Eyc9
	 h/WGugkDYCzRKJ6uLOJ7Erz8RRd7wCOF/AGTdIfdELZaPipNoveUU1ZeDP0piPXWV4
	 Nv/AkxUGTogFJKPmXDsCap3kMgxwqOfCRZDzBKiMIRdIFi0/KOfa+gM9ZKtRflx5Dg
	 MCN5fz3uK4ohJvLKWOO9qkLaL69stQXVrCje9m7LQEUwsjGwgb9SY14tuLxOB8RsLm
	 Z80WFM/8p5WAw==
Message-ID: <e6baa8a2-7c1c-4905-86a3-fb02c64637a6@kernel.org>
Date: Mon, 21 Oct 2024 18:49:11 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI endpoint: pci-epf-test is broken on big-endian
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org
References: <ZxYHoi4mv-4eg0TK@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZxYHoi4mv-4eg0TK@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 16:49, Niklas Cassel wrote:
> Hello PCI endpoint maintainers,
> 
> 
> While looking at the pci-epf-test.c driver, I noticed that
> pci-epf-test is completely broken with regards to endianness.
> 
> As you probably know, PCI devices are inherently little-endian,
> and the data stored in the PCI BARs should be in little-endian.
> 
> However, pci-epf-test does no conversion before storing the data
> to backing memory, and no conversion after reading the data from
> backing memory.
> 
> For the data backing test_reg BAR (usually BAR0), which has the
> format as defined by struct pci_epf_test_reg, is simply stored
> to memory using e.g.:
> reg->status = STATUS_WRITE_SUCCESS;
> 
> Surely, this should be:
> reg->status = cpu_to_le32(STATUS_WRITE_SUCCESS);
> 
> 
> Likewise the src and dst address is accessed simply by
> reg->dst_addr and reg->src_addr.
> 
> Surely, this should be accessed using:
> dst_addr = le64_to_cpu(reg->dst_addr);
> src_addr = le64_to_cpu(reg->src_addr);
> 
> So bottom line, pci-epf-test will currently not behave correctly
> on big-endian.
> 
> 
> 
> Looking at pci-endpoint-test however, it does all its accesses using
> readl() and writel(), and if you look at the implementations of
> readl()/writel():
> https://github.com/torvalds/linux/blob/v6.12-rc4/include/asm-generic/io.h#L181-L184
> 
> They convert to CPU native after reading, and convert to little-endian
> before writing, so pci-endpoint-test (RC side driver) is okay, it is
> just pci-epf-test (EP side driver) that is broken.

That in itself is another problem. The use of readl/writel for things in the EPF
BAR memory is also *wrong*, because that memory is NOT a real mmio memory. We
should be using READ_ONCE()/WRITE_ONCE() to treat the BAR as volatile memory but
not use readl/writel.

> 
> I'm not planning on spending time on this, but I thought that I ought to at
> least report it, such that maintainers/developers/users are aware of it.
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research

