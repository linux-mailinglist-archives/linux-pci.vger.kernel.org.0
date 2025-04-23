Return-Path: <linux-pci+bounces-26498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD3BA98388
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07443A4E9C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A6285405;
	Wed, 23 Apr 2025 08:23:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9E285401;
	Wed, 23 Apr 2025 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396623; cv=none; b=hjPvQ4ZZzpM4XTp+yKQd8Oj93XsbHZ39CwrXz9Y5pkqxEpMZ4GnBAkIfzZobmJ7qvGzq4FaWXTg1G2jduUiyTuaDRBBiglqnyMv5ED9x4eze9QyqQ6qNZCa8vIaCsrndIcp0bZ31fVZqL+LpEFLHiB13t6A9jPBgawgvniE/+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396623; c=relaxed/simple;
	bh=hUoqsp8kYW98lcqyttv8aTu4OTJd/sEM4L+uCbnHJPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGoP6QZpZ5AI3F6khQ9fE0xeFHDQeDxWMCJbA/QipOy9hAqtKB+qcVGUht7KlJozh+Sk1ZtigeGkStNZrWTtUSyguGR/kO5Ej/GxAXUwnw8y9bbihAa4MbwmgIjqkgIa1lxjoSzihGOXyxSvunuAhKzO59eN1xblGRrXsSx0hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id B253B2C00093;
	Wed, 23 Apr 2025 10:23:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E5878107CA; Wed, 23 Apr 2025 10:23:30 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:23:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: IRQ domain logging?
Message-ID: <aAijgnvHRYu_Dlqe@wunner.de>
References: <20250422210705.GA382841@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422210705.GA382841@bhelgaas>

On Tue, Apr 22, 2025 at 04:07:05PM -0500, Bjorn Helgaas wrote:
> This from an arm64 system is even more obscure to me:
> 
>   NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>   GICv3: 256 SPIs implemented
>   Root IRQ handler: gic_handle_irq
>   GICv3: GICv3 features: 16 PPIs
>   kvm [1]: vgic interrupt IRQ18
>   xhci-hcd xhci-hcd.0.auto: irq 67, io mem 0xfe800000
> 
> I have no clue where irq 67 goes.

There's quite a bit of information available in /proc/interrupts,
/proc/irq/ and /sys/kernel/irq/, I guess that's what most people use.

Thanks,

Lukas

