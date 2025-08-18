Return-Path: <linux-pci+bounces-34202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16BCB2AC17
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FEA685B45
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED7238D54;
	Mon, 18 Aug 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o961xHW1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985535A2B9;
	Mon, 18 Aug 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529065; cv=none; b=Hv9Gf6jhP7OU6ZgV64tS5Iezc7SuO5Y3AV+qVl/XH9N1O+PpJMkHPamKVK3ckFCuRo6TWoSsSg+afBgbvBx4ln0goYTd/60yhQeI0V/4IgGxcldHMcFviLwukSGaYaev2d+jCa2eSmT6HkYuQlJhvbmkyym5fkAB8Gb3o1Z35DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529065; c=relaxed/simple;
	bh=fxjpl7asl8KgiwlfZoIW1bbJhs+WMizR72o5Nm2FTt4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=m7eUY1Wb0xYrp+ITXgRs7bi1B/NL7J8KNVH4VF4GYbYN49xUz4FnpjDgoXkp+t3erLYIpFySj5V6kBT360YW7hlq9q8zmMQPu/KdLE56GKh4AuidaKfORUTbg8tUwcpxDLHHMGvvEve5OI+PtuW8OM3os0AsS7DfqJIuyh1PGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o961xHW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA8FC4CEEB;
	Mon, 18 Aug 2025 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755529063;
	bh=fxjpl7asl8KgiwlfZoIW1bbJhs+WMizR72o5Nm2FTt4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=o961xHW1StP2YxwSH+foXj9a462Mbib7uaamtopiOykiFOo8Lqp488gNnQZiKVOra
	 MM0uwwNLsx0nxoqW+9XrItJcOQShnLNMM5CnNYTmZ6qPu8lWkaMCIcYzh/E/r+CYzN
	 mdOqIvq7SF83SDYQiHe33rkzRhC3h/y0kGHaCVMzVXawtgokZlj4DrARzFfVcMu85Y
	 +/NWuIiWY7r52y57iLA8HnB7JsoGMmwdJ+EcUkLzV6LS+WN1qzAK9k7nzwy1dVoSrz
	 U6N54yRdCXkvq0k5nchDsBqn3z00X7VeHgKxyBB7zrwuT3D6Z6rMKN4fXJOtQxO63F
	 HRVE5SWhU0zTA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 16:57:37 +0200
Message-Id: <DC5N439ZNA6E.34LSQ3K5366P7@kernel.org>
Subject: Re: [PATCH v2 1/3] rust: pci: provide access to PCI Class,
 subclass, implementation values
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
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-2-jhubbard@nvidia.com>
In-Reply-To: <20250818013305.1089446-2-jhubbard@nvidia.com>

On Mon Aug 18, 2025 at 3:33 AM CEST, John Hubbard wrote:
> +            /// Create a `Class` from the raw class code value, or `None=
` if the value doesn't
> +            /// match any known class.
> +            pub fn from_u32(value: u32) -> Option<Self> {
> +                match value {
> +                    $(x if x =3D=3D Self::$variant.0 =3D> Some(Self::$va=
riant),)+
> +                    _ =3D> None,
> +                }
> +            }

Additional to the comments from Alex, I think one should be
`impl TryFrom<u32> for Class`.

> +
> +    /// Create a new `pci::DeviceId` from a class number, mask, and spec=
ific vendor.
> +    ///
> +    /// This is more targeted than [`DeviceId::from_class`]: in addition=
 to matching by Vendor, it
> +    /// also matches the PCI Class (up to the entire 24 bits, depending =
on the mask).
> +    pub const fn from_class_and_vendor(class: Class, class_mask: u32, ve=
ndor: u32) -> Self {
> +        Self(bindings::pci_device_id {
> +            vendor,
> +            device: DeviceId::PCI_ANY_ID,
> +            subvendor: DeviceId::PCI_ANY_ID,
> +            subdevice: DeviceId::PCI_ANY_ID,
> +            class: class.as_u32(),
> +            class_mask,
> +            driver_data: 0,
> +            override_only: 0,
> +        })
> +    }
>  }
> =20
>  // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device=
_id` and does not add
> @@ -410,6 +600,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindi=
ngs::resource_size_t> {
>          // - by its type invariant `self.as_raw` is always a valid point=
er to a `struct pci_dev`.
>          Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_in=
to()?) })
>      }
> +
> +    /// Returns the full 24-bit PCI class code as stored in hardware.
> +    /// This includes base class, subclass, and programming interface.
> +    pub fn class_code_raw(&self) -> u32 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        unsafe { (*self.as_raw()).class }
> +    }
> +
> +    /// Returns the PCI class as a `Class` struct, or `None` if the clas=
s code is invalid.
> +    pub fn class_enum(&self) -> Option<Class> {
> +        Class::from_u32(self.class_code_raw())
> +    }

I don't think we have struct pci_dev instances without a valid class code,
can we? Maybe we should convert infallibly here.

