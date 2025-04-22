Return-Path: <linux-pci+bounces-26418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07BEA973ED
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 19:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D53A863D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05B02135BB;
	Tue, 22 Apr 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDHtQWjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6D14C5B0;
	Tue, 22 Apr 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344170; cv=none; b=URdMR+nhWct4/ffNZjv7Sw2TVhSPByrNxtIDHt34un16LScpp6tHR+CmvXrlEvbPCPkS7R7vdmgXXG1q14FDiApcooJogErju3Ku2uzhyLXra1DrtVL7LfLlkrCnOX2049VvjMX8/PLFhTGVaaMzbCbVXQFZDSafaE0d0yxOiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344170; c=relaxed/simple;
	bh=NMUrajeGaevk9etR13v+Zo0jMwWofA3IhBlD3NT/Bow=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eojbr9ZFiLmFpBEkxBKK8BYDPOxeSXy6EV5Ztu7re1VioYDFSftJ8u6/hGJaI1IHJlmTRncpsGZKAmHovSK6g8E2YbgnFWyVaDN5t8WIJIJCz3ppgVvqS3sl51dcVejGn1k5Zss8o61qeTiDK44P0lc73UD10hw600XhqiTgPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDHtQWjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A13EC4CEE9;
	Tue, 22 Apr 2025 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745344170;
	bh=NMUrajeGaevk9etR13v+Zo0jMwWofA3IhBlD3NT/Bow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDHtQWjSQTxmMHgS3ri1MQSyvjg61Egx4BhiC1VwdoRitk5GEOHPa/2KkpYSWFYbW
	 QoJuCcmAYrtToxX8CYvWKtjJJ9SE3lH08QQQdU0VURSnEjhJmLm+c4O3u5GndJbYle
	 ZAsz+XFa2VqkPPVYyLyXt/LGQB5caYC2STVCUzECoRUWVsqMdHeYEfdECSEFWq8WDT
	 b0zOYmlfaSSlsbW8wsw9SK3PEjv/3PpGqYT+nuo68MR1Kbp1a78qdWDCALzVWsUnI0
	 cuCmGa3aqrg4y0zJ9P1DbmhOQ0FD7IcEIfIuwnyuTZuYlHuVxLAD/zWBzJZYzswu1k
	 RG37+XA8DK1Dw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u7HkN-007ihb-Jq;
	Tue, 22 Apr 2025 18:49:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Apr 2025 18:49:27 +0100
From: Marc Zyngier <maz@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne
 Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, Sven Peter
 <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 07/13] PCI: apple: Move away from INTMSK{SET,CLR} for
 INTx and private interrupts
In-Reply-To: <20250422174156.GA344533@bhelgaas>
References: <20250422174156.GA344533@bhelgaas>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <739728922cbf097aa87dc41265478dfc@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: helgaas@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, mark.kettenis@xs4all.nl
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2025-04-22 18:41, Bjorn Helgaas wrote:
> On Tue, Apr 01, 2025 at 10:17:07AM +0100, Marc Zyngier wrote:
>> T602x seems to have dropped the rather useful SET/CLR accessors
>> to the masking register.
>> 
>> Instead, let's use the mask register directly, and wrap it with
>> a brand new spinlock. No, this isn't moving in the right direction.
> 
>> @@ -261,14 +262,16 @@ static void apple_port_irq_mask(struct irq_data 
>> *data)
>>  {
>>  	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
>> 
>> -	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKSET);
>> +	guard(raw_spinlock_irqsave)(&port->lock);
>> +	rmw_set(BIT(data->hwirq), port->base + PORT_INTMSK);
> 
> sparse v0.6.4-39-gce1a6720 complains about this (and similar usage
> elsewhere):
> 
>   $ make C=2 drivers/pci/
>   drivers/pci/controller/pcie-apple.c:311:13: warning: context
> imbalance in 'apple_port_irq_mask' - wrong count at exit
>   drivers/pci/controller/pcie-apple.c:319:13: warning: context
> imbalance in 'apple_port_irq_unmask' - wrong count at exit
> 
> But I guess we just have to live with this for now until somebody
> makes sparse smarter:
> 
> https://lore.kernel.org/linux-sparse/CAHk-=wiVDZejo_1BhOaR33qb=pny7sWnYtP4JUbRTXkXCkW6jA@mail.gmail.com/
> 
> Nothing to do, just "huh".

Huh indeed. Pretty sad to see a useful piece of tooling being left
on the curb.

GSoC project?

         M.
-- 
Jazz is not dead. It just smells funny...

