Return-Path: <linux-pci+bounces-37728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21620BC66D0
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 21:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5DB44F45EB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5A82C0F96;
	Wed,  8 Oct 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afsjEM19"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB42C0F62;
	Wed,  8 Oct 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950551; cv=none; b=t/xvTtX+7bZUB2Qt15pU7s6V6FJ/FksuRRbr1zisQ2FnU6fyDqkhPOICKAeaUINzN6/apPlYnpi4jbZvrmw9ko1sJEQ33wgC42DvyxmAWTndhQwM8DimHmYbMeCTy+mEG476HZZfiCXvEFHNVZ7GB53b8vi7ISySf1x9iBne/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950551; c=relaxed/simple;
	bh=rDlZkxFVfeE5ywtDCiqrEgIGjXabJr8YNje3YP1LdYw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=fbEzqhptmKh7tm5W2TMNKBMnOlLQrjkrvs8I/o6JUNHXk3zpNf9R0AWTxlSxf4FPbTRw5eAgUaGUDGQCQBahqk+BG4PAwYtNjwcy2Pwc6mElZsQ3+tiJviVYkbG1gSz2vP0LL2WOgIt8xCHaoH0gok1L13forf8WYuZZG7LMOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afsjEM19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2976C4CEE7;
	Wed,  8 Oct 2025 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759950550;
	bh=rDlZkxFVfeE5ywtDCiqrEgIGjXabJr8YNje3YP1LdYw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=afsjEM19mGNanXNHRwdTpCnuYUTj1bTYJ60bUAQ9o6bVhY5Ig7ZOP1iWsXGRUP/g0
	 pRDVnHQm4UwIyQzUUDwTyrTQC9J3jmqn1LEa9+cXz1ALrcUQHk9gOi22UgACq4/0j0
	 b6LaLvAn+yFs9mnFGgGTX3yhgmBkXj7z0i+PJ3EbFnzCV47DTr1AK+8EPGWn8bJ9lG
	 d0G8TmeBOQ0RJU9504lwShlVaMcp3CD8S/2zdQf+smGa6CzpAEFY0B+71z3vcIgQoJ
	 qZOl5jMY2kyAN5M24e2iwU3AshmU/EpClp8AHP05rKwWISEWFUcpAhsZdp1OVtY5Mj
	 iK1sPEU6QfR/w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 21:09:04 +0200
Message-Id: <DDD6EEB2MJGJ.1UNH7GMXXU9WC@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <acourbot@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <joel@joelfernandes.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] rust: pci: Allocate and manage PCI interrupt vectors
References: <20251002183912.1096508-1-joelagnelf@nvidia.com>
 <DDAEL8DQFWKX.1BSBDMMN9I5B0@kernel.org>
 <58a26b94-bf06-413e-a61c-2e0d71de2ac7@nvidia.com>
In-Reply-To: <58a26b94-bf06-413e-a61c-2e0d71de2ac7@nvidia.com>

On Wed Oct 8, 2025 at 8:45 PM CEST, Joel Fernandes wrote:
> Great idea, so paraphrasing for myself, your point is with the above code=
,
> someone could theoretically do:
>
>   1. Call new() directly on IrqVectorRegistration (bypassing alloc_irq_ve=
ctors()).
>   2. Forget to call devres::register().
>   3. Store the IrqVectorRegistration somewhere.
>   4. Device gets unbound.
>   5. Later when IrqVectorRegistration::drop() runs, it tries to free vect=
ors on
> a device that's gone.
>
> Is that right?

Correct -- however, it's less about this could actually happen, since it's =
not a
public type. But it safes you writing invariants, unsafe calls, makes the c=
ode
cleaner and more self-contained.

> So a better approach as you mentioned, is to do the devres registration d=
uring
> the construction of the IrqVectorRegistration, so there's no way to do on=
e
> without the other. Did I get that right? Anyway great point and I have ma=
de this
> change, thanks!

Great, thanks!

