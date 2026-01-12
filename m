Return-Path: <linux-pci+bounces-44525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B36ED14135
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CB330FFF3C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9666A364046;
	Mon, 12 Jan 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTvsvVQN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE524A07C;
	Mon, 12 Jan 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235422; cv=none; b=CoinrwUhEUMYdub9akHWlpGsX8YJxwkHgIjWa/KT1kz6nn3g5biCC7hyXHwzutSGxZlP3tKRtFYUhzVzf5AfE81ub098Xsya/5ZnUzRW3gziJ7cCPCeM3/tMakFNkDSUIlzO5rbuDUnVWAyKzVBvObT7zh5se9mX79wN5H9IHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235422; c=relaxed/simple;
	bh=D5FW8AgSUopXzALYEw+ZPNzXsyiuugZWfH+sRTMD5e0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=iCOky33dYnz0Lq/vGIRwjhuUaNmS4a6knAMqUH64ePzS9vCDKtnd/ia3PngaPXL54upbZOmTgwQmerULvxCx1fgRHZAGnMWGHN61txXcEDXPAaHU7v5QgW16/+9loLmNUDnwMRg9H/0E4T6leFSShF6V/qgEwErzVwWi9HTmpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTvsvVQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED24C116D0;
	Mon, 12 Jan 2026 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235422;
	bh=D5FW8AgSUopXzALYEw+ZPNzXsyiuugZWfH+sRTMD5e0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=dTvsvVQNZHYA37f+XKLYgIeYOhjH0fmOW2mu4XspUOMDo2/7DpxUR45xt6MTUlz5B
	 FnayInfdfpA+uzL9Mq90zfReWacroF8Nz2TP5SmC01Z4QIy8/GPeju/6Tjmaz4ZNK+
	 JhxgSy4/2rr7oOovpvIk6LLgrPIn+Z7wEhabcZG97oj3RIs6cy65IHYKt26yVjYPtq
	 zRqJGMkius2NX0RZ0rB1NraEGe8UQWlRkhVJUWE5cyc/XJly4y1vWfWdk90EmaZlb1
	 bKjGy3sNgE/fX249OuHxaBrG8fjfdeodFDiexE0WToN+E8XAzqUPFn7HUqvQBqVtua
	 hb1cvLAGP0BTQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Jan 2026 17:30:16 +0100
Message-Id: <DFMR5480EBNW.2TGBZVU4XZ8U7@kernel.org>
To: "Bjorn Helgaas" <bhelgaas@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Dirk
 Behme" <dirk.behme@gmail.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "kernel test robot" <lkp@intel.com>, "Liang
 Jie" <liangjie@lixiang.com>, "Drew Fustini" <fustini@kernel.org>, "David
 Gow" <davidgow@google.com>
References: <20251226113938.52145-1-boqun.feng@gmail.com>
In-Reply-To: <20251226113938.52145-1-boqun.feng@gmail.com>

On Fri Dec 26, 2025 at 12:39 PM CET, Boqun Feng wrote:
> Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
> is disabled") fixed a build error by providing rust helpers when
> CONFIG_PCI_MSI=3Dn. However the rust helpers rely on the
> pci_alloc_irq_vectors() function is defined, which is not true when
> CONFIG_PCI=3Dn. There are multiple ways to fix this, e.g. a possible fix
> could be just remove the calling of pci_alloc_irq_vectors() since it's
> empty when CONFIG_PCI_MSI=3Dn anyway. However, since PCI irq APIs, such a=
s
> pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=3Dn, th=
e
> more reasonable fix is to define pci_alloc_irq_vectors() when
> CONFIG_PCI=3Dn and this aligns with the situations of other primitives as
> well.
>
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Closes: https://lore.kernel.org/rust-for-linux/20251209014312.575940-1-fu=
jita.tomonori@gmail.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512220740.4Kexm4dW-lkp@i=
ntel.com/
> Reported-by: Liang Jie <liangjie@lixiang.com>
> Closes: https://lore.kernel.org/rust-for-linux/20251222034415.1384223-1-b=
uaajxlj@163.com/
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is=
 disabled")
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Bjorn, I just received another bug report due to this issue. Can you please=
 pick
this up for the next -rc?

If you don't have anything else to send, I can pick it up as well. :)

Thanks,
Danilo

