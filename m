Return-Path: <linux-pci+bounces-44667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBDBD1B1C0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 20:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C0230206AA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF135E527;
	Tue, 13 Jan 2026 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eypCiSOr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009982FD689;
	Tue, 13 Jan 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333761; cv=none; b=vGoXZ+MlLMRE94nx/OnOVc8oNV0+VqRnGPy0TKSaNdTX6qRXa7WXVXMKAEWdsO5mR4s9IPISsQ5DC7yzZvWHGZpCoGUKMIfoswrnPy3c+joWHn+GvMvQwVG827SGRfd9QEnn57NibK5Z0oZ/LUV8/MfAYpl8lgZ9aR2l+iwOgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333761; c=relaxed/simple;
	bh=yfPgGkpwuD2KjtAw9IVkFuilfVOJvHYpHRSDUjmENzk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZwgRr+GpgR0e0VhM4Q/Z1mkQHkl19FUMLbf94QIbNgEwV9aBQq1vrKUzNS7iUDJv1qHCA/m9h4ykWzdv2EZJvux+HCtxZuIAbK0fo9Mw/55zviL+0Wof72lkDoeaDs1pGnmyJu9XZ26PYztMXeWPmyGOwiS9ZGV/YMmEZoVZ+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eypCiSOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA21C116C6;
	Tue, 13 Jan 2026 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768333760;
	bh=yfPgGkpwuD2KjtAw9IVkFuilfVOJvHYpHRSDUjmENzk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=eypCiSOrTkSbVRDuGZ9rrmN2+G2w9lURskL8n/xlsvZ0JspYdVm5FwZPV0aSLDoJ4
	 IrYQP3KQkc8o3Jrdy4Yu1YBV8OrIGyJd2W+jTwrRgRfd5eC/Af5LU+rC3oyZsuvEse
	 Iyph07OHC0hanpHKPNMlzIYHDHSoURT9t+BMiYNTaI8GfTXo+30s180mFj1KY3cxpM
	 MBZGSvTc9pMtxea6ai4GmIzin5f2ssDXH3KRhgB+W60U/BoI7sZdwZWbszPvmDClt8
	 YWzswcWnd5hrFNp6kGN5EtnEyyTn8+jFA2dN83QIjmDexup0yAAe58uqx9sLIIXvqo
	 qJJpEQZwK/I/w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 20:49:13 +0100
Message-Id: <DFNPZZNAZRG6.30Q62W48XV008@kernel.org>
Subject: Re: [PATCH v8 5/5] sample: rust: pci: add tests for config space
 routines
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260113092253.220346-1-zhiw@nvidia.com>
 <20260113092253.220346-6-zhiw@nvidia.com>
In-Reply-To: <20260113092253.220346-6-zhiw@nvidia.com>

On Tue Jan 13, 2026 at 10:22 AM CET, Zhi Wang wrote:
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index f7130a359768..1b28a2a7d07d 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -66,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u3=
2> {
> =20
>          Ok(bar.read32(Regs::COUNT))
>      }
> +
> +    fn config_space(pdev: &pci::Device<Core>) -> Result {

&pci::Device<Bound>

