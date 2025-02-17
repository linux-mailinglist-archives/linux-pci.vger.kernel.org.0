Return-Path: <linux-pci+bounces-21678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E4FA38E30
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0BB18827A7
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104901A23B8;
	Mon, 17 Feb 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="WgcVy2Bm"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332A1A0BFD;
	Mon, 17 Feb 2025 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828260; cv=pass; b=gaKxR9PVRM7xP5FaRVljxSB8kVMbbx4l007qTn2jZtW5rm7T3wnQ6sYQIxQknBnup+vlGZgYPvG1zWVgSmsFIsy2D/A4ctKgj1rhdWqPxq25qDtKKyKAWKSp5whOEvqqRb8dxCeFr7tvcPlcappCS488cOyNnif2otGwR3sCrcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828260; c=relaxed/simple;
	bh=KXp05alJw/YTiENAYBBHOIMynUt304IeNxlDT2ZiMqs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=on31u1SHIQLgBCkHKTpZqtc8T+lssIBPpHNJAs3nTlgRN2gLTefkiIGy2fRHdihTXUzbEiNQ6f00PckLipXmoSqUz7UD5mWH4mHeFrGD2z1UoQ0E+JgC5mj+lkii/a+qmG7qXZbazkAqzIi2kIgJFf8ipKrLGvSh9Zlhxu+zd5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=WgcVy2Bm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739828232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ds0B8ZRjf6sNlgypv+KRuMxk7XEETpZmht+5Eo8o0JRzdsor52sMkDGse7SPkhs3nKUqi6Ulz7eMe5PHRIR1Q2V+vfLO3d17Z2rQx8AzE2D9LhOBQkHSrEq16J+HByVaOwE13mJX97SrufHdKVUhzZPr0WuW5MXnMTvUd/YojjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739828232; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KXp05alJw/YTiENAYBBHOIMynUt304IeNxlDT2ZiMqs=; 
	b=F0g8jJIHJIYsrsNjVxPiaAVH98O0Ee3XTmr6CO3/FssL7RtlZCrVmimShykuFFJ13HVwrQZKjlelO7a/Zh53zE5PFobUODZuxCw6uUJhiGrnbvuH7MOE8+pUWSB94B60n2tVBb43yoYuKm7W8aS4jLwhXTW60+WnW3SFcVombPk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739828232;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=KXp05alJw/YTiENAYBBHOIMynUt304IeNxlDT2ZiMqs=;
	b=WgcVy2BmFcJH0dRi+48SNcblb7tYVhw9/zwSRIlTE1yr/pBL518XI/E+RN/VfUfP
	j+8njG/8IyRc8G+RU5ac5IwGo20yyE7M06A55kWTs7Rs3e4P5884bh7Z4DcSjD6MfwS
	61Z53+lStTxwxE12nd2Sx8esOR4yHPl0ywAUgLfM=
Received: by mx.zohomail.com with SMTPS id 1739828230560992.1366230961031;
	Mon, 17 Feb 2025 13:37:10 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH] rust: io: rename `io::Io` accessors
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>
Date: Mon, 17 Feb 2025 18:36:52 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2244CEBA-3AF2-4572-B32E-8BA9F86417C9@collabora.com>
References: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>
To: Fiona Behrens <me@kloenk.dev>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Fiona,

> On 17 Feb 2025, at 17:58, Fiona Behrens <me@kloenk.dev> wrote:
>=20
> Rename the I/O accessors provided by `Io` to encode the type as
> number instead of letter. This is in preparation for Port I/O support
> to use a trait for generic accessors.
>=20
> Add a `c_fn` argument to the accessor generation macro to translate
> between rust and C names.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: =
https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/=
PIO.20support/near/499460541
> Signed-off-by: Fiona Behrens <me@kloenk.dev>

IMHO, the `writel` and `readl` nomenclature is extremely widespread, so =
it=E2=80=99s a bit confusing to see this renamed.

On the other hand, I do understand that such a change may be needed for =
ergonomic reasons when introducing
PIO, so I guess we will have to live with it :)

Acked-by: Daniel Almeida <daniel.almeida@collabora.com>=

