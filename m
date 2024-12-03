Return-Path: <linux-pci+bounces-17600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CD9E2EAA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF79B28C7A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A81EF0AE;
	Tue,  3 Dec 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fs8EroUr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jts7PM3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB71207A07;
	Tue,  3 Dec 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260360; cv=none; b=aNF8A3ZXjQdOb9RqnALwOFT5OtEXaPBdLUEsNa0GYqXwFUArReq6edWitGTI0MCmo/iz33n5xdX4sIV5aae7tRGFMGn+SEHnr7zlPYrpsLmZ5yzeRPXXu0+RZINUQ5RWA7HKl1H3oO28JmAfqD/9CffgogA/JSrikQ5VN/Usg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260360; c=relaxed/simple;
	bh=Xp7nItebZYWzIRkQ3dtApJ0l5bX7krb4ovTaP7j/+xY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhtXCmQ2/d3owO9+BpRCLa8PW+ga7TeqmHtbahc0ubpS6hBgj/3wO/teQ3yUkPN9NKegLC8TH2abC67gq1NABZ5R6NBcJFNmJ0j/B11cQ6GcG7zUs2Ylz4tGIOyzxvuB0qxZ4msljIcOBGemoIdlQ/QWJpCJYAR4f6iFlm4jxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fs8EroUr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jts7PM3z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733260357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnFWEKbSESp9bfgP3xRoSac+D0/KI17M/a5z2PbtZZA=;
	b=Fs8EroUrJCDqGGVrLBaUJeUXTHen+IpZiPJi1+z2vwK/4ZH8CBmYZf6lVp+N96KKbo/AGq
	uH67HiWj58jATLxNoLLnQFFpgr8VqzZkfBGzwK8vwsLWKcgtmwISYRXfTF8DoSbfA9JCmX
	ow3StPdOImtJ4Vp6vO6RvZ9MaGA+vQfao1CqC/l/jjZLrFjA0EKqJYQKL1Ti1R49kDeWgl
	e96h5+fPKs9pwFoq5jU6oxq6FZFtQs9w37f7DrMqj4HmG+MVdBLsiAYQVPvUDxCFqjM2aR
	3qWjoYg1ZWnXn6eocu3htVxvM05QwQwzxPe4FZjCq4TEfYXwUGXQNNVS2b2LAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733260357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnFWEKbSESp9bfgP3xRoSac+D0/KI17M/a5z2PbtZZA=;
	b=Jts7PM3zpGCNoUhOHZ0AJX0xH/5gVICXAZM/BxKVgFwHi1MY/cc7J4UBAP/wj2tFP92dPN
	BX+a1criwUkN4NBw==
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us, Frank Li
 <Frank.Li@nxp.com>, stable@kernel.org
Subject: Re: [PATCH v9 1/6] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
In-Reply-To: <20241203-ep-msi-v9-1-a60dbc3f15dd@nxp.com>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
 <20241203-ep-msi-v9-1-a60dbc3f15dd@nxp.com>
Date: Tue, 03 Dec 2024 22:12:36 +0100
Message-ID: <87y10wsc6z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 15:36, Frank Li wrote:
> The follow steps trigger kernel dump warning and
> platform_device_msi_init_and_alloc_irqs() return false.
>
> 1: platform_device_msi_init_and_alloc_irqs();
> 2: platform_device_msi_free_irqs_all();
> 3: platform_device_msi_init_and_alloc_irqs();
>
> Do below two things in platform_device_msi_init_and_alloc_irqs().
> - msi_create_device_irq_domain()
> - msi_domain_alloc_irqs_range()
>
> But only call msi_domain_free_irqs_all() in
> platform_device_msi_free_irqs_all(), which missed call
> msi_remove_device_irq_domain().

It's not a missed call. It's intentional as all existing users remove
the device afterwards.

> This cause above kernel dump when call
> platform_device_msi_init_and_alloc_irqs() again.

Sure, but that's not a fix and not required for stable because no
existing driver is affected by this unless I'm missing something.

What's the actual use case for this? You describe in great length what
fails, which is nice, but I'm missing the larger picture here.

Thanks,

        tglx

