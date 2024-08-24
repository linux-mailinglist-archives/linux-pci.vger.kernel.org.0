Return-Path: <linux-pci+bounces-12166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7295DFD6
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 21:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219F11C20E0A
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975656B72;
	Sat, 24 Aug 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QUy+ZKmy"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E4B669;
	Sat, 24 Aug 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724528885; cv=pass; b=N40bxynHhMq6ZVzrZwe/qUN7oh5H2Ss0dXNlxZdsvtdfI1E+jfatqA6BL+YVik05QJGzpSQYdBlJ3wCfvxR6VzSkLgR4IYT+/drg4w0w9VWVzAy55ZSp0gAbUkbkfNg2mAyhs3EIc0VXMujy6U1B9hTqyXHIOaHur6QZb1YKKes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724528885; c=relaxed/simple;
	bh=bOkpbfgfSj3qeUT/h8Mgu+vfuZecCK8Ya0ifgmoikLI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bKVLI282E0F2T5lWNjhpJXGPMMnedKEpXEitwYRDK69a3CUDxEfcs383THtx9kj3BYTvlVxdTwg3vdwsJR12ouJnJDnMSBEXfxhmVtu1BWGmcwb2YyDY2mS2Q326CDZ/K5r+x5wS5mHA5zPH7w1V1B0ZBHUTedUoL/YWj6so0lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QUy+ZKmy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724528847; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ikylJpY+oSH2VYCO7wbK6Q9LefQuA2nYPoBxKYGTSEj8ui1OI0nqi9tLfEGkfc42GhkISqwmmxSTvCRuUtrl4j95rHzVx/TvyRnFhZuZF4GLiYe6qEex5lcUHDBIUUyV+//X3WQJ5JeEq4MgLIBnCK84FtZO19C9W3CJ0e8di98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724528847; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bOkpbfgfSj3qeUT/h8Mgu+vfuZecCK8Ya0ifgmoikLI=; 
	b=ehAw0SXf5mdzmm3+4IkHT1hNsiyvsCbav7nmU5l30jHKNTRXJbiJsFe2H2FzJU1QumBAPtVANzuylT+UToYqR0jN8PnS80Xo6P/n+rFqS22Q3Wyi3exPEkgd+ca9Tqw8iDwLk4Xe1rSnrxbBLzr710OLR+b5q1kZufs77hfzpZs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724528847;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bOkpbfgfSj3qeUT/h8Mgu+vfuZecCK8Ya0ifgmoikLI=;
	b=QUy+ZKmyo2983l9HZk/FVBzgXgKs3GxCjo8pjHW8wBOS6ve0Lyl3NOqWHlj/7Kvf
	JZZv7qm5BboRxnXcJwPki6uv+N6ehdbyIvXq1wlHYMb5nmvDFdx++NdaBLhw0koFpTU
	AQPPIC4It1DrylfGWq3duUh/Trs8xwm3Ep1zrnTQ=
Received: by mx.zohomail.com with SMTPS id 1724528845223809.8339247569138;
	Sat, 24 Aug 2024 12:47:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 07/10] rust: add `io::Io` base type
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240618234025.15036-8-dakr@redhat.com>
Date: Sat, 24 Aug 2024 16:47:07 -0300
Cc: Greg KH <gregkh@linuxfoundation.org>,
 rafael@kernel.org,
 bhelgaas@google.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Asahi Lina <lina@asahilina.net>,
 Philipp Stanner <pstanner@redhat.com>,
 ajanulgu@redhat.com,
 Lyude Paul <lyude@redhat.com>,
 Rob Herring <robh@kernel.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF9E76A0-C62A-4A73-973A-8FB1CB8CF8ED@collabora.com>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-8-dakr@redhat.com>
To: Danilo Krummrich <dakr@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-ZohoMailClient: External

Hi Danilo,

=46rom a Rust API point of view, this looks good to me.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Cheers,

=E2=80=94 Daniel=

