Return-Path: <linux-pci+bounces-33670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B9B1F539
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 17:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBFE3AE17A
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53E276058;
	Sat,  9 Aug 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5tx4/DC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yHa0EYuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00D176ADB;
	Sat,  9 Aug 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754753540; cv=none; b=rBm0bUW4tfQC69gnB1W7bao3BptfpmsGABcdhFCFJmXpZXpgZL/RS6wnDiIEtxD6Zgqj0p6f8Vn7IjIZze/mJ79GtbbzAgyj3MzUPTNQOc0BjqcNifnKjwM6+X7NZ7e5hVbL0rkt64+8wI3dwTPZyn3gO7KZHD72ZazfIwf3vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754753540; c=relaxed/simple;
	bh=wsbKp4Rul3bBUSC3LqRvUkLGDNGpyyc3CDONbZFn5hM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iswFz/ficz9+XclPbr3H6tHoE9fYPj+uuP9xyzskDdoj55yGxpG9mck8nkfj+3B56rG/eHR1AKR0CDok6eSNxZA+EYERKZJ4RSVwWUm4ZOxi215V/QXnnGKb/WMJ4GXjKhkPXkz1Z7nU7cjHwIE2WxRHBkYVYXnV5T8PoQ/ax/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5tx4/DC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yHa0EYuk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754753537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZbRABX71KNiM1YZsVSV5L7I+pnm05kQRVz0yjcb9Jc=;
	b=t5tx4/DCOsGMhdOC+GYxsOc8pGy6NjeC2wnDn/BjYlLNYJevf7hwH90b8GvHvDvxjPxXwz
	XA3Z7OfwDWFGqCyhHckVT+n4Y3NC4Zdg4xmfdgJ+LkCmOQFYzSb+Z9dAHrq48wiaoLbLyZ
	UFFrKog4Q/lP8ubEjAdqWD35OfBfixgDIekWy2EzyN5Z67Vb6LCIzvyIBTLxTfub7bCFi2
	DhbDlvIBVxN88ozGe0iYXOQ9ot0JvxUSl0FfYlumHTGV2TmfuANGcqQeXmBXEIMXvw+5Qz
	IMYeCE1iiXnFFVIi++/ts/EZDgIoPaPHbfKRK4YEFnKet7f53dHBe5ofdNFXrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754753537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZbRABX71KNiM1YZsVSV5L7I+pnm05kQRVz0yjcb9Jc=;
	b=yHa0EYukbFVUAlOsG4vONfTw5FGbtm4aPI4DvjK9nOeHCG5IDBGQ5Nzvf9ZLLp/TQ9zr1g
	p4gZpfNcZ7HutKCg==
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux PCI Mailing List
 <linux-pci@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Armando
 Budianto <sprite@gnuweeb.org>, Alviro Iskandar Setiawan
 <alviro.iskandar@gnuweeb.org>, gwml@vger.gnuweeb.org, namcaov@gmail.com
Subject: Re: [GIT PULL v2] PCI changes for v6.17
In-Reply-To: <aJdmGwFU6b9zh1BO@linux.gnuweeb.org>
References: <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org> <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org> <87ectlr8l4.fsf@yellow.woof>
 <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
 <20250809043409.wLu40x1p@linutronix.de>
 <aJdNB8zITrkZ3n6r@linux.gnuweeb.org>
 <20250809144927.eUbR3MXg@linutronix.de>
 <aJdmGwFU6b9zh1BO@linux.gnuweeb.org>
Date: Sat, 09 Aug 2025 17:32:16 +0200
Message-ID: <87wm7ch5of.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ammar Faizi <ammarfaizi2@gnuweeb.org> writes:
> Here's the result after reverting those two commits and applied the diff.
>
>   https://gist.github.com/ammarfaizi2/03c7a9c0fec2a11f206931f1b7790709#file-dmesg_pci_debug_002-txt
>
> Let's see if this one is enough for you to diagnose the problem.

Thanks, I think the problem is clear now. 

The diff I sent you has a mistake, it should be
    if (pci_msix_vec_count(pci_dev) < 0)
not
    if (!pci_msix_vec_count(pci_dev))

So the log is wrong, it printed "MSI-X, looking good...". It should have
printed the other one.

But no need to re-run it, the backtrace is enough.

    MSI-X, looking good... <-------- wrong log
    CPU: 3 UID: 0 PID: 183 Comm: systemd-udevd Not tainted 6.16.0-afh2-dbg-2025-08-09-gb622ab28bcac #13 PREEMPT(full)  28137b57996795286f6544f071ec852674a057d4
    Hardware name: HP HP Laptop 14s-dq2xxx/87FD, BIOS F.21 03/21/2022
    Call Trace:
     <TASK>
    dump_stack_lvl
    vmd_msi_init
    msi_domain_alloc
    irq_domain_alloc_irqs_locked
    __irq_domain_alloc_irqs
    __msi_domain_alloc_irqs
    msi_domain_alloc_irqs_all_locked
    __msi_capability_init
    __pci_enable_msi_range
    pci_alloc_irq_vectors_affinity
    pcie_portdrv_probe

So unlike what VMD doc says, it actually can have non-MSI-X children devices!

Please discard the reverts and the diff I sent you, and try the diff
below. I believe your machine will work now.

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b679c7f28f51..1bd5bf4a6097 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -306,9 +306,6 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent,
 				  struct msi_domain_info *info)
 {
-	if (WARN_ON_ONCE(info->bus_token != DOMAIN_BUS_PCI_DEVICE_MSIX))
-		return false;
-
 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
 

