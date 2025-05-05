Return-Path: <linux-pci+bounces-27153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C46AA942C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 15:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A653AC5B9
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 13:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E5256C89;
	Mon,  5 May 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jbm/bH6G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCKdCpT5"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40F2566EC;
	Mon,  5 May 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450886; cv=none; b=kVrZ+LW+U++4TWT1g44xvsFIDgY8EIubj+8zetOzSpGJwNrCkh+AzHH/kIhzG5Zjim4ufdJ6DQQUmxIOhWUZWT/P7BvWEEqEXUuO4DVOMyUlkiaMAzucOgQO1txpR01GLtwi/kmEIBZcqxi3Ih9brNx172oZa/PDTav3UKDEMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450886; c=relaxed/simple;
	bh=3EWSW4gNfNtjmTUSGyTYNCDFFGlOwSmy1uGel+gm/xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B3iYwuD7HEAgoP+jsYVfNigscPmR6YF7rpIO47e6LYdJqKnKDsUkwGM8hnRsDYLuV9HCnjEQugovkQuxWf+T7e8imQb+4EGdP/8sBEaIW3X9FHQ+ZUZeXrQTOmeTMZfXGNLd7jL5kC6WCLT/dof2qmm+P5Nm+tVnzh55snq7riI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jbm/bH6G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCKdCpT5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746450882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+UKpSa6valaQx31376IcaCpRREUke6uxzsbUDbgt/I=;
	b=Jbm/bH6Gl11/XktsUKhaC3fUp+bkSBXJiUF1M4dtKXeuPAbLbSqT3PcdKOKCJejnPE6gB3
	nvKOPFzwYWEOUoTCAND0+tjzJPmsd46BUGNvpIvuSzgqMdVLo5wFLCt3WG8Z5nwKDvn9oY
	GObKbztRO1hoUmAD6isrqkDSgSLMDNN9GSh+AbHcRy6sx4ygtR/tdhR5B1oZBE+RapNNGa
	TcxPKVmPRIMrdDMydh+xIqOgkbI5Zno0onNMhPvrnn5DV4ccVIRsTJQvZIwAGSMt2iylSD
	vRjq2k0w04vgLRUFOYY4XDO/xgBGZtCf4ZtBOEe07X615A44NCgF2oTlVZeIdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746450882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+UKpSa6valaQx31376IcaCpRREUke6uxzsbUDbgt/I=;
	b=DCKdCpT5SW1ieODOXAoRBUzdBc2m09BYBHSZP+ungTFYZmw68Dty83iHFiRWgGg83jbahp
	uApNxUG7vd4RlGCA==
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
Subject: Re: [PATCH v3 1/4] irqdomain: Export irq_domain_free_irqs
In-Reply-To: <20250502-pci-tegra-module-v3-1-556a49732d70@gmail.com>
References: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
 <20250502-pci-tegra-module-v3-1-556a49732d70@gmail.com>
Date: Mon, 05 May 2025 15:14:40 +0200
Message-ID: <87tt5znqrj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 02 2025 at 14:00, Aaron Kling via wrote:

> From: Aaron Kling <webgeek1234@gmail.com>
>
> Add export for irq_domain_free_irqs() so that we can allow drivers like
> the pci-tegra driver to be loadable as a module.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

  https://lore.kernel.org/all/877c33qxss.ffs@tglx

Is it that hard to address review comments?

Thanks,

        tglx

