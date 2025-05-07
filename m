Return-Path: <linux-pci+bounces-27361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C56AADB24
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 11:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6A91BC5F99
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985BE230BD4;
	Wed,  7 May 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DEItteXU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4WibtGES"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792B230BC7;
	Wed,  7 May 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609086; cv=none; b=QaV8dSVyNnmC0fwxjB036oZK6eKYgOiTvJpjPd5Eke1lrTqlT2p3dL5hQVwdrNcKtc16XepEs+o7M1ABf328kS95Plr5tMFOVDQm4/yjbc+/WWrrhVfCuPGY6WX+Lsdkd4dNMEmfjnMcmArPZopFfi081otb7wlld4k9YFlvF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609086; c=relaxed/simple;
	bh=nTSJhp6z6ny3M8CreO0VHVsuBpUbih2yDdEsE6hB29g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPFDcGhvilM0hH27uyAkOG2nD243TQCEo5dUzPfwx8Xq0gYhxZ7yZuY4OsNQdMl7h9oDBj+ewGmVGFjODtqHKjX8ZwaFNPVZHNWDI/P4jOwD1+bawJPhT0KQRzfc01pBd6sv+u3ajkmqU16ofUyVRj+RQ2c9BwTtDloe9UkT6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DEItteXU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4WibtGES; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746609083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJHUhB3RPPQ57Jx2SVGz3BrGmOM3nFLDXMe7800oHrk=;
	b=DEItteXUj+nLcTLq2a1nkSm0eWY5m+aVKe0kPjWYo6v9suzjTus4QV6PzMm0NaFe7LAKCi
	gdVZNbect+MLchMr6m28JWblsUAwL7Ty+hr+mBvRrn/Pik+z0gU+W0fAiSSY8jkhnnD7vX
	PPbK+ZaqKhNhpbCXk7j2sGN67A4P2zkbk6zDFK4JAsM/5CFZyIE8WSUAgndxYT0o+71SNf
	EpJeNomJgfkIOYPiZ7C+f2/9lRlYcdfk66Hr5cdohxufxJ1QcFqr+LSVTISS3HOn7EdMHl
	Bd7sxsEaWIa7x8yztScSH/1FZDp2eVtz80rgaHv1SeAlqJ3qyIQOp+xOluS/zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746609083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJHUhB3RPPQ57Jx2SVGz3BrGmOM3nFLDXMe7800oHrk=;
	b=4WibtGESCfU8lLSH3SKHAizdtULwyUsO8bihePchRQ7+EfYRD0RN1okCsqGACPS0NDRpQc
	SEjp9jyWqnueXVAg==
To: Lukas Wunner <lukas@wunner.de>, Zijiang Huang <huangzjsmile@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijiang Huang <kerayhuang@tencent.com>, Hao
 Peng <flyingpeng@tencent.com>
Subject: Re: [PATCH] PCI: Using lockless config space accessors based on
 Kconfig option
In-Reply-To: <aBsRXO6Us_wsdhji@wunner.de>
References: <20250507073028.2071852-1-kerayhuang@tencent.com>
 <aBsRXO6Us_wsdhji@wunner.de>
Date: Wed, 07 May 2025 11:11:23 +0200
Message-ID: <87jz6sn5tw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 07 2025 at 09:53, Lukas Wunner wrote:
> On Wed, May 07, 2025 at 03:30:28PM +0800, Zijiang Huang wrote:
> The question is, why did the commit only replace raw_spin_lock()
> with pci_lock_config() in the in-kernel PCI accessors, but not in
> the user space accessors?  Is it safe to replace it there as well?

See comment above pci_cfg_access_lock() ...

