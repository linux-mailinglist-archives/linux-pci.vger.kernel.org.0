Return-Path: <linux-pci+bounces-36287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C8B59F8C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B8D1C04D05
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46081261B65;
	Tue, 16 Sep 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EQXTBjlM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE132D5AA;
	Tue, 16 Sep 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044356; cv=none; b=ZIQFPI7X5URfXZATDLAjEonL1CK67TL7JLVEVfFGzjgyG1njAoC4UDrD9g13jT2QqmMF9n5HO0Nwi4HAa4ZjxDe7dNwl6lEsY1zLlpowIxSRWeN0rSU409pSTdZWHec+kYXZdacU/khfHJDdnyOH9KhEBzv8pXslLaRxSR0JaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044356; c=relaxed/simple;
	bh=2I1gVgaz9JZmo0V1wFV9xBcLNHnMqUrsYTBwIhXPNh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTCeIGLN+2eu/6lJ8V+xbFxaWL/XFJ2RlJyDRAS5FawvT+q6thLBLpsF5+r68TXR//T/gjXezkOcpIAQXm9UM24SFGHyGFUX1syZT+fbp3/J4vCYnj2TWULZ+uXUDeu4Apcw0+VGg+lGSMz0mscQdI8uN9v6GQd1W3PJP3XRfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EQXTBjlM; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cR8KB5zzQz9t8x;
	Tue, 16 Sep 2025 19:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758044350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iy+diz1IFg9aObDq0ylETHFNNDzHn78HPNeZm0rB0Sk=;
	b=EQXTBjlMO19X1pbJvpbj8gQRklZ2zQMJi0oQP8rutPB9ntziMJ5hSRJEgqAKB2GO/Fn+NZ
	zqbtv1dnlt+7A3I2ERpaUuTCptwdvab1hR1Z71cww6x5preEQtSqXkOnMZznNwx6bBITVD
	gwGOt2JLF+9u6iuCn/67FZgXFRfTuA7gKTLF8DhcyYG8BRvZr6/AuIlQdZuU5RN0eMc7vm
	yq4u1WqYEaKw0qnbA7hsibKqF2djcre8rZVZk+iXGQ8whL/1NjfuFigfagq/PIfY+UwQOC
	9f5nrg3H1Vo+3py15+49e6X/weR7lZmwHIQ+tv/sow5NTOsFo18g+M8Ff0E9aQ==
Message-ID: <ab002c9a-0c9c-4d8f-be5d-b2694175cc86@mailbox.org>
Date: Tue, 16 Sep 2025 19:39:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250916171312.GA1808058@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250916171312.GA1808058@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: daeedef892919c07b86
X-MBO-RS-META: m4rkq7aibx3jdynfwf5saoajtbdypwj5

On 9/16/25 7:13 PM, Bjorn Helgaas wrote:
> On Tue, Sep 16, 2025 at 06:31:31PM +0200, Marek Vasut wrote:
>> On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:
>>> On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>> On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
> 
>>>>> This change looks correct, and fixes the timeout seen on White Hawk
>>>>> with CONFIG_DEBUG_LOCK_ALLOC=y.
>>>>> However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
>>>>>
>>>>>        SError Interrupt on CPU0, code 0x00000000be000011 -- SError
>>>>
>>>> ...
>>>>
>>>>>         el1h_64_error_handler+0x2c/0x40
>>>>>         el1h_64_error+0x70/0x74
>>>>>         dw_pcie_read+0x20/0x74 (P)
>>>>>         rcar_gen4_pcie_additional_common_init+0x1c/0x6c
>>>>
>>>> SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
>>>> this fix.
>>>>
>>>> Does the following patch make this SError go away ?
>>>
>>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>> @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
>>>> rcar_gen4_pcie *rcar)
>>>>            if (ret)
>>>>                    goto err_unprepare;
>>>>
>>>> +mdelay(1);
>>>> +
>>>>            if (rcar->drvdata->additional_common_init)
>>>>                    rcar->drvdata->additional_common_init(rcar);
>>>>
>>>
>>> Yes it does, thanks!
>>
>> So with this one extra mdelay(1), the PCIe is fully good on your side, or is
>> there still anything weird/flaky/malfunctioning ?
> 
> Do we have a theory about why this delay is needed?  I assume it's
> something specific to the rcar hardware (not something required by the
> PCIe base spec)?
> 
> I'm seeing SError interrupts and external aborts on several arm64
> systems and I'd like to understand better why they happen and when/if
> we can recover from them.
The SError here happens when the PWR RST is released and DBI is accessed 
rapidly right after that. The current hypothesis is, that the controller 
core needs a bit of time to initialize itself after the reset is 
released, before DBI access can be performed ; if the DBI access happens 
too soon after the reset was released, the core reject the access and 
CPU interprets that as SError.

The reference manual however does not list any such delay, which makes 
me concerned. I can send such a patch which adds the mdelay(1) as a 
temporary stopgap fix, until some better explanation maybe sometimes 
gets uncovered, if that would be OK ?

