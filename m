Return-Path: <linux-pci+bounces-38411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E1BE608B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 03:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 186854E30E4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 01:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B720297E;
	Fri, 17 Oct 2025 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO/Er95y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69221C167;
	Fri, 17 Oct 2025 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664411; cv=none; b=QKRyIQQ9LsaujC4Hdl4uppszXGMAVHs4kOXrX097DUmD+hLKLtOIAw6AVhWx9MdIx36IPOhaRHsx1XDvbRjYQYgQO4IAeO0L49lq6Oou8kTrggCsMFH9MDEKdjIGO8/VcBiKtkit5y6B1K6ge8K57tk6dGyoRoGyvF6MCO5zXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664411; c=relaxed/simple;
	bh=OwdpteuKkhFEy4Yv0hZ3dRnKGEL6B58h0osRHcEUIfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=STR3aWRtopdhsQXan4YUjDb7xRTBG+BVs2ztDgUyHBrsGobwitGkpreryqhm9Yi0fZzr+5lk6GGM5zQi/WBgYhHDMpWsfviuEGbGYqgiBrgB/ad7saBIblh2Boel1skAeuw6kYy8hkNa838zT9qtMo/BvqSbOiovz3pF1d5y7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO/Er95y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F14C4CEF1;
	Fri, 17 Oct 2025 01:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760664411;
	bh=OwdpteuKkhFEy4Yv0hZ3dRnKGEL6B58h0osRHcEUIfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gO/Er95yZOzdFiTOXBKyilvwKqbwjcZb4LCjJt2lPkZohO2RePyg0jRQ3XdYrvDk+
	 iEcuA/lx6HswuGJLvmGQA4yqL2JP9o0QELtRin1PlUcmUP1w4ht7pQA/KoYOGWAm6+
	 7xXArmXeyzTJzEzI8ownFvdtzDCsVRkPI1wnW/kfI5JE0zovGSnK8Df7ggYG/6ztDG
	 DKxuyNORRwgBOG3sztLhvIJYA1tJ8qornQiFoY6uxTver6+wgS6thoPhYTdrWZvICn
	 fogPGA15Sfkfhk5c0gnRR2bhbjECqXt5zZNkDZ85TUTn9bZLxVQBZ0pwQC3QMpJIxV
	 yUwtm+kPKxHbQ==
Date: Thu, 16 Oct 2025 20:26:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, zhiwang@kernel.org, acourbot@nvidia.com,
	joelagnelf@nvidia.com, jhubbard@nvidia.com, markus.probst@posteo.de
Subject: Re: [PATCH v2 1/5] rust/io: factor common I/O helpers into Io trait
 and specialize Mmio<SIZE>
Message-ID: <20251017012649.GA1009471@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016210250.15932-2-zhiw@nvidia.com>

On Thu, Oct 16, 2025 at 09:02:46PM +0000, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct.
> 
> To establish a cleaner layering between the I/O interface and its concrete
> backends, paving the way for supporting additional I/O mechanisms in the
> future, Io<SIZE> need to be factored.
> 
> Factor the common helpers into a new Io trait, and moves the MMIO-specific
> logic into a dedicated Mmio<SIZE> type implementing that trait. Rename the
> IoRaw to MmioRaw and pdate the bus MMIO implementations to use MmioRaw.

s/and moves/and move/ to match "Factor" and "Rename"
s/pdate/update/ ?

> +/// Instead, the bus specific MMIO implementation must convert this raw representation into an
> +/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
> +/// structure any guarantees are given.

s/any guarantees are given/are any guarantees given/

> +    /// Returns a new `MmioRaw` instance ...
> +/// Provides common helpers ...
> +    /// Checks whether an access ...

There's a Linux trend toward using "imperative mood", e.g., "Return",
for commit logs and comments, but I notice Rust code more often seems
to use the indicative mood: "Returns", "Provides", "Checks", etc.

Maybe that's part of the Rust style; I dunno if that's intentional or
worth commenting on, just something I notice.

Bjorn

