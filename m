Return-Path: <linux-pci+bounces-37466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE70BB4F2B
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E4A323ED4
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E88279DC4;
	Thu,  2 Oct 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8wOR4zC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA512C544;
	Thu,  2 Oct 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431319; cv=none; b=SCI5y7EV3kUjFAqA9ZvpQl5yU+wgb8pch8F/1p2WLqlBm1pUhP+n8tUqCODU4qgTWyuN6gifFnbUBQJ6HGww+hlmOxk4G3n3nEFOmqXykM+5/Hn/CXIbGSDnjZkeILYjvltY1ZCs23rxEdP0nK7JmEXI/PFSCyYYsczq/DyzwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431319; c=relaxed/simple;
	bh=iBuI1IKCcI3ACqI+D1Yi8xJA58gX+7AgVRKHpdGsNww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nk0c2QpphOI82lH7Y/yi61AFMGaptX20tjFOvvAtUpBgK8VR9zrO7KpkwOIobnV6CvK5YDdgG8xuQy8/aA8RXjvj2dmH897rgTDnYd48DUE4+iAisHw1ZmnAoHZav9d0qa2X6W2djHztsK1px/11Y4frcBNe/I2o2/QRyO2voac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8wOR4zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48284C4CEF4;
	Thu,  2 Oct 2025 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759431319;
	bh=iBuI1IKCcI3ACqI+D1Yi8xJA58gX+7AgVRKHpdGsNww=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=T8wOR4zCyX6MF3M/MH5K2+QWrrVRuudVY8SbYJf3bRKh0c/1+Qmm/q0FsWPrRoV6v
	 9sgu6CFZCVu0pq9odRZdqawa55NQi4buzCkzpYZeFmLUpR89ZxiQXfNe2yEt0GCtj5
	 qF0A9TIz3hHgP7YLOqdSd0wHS/a9D5Mz26BAQYS/BKKCenA0Ed8PZPAynQ4L70jTZx
	 xH7mLxDh46pfkSYbrgcreY1GpalwKtSlYxTdiACy09mY7J7xcRFxtA+V80sBIxQ7i3
	 yUvhWXNeY16X3uDou4pgWI+76ntGTyayXJ8pDsIqZd1H0vECaT/HK6iTUEJyoczQI0
	 KVMKdyrkcWfEw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 20:55:12 +0200
Message-Id: <DD82CIS1RKUX.GRLSUUL05D8E@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <20251002175603.GB3299207@nvidia.com>
In-Reply-To: <20251002175603.GB3299207@nvidia.com>

On Thu Oct 2, 2025 at 7:56 PM CEST, Jason Gunthorpe wrote:
> This is certainly one option, you can put #2 in an aux driver of the
> PF in a nova-sriov.ko module that is fully divorced from VFIO. It
> might go along with a nova-fwctl.ko module too.
>
> You could also just embed it in nova-core.ko and have it activate when
> the PF is booted in "vGPU" mode.
>
> Broadly I would suggest the latter. aux devices make most sense to
> cross subsystems. Micro splitting a single driver with aux devices
> will make more of a mess than required. Though a good motivating
> reason would be if nova-srvio.ko is large.

As mentioned in the other sub-thread, I'm fine with either approach, but I =
think
I'd also prefer folding it into nova-core.

> Then you have two more:
>
> 4) A PCI driver in a VM that creates a DRM subsystem device
>
> This is nova-core.ko + nova-drm.ko
>
> 5) A VF driver that creates a DRM subsystem device without a VM
>
> Zhi says the device can't do this, but lets assume it could, then I
> would expect this to be nova-core.ko + nova-drm.ko, same as #4.

Indeed, but there'd probably be an overlap between the logic in the VFIO dr=
iver
and the logic required in nova-core to make this use-case happen I suspect.

