Return-Path: <linux-pci+bounces-41536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F8C6BB3A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70D4B4E1202
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A792DAFB4;
	Tue, 18 Nov 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa8LOAlL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EE29AB07;
	Tue, 18 Nov 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500717; cv=none; b=NvU1RKhv+BdyuTHAFMfECKcjg2Z9eQQyo2XhzKvVYONZKvSqIbJeIGZpTxuVutGOyh+UEShp0+lYC0l5BHNr2utHosTthUna/AVbDQkOewBOtw52P8QdmzeYc5FP/G6GM1G/70saOFXMc58jXuQo6Y1JHSayFL9NgHaljfubzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500717; c=relaxed/simple;
	bh=6wWz4dUIUu3bV4VCg0t2TGcelVK03+4YgkyNMH+Jmxc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=WLtrJQzfHU5u0xZwzkvn0zpq3wXKaVmRLiv0KLsY5hV/zpYzx2fsz1KFJXZWUvmmDbtH/fiMPBokolCUeuRp7FHruo0ctiO/7ymxzHdd5AMFfkNg1kuT2EzE3JJBAzp1+fDl1Q1+8+fy81GtvJ/FXXx3dId5Xy55c0/ZU8972PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa8LOAlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E68C19423;
	Tue, 18 Nov 2025 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763500716;
	bh=6wWz4dUIUu3bV4VCg0t2TGcelVK03+4YgkyNMH+Jmxc=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=fa8LOAlLVKpqMnCIh6GzxMVW24Hxdi0MwqaSyH4Q9Iyv5QgmEESNRrgvXjwiCJ6gO
	 x4Nm+TtwelnCrB1qQmpeHvZM547BK8+XmovHrJI7paqBBZ51Vqf9HAle8x0bjsY5Oe
	 kwLUsHvVkCMvMFkL0XNb9IngOEoiKKktgpZjK07RQf7GkzrC/RsBEE1Wl6uWXmZMgi
	 2+5CCRRPCEgBE7eX2PTbRNf2Jiq4+jg0YMhV2xQeBwoyBsrnoiX4HeC2B2mpYQTYdx
	 iHQ56BCuJ8AUWwUtUU7CEI+BrPwiCfwg211fDxRkjjJ0iR/r+Wk9FhgI4Bj72KfQoM
	 5cI6fiJ/iDp+g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Nov 2025 10:18:27 +1300
Message-Id: <DEC4TSQBTESW.28F17X9GHCIU7@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into
 Io trait
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <zhiwang@kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-5-zhiw@nvidia.com> <aRcnd_nSflxnALQ9@google.com>
 <7b30a8a5-ec0b-4cc6-9e9a-2ff2b42ca3cf@nvidia.com>
In-Reply-To: <7b30a8a5-ec0b-4cc6-9e9a-2ff2b42ca3cf@nvidia.com>

On Tue Nov 18, 2025 at 11:44 AM NZDT, John Hubbard wrote:
> IO is generally something that can fail, so this whole idea of infallible
> IO is making me uneasy.
>
> I understand that we're trying to wrap it up into a bound device, but
> bound devices are all about whether or not the driver lifetime is OK,
> not so much about IO.

That is correct, device context states are about driver lifetime. However, =
it is
at least related, see below.

> For PCIe, it is still possible for the device to fall off of the bus, and=
=20
> in that case you'll usually see 0xFFFF_FFFF returned from PCIe reads. The
> Open RM driver has sprinkled around checks for this value (not fun, I
> know), and Danilo hinted elsewhere that bound-ness requires not getting
> these, so maybe that suffices. But it means that Rust will be "interestin=
g"
> here, because falling off the bus means that there will be a time window =
in
> which the IO is, in fact, fallible.

The PCI configuration space accessors indeed check a flag that is set when =
the
device falls off the bus. However, it is not sufficient, since you still ha=
ve a
period of time when the device fell off the bus where the flag isn't set ye=
t and
the I/O accessor may still be used concurrently.

(If you look at C drivers you will note that almost none of the drivers act=
ually
check the return value of the configuration space accessors; needless to sa=
y
MMIO ones don't even have the flag.)

Because of that, there is not a point in making all the I/O accessors falli=
ble,
because you'd have to deal with false negatives anyways, i.e. check the rea=
d
value for plausibility, because the device could already be gone, while the=
 flag
is not set yet.

Additionally, when the device fell off the bus the driver core will unbind =
the
driver, so the period where fallability would serve at least some purpose w=
ould
be very short anyways.

Instead, drivers have to be designed to be robust enough to deal with broke=
n
data read from the bus.

> Other IO subsystems can also get IO errors, too.
>
> I wonder if we should just provide IoFallible? (It could check for the
> 0xFFFF_FFFF case, for example, which is helpful to simplify the caller.)

For some registers this could be an expected value, plus a device can fall =
off
the bus during a read was well, leaving you with broken data.

I don't think trying to make all I/O operations fallible is the way to go, =
it's
just unreliable to detect in the generic layer. Instead, drivers should per=
form
a plausibility check on the read values (which they have to do anyways).

