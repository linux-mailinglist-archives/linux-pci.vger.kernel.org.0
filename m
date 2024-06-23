Return-Path: <linux-pci+bounces-9131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3FD913A07
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802D01C20A25
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF1132126;
	Sun, 23 Jun 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXCpPwb3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1cXC6WjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8212FF8E;
	Sun, 23 Jun 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141989; cv=none; b=cyOTKEuRdpwkVwyHgkRTAE9/kpOmRDbF2+qkEvgpO/qNbWTPbG+T9MzDn9OcDZrNfrVsY3tGHUwRdXR3gCyiuzjvUcawhmAYKV2anDWi4vDqbOjufOoLtrUVa8qaziw5GOTFPjaNwoz+knxWrfyrhV3dK2skP1/s0GC0ZbtTebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141989; c=relaxed/simple;
	bh=qhsrUwI1BaRjMxZQpPQjnVJKvkarNUwnbDUiSbpWpiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1EbonDN7FHW869NOkDGRpFDOIm/+FzRRBrAmRdAs5OpBRol/hPgFhXJsndWHVZcMqeE0nMQPqA7uaiP7Ql7n9tOK3MnQiDEmESaII+VYK9F0+EDkBaG6kqo8lm1VeOh0nqRJPRvJBIvMb/7ypK4VfWuG3HLdfzVWVDULZAYhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yXCpPwb3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1cXC6WjM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719141985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qhsrUwI1BaRjMxZQpPQjnVJKvkarNUwnbDUiSbpWpiE=;
	b=yXCpPwb3c/49RP1ZeXUBNHFneSzL1Ppntcu+GFWtqeAEssBbP3UE1vFdfwK2rV7+mAe1Op
	iFaele5JBPedNEEKYrFULToFezevGTfVAh9yWTmORURjUhCFu49o2lL/if1J04I027Hpz5
	78VZz3DWIQ/17aryT884x/0yOyY3QRk7gYaW2tMm+OutvlZqXUWKfbWlyGFX+xWGxWpPUA
	gqEHYVwzJtV4pMdEKvrDVBDgl2OYXrP+gawmHB6NigIks0D4cY3byIKi4F5p/F16BGuB6t
	+9v9EqkNBBSJ1lVNT9wdzku8NvYUm8X+m5b0l5L05xGEbeaiY2uIr1q2AUx/Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719141985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qhsrUwI1BaRjMxZQpPQjnVJKvkarNUwnbDUiSbpWpiE=;
	b=1cXC6WjMjs+tsE/qAxPS1jrIP6NHXTC1LS/fH5wuK/lBL8IWdHxRC+COE/Vr1AMtsJbqWa
	CVFMFYxLTM5JULCA==
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
In-Reply-To: <87le2yo0ib.ffs@tglx>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
 <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
 <86le36jf0q.wl-maz@kernel.org> <87plsfu3sz.ffs@tglx>
 <86h6drk9h1.wl-maz@kernel.org> <87h6dru0pb.ffs@tglx> <87ed8vu033.ffs@tglx>
 <87le2yo0ib.ffs@tglx>
Date: Sun, 23 Jun 2024 13:26:25 +0200
Message-ID: <87le2vyk66.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 21 2024 at 16:04, Thomas Gleixner wrote:
> Gentle ping!

Whatever. I just drop the patch and be done with it.

