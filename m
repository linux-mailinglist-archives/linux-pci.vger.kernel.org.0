Return-Path: <linux-pci+bounces-39251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D6C056AE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 11:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56143A86B2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62330BF64;
	Fri, 24 Oct 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZDqJm3d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tNyuMNzr"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A42D322E;
	Fri, 24 Oct 2025 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299080; cv=none; b=HzH5VLxAbWA0bDAvxdTX23T2yW6uSe8sbTrJWRS3fCysLNgWmDa8Y+Lm19slYvktAD0DU/29QqtE5mX72t8kMYDeVwh78ArmfkW3XQlcmlIsL8A3LM4oeKW3JtR8B0+hf0tU5Sz+MvM4/UODDoDmLCae3ztyqMDizoUeDVck97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299080; c=relaxed/simple;
	bh=NZAVSPwU4IZGJBRGWBN1MHI+1BtA5xwO6KheQoUtZUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGXD3IpidmFIaG+IowGFeUMmP7akduXUdsfo9z197AXnnOfK4C0MEwdDlVZOAhFFk1JfOXTmlVG4gFvhlNluYkTZJRkjWIpQGyHPmg59TtitrdEDE+9ZKIz7Po8rGjwOzAheJbSAWI9VreBzlcIZiGkHD61veMcpy+c1QQp0tQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZDqJm3d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tNyuMNzr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761299076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXavAEt2AdeKA50kbQrTDAxk8ooenTF+Pk8EvuBhte8=;
	b=aZDqJm3defnmzAAYbej0YfrhJcyo1IHIK3yfLYpDulBXRr+I//iKnbcW7RPrMio0WW33wc
	pq31aoDVsMIB5kzf4j31hfJGEu4Gl89tvpy7NPygc7H+mdeBpZ+mudvk7mVaKU1h0Wq24q
	SzwCOGX0oGCYnoL7jqBtjNS0PpgTPd1v7/i+tEJpTs5RjpyDaE8aeQ2k29KQAA5FKDsjHg
	wpMFxj7l9Xt16t8ffsT5KIGUHI2GkmISiRELARU72SznhYT75xpPash+YuOiaqsMiIhKyA
	VJduM/jQlI5QyGVdd5YAVObGrO9mObBJ5uxfklJg1oAUiuYAFWvOz0ZztNkySw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761299076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXavAEt2AdeKA50kbQrTDAxk8ooenTF+Pk8EvuBhte8=;
	b=tNyuMNzrbE99rMYg5ySoCVmAPUBdyZ1Ry8ejR9FvszFxAg8QhaYLAdZdkBqYFQfZtwc3mK
	4dfYFirrzA/2bsAw==
To: Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Sascha Bischoff
 <sascha.bischoff@arm.com>, Scott Branden <sbranden@broadcom.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, Frank Li
 <Frank.Li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Marc Zyngier
 <maz@kernel.org>
Subject: Re: [PATCH v4 0/5] of/irq: Misc msi-parent handling fixes/clean-ups
In-Reply-To: <20251022140545.GB3390144-robh@kernel.org>
References: <20251021124103.198419-1-lpieralisi@kernel.org>
 <20251022140545.GB3390144-robh@kernel.org>
Date: Fri, 24 Oct 2025 11:44:35 +0200
Message-ID: <87v7k4ws58.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rob!

On Wed, Oct 22 2025 at 09:05, Rob Herring wrote:
> On Tue, Oct 21, 2025 at 02:40:58PM +0200, Lorenzo Pieralisi wrote:
>> Lorenzo Pieralisi (5):
>>   of/irq: Add msi-parent check to of_msi_xlate()
>>   of/irq: Fix OF node refcount in of_msi_get_domain()
>
> I've applied these 2 for 6.18.

The rest of this depends on those two.

>>   of/irq: Export of_msi_xlate() for module usage

Can you pick the three of/irq ones up and put them into a seperate
branch based on rc1 so that I can pull that and apply the rest:

>>   PCI: iproc: Implement MSI controller node detection with
>>     of_msi_xlate()
>>   irqchip/gic-its: Rework platform MSI deviceID detection

Thanks,

        tglx

