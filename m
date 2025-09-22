Return-Path: <linux-pci+bounces-36685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C406B91E0C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204A52A0AD3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F092DECB1;
	Mon, 22 Sep 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X+m03wCm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9E2820B2;
	Mon, 22 Sep 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554268; cv=none; b=P1/nvkgC+18W/yJ2voTmtS4I0rzGQckVZNAmGQfCYZwClWAzGkaOUVQdqSyXrGbz9kbTUwVGvuPxNSoU6Yd3+wEazidKEhq8npJ1SVTtEvk9PDRBLSCBp5fwqlEcXsAtQxs4huHKYUDkZgl5wYPYS2804AQdevCIWL6qqLxN1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554268; c=relaxed/simple;
	bh=MdE303L2jf4nU+Hx7xSbllxvbBaD9/9k3x17y6Zdap0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APMY4VFmT/F1UcWwzp1lMXDrlmopXF3wTB/fiSXJBZz6uNzJA2+kMQOvngRMzRSQsalF+/5vaxk0oa+lNU2kuEUJsUTr3VxsfN6jzGKf+5t3ovSN+wBNUL/tuBqHchvc+0EElA1BIf9HnuXoDvrVFT2mJzWZUgzl5fOdTEWaKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=X+m03wCm; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cVmvC0rphz9sX2;
	Mon, 22 Sep 2025 17:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758554263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9HzCu9fxdKzZx3H4fanu6rYT9Lj42sxXC+higvSiso=;
	b=X+m03wCm7T3J49DqAL2mzsmySlMb21ew3ZO2T1oWUBX5YvXDl4D5/I9HL1H6IEPp5B06vn
	d6wgz9yLoaQeP2UDOL7HXZAOoLm75ofpr3LKURwMwK8mKu+DW4U/4nKMiOtYriwLN2gzc5
	gpBuhXKF5PUjovrJTnP/rN0ApgQX23VTM8ka2bP8qiuAhYgT/Mqu0uuDb1xIl7A8TUoXQK
	d3o0NnE7DhNBvGtUHniE0Xk6sPkbQwOaEoULHUdJrYpYrefqwo7JnT/FBoVbwGz4vWl5t3
	sJNfzBYd3e9sZSuuYIAri+ojiXrwh4h/M3Ieq3FDUf/5KRUBhfBMhWlikurJ8A==
Message-ID: <3e6544a4-a202-4a1b-8cef-a864936db5f2@mailbox.org>
Date: Mon, 22 Sep 2025 17:17:39 +0200
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUnKqHQpaTkiuYUmR1kQ2GwVvj0SeML-9x3Rc+srtXW+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b9e099ba3a54f189132
X-MBO-RS-META: dtmfpu8wk5keobsmfim7o7csdd6p69oc

On 9/22/25 12:10 PM, Geert Uytterhoeven wrote:

Hello Geert,

>> I have instead posted what I think are proper fixes for that SError:
>>
>> PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
>> https://patchwork.kernel.org/project/linux-pci/patch/20250918030058.330960-1-marek.vasut+renesas@mailbox.org/
> 
> I used v3 instead.
> While that patch seems to fix the SError after a hard reset (hardware
> reset), it is not sufficient after a soft reset (typing "reboot").
> 
>> clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
>> https://patchwork.kernel.org/project/linux-clk/patch/20250918030552.331389-1-marek.vasut+renesas@mailbox.org/
> 
> This does not fix the SError, as expected (pcie-rcar-gen4.c does not
> call reset_control_reset(), but reset_control_{,de}assert()).
> 
>> clk: renesas: cpg-mssr: Read back reset registers to assure values latched
>> https://patchwork.kernel.org/project/linux-clk/patch/20250918030723.331634-1-marek.vasut+renesas@mailbox.org/
> 
> I used v2 instead, which seems to fix the SError.

Those three patches have to be used together, and this inverted break 
condition fix should be applied too.

The first two are corrections which align the code behavior with 
reference manual. This inverted break fix is another correction. The 
last patch in the list above actually fixes the asynchronized reset 
behavior and turns it into synchronized reset behavior, therefore fixing 
the SError in the process.

-- 
Best regards,
Marek Vasut

