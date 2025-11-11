Return-Path: <linux-pci+bounces-40851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29BC4C79C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACB4B4E9D33
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B5D238C3A;
	Tue, 11 Nov 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ/ujWk5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E891DE8A4;
	Tue, 11 Nov 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851223; cv=none; b=pn3CypPlDhYmza57up/cE/Wa7p80bO3u0gPYc/Zh6mjZaWTE2W2AFDUK9IzjqwPtgfLxVWP+hxm91JYwptqqLp/sq+sPuYbqb3py5d5O5TXcl5HmyUlOJRNXbgtqKGZ8io0oZo6YntghbuO87z5goynogUy9cs4X4yqm1SV4SvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851223; c=relaxed/simple;
	bh=JSd9pmiZ1GeEYbJE0KeNE6uRYdp7JRsb7q0z2AEKPGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BiXmcH+W7JfxAzfF04YVpGjS152Jv63dYPkFKxWHEdRdX546yY5qrCvI63Tjv83XuS+Oa+qiWiPQ+eVC+5JUl1dRtTuNjGxPDC1kH95wUmIHgtjW1AL4rneWHmjVgqBbc0BL/lWFIKU6PhMU+HWsy2M/lR1CQjcBAnSCanBmW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ/ujWk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B8BC116D0;
	Tue, 11 Nov 2025 08:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762851222;
	bh=JSd9pmiZ1GeEYbJE0KeNE6uRYdp7JRsb7q0z2AEKPGg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=PZ/ujWk5Ry5qidHyAIv3xk46J6cRe+cqgeA5TcSQecDHSPwdGstFmrbDZNJ10SRxW
	 ybyzJOJsyRlhycD4rL/pKOP1HmIm5sift2oz7+sVeQTZsXDoW93G1YNyYjxwwogVSZ
	 w5z6DyodEUUjNoKl5ZNd5/nAaxrI1XCKP7P15STGcu8Pr1qt7EVegbxTd4dpOyeeOR
	 oP0KRUpeWiztDMk3+0nAJ1iG97y7oNsKbEd57iw9+oVK6CCoFvq/jEF6dxmqEkJzpV
	 7XtCEoTN55M77t6HIdIHhT9p9eeylQFYj/KNzchhULv6XPOLcEZi2Q2MyhpvQbixPf
	 tp4L4P/EUyqQQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Nov 2025 19:53:31 +1100
Message-Id: <DE5QLMGR3OJK.1FDRF7ZJJ8WGZ@kernel.org>
Subject: Re: [PATCH] rust: pci: use "kernel vertical" style for imports
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251105120352.77603-1-dakr@kernel.org>
In-Reply-To: <20251105120352.77603-1-dakr@kernel.org>

On Wed Nov 5, 2025 at 11:03 PM AEDT, Danilo Krummrich wrote:
> Convert all imports in the PCI Rust module to use "kernel vertical"
> style.
>
> With this subsequent patches neither introduce unrelated changes nor
> leave an inconsistent import pattern.
>
> While at it, drop unnecessary imports covered by prelude::*.
>
> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

