Return-Path: <linux-pci+bounces-10233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCF930525
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B38283923
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14345008;
	Sat, 13 Jul 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kFf52Hi8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+gNrFhx"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6992E40E
	for <linux-pci@vger.kernel.org>; Sat, 13 Jul 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866813; cv=none; b=PuTmGL8gXtqoazkYyZVhAFrJrJXLFLmb/6JpGTVkaEcnX+pxl2jfZ5ztITNqgzX7bOKifpK17eY0iEV5FokhLnZT7SZkoCLXochXtsb8TqA6xsIdkRXXDI2UDfs+MQv2hC66JFadZlfqXaib/Ik3TS2ZQp9acjxyZlHWzFPmfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866813; c=relaxed/simple;
	bh=EjwSrTHwM2wh7cRMcXy5l/we7wtuWobAyFemPuHlobs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Suts9WPoF5Uly2NQbKf93MXwWu2u+CaL/DpezUObjf0zRV5javOfDTRH7NweYSe+8krpp+uHPwdmM3JYtmRpS9X9ibA4jXYqh63ZwEIyOiuuzBqPkD3Zl5oA7bxmjGsgPLCHGX6WH2IhaBSP2EBkNyuKqTbjiKM0b61Jo6zC+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kFf52Hi8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+gNrFhx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720866811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZz21t0XLRVOmJf1C/wt+L4fSHfWkHnEUPmCtKL8PpA=;
	b=kFf52Hi8NhDlogfXYjuhjpOvWXA+t206AfqmeQX4Hw07oWH1iA8AQTihB49OxRFVMEMaaK
	zEiKCkRpn47iWeTKn7Xx7wCq+1MmfsekkVB3f7ShdzF1c0ICBZ6DTqiO/8XXzJ2Y/bUgBA
	C8qEY5iP8NfGf2c9IvNtGQMqc3G0Lu8j/soo4skBdGXJPc2+7xousV+IWjYC/1wnIg73qT
	lPOLejZKX8kEyk7y84xnPEGz0iRWwac8aWABaSN/kMS6/+1xQsh3IUz03N2fyKogkn01kF
	MYOQig/YGaavqxwSX+TIto8WicpOtY0ZLPzeeCEN+yroPW7UYZcaLw8s2f0mFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720866811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZz21t0XLRVOmJf1C/wt+L4fSHfWkHnEUPmCtKL8PpA=;
	b=X+gNrFhx0snjnQnJW9TFrHzrSTwdKTo4kwXHt2OOYcjD+8RWTRYU+zkejywQeKFP3Mhs+4
	TQVRb2SMHOPMNhAg==
To: Bjorn Helgaas <helgaas@kernel.org>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy?=
 =?utf-8?Q?=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Rob Herring <robh@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Pali
 =?utf-8?Q?Roh=C3=A1r?=
 <pali@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI: mvebu: Dispose INTx IRQs before to removing
 INTx domain
In-Reply-To: <20240712204106.GA336836@bhelgaas>
References: <20240712204106.GA336836@bhelgaas>
Date: Sat, 13 Jul 2024 12:33:29 +0200
Message-ID: <87sewdshs6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12 2024 at 15:41, Bjorn Helgaas wrote:
> On Thu, Jul 11, 2024 at 03:25:44PM +0200, Marek Beh=C3=BAn wrote:
>>  		/* Remove IRQ domains. */
>> -		if (port->intx_irq_domain)
>> +		if (port->intx_irq_domain) {
>> +			for (int j =3D 0; j < PCI_NUM_INTX; j++) {
>> +				int virq =3D irq_find_mapping(port->intx_irq_domain, j);
>> +
>> +				if (virq > 0)
>> +					irq_dispose_mapping(virq);
>
> I am not an IRQ expert, so all I can really do is compare this to
> usage in other drivers.
>
> There are 20+ drivers in drivers/pci/controller, and I don't see
> irq_dispose_mapping() usage similar to this elsewhere.  Does that mean
> most or all of the other drivers have a similar defect?

Right.

But the real question is why is such a mapping not torn down by the
entity (device, bridge, whatever) which set it up in the first place?

Thanks,

        tglx

