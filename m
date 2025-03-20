Return-Path: <linux-pci+bounces-24207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C1A6A14B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B819F3AD182
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388032153C5;
	Thu, 20 Mar 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpBPjPHO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ASM7tm++"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AE20FA97;
	Thu, 20 Mar 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458998; cv=none; b=OcTuESWtsu1PealC3bnZbNPZGjSSJkKidpAIK1NBor9EFH82ybpwuNNtnnsQvznm/yAj4T+CaVrP8KBk6bBK3N6yRIEEcZ0rzTvTNjLxY33yPdggK9VT/rWGto+oiWb2/7vMlcYGBppPLLUVKNqUnJXINgdtWq88tMdl3xx4jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458998; c=relaxed/simple;
	bh=tv5wCB4p8oeh66WwO1jDuyzP1uyHfR0URb1jM6Btmvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S4moagWeXHbk6ESH7pVQavHcCIQp6WpaZ6kDkLiUWAluBcKBpKtkhnx4WVXof1GCh2okQ0l3WukSB+DGhlvCq6W2Hd3gZfEOGEcw2TBekpLs/auYv5HwsY9+CPRqigrgI+Fk/ihsVbncvAybIQr8sLQ+li+2WYEmcknL3fKaCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpBPjPHO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ASM7tm++; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742458987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+FF8L31bluj5IUvydOuAJAVMO+mokt/1K0z0gQUDYk=;
	b=MpBPjPHOPXus5HC2PFkee+KTnGmNVP6AK4KIHjIDgp/YIA7znKhp9gOGKw2km2t53amaLr
	M6vjtc2JfqVieI7duEYbWa/1ctQlwgP+b74S31fZAo2N9TYQxolocBPy/oeBbeo34hzlf3
	EEZQZtTm8C1dK2FLbNKM8hAA6sMiaYqo8VRziGzIXe+K9Bh1ljV8PuUsqGPUw31Fv1+xQV
	iSf7KmTC2qq4kQAIq7yVh8tjYzaEuh8J7sgo0/SND4lj+zKtE4Ku/uV4MmVXXR3EojfZsn
	y8CwrHi7K8jN11/xtwMueXHzB21KqMQ8ICpEn1x/vjNRiCZYhvaOY8FFX0Z3DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742458987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+FF8L31bluj5IUvydOuAJAVMO+mokt/1K0z0gQUDYk=;
	b=ASM7tm++d8S2C0lKTd6aaHKKbgaE6Og+CdejqgcPe0ucSsytZo3OZ4Ej30a+EyBB3K6d19
	Urtw4vRGNlMnsTCQ==
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <90777da90abe02c87d30968bfedc9168@linux.ibm.com>
References: <1742386474-13717-1-git-send-email-wenxiong@linux.ibm.com>
 <87a59h3sk9.ffs@tglx> <90777da90abe02c87d30968bfedc9168@linux.ibm.com>
Date: Thu, 20 Mar 2025 09:23:06 +0100
Message-ID: <877c4k3yc5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 19 2025 at 21:58, Wen Xiong wrote:
>> The real problem has nothing to do with a remove/add operation. The
>> problem is solely in the probe function.
>
> I don't think we have problems in probe function since this driver has 
> been in productions for many many years.

Seriously?

It does not matter at all whether you had it many years in production or
not. Fact is that the driver is operational and after that a device
reset happens, which wipes the config space. That _IS_ the problem.

> Also we didn't see the issue before the "MSI domain" patchset dropping 
> into linux interrupt code(no issue in rhel92 release).

That's completely irrelevant. See above.

> Device reset is not called in probe function.

Right. The reset is part of PCI error handling, which happens _AFTER_
the driver has set up interrupts.

> We don't see the issue without dynamically remove/add operation.
> There is a small window which irqbalance daemon kicks in during device
> reset. So it took about over 6 hours to recreate the issue when doing
> remove/add loop operation.

Sure. You need a loop to hit the window. And it does not matter whether
it's the probe or the remove which triggers it. Fact is that the reset
wipes out the config space, which means that any read from the config
space between reset and restore will return garbage. That problem is not
restricted to the interrupt code. It's a general problem.

> We can't find the good way to fix the issue in both of device drivers. 
> So we look for some help in interrupt code.

No. This is _NOT_ a interrupt specific problem. You are observing the
symptom related to interrupts, but any other code which reads from
config space during the reset window has exactly the same problem.

The PCI error handling resets the device asynchronously to any other
operation which might access the config space. Yes, set_affinity() is
one possible way to hit that due to the implementation detail of
pseries_msi_compose_msg(), which reads the MSI message composed by the
underlying hypervisor back from config space. But even if it would not
read back and compose the message itself then set_affinity() would
create inconsistent state because:

       reset()
                        compose()
                        write()
       restore()

I.e. the reset machinery overwrites the new message, which means this
ends up with inconsistent state.

So this is a general problem with PCI error handling and _not_ a problem
of the interrupt subsystem. I have no idea what to do about that, but
this needs to be looked at from the PCI error handling side and not
papered over at the messenger.

Thanks,

        tglx

