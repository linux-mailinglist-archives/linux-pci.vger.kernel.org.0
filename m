Return-Path: <linux-pci+bounces-32018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E426B0315B
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD1418986B6
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A855E277C98;
	Sun, 13 Jul 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HxNI347H"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3915746F;
	Sun, 13 Jul 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415850; cv=pass; b=I8N+/Exe7GXaHlA+t66zKgZnPeP/orAS2ZG9F4tvBscv9hdB41Te6v25rEtEjoIju4j1kVtvp3Fb4Hp5PwpeHqI4isPMzV/RbGB7mLu+UhJk5DpNnGKV9uTDbCb5GdilUdi1/Wxsy4pjJ7TTwQ5Z2QBaOEaXhvIbgbTpUr5gRsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415850; c=relaxed/simple;
	bh=KLG6sVwb4CNSPksB+jwSLziTbeDmCF6by7nGtOXUjZA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nrZhJXkCZ0eSbXQLqJ8GcdQWih5981arWypfGeq2SrkM+Te1uH4G2BeNP4+kZrAa8iPn+W8tMhXl9tGpoEHezY0Zf/+4dt94PvHNUHbgAh2xNntxkG+ol4H1KXxn3K8y0hlluxsKU63xv+F2fU7pZs0GENFsQvmbEHzuce3ildU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HxNI347H; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752415805; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vr3i2dDb4LmSogcIKBo0mIRp5l2WuqC3+PH+7hQqE7xuBLLqoUKVYoCKdKtQngpe0xgkJOPoNUfeya3da/2ySsQK53TdRlGWCQfiDyTsdmrRptbu1G9BSr1sYyoqwD+1Ry6Evc/zzmWLu+/DGRK/bMllrhK38PlMDwkf2n0rJ7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752415805; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KLG6sVwb4CNSPksB+jwSLziTbeDmCF6by7nGtOXUjZA=; 
	b=T2WMpFq0Y+Z+A32rumI0mohExhWbsGwUJGYL3k53DCeAo5p4iU38/Tosp5N9LLZcjtzMtMRG/Ms4UiVGboD363DzCiLSbu/joZ/c3Rf+kG/7P0wZQJ7eJxtPpJqQaCDbav94n7JdRdD5UeIgaBUdiwIHhfg59gow3/XwnEy0lq0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752415805;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=KLG6sVwb4CNSPksB+jwSLziTbeDmCF6by7nGtOXUjZA=;
	b=HxNI347HLSdFJx5OLkG/EVUqWf8RNQ2KSwi4vqyOjY1Eba+6155kQJKE5dR29z88
	xuM8iM6Scwa2mA1o9tWbk7W6WpTwvzOFG+jd0AjwOstMCmjk6SQZcN9AZzYqqAmzo0W
	jUBiGDV9m0v8LFVCmf7GZI/AEZ62l3lghi/BYY4A=
Received: by mx.zohomail.com with SMTPS id 1752415803581699.289700032508;
	Sun, 13 Jul 2025 07:10:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
Date: Sun, 13 Jul 2025 11:09:47 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
 <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
 <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

On a second look, I wonder how useful this will be.

 fn handle(&self, dev: &Device<Bound>) -> IrqReturn

Sorry for borrowing this terminology, but here we offer Device<Bound>, =
while I
suspect that most drivers will be looking for the most derived Device =
type
instead. So for drm drivers this will be drm::Device, for example, not =
the base
dev::Device type. I assume that this pattern will hold for other =
subsystems as
well.

Which brings me to my second point: drivers can store an =
ARef<drm::Device> on
the handler itself, and I assume that the same will be possible in other
subsystems.

-- Daniel=

