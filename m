Return-Path: <linux-pci+bounces-27851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD86AB9A96
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6046B3B9147
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2851E236431;
	Fri, 16 May 2025 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wFRyTgh5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hj8ucecR"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51EC442C;
	Fri, 16 May 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392928; cv=none; b=DoBXsxlDHEiGpVforXBpXMv5W6Onhmn6Ngc+lP53BAYdv6ZE+BcX+E+SQ+NYzFJSdAV4Uv4I+wyUCzy4XFYUiJVW2cHchFk4gp1lWCZVanrOwLCYI6cih7/Gcp2HB/IwMF7qgiexSpZXJedHZJVeLUGoR2dm9sbuztPG1naPEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392928; c=relaxed/simple;
	bh=w7QeoE83CYUeWMXWHItYCFwhRoh7O5YrA1CtSYqaC5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CqlGyYlL6hpFmEV0/w3eEQk0l5YORV+rIqIVgTTWo529dVsM6ATNNuPSD/q49f1jcOWrrMVVB036bb8hdud/p8Uq03Evzfxy0NyUilvYJv7bieEnZ3A3kOaF1C5yZtueuyOoXj/g2+cNojlj1stJje9Ygb15yxF3n8Y3Wkby7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFRyTgh5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hj8ucecR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747392924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAqrnR9lpSHDZlAAETS+32VSLf1k30Eg11RRVWeYS6I=;
	b=wFRyTgh5iLzemsXj0MthjLhFkFk+T/oUw5so4tKc93df/qp3XUEjP0//91ABrO72LDZWWA
	6DOqZ2GdO8dB4KQ2fvSWcSImMetRprkZTdyqi/suBJgic+6Y7YktkkK+V/cvBNH41gSLu9
	yxTqypSv5u0VKOLcKwO+MNZgkYC/ZYnZk4DUfAt0g3yWrDfpvXbYUkJPw+KY9wu2lmt4uo
	9zAL3k32Mig1jq4ZJeU+OndA1bjZdk2F2666NyE+R16DTtb78uW7YJyWTRR7G+Qo3zJ/vW
	xL6O8xtEU5h251EoV00skrMpgNGcr0pV95olUSRyz/dbeEzfpRcvtf0t2+Z0kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747392924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAqrnR9lpSHDZlAAETS+32VSLf1k30Eg11RRVWeYS6I=;
	b=hj8ucecRwdmcFj2oYvgQ0kQwtzo7OZ50CexMIsZVvD8IvuPM4gpusBdRiJjRlyhDME/vuO
	sYiPVi1U5uXAp6AA==
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Toan Le <toan@os.amperecomputing.com>, Alyssa
 Rosenzweig <alyssa@rosenzweig.io>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 3/9] irqchip/gic: Convert to
 msi_create_parent_irq_domain() helper
In-Reply-To: <86cyc8g7di.wl-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
 <20250513172819.2216709-4-maz@kernel.org> <87h61kj10o.ffs@tglx>
 <86cyc8g7di.wl-maz@kernel.org>
Date: Fri, 16 May 2025 12:55:23 +0200
Message-ID: <87bjrsj04k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 16 2025 at 11:47, Marc Zyngier wrote:
> On Fri, 16 May 2025 11:36:07 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> No need to resend, I just hacked up a few lines of coccinelle script to
>> eliminate this offense.
>
> I personally find the rework much uglier than the original contraption.
> Variables declared in the middle of the code, Rust-style? Meh.

That's not a Rust invention and we already moved over to do this to make
the __free() magic more obvious.

Thanks,

        tglx

