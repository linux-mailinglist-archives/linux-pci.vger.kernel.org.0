Return-Path: <linux-pci+bounces-33553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11818B1D963
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FA23B125D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761A25C6F1;
	Thu,  7 Aug 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqn3JFfy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NtGICAEa"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AC204583;
	Thu,  7 Aug 2025 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574710; cv=none; b=PZGFzyoRqK3ui62JGhooA/W2qxdxsydnEnY2CZw0y/4JBrRuiwmbl5ppQYXIFlnKCZrDxm/T14HDH+PQLT6pcPNTwyRagPP5E+O7xbVDqLDG+03ZGUofq8TGf4xkurfCDiUIJ/HAZVLWEDk/jUL2N/vvnefDwqSbZL5MfX02Pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574710; c=relaxed/simple;
	bh=y3VzKTMUGFiW5PV0B3iKiu/OyKnAIeeqfp3JI7yPsbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TqSJD5mWEJwZhjw0lLYH/6NsPEQXk/JBeawNmLuKHwS6NmMjxkT2kC3p/VKJLw3DdI8tGcgwKEFbEeTIhafdTaAUVC6cPNViZ5eHb4FQQI7i3w2NDq1xawV3GboGY1b5Mw9QAusJ0Q8iemQm4dh34DzMBGIXjY0bqj6DtAW5hK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oqn3JFfy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NtGICAEa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754574706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3VzKTMUGFiW5PV0B3iKiu/OyKnAIeeqfp3JI7yPsbI=;
	b=oqn3JFfyPJDvhf/TnypbHmtjESmHniRx/Q20iKQz2p5o2upV0E1df2KxpvsgPsDJ4fPodA
	RM1rrPBJ02K6GFC5hzdA7ylMFmLqoMAJ8MqEcjbJH2vGQG/7n1gazvho3RGIgn6i6sahuw
	NyPJE5ZqOKWluD2Kh+78MQe6ercawedT5NqP0QsvJAlBJ/wjmdHo2LlNWv8DkaReceFQ+C
	2iFam7vVhv9fZsKpvyc2CI5vOV/Zi7xEGN9AdhAqS8I2vMyM8Jw7b+UVZji639MRH3MECG
	kZ53SoG9EIneIhGUuQqR+9oZtyLInOMAKmj1UqDjU/e4Q/XAzjZJaclS12zTqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754574706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3VzKTMUGFiW5PV0B3iKiu/OyKnAIeeqfp3JI7yPsbI=;
	b=NtGICAEaJkxu5muI/pM5/D7BpYBu5NJ+VOverd5t4xW3EyN2ewjAFuVbEqs4J+/Kjzq7sg
	YqZVAgpGSlV1aoBA==
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
Subject: Re: [PATCH v2] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
In-Reply-To: <20250807081051.2253962-1-namcao@linutronix.de>
References: <20250807081051.2253962-1-namcao@linutronix.de>
Date: Thu, 07 Aug 2025 15:51:45 +0200
Message-ID: <877bzfck9a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 10:10, Nam Cao wrote:
> vmd_msi_alloc() allocates struct vmd_irq and stashes it into
> irq_data->chip_data associated with the VMD's interrupt domain.
> vmd_msi_free() extracts the pointer by calling irq_get_chip_data() and
> frees it.
>
> irq_get_chip_data() returns the chip_data associated with the top interrupt
> domain. This worked in the past, because VMD's interrupt domain was the top
> domain.
>
> But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
> msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
> VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
> now returns the chip_data at the MSI devices' interrupt domains. It is
> therefore broken for vmd_msi_free() to kfree() this chip_data.
>
> Fix this issue, correctly extract the chip_data associated with the VMD's
> interrupt domain.
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

