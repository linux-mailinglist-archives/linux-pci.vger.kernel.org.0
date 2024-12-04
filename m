Return-Path: <linux-pci+bounces-17655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12339E3B52
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 14:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28F4B23F9F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FEB1ABEDC;
	Wed,  4 Dec 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFBy1gyA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6OVT3qJb"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764318BC19;
	Wed,  4 Dec 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317697; cv=none; b=fjE36QlpKwouZpUeLDuNzqse59vgVLAPYukOi3490uJurixvBypcTlumKzux9UzW7ojNZBVAditoxQyVcz9lOH6styYvTtcG2+TgkvPdU6e5opdqRKEy2nt+AoCGlQ5g5h2ylsnjOt4H6s4grUXy9mvR9G/NXZdtirroK0HAY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317697; c=relaxed/simple;
	bh=05RaxY8NTJZsdAMk/F+MVGS6iIIbXrpDd0cv9NTMgsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJ3bQja8mgGjFoymL7ol43LRxJOOCoEFHdTmKsDSn+CNNllZ9oETBl2IzfDLww1J3Fnr+c+yu6IFDQ4R4ITe3DYENjGIDpZ5lzST4xL/zA/dATBX8xKq7IzOdioW3orXgdx3ws7H8nT4qz1lVdL6dSi3vq0QR8wFPHngmqOVAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFBy1gyA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6OVT3qJb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733317692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ai6Td+7Re4FB0bJzl00OhDz0NYYlW8jViszOUHsn54c=;
	b=zFBy1gyAVOA9KgJwUcsOSY5q9TPYuTqu9LkGJXJC+RsJzCZ7aB9Hb8nslQDzhJxP91iwvv
	ayQxv7NwBnF4sH3k8udsY2kj2yVSgy3UbvHYSc/TlBtYprapRncVYqnz9OqkYwl7zoVdus
	WVNuh76NkV+R/LL6iczxXh3IyHhtj0znSpYq9EbcK+ddnOKFWaTbrCsVYKnVMMnzg2emje
	dBeADw1CwksN/+R6mi+nyuwA7ICGcwnyCynmBocoNktqzyxhYZzFPMvUeKhlH4+dnC4qMq
	SUHNdv4ZcG9KgMYfwso3Qa6O9aY8H93m3bWyRh3fQD81s5p3OtIIM+uCzLNuPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733317692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ai6Td+7Re4FB0bJzl00OhDz0NYYlW8jViszOUHsn54c=;
	b=6OVT3qJb7QSbzkewvzZYWWbqCQIHPBJ/jiRUicmS4fVMvTkHZhy9KpkcqF9yl8uB0Mg8Yi
	pXiq6/VkKOtt1zCA==
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us
Subject: Re: [PATCH v9 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
In-Reply-To: <Z0+TFbH5uWgFq6xY@lizhi-Precision-Tower-5810>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
 <20241203-ep-msi-v9-2-a60dbc3f15dd@nxp.com> <87v7w0s9a8.ffs@tglx>
 <Z0+TFbH5uWgFq6xY@lizhi-Precision-Tower-5810>
Date: Wed, 04 Dec 2024 14:08:12 +0100
Message-ID: <87jzcfsiir.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 18:24, Frank Li wrote:
> On Tue, Dec 03, 2024 at 11:15:27PM +0100, Thomas Gleixner wrote:
>> The fact that a MSI parent domain supports DOMAIN_BUS_DEVICE_MSI does
>> not guarantee that the parent is translation table based.
>>
>> As this is intended to be a generic library for all sorts of EP
>> implementations, there needs to be
>>
>>   - either a mechanism to prevent the initialization if the underlying
>>     MSI parent domain does not provide immutable messages
>
> How to know such information?

It obviously needs to be flagged somehow in the domain and the EP magic
needs to check that flag. 

>>
>>   - or support for endpoint specific msi_write_msg() implementations
>
> Even provide specific msi_write_msg(), write to address/data to shared
> memory.
>
> host driver:
> 1. read address/data from shared memory
> 2. write data to address.
>
> 1 and 2 is not atomic. So it can't avoid above raise conditon.

Correct. So you cannot support that case, which in turn requires to have
a mechanism to check for the immutable property.

Thanks,

        tglx


