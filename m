Return-Path: <linux-pci+bounces-35436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED055B433FC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 09:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EBBA7A942E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C7242D92;
	Thu,  4 Sep 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1NcJy0u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gx6iCLxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260951E04AD
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971029; cv=none; b=uI2PGo1Y6TgtZivlPE7mgEbHIdSX/UBSjV0qC8A6vhL5+zYOW9Qf2YtJ464IZ7F+Ybi8PAifpB4od7tn3h70l73UAgwQZla8v6pHJ/LVj08CEbvHp2ayVwjhJ3xWG99n9TUXnTo8O3Ay+Weyq1soJELqQ2XtW9gConLPMxiiYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971029; c=relaxed/simple;
	bh=Ixc98y50p4OgaTFwWHSM5zW9l2ONIM7iWep6P8DAQHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbxlmruYAwt9dKCNzqgZZ8ZVDxFP4hsGq60fLhZF5TEu0bb/0rYEuI9elI5N76GYojvsZwJ0jyrhHVjkfCtKSpng5STyklMMsYvoOJa5BFKicODH3IMDtm1BjOZVZWeG55ZuYR1dVSCW5/KFqhHmr254xR6vhkr8vTQs7cJ9xbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1NcJy0u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gx6iCLxA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 09:30:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756971026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v19daYK7RwpDzpCxMt4efA2yMOM1nVWdKgeweEfjHSg=;
	b=V1NcJy0uNeI3ubyp9McqZGo4tLpcgTDb/CzKO0rOO+2BbeYix7emyfrfet+68QCvQdBDhd
	cOH5ANhZ4u+WhpQcSkVCu1tKwFuOSDP/YVzfBaGb1zcXRAt/o16pDfIfZZvt4oTihkAvul
	HzMDjiSMuaLV40MQq1iLM7gIt9Xg/GUC7fRa8B1d0ZDirQmidQIqZaIQKsEsy3ylxEvJVu
	/mfkfKSjffcJF6S5cJBLqLQYXmGbqHSQAQAQB+5Ij7dXe1A+2x4jcvp5mKUvNMeQ/v62fI
	XU234yXPNjS440XAwczceH6QYE/8cznqLHz61T4A3hi8K3BZhac5cH2Qg7rLiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756971026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v19daYK7RwpDzpCxMt4efA2yMOM1nVWdKgeweEfjHSg=;
	b=Gx6iCLxAmkpVk52DjHEfnd9NV0p+6i6pzm4L8sM7xE6f/mC/LGrCR1PW346OmMhYTFMZZZ
	1WIVGwWFze2T6fCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Crystal Wood <crwood@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Message-ID: <20250904073024.YsLeZqK_@linutronix.de>
References: <20250902224441.368483-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902224441.368483-1-crwood@redhat.com>

On 2025-09-02 17:44:41 [-0500], Crystal Wood wrote:
> On PREEMPT_RT, currently both aer_irq and aer_isr run in separate threads,
> at the same FIFO priority.  This can lead to the aer_isr thread starving
> the aer_irq thread, particularly if multi_error_valid causes a scan of
> all devices, and multiple errors are raised during the scan.
> 
> On !PREEMPT_RT, or if aer_irq runs at a higher priority than aer_isr, these
> errors can be queued as single-error events as they happen.  But if aer_irq
> can't run until aer_isr finishes, by that time the multi event bit will be
> set again, causing a new scan and an infinite loop.

So if aer_irq is too slow we get new "work" pilled up? Is it because
there is a timing constrains how long until the error needs to be
acknowledged?

Another way would be to let the secondary handler run at a slightly lower
priority than the primary handler. In this case making the primary
non-threaded should not cause any harm.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> I'm seeing this on a particular ARM server when using /sys/bus/pci/rescan,
> though the internal reporter sometimes saw it happen on boot as well.
> On !PREEMPT_RT, or with this patch, a finite number of errors are emitted
> and the scan completes.
> ---
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 15ed541d2fbe..6945a112a5cd 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
>  	set_service_data(dev, rpc);
>  
>  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
> -					   IRQF_SHARED, "aerdrv", dev);
> +					   IRQF_NO_THREAD | IRQF_SHARED,
> +					   "aerdrv", dev);

I'm not sure if this works with IRQF_SHARED. Your primary handler is
IRQF_SHARED + IRQF_NO_THREAD and another shared handler which is
forced-threaded will have IRQF_SHARED + IRQF_ONESHOT. 
If the core does not complain, all good. Worst case might be the shared
ONESHOT lets your primary handler starve. It would be nice if you could
check if you have shared handler here (I have no aer I three boxes I
checked).

>  	if (status) {
>  		pci_err(port, "request AER IRQ %d failed\n", dev->irq);
>  		return status;

Sebastian

