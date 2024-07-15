Return-Path: <linux-pci+bounces-10266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B646D931540
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 15:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E071C21F72
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E638F18A926;
	Mon, 15 Jul 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ0uShy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9322EE4;
	Mon, 15 Jul 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048325; cv=none; b=sbAkKHUAxmlD4mSAMz8hXG/qJpf6rKRQ6+25W4gBRV0dbFs4quQNwkS0s6CvgErAFnjZB5vr16MgfFJNfOU833F50qdkRh0P7fHPyoOJo7QSQXXzHdZxbYJqccqFpDHq+hRM/17CMIoaeD+YC1ad99Xn8/Ij3oZOi1ZZXycETtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048325; c=relaxed/simple;
	bh=938N090mX21Ue6dt/U1tChZbGlOk3IFslj5zQ0oos3I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP+CzFfOrpX1D8ZDQ6NxFYuiqfgd7+wAkZK7XZFpvLHq/zmbn6vYsxC9BqB1KdK+HLzY6RxJSK75MNMmnhtARnTNMxBfPfgo0pSdeenXKdgbSJBxdZZnhx5DvVWNk24lVnFoFe752un0vTr5WoMHLgQxznjMrqjz3QJGHeYJlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ0uShy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEE6C32782;
	Mon, 15 Jul 2024 12:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721048325;
	bh=938N090mX21Ue6dt/U1tChZbGlOk3IFslj5zQ0oos3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJ0uShy+5FUGoMfUDinFemfd8tFcTtSn+1daGiXEJyXYP7Rwq/7pgJlOAZHxf2luj
	 VGE0rvqj85rwDKtLX8bSMddybJiPcKCYX8zBxzcxA6oR56P6uEQRjWCMrVjpkhTPqq
	 NbP/4sfoRcCG3Tb3SBuWuMRu1QQBgMhu2gyBlGst/r5DASbLkr/eXXJv1AdgKYcsA2
	 DnvnNQZAqZM+9JDyKENoNnmlgPhInGTCPX2de6LdPkbrM6DTQD80JK52V/jFTVdxnE
	 MfqBQqh6Lp1OWGj6xt/hiXyu/t3L8yCb2EqE4q7czpv2gWWQei5ZN2OhASQZDNcr6z
	 t9m9zbS+sLJiA==
Received: from [185.201.63.251] (helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sTLHu-00CVgq-CV;
	Mon, 15 Jul 2024 13:58:42 +0100
Date: Mon, 15 Jul 2024 13:58:13 +0100
Message-ID: <878qy26cd6.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to per device MSI domains
In-Reply-To: <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
	<ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.201.63.251
X-SA-Exim-Rcpt-To: johan@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com, shivamurthy.shastri@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 15 Jul 2024 12:18:47 +0100,
Johan Hovold <johan@kernel.org> wrote:
> 
> On Sun, Jun 23, 2024 at 05:18:31PM +0200, Thomas Gleixner wrote:
> > This is version 4 of the series to convert ARM MSI handling over to
> > per device MSI domains.
> 
> > The conversion aims to replace the existing platform MSI mechanism and
> > enables ARM to support the future PCI/IMS mechanism.
> 
> > The series is only lightly tested due to lack of hardware, so we rely on
> > the people who have access to affected machines to help with testing.
> > 
> > If there are no major objections raised or testing fallout reported, I'm
> > aiming this series for the next merge window.
> 
> This series only showed up in linux-next last Friday and broke interrupt
> handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
> and x1e80100 that use the GIC ITS for PCIe MSIs.
> 
> I've applied the series (21 commits from linux-next) on top of 6.10 and
> can confirm that the breakage is caused by commits:
> 
> 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> 
> Applying the series up until the change before 3d1c927c08fc unbreaks the
> wifi on one machine:
> 
> 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22
>
> and backing up until the commit before 233db05bc37f makes the NVMe come
> up again during boot on another.
> 
> I have not tried to debug this further.

I need a few things from you though, because you're not giving much to
help you (and I'm travelling, which doesn't help).

Can you at least investigate what in ath11k_pci_alloc_msi() causes the
wifi driver to be upset? Does it normally use a single MSI vector or
MSI-X? How about your nVME device?

It would also help if you could define the DEBUG symbol at the very
top of irq-gic-v3-its.c and report the debug information that the ITS
driver dumps.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

