Return-Path: <linux-pci+bounces-10264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3893142C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0BB280F6F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EF18787F;
	Mon, 15 Jul 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wMuqxhom";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wpTJ/K+s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455E13B295;
	Mon, 15 Jul 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046397; cv=none; b=sRMv+aElR0Epfeu5DcTCtiqD/sOS2JmOwfCk+PH+dQJEIY6FdjFJsks6/KUsUbNHxLO2oSp3q6fJT87Vk8u3VQUJr9eH4DcdlLwT5zep499k+PgKk7VlnYffZstkqt/rOGuDuOBuXTSPMgT9Sx+fvRwePSjblO0hkyM2O3I9s7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046397; c=relaxed/simple;
	bh=vPW7JAF6bYAUWq5ndRyxC0bBzDNzXxdx/wR3+iiqHfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJNNlrdXV9aKJ7dDUMYENPuKRzYJauU5HwhmsenI0KY6c1e4au3pxicsvhLpwyHStKreRY1US667+dPIFqZ7yaj8qhDz34z5MrZB5UJiI1r2mt5PTLU1b2YxyEAl/941kA1YzzJpc5tRDllMCtQv1fRUO0TBZOHvRQj/Tg2h2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wMuqxhom; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wpTJ/K+s; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WN1f075QZz9sNb;
	Mon, 15 Jul 2024 14:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAYtw0P54MFPhiA1yNO4FQTOtoDQDCXNbjWPVB1cXx0=;
	b=wMuqxhomrJ6BipJvBccdLLORTVBwFh0KARw7lV3P2omP1AWa8o0TEKXVy0vLnXSrSbaGkf
	IqWX9oIw3waZaAQJKeYNJfGab9KGbI4YHZ0i5RkWoo+4n5sW+ylmlcD6SVhNqR2+QUK0BI
	BvOrhKau+zwVzupU0igkXw+ZbvaPOD467wdwk+P5NIJIvO2jAo9Q7Otd4+3qqm6CgR0GdG
	S9rbCuuwBoNBc/sqpeWsS4TY+u/r/T1fomD+770aP6GPeipIQxQwO1nUazAIWo5GVApzHn
	3nQyVVgl5Fkt2XFdNNFn9yXuo0pPh959hByHjE7nKtLBMpFZBvjUfPo8UheSqw==
Message-ID: <d5efcb28-dd5a-4b96-aabd-c73c95dff8e7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAYtw0P54MFPhiA1yNO4FQTOtoDQDCXNbjWPVB1cXx0=;
	b=wpTJ/K+suGEFWXrIfkxrReFUhCnCqxKhxQh3sq0t4LaOvOg3N715I84biDAcMht79vKJ+L
	4uuR3UWd/LfMf4rqI9IMlgmNT0JwbCBQ/7eZfL/bNKsJRaWefhyYkrt6eAfjkn4ws5yV3e
	sqgOV1ZmWzh4GFTbzY84S5GirLd6CRA2+VDs7H9fjBu5HwPG3Ola+dXvaDd9d3MW9kmGkJ
	gTkOSVrvI8gv4WbqA/Q+mrjR7yTvpxNc+wiScqVXiurpbSCHnphPBy5VQuim8v1l+eBGHI
	TtPNUdklwL1VLi3tzeFcGYTz8Bg1qibqivcXRWA45+Arpvz0RSNYJRbvIBAFhg==
Date: Mon, 15 Jul 2024 14:26:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] [RFC] genirq/cpuhotplug, PCI/rcar-host: Silence set
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
References: <20240714122405.27548-1-marek.vasut+renesas@mailbox.org>
 <87wmlnrdkf.ffs@tglx>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87wmlnrdkf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 58fbf58eab3c27b7366
X-MBO-RS-META: aspsmutygi5hja3duf1zym8jucwta81g
X-Rspamd-Queue-Id: 4WN1f075QZz9sNb

On 7/14/24 9:14 PM, Thomas Gleixner wrote:
> Marek!

Hello Thomas,

> On Sun, Jul 14 2024 at 14:23, Marek Vasut wrote:
>> --- a/drivers/base/platform-msi.c
>> +++ b/drivers/base/platform-msi.c
>> @@ -100,7 +100,7 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
>>   		chip->irq_unmask = irq_chip_unmask_parent;
>>   	if (!chip->irq_eoi)
>>   		chip->irq_eoi = irq_chip_eoi_parent;
>> -	if (!chip->irq_set_affinity)
>> +	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF))
>>   		chip->irq_set_affinity = msi_domain_set_affinity;
> 
> I'm not really a fan of this new flag.
> 
> I'd rather leave MSI_FLAG_USE_DEF_CHIP_OPS alone and introduce a
> dedicated flag MSI_FLAG_NO_AFFINITY to tell the core code that these
> interrupts cannot be steered. Other than that this approach looks sane.

Should be fixed in V3. I also converted Tegra so far and sent it 
alongside V3. There are many more controllers to convert that will follow.

-- 
Best regards,
Marek Vasut


