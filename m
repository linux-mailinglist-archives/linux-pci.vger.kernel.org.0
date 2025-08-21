Return-Path: <linux-pci+bounces-34452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93BAB2F5AD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B67A5C89
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7EB3090D3;
	Thu, 21 Aug 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZiMedDg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E13090CC;
	Thu, 21 Aug 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773565; cv=none; b=XGHc9z04xxhsDYuxMbQ044f8uVh3i/oam+oAAscEAUUamPEg7h8YPjPhUZR+OUE09yC9xYSBff5z5DoAz9WCb5GT+PbcrMkFdRCwNRCrAvHRBU9ngfPzFqYb7n04rNrykFV8w4VAKBZf1oO3rPYFsYBxgCj+ZKe6n5PaQ0z5Ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773565; c=relaxed/simple;
	bh=R1V1AwRna/S8N/EhSnIaw17FsINeg5f7DVVQw8h2ON4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kipHYkNHldB3l7r/BHWLIRKJ9/XKEbL/O8pnXOS5Z92Os7tgJlhUoyYgHu1U9XUijaPKE+OPmVGP+Z953LfIoJlWYd+cAgYJSoAqJRv2lziwcn/7xYmPWsPvRDovX5DDASYrDVm5TaRd0TLQM+2LquD1FfXEcJRWbNQnwFPQwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZiMedDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42508C4CEED;
	Thu, 21 Aug 2025 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755773564;
	bh=R1V1AwRna/S8N/EhSnIaw17FsINeg5f7DVVQw8h2ON4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cZiMedDgUMqwW3c+r9YzeXcJDpQqFJYlJ78w2zvhV9OUFIDzp56Gb1oMLnNNJYyz/
	 AhsjENOCWk4xjaeuNqrxJdVNOmuOwmbygmsyKgM1eV3nLDHQg902o4M+KWuLNekYGi
	 K6Avk/aw0OdBeQIGOqjAuqbS0OXHXsCiEWCXsx9l4Dv+IOsKkJW8duuI0PSYdGK2nw
	 E9AFbwyanXElhVNV34z2bpjdcJCh3vcDVfJEcCPCYkh3LgLnDSVb4fxgojqTGrD73v
	 BZ86KcW+d1VwgjHPXCDOGXdvQuK3hwdxrDobRO877jYn9kAe338WWnL1ZoiENoegu2
	 OmJb8j7tECFrg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 12:52:38 +0200
Message-Id: <DC81S5SN8N76.YH4323TLNHJK@kernel.org>
Subject: Re: [PATCH v5 3/4] gpu: nova-core: avoid probing
 non-display/compute PCI functions
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Elle Rhumsaa" <elle@weathered-steel.dev>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821044207.3732-1-jhubbard@nvidia.com>
 <20250821044207.3732-4-jhubbard@nvidia.com>
In-Reply-To: <20250821044207.3732-4-jhubbard@nvidia.com>

On Thu Aug 21, 2025 at 6:42 AM CEST, John Hubbard wrote:
> NovaCore has so far been too imprecise about figuring out if .probe()
> has found a supported PCI PF (Physical Function). By that I mean:
> .probe() sets up BAR0 (which involves a lot of very careful devres and
> Device<Bound> details behind the scenes). And then if it is dealing with
> a non-supported device such as the .1 audio PF on many GPUs, it fails
> out due to an unexpected BAR0 size. We have been fortunate that the BAR0
> sizes are different.
>
> Really, we should be filtering on PCI class ID instead. These days I
> think we can confidently pick out Nova's supported PF's via PCI class
> ID. And if not, then we'll revisit.
>
> The approach here is to filter on "Display VGA" or "Display 3D", which
> is how PCI class IDs express "this is a modern GPU's PF".
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 33 ++++++++++++++++++++++++++++-----
>  rust/kernel/pci.rs              | 21 +++++++++++++++++++++

Can you please split this one up in two patches?

>  2 files changed, 49 insertions(+), 5 deletions(-)

