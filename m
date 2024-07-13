Return-Path: <linux-pci+bounces-10237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD2930730
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 21:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0221C20F85
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF12E3E4;
	Sat, 13 Jul 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MzsURIn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvThdUVP"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003D18EA1
	for <linux-pci@vger.kernel.org>; Sat, 13 Jul 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720900580; cv=none; b=XO1+EQaOzxQLZNmrIoDjw3XGpsLq53blgCd+N6hySbQRjTfiBtE/1bVffZJ43+CqsZWw5HQ/etzIDzMe7RqPuEWB5r46gKHupR7kM0sNXhEE1U9e5CBkQY/dnfQlGESBgAGJEs/C4gzqEGIsWIfFhHTNFJtoCMZ+ZKoJlG2vat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720900580; c=relaxed/simple;
	bh=9SOKot/cbd9KXL0bnlWbInmQlwuhgdIdhAhWydY6T2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JwH1heOrI8OsdT7z+UuBr3tQ+zVQvaX6QYulYVyIYH4Q0InIaFgfbNOTh2lM2lhYXzYerW+Oadhzh+Vl9mVYzBlBd3gn9pXFnBPnBQC4gkipb80yDNvYFXenOzAsAoH6oUWJE/I8ysPmpeDoRH0v7AAgqeBKdseE8uIfB0TK0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MzsURIn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvThdUVP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720900577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRPdv/ftOLQuVeXznl0lu98TbjXcYSwLjTuncwy+WfI=;
	b=MzsURIn1hxXiP39jY6qaf6Kw64T3nTcB6KjMuZ57f0iUpKpnSlJpCtWXET6zpsPo/b5SB3
	0gt5OtGSr/KYdxMoDw73ULKZMaVsnGAOgDDg8UDBd3czcL2Nr3kzEcLSkrqXizKpy6v6qV
	D5i1g1SiErlYPP2+in9iEwrfw82TeeZVtGe02Uxd7dVvEfcBWMDwxi3NSoqqr7wan3nTKx
	U6/poGJLwFeB+cD/XWY9wYUSY3V+F3ywaiMObzj/bcAMOR9qROixkXrycheVKMAqdL/XwS
	za9oRMbjjgccMB0FebenhbZMf4yCtph63aLrFoc0+hyryx1yOdJTJTk/h3O7qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720900577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRPdv/ftOLQuVeXznl0lu98TbjXcYSwLjTuncwy+WfI=;
	b=YvThdUVPdGiWN25ynNS8ChfwwK3EhshdhosV3nk2ahuT8EybEU1IkiOQe/OIxboDqvtu5Y
	/ZUlAPd032O/HoDg==
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew@lunn.ch>, Gregory
 Clement <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Rob Herring <robh@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Pali
 =?utf-8?Q?Roh=C3=A1r?=
 <pali@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI: mvebu: Dispose INTx IRQs before to removing
 INTx domain
In-Reply-To: <20240713193200.GA374767@bhelgaas>
References: <20240713193200.GA374767@bhelgaas>
Date: Sat, 13 Jul 2024 21:56:16 +0200
Message-ID: <878qy5rrq7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13 2024 at 14:32, Bjorn Helgaas wrote:
> On Sat, Jul 13, 2024 at 12:33:29PM +0200, Thomas Gleixner wrote:
>> > There are 20+ drivers in drivers/pci/controller, and I don't see
>> > irq_dispose_mapping() usage similar to this elsewhere.  Does that mean
>> > most or all of the other drivers have a similar defect?
>> 
>> Right.
>> 
>> But the real question is why is such a mapping not torn down by the
>> entity (device, bridge, whatever) which set it up in the first place?
>
> Marek/Pali, the commit log mentions a crash when unloading.  Do you
> have a pointer to any details?  Maybe there's a driver there that we
> can fix?

Pali already explained it in his reply to me, but for some stupid reason
(my fault hitting reply instead of reply-all) this did not make the list.

Let me replay the discussion:

>>> Pali:
>>> I'm not expert neither. But IIRC it is because endpoint drivers do not
>>> call irq_dispose_mapping at their own for shared IRQs. And this is how
>>> shared PCI INTA-D interrupts are implemented in the kernel. First
>>> endpoint driver (e.g. wifi card) request for shared interrupt and kernel
>>> automatically creates irq mapping if it does not exist. Second endpoint
>>> driver (e.g. second wifi card) request for shared interrupt and kernel
>>> just returns existing mapping. And when the first endpoint driver is
>>> releasing its own irq handler it do not dispose irq mapping because it
>>> may be shared with other endpoint drivers (in this case with second wifi
>>> card). Seems that the owner of these shared mappings is the PCI
>>> controller driver and it has to do dispose them on its own removal (when
>>> releasing the domain for shared PCI IRQs).

>> tglx:
>> Working around this in a particular PCI controller driver is just wrong
>> then. This wants a common cleanup function so all affected drivers which
>> remove the INTX irqdomain can be fixed up without copy & pasta of the
>> very same code. Something like the below and then change the
>> irq_domain_remove() call for the INTX domain to use that function.

There was some additional back and forth but the actual patch which can
be used for both INTX and other, e.g. error reporting, domains is below.

Sorry for taking this offlist unintenitonally.

The background of all this is that initially PCI[e] controllers were not
removable/modular. Later on the whole modularization effort created this
problem.

Thanks,

        tglx
---

--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -278,3 +278,19 @@ int __weak pcibios_alloc_irq(struct pci_
 void __weak pcibios_free_irq(struct pci_dev *dev)
 {
 }
+
+#ifdef CONFIG_IRQDOMAIN
+void pci_remove_irqdomain(struct irqdomain *domain, unsigned int nr_irqs)
+{
+	/*
+	 * Comment explaining the oddity of this.
+	 */
+	for (unsigned int i = 0; j < nr_irqs; i++) {
+		int virq = irq_find_mapping(domain, i);
+
+		if (virq > 0)
+			irq_dispose_mapping(virq);
+	}
+	irq_domain_remove(domain);
+}
+#endif

