Return-Path: <linux-pci+bounces-38452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D09BE8417
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A40C1A64F09
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D53321B0;
	Fri, 17 Oct 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVYgzf7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24933322523;
	Fri, 17 Oct 2025 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699393; cv=none; b=DjzFma0S4p02HnT1lLoZC44l34fcg8eAOezJcJx2WelG9oJbz0QBazdKxdCMbjKoXRhSrQZuqZLvsm91d2wSeNmGE3Ax9mxvZRWobuT2B7EQX2Fx2waGr2HohQ0PWxMDBg49nHwN6/t5wRwobSMEyVuRch47jU8GLNMtzfsBfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699393; c=relaxed/simple;
	bh=B+EuQS2MVzxcLVb34Ndtuh1lzX9fiI4+iBqedQ60U8o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qHBhZ7pRwHYqQE5H9IoHJqh/Ubvx1AKj6zv7QRRhkq9KJ/RQi77piY1OkNcF6/wOjO8/K9LeSSft6qXVJTrgjSv8LcpQM0Xkc6yeC55ZGLCtOeliTox4NErujXtEyZMeknydH9LXcFjnvf7Hvvhj0Z1KpUUPPG9xyPr3sOt9RZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVYgzf7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF333C4CEE7;
	Fri, 17 Oct 2025 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760699392;
	bh=B+EuQS2MVzxcLVb34Ndtuh1lzX9fiI4+iBqedQ60U8o=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=AVYgzf7mflp06nhE6PBC3Ecf5DK6RVQzPAzk5eoFDKXxKpf+rZU+1Lb4ALl5ef3mx
	 xK2mdBZyaolA095jlRNuvzyNnEd/XrA1kx+FGLQduK8BKgt3OhyRvLXLDwngl2f8/U
	 UuTklmlFUMI+zRd9L7bfSphZ6uDQ9RZzEkd4cfK4VpRA+DkXwH23LBMeUwLi61Hs/5
	 AF5Zcc4ln/HB0gJF59ItgCcOXxYb9LmplNFgK94OXwfzbXPO+rX79mlS4lfGJknjgS
	 wR3a7xcszk0oGyc3kRVMXQfEnBQPNEX02IULTXe/1m7vQY8w2iAGyDq5PJAbxlXt/f
	 7ulRXw0OXfqqQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 13:09:46 +0200
Message-Id: <DDKJUBOP0MTE.1ZMM4KXC64447@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 3/5] rust: pci: add a helper to query configuration
 space size
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
References: <20251016210250.15932-1-zhiw@nvidia.com>
 <20251016210250.15932-4-zhiw@nvidia.com>
In-Reply-To: <20251016210250.15932-4-zhiw@nvidia.com>

On Thu Oct 16, 2025 at 11:02 PM CEST, Zhi Wang wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 77a8eb39ad32..34729c6f5665 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -514,6 +514,12 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns the size of configuration space.
> +    pub fn cfg_size(&self) -> i32 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        unsafe { (*self.as_raw()).cfg_size }
> +    }
>  }

This should probably return an enum type:

	enum ConfigSize {
		Normal =3D 256,
		Extended =3D 4096,
	}

