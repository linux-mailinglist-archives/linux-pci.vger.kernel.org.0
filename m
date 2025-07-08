Return-Path: <linux-pci+bounces-31669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8AAFC71F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FB1161DD1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9179235371;
	Tue,  8 Jul 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEAo92Pp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB662343BE;
	Tue,  8 Jul 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967149; cv=none; b=ReFerXvv5p0FmZm81BNQ0Q4+wGbS2jEkQ0Ji5W0BQ1AM+ilpIH48oNP2bMgqF0UKojtARSOP+9Db3jNpYD7lxSLGNy0Nys7IhV6Ep+xi6AYR8joQxH+fQaBxAJwS34gU51lx7NRx/5F3ktmQU+NWlOQ61Pxk0LCEHseDt+XBlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967149; c=relaxed/simple;
	bh=odbyXf59vUqn2dRPJ8DZVcQ9vXKtu52T3STTFkXU/NQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IOvVGCFW78DKdDIvRau/h5i6ouS6/7mPHciwF1uCD65UI8P7IT8sHTMbv89JbrCiTEyPMmvtJnJdb4Ag41KKcDPACQgDfJsUzkax7sf9S/ZCo3CU2F0PqFNJN9lJEZ/dLOxzo/xDyDGaS8AOvHObR86vOF+pnhnIePJNImBQbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEAo92Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091C8C4CEED;
	Tue,  8 Jul 2025 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751967149;
	bh=odbyXf59vUqn2dRPJ8DZVcQ9vXKtu52T3STTFkXU/NQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VEAo92PpvHcMZFNUGnl8furso34hSu9liyrOEMeLsk0olY+K2/fLIaDLrVjpJIR2r
	 2iAxb6fPds7ZzgiZyLfO1c/tMGOexgPlCNJHQ0Qh8ZW/NWMfTe7owW5wLVRQDCZPgh
	 VSDvw2HfdbUwOb2jYlwgLad6Sy0kHpZi0IoMAlkN7hPqZWoWc0nyCPaYFgRRmDh3oQ
	 0fYTufiKG+LtW+D6B9r4MJOtApGvLQRjQ2RxLqLbBcufLQPCjMV4um/lNftOAe3iK4
	 sPbhls3wqZxRvi2N3FCfeRIg3cEa+ihXFz89+/aROjlTK1pN67WzrGwdUvumnrPxvA
	 f0tgCnwlOpn5Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 11:32:24 +0200
Message-Id: <DB6KIR4X6GKM.3EJYQJXILGOGN@kernel.org>
Subject: Re: [PATCH 2/2] rust: Add several miscellaneous PCI helpers
Cc: <rust-for-linux@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250708060451.398323-1-apopple@nvidia.com>
 <20250708060451.398323-2-apopple@nvidia.com>
In-Reply-To: <20250708060451.398323-2-apopple@nvidia.com>

On Tue Jul 8, 2025 at 8:04 AM CEST, Alistair Popple wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7f640ba8f19c..f41fd9facb90 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -393,6 +393,42 @@ pub fn device_id(&self) -> u16 {
>          unsafe { (*self.as_raw()).device }
>      }
> =20
> +    /// Returns the PCI revision ID.
> +    pub fn revision_id(&self) -> u8 {

We should add a compiler hint for those methods to be inlined.

> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.

Let's refer to the type invariant for the validity of self.as_raw().

> +        unsafe { (*self.as_raw()).revision }
> +    }

Both is also true for the existing methods vendor_id() and device_id(). Can=
 you
please fix them up in a separate patch as well?

Also, please add a brief note in the commit message where those will be use=
d
(even though I obviously know). :)

