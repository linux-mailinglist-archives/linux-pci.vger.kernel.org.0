Return-Path: <linux-pci+bounces-31665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71EAFC5F1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 10:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABA417D261
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A42BD016;
	Tue,  8 Jul 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB7jWleD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5A286D7D;
	Tue,  8 Jul 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964040; cv=none; b=YZ4uPLUDmIOkcqENNV6dV8xJoHMRL77T6iphvhOYWGdJmOiVLMJXzJ+YbLcG+3+9UXs0V4cd49fQk0RDGkmAS6CIczvRP10Y2FLIg5VOjQNS/5dO262JC4yJeRp4edG91YInAfKlALxhL/0xzV961+5B5XOTBc6ZUBzxRQjFZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964040; c=relaxed/simple;
	bh=isJPiXKLK8ij/L1W0olww0VEgqaDb+I2fExhbAsSBig=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=iBk+hhaXKZ/Oq4xR0xX2FgxSTtXgyJszOd7RMP4aW7hbZUy3Xv/Krw2JhfnESQvX4NdQ00SQIFWQ0RGw69NoMu+iv3DBwSQbHU6xc+d/SuHeB9DqvP3YVUn8PypFckwY/8mYt1fpURTYn25qfPA3jNuwl2nFqiV5Yztg/u+hPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB7jWleD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE37C4CEED;
	Tue,  8 Jul 2025 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964039;
	bh=isJPiXKLK8ij/L1W0olww0VEgqaDb+I2fExhbAsSBig=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=dB7jWleDGo5v9F5/q/5qSI7Bic5FAWJWnNU6szBin/XwqNhE4Lxicq5zZO9KStgvV
	 xJzpzG0kcvIPlfLFr7m4iUECFV16aHBUQIjpF5j/K1mFkKXCk7op/huAkVV3OjRe2d
	 2LEJpyNIQrLB0zsq7yfuVh9YZDJ+PltHCM4oyKB2Ktv72PVn7eEFwC5M34bszjPmf1
	 zrUzRniQRIdICX5HurttGX/+PD2KUjRQBkyiGOm6x5ItglS+2aJk7hSBS+KW9miCBv
	 YrWfGOBXQq8RS48nmjaRqh6/yX1iXXG6miJoE+lbjz/uw+unnMgVtQ8m/idVJBq5ul
	 JyLI5hr44CY9g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 10:40:34 +0200
Message-Id: <DB6JF2JLZEO8.4HZPDC26F3G8@kernel.org>
Subject: Re: [PATCH 1/2] rust: Add dma_set_mask() and
 dma_set_coherent_mask() bindings
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
In-Reply-To: <20250708060451.398323-1-apopple@nvidia.com>

On Tue Jul 8, 2025 at 8:04 AM CEST, Alistair Popple wrote:
> Add bindings to allow setting the DMA masks for both a generic device
> and a PCI device.

Nice coincidence, I was about to get back to this. I already implemented th=
is in
a previous patch [1], but didn't apply it yet.

I think the approach below is thought a bit too simple:

  (1) We want the DMA mask methods to be implemented by a trait in dma.rs.
      Subsequently, the trait should only be implemented by bus devices whe=
re
      the bus actually supports DMA. Allowing to set the DMA mask on any de=
vice
      doesn't make sense.

  (2) We need to consider that with this we do no prevent
      dma_set_coherent_mask() to concurrently with dma_alloc_coherent() (no=
t
      even if we'd add a new `Probe` device context).

(2) is the main reason why I didn't follow up yet. So far I haven't found a=
 nice
    solution for a sound API that doesn't need unsafe.

One thing I did consider was to have some kind of per device table (similar=
 to
the device ID table) for drivers to specify the DMA mask already at compile
time. However, I'm pretty sure there are cases where the DMA mask has to de=
rived
dynamically from probe().

I think I have to think a bit more about it.

[1] https://lore.kernel.org/all/20250317185345.2608976-7-abdiel.janulgue@gm=
ail.com/

