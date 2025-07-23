Return-Path: <linux-pci+bounces-32785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C76B0EB50
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 09:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FC3580B38
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 07:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DFF2727EA;
	Wed, 23 Jul 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mCUxXdoD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1p9cEwV"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBF27146E;
	Wed, 23 Jul 2025 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254480; cv=none; b=WTby4Nn5l/nuNK0g0L338+2UOuDFg39l0V4+akkGP2Ks+qC6KIKo75+z8qHDyYQb8kptTBM6NOjhH4SDkLsq9HSnhzEUdiEpmZ/QiiNM9hOMrkbhp2MDdmWEZdCSpX3Wy8Ex30LgFBM71HseMvr2rXlUHs7M7ZQ1d8WqK5F5o3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254480; c=relaxed/simple;
	bh=00SHje/HeHU9BetHBrRyLZqjw+/vmih4cBwgU6MjxuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRQgzFGuYsarECDhhoj7d1Bf5r7HE3uZYrbcubK9++gEjzYFceYjPbF0M8x2CAQCMGIj7ceIiPDr0Fx2inmmMztwAvV7hQuUu1zbyeZgwnE27idPh/PKnm2fdT/Qbr1y2+Fsu5YUli6lcsLbwOngluzfIz+7efA7o+s//UYxq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mCUxXdoD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1p9cEwV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753254477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00SHje/HeHU9BetHBrRyLZqjw+/vmih4cBwgU6MjxuA=;
	b=mCUxXdoD/2wy6VchdnvvCQLlYZe305RJNgyWNBh6k1fgq+MF12t61dVpeQClNTSb7v2Gwn
	EPaNAWvrfUf3wuQBoVaF5w076nUUYthvppIy87m6S2NrDUsaGYiT2prZhgIoYFA+O0v5BK
	ONg4GIBrM3quWJKp4r/vMpInL9vXhYa437dxr8zcJaAGOijHTCU9bseIV337BeVFbUWqat
	hQ2EX9IV/t0zxfCVQCENJ8jUIOhQz9a2XRKjKQMA6yzV1qMPF866xCrRNA3DlxTzgyZS2M
	C5Y5RJWv5CaARbhPHV/iIL1Z9PVL8Hsy2RzonvaDjjt7kHwXuT2vCqx+KMsC7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753254477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00SHje/HeHU9BetHBrRyLZqjw+/vmih4cBwgU6MjxuA=;
	b=L1p9cEwVDxHRSbendgDHLRMVW6NZ+nwQvIEba1utRiPxgt3GCRZPClYCXQj6+DXAdyWtEV
	l9Uht655bJ7wKxDA==
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jim Quinlan
 <james.quinlan@broadcom.com>, linux-kernel@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix typos
In-Reply-To: <20250722213743.2822761-1-helgaas@kernel.org>
References: <20250722213743.2822761-1-helgaas@kernel.org>
Date: Wed, 23 Jul 2025 09:07:56 +0200
Message-ID: <87ldofs7ub.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22 2025 at 16:37, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix typos.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

