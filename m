Return-Path: <linux-pci+bounces-18105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3889EC819
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3701528A98A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23881F4E3F;
	Wed, 11 Dec 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="inqpUsRS"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9221F2C34;
	Wed, 11 Dec 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907577; cv=none; b=Rhfj4sET8WIoKynFJoaAZ4vpf2L+AWvIrZWdG/pyAr3wTAtpIU94pMVGsSClUDMKhg7bR8zpNR7fVMi4CPaPa8+MAlHWP7EVTi2Jmulc3QcdizRj0CXK8hSVuNuVKkI+DJ1KW8+4ViHT18QALIUisJ63jm1dz6F4vEvlGZLKAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907577; c=relaxed/simple;
	bh=KiAaTnVSSd85L0rj+ElUu1otrbTPLtYknduDK1b4JMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jle7UuHNWy2WtWNrSjh1JhgOCderAqvFk9+pBrQ3l/KYdAsFdJwxSga170yd0iQESal77vXu2sxj/n7nbAU4Kh0dHCl2TgjceW5bjzaktL0z/6CTBBo+xn24iWMxupc5lODMN16AvXB2wp1+hpq4hJqRZ0+Wu8w9A9MJDwwNG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=inqpUsRS; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00A31C0003;
	Wed, 11 Dec 2024 08:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733907572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7ZdFIOQHwqPMa8tmn8WeXqIrLZITf12PwojoLtVGX4=;
	b=inqpUsRSkcB94b7GwsAZU21kVVmqOTI5L/EzRdBn2l1edxocTCTwL/1DjHvKKl+mggFx00
	fNfHWoIT0JqNCHI5IrLq89sAfDkIxUEizzwXYoAzfsI1+ETRMTuVt5XHoaG+f0BdP18b5s
	3WcDWQ9AVc3t4Z9jKVtLII5FTG5dihFuyLgXJGherdEzYefBDYRAt5vfORUpMFM49zJRVN
	nSorMiqf7toaKTsXLKHpsSZWQRgw6yfUCmURYPVbnfJZWL5e76boJ0ZIE/qcTOShiA9UBN
	8ltMQx0Q8+5N2Fi6lKAvOjJWdSlZDTdxG/etmfwyeZhv8ASwtw1M4ShI/WHaGQ==
Message-ID: <6c7cb07c-af9e-4f69-84df-2b59a57e4182@bootlin.com>
Date: Wed, 11 Dec 2024 09:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: j721e: In j721e_pcie_suspend_noirq() check
 reset_gpio before to use it
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: vigneshr@ti.com, s-vadapalli@ti.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com,
 kwilczynski@kernel.org, linux-omap@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, u-kumar1@ti.com
References: <20241210154256.GA3242512@bhelgaas>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20241210154256.GA3242512@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 12/10/24 16:42, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2024 at 12:23:21PM +0100, Thomas Richard wrote:
>> The reset_gpio is optional, so in j721e_pcie_suspend_noirq() check if it is
>> not NULL before to use it.
> 
> If you have occasion to post a v2, update subject to:
> 
>   PCI: j721e: Check reset_gpio for NULL before using it
> 
> s/before to use it/before using it/
> 
> Did you trip over a NULL pointer dereference here?  Or maybe found via
> inspection?

By inspection

> 
> It looks like gpiod_set_value_cansleep(desc) *should* be a no-op if
> desc is NULL, based on this comment [1]:
> 
>  * This descriptor validation needs to be inserted verbatim into each
>  * function taking a descriptor, so we need to use a preprocessor
>  * macro to avoid endless duplication. If the desc is NULL it is an
>  * optional GPIO and calls should just bail out.
> 
> and the fact that the VALIDATE_DESC_VOID() macro looks like it would
> return early in that case.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?id=v6.12#n2316

Oh yes you're right.
In fact, the if statement in probe() and resume_noirq() is for msleep(),
not really for gpiod_set_value_cansleep().

So this patch is useless.

Regards,

Thomas

