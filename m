Return-Path: <linux-pci+bounces-34383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0B2B2DBB4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F30C4E51E3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F12E5D39;
	Wed, 20 Aug 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvF3LCgn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7A2E5B2E;
	Wed, 20 Aug 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690694; cv=none; b=W8AnvO/ndxCd8ivuqaWUGEzUI96Odj54SwRExRdGc9VKqffIu6tgIBLtSQd7yEyjqRYMnrdHvf8eoewfzCdkUhthJcuVvLWuXDwI0G1kGRi+0rb4ovwlBW+O5ueGnrHNt8H51oTHsP3EV0+pnevBoWDlWRjuJGr/bxIz+vXM3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690694; c=relaxed/simple;
	bh=BCf4oy3QiJQA2+jBC9hoGaSkFNSQT5YL981+qIDojUw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Rw30W/rDmB1JaDziCkkV/MHVuVV/8Be9mjA0KIj/5OtXtnbC8d4e/PQ1CXZlUTbneQRQHxQuuQ4h8aPnUaHYXnxRuwX761PohMfkfi62MRixZUFJ3osuXzSq3qJ84sA2tdFVH1Or7JELAcb+SD5iYihD6l+i7thd/5wD/OiTGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvF3LCgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE17C116C6;
	Wed, 20 Aug 2025 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755690693;
	bh=BCf4oy3QiJQA2+jBC9hoGaSkFNSQT5YL981+qIDojUw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=LvF3LCgnY/GRzggNVn5MVRpF1l34cVed2W+D2xfBDGpoIIexSuXLQevyOV7UgyVTI
	 SSY6cRe0xJB9Ervp6COFmHDzciYoopkjK8pMYIeSo9EpH1t+/mayrtByB0a44selC9
	 m2ukkfuvJHwj/C2d7hykXlCBl8gH6YPRt1nyv4XDU0ACgqkdkVwz7kmPdQl2kvphvg
	 jKDwz0dpEIYqBajdusZCBBDY93HkU5XWg0dK7aXd1FGaf7177lzRi/9RTmgz18Wwxq
	 bJTB0aKFDe7rTll7wUDQ08DEPSxJylSUdriCHKm1wIQ0X4A5Fs3NgMTQ1G6xDpp7V1
	 tktYKZr0xTy/w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 13:51:28 +0200
Message-Id: <DC78ENI8QVIO.1AU7LK858YKTM@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/3] rust: pci: provide access to PCI Class and
 Class-related items
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
References: <20250820030859.6446-1-jhubbard@nvidia.com>
 <20250820030859.6446-2-jhubbard@nvidia.com>
In-Reply-To: <20250820030859.6446-2-jhubbard@nvidia.com>

On Wed Aug 20, 2025 at 5:08 AM CEST, John Hubbard wrote:
> Allow callers to write Class::STORAGE_SCSI instead of
> bindings::PCI_CLASS_STORAGE_SCSI, for example.
>
> New APIs:
>     Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>     Class::as_raw()
>     Class: TryFrom<u32> for Class
>     ClassMask: Full, ClassSubclass
>     DeviceId::from_class_and_vendor()
>     Device::pci_class()
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> +    /// Returns the PCI class as a `Class` struct.
> +    /// Returns an error if the class code is not recognized.
> +    pub fn pci_class(&self) -> Result<Class> {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        Class::new(unsafe { (*self.as_raw()).class })
> +    }

I think all this turned out very nice!

One thing to reconsider would be whether we really want this to be fallible=
.

It's probably better to define a pci::Class::UNKNOWN and implement

	impl From<u32> for Class {
	    fn from(value: u32) -> Self {
	        match value {
	            $(x if x =3D=3D Self::$variant.0 =3D> Self::$variant,)+
	            _ =3D> Self::UNKNOWN,
	        }
	    }
	}

instead.

