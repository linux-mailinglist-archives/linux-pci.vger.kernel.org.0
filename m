Return-Path: <linux-pci+bounces-9074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A25912739
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BDD1C23CC2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D234A12;
	Fri, 21 Jun 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3O31GzIq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c44WSDYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEECA21;
	Fri, 21 Jun 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978675; cv=none; b=UD2ff9NJ53fVM51U9SpH1E7OuzNJTEt9uY7/dXiN7J2o8ElHxIvcPNa9mmy/Nh8q+vBaxbpvZNQYC6Y3Sc/BF+H0+6iJijYUqO81BaoPwS2jlmWJ9/h6yS3YiuYcbexwI6mOHN2oiGjX61GGXFYIIyxDTdGtzCRcgMw7qpCLBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978675; c=relaxed/simple;
	bh=Bh63jgLkIskV2XJ/cPyspmcVUfQYnsLqEDPsMyYSF8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQ2UFKCy/lxUhCrU1fFEoAM75G2J/QXzdQgrP3NHUsi/N1Vtb7q5AU8JtmFS68GKPjhr34WjcGf26o0zhI9dLJeJK0niGvJrAuve4iFSZy7PSeuP6tRxdc7fIBZm4XxnxipY1x4gPUufWTp7zi+TTszAVQQHQr1A2O9rr2jWjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3O31GzIq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c44WSDYK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718978668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vxYLRaM0g0hLDEgQ8vsw75W1q+Hkmc7pGfCU1ZZdT4=;
	b=3O31GzIqzYpWk9Lzp2k8vutGkUFZ+IxeVJ0KvoKS/pm+u44o/prmAwQ2sTmGQeO+unqmgL
	jZfPg5Ta9SWbRSGvBs7h/G/EsN+ETE4U8Da3bkfqCaDwhMR2S4CNp5LKv++rZN7BlSRzAX
	lz3NiGPgaWT+q3MXl5cBAL3NJPznEFTeRkz65RaoOERoMgMb5Nj0msrXAeTAKJhvUzLN73
	kJpf/cd6HYgaOBEDUZQfuhCzE1P908mBFk3y7aI59H/rfOkU4rZcMZYOvEI6wF1osIplFK
	0S9rZOMzGaHmVKN8TSFpmRsHZlj6Tu9eju097O6sbWcRxerq+MzpqEeUMEqeSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718978668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vxYLRaM0g0hLDEgQ8vsw75W1q+Hkmc7pGfCU1ZZdT4=;
	b=c44WSDYK/TeAI2oxSjPi9TXvGYnylf68EKuN95zvRde+oDPWqd/SrCa2CA3K+a+fpgWs+Y
	KfIjKhdEJMR5cqBA==
To: Marc Zyngier <maz@kernel.org>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
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
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
Subject: Re: [PATCH v3 14/24] genirq/gic-v3-mbi: Remove unused wired MSI
 mechanics
In-Reply-To: <87ed8vu033.ffs@tglx>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
 <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
 <86le36jf0q.wl-maz@kernel.org> <87plsfu3sz.ffs@tglx>
 <86h6drk9h1.wl-maz@kernel.org> <87h6dru0pb.ffs@tglx> <87ed8vu033.ffs@tglx>
Date: Fri, 21 Jun 2024 16:04:28 +0200
Message-ID: <87le2yo0ib.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Gentle ping!

On Mon, Jun 17 2024 at 16:15, Thomas Gleixner wrote:
> On Mon, Jun 17 2024 at 16:02, Thomas Gleixner wrote:
>> On Mon, Jun 17 2024 at 14:03, Marc Zyngier wrote:
>>> Patch 9/24 rewrites the mbigen driver. Which has nothing to do with
>>> what the gic-v3-mbi code does. They are different blocks, and the sole
>>> machine that has the mbigen IP doesn't have any gic-v3-mbi support.
>>> All they have in common are 3 random letters.
>>>
>>> What you are doing here is to kill any support for *devices* that need
>>> to signal level-triggered MSIs in that driver, and nothing to do with
>>> wire-MSI translation.
>>>
>>> So what replaces it?
>>
>> Hrm. I must have misread this mess. Let me stare some more.
>
> Ok. Found my old notes.
>
> AFAICT _all_ users of platform_device_msi_init_and_alloc_irqs():
>
>         ufs_qcom_config_esi()
>         smmu_pmu_setup_msi()
>         flexrm_mbox_probe()
>         arm_smmu_setup_msis()
>         hidma_request_msi()
>         mv_xor_v2_probe()
>
> just install their special MSI write callback. I don't see any of those
> setting up LEVEL triggered MSIs.
>
> But then I'm might be missing something. If so can you point me please
> to the usage instance which actually uses level signaled MSI?
>
> Thanks,
>
>         tglx

