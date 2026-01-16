Return-Path: <linux-pci+bounces-45047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26240D31C14
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D04F3006983
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C63025783A;
	Fri, 16 Jan 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNRx9eIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621925A655;
	Fri, 16 Jan 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569802; cv=none; b=qipVS+OJEY0q85piad0Uf+c4qbyHkZ6KYkynUfJ+yWZppTanOoKqrj4nKxib7521Wmy23CVMXbCqZ0jwUSxCw8/jCqQkXqnMkkDKC/WTKw8IG9vkNzyKrAE1KZHtNdgWZvmotsdLvXm/WNrnzhoRkj4tGzIyrSFHSPRrdzCdDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569802; c=relaxed/simple;
	bh=WIiyV233cxPXH/AULzFgkZOCAmADaTTIQl8AfEzSeEQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HaEd5VApooNVuY4bIZ7sgac09LBzNrQNYosSnHFQY8+A1EsQsDZgQEBm/mCAxHtQBpl4e7weg4ZT8AA4zHSSc++u4xbmu+pfMqR6O4w9CYFBPqGYLEhjxUVuSa5Rk3Ua3PTNCSPmSCjjpoZ/LCmDUpS5oMscbiPmWbuUpu7LBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNRx9eIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B273FC116C6;
	Fri, 16 Jan 2026 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768569800;
	bh=WIiyV233cxPXH/AULzFgkZOCAmADaTTIQl8AfEzSeEQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fNRx9eIP/rBOXYBa2IPvuKveoBGsy3MFos1NH+PbIwR7IOm9RcOOBavI5xqn+cZQV
	 6AXwGWNYJaNGEL7viyO7Lh+wBMYM6C4x8pCxG/FsizYkwl9jDOcRrwNl9okv+S5N49
	 M+L1lB7VzLVO81Wcts9Hp55vtjbxJFwovW3U8F1vgPDSnWbfMwyUi9zOExayiOk+hm
	 lRzTSdal96rgOqvc2HQLAVXfMKlghX/rNSA3ss0HmYg+XnNdulpptJWEsjEbmG7LY2
	 lF/PFl+LnSh2vWIthW67AN2s4TTl+jv9HopjQD//lSecSHpGPwNk0ImN4TgFcGNJna
	 6xXAL5tEWV4rA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 14:23:12 +0100
Message-Id: <DFQ1O2M9YEDC.3HOIZKNM4HDVF@kernel.org>
Subject: Re: [PATCH v9 2/5] rust: io: factor common I/O helpers into Io
 trait
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260115212657.399231-1-zhiw@nvidia.com>
 <20260115212657.399231-3-zhiw@nvidia.com> <aWoWntMxyhBc9Unx@google.com>
In-Reply-To: <aWoWntMxyhBc9Unx@google.com>

On Fri Jan 16, 2026 at 11:44 AM CET, Alice Ryhl wrote:
> On Thu, Jan 15, 2026 at 11:26:46PM +0200, Zhi Wang wrote:
>> +pub trait IoBase {
>> +pub trait IoKnownSize: IoBase {
>> +pub trait Io: IoBase {
>> +pub trait IoKnownSize64: IoKnownSize {
>> +pub trait Io64: Io {
>
> The following combinations are possible:
>
> 1. IoBase
> 2. IoBase + Io
> 3. IoBase + IoKnownSize
> 4. IoBase + Io + IoKnownSize
> 5. IoBase + Io + Io64
> 6. IoBase + Io + Io64 + IoKnownSize
> 7. IoBase + IoKnownSize + IoKnownSize64
> 8. IoBase + Io + IoKnownSize + IoKnownSize64
> 9. IoBase + Io + IoKnownSize + Io64 + IoKnownSize64
>
> I'm not sure all of them make sense. I can't see a scenario where I
> would pick 1, 3, 6, 7, or 8.

I think for the PCI configuration space backend we can get away with 3
(which implies that the others have to exist as well).

However - and I think I already mentioned this in previous reply a while ag=
o - I
am not insisting to make this split for this reason, as it is an exception
rather than the rule.

However, note that the only really odd one is 1. All other ones could exist=
 when
there is simply no user for certain accessors, i.e. they would be dead code=
.

Having that said, I think both have rather minor advantages and disadvantes=
, so
I'm fine with either. If you feel strongly about this, let's go with your
proposal below.

> How about this trait hierachy? I believe I suggested something along
> these lines before.
>
> pub trait Io {
> pub trait Io64: Io {
> pub trait IoKnownSize: Io {
>
> With these traits, these scenarios are possible:
>
> 1. Io
> 2. Io + Io64
> 3. Io + IoKnownSize
> 4. Io + Io64 + IoKnownSize
>
> which seems to be the actual set of cases we care about.
>
> Note that IoKnownSize can have methods that only apply when Io64 is
> implemented:
>
> trait IoKnownSize: Io {
>     /// Infallible 8-bit read with compile-time bounds check.
>     fn read8(&self, offset: usize) -> u8;
>
>     /// Infallible 64-bit read with compile-time bounds check.
>     fn read64(&self, offset: usize) -> u64
>     where
>     	Self: Io64;
> }
>
> Alice


