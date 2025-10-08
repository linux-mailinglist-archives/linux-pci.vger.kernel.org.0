Return-Path: <linux-pci+bounces-37703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16844BC44CF
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C023189C5A7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D062F3632;
	Wed,  8 Oct 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ErJKgup";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IbM0IHWD"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738C217659;
	Wed,  8 Oct 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919076; cv=none; b=OlFTYvTO8k9mp3E1czD0aqlWjAmHZtZs11vMbKmXmD7t3nd1niKWHIL9Na0NJwuZ0NhRSFZ+7wssgR7Wlg8papbPo+tXGFgJh8xDNaAKXCE/2QHbeFkPVjXvKX5qoxXpFyJJZ7GpP8z4A/ZPbOyLDKvEJn866+LHYa59Q6CYMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919076; c=relaxed/simple;
	bh=MF7x00xxPQdn6InVCvhEMv+14jCAin6VCNXzeU6v1Ng=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S2sF1oOiPo0NVX9EggitB3ykY+rHTg6kLb29pK6WfxeWFf16yccsgw/d8XDwDIRsjliUK+Z9gmT2kN7MD/H13KbxQ13qGQZfyll6qenJHq6OaxgaNCAumc4m9oZS64Nwh745HHcLwBeX+akHAjD+ZUH+XJv7BEgDmeNm5/ZL6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ErJKgup; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IbM0IHWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759919073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MF7x00xxPQdn6InVCvhEMv+14jCAin6VCNXzeU6v1Ng=;
	b=4ErJKgupc69BMxcsp0mcl/HjgnfTxnlMpQ9BzH9JhxZogyslBxzkkVaJ0Ff+pvqONlgjiH
	2siPxTrqUw299ZlW5F8ZduiCiqpiADKkgrZGu8OSic03rBcxhnowrdOkbo8hDkl6utbR7W
	zVlHo1GHRktEoIdTgnYlSBzuVhWeQnypSbpyt/ySl0YYgiLQBBNAmvrbnLPjeF5WRAfFsi
	tRrvDE0QHwumFqTMEXfyT6qvQSHclM7UPE+4pplwzccT+4hgbZ5x6qkzqGouXkWpYOBzN3
	qDSe3w+5lQqCAWvR3WMuxhjXzqnhAXtSgIZnIF2q8XDXsALujnyGsjIrX5rDUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759919073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MF7x00xxPQdn6InVCvhEMv+14jCAin6VCNXzeU6v1Ng=;
	b=IbM0IHWDadupNDXAH7Jq2i1T+/Fmd/iJKtFVagcQNs9/bJ3ScBD+Ox6r3WKEUOQVDd1E8L
	bKKTr+BxGrjc9rCA==
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Delete pci_msi_create_irq_domain()
In-Reply-To: <20250721063626.3026756-1-namcao@linutronix.de>
References: <20250721063626.3026756-1-namcao@linutronix.de>
Date: Wed, 08 Oct 2025 12:24:32 +0200
Message-ID: <871pnditcv.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Thomas,

Nam Cao <namcao@linutronix.de> writes:
> pci_msi_create_irq_domain() is unused. Delete it.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> This is the final step in converting to the new MSI interrupt domain setup:
> deleting the old setup.

The last dependencies (powerpc & hyperv) have been merged to 6.18. This
patch can now go in.

Nam

