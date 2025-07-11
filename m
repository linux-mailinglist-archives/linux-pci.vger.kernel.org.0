Return-Path: <linux-pci+bounces-31917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA5B01756
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901B23AC195
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDB261574;
	Fri, 11 Jul 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5zHYcJ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F52609D9;
	Fri, 11 Jul 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225100; cv=none; b=DuVw9ZntP/Du3YYsVdyiT6v4ayop5LQodnI7W3wm2cE/xZqzs1da/IbinAkNleCFAi8svirqL/zvfCxPL/0oK5doyfkgiohKUWQ5X6YQ85040slkuQGNUYmyIymY5nIHv5XjhaQ6df0dUB8RHdVQCtovP4PA+2xTkKsY5MZ32F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225100; c=relaxed/simple;
	bh=tudeVcSNoXzHGy2LFEpMNuqRRFSL77J7jE48/SmT3GE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=b/bws/LgZ0fMdtW/aPyvNaUst4Ioigg3ToHcoL3McFTNCjZ6A5V3ANpIR+Dm5vNYR91No+fJ7u503QJtA88wGBWqXYngBnXfcMcJ8IdO5nPXeylLeHZQuy2RZpLGK+Gntnkg3UMJCuFpfBodgfOSzcXAtEihwNjOX0xughoN3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5zHYcJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2042C4CEED;
	Fri, 11 Jul 2025 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752225100;
	bh=tudeVcSNoXzHGy2LFEpMNuqRRFSL77J7jE48/SmT3GE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=t5zHYcJ6NmMa69kELTdf+KaS3dNYHjoWcKpG2Y2O9Gc5IhR2dRmmd8nNw/esLbwrT
	 KqFf2FoMJI5CakGjKAfF+CouVfT0sqaZxzHQAUCKV/4IR3ZObCuXeFLfuSFXzbmVmG
	 Yaj6gKOpcyThw772ug+LAVjyO0eOgm+0N8LrGCrZzSiQLYZRroEt/x3aoEhqpQsO7U
	 7uK53atW8y5q4ul8Wgtiu+4+DEZG64S/CQ2hWPuJNhykFDeFbCrnL6wGSwkXEqKMB4
	 f7H4rSZ1Cvgwn0dyVuoLjCPljpPWIUZhse4jBF9DhfDaHn8cnIc3feIDmyt5bOtJI1
	 hIi0z+skNoajA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 11:11:33 +0200
Message-Id: <DB93YF5EJT58.EVSPYQ3ZJLUU@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Peter Zijlstra"
 <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm: rust: rename as_ref() to from_raw() for drm
 constructors
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
 <20250711-device-as-ref-v2-2-1b16ab6402d7@google.com>
In-Reply-To: <20250711-device-as-ref-v2-2-1b16ab6402d7@google.com>

On Fri Jul 11, 2025 at 10:04 AM CEST, Alice Ryhl wrote:
> The prefix as_* should not be used for a constructor. Constructors
> usually use the prefix from_* instead.
>
> Some prior art in the stdlib: Box::from_raw, CString::from_raw,
> Rc::from_raw, Arc::from_raw, Waker::from_raw, File::from_raw_fd.
>
> There is also prior art in the kernel crate: cpufreq::Policy::from_raw,
> fs::File::from_raw_file, Kuid::from_raw, ARef::from_raw,
> SeqFile::from_raw, VmaNew::from_raw, Io::from_raw.
>
> Link: https://lore.kernel.org/r/aCd8D5IA0RXZvtcv@pollux
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/drm/device.rs  |  2 +-
>  rust/kernel/drm/file.rs    |  8 ++++----
>  rust/kernel/drm/gem/mod.rs | 16 ++++++++--------
>  rust/kernel/drm/ioctl.rs   |  4 ++--
>  4 files changed, 15 insertions(+), 15 deletions(-)

