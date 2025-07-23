Return-Path: <linux-pci+bounces-32834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE24B0F7F3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962E33BB320
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6BD1F4631;
	Wed, 23 Jul 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="T2E10tDI"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17E1F09A3;
	Wed, 23 Jul 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287532; cv=pass; b=cms7bldysP+X05C9me6PwiGAy3Z8EEOXQ8YTkZUCP0GWMMSfobwmVJnq/CVWHlXpUmv6YAs9UAqppkP/il5dLq7wLv/FyliuP6ERM4z+nwlfASzB9S/z9DtwGLJZUmdLWsRctWm+dFeefjE0dnFw4/hjbxRkOzUQ3NZbXSqQv1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287532; c=relaxed/simple;
	bh=GpgaHGuL9/lgN3fsicCJtBglgpUO4R3qWc++ipCfKVM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q4RfBmMv4fi+oqzHhGbrRTFYfaGwyfV6Jz+fMHv95DB0pHi5VUp950iq/dFwbrc1Jm2Zu0NpDhjCluspVjilMgeDGBUOepiS2uADwD3uFY1dsBIzKx58mqOHLi2aVwcuWeE6+/nU91rlPVdWN01ZC1LWbZxOaw6rQ+ofN8YlUR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=T2E10tDI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753287511; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mh0yFvKWLMnYppdXHHVWXjCJMmpLVIY+AfApUHty4HELwiT29j5FF5gFD+uLt5Le3Mq12+XfErNswKp4zYxNDZW1Vt8+nC3fkLJ5znFfPJ9lRQ+03UHfx0BjdMqysZOm5VdXSOgKqiIda+mTSxIQzgHMZQpaPyECnRqCwHI3NMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753287511; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GpgaHGuL9/lgN3fsicCJtBglgpUO4R3qWc++ipCfKVM=; 
	b=SKL/tcdrXmoCglNFkD5KlZu8uv7VeSJSzcsmsJaLDaP9bhEMOnuNpibY/5JxML7zZAyWps5pER4AO308FwEU3+D4AkLz+kNJBxY52RgsQWcNiG+z8cO9WxSHXDYyMU7bnWZFx/F5j2PdQqW5iquSsNFEegd8tXmTg5RYMO2yGoU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753287511;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=GpgaHGuL9/lgN3fsicCJtBglgpUO4R3qWc++ipCfKVM=;
	b=T2E10tDIC1NMh79SjDyrt5pcf2/bdHBLOqsypZsRDKGvx/TheAbC5KpcPnZuDBMN
	u5UVKszEjgDw4QzZk5OPYxSUg6uYHmStTNS69sS8OUtt5c8m8A8TrSRJaZmtaGD+E5J
	6H0I9M0S9AJbJjEDBZrB85MofsR/zJh0mWjtOhQc=
Received: by mx.zohomail.com with SMTPS id 1753287507515824.963469037537;
	Wed, 23 Jul 2025 09:18:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBJKEPR28MY1.1ISG6JYV3ZJK7@kernel.org>
Date: Wed, 23 Jul 2025 13:18:11 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FA40D95-4FB4-4E71-8FDA-3DEC3A7FF0A5@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
 <aIDxFoQV_fRLjt3h@tardis-2.local>
 <95A7ACD9-8D0D-41FB-A0C0-691B699CBA17@collabora.com>
 <aIEE4Tt7xtaX-9V9@tardis-2.local>
 <CF821F27-7F78-4B3E-AF62-887341EAA7BE@collabora.com>
 <DBJKEPR28MY1.1ISG6JYV3ZJK7@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 23 Jul 2025, at 13:11, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Wed Jul 23, 2025 at 6:07 PM CEST, Daniel Almeida wrote:
>> On top of that, we can use the
>> words "interior mutability" somewhere in the example as well to make =
it even
>> clearer.
>=20
> You *can* have this example and I encourage it, I think it is =
valuable. You can
> have spinlock or mutex for this purpose in threaded handler, no?

Right, but then what goes in the hard-irq part for ThreadedHandler? I =
guess we
can leave that one blank then and only touch the data from the threaded =
part.

If that=E2=80=99s the case, then I think it can work too.

=E2=80=94 Daniel=20=

