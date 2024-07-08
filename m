Return-Path: <linux-pci+bounces-9926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC092A1B5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41B9284B4E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A07FBC3;
	Mon,  8 Jul 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nc+paXFo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PRioF75z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990B7FBB6;
	Mon,  8 Jul 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439750; cv=none; b=jBQTKPh3I+ZqJwX8JMqwcJRpZ3iyDDjZIfs+HAV/z4VUtCH9Tat2B+eVqwxFb4+Ns0sRFcM3RHdcfMnZyscXxzOO7VOYz102A5eWgd8YOz55ExO/OkEQJMjDK56Mca/AfWU+1SGJQnhvM1e7IQuboQLkKk0rhIJRwvtTyuq+uUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439750; c=relaxed/simple;
	bh=svJk2a68EMvPk89NhoK9u0qey+5pU5BmhsmnZzUUpX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqhBPgTeEdcM+qV+bQPRgSKzRbVXTvFwf3iwQ6H6az4CDbAXYYeI/EkC3lO86sPwwjs1uzeGC4y1gD2AAb4CWKpGPVOO5SVG/z81KIhcdFRJo95HSmW1hWfyts7CgfJKwMbrIT43EWHoUflSZOIo0wZpp2tO7DKsUCyk8JE3//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nc+paXFo; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PRioF75z; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WHjHj22f5z9sb5;
	Mon,  8 Jul 2024 13:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1720439745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWAfYfaY0yizK6Woa1K0h62J6G5j6wjoIDC1zSclttU=;
	b=nc+paXFoiJ6MO7pRa/4FJbjQD07IyOGvO0JFV6dvJQDTnqYY0gtFclkjLWdSEu5v0r21Pl
	PZVGQl+//PHuCRNslbOqRh6tG9adyZ0g37PM+SFyzo6pgLSEFhr986GQBF/BhvecmsPXuD
	rEuV9ub3UYyfsCnapYxk4ItoBdahhT2mOyfFH89tgv+X5m+TidLHQgmSy+IcfGxyWcXVR7
	x/IPWLHYyD1ZQf+SUUPrNsxshZYCyti7zCqHomFyxcrE16fFRMKa1t/Qc0+pV5hgwVwRuE
	Kiv0B6l3Zu/MoI/danlzWeH4cTVJZezhPCxR4wFbBph/wkJRJALAi6rzy39t0A==
Message-ID: <43e4c568-083f-4b14-9f08-563ba6a71220@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1720439743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWAfYfaY0yizK6Woa1K0h62J6G5j6wjoIDC1zSclttU=;
	b=PRioF75zNznjMMWWIQchA+cYL7jATlGd1Gb/LPyaz19qiHgAxW5NT5YKdRSPepIy/Id+sv
	NQtRGs3qdVqfJSOfL6V8Iv0vKVekHIJIro4uK2qF5z/y6wpvbo6jV918YzsNzfInuOekFt
	nvBhZDMwf8jqHFFlmnce5n/4mzq0rQ3SLMSiRWJxARDajGm2TQCqJzWueEEOtlVLhJ7e+J
	oJe19ol9wOkdVT2m+L71AvAzuVJJ0rNuyyGcDnOZcaVRAIAa8FkC1H9EECbph8LTs+ys7x
	vxr70POMpWG0StzJ0DhdR/6MB0DGnYtbCC9965pgMlgl4M/1/AFsFMwGohl21g==
Date: Mon, 8 Jul 2024 13:55:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] [RFC] genirq/cpuhotplug, PCI/rcar-host: Silence set
 affinity failed warning
To: Thomas Gleixner <tglx@linutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Jon Hunter <jonathanh@nvidia.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20240706132758.53298-1-marek.vasut+renesas@mailbox.org>
 <87h6d1vy2c.ffs@tglx>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87h6d1vy2c.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fbspjz5oatamk7pou8zhtrktx5cmz91g
X-MBO-RS-ID: 5a863fed5a6295c1127
X-Rspamd-Queue-Id: 4WHjHj22f5z9sb5

On 7/7/24 8:47 PM, Thomas Gleixner wrote:
> Marek!

Hello Thomas,

> On Sat, Jul 06 2024 at 15:27, Marek Vasut wrote:
> 
>> This is an RFC patch, I am looking for input on the approach taken here.
>> If the approach is sound, this patch would be split into proper patchset.
>>
>> Various PCIe controllers that mux MSIs onto single IRQ line produce these
>> "IRQ%d: set affinity failed" warnings when entering suspend. This has been
>> discussed before [1] [2] and an example test case is included at the end
>> of this commit message.
>>
>> Attempt to silence the warning by returning specific error code -EOPNOTSUPP
>> from the irqchip .irq_set_affinity callback, which skips printing the warning
>> in cpuhotplug.c . The -EOPNOTSUPP was chosen because it indicates exactly what
>> the problem is, it is not possible to set affinity of each MSI IRQ line to a
>> specific CPU due to hardware limitation.
> 
> Why does the irq_chip in question have an irq_set_affinity() callback in
> the first place?
I believe originally (at least that's what's being discussed in the 
linked threads) it was because the irqchip code didn't check whether 
.irq_set_affinity was not NULL at all, so if it was missing, there would 
be NULL pointer dereference.

Now this is checked and irq_do_set_affinity() returns -EINVAL, which 
triggers the warning that is being silenced by this patch.

If you think this is better, I can:
- Tweak the cpuhotplug.c code to do some
   if (chip && !chip->irq_set_affinity) return false;
- Remove all the .irq_set_affinity implementations from PCI drivers
   which only return -EINVAL

Would that be better ?

-- 
Best regards,
Marek Vasut


