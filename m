Return-Path: <linux-pci+bounces-39265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12AC06712
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F4C1C0162C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2FD315D4F;
	Fri, 24 Oct 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U5fLunLq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0mNV1hJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE738313539;
	Fri, 24 Oct 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311851; cv=none; b=PAiRAQKYMJTALBFeEUDae72L+k7g00xxoJVToN/+LUiPYwqTZZVsLqy+8o+jAPITbRYWq4zL8oGaMCpzMeFxe/Qb1bq6ycFEejxCYEiweLtSmqYf/tz8hMEbx2i61U27ujbu32ABzqItGtVX4IXy1GDgyqfHfBc81ZflYEEi20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311851; c=relaxed/simple;
	bh=9950Es8hMVNHLG4ReQrAJEeUoGaZLxEyiZEHHF/Uqb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbFGzLoWi9UgvneWlrd8wxKZurYO0aeR8BqmCdt8EeBQba/BBBNykGHxT32UJ8beAq/pBLn5iKwhnEuktKd+btPtmLEkKPm/04ZiBUIssxHN46iK6OjbRz9odeKrExjMvh89YGyBLeTDzqD5oPcjlasl7ndrZ/LXtZq48RSXV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U5fLunLq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a0mNV1hJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 15:17:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761311841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9950Es8hMVNHLG4ReQrAJEeUoGaZLxEyiZEHHF/Uqb8=;
	b=U5fLunLq4QH93yIJjYVQ+Akbhxky7nktgYfQAinsFZQJ0VYQqjjaiRn0h/dFFrsZoSn2jv
	sK+MmUO5jaAGw2cIK+s1agUgi4QlkSnp5wcDMmImTvI9maxL4pm5dSIavAtsfBwNs/DBM2
	PtXSHzHeWGQCDfKMOCwcHz0h0mUSoZNhBDH5adJVvXq+hS2BMFE4pSe4RZ8oEe5Zy4v07k
	A6OdIa+EmNrgjhkcSPbZDM8lngizYWzrBGQh/zwkhpFZnT8zXmSUKyRXVeX0Zn+OKApWtd
	j09RXK+r5nWOsDtqssikKm2xgbA0jeTEPHZE6NuM8XpInJ0JNdLdIVwf1pClHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761311841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9950Es8hMVNHLG4ReQrAJEeUoGaZLxEyiZEHHF/Uqb8=;
	b=a0mNV1hJeObjNVbMWJ8g2rKJ1qgpUD0BIZFk0wMxSwZ5Ce2NvxOvCE3Nvs/zp82VXm2QtW
	Yt2kt8ZiPEu2jkCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to
 raw_spinlock_t
Message-ID: <20251024131719.tJRyYGcD@linutronix.de>
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
 <20251010071555.u4ubYPid@linutronix.de>
 <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>

On 2025-10-11 01:18:05 [+0800], Guangbo Cui wrote:
> I will drop the lock in aer_inject_exit, and update commit msg.

Was here a follow-up?

Sebastian

