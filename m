Return-Path: <linux-pci+bounces-34627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339CBB32B97
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 21:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BE17A859E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5500421771B;
	Sat, 23 Aug 2025 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vDTMI6sZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8B7GWGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DF2045B5;
	Sat, 23 Aug 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755976103; cv=none; b=nF/lqMX+Vq/GXzK7GQ4/Y7JAZ25rsfimn60yDR4raH9JXflRPwIrmpeCrfcnqoYIKg0tlBVv78AfnUR3eqNLA8QhsbBEWO21+UR+RJzo0blzJTfBTPTP0tODMpl/zp6tyJWkXQwk7DwplEjE5ky4o2htZQlLI2i6/pZMm2M7avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755976103; c=relaxed/simple;
	bh=/ih9xp8+GWSjBPsOke4yn35ChhE5INsEH83qk0Ueztc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jWqOcWfXHxR4JKtXXt62tjvS9yW3MK6qRiDy29i+Ua3uNBAFOxjVVJG3kbm4BH5JZQkwuSLutwddedNv8z8HPV95XUUEntuvWoV7ODhSL2qDUCWjcn7L8uY5KoVX8Fyrqxy67DeZGkJQfX69uKto1VnKx0SPTaf+S7lq3XgIBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vDTMI6sZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g8B7GWGn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755976095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ih9xp8+GWSjBPsOke4yn35ChhE5INsEH83qk0Ueztc=;
	b=vDTMI6sZ9OFcad+BhuH5eYcPICixM70iZdo4oaG3t/EOoC2BGFq+gslleDPxYqJ0Nm/o/v
	9B3WRqvPA7ceR+eMidLie33Y1gz3TfiWWXUsIqxdfR0ecQDBdjfs8DpvK+Ca5ELHp3fpk8
	mH9HcfqCLo1E8SSARz9QFf/ZzS7FdT31Uvm/7CQUV3ZtDEIeL760tDjiw9AVR8RXS+oN/3
	rYbl2quWERGu6uKYyKO1jC6rfoifNFD7bSvnjsYytqzNXCeAriqGGSQP0khcgC7lsHpLI3
	jsBkaha1/CRdmH8RZlxkCY8FMbgWLr0yuRoFYsg5OOZcsC+KKRw6ye+dIawXJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755976095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ih9xp8+GWSjBPsOke4yn35ChhE5INsEH83qk0Ueztc=;
	b=g8B7GWGn6zMsdUw7UT/yq5m8NfSXMpXRn0BR1W+x4TlA+kL3npB92Ssj36N2UulnpvxZKw
	VuchgO5DIM7HfdCQ==
To: Bjorn Helgaas <helgaas@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Jonathan Cameron <Jonathan.Cameron@huwei.com>,
 Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Yixun Lan
 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
In-Reply-To: <20250820205438.GA640534@bhelgaas>
References: <20250820205438.GA640534@bhelgaas>
Date: Sat, 23 Aug 2025 21:08:14 +0200
Message-ID: <87cy8l500x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 20 2025 at 15:54, Bjorn Helgaas wrote:
> On Thu, Aug 14, 2025 at 07:28:32AM +0800, Inochi Amaoto wrote:
>> As the RISC-V PLIC can not apply affinity setting without calling
>> irq_enable(), it will make the interrupt unavailble when using as
>> an underlying IRQ chip for MSI controller.
>
> s/unavailble/unavailable/ (mentioned previously)
>
>> Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
>> MSI-X templates. For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT,
>> these startup and shutdown the parent as well, which allows the
>> irq on the parent chip to be enabled if the irq is not enabled
>> when allocating. This is necessary for the MSI controllers which
>> use PLIC as underlying IRQ chip.
>
> s/irq/IRQ/ a couple times above
>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thomas, I assume you'll merge this series; let me know if not.

I'll pick it up and fixup the wording as I go.

