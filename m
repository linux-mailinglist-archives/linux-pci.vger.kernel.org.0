Return-Path: <linux-pci+bounces-10252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AEF9312F2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 13:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AA9280DEA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1B13D8B1;
	Mon, 15 Jul 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/VLy25s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6A27442;
	Mon, 15 Jul 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042331; cv=none; b=AXp1B8R3WmmrynrJNjKEJ04lFNIom2it0sLsYH7aDOInf7/QJXrEHGw73/ZqocoN2Vylav0cWuA0xDmWKBgm/fvgZN53OW/WwSLTyesLMVAqaUG9y8q81FieRS4veGnBiQEpcjSFWN68svq7SdNYTvGuJNUjzlGsmP2wUf7YwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042331; c=relaxed/simple;
	bh=gM6v1f3MVNVjpe3F220a7SyLMJ+XXmEPJpYxkhnosME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbjYjQvln/8DwD12UD5ruLDkK76/l8C+ApkOfytQf06KF3+fllhfEf5II3KoFoC21aDNVM/uW6d0G/feuMpv+rmjHf9AoVokBmShMM2TzdM6Q1vRDI04tGg91tdcoBBCkp50MvkDaEEsyoYIc6hlTX7U+7i/RkguD/MQ5AIlFMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/VLy25s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEDDC4AF0B;
	Mon, 15 Jul 2024 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042331;
	bh=gM6v1f3MVNVjpe3F220a7SyLMJ+XXmEPJpYxkhnosME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/VLy25siMjF9WNsZvykAgzkawWpLkykU0qPvr4qwLqfxqcb+E8ZrCOHtxOHZ9y4m
	 qlzjqFN0aN0p3NdZL0fS+6SRGayKo6Lm/9rl4wtpczRSaLBJKOCs4pwWIMSLBxY4CB
	 7l/kQ0jTb77F7GTiVyqqbzA8jA0PywZKwQDDaN09q02Akv68nqm9qMw3GkCjRI3FAY
	 ToXDBqLwr7xiC1l69s9zH7FaQgoJz+5PxBBB8NRZVx4+H8QabdIva7Yldqp8uG9Lt7
	 JP8Un09W6bvsuFlrn5Ih8tpnmU6483NPvtrYaMSZhSHm6eWEfr4js3wZJxqsN6iVot
	 5FkdSmBFh4pIg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTJjD-000000005Ns-2vD8;
	Mon, 15 Jul 2024 13:18:48 +0200
Date: Mon, 15 Jul 2024 13:18:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
Message-ID: <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623142137.448898081@linutronix.de>

On Sun, Jun 23, 2024 at 05:18:31PM +0200, Thomas Gleixner wrote:
> This is version 4 of the series to convert ARM MSI handling over to
> per device MSI domains.

> The conversion aims to replace the existing platform MSI mechanism and
> enables ARM to support the future PCI/IMS mechanism.

> The series is only lightly tested due to lack of hardware, so we rely on
> the people who have access to affected machines to help with testing.
> 
> If there are no major objections raised or testing fallout reported, I'm
> aiming this series for the next merge window.

This series only showed up in linux-next last Friday and broke interrupt
handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
and x1e80100 that use the GIC ITS for PCIe MSIs.

I've applied the series (21 commits from linux-next) on top of 6.10 and
can confirm that the breakage is caused by commits:

	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")

Applying the series up until the change before 3d1c927c08fc unbreaks the
wifi on one machine:

	ath11k_pci 0006:01:00.0: failed to enable msi: -22
	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22

and backing up until the commit before 233db05bc37f makes the NVMe come
up again during boot on another.

I have not tried to debug this further.

Johan

