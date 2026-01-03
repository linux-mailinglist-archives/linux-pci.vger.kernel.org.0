Return-Path: <linux-pci+bounces-43957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A357DCF0198
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69758301BCE2
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84E01DC198;
	Sat,  3 Jan 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxAx2n/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74B10785;
	Sat,  3 Jan 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453428; cv=none; b=Q+HywF8fhoP7Vut+L2XaRqAMkAsbp6NkS0s2qn2ZqiPxG+vzsl2tyc38ru1nZutadyK9iz4o9VRXm6IuUvIdnBgrGc8+oSiWwZvFntq8k5mBQWdd+aPybEOqxMRc7cUszUa69ABWEYtP8S+8tO8cgd2dy3uuLX+gbiN/wdI6lwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453428; c=relaxed/simple;
	bh=eoMMZkF6H3zKs3PqpfXVv4wM4PUx60i8dYGMpoPMyPU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=d+xW5ShmnhCRHj+Jd0mzob85gnsLjoW/zmYIebaXQgICaUSRxJNduhtFrQOoDLiUMFAJuv/5fljcPR1jrpUgM1PvK6MDJCCSa2PuwO9w4yiaMqTd1gDdFQdRzQkFqeGBS0A5zAWlIoauAMzHg7XKGP8m7OLI6B9KV+9weULY+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxAx2n/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321ECC113D0;
	Sat,  3 Jan 2026 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767453428;
	bh=eoMMZkF6H3zKs3PqpfXVv4wM4PUx60i8dYGMpoPMyPU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=TxAx2n/IQU7aPHKvVvLW9ItiUuIlbcTpVHYFonmuKSNpnmcZw24ki9j2dv3w0MYAj
	 AWXeCCt8/CI7ulIxspe1w6LVr5pvUHoclGUiAFkwhHCVvtgUkPgwjKo4s6/6hu5M7Q
	 h5idXGcjAaf+C8hnFsasqGXZINa01YoiVRJzjpnHaj7l/AoC8dJSutdvteFw6Mbqc4
	 Ghq8hvuq71nHMPAIC4+/37B3GB2WkWOx0TY4ORCico1xP2Znayqf4mdS4se0RiQ3sZ
	 V9zYXob8TcRs8kLqYhdJFChi98XC67jpym6DyXgJL2hzdS0EInjpWpxkD8rAGY6+JS
	 mIK3SULc1BJfA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Jan 2026 16:17:03 +0100
Message-Id: <DFF1Y5LEQ85Q.V2AC0R1EFXNZ@kernel.org>
Subject: Re: [PATCH] rust: pci: add HeaderType enum and header_type() helper
Cc: <engineer.jjhama@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "SeungJong Ha via B4 Relay"
 <devnull+engineer.jjhama.gmail.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260103-add-rust-pci-header-type-v1-1-879b4d74b227@gmail.com>
In-Reply-To: <20260103-add-rust-pci-header-type-v1-1-879b4d74b227@gmail.com>

On Sat Jan 3, 2026 at 3:38 PM CET, SeungJong Ha via B4 Relay wrote:
> This is my first patch to the Linux kernel, specifically targeting the=20
> Rust PCI subsystem.=20

Thanks for your contribution!

> This patch introduces the HeaderType enum to represent PCI configuration=
=20
> space header types (Normal and Bridge) and implements the header_type()=
=20
> method in the Device struct.

We usually do not add dead code in the kernel. Do you work on a user for th=
is
API?

