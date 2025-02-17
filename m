Return-Path: <linux-pci+bounces-21677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3833A38E2B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C271884713
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2501A5BBC;
	Mon, 17 Feb 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk4IZw1F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FE1A0BFD;
	Mon, 17 Feb 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828161; cv=none; b=f3Z7TNXtda9uDYiaVE1j3aQzdgW2EJB5WtpkRt1QK3qk94ziD+CnNS++RY30iZ16qGCeD6++8K63W30RWPNro+uvuZh46MBCyFSgzW+rUu5Ed6rKRNSsGcJ4O/D8tyR5RtOTBo7zwe5kgLwb+wcgGYOPAp31v9mZ01Avcqp/0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828161; c=relaxed/simple;
	bh=nnN0rOuNFY3vbBQ+F9rX4McpaGt4OacgS75CF8D1j0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4zP2e5A+x3ngHRrCH+Qcbh2fLVah2+mwFj0v+Aw6+/ng4pZTZnisVgPMkxsjaKNLx9nheJ22r1YV8bZpNPFUu59oA9UWTVT0F1pIJUhi4Lqg1CDyCiq/ltIJaYOyiiDUSaezy7mlEejDMUCSm+JuaAK8OnOERuSE+0JeBbkseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk4IZw1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B6CC4CED1;
	Mon, 17 Feb 2025 21:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739828160;
	bh=nnN0rOuNFY3vbBQ+F9rX4McpaGt4OacgS75CF8D1j0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pk4IZw1FePzBlsre8TevuShDSEF1q5qWfpPcBVHPP9kPk7YW565RJ8mvm8jZJM/9T
	 Uu2nGb8RkepSvtb1YwwzHkD5DLHyqukGiBYM+8Ei85fH0m2SB0AgWGNSCXbl8C7+u2
	 Hy/phHUF17f2I25iMAbFZBMqFfu8yp6wp0Ph98f0Gc0nLKJ7V5zEUEVwNwzViy6nt0
	 Qadx5km47X5m6caIA0UufxQzYhBVaiV4sYjcqasUeGiHZuu01kIATqNUzUJInSVazS
	 Wm0YyJxC2D0+5xlNo1AgbK5Z6hQDWaBBZFZZhffUzUzzv/gg4OUxTCgRbYqFaicj7z
	 DQ1PiRUafe06w==
Date: Mon, 17 Feb 2025 22:35:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Fiona Behrens <me@kloenk.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: io: rename `io::Io` accessors
Message-ID: <Z7OruhGqbPVs9KUF@pollux>
References: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>

On Mon, Feb 17, 2025 at 09:58:14PM +0100, Fiona Behrens wrote:
> Rename the I/O accessors provided by `Io` to encode the type as
> number instead of letter. This is in preparation for Port I/O support
> to use a trait for generic accessors.
> 
> Add a `c_fn` argument to the accessor generation macro to translate
> between rust and C names.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/PIO.20support/near/499460541
> Signed-off-by: Fiona Behrens <me@kloenk.dev>

Acked-by: Danilo Krummrich <dakr@kernel.org>

