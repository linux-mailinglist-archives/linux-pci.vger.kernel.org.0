Return-Path: <linux-pci+bounces-36695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B404B920D0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BE57B24D9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A91D30C612;
	Mon, 22 Sep 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UGWLSg85"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618443043AF;
	Mon, 22 Sep 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556182; cv=none; b=AuubtDTRyIMpfEcNqDZLW8TUidgUNwgKTSZz7dmHcZfCTaWgwN+YK6IReEZa1pe10RHf9JuAnEC2KeeUzVysbimWYW1r/EMhuYAqWmZ/xaTSZmNmVSAv6HaE4HYPrNbjROPFZcF9IAohLYDTzze2yINN3yJpTWUuK1rXI1lJ6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556182; c=relaxed/simple;
	bh=6v63gcck4IdmcUss0gS+xnAwi2ypo7VV2cbS2eFvqzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FC5HEpuaPHDuRyalRvr0wRAWbaqfa5OO+HSj6X/Tz9nap5eybx944wK7RwdFHTH4UDyZDujpKVTgnEVnWt8toziTN1HeX3fZDNFo05IenOkd3v1UT45a2d+tuk871UVSCfZwlsQcu1Fz2drdaAFifXSc62rPLBxAy8NGAn88yC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UGWLSg85; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cVnc13Bdbz9tQs;
	Mon, 22 Sep 2025 17:49:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758556177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMSiwDHMdiBzB9w1xv0vr5ZmlYI62jGSNhhuXuilP0k=;
	b=UGWLSg85wjKNKW1OEWsiZdg2gYaxpk8LlMUCrOEvNPrGaJtWJvNOLputAaZC1++F1hgyVj
	JtJZsmc7PQzyljacRyNgDeq20MoI9v0fHgY+kjRiidpbQ//Ksm9B9B9IVCnkEPctrtDIC7
	gGcgfJQa+h3xq21bBnpCnjWMkr4LcyMrLjAKxbZQgKVrLjxpqIwpG4mk4lWnp3FlsB+6jz
	eeT1Qf5GDw2Gxvea4KtihMqWqMu1W0GndP78SeNqlcTGoiqXyNaPtB87rlVygddybMjpkV
	TTa/3jR8D3Vmjc/V36Z5OhQRCQMCL/aQI+ZXDXjsujFZK5ZTis36Vxkhu/qF3g==
Message-ID: <c34424d5-b1ac-483e-a1e1-8dd8bfdc2c51@mailbox.org>
Date: Mon, 22 Sep 2025 17:49:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
 <6fdc7d1e-8eaa-4244-a6b4-4a07e719dd73@mailbox.org>
 <CAMuHMdVrw1Mr_hKvgve03DQwvpqSPNaN5XUnYRJPXMeX1wvv0A@mail.gmail.com>
 <de4e4003-214f-4260-854c-d15efc81bb74@mailbox.org>
 <CAMuHMdVgFNb-3TgL7a+AJMYE6tqOiMpGYFDhXnQoz9R5gLz=-A@mail.gmail.com>
 <12b54030-5505-416b-9e4e-2338263c5c7a@mailbox.org>
 <CAMuHMdUnKqHQpaTkiuYUmR1kQ2GwVvj0SeML-9x3Rc+srtXW+w@mail.gmail.com>
 <3e6544a4-a202-4a1b-8cef-a864936db5f2@mailbox.org>
 <CAMuHMdUZ0U4OZOgOMXVKque55JwuSjA7kxBg7htmFjzca6+DyQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUZ0U4OZOgOMXVKque55JwuSjA7kxBg7htmFjzca6+DyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f137d8bedb6dea5bb3f
X-MBO-RS-META: ewya93e5otsbcmyrpq8ipiuqh9w9opna

On 9/22/25 5:33 PM, Geert Uytterhoeven wrote:

Hello Geert,

> On Mon, 22 Sept 2025 at 17:17, Marek Vasut <marek.vasut@mailbox.org> wrote:
>> On 9/22/25 12:10 PM, Geert Uytterhoeven wrote:
>>>> I have instead posted what I think are proper fixes for that SError:
>>>>
>>>> PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
>>>> https://patchwork.kernel.org/project/linux-pci/patch/20250918030058.330960-1-marek.vasut+renesas@mailbox.org/
>>>
>>> I used v3 instead.
>>> While that patch seems to fix the SError after a hard reset (hardware
>>> reset), it is not sufficient after a soft reset (typing "reboot").
>>>
>>>> clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
>>>> https://patchwork.kernel.org/project/linux-clk/patch/20250918030552.331389-1-marek.vasut+renesas@mailbox.org/
>>>
>>> This does not fix the SError, as expected (pcie-rcar-gen4.c does not
>>> call reset_control_reset(), but reset_control_{,de}assert()).
>>>
>>>> clk: renesas: cpg-mssr: Read back reset registers to assure values latched
>>>> https://patchwork.kernel.org/project/linux-clk/patch/20250918030723.331634-1-marek.vasut+renesas@mailbox.org/
>>>
>>> I used v2 instead, which seems to fix the SError.
>>
>> Those three patches have to be used together, and this inverted break
>> condition fix should be applied too.
>>
>> The first two are corrections which align the code behavior with
>> reference manual. This inverted break fix is another correction. The
>> last patch in the list above actually fixes the asynchronized reset
>> behavior and turns it into synchronized reset behavior, therefore fixing
>> the SError in the process.
> 
> FTR, I always had the inverted break condition fix applied.
> All 3 fixes on top should be fine.
Maybe I can finally properly deserve your TB on this patch with this 
option (C) , all three patches applied.

