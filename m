Return-Path: <linux-pci+bounces-34269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86748B2BD05
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDFC1B6300F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C977631A054;
	Tue, 19 Aug 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIZ/ATd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC531A04E;
	Tue, 19 Aug 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595000; cv=none; b=M4dq+/QPSOzwvYJohnBbnWZn8sSQSDb1ZttrFcIYM/EoVspwDqLaq6DkP1De2ZWjHOOv42rSVjskH8iPgFxYeyruLanu4oxfyxGehcJKfIbByrqjq+zfdu4NecJPXyofm236AM2T1xSd+eNhRb+vCn+69cSMZw7eQZGQhEazEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595000; c=relaxed/simple;
	bh=pBfQ1Kjl7wTAxur8QpXNGs9LaE42NaS0o3uiaMX/tdo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=czbugdmcuVw0i73l/N4+5F2ECiuLckiA8flrFLL+21KxxscIAfE/y0oz5k7aHRDU4gGsoRC19bI0QfD6amhT5nD4m5+wbCXN/n5ZUGWroruFqVHckU9LHejY9ixpYrAkYKClf+B2xJADA9MLwH73nc+mvz4LDy1N4YMI1LiaEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIZ/ATd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34472C4CEF1;
	Tue, 19 Aug 2025 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595000;
	bh=pBfQ1Kjl7wTAxur8QpXNGs9LaE42NaS0o3uiaMX/tdo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=EIZ/ATd4bWFl/l1pWl/sIIjoiI2AJ62g/WRMndIRddH98fNEsu/1HQW9JfERdoJx8
	 OeenBcjwGoM34bQqvMJrEVLTfxvOir58YaFtPNji0/sCOSJom3BIEk6VajzVdUlcIv
	 j7w2l7WeCtt/z52Q4tiqEXmqHYBYn1O8r0oNZZZz9sfxFuAdnGYojNClAxTKnyKuR8
	 gaUp8QHnPlUuGDuap3u4dJ2bC0oCplQ/p8ogWE5LTtYUsPR1kdLXf0rnCVDPvzRzyj
	 K+3aMsfMWLEzJM8thChlUtsVhUTQJwvZ7i9/qjJ9MXE1x7sZLF9QC/6hGNBar/DiuO
	 jBfhshsKtT+zQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 11:16:34 +0200
Message-Id: <DC6AHIFTOH7O.1USOTN2YAHGF9@kernel.org>
Subject: Re: [PATCH v3 3/3] rust: pci: provide access to PCI Vendor values
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
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250819031117.560568-1-jhubbard@nvidia.com>
 <20250819031117.560568-4-jhubbard@nvidia.com>
In-Reply-To: <20250819031117.560568-4-jhubbard@nvidia.com>

On Tue Aug 19, 2025 at 5:11 AM CEST, John Hubbard wrote:
> +/// PCI vendor IDs.
> +///
> +/// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI =
SIG.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
> +/// fn probe_device(pdev: &pci::Device<Core>) -> Result<()> {
> +///     // Validate vendor ID
> +///     let vendor =3D Vendor::try_from(pdev.vendor_id() as u32)?;

Why not change vendor_id() to return a Vendor instance directly?

> +///     dev_info!(
> +///         pdev.as_ref(),
> +///         "Detected vendor ID: (0x{:04x})\n",
> +///         vendor.as_u32()
> +///     );
> +///     Ok(())
> +/// }
> +/// ```
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +#[repr(transparent)]
> +pub struct Vendor(u32);

[ Vendor impl and lots of ids... ]

Same as for Class; probably better to move it to its own module.

We could also move both Class and Vendor into a single module, e.g. id.rs a=
nd
keep the module prefix. This would have the advantage that we could have
pci::id::Class, pci::id::Vendor and pci::id::Device (which, eventually, we =
want
as well), without getting a name conflict with pci::Device.

