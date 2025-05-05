Return-Path: <linux-pci+bounces-27213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F7EAAA665
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E4B3B28F4
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CBD322AB4;
	Mon,  5 May 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNbJQ11E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+q9z70S"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3B322A90;
	Mon,  5 May 2025 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484416; cv=none; b=aTOJVV3ws5dd+jVSuuHJR/ngkA4WR9NavmtGtdcwKYqUUJlsoLcGk/em0qqFED/8z+X/o55QdNsuLZBBRWeXzXdi29sObLT3v42cbGqUMXKyH0NNP56rPd1rUMkse394vJRA7+pQPJ6yqvz5feG6JiVa0MDYGtBBC8Hjme9ULT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484416; c=relaxed/simple;
	bh=HatdA9k8dTOZzoALiSAOatm15PguKG74mPF5yaTmjXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0qO5mjDr1ymM6fSu9543fhK0DnvIDuYpO+O5xKq7kb7Hoejp6Oy05BnV2yTQmkp+z21aQ8T9xu+7kMUkVW8uEVRUtz1WUnm6U7aZi1/+PuFVIJ0ZenLObGx/7X9+2PNLcLNkOLXmZ34Xr/tSaKgOmhzCrVGJQUc/tP8Sr/VMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNbJQ11E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+q9z70S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746484411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar+nYY6YvS1JDsf3WZ/fGQw2E8KQPNJ8g1OwVIgR+aM=;
	b=YNbJQ11E0VmO8C+gqyhlukX676Aov3AgM0pJVFAc4FJgNaleYvU1mCt+jSrgTy00xjZdcY
	lw5g1mEGYYy2t9gmxGgFkVEo5Xn9LxICd16cbLXdLhaH+lo5UkL7bt28USzil0HKrq15fy
	zW8p3peJv8DIfogSabh+6tPhKL76cJj2HgNcuMVpP1yL9LQyOUKglw3H7FKhsJTSP9E8l9
	sN2XkT9RQb5nl4RDyj3Z3u23EuIxjuQfrGqKC6+T0KUkFhQJJN4y4Nub4mO3SUdCRrLJYs
	qK9CQ+vVfaZ9RSzBw8uYllWzYms2soUc2mGoN5DWyToCHSXwaCnnyaoZ2sMnlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746484411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar+nYY6YvS1JDsf3WZ/fGQw2E8KQPNJ8g1OwVIgR+aM=;
	b=f+q9z70Smk3vOT60407tVIz6Ss+kDH8S/UNUpUYoaE8+VjeoW6/KIMuK5eDqOnEyyebr9T
	HeK2bY8XrvJ2t6Bg==
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
Subject: Re: [PATCH v4 1/4] irqdomain: Export irq_domain_free_irqs
In-Reply-To: <20250505-pci-tegra-module-v4-1-088b552c4b1a@gmail.com>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-1-088b552c4b1a@gmail.com>
Date: Tue, 06 May 2025 00:33:30 +0200
Message-ID: <87o6w6ofgl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 05 2025 at 09:58, Aaron Kling via wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>
> Add export for irq_domain_free_irqs() so that drivers like pci-tegra can
> be loaded as a module.
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Seriously?

Did you actually sit down for a couple of seconds to read and understand what I
asked you to do in that initial review and then again:

    https://lore.kernel.org/all/877c33qxss.ffs@tglx

I appreciate your dedication to get this sorted, but please take your
time to read more than just the _two_ lines which you think to be
relevant.

Please don't come back and waste your breath on telling me you are so
sorry as last time:

    https://lore.kernel.org/all/CALHNRZ_ctL1fJGO5752B6XEEXHwRe-a-Ofv+_=qtdq1WWXLLjw@mail.gmail.com

Just get your act together and do it right.

Thanks,

        tglx

