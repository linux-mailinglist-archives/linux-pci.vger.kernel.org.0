Return-Path: <linux-pci+bounces-38450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C1BE835D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1F118984E4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775F32F766;
	Fri, 17 Oct 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hciA4sIr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AFC32F762;
	Fri, 17 Oct 2025 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698914; cv=none; b=ApXhE55fPn++MWVcQ0lZJRyWKOsKi/gadjhskLwoh5zg/M9f0fZx6q/uF4flyBSRzqKyybaiHE4s0793jcOITzQgHHG8WIbkaQ5AKOw/J/yUtKM4Tm/O4f7tb6AIWy2qTsIE70a+3A57BuxsnUXBO06tmIeju83VycEfGV2aN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698914; c=relaxed/simple;
	bh=RmzPIFaRdsrQ+NAnOXzWCQH/A77thF0b/z6YP9rVT6Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=cfsWp2rID/aycnisHhe88NHvtP/oZ1HNUU+YQOqRcXD0c1+veRLbAR8JPtnGmrWoiGqPEYvr3Xta4RP77GEAEsWrjrTGe796Rfw5wuI4VnhpWks3jznzYPreFVo2xMaAXv+gzBovG0SGwEJ13J7u8konmIdk8pbvzjTll6ND6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hciA4sIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA854C4CEE7;
	Fri, 17 Oct 2025 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760698913;
	bh=RmzPIFaRdsrQ+NAnOXzWCQH/A77thF0b/z6YP9rVT6Q=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=hciA4sIrSqbIPYWwoz9zZmJzqGzlo67hqlZi2e6yl8yf+VLDHudVpvXiQ8UauAikG
	 Ls0rMcbUfPlvusFqHHpw0fYbI4DG95KQX4XmnS311ORfsHiLZuPU+r7Q2zTqJhKDJr
	 kG+xa1v9AllIoQ/W4DTukOz46XpkiRRAxEnGXHhOcpdp5Q/mjCnu8CQmFk0ZVEx8P1
	 znbwZczr3JT8GW0Lr58Jg5hZ6rXEcifmFTyQnKOrCYyTykVTzwGlfzq+RMRJ/0IRbB
	 RNjsTnZz7u0MYot6Rj8fteW7dvyN2EKBb6juIybyLO4Xm5epwB3W8oUtgRr9zNvCj6
	 xiRaXmwu/OF5w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 13:01:46 +0200
Message-Id: <DDKJO7HME02Z.2HXY61JBM3GZN@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: io: factor out MMIO read/write macros
References: <20251016210250.15932-1-zhiw@nvidia.com>
 <20251016210250.15932-3-zhiw@nvidia.com>
In-Reply-To: <20251016210250.15932-3-zhiw@nvidia.com>

On Thu Oct 16, 2025 at 11:02 PM CEST, Zhi Wang wrote:
> @@ -122,10 +139,9 @@ macro_rules! define_read {
>          $(#[$attr])*
>          #[inline]
>          pub fn $name(&self, offset: usize) -> $type_name {
> -            let addr =3D self.io_addr_assert::<$type_name>(offset);
> +            let _addr =3D self.io_addr_assert::<$type_name>(offset);
> =20
> -            // SAFETY: By the type invariant `addr` is a valid address f=
or MMIO operations.
> -            unsafe { bindings::$c_fn(addr as *const c_void) }
> +            $call_macro!($c_fn, self, offset, $type_name, _addr).unwrap_=
or(!0)

This introduces unnecessary CPU cycles in the infallible case, I think the
implementations of the try and non-try variants should remain separate.

