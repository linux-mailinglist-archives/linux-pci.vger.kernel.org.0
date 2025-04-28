Return-Path: <linux-pci+bounces-26932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE86A9F1EE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C4B5A5231
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626CB2641F8;
	Mon, 28 Apr 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jgzq8SU4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VQsuJICz"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B2153808;
	Mon, 28 Apr 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846027; cv=none; b=qsLiOEiCGsLpv4N+rgGwzBO58nSZVgWffoAKuQ9cujREKV33fGqMOIJ3KWBh9cdnUJS3kgFgPdzexBdZrCICBN+vaahzuaVMK/bc6Klfx9egdXmxymAsvkMwxTgKZXSMexD4AKsAhekjmy6uykoxMp+Ki6Hab2gktAm+yIKYofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846027; c=relaxed/simple;
	bh=fBDkrtcHnWOZRMjsb2EAjVcZfiBrFGHx5/fX8YtVxug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ypux4GPXvGVQ/yxWguBZHZO40obgXymkxtfpqJy4byWV9dAK+4yb4PozCxqpIBo0sVeeGfhLfvbfIQqufR8I+gZD6XdGCQV9udBf1wIqcOTXKgV2rA/rxEqWohQV8RptF4CGnY90JB+PVDlcVb8QSXw/vvC+59apVwGlwtQcCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jgzq8SU4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VQsuJICz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745846024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4p2KNGoH4RpXnHApo5XcQ+MmbzVaxHkwzaFjw95U/Pg=;
	b=jgzq8SU44nSuBffQa7MjG7Bum3OHasBmml6dTTxWJ7GwP3hJWsr5pFFPa4EK4h5GufXm2F
	L94zdH8Z8byyCl+XOssrd19YiR0vWUrUDRs6jOOtY7hELfwVqg4X0n+TjOrncI8XiFvmqJ
	41aC5wr8bLbwLl7jkKrXk2+vri+KJ5ObbAN0kYtooRXyG+nZdNyc17x8ea0Kh5iCPZ6vVU
	EzhcwDZ4C8gV4Upiv44lFojwQMsPmNfPe5dD/MF8rbn9qadHQsLpAlA8wPqxDMpsK8CHOz
	+1ddKOxb/mDdfbC84AyKV+HKn376dKHt8tc75eGbca4xhDaugEE4zi4YIYyj4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745846024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4p2KNGoH4RpXnHApo5XcQ+MmbzVaxHkwzaFjw95U/Pg=;
	b=VQsuJICzLB11hhy2zHUeeH4u0hUUdZzYJ9oKfrpOAajI2YIz7TKQkQUtPgPEBlQw7ghPOZ
	VbPlK2rmeMDGikAQ==
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: IRQ domain logging?
In-Reply-To: <aAijgnvHRYu_Dlqe@wunner.de>
References: <20250422210705.GA382841@bhelgaas> <aAijgnvHRYu_Dlqe@wunner.de>
Date: Mon, 28 Apr 2025 15:13:43 +0200
Message-ID: <87frhsqvi0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 23 2025 at 10:23, Lukas Wunner wrote:
> On Tue, Apr 22, 2025 at 04:07:05PM -0500, Bjorn Helgaas wrote:
>> This from an arm64 system is even more obscure to me:
>> 
>>   NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>>   GICv3: 256 SPIs implemented
>>   Root IRQ handler: gic_handle_irq
>>   GICv3: GICv3 features: 16 PPIs
>>   kvm [1]: vgic interrupt IRQ18
>>   xhci-hcd xhci-hcd.0.auto: irq 67, io mem 0xfe800000
>> 
>> I have no clue where irq 67 goes.
>
> There's quite a bit of information available in /proc/interrupts,
> /proc/irq/ and /sys/kernel/irq/, I guess that's what most people use.

/sys/kernel/debug/irq/....

Gives the most comprehensive insight into the domain hierarchy.

# cat /sys/kernel/debug/irq/irqs/204
handler:  handle_edge_irq
device:   0000:01:00.0
status:   0x00000000
istate:   0x00004000
ddepth:   0
wdepth:   0
dstate:   0x1d401200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_AFFINITY_SET
            IRQD_AFFINITY_ON_ACTIVATE
            IRQD_CAN_RESERVE
            IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 50
effectiv: 50
pending:  
domain:  PCI-MSIX-0000:01:00.0-12
 hwirq:   0x65
 chip:    PCI-MSIX-0000:01:00.0
  flags:   0x1430
             IRQCHIP_SKIP_SET_WAKE
             IRQCHIP_ONESHOT_SAFE
             IRQCHIP_MOVE_DEFERRED

  address_hi: 0x00000000
  address_lo: 0xfee32000
  msg_data:   0x00000023
 parent:
    domain:  VECTOR
     hwirq:   0xcc
     chip:    APIC
      flags:   0x0
     Vector:    35
     Target:    50
     move_in_progress: 0
     is_managed:       0
     can_reserve:      1
     has_reserved:     0
     cleanup_pending:  0

It shows the complete domain hierarchy for each interrupt an
irq/domains/.... gives extra information about the domains.

You need to enable GENERIC_IRQ_DEBUGFS.

Exposing this in dmesg in a comprehensible and condensed form might be
possible, but needs some thought.

So far I survived pretty good with the debugfs data.

Thanks,

        tglx

