Return-Path: <linux-pci+bounces-9433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FC91CBB0
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B054BB2171F
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA238DFC;
	Sat, 29 Jun 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSpIQWIf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMTTsVzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC937703;
	Sat, 29 Jun 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719650282; cv=none; b=bsT/PDo9cL44DdRzxf51R7XEsei9dEW/1Mzw9hFkFT3YGpr2j2mYGZdMV7rbfW/o3fJ84bexObGTSGoTUK7nqkY+a+oKIBjQ9dvrniX+fvqkjkoM+zF+AATw9gVyXWLhPcmhJzei2QgKScorJlpP/1yWxjq+nbnLDrMArVxV6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719650282; c=relaxed/simple;
	bh=q/3lT/7sRnUNMd+59T7wJOpFjJcROwhrHn3K/SaaZQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bz/KddG5h3VcCENjjYLLwx+7odSZZBxZsUkGBx/miUxt+n/FbKll86F3+nQE2oA9Nq51N0er7LsTETW6SXbLTG3w8m49dnqAfOYBfqcNAxImd5y/CUOhZphfIfseY4PcMUZrEz6CUdnrqWzkXs1OlWUDpTz47RSly1JbpvcfZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSpIQWIf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMTTsVzO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719650279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUFJvIfZrgiznYfgSI2fEF0HgrLUinnhHj4NcJxIY7I=;
	b=HSpIQWIfLYjnVetGPvASNKXrCMaFiE/Ws84xltt0Sf+pZ5oVM+xkMuUVy8d7UXuaPsPxkl
	tR+2Gduf1bUgujal8+v9oyrXohkxLqNmS7ASHW9Q3EXGghIhhsv1rB2DXh4uvYyTChtkHP
	ORQfZeGvhccb8xaZRphhmszBxJaG1e0dbtzRzcECzY/Y+djKTt0abXY5Irg24W/xqSq51y
	X/nQJhTiylR7SF4IBe2Bz4y5k21LV0gjHTDd5JGfKt6vxAGYU+5zTAQod9epIZrKQb+s78
	Ksu0GsJLLi7fI6toVSCt/V945PqqPLYWmV9IpjZL1A0dzC0qbjiYKacYHaawrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719650279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUFJvIfZrgiznYfgSI2fEF0HgrLUinnhHj4NcJxIY7I=;
	b=fMTTsVzOPD8Lf770Fvq7+goRYUzr2wpFw6BFLBw+z6xScfjxNz+UMwfdCSx/R2ad6kYULw
	bOD5bUBI/j2uVOBw==
To: Catalin Marinas <catalin.marinas@arm.com>
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
Subject: Re: [patch V4 05/21] irqchip/gic-v3-its: Provide MSI parent for
 PCI/MSI[-X]
In-Reply-To: <Zn84OIS0zLWASKr2@arm.com>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.024567623@linutronix.de> <Zn84OIS0zLWASKr2@arm.com>
Date: Sat, 29 Jun 2024 10:37:59 +0200
Message-ID: <87h6dcxhy0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 28 2024 at 23:24, Catalin Marinas wrote:
> I just noticed guests (under KVM) failing to boot on my TX2 with your
> latest branch. I bisected to this patch as the first bad commit.
>
> I'm away this weekend, so won't have time to dive deeper. It looks like
> the CPU is stuck in do_idle() (no timer interrupts?). Also sysrq did not
> seem able to get the stack trace on the other CPUs. It fails both with a
> single or multiple CPUs in the same way place (shortly before mounting
> the rootfs and starting user space).

From the RH log it's clear that PCI interrupts are not delivered.

> I'll drop your branch from the arm64 for-kernelci for now and have a
> look again on Monday.

I stare too. Unfortunately I don't have access to such hardware :(

Thanks,

        Thomas

