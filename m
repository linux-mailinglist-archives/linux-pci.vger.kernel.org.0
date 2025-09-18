Return-Path: <linux-pci+bounces-36446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56EB872B8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 23:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9C27A4556
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019522FA0C6;
	Thu, 18 Sep 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ssVJN7RM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DnNvpYIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CD2DAFA5;
	Thu, 18 Sep 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231718; cv=none; b=sNPoOL4RtF/0DGbsbjkO1kUuG/d6fwv4/HIC3YBb7x3o703eCr6WA/cF2EFQBLve0tY8dPrh0y4k8Cb7qPPx9lIIJiz4xIz8xLij4592cBnGfVL6P9TEh7g1xU+NihR95DL6A1Lef7/77DYUizAYb66+JUJpI9caKS+EGP1qtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231718; c=relaxed/simple;
	bh=fQWqwO+IY90WkL9HuMehtFEhCqsAL8G/tYqXfD3H99M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr/MCXur+rU22rsMA36ZzsBojDOBWEya0lRRapET0vdilj6DAnmIedhlP75sNuWupSz0umMy+l+1JEx61P5UhTWXTo7qvZo63NdIfzo4ONkiy0LNNnz5eYVa4ZxBqu54QaE7Eddav6JjqRGr42B4SVhh3X8Z1i1FRimuuyXDqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ssVJN7RM; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DnNvpYIV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSTcL15NSz9tcg;
	Thu, 18 Sep 2025 23:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758231714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqGuZKA6c1No0HtARiiZ7b/FNkRUJ8+YJVLSsjHRpys=;
	b=ssVJN7RMnEz7VXAVFk++4c3g+Sw0k7Lb0OuJl4JGZBiPHqgQpP7TopaknKXnbapOoSyzUb
	O33Si/t4bn99cUD/M8gpsnTTA9vo69MjO0r3pxxDxibvn8oF5DJBNasF3Ri5p1G896DSs8
	1qVlm2GSVTGAEXwLMS+koh9tGQI0qrbRwfTYQfUG41opUjM8UYRkaV+3qyswZZjFYRp5XX
	+7eS/LvpRQk3lhWPuF5wKuj9139U2O+Hleo/XvK90aY5+jMSuz52FNQaHimtGeO+z8/11J
	ymLXiKh+gCCfHpQwZogcV35lsSO+I779Wc85HhoWA2M3UMhaAWqQzTHummIUGQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DnNvpYIV;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e7dadf6d-b89f-4054-91d6-5452012b6dd7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758231712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqGuZKA6c1No0HtARiiZ7b/FNkRUJ8+YJVLSsjHRpys=;
	b=DnNvpYIVbmrbXkWDf8owhRDoO1PTHK4bQJRoqbSfm2x9qMEwPW23c9Q4jdUipnMwMWPQ59
	eQH1R6PQco9e2SmSWg8iXpY68Pk7lr+3lLKd7ol2SBCU1Kcm4kfj+qETQd63BriK0AhmYh
	rr1TMOr9rd1Z793N8iyZqS+ehK8cs2u9mo5gGaPEgvOze8MAw3F+YMmLTQq6PUVVn8qx3h
	93GPkK/ieveHomPLj18UmnPbNsInfwRTYS1mAKTAmumPDX9dlqIolEOmb9IjzXYAbJ+f9N
	XY5Q3egYplyWVerUJfKTVcOWsVTF2jxFPE6CJH3butyTZF0LRIprN50hjrDpag==
Date: Thu, 18 Sep 2025 23:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250918204416.GA1921028@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250918204416.GA1921028@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b151e38783d1c17a838
X-MBO-RS-META: kiczounzyu9uh8gm9d3jms5b8wdagr73
X-Rspamd-Queue-Id: 4cSTcL15NSz9tcg

On 9/18/25 10:44 PM, Bjorn Helgaas wrote:
> On Thu, Sep 18, 2025 at 10:35:08PM +0200, Marek Vasut wrote:
>> On 9/18/25 10:04 PM, Bjorn Helgaas wrote:
>>> On Thu, Sep 18, 2025 at 05:00:26AM +0200, Marek Vasut wrote:
>>>> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
>>>> Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
>>>> domain, after reset has been asserted by writing a matching reset bit into
>>>> register SRCR, it is mandatory to wait 1ms.
>>>
>>>> @@ -182,8 +182,10 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>>>>    		return ret;
>>>>    	}
>>>> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
>>>> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>>>>    		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>>>> +		usleep_range(1000, 2000);
>>>
>>> What would you think of "fsleep(1000)"?
>>>
>>> I know there's controvery about fsleep(), but while the 1000 usec
>>> lower bound is important, I think the selection of the 2000 usec upper
>>> bound is pretty arbitrary and doesn't really justify spelling it out.
>>
>> The upper bound is arbitrary.
>>
>> My reasoning for picking up usleep_range() is to give the kernel
>> sufficient space to pick the best fitting delay in that 1..2 ms
>> range, without constraining the timers too much. In other words, let
>> the kernel pick the next easy to use timer tick which guarantees at
>> least 1ms delay.
> 
> Right, basically the same motivation as fsleep().
> 
>> As far as I can tell, fsleep() in this case would add a bit of
>> auto-detection overhead, and then select equivalent of
>> usleep_range(1000, 1250) , wouldn't it ?
>>
>> So I think using fsleep() here would add overhead, but not yield any
>> actual benefit. Is my understanding and conclusions correct ?
> 
> I think you're right that fsleep() will pick usleep_range(1000, 1250),
> so it's less optimal in that sense, but I think optimization like that
> would be better done inside fsleep() instead of everybody doing it ad
> hoc at the call site.

Lemme do V2 with fsleep() then.

> I don't think fsleep() should add any overhead since it's inlined and
> all the delays are constants.  But I haven't actually looked at the
> generated code.

You're right about this part.

