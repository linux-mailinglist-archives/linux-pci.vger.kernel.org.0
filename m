Return-Path: <linux-pci+bounces-36551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E2CB8BA64
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 01:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E1F1BC6C41
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398D29CB4D;
	Fri, 19 Sep 2025 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyDkqVg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B117A2EA;
	Fri, 19 Sep 2025 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326194; cv=none; b=aNjiftTk+eV/8myCLMDvmF/SNVcYof+P1K5pEGSwFz3+u06BV5EPJdd7TqC7ETDHU+ix+uEXwKMOmMqEUskUxpsXITfiup41XOLj3nlYwZCLFCSHx8zNopKDRUCJDUcj9AY3moWaUiW6JFvHYoldhgfrVVTtnJmX7I6V/qc6lbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326194; c=relaxed/simple;
	bh=jnQJmZBheVXo3pp3RQRswVKx1JqGxYUBeu7J45F+5VI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KTd9XyXtT+B7G2g/JxOtq/VXFjoaZq7HD7TQG2TEdGRZCZz8DZPPAoqeJ37I6G0fGQtuEeFtzf3b37QBayzBHzGHqZxskxtig7awFcQh66zlqoB3j+pbpekgLFzvsUhc2PMiX2EmtrtZsmA3cqNv35zEYZagzNn73fcpnlwdiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyDkqVg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C490C4CEF5;
	Fri, 19 Sep 2025 23:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758326193;
	bh=jnQJmZBheVXo3pp3RQRswVKx1JqGxYUBeu7J45F+5VI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=TyDkqVg+ydfmvIpZW3BOrIbUI0oXw4Its1dal9d976p/0B9GgPQAjwfkPIBaEq0Rg
	 aid6R8BLb/XMF/AyYHcbr44Bs4/ZoukK9O/rZEUzgCSAdRikNPUe1ETkwAxawVqgtp
	 mYrSFx2Y+XUcsWF+th7mmn5WtFKonD8Z2euUoli+7c6RtoNHRSfvoAfKHIaLuJqm4a
	 3FV9qDzWYFi80qkdAOB7yarvkcjZk3mgEFb/pSYNoxKvJxkxLVGzJ2VR/Q6dfVjq+F
	 024+WUopqrL58Fgtx5zqArW7ojZ6L58gT+KLq6nji8SIcxKkTg+nwJZvb3mQx/SySC
	 4Tz8G3RFVyoaQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Sep 2025 01:56:27 +0200
Message-Id: <DCX6M3BCXV2W.37USDZEDRVA2G@kernel.org>
Subject: Re: [PATCH] rust: io: use const generics for read/write offsets
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250918-write-offset-const-v1-1-eb51120d4117@google.com>
 <20250918181357.GA1825487@joelbox2> <DCWBCL9U0IY4.NFNUMLRULAWM@kernel.org>
 <20250919215634.7a1c184e.gary@garyguo.net>
In-Reply-To: <20250919215634.7a1c184e.gary@garyguo.net>

On Fri Sep 19, 2025 at 10:56 PM CEST, Gary Guo wrote:
> Turbofish is cumbersome to write with just magic numbers, and the
> fact `{}` is needed to pass in constant expressions made this much
> worse. If the drivers try hard to avoid magic numbers, you would
> effective require  all code to be `::<{ ... }>()` and this is ugly.

In the absolute majority of cases users won't see any of that anyways, sinc=
e
they'll use the register!() macro generated types.

   // Master Control Register (MCR)
   //
   // Stores the offset as associated constant.
   let mcr =3D regs::MCR::default();

   // Set the enabled bit.
   mcr.enable();

   // Write the data on the bus.
   //
   // Calls `io.write<Self::OFFSET>(self.data())` internally.
   mcr.write(&io);

For indexed registers it is indeed a problem though.

