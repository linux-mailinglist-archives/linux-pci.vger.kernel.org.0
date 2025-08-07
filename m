Return-Path: <linux-pci+bounces-33534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F74B1D485
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F4C1885E27
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F059231C8D;
	Thu,  7 Aug 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+5kI0uf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W13copfP"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154F4431;
	Thu,  7 Aug 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557335; cv=none; b=pih3Hkc2vLrCf6KgbzNZvz8ZO2TSzT4RkPOk/7jPxjUxHWVsvyK76fPTNU7GZ0uejVlh747bOSYRx+4WBkZj95UHlzUUt1whO9FvhnpE0ERTzMGRsYVKagdu5sSrEaeiSS+Hq5/c/rO6UBaewzeW4nBvLQsczYX6JVEMtnfLCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557335; c=relaxed/simple;
	bh=QBUQi59mULcikjW6YDKMPtF01RPmGuFRMpesIoBMKLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ARZl5x08+hw2heeqsLHn5CDw7LmIdSyY3sEGahi1lagqboyuGDT5wjD4MwkAmnQD/Vk3KsYIfXuEVIkRvyHQlhoWvOeJLxs8KW3D6gWsmp7gpB+0GkmMGhxQxKMuPfQeayiUhZYXrvAAzMgJGVBk8ybW6EEtcSklJ+//Oyc/baQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+5kI0uf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W13copfP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754557331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBUQi59mULcikjW6YDKMPtF01RPmGuFRMpesIoBMKLo=;
	b=D+5kI0ufW2HFn0iQqjkcM48GCwxrDz5bypHeqMk68VNJC+DPWl0MX9lsA8TP6rB70a0FJ0
	HESqRr1oeOTnqz1JHzgs+VblKNylMDF/hAN5trylpWIOa4Us1kIhKEi7Hfz2oyXlEhKThm
	5ciQN1qAUEOl6Zj8iQJ2D7N4pk7BbIEsGe9rMUjvqzhBKbL6M5GRVohenswK9idE5td7JO
	Qv10iKuV8SyeUBqqwhLOEBJ4z/lg2ALrBJjW8y2HWjxHAJguidtymf+U4N/WzkvqojgUGt
	AjHVQjV2w6zGAmI1ycpgvx+SdeT/ndYecmm6mknLLXuaivbgMebV7Ryw1evdGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754557331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBUQi59mULcikjW6YDKMPtF01RPmGuFRMpesIoBMKLo=;
	b=W13copfPQGGuYWBm+AX2OGBOkLnf2UhH8g0vjg5aVER5d/SsRZuga/ZUTpChEG8M45SEru
	Dp7+gPnx46bpEMDQ==
To: Nam Cao <namcao@linutronix.de>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Kenneth Crudup <kenny@panix.com>, Ammar
 Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
In-Reply-To: <20250807063857.2175355-1-namcao@linutronix.de>
References: <20250807063857.2175355-1-namcao@linutronix.de>
Date: Thu, 07 Aug 2025 11:02:10 +0200
Message-ID: <87ectncxnx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 08:38, Nam Cao wrote:

> vmd_msi_alloc() allocates struct vmd_irq and stashes it into
> irq_domain->irq-data->chip_data. vmd_msi_free() extracts the pointer by
> calling irq_get_chip_data() and frees it.
>
> irq_get_chip_data() returns the chip_data of the top interrupt domain. This
> worked in the past, because VMD's interrupt domain was the top domain.
>
> But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
> msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
> VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
> now returns the chip_data of the MSI devices' interrupt domain. It is
> therefore broken for vmd_msi_free() to kfree() this irq_data.
>
> Fix this issue, correctly extract the chip_data of VMD's interrupt domain.
>
> Fixes: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/linux-pci/dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com/
> Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Closes: https://lore.kernel.org/linux-pci/ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org/
> Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

