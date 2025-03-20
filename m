Return-Path: <linux-pci+bounces-24219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B810CA6A1BA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3691B16731A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D3207A0F;
	Thu, 20 Mar 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2wg2vuJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5SgXWhI"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E6130A73;
	Thu, 20 Mar 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460507; cv=none; b=if9FAWUSbOzCHTQrBAhF5x3AhN3XRBS3ALZ/mx5LUomlu6PBtAYZ+akbx/vW2Y39dY5pmZcvPkTux3QMvC3PaVyJkVYerzvdIYYpSj+iPw2PyPJkc5l5daEyKd2gDfhvidwofWCQSegxEA/9WsBSU/8hYj13W3NRVpsuDUhGSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460507; c=relaxed/simple;
	bh=aSzSfbFxyW0DCZ/9YIQGJxTqKVV2ZHUsAEQuaVJC12Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOWcUaHrWgUZazzWVxSkatT3sPwLzHtivMpCDZrt+aZQh/jyJeOwQhL7ej8Y1tnJbxviHPwShodzNvDjrLqSzV7vWcmxnQ+KS1zgp6koDJ3uVRk4PmaPt/lrZcCsJ+nkWtz1h0tIZoe5hLeDBUAlqE33tdv49oQD9RaWNXa20U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z2wg2vuJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5SgXWhI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742460504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ0fWumRi3cSVABPnhheHjD9lGzrLvyFl+HCBfJN+Bw=;
	b=z2wg2vuJQk5IcDQjB9Ogzc+FrG4h58MTWJe5+QNnZKpTA1VFDJOd/x6WY8KRU+cJys4oyg
	Cd9WsrvKKii1g0EAeGMNHYT4LtWl86hiKyKgQsqW2JUvTTdng1nFEVwjpuvwkiLbGYwnaE
	z2MEqrXiVWVw6yq81jZW/1i6rGWztZYcvapnixIkTpqd5BroA8mb1nnFdsRptyEGNIOEpX
	MWwT/K/HIv7QQPqGTUakz+spCW0AlZp/2dtu8Uaby2cFCXts/4xz8sVZY/TGq/tprwfHwC
	512WqJ6nNj958tjBC4F5yofsikS8+ftGdoxO5XxL7cSU2NvXAhIQ4ZoUrUAyjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742460504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ0fWumRi3cSVABPnhheHjD9lGzrLvyFl+HCBfJN+Bw=;
	b=S5SgXWhIa5tQX9KrG8tLAilp7eDawznMy5pDFv4rMbSEikKajt61fI6a4CY9qNXnsTMk52
	duIc+eDNOUwsOCAw==
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <877c4k3yc5.ffs@tglx>
References: <1742386474-13717-1-git-send-email-wenxiong@linux.ibm.com>
 <87a59h3sk9.ffs@tglx> <90777da90abe02c87d30968bfedc9168@linux.ibm.com>
 <877c4k3yc5.ffs@tglx>
Date: Thu, 20 Mar 2025 09:48:23 +0100
Message-ID: <874izo3x60.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 20 2025 at 09:23, Thomas Gleixner wrote:
> On Wed, Mar 19 2025 at 21:58, Wen Xiong wrote:
>> We don't see the issue without dynamically remove/add operation.
>> There is a small window which irqbalance daemon kicks in during device
>> reset. So it took about over 6 hours to recreate the issue when doing
>> remove/add loop operation.
>
> Sure. You need a loop to hit the window. And it does not matter whether
> it's the probe or the remove which triggers it. Fact is that the reset
> wipes out the config space, which means that any read from the config
> space between reset and restore will return garbage. That problem is not
> restricted to the interrupt code. It's a general problem.

After looking at the code again, it's a problem in the remove()
function:

__ipr_remove()
  ipr_initiate_ioa_bringdown() 
    // resets device
    restore_config_space()
  ....
  ipr_free_all_resources()
    free_irqs()

So yes, it's not probe(). But the question is pretty much the same.

Why is a reset issued while the driver is fully operational and
resources are still in use?

Don't even think about telling me that this is a problem of the MSI
interrupt rework. It is not. It's been broken forever.

You _cannot_ pull the rung under a fully operational driver and expect
that all involved parts will just magically handle this gracefully.

What about tearing down resources first and then issuing the reset?

Thanks,

        tglx


