Return-Path: <linux-pci+bounces-33728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A74AB208F3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E4518A3689
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3DC221277;
	Mon, 11 Aug 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="EXiQUWyY"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112662D3A83;
	Mon, 11 Aug 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915901; cv=pass; b=oIX6Hboto15hG2Avt6wOGBcZw05USyft4tcHdosUJNb0GjMX54HiTG7UlK/rXNb5KUDfEKeY2PR2Oi6ifrE6oy3DKyxodaEUW66tYc4Cw0nny4sto1KAokg2i3VnN3S+N4n7VdfXbNjVmc6xXCAyjqJtmrENN5clCC5Pe9WqN1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915901; c=relaxed/simple;
	bh=NFbMZQad2B+B3Dr1/R/+HFea9OlYoyRt+gHpZZeusOA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ukktIRzFgE4wD1IaJJd2xb9CevwDP3/FUGTPhyRnPaxXVAMqo04Byivu9kqDu9FzmiruUtkkFXTJSEfDRtTUt/cX6XAUyBBzrsWFAvGjstnaGXX0TG4fSTyg2Z8pfgSM8amiWhEcBgNxO+ENWD/NF94YuALEKtTbRMyG80+XhOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=EXiQUWyY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754915875; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IzY73z6r4ssJL8TFUMNyJ4BPI12C+9QJOnhAYcvwGDUp5mNucGIevzhvJg7GUzX7zBh8Dwep/VhLZK0D4TKK6ihMqIutc4H8tkuQ/7kPWArRvYMV9hkvYLhakzSL7glFpwxgaKVHE01Xftnrzm/fkV2ReyqQ/iCwYYLstM0lpV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754915875; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NFbMZQad2B+B3Dr1/R/+HFea9OlYoyRt+gHpZZeusOA=; 
	b=dQs2yZrKeDB4o6DZT6ddsBA7cPzsCsGsrOP2PBRHyf1VDl/g5eyAoySlgesdOM5KmRVtaTK3rPo5Cwzq83G0Ao4+a8WwKa1Xy86eU/E9B4fRbCwOh9odUSbd97X46XBXVORQ1h5eMJiYAO02jg0+UWFmtqIh25PlxQGeougOPt8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754915875;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=NFbMZQad2B+B3Dr1/R/+HFea9OlYoyRt+gHpZZeusOA=;
	b=EXiQUWyYFbqLgGeZfn3sbOk4F3sJ5VOTV0Lj8gGT4fEORBibVj+OGH0Rp9XFt+TR
	2zXr4zN8zfPhwDjD0CijBr7E6apTwNyGEvhDQ+lUDx5Upgo/AuD+S9w3qFS0tn7dcXC
	qbj6g+Xj3yyJgMrHmOw41PcRUZgpqN3jUQnsnPGM=
Received: by mx.zohomail.com with SMTPS id 1754915873419805.6256233376367;
	Mon, 11 Aug 2025 05:37:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v8 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLghV0aVZBBEmjf9CF9gFyG08dH7nFzKHnHM6RiANuSZaMw@mail.gmail.com>
Date: Mon, 11 Aug 2025 09:37:36 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
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
Message-Id: <AF48133C-BD57-4EEF-8E4A-ABEECB8A5C49@collabora.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
 <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
 <aJnM1LgUYjTloVwV@google.com>
 <4EE6F260-5AC9-47AD-9F34-0D6C224A8559@collabora.com>
 <CAH5fLghV0aVZBBEmjf9CF9gFyG08dH7nFzKHnHM6RiANuSZaMw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External


>> Also, I was getting tons of =E2=80=9Cunreachable_pub=E2=80=9D =
warnings
>> otherwise, FYI.
>=20
> If you got unreachable_pub warnings, then you are missing re-exports.
>=20
> Alice

The re-exports are as-is in the current patch, did I miss anything? =
Because I
don=E2=80=99t think so.

In particular, should the irq module itself be private?=20



