Return-Path: <linux-pci+bounces-34195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DFAB2A1BC
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFB64E2243
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311913218D1;
	Mon, 18 Aug 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iN0BP3XS"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155A3218A9;
	Mon, 18 Aug 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520663; cv=pass; b=TinFHqZ7CyPTafaqR32As9kp+peCBoj/NSMU4VOkcIQ+miLgAN3/E0sEXuXdUy0RdC3U7LDofNQMZOutPcMX3fX4QrdWw4G53UBjqK2amf+/aGuMvedaH8uEhG49IvZ9nBFX2QAvZBQUf5Z8s2C8h6FvP18pDFIK/uRP5iPBrwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520663; c=relaxed/simple;
	bh=rkp6z7TVKY7PMEz67LeKxscNTqqubl3DaI+stNdUHl8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qzCxmGaK88Icgm3JkawZA37ryFvPcGQ6XYMyeqG344Ob2H+n9sUzyXH+khOKJwH6XAI+hyspAGSydQWr6Eh7wrrbi7XKMsPHDNR89WHXgfGUHJEGkPgGmEcNTv0aGnaXIKDvb928ukHw/F4QpIjMAjCNUqB+ihTekNPbD286ndw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iN0BP3XS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755520619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nc0dOVxblQWfkMMD1dJeSrA++MrL01Tqs6hMI404ZNjeFjnzzE2yHWALxejppkfkCyPKxiYQ2zhPYHhXsoEMCZTYIc7CBl7DMjFwnVwEGPnuJpIX1kuZYuCiKjrAUEHktGlLfOdcqTD8lV2jdD3d5BY152sC9pcRVVK74EI7Aj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755520619; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rkp6z7TVKY7PMEz67LeKxscNTqqubl3DaI+stNdUHl8=; 
	b=BJSXZbf+oZ8lS5Hxy9b6cfzq5lO2H2PwBOzhzdZ6cytwyEhss7ugdWBmuPRbDsKruQgxBO1YFiFJxh69xjGe25x5uVdEQqzOp/T2N0OfeVfQqobrIGrVMOMsDC1vn4ye9vCboi5QlunLqNY3walL3ilh2akX2I/A+WNH3UVudZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755520619;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rkp6z7TVKY7PMEz67LeKxscNTqqubl3DaI+stNdUHl8=;
	b=iN0BP3XSJ4tEOZWR6YKebeHJQcmCEV13dnoD1e+vO59BYp9q4dGoI1VQ8/QZo98d
	QUKofqEZqMt/uN86BIEG6VAXIKMB0LHDCYWzuu//ZJpvHEdvCv8yQBWDNQb47WAl4AW
	+d3xQbivLMptZKkFty2zRWuDeldw+hFHtrtzLbxs=
Received: by mx.zohomail.com with SMTPS id 1755520616688473.89732619527456;
	Mon, 18 Aug 2025 05:36:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v9 3/7] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <87wm71cahd.fsf@t14s.mail-host-address-is-not-set>
Date: Mon, 18 Aug 2025 09:36:38 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Dirk Behme <dirk.behme@de.bosch.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78006490-2576-4A10-9B8F-0AE43AE9030A@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <ZBiGWoEXSxAUvEwNj8vzyDa5L6KvqTuKBTKz3mzyhMGBAja6PJsMtIiSdAUKDmn_FumrmDYuOk4PKlXRW055Qw==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-3-0485dcd9bcbf@collabora.com>
 <87wm71cahd.fsf@t14s.mail-host-address-is-not-set>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Andreas,

> On 18 Aug 2025, at 05:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>=20
>> This patch adds support for non-threaded IRQs and handlers through
>> irq::Registration and the irq::Handler trait.
>>=20
>> Registering an irq is dependent upon having a IrqRequest that was
>> previously allocated by a given device. This will be introduced in
>> subsequent patches.
>>=20
>> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---

This was merged as you noticed in the other thread, but I can of course =
send
new patches to address your comments.

I will get back to you on this soon.

=E2=80=94 Daniel



