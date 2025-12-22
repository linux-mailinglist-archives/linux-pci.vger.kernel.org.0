Return-Path: <linux-pci+bounces-43532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC3CCD6B54
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95925303461F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B2733290B;
	Mon, 22 Dec 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buQieWgn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C83321D4;
	Mon, 22 Dec 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422192; cv=none; b=FVmx5RqrZxlB3O3gHMJ0/fJTsHqBmaSK3atzWs/5yVWGmXfgqVzQE/0TXEsvQTPnkUS7oDE7CmEs++X0tDp6Gp7ca/5s+HMubr8Xk9UcKjl7SDoggd2HbEojSkp0orm/tdVsiIJn8vZ+W+gFMOLQI1kR1K1CitQwuazh1n0eCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422192; c=relaxed/simple;
	bh=xoq/hoW7U9u41oy38azelGammnr7c2yCzT7NeTkAdpk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PIz/YdMgRvuwhRDSIOi+WchbvNcEHJOVHvvRI3o7CDtBlyj/cWzZzBs6Ym7iSAzz3AlEFMQEZMy6PCE2neDQoJRAGk2E3AVDhtqIqrs+KXQ19l9+mBCsZq+nBRcok5T18S2//aGh/dYFGq2MehCR9Ei6rJKqGwfa/ab6W49G/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buQieWgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277EFC116C6;
	Mon, 22 Dec 2025 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766422191;
	bh=xoq/hoW7U9u41oy38azelGammnr7c2yCzT7NeTkAdpk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=buQieWgnDtkQMMilTzGUXG1vg2S5OrfflO1d1HWqI4dprJ6LC62X7Mhx1EehCFyIq
	 oCnZdpbDEoTNIecQzEx1aRSzDaPlfjFUSSOR9wOzhZ9mhycQ1nkAQu7byTGeFZpv+h
	 Ca7ocEPJOeaRoAf6hZ0sDDOkzPAb8B7S08W+bGrjmFxhmisRCRXh30icattqFKYCW4
	 H6iJw4UPl8Gl7w9pXzTzRA+u1erm+p0kpPwrYNyTaWQX27MXcBAvs1lJBDKDICSarT
	 khURYC/UF/K/IktU5CTNitCqgTs7u/Wh9yfGkn4nRwEBr4R2LiIZ+cssH/oauwPOmZ
	 /lXDryVPcIenQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 17:49:39 +0100
Message-Id: <DF4WEITBST34.66DSABGTC82P@kernel.org>
Subject: Re: [PATCH] samples: rust: pci: replace `kernel::c_str!` with
 C-Strings
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Tamir
 Duberstein" <tamird@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
To: "Tamir Duberstein" <tamird@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251222-cstr-pci-v1-1-a0397c61bbe4@gmail.com>
In-Reply-To: <20251222-cstr-pci-v1-1-a0397c61bbe4@gmail.com>

On Mon Dec 22, 2025 at 1:23 PM CET, Tamir Duberstein wrote:
> From: Tamir Duberstein <tamird@gmail.com>
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to dirver-core-testing, thanks!

    [ Use kernel vertical import style. - Danilo ]

