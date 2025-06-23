Return-Path: <linux-pci+bounces-30452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5098AE4D3C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEC83B5655
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006025F785;
	Mon, 23 Jun 2025 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wq8P8oSO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJ3uGDEs"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF961DDA31;
	Mon, 23 Jun 2025 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705499; cv=none; b=eiXIkt3GV+fqVz/vpBbUd4uRdfQfWSsHIHZbY3kRnl0jXcglndY/6vLzQ02AznoqKO76m4elaw+Q5pTbs50iUhY3OJISnMn9zO+WksZx65ReXXUm9JDtsRH/LdqojsMbLtUht7CQACU6pKAJs4bDD0N2fPrg1qc+WAZ3nxA2M7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705499; c=relaxed/simple;
	bh=TR8ISfADIgMboKyCwl25EEKSp/wq6BbTsD/oRX+z1C8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSoEMe5fsXWFSuuHxq1O8xD7WHqV09r5mlSCE7nCcEKF3R/J0sXISk1O9ITcMuof5yBkA6PJrZtptxuYzTIHg15Q1I90b7nyAfiHq6hIsSX+gz7QvlqKrPBE0cBRm1vuA10TpIZPojWQiSOUq/szBIjY7A1Y0aSjYyE3obl9xp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wq8P8oSO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJ3uGDEs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750705495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6DcYddt5wym2Xskxe6KfcsdaZsVhnmiyQICeoOHbM8=;
	b=Wq8P8oSOSnrEFmyK5tBA94+ro+F6vK1BDqjUoE2cyXQ7+BV/JEjWO58VVuAZ1TfKjH+64f
	WqMXCGXHSNX07tPREailSfueUDYo2DFKi5TrXV1mokTpLI+TnIybDSvX3Zg6RMMhvqPfaC
	9X0mPgCp0A74LFynqgJE9znnOlfXksasKZfK4BOi5Higm6dCMf7kj3KvYJrxjsfeDueYAV
	LSs8H2jtQYcdk9VPUaDlP3cm5DT6EgWEq0xhz0uHXSzszsZx+JgilzK4NQ6XP5RqlsPMH1
	DpyBg6RJKWxlRJUD32Rz6uK5YHRWPKhJFvOBNZlTL/ggRfmRqEMCh0ikudVXsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750705495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6DcYddt5wym2Xskxe6KfcsdaZsVhnmiyQICeoOHbM8=;
	b=bJ3uGDEsaB26JP9V7UX1Jlx1g4wZEoUxaRVea7vzQCcQzJlekZks5lMZkgtZUr16gahBgA
	SNi+iyrrJuUoCwBQ==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Sascha Bischoff <sascha.bischoff@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Timothy Hayes
 <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Jiri
 Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 24/27] irqchip/gic-v5: Add GICv5 ITS support
In-Reply-To: <aFkd0cigSKOSqUQI@lpieralisi>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
 <20250618-gicv5-host-v5-24-d9e622ac5539@kernel.org> <87y0tmp6gn.ffs@tglx>
 <aFkd0cigSKOSqUQI@lpieralisi>
Date: Mon, 23 Jun 2025 21:04:54 +0200
Message-ID: <87ms9ynusp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 23 2025 at 11:26, Lorenzo Pieralisi wrote:
> On Fri, Jun 20, 2025 at 09:18:32PM +0200, Thomas Gleixner wrote:
>> Just add a MSI flag and set it in parent_ops::required_flags and extend
>
> I added that but it does not work (not if we use d->flags as below), it works
> if I add it as an
>
> IRQ_DOMAIN_FLAG_*
>
> and set it in irq_domain_info in the msi_create_parent_irq_domain()
> call in the GICv5 ITS driver when creating the domain.
>
>> the lib with
>> 
>>         struct fwnode_handle *fwh;
>> 
>>         fwh = d->flags & MAGIC ? fwnode_get_parent(fwspec->fwnode) : fwspec->fwnode;
>
> Here we are using the domain flags and I think that's what we want.
>
> If I go with parent_ops flag, I believe here we need to use the parent
> msi_domain_info::flags - I don't think that's what we want.
>
> It is a property of the IRQ domain so I think that adding an
>
> IRQ_DOMAIN_FLAG_FWNODE_PARENT
>
> is the best option.
>
> Please let me know.

Obviously. Doh :)

