Return-Path: <linux-pci+bounces-39030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D64BFC61C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4183B4E6522
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D734A783;
	Wed, 22 Oct 2025 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvMK3vyB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF2337B99;
	Wed, 22 Oct 2025 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141949; cv=none; b=OWYgimrqxQ9ThLrqWgrLKpWihZIpHJVHxJLv1incaqwJNIj+M2+G3R9xVSVVGzcOVuPWYOuJX6mv8AMopR3gpP0KniLdqhVxdmpYS1XifbkKiUgsgGfl7U6cslUCkaqO/tJP/htYqvp908cE7161b90eAxHOwydDReQmrJJpcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141949; c=relaxed/simple;
	bh=vX0gXdN6jv2zlOWrLKcyRh+bVnN+mK0EFHUlCY63Z1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaLgRt+n/H1oTfQVaoTC6qPheHjgoH8NuW5/beZ+QJgtzAaxOW4LcFyZQnZFVPyR9XHRGgV16Jfw9SwUjQuJmRXAmio6LjFhrzjK6SHIebu6rywEDQhmxRoLmyNnfsxkC9lV0XNQ3pUHwEmXtBo8VhS0SHV2qrY0ZlPZLc7ugvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvMK3vyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9E8C4CEF5;
	Wed, 22 Oct 2025 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141947;
	bh=vX0gXdN6jv2zlOWrLKcyRh+bVnN+mK0EFHUlCY63Z1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvMK3vyBbV4PLL1HkhvCld7i9mlFxwPA6kg4WyEt4jlaMNpXy9E1aCRDM9EceZETB
	 cUAmICAHoVOk6nX93XGnqte7ip9eJVo5gzjb6DgZ6ek4R0SSiJ4LSp/seWWamZ/ZuG
	 wBBac6K5/RgjgWGadgXGWowzuBDJg6P5nx50MOQE+i/hGou4w9mPh2IBSBgVQzu44a
	 qbKOM57k3x8kzkYqx5J3YivQ0blkt28Dr1G6Q/VA596R3zPQM/tE5k7w+t8HevXRjy
	 dYu2l2BvCNhj/CyOzudz5FaMN6kpBywmrSZBXsLYB3FZ5b5vOz3QcONT1G6TAHjlDj
	 Ve8+GP3ZETBgw==
Date: Wed, 22 Oct 2025 09:05:45 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 0/5] of/irq: Misc msi-parent handling fixes/clean-ups
Message-ID: <20251022140545.GB3390144-robh@kernel.org>
References: <20251021124103.198419-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021124103.198419-1-lpieralisi@kernel.org>

On Tue, Oct 21, 2025 at 02:40:58PM +0200, Lorenzo Pieralisi wrote:
> This is series is a follow up to [1] - with additional patches that are
> addressing Rob's feedback (pcie-layerscape-gen4 was removed from the
> kernel, Yay !) and other bits and bobs I noticed while staring at the code.
> 
> Patch (1) is a fix and technically we would like to get it in v6.18 please.
> 
> Patch (4) is compile-tested only, I can not run it on HW, I do not have it,
> Scott, Ray please test it if you can.
> 
> v3 -> v4:
> 	- Addressed Rob's review
> 	- Added trailers
> 	- Rebased against v6.18-rc2
> 
> v2 -> v3:
> 	- Added additional patch to export of_msi_xlate()
> 	- Addressed review feedback
> 
> v3: https://lore.kernel.org/lkml/20251017084752.1590264-1-lpieralisi@kernel.org/
> v2: https://lore.kernel.org/lkml/20251014095845.1310624-1-lpieralisi@kernel.org/
> v1: https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/
> 
> [1] https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/
> 
> Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> 
> Lorenzo Pieralisi (5):
>   of/irq: Add msi-parent check to of_msi_xlate()
>   of/irq: Fix OF node refcount in of_msi_get_domain()

I've applied these 2 for 6.18.

>   of/irq: Export of_msi_xlate() for module usage
>   PCI: iproc: Implement MSI controller node detection with
>     of_msi_xlate()
>   irqchip/gic-its: Rework platform MSI deviceID detection
> 
>  drivers/irqchip/irq-gic-its-msi-parent.c | 91 ++++++------------------
>  drivers/of/irq.c                         | 44 ++++++++++--
>  drivers/pci/controller/pcie-iproc.c      | 22 ++----
>  3 files changed, 68 insertions(+), 89 deletions(-)
> 
> -- 
> 2.50.1
> 

