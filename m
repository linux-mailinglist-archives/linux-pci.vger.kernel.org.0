Return-Path: <linux-pci+bounces-41461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 471E0C6663C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 23:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1149D299BC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED123451BA;
	Mon, 17 Nov 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQAqFEYq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1031E10B;
	Mon, 17 Nov 2025 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417106; cv=none; b=ZPU+Kt3kfG666Nxm67OlQ02ANC6hSgLIKQL19H696TMLwgPFYaHxLqRgMLmANMTrS5GM3T8Bi5YsW5Geo8zN8rfq3qOYS6rN8tsbRaKKmkNdUfXeYLgWnIrYGCHlhxmvx2AfSZ6Q332gJQW8yM1yZB40CwsSCQZDE68EmPV/9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417106; c=relaxed/simple;
	bh=5/G8GIkoO7z2N8ciB1v5Rc2n9Ta4Nf0bZTaX7MC2Olw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=f3Z8PfN5AbPlpolijiindKgkQPmwu4OfIQCzHJJ2YCdbwIZD+0l42cwBRgAbct6ASfGwx0oaqPMNfWlTwaiDu2oMLPwWK9k6qHyGWIcNQzQrOLPngqR5DGYesn/KqBbhqBqXKl/USHeSjbkKR865USBpt/dzZmoKcODTWYzRBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQAqFEYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33EAC2BCB6;
	Mon, 17 Nov 2025 22:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763417103;
	bh=5/G8GIkoO7z2N8ciB1v5Rc2n9Ta4Nf0bZTaX7MC2Olw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tQAqFEYqeC+cHKxLKAxS4qQCq5OcyG2fl4sxNMXCdvs0/SbfDVAbi27opRi7+v0T9
	 CiHX5Yzvy+uIe14n/2VQv63FAajjXIBP1j2NjbWezUXXryVVM3w8HdS2HdEkJK0gdX
	 Oe8yOpK8r66UArcxA7Ji54TP/w3gYyANv6BQHGEpFWvVZsZHtswu6DcDKSJOdNtLCK
	 X5vcJK0kq3lnH0Q3OGaVVgiRYMFOnzNGSmnDGUXCYToVwEGfnTqutbkkP1gTM4/2uf
	 VyWHgNC3Jm/mdQQjdgLshNUczH6YEjiSVk2N1sA5G2q33EY8TZX04yzfko6mcqDLl3
	 Ammys52N69phw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Nov 2025 11:04:53 +1300
Message-Id: <DEBB6T5ZEYQW.19GFZ39AF1SVO@kernel.org>
Subject: Re: [PATCH v7 1/2] rust: Add trait to convert a device reference to
 a bus device reference
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Lee Jones" <lee@kernel.org>, "Pavel Machek"
 <pavel@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>, "Ira Weiny"
 <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-leds@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251027200547.1038967-1-markus.probst@posteo.de>
 <20251027200547.1038967-2-markus.probst@posteo.de>
In-Reply-To: <20251027200547.1038967-2-markus.probst@posteo.de>

On Tue Oct 28, 2025 at 9:06 AM NZDT, Markus Probst wrote:
> Implement the `AsBusDevice` trait for converting a `Device` reference to =
a
> bus device reference for all bus devices.
>
> The `AsBusDevice` trait allows abstractions to provide the bus device in
> class device callbacks. It must not be used by drivers and is intended fo=
r
> bus and class device abstractions only.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Applied to driver-core-testing, thanks!

    [ * Remove unused import.
      * Change visibility of AsBusDevice to public.
      * Fix build for USB.
      * Add impl for I2cClient.
      - Danilo ]

--

Given that it's already quite late in the cycle, I expect the LED stuff to =
land
in the next cycle, hence I picked this one up in the driver-core tree.

- Danilo

