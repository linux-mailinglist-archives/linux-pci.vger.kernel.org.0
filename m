Return-Path: <linux-pci+bounces-16876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD119CDECA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95609283A9E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4B1BF81B;
	Fri, 15 Nov 2024 13:00:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97D76035;
	Fri, 15 Nov 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675613; cv=none; b=YeKSdTByp9UmgM5WI2ceJBqoT0CHBxnxnl58cWuU2+I1dPdkNOyp7KrzAwa9xjaOksyF071P3MqjliLfdKHOA5AF5GNjqIFXoelDdO+VyiG+fsUtKnSiHuNog5BlIZJVI1/pKA0uOJt4EpP1bA52yXy2tsqmDEYiZXqSv//p/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675613; c=relaxed/simple;
	bh=mCnRWVyekBUyqxkFbvRf5JlXVVEgALUqhJyS4P78EI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVHOAcigGunD9pGeUNAk0uB19cWTgAkemKrEiQIn05wMgVHUJNZSs92dCPsDhP0c/nsNOv/DtHnEIpcGzNHbjSe7lKj77R5iESBbeYasbaz3NHc/rRCLygtip3aKTdmqf3g+uYhZmXrd3JINx/Fdr9WYZFomnt46ZlzkhkBVEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 147642800BBF3;
	Fri, 15 Nov 2024 14:00:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0DC5D3D0A2F; Fri, 15 Nov 2024 14:00:07 +0100 (CET)
Date: Fri, 15 Nov 2024 14:00:07 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/PME+pciehp: Request IRQF_ONESHOT because bwctrl
 shares IRQ
Message-ID: <ZzdF1zrgQNNRlkgP@wunner.de>
References: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com>

On Thu, Nov 14, 2024 at 04:20:34PM +0200, Ilpo Järvinen wrote:
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -68,7 +68,8 @@ static inline int pciehp_request_irq(struct controller *ctrl)
>  
>  	/* Installs the interrupt handler */
>  	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
> -				      IRQF_SHARED, "pciehp", ctrl);
> +				      IRQF_SHARED | IRQF_ONESHOT,
> +				      "pciehp", ctrl);
>  	if (retval)
>  		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
>  			 irq);

I don't think this will work.  The IRQ thread pciehp_ist() may write
to the Slot Control register and await a Command Completed event,
e.g. when turning Slot Power on/off, changing LEDs, etc.

What happens then is, the hardware sets the Command Completed bit in
the Slot Status register and signals an interrupt.  The hardirq handler
pciehp_isr() reads the Slot Status register, acknowledges the
Command Completed event, sets "ctrl->cmd_busy = 0" and wakes up the
waiting IRQ thread.

In other words, pciehp does need the interrupt to stay enabled while
the IRQ thread is running so that the hardirq handler can receive
Command Completed interrupts.

Note that DPC also does not use IRQF_ONESHOT, so you'd have to change
that as well in this patch.  The Raspberry Pi happens to not support
DPC, so Stefan didn't see an error related to it.

I'm afraid you need to amend bwctrl to work without IRQF_ONESHOT rather
than changing all the others.

Thanks,

Lukas

