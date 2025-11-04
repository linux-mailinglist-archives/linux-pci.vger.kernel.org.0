Return-Path: <linux-pci+bounces-40219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3BC31E3F
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 16:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD36188ED9C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E95299AA3;
	Tue,  4 Nov 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niRgE2Xr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1D26A0B9;
	Tue,  4 Nov 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270710; cv=none; b=h58864DyVUtbG2kvT0N+ZulGITudUESmpIMvBnfMf2bKS9n+u7jjmwreFMENkkkKL39omQkO/8MdgzN8vCpOg+gcG8ily+JyqVL7ImgWSw3kGXn0kqau7qBaUn/GBJrxI3Pq5s22kbaVsGQbN/8s7/wy1riZDv6B4Z2vZrEgz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270710; c=relaxed/simple;
	bh=wYPHFJThd8jWW+3fIFe5EEDNMYGXnRVN2KTP1pKHF0c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RQpKPs1b4MoCwQ/sPGQr7S19HFyul56KlGg+kvSTt8UqUD9Myo+aK9UDAoEzdDYkNZ6FGeIGQ8j6uwEuKzFO6e5nR3np9VMIa6kt7o15u+Raq0HkJXOzZL3LXq9wG0Anrs+0F/RxaLfF0aQb1jp8O/HfZdaDnPcYX60X5V0qzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niRgE2Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31BAC4CEF7;
	Tue,  4 Nov 2025 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270709;
	bh=wYPHFJThd8jWW+3fIFe5EEDNMYGXnRVN2KTP1pKHF0c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=niRgE2XrLtwtpgwGuT96yrZS7huaMcxwdnIiWko2BbDDkRaHHeNWwamVVemhuKPoA
	 A7nzlirBav39YpeU4Icm6ASe/7Ug/CuZ85C/7H8rRlX7niRWdxx/E0xIphq0pG5W+p
	 EVfGj2JvtEmb7P8vr3XmMsRE/AC1Xn+EsEX3+Nozq4WngTEIpE+VR+Ct8T4pr/RHnr
	 k6OPKjtxguQjunQIxNHLndP15VqrMw0k3qhWofVVn3sP6vUDUZQCwAIfOkHNU9PKMK
	 Kv6xv7W4aBpGv/dvgMS/a+LUz7nULM/2I9XSBIZ66ufNI++iqUB0dx/kTmGEY8RUe3
	 gglW6AAmVr29g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 16:38:22 +0100
Message-Id: <DE00TSKGDJ12.39WDK8MMUPGDM@kernel.org>
Subject: Re: [PATCH RESEND v4 3/4] rust: pci: add config space read/write
 support
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
References: <20251104142733.5334-1-zhiw@nvidia.com>
 <20251104142733.5334-4-zhiw@nvidia.com>
In-Reply-To: <20251104142733.5334-4-zhiw@nvidia.com>

On Tue Nov 4, 2025 at 3:27 PM CET, Zhi Wang wrote:
> +/// Represents the PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*` help=
ers.
> +///
> +/// The generic const parameter `SIZE` can be used to indicate the
> +/// maximum size of the configuration space (e.g. 256 bytes for legacy,
> +/// 4096 bytes for extended config space). The actual size is obtained
> +/// from the underlying `struct pci_dev` via [`Device::cfg_size`].
> +pub struct ConfigSpace<'a, const SIZE: usize =3D { ConfigSpaceSize::Exte=
nded as usize }> {
> +    pdev: &'a Device<device::Core>,
> +}

Device<Bound> should be enough, we don't need to require the core context.

