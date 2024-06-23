Return-Path: <linux-pci+bounces-9160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C806913F0F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 01:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2E61C20F76
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73EC184133;
	Sun, 23 Jun 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2bYLcXwe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8Aoueg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FC175AD;
	Sun, 23 Jun 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719184664; cv=none; b=pI3hISnUREzjpub/TKMGAkiM88HdtE+WNYvuOe6TKCsQ7sk5bCPMf6LVPbZL8pYK9i5xRef0B4mQdjN3bJPfoBMuCTbVxr4zM73vtscC/o62P9mlAlZiJ7r9iTeVcVpka4CM2QvpA/WTHckLS6uOlEJvQUoSIbrD1I6Gv7fwGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719184664; c=relaxed/simple;
	bh=MAaXRs+2g7jJPebEaUqxCCPsFFfzzsr9X61/w4fiT3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IbladWAvmPxqaeA/yPDpXIoAxrFjNipfvCQjL6amNfkwA/iIfD1p3lYihubUjpSxsgQUCofRYQpPECUJzbS2fPmWxOi9UiusPv+0mYzgSeogFqyrP5s4+XMUwjJZyUCVHgS2vhLsl59UMix0KSwyl0ZaTKSyGgNth2r8pk6iODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2bYLcXwe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8Aoueg5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719184661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAaXRs+2g7jJPebEaUqxCCPsFFfzzsr9X61/w4fiT3U=;
	b=2bYLcXweNcbku5gmLG0xsERuO+nUZcSupK6N0btD4m2Hv2XtOKLc7Gx0AUN3KfFO8d1mo6
	dDMfp25ee5kFOBtiMSnYoYA7NeG6bjVjIGimv0XJkaX4I9t3ugj3ugvWiSGXXbRT+2QoGQ
	QFOzmSwxyrH9U0rekcX5/s+QOabDoN1SjxZXclIExk8p9uHhXTzOt2DWxBtcyg+8HUM38v
	iEdlyWpo9frmoupZWCxSRXziyXAGKVnSMiswpC70OaacrUT1vicoL8x4h9cc/w0GTA6Q82
	pmwN9rS1jeNvYWpCzqZV+W+O4/dFc0tD8cI8MwkjMjwf4G67n6YW4QcZZLtMmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719184661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAaXRs+2g7jJPebEaUqxCCPsFFfzzsr9X61/w4fiT3U=;
	b=I8Aoueg5qu9p5ks0JhzYxN/tV5Xd5xy1K33gASb1sRC75Xw8OVW3zAFsPPxcMqGCFrA+VL
	BvLWBir+gZEQ1uBw==
To: Mostafa Saleh <smostafa@google.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 kernel-team@android.com
Subject: Re: [PATCH] PCI/MSI: Fix UAF in msi_capability_init
In-Reply-To: <CAFgf54rFL0rF2KxGP883Vk8APnSgtNnXJYSO_oYsSqnEjf4-ig@mail.gmail.com>
References: <20240429034112.140594-1-smostafa@google.com>
 <87zftbswwo.ffs@tglx> <ZjAuJV87RjOu7gSy@google.com>
 <CAFgf54rFL0rF2KxGP883Vk8APnSgtNnXJYSO_oYsSqnEjf4-ig@mail.gmail.com>
Date: Mon, 24 Jun 2024 01:17:40 +0200
Message-ID: <877cef9rl7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 22 2024 at 19:53, Mostafa Saleh wrote:
> This has been here for a while without fixing, I will respin V2 with
> your proposed changes,
> please let me know if I should add any tag by you.

Suggested-by is fine

