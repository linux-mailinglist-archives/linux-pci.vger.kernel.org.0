Return-Path: <linux-pci+bounces-32035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEFFB03244
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 19:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03427A4CE1
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E32E233701;
	Sun, 13 Jul 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQsMDstz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A7A48;
	Sun, 13 Jul 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752427254; cv=none; b=DGRY3HHdHLEFC6op8CdLSLnL/tJ/OcD4+77UhpOuLNSFiH6rqIb1ZK0Lk9JSt/PGr23svEICtTwcJcNxfEIj8zHMif8+7m12aY91L01HSOYrF0rCD8X/me7/wIYy1WaCvqmUAvtV1iAXVb6i7EoLJZ5auDAjM0AAuLuiDUc+Xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752427254; c=relaxed/simple;
	bh=410mqOQuQTlQxVEo0ESQ57NlWicmBuyCvTwRg65vIr0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RUFXKi0tuZBCkmMzSVE1P1KpOpniETJAnfSCX9c0Q+w18VK9/R2Y9wZX28OPEb7uX2XGH1Qcm7fpw+BU5jbaVn4R/2Rre/OKyuUxQiGiA2vtWmfb2BCC/h2l6eRbfyEYOZm96anTOtHcqbY5UbsL1Ym9iLGCIn86w8APk/A//V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQsMDstz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23CAC4CEE3;
	Sun, 13 Jul 2025 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752427254;
	bh=410mqOQuQTlQxVEo0ESQ57NlWicmBuyCvTwRg65vIr0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lQsMDstzqqxgww59JZIxBK6lTOWif2E9XSEp9lgnLWCk0c1fRRldLSK45HqWPwL61
	 kQVZJLpB6y9ByDsMI1PN4xHrYnrkO3m1QHccFOXbTi3FeXjR3VCVJFEVfa4hfC+QKl
	 yx0TsSJs6A6SKci5jvDpk332XwmK1Ns+D4eIIfDvsyqD3L/aLaq7A6gA1FyUXucyUh
	 v+Hn1ZRZP5bgwXesEze7NqCshcoCpHxqydnS0iwv7C00n7nEj2861CI4o82k0pBuaP
	 3vPuI6rth4fQkb2PLbUlRrYnEOuQ7grH25BCmI922LAZyK4B8E0mbgoa03BXa+hnPZ
	 2JpACtdpW52ng==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 19:20:48 +0200
Message-Id: <DBB3M49I0GX0.2OZJA23EQPP8Z@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <DBB18YX7MBDW.3C5Q5Y1O28NFL@kernel.org>
In-Reply-To: <DBB18YX7MBDW.3C5Q5Y1O28NFL@kernel.org>

On Sun Jul 13, 2025 at 5:29 PM CEST, Benno Lossin wrote:
> I think this solution sounds much better than storing an additional
> `NonNull<Device<Bound>>`.

I can send two patches for that. The IRQ abstractions have to either land
through driver-core or in the next cycle anyways.

