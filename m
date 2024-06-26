Return-Path: <linux-pci+bounces-9336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B464A9194B0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 21:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B2B234D3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ABA19068A;
	Wed, 26 Jun 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FRpB5K1y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J8QlprRG"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588E191487;
	Wed, 26 Jun 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428618; cv=none; b=hW6MPvZE6UbWhjCDkOpERIFJv3j1/5YcRBDesm2rrZ1e2gRysrxmW9oSrdE6hXsEYUUR+LtXfaOesx2YzN7Llp/8FILR46aT3Vi4zl+4fXTtsb4K+AM3IGHjVasPYq4XsXbhFOQ4D73GP4lisXnOtBvYBApeETOJ9Uua1H0NJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428618; c=relaxed/simple;
	bh=buBMI2fP8QVy2V0X9Ola9ijY+X3Ph+ewky6fAyFFm9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NShPCqKHUAfYsv6IQGZOURTL3VAC+wejjWN5OH32iQnxReCh6SkXYx+uT9vH0IvgtRTtDUSNUsfeKaHD0UqgdLLaLya8oPvr5cN0kvg4TTyreQw56WO0h2nnslBtmWoei7dFeHXvg+eBCJugyuzi8NcUdoOg/+82xazepJV7C7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FRpB5K1y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J8QlprRG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719428613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otRzP7aUfI9j3HdxqdRahcORxtdoaz5/rfejeaFYrSU=;
	b=FRpB5K1yhIi1A3VLSvI/jfYYVXQXXiwlvlC5vKGEl2a/JcN8iyrBRuXH99DwPYzYOKJz/b
	XE3RJ8atOjkfQch1QBcI2SriZj1ENBp+EbAMKdrk9YmmY1IjKFhg/LxHF3d1QN3yfnIweI
	OZo51VoYyQYcyVt4L5x9WIHCyDsEWdQsXzJbmW4sFoptvp3eo2EFSDGw9QnUyja2viTKSR
	bvYllDWqoeTUXbUI/Bl0DamfXxQH5QycL6TG9/WwaCY7RX35CeTq1MaeC3ckgdr5gnL+PH
	lMGSSfefV2uFdJGoRHVAjVMQwa4dM4AQcpLeoScYTyrZrBtS44uMm1NZOsXnWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719428613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otRzP7aUfI9j3HdxqdRahcORxtdoaz5/rfejeaFYrSU=;
	b=J8QlprRG4QWJJFlBisyO6UgK+ScaTrMAfa0ZRV/SjXTYrqN3XyZetxTPXypv2IfDtDt1BN
	j8lwD14Wt963QuBw==
To: Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
 rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com,
 den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
 vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
 andersson@kernel.org, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
In-Reply-To: <20240625194614.GA4013374-robh@kernel.org>
References: <20240623142137.448898081@linutronix.de>
 <20240625194614.GA4013374-robh@kernel.org>
Date: Wed, 26 Jun 2024 21:03:32 +0200
Message-ID: <87h6df34sb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 13:46, Rob Herring wrote:
> Running this thru kernelCI has some failures on x86 QEMU boots[1].

oops

> <4>[    2.199948]  pci_irq_unmask_msix+0x53/0x60
> <4>[    2.199948]  irq_enable+0x32/0x80

I'm sure that I fixed that before.

Updated branch:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-arm-v4-1

Thanks,

        tglx

