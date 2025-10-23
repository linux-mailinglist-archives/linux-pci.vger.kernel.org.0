Return-Path: <linux-pci+bounces-39198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C15C03494
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 21:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26F33B3FAE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E56354AE4;
	Thu, 23 Oct 2025 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6aDiL8L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA6351FDB;
	Thu, 23 Oct 2025 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249309; cv=none; b=FpHgUCMC0fJTkDSlKMjclAkXq33aaUkLA1FXubT/QTgbKVAcazQvZRPAqQKG0et6ueCHjTxtSkuy/1FDxsQ4Eq3Y5U9+PBkssUjp9I29nJDxyQtyDN64rF/AebhLx6sRobw8mni450nrbhAlFNuMk74SKou0v0A9PczqbsV63lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249309; c=relaxed/simple;
	bh=s5xy3nx2u+lSM9BE9Cj4rKf/t3GUTdzsabHFPSUjS4A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DFPGwzimLZNswge+WJs2GeAgkHk6b3j3EOyxK9vp3aqDrwIXFcY/V6H0o9s1GA2IdPhQ3fG7AwHttI5jxNPar+NadJDmVbhy6Q7O4ROWjpdPHOGFiX1s9bLYR5yIR1BIhETMsNpAQQIIZML13jZDpoclxnEdkedNrlJBDGjOOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6aDiL8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A1AC4CEE7;
	Thu, 23 Oct 2025 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761249308;
	bh=s5xy3nx2u+lSM9BE9Cj4rKf/t3GUTdzsabHFPSUjS4A=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=M6aDiL8LtQuK/G6MlP/OUYxaKPH7XjLHvtPjbUBqs348WDzxRYKn3wlkycsCeRni/
	 rH4mdJuslYgfyfISh2hFiM7jBqoiSW2v/kh+tXQWqFpx3N5vL+NR3cg5e2P0U/Y5BP
	 2Xo4h0/ySxebKM+Af34C3skuNJ41GWMh9FCUeEJ9UC8cYWMIyvJkABdxNU0vQ/w20X
	 lKv0D0nUzvQ76c2pDjSkHFgW2egDIJCxH9ovJ/jLAQwneNngCYElK5/FOZOJWUpAJZ
	 rnMBXLSYdlRbCBV2s6mHq8RKD+FCyl3MhSYNmQugvgpxRQESDE5Ig1PjY9yUvXIH+w
	 oLlZ8a8ALlMXw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 21:55:03 +0200
Message-Id: <DDPYRSBQZ74E.QTPGVTXJDTVC@kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: consistently use INTx and PCI BAR in
 comments
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Peter Colberg" <pcolberg@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251019045620.2080-1-pcolberg@redhat.com>
In-Reply-To: <20251019045620.2080-1-pcolberg@redhat.com>

On Sun Oct 19, 2025 at 6:56 AM CEST, Peter Colberg wrote:
> Peter Colberg (2):
>   rust: pci: refer to legacy as INTx interrupts
>   rust: pci: normalise spelling of PCI BAR

Applied to driver-core-testing, thanks!

