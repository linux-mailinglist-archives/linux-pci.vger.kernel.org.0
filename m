Return-Path: <linux-pci+bounces-37414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C18BB3D03
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07013AA406
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC02F39C6;
	Thu,  2 Oct 2025 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVLsTUV1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F762ED866;
	Thu,  2 Oct 2025 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405784; cv=none; b=nyGE/zdXPiomsXsFhSTbQ+nUm4MsdIRinrbGfr7oxk0Fmxm9PmVc82M2N7BDk+C4JUzuZb4BadaI/mA4NV9TPF8L+uormnF+EQTIvKGgqeAhumdQHFqrSxR+jTrgWPvfMCEDOpj2IQfuykBIIadg6K7hGS25PuuKfvzWf230ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405784; c=relaxed/simple;
	bh=oJQ7C3Km27dzf9R9tsuKLeHkk518hp3tLVzdWr3kU0w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=d4bGBDFPheXh17M5VNJNigK8+6gWbmvrmiwv64aZ1YSyWV7T4PtcJ92PY/gYhlrVDsVYzjqbFpJpvPCkxlGVy0ykToXRb7NYW5nWzb1Xq3b0ioJHXQQwcuERYHt8K9nhsMn0yYKHJ2CUiK59IY6N5ZNso0CfQNpPnjw+y7EOtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVLsTUV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA28C4CEF4;
	Thu,  2 Oct 2025 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759405783;
	bh=oJQ7C3Km27dzf9R9tsuKLeHkk518hp3tLVzdWr3kU0w=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=PVLsTUV1a8WRDlRxHPAmCIkBmj3obBmxbDxNYZSsbc2ZvZ8Ex0eE+dPqumkvfX+Y5
	 ZLbLL+c3EwpOyZIhMGHEIttkZWQZLp2w3gFwGloTSQWH7VXDTlzmKUNiCaS5cl0QMN
	 Vdp+EBndJ6v6lgBdMCOjbdiwz6nGGWZKC+qKMso1XQoagkDE/m2+tdfZP59aufIrfc
	 y7yQgwAuBMwMco4RFjuBaIxmrgpur+IBcvk3++Xqm6IBS+wu/fETAmUhEDtSC1ZhJ4
	 oXZ2j1vOjTRZpNbeZQuyg2M3oBXho93bPSF4UwFDF7OFWxxT0muhjtAYZcvXp6QuIk
	 3LLgxjwXD+qkg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 13:49:37 +0200
Message-Id: <DD7TANT8PB1W.2SVA4TOU80BFN@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Surath Mitra"
 <smitra@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alex Williamson" <alex.williamson@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
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
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
In-Reply-To: <20251002020010.315944-2-jhubbard@nvidia.com>

On Thu Oct 2, 2025 at 4:00 AM CEST, John Hubbard wrote:
> Add a "supports_vf" flag to struct pci_driver to let drivers declare
> Virtual Function (VF) support. If a driver does not support VFs, then
> the PCI driver core will not probe() any VFs for that driver's devices.
>
> On the Rust side, add a const "SUPPORTS_VF" Driver trait, defaulting to
> false: drivers must explicitly opt into VF support.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Zhi Wang <zhiw@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/pci/pci-driver.c | 3 +++
>  include/linux/pci.h      | 1 +
>  rust/kernel/pci.rs       | 4 ++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 63665240ae87..588666cc7254 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -412,6 +412,9 @@ static int __pci_device_probe(struct pci_driver *drv,=
 struct pci_dev *pci_dev)
>  	if (drv->probe) {
>  		error =3D -ENODEV;
> =20
> +		if (pci_dev->is_virtfn && !drv->supports_vf)
> +			return error;
> +
>  		id =3D pci_match_device(drv, pci_dev);
>  		if (id)
>  			error =3D pci_call_probe(drv, pci_dev, id);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860..92510886a086 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -983,6 +983,7 @@ struct pci_driver {
>  	struct device_driver	driver;
>  	struct pci_dynids	dynids;
>  	bool driver_managed_dma;
> +	bool supports_vf;	/* Will bind to Virtual Functions */

I don't see any driver changes in this patch, are we sure this doesn't brea=
k any
existing drivers given that this defaults to false?

Obviously, the safe call would be to invert the logic, such that it default=
s to
VFs being supported, though I clearly do prefer the opt-in.

Also, in C this always defaults to false, whereas in Rust we have the choic=
e to
make it true by default, hence in C we'd need to invert the semantics, whic=
h is
not desirable either.

>  };
> =20
>  #define to_pci_driver(__drv)	\
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7fcc5f6022c1..c5d036770e65 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -47,6 +47,7 @@ unsafe fn register(
>              (*pdrv.get()).probe =3D Some(Self::probe_callback);
>              (*pdrv.get()).remove =3D Some(Self::remove_callback);
>              (*pdrv.get()).id_table =3D T::ID_TABLE.as_ptr();
> +            (*pdrv.get()).supports_vf =3D T::SUPPORTS_VF;
>          }
> =20
>          // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> @@ -268,6 +269,9 @@ pub trait Driver: Send {
>      /// The table of device ids supported by the driver.
>      const ID_TABLE: IdTable<Self::IdInfo>;
> =20
> +    /// Whether the driver supports Virtual Functions.
> +    const SUPPORTS_VF: bool =3D false;
> +
>      /// PCI driver probe.
>      ///
>      /// Called when a new pci device is added or discovered. Implementer=
s should
> --=20
> 2.51.0


