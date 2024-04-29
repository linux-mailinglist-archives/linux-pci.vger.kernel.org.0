Return-Path: <linux-pci+bounces-6810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D58B6453
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D841C22042
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B69178CC4;
	Mon, 29 Apr 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fc5TQjoQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qKZlLs+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99A178CC5;
	Mon, 29 Apr 2024 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424685; cv=none; b=cWq0VMhQ5Oo00tcQKlo2PsMUtvE1URnDYUbJJOFDUbWimHX+DXftCRTgf0qPGJsoU7ewQJt4/7z4inNlHooUjhcGA3MmI0+PGB0pVWbBbFL+2LgJr2cGubzyrmlTlVakonUtAtT+fjNKv9eRmr2uYFK6UDsx1OsxeIHoKwtCECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424685; c=relaxed/simple;
	bh=RJU+rqzbC2GGAl4tdD5o6ueZMzfbxZmF8XAZfOL96T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPx6dvO7PNH57uqxNWBNe7aSlSchD5YsKctGn3gEKKH0p+n//85xENIZpXETJnVWdwSOF0bovqHXvmgmohG4E4VFKl8+lbZQb28C3f1YbxQ5pgA2tbcs+1UDEPHsnKTgpipxaQE3Te55p7mgWPCQagPnz7ln3ZY0qGvB3HPuIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fc5TQjoQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qKZlLs+g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714424681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTxwFLVccxj2TMlIRUP97VQiicQibR0IBgIQhq6q02k=;
	b=Fc5TQjoQViZhw1EV1ApD2hD4We9rVGUJ+kTDcHsZrBT2bAPodN3X7vJ7jpMPon2JFfznkx
	KyftyqF46wOw4kjWPxu3BbeP99YKx7xSySTJ3iSuanmUZSQHIoVnKZVPJS8snSkJujCcrx
	sX/74UYcXZacHk+V2S0s6jrchU3ecfh4mgO3MPktzpD6d64HyaAVRD2cqdVG1rSoC+LBTb
	YMvaBFWTMQIWia1idgTNzIYRoTBBjF1/H1bncgQw4/UOog9GQbAbhHEKOniphP4V5IPJHY
	Yk26lbR0/JvzmOb86lWAnV5YPSyh8Nk7k2BiTe8baP4cK1ptG18MWbcL6Yxc0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714424681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTxwFLVccxj2TMlIRUP97VQiicQibR0IBgIQhq6q02k=;
	b=qKZlLs+gbIvDn89xz6XtsUzOqd4E7crbcHbGIgxjLJjbG0KLGY3sJcLJsDvpNcMwpImEqm
	P2ZKjBiz6L0vZpDQ==
To: Mostafa Saleh <smostafa@google.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com, kernel-team@android.com, Mostafa Saleh
 <smostafa@google.com>
Subject: Re: [PATCH] PCI/MSI: Fix UAF in msi_capability_init
In-Reply-To: <20240429034112.140594-1-smostafa@google.com>
References: <20240429034112.140594-1-smostafa@google.com>
Date: Mon, 29 Apr 2024 23:04:39 +0200
Message-ID: <87zftbswwo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 29 2024 at 03:41, Mostafa Saleh wrote:
>  err:
> -	pci_msi_unmask(entry, msi_multi_mask(entry));
> +	/* Re-read the descriptor as it might have been freed */
> +	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
> +	if (entry)
> +		pci_msi_unmask(entry, msi_multi_mask(entry));

What unmasks the entry in the NULL case?

The mask has to be undone. So you need something like the uncompiled
below.

Thanks,

        tglx
---

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -349,7 +349,7 @@ static int msi_capability_init(struct pc
 			       struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
-	struct msi_desc *entry;
+	struct msi_desc *entry, desc;
 	int ret;
 
 	/* Reject multi-MSI early on irq domain enabled architectures */
@@ -374,6 +374,12 @@ static int msi_capability_init(struct pc
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
 	pci_msi_mask(entry, msi_multi_mask(entry));
+	/*
+	 * Copy the MSI descriptor for the error path because
+	 * pci_msi_setup_msi_irqs() will free it for the hierarchical
+	 * interrupt domain case.
+	 */
+	memcpy(&desc, entry, sizeof(desc));
 
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
@@ -393,7 +399,7 @@ static int msi_capability_init(struct pc
 	goto unlock;
 
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled = 0;

