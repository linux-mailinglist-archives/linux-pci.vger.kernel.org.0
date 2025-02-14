Return-Path: <linux-pci+bounces-21476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD46A3624B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEDF18923E2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133BC267385;
	Fri, 14 Feb 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cOgvKaT2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571213234;
	Fri, 14 Feb 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548299; cv=none; b=oOdeob9aZsb93+rorVY7RE5dNBWEpC8jY/d/dZqFzq3RkXsri1xtQSItNqsE/hFnnazib2mCrtmNSSq2J4SMEXhXoRUjjECduvXXPLK+5cbHSpeSLu6gMnlUNSOQ+vGjBLWd5X+BGPipAm9LLSygUg3D9ym2rgOvXnruq24yCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548299; c=relaxed/simple;
	bh=IDTr1Eq3cziq+DUkNqSv2uD2a5GpF3XqUFMvXRcIcAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQk9OVcIclWOSdeIuj/Rg8WF0NSPYfJc1iqrp1gqyBv0SxjRVni/MDzy3LTVrwU07yFP+p74Bdna3ZM3rC/M3qb1jg2h8ensPW9MHp202oaTaea41lpmSc3oXcX+7c4etq2ifRoOvZIJpypgtO2EOD3pr3OZE/yEX3lw0I56FaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cOgvKaT2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ifmXkuEVqR4hvNL7Ti3tLm85mmbETlFEp0sPfcah6gI=;
	b=cOgvKaT21pxQzx1r0FRbiRUvxkkM0LYZvifYm1R9KLN5V3jr2UcS4qloeWdFS7
	eTAiuA/1wupeLxloNnxZFm9Sdh3rUdAhH/6SoOfa2bgY5ACeNtDPzTkBdTNjsaCa
	oXLM5gs+r/tEjHuy8rCrYAKjYh6fpRzLA1xiSewHp0AxI=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3+S_AZa9nvmfeMA--.26732S2;
	Fri, 14 Feb 2025 23:48:17 +0800 (CST)
Message-ID: <3d3d8772-08ba-4e5a-bf1f-71821cf056e7@163.com>
Date: Fri, 14 Feb 2025 23:48:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 bwawrzyn@cisco.com, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
 <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
 <20250214132115.fpiqq65tqtowl2wa@thinkpad>
 <332ec463-ebd9-477c-8b10-157887343225@163.com>
 <20250214153103.4cjlawksw4xobc2l@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250214153103.4cjlawksw4xobc2l@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC3+S_AZa9nvmfeMA--.26732S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur18JFyxCw1rAF1UGw4fGrg_yoW8Xr1kpa
	9xKa4Skws5KrZYvF1xZr1IqrnrGFWfXa15Cry8ZryFyws09FyFkryIka1jga4rGw1rAFWY
	vryjgFZrAa12vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwTzo2evZK4OwQAAsW



On 2025/2/14 23:31, Manivannan Sadhasivam wrote:
> On Fri, Feb 14, 2025 at 10:28:11PM +0800, Hans Zhang wrote:
>> Sorry Mani, I shouldn't have spread this SOC bug. This is a bug in RTL
>> design, the WSTRB signal of AXI bus is not connected correctly, so the first
>> generation SOC cannot send message, because we mainly use RC mode, and we
>> cannot send PME_Turn_OFF, that is, our SOC does not support L2. I have no
>> choice about this, I entered the company relatively late, and our SOC has
>> already TO.
> 
> Ok. Just to clear my head, this patch is needed irrespective of the hw issue,
> right? And with or without this patch, first revision hw cannot send any MSG
> TLPs?

Yes, that was a problem with our own SOC design, the Cadence RTL bug.	

> If so, it is fine. But is there a way we could detect those first generation IPs
> and flag it to users about broken MSG TLP support? Atleast, that would make the
> users aware of broken hw.

I don't know how to do it, but here are the questions that were actually 
tested.

>>
>> This patch is to solve the Cadence common code bug, and does not conform to
>> Cadence documentation.
> 
> you mean 'does'?
> 

What I mean is that common code bit16=1 is to send a message without 
data, while Cadence's development document says that bit16=0 is to send 
a message without data. This is not consistent with the documentation 
description, and the final verification results, the development 
documentation described is correct.

Best regards
Hans


