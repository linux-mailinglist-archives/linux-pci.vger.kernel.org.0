Return-Path: <linux-pci+bounces-35292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305BB3EF92
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 22:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6C37AF19A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116F26CE3A;
	Mon,  1 Sep 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Efs6hQT/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB526CE05;
	Mon,  1 Sep 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758389; cv=none; b=nxVboSbVA6XQl5VcqUeD7PEY9c/D4ewHFQI+gPXQzJA5LglW86OPMmvHEwb6b6nX1DQfL/K5v4kYb/7vbSwxHcFQzqc0fqyPJtsNxnvwTPFkav2ndaRqzu8sZWnnhFGlozzMIQC1FykAwHK5BSIgzr2T1DOwVCdQYDm03Q09tL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758389; c=relaxed/simple;
	bh=eF5HEy70tfeo1yW+uH2DRuxqaYZppSmTaxduRb9MIZY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=G0oTu59PDUtUHzQKpZmmOc64bPmMZqeNY00SEl1zho4lr7Mn1gnKzCG1B9vb9ZQeqAcejGNxKOMpE4sX63V7mJXuCEwhSw/tP7l6OaWnIZ310GgA1wA/9YAZegW/FBTMRF4KO12CohSG313dlCZ3f7NBzWNR7/Lggwa0a12X4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Efs6hQT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02503C4CEF0;
	Mon,  1 Sep 2025 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758389;
	bh=eF5HEy70tfeo1yW+uH2DRuxqaYZppSmTaxduRb9MIZY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=Efs6hQT/z3OP2aSlyCKjerM6VE+/hjqwZEEEoxacgYAA8Mj0rZtK+PGz65I04d7dH
	 YTdzUr7z0tfxgqJM2BoSCquSZF2sRtIrbCkP5SO9oSchNtqZav5hwvMmMquW0J0ot5
	 OLcFT+YNoO8s+Wv1Ftdrz3t70PECmC5eDU8rX35dgxVuAax2yp1D7q/odl77PkI8Mo
	 yiU0cfTUaQKf6rWIiavJ/1/mUvYsQAklbh2KB2dSEzUSqXtTt7YXkwMiivgU/JIXpQ
	 9lUae+CoQ+JxFN0aMpyIt2JPVljdpIjbESYNcRFkfruixuuwyhAOW9IeBmnpbh4ZaM
	 sGPPSkWDtJ0aA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Sep 2025 22:26:23 +0200
Message-Id: <DCHQVFTUYTLV.3F0N1WIXZHO96@kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v8 0/6] rust, nova-core: PCI Class, Vendor support
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Elle Rhumsaa" <elle@weathered-steel.dev>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>

On Sat Aug 30, 2025 at 12:36 AM CEST, John Hubbard wrote:
> John Hubbard (6):

Applied to driver-core-testing, thanks!

>   rust: pci: provide access to PCI Class and Class-related items

    [ Minor doc-comment improvements, align Debug and Display. - Danilo ]

>   rust: pci: provide access to PCI Vendor values

    [ Minor doc-comment improvements, align Debug and Display. - Danilo ]

>   rust: pci: add DeviceId::from_class_and_vendor() method

    [ Minor doc-comment improvements. - Danilo ]

>   gpu: nova-core: avoid probing non-display/compute PCI functions
>   rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*

    [ Replace "as a validated vendor" with "as [`Vendor`]". - Danilo ]

>   rust: pci: inline several tiny functions

