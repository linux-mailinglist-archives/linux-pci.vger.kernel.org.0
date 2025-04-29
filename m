Return-Path: <linux-pci+bounces-26983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3AEAA037D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 08:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B811793E6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF72741C8;
	Tue, 29 Apr 2025 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DnWOW7Cn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T80HuCt5"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629881E2834;
	Tue, 29 Apr 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908582; cv=none; b=aiB8FeKxVzrruxWEFPBT9fYGLP4WbK3dEwRXdSWcnRmGnLiTllCwYot4vbQGxc2lGHRqUqcWsggwHlR7Jkt2fbVLoYAN9nvEoDMFKiOB6hd6+V82vx2DF9gBFlXhPJ5AyFyj6qEIhnD5TfVmFKG7Yj6sJJ7Oq1KeyCoZv3MYFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908582; c=relaxed/simple;
	bh=9mbueJwWZgiSOGRcpxVZxqIaPS1CG1KC5I/qRx56R7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P/i7gGPpMnHg476dH4q+IRG1fRDERufv9thHwMOiCsvocZGjihbeTINh/EjZNGSKp8apxqnz3KRGKK5ad+8gewxBD14xZZZugTl6lNB6uxJLc6zouVRxz8KeyKGT/5ICga/Br86sEEbccN1A926QEgvsG7Ri6m9AeY/GfuQfG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DnWOW7Cn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T80HuCt5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745908580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9mbueJwWZgiSOGRcpxVZxqIaPS1CG1KC5I/qRx56R7I=;
	b=DnWOW7CnOsAcV22vpKV63CbsY0ldb+5sbM3yvyIQcc2zf6QyVfsmfvL9wBypHs4nV0ld6Z
	Zurxv7W1oMofpW0eEtAhlj+MHvHdG+GZ++ae2mgPOD6N9tkJ9LdUbpn/5wuZlsj/NUa6yp
	acICJrAun4fhOZx5xqB7vp7BwzSyN8fIJj5rH/gqUrN3Ijb0ryMTJ5ISxKG5fqqRSmgjrb
	dhG74v4QmZtjs2LYPyfXRSY/kuAZBRt+zfh4bgwBgwenZkjRI8AVseHBLAKaWK5cs6bJsZ
	S31BdCGodkYHMMsRb0freXUSXiu4/hCKHRA9XHkXLmQrWgulGV7LBZPsRZ8hrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745908580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9mbueJwWZgiSOGRcpxVZxqIaPS1CG1KC5I/qRx56R7I=;
	b=T80HuCt5ESK3U117L2ud9Kpxqr73T+IhsCP8hk5od1nGiAlIYD21ojyx0oNzqnpjESRh7i
	HuNjlGSQmCMYsBDQ==
To: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy?=
 =?utf-8?Q?=C5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Kling
 <webgeek1234@gmail.com>
Subject: Re: [PATCH v2 1/3] irqdomain: Export irq_domain_free_irqs
In-Reply-To: <20250428-pci-tegra-module-v2-1-c11a4b912446@gmail.com>
References: <20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com>
 <20250428-pci-tegra-module-v2-1-c11a4b912446@gmail.com>
Date: Tue, 29 Apr 2025 08:36:19 +0200
Message-ID: <877c33qxss.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 28 2025 at 20:05, Aaron Kling via wrote:

$subject: .... irq_domain_free_irqs()

> From: Aaron Kling <webgeek1234@gmail.com>
>
> Add export for irq_domain_free_irqs() so that we can allow drivers like
> the pci-tegra driver to be loadable as a module.

Export irq_domain_free_irqs() to allow PCI/MSI drivers like pci-tegra to
be built as a module.

See https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

With that addressed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


