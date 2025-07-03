Return-Path: <linux-pci+bounces-31439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3C7AF7DED
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E74189C417
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C3248F64;
	Thu,  3 Jul 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PBBXZF4k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Uirmdc/"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B624DD00;
	Thu,  3 Jul 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560151; cv=none; b=h4Zns5grSEHogAitaJplkpNmDSZEKm6vzemSR8W6U6JDAIyrtzIWAuW/7IWurGZDUHlUwl3MjmFa4hSz/CWkBd1h83jj1nf15FHSiDCq5XeZDqqDpLGRDF0q91/ckpoBh9e+85iBfJxmNpAZlopMapFoPuXiPw6m380hMEM5NPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560151; c=relaxed/simple;
	bh=nToq4wwc4Uc7nbyaMfiALbolZIwWgKsAua7F5h9q2tQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UIuGoBOwiyFab5ytO3mnw/WvK5xpWjHw4lZ+G8LntOnV0H7h7q4ZIaDcdHelhpiseQEc7jOD/HLgiwbGtzg0ixcoSBrm4nDVJnSYZOIwdxFXv2JJiac8kx3JSGF2MuhJhekKUoJBtbVJ8W69FlpitZGvhj4C606XhuqJ/xTyhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PBBXZF4k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Uirmdc/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751560147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNRH1g12Ne3BwA8FmDNO10ARExu6uL6cJ1LMrZ27OI4=;
	b=PBBXZF4kI/WbElBKU/Utuj8jjVt/2dVrbejvGTcXKIQRU2uYoTKAqpHmGsySadjRy0LdQM
	ZZdkKSeeI9H/B4hejFC0zufMbUcLT6n6EzmboNb5TgH9LtltqIvv77ExiIQjU4+YTNRlPB
	LDs7slQQ0aoI7BHwHRw89RbfHV4RI4PqFuSJLMGQA8PKk1aej5pZ/qIFh2a3BzGOklukU9
	TDsBx3nmgSUaK6+/vtL2crKw+rhIgR+lZ6bwu3ns+AJkZosFZR7wACzljwIgp2xwLFz+ET
	BwKxONiv/rg1ioO8PGKJ6NSRgSjbXvV2PT1jH93SiBabI1RRJ1iPXq9Oj328VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751560147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNRH1g12Ne3BwA8FmDNO10ARExu6uL6cJ1LMrZ27OI4=;
	b=/Uirmdc/9olnKo8974l+b36bgV4+yNj/U1X0RSMH6B5yU9vJJBmZpDUYSoy2WLPu8k3+9e
	sRyPNBcdYArNPACg==
To: Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 01/12] genirq: Teach handle_simple_irq() to resend an
 in-progress interrupt
In-Reply-To: <20250628173005.445013-2-maz@kernel.org>
References: <20250628173005.445013-1-maz@kernel.org>
 <20250628173005.445013-2-maz@kernel.org>
Date: Thu, 03 Jul 2025 18:29:06 +0200
Message-ID: <87y0t5tezx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 28 2025 at 18:29, Marc Zyngier wrote:

> It appears that the defect outlined in 9c15eeb5362c4 ("genirq: Allow
> fasteoi handler to resend interrupts on concurrent handling") also
> affects some other less stellar MSI controllers, this time using
> the handle_simple_irq() flow.
>
> Teach this flow about irqd_needs_resend_when_in_progress(). Given
> the invasive nature of this workaround, only this flow is updated.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

As I have no conflicting changes pending in this area, this can go
through the PCI tree along with the rest of this lot. Therefore:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

        tglx

