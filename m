Return-Path: <linux-pci+bounces-40847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC1EC4C69A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE7F3AA224
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01B2F9C3D;
	Tue, 11 Nov 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2v6Wg8v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DC2F3C3F;
	Tue, 11 Nov 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849614; cv=none; b=SEOwX6fJVtlM3UoX7aXL9rJxiwI0tIM/cUeHlxIIDjftVB7acBYHiGEub9W5f96QiWWJh9w6dy1M7Rq8wPrTarib0a9Jr6Rv10nV5qYO3PT+fVANymXshMALJeDcEAvHskkMSdmW34vUyTyJyq4kIzfqpn4qZSk+eTax1G4C4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849614; c=relaxed/simple;
	bh=96FM0MY01nX4wL/hTTKuey+IyAjZgiStHLdV7xlzeuA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=I4Zs0u0Qy80n+8BaElzLn7CZfxtmNRDPJbJ+wT3fBhX4bHzlpsk9h61M1WYId7rEZIZcfWgTk0xtFoJxsyMTKZbkxF9iNdUE2pew0vyYJduiolQ5MYmyhfMPv8BzH2+UT8kiNfWhMKfxhb5096/GgzrI4jv3Pc/NDHxH1KcOR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2v6Wg8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDD0C4CEFB;
	Tue, 11 Nov 2025 08:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762849614;
	bh=96FM0MY01nX4wL/hTTKuey+IyAjZgiStHLdV7xlzeuA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=f2v6Wg8vBqxPTA2MkjJ9Gf051kS6sRBZVpTJ/7hgE8CGegU3SvCYU3DSF7cWuYWjD
	 pOoDkwO6GD46bNUHL+TCkZqLYTy3ZG0XoGuFW00cKT1u1Aq1YD+GVIjBIYjtLqcKIj
	 CO/+m/3YBe78BBQrCnP+uB9UJVHCjY7T/TIP7l3KcKQVHiWVCSzwUz63vIF0hIdP3E
	 MmfLxME31u/vq/JlhSOlrzZeC/KtCobBDE/d8BMdvXsI7uTDmpC4GualxJ86kX6hTI
	 80Wkh1Paezkq8Tufsr9czK1JyYkKiFJiaRdYtwpU/yxkofBie/jDv6IyFnBNxYNFNE
	 2Coaynkj6ERIw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Nov 2025 19:26:42 +1100
Message-Id: <DE5Q13AXWVZC.1NRFHPA8CSO0T@kernel.org>
Subject: Re: [RFC PATCH v1 0/2] rust: pci: Introduce PCIe error handler
 support and sample usage
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Guangbo Cui" <jckeep.cuiguangbo@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>
In-Reply-To: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>

On Sun Nov 9, 2025 at 3:55 AM AEDT, Guangbo Cui wrote:
> Hi all,
>
> This RFC patchset introduces basic PCIe Advanced Error Reporting (AER)
> support for Rust PCI drivers and provides a simple example to demonstrate
> it's usage.
>
> The first patch adds the necessary infrastructure in the Rust PCI layer t=
o
> support device-specific PCI error handlers, mirroring the existing C
> `struct pci_error_handlers` callbacks.
>
> The second patch updates the Rust PCI sample driver to implement a set of
> dummy error handlers. These callbacks simply print messages and return
> predefined results, serving as a guide for future Rust PCI driver authors
> who want to handle PCIe AER events safely.
>
> This series is an RFC for discussion and not intended for merging yet.

Thanks for the series, I will have a detailed look in a few weeks.

I think this will be useful in the nova-core driver for instance. However, =
I
wonder if you have another use-case you wrote this code for?

Thanks,
Danilo

