Return-Path: <linux-pci+bounces-36992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E8BA08A5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C71188F3E2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4730648B;
	Thu, 25 Sep 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2VsaC8b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1D30597E;
	Thu, 25 Sep 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816285; cv=none; b=R0TWjRBAyhy2raQ0uyob4MUTp3wT0ZKaixWxur/kZntfq7miuF40IaazzryBGpMUTeECqIB8Wfa0e+cVuuubvVBEbkMG+uvCBETso2FJkkAeGaeBDLeUoMzJ3UnxfpvHUe4sIG+hSpG0DjvnjaDVSz6CWdBT12taS0sn8miDxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816285; c=relaxed/simple;
	bh=J4lfDJvJgocwerP41ChdYCyqljRyihOByw2tDqIsf/0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VrQxG1ju9A6/syvS2j2BouqHonWx1ddXLEFx7BnEpuFc4RY/F8j/bLgEw10sdwqOnwf++PYQNKj7+9VShZp/PpVeHXoVgyc3Hc3wVQXX8AjKiSfQd9MQqwAL51HOs2H9U5gnAe/6zvRVAazek3g0efWcTAvHbnysJ4XIIXMw/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2VsaC8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD4C4CEF5;
	Thu, 25 Sep 2025 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758816284;
	bh=J4lfDJvJgocwerP41ChdYCyqljRyihOByw2tDqIsf/0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=I2VsaC8bw4xCfIrNIpD1bNAl+0M2V2X1yr6BfxIQWRuKkpujsnlGPvTTgbhN+H46K
	 CS8iZ7KQwSNoYBxUa3fV9xrwrtBUaa3zShjwn9+GsIFEPScHG06lFcG7CER/G14reF
	 jKZ97z1grrkrJOoidPf9wm8jCb8n/Qa+8LBmooC8JP1PCoWLc6jr4CmYl9wb5L1X6J
	 OJOVZKuzSsyQgT5NYRseInCHnm+nAFwG8GZmAZkkmbwgA2MKcG84clKVOkKxGJRgzu
	 /T2h9fTtNvfUJQNDfqyGbOuSN1vsCNxYVM0206IExEQl+GxbDPurjctd+pqLfjDhqi
	 sUlcOBOgn96Dw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 18:04:38 +0200
Message-Id: <DD20C3S0YCK0.25BIXD409WED2@kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: display symbolic PCI vendor and class
 names
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
References: <20250925013359.414526-1-jhubbard@nvidia.com>
In-Reply-To: <20250925013359.414526-1-jhubbard@nvidia.com>

On Thu Sep 25, 2025 at 3:33 AM CEST, John Hubbard wrote:
> This applies to:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git

This is an old tree, the new one is:

https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
/

> John Hubbard (2):

Applied to driver-core-testing, thanks!

>   rust: pci: display symbolic PCI class names
>   rust: pci: display symbolic PCI vendor names

    [ Remove #[inline] for Vendor::fmt(). - Danilo ]

