Return-Path: <linux-pci+bounces-37443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202ABB4703
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AD91675EA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBF623F431;
	Thu,  2 Oct 2025 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVAibted"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1C23E25B;
	Thu,  2 Oct 2025 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421135; cv=none; b=QKBNjfcP0diMKq6dYNw07LgwtxeJaVs49vJ0S5pjOMImONH6J918p9WKfcL7O5aEIlp0H3sk1nlJDTnjVDoowYH7Z7Y9cFReoCE35BMpdmKcD0Ia20KcqVgYh4U3ABDXBPIYRQcFGgUpzheikegDprrX+gD3v95TFDO8nXCXx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421135; c=relaxed/simple;
	bh=FSsNLddF/JQI+ng0LO9L5eWcAwBOBZsP1GwaePkWVgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=micr77wGPFKQ1OC8GyWiAviPkXUGzmdGefxStkjA0drRZjwxxol3YYuDlegRX/eJEiHCZiltZJwa7JF5svv5YiADge1OmVzByusw9tbdJaK9sDgYRM9ad7e3e0FPNWNka8bcpvFX0G/rWyhCVtX9vzil+sbPWVoHftNhhQqe9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVAibted; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3C7C4CEF4;
	Thu,  2 Oct 2025 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759421135;
	bh=FSsNLddF/JQI+ng0LO9L5eWcAwBOBZsP1GwaePkWVgc=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=fVAibted+YQXWHCfm/zSBcYzpFNyr92F86zW7Cr6T6/cvFzUIVMeVracte/91vNNn
	 HrjXw3CZUbZN15Bh5Q11fW+0af71GqAUEVc0nYwYW/saJ5VnF3siAPz3vIAz/E5yjm
	 315xGgkNRU2m1r6yjrMQG6AOgbHMkFZQMMjLZw3fMDxjOQ9Ij51wOJ1LOWWVodd9xI
	 MEkaKwHZIUP5e9nWkJTErq5sKMNicg1SEvELbbFeZupHztW65Cn4vjbA760w+f20Nw
	 ozI0Oi3/XHI1VS00dVwVKamy0YuX1wfb9pa2kDayIQm7QBBK0PaWZ0MJCt3AXBIjup
	 fsZXTqfr6+OGA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 18:05:28 +0200
Message-Id: <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Zhi
 Wang" <zhiw@nvidia.com>, "Surath Mitra" <smitra@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alex Williamson"
 <alex.williamson@redhat.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
 <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
In-Reply-To: <20251002152346.GA3298749@nvidia.com>

On Thu Oct 2, 2025 at 5:23 PM CEST, Jason Gunthorpe wrote:
> This is not what I've been told, the VF driver has significant
> programming model differences in the NVIDIA model, and supports
> different commands.

Ok, that means there are some more fundamental differences between the host=
 PF
and the "VM PF" code that we have to deal with.

But that doesn't necessarily require that the VF parts of the host have to =
be in
nova-core as well, i.e. with the information we have we can differentiate
between PF, VF and PF in the VM (indicated by a device register).

> If you look at the VFIO driver RFC it basically does no mediation, it
> isn't intercepting MMIO - the guest sees the BARs directly. Most of
> the code is "profiling" from what I can tell. Some config space
> meddling.

Sure, there is no mediation in that sense, but it needs quite some setup
regardless, no?

I thought there is a significant amount of semantics that is different betw=
een
booting the PF and the VF on the host.

Also, the idea was to use a layered approach, i.e. let nova-core serve as a=
n
abstraction layer, where the DRM and VFIO parts can be layered on top of.

Are you suggesting to merge vGPU into nova-core?

(The VF specific firmware interfaces, should be abstracted in nova-core, so=
,
technically, we will have some vGPU specific code in nova-core.)

