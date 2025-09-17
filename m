Return-Path: <linux-pci+bounces-36353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF9EB7F43C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B1D1789BA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25533C77B;
	Wed, 17 Sep 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYmvvuBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2233C761;
	Wed, 17 Sep 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114538; cv=none; b=qn3wWt5PqWI/ajE4jQj/kFWqrRC2ovtTjfGPSW2qkP0Wn8zpytE9XA6Pjyr6Ol0BAHPHO/VuJbnidAcfGsvppjgbUFHzqC3XQSmI3PVWCNFI3bSubDFu1KzkrmwKmjKMx0idMG61RezaeCDxqKHCTHOkbJ7AmyYHgjpCiGi8hXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114538; c=relaxed/simple;
	bh=VLrLSUlBS/P9kZXzPQdphm6EfcLdbn3OHFF6yEub+qs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=gcI/8Dmsim2IxdTFPPfHFV93Yka9CGwGUIiUz3dhBVS5+v6V9Xh29kRjGDINa/DWSFfdolVHgLMeIrLQszbBatmrmoMtUe/zoANYxAjorbwgRwjt0scW2PlXn6DxwfD9sL4DNVttgxyujQUCxyZFuRZjY3G/J4phLCS1Af7Hz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYmvvuBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A46C4CEF7;
	Wed, 17 Sep 2025 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758114537;
	bh=VLrLSUlBS/P9kZXzPQdphm6EfcLdbn3OHFF6yEub+qs=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=KYmvvuBp8TffgGuOj2jo+UqW3NIL3QnvuUA3zwR7+L89QD/QHGVBchIy6m8vUN3DT
	 9LK95cTtwL2zgL9GzHR0bzzokeWu+Fuuyor2uoiBxjzN55CvAa5AYZzvMZqxCF0qBy
	 2wbaeNZPuOMTh7MCPfggHaTGYz74ma64HovzZhM+zQ2AKol18YDQhpnGX1TYIYsf50
	 +/NY23j5gZAv4b9M8A3NJWeh41sarb+HyPmXLDYPvpRUhVT1T7PFY3uN8MW+DtnBKO
	 LtU6q4igqHB8lwhwQP9siWqmVonURttpCuIzgRYZd/5CCjBri6yPg1/DGMcrOirG5/
	 594IfCF4cHmZw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 15:08:50 +0200
Message-Id: <DCV3L5I2SKWH.1QPMBQBT71OKA@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: pci: fix incorrect platform reference in PCI
 driver probe doc comment
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <stable@kernel.org>
To: "Rahul Rameshbabu" <sergeantsagara@protonmail.com>
References: <20250914031759.9122-1-sergeantsagara@protonmail.com>
In-Reply-To: <20250914031759.9122-1-sergeantsagara@protonmail.com>

On Sun Sep 14, 2025 at 5:18 AM CEST, Rahul Rameshbabu wrote:
> Substitute 'platform' with 'pci'.
>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72msM5PT2mYKrX_RPXYtA4v=
apMRO=3DiSex1gQZqiXdpvvDA@mail.gmail.com/
> Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractio=
ns")
> Cc: stable@kernel.org
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

Applied to driver-core-testing, thanks!

