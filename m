Return-Path: <linux-pci+bounces-32847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E2B0FC28
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 23:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5B3AA234C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D7926D4E5;
	Wed, 23 Jul 2025 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHn5KI2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F026D4C7;
	Wed, 23 Jul 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306285; cv=none; b=GtDBOauDR2XhKzOopE4WTlR6qdRT0JHZXf74fAdKl2OkkTAipFkQHUgHsJK9bHhfxIfnGNEYhO9QQ8df1i5XH/i37rWI7zjzZSFqeHfk7n4RQsIqWePAlOdJHshMX/zMsZbKe72Tpn5gX3KVflpfae/zCEDR7DFvQ5I23d+T/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306285; c=relaxed/simple;
	bh=81czxkm0qDpnBXqs6HR9kLuC4cgg4IlWt2hYMO2FQPo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=iOWzEGNou1Ayc2AjQT/UB2gcCwfn6ysknSjkviDM4ZS2fa0iXZ0AoZUrOAjgRP0VmjZ7B6Q5grUQrdSgODyrpZZ58K/B9NywtPtnHCzfa9kxdNy2OMZFgHl9I4Xg9CsocwhfFCne0jI8kDkySHQ9KmcuMiYcr6gcdCW+ry5Lab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHn5KI2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA78C4CEE7;
	Wed, 23 Jul 2025 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753306284;
	bh=81czxkm0qDpnBXqs6HR9kLuC4cgg4IlWt2hYMO2FQPo=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=XHn5KI2aqrE+1SS9jYuEZN/QLcYG4VnklNzlQMrS1UvosuZtZTRM+VK+XOxaThcTd
	 XPQRCiq0729W8s0872wyyDYkITZcevb5keU8ICNdVQ1JvlSJoYeZBZ43GtwN8Ireki
	 HJpZHpJqSfOFJjZDCE4BsRfcHi4k08YJwlhU976GgcdOIoX1TWFaRiUmFzXSCdzRt+
	 Y31VA3du+8WQfDMAR4TpWt9ZGhhsfzAQEn0iUd8PtfOg/mc3axrPCPiGulUwHa5v/q
	 lWG5bc/Mcch+pUF5Imbx7dtNnkUHCX48SwLCbNRUfVl35QclwwwLdRZAsF6qK22Bd8
	 nYaGI2cizcI3Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 23:31:19 +0200
Message-Id: <DBJR7DCAPYJ1.39V7X6LNO3ILC@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com> <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com> <aIBl6JPh4MQq-0gu@tardis-2.local> <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com> <aIDxFoQV_fRLjt3h@tardis-2.local> <95A7ACD9-8D0D-41FB-A0C0-691B699CBA17@collabora.com> <aIEE4Tt7xtaX-9V9@tardis-2.local> <CF821F27-7F78-4B3E-AF62-887341EAA7BE@collabora.com> <DBJKEPR28MY1.1ISG6JYV3ZJK7@kernel.org> <5FA40D95-4FB4-4E71-8FDA-3DEC3A7FF0A5@collabora.com>
In-Reply-To: <5FA40D95-4FB4-4E71-8FDA-3DEC3A7FF0A5@collabora.com>

On Wed Jul 23, 2025 at 6:18 PM CEST, Daniel Almeida wrote:
>> On 23 Jul 2025, at 13:11, Danilo Krummrich <dakr@kernel.org> wrote:
>> On Wed Jul 23, 2025 at 6:07 PM CEST, Daniel Almeida wrote:
>>> On top of that, we can use the
>>> words "interior mutability" somewhere in the example as well to make it=
 even
>>> clearer.
>>=20
>> You *can* have this example and I encourage it, I think it is valuable. =
You can
>> have spinlock or mutex for this purpose in threaded handler, no?
>
> Right, but then what goes in the hard-irq part for ThreadedHandler? I gue=
ss we
> can leave that one blank then and only touch the data from the threaded p=
art.
>
> If that=E2=80=99s the case, then I think it can work too.

For instance, yes. It's a very common pattern to only have the threaded han=
dler
but not the hard irq handler implemented.

IMHO, for ThreadedHandler the hard irq handler should even have a default b=
lank
implementation.

