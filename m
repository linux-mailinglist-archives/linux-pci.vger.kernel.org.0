Return-Path: <linux-pci+bounces-31916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875EB01752
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702027B004F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89104261574;
	Fri, 11 Jul 2025 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzNNTJ5Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578832609D9;
	Fri, 11 Jul 2025 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225078; cv=none; b=IJS5B+gToeyk935Ko7K2joalfepztxawxaYkVBLsQjT7ZZGuiXZyi7p1EHq6qjz3C8QHeq/nKfjhuC+hPL/Zos0hb+H5GHGsGutZ65rcg9F8fo98cYl3IwRra2lm80jw8sWStJOOdKFXAKha6LD23Yn3cc/Iqeg/gIQku7tAgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225078; c=relaxed/simple;
	bh=0nbohhXXJ5N3VvNtfOJEvo9EoQefvFRhKbjpAeYezH4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ANuR3Dc3X82exnrzgkTOIlbwwsUg5O0Zw8yfzQLGyUo8yZoegirLDRWAP/iXNUDcx9VUOYHmSFEgDSAJBj/TaZbHra+iPpbv0qOsBZflJOER71FkDl71e2INHmDjsWKA8uBwNjRPbGv3SRmifOaFg0aM9Kjq2qnSxaRz3WK+Ixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzNNTJ5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D423EC4CEED;
	Fri, 11 Jul 2025 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752225075;
	bh=0nbohhXXJ5N3VvNtfOJEvo9EoQefvFRhKbjpAeYezH4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tzNNTJ5Y6XPI6v0D/HYxdnyjHHMcK4iE4HM0rsI3BsOC+YB5C40zGOLsmQ4cRjsLk
	 pLtDcB7d0VsC1BGDxkeoKg/3f5XME8HXl66unVghLyFVan/90rhptQbURPN3EGTljB
	 Cigp8TjQ1x9d3mIyVFhdfNHXxVv/qXXFNnihyzSgPmNXMBH0DXoiI+b4CAYuxiG3VX
	 Z313gAOeeRL5rKCcUcYAuY7NWyECSn9sV4YWgZcB47j3nTL4Ia9sXY2PCVxsiAheRz
	 kqJgC+Mxqa5OgVoq3UDK96M6bcF76NUeSDkK9s3nkzowv5ayABRJuybkq9HcenQh6y
	 tP0AgCDwEIpdA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 11:11:09 +0200
Message-Id: <DB93Y46GKRRM.P22144H9APXG@kernel.org>
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
Subject: Re: [PATCH v2 1/2] device: rust: rename Device::as_ref() to
 Device::from_raw()
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
 <20250711-device-as-ref-v2-1-1b16ab6402d7@google.com>
In-Reply-To: <20250711-device-as-ref-v2-1-1b16ab6402d7@google.com>

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
>  rust/kernel/auxiliary.rs  | 2 +-
>  rust/kernel/cpu.rs        | 2 +-
>  rust/kernel/device.rs     | 6 +++---
>  rust/kernel/drm/device.rs | 2 +-
>  rust/kernel/faux.rs       | 2 +-
>  rust/kernel/miscdevice.rs | 2 +-
>  rust/kernel/net/phy.rs    | 2 +-
>  rust/kernel/pci.rs        | 2 +-
>  rust/kernel/platform.rs   | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)

