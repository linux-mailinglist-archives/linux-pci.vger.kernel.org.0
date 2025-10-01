Return-Path: <linux-pci+bounces-37338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19235BB0058
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 12:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEE53A5DD5
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0529B22F;
	Wed,  1 Oct 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKoY2KnL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580828F935;
	Wed,  1 Oct 2025 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314731; cv=none; b=N74K4r/NA7J0tvZu4fCCiIraL0UIJtrktZWuzqpVLpqspVAq6nJck7O4PKfDTsDEdZeh++8AJpNUaBI7o5l+hddnVKBQHIl15YUYjVTYRbNrRnShBzQUgzWPja0jTKEaj2hb/mPKkNW2/fCiti2W43dGXvljFe8P90xVXssUXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314731; c=relaxed/simple;
	bh=P+YFqwjAsyQVj+ajZA/B1KBSZKrqZK9v+m3Wiyc2kV0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nKJkltrwx5ICbdouXDiXS0l0yUg1XJQP1Dby6K5UnH4pSmf8WbYKVZ2iTnmvd3ebfAZ5rrQHk5Ezakxs5bxqEBGlnGzpvvPkLlWp3shyH9HznneVR9qVdxHZ63GkoBFVEwE/lV/xrebFhRu/9e9Cgy5CmEcs9lKt+WFV72V3+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKoY2KnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AD1C4CEF4;
	Wed,  1 Oct 2025 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759314728;
	bh=P+YFqwjAsyQVj+ajZA/B1KBSZKrqZK9v+m3Wiyc2kV0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tKoY2KnL8Xj76oTVo6g45E3T5ntWA8T8f6WWl5EpA50rhnXgrX2/kqqr0xjJ19izW
	 P/6MMZw0S7kFN2T7z2C8MLi4fVhnnuZD7wriXPiBnITh2FI7KK0KUG5HwPOeYshj13
	 9pxzZtdM8rWiQA4U6VX0A7np0iOnn+5Jhb89q/+sRJWc7B3yFTiWDN4B5MebDNe4Vf
	 zor/ax/V2JBHOiqkIKrHVcylkoDQdbldtm/B6vWL4nB8R3YPW7/3TddnoIbjNl7LGH
	 SrZEE7ds/mGwl3LLCQtgGhwpbCgTRGEQdEADKiHn0J50zuq8zcDPsCawnFe3YSiNs3
	 cuTjOCLJqxG8A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Oct 2025 12:32:02 +0200
Message-Id: <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Surath Mitra" <smitra@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <nouveau@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
In-Reply-To: <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>

On Wed Oct 1, 2025 at 3:22 AM CEST, John Hubbard wrote:
> On 9/30/25 5:29 PM, Alistair Popple wrote:
>> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote..=
.
>>> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
>>> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
>>> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was t=
o
>>> let NovaCore bind to the VFs, and then have NovaCore call into the uppe=
r
>>> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
>>> longer in favor.) So, in order to support that:
>>>
>>> Nova-core must only bind to Physical Functions (PFs) and regular PCI
>>> devices, not to Virtual Functions (VFs) created through SR-IOV.
>>>
>>> Add a method to check if a PCI device is a Virtual Function (VF). This
>>> allows Rust drivers to determine whether a device is a VF created
>>> through SR-IOV. This is required in order to implement VFIO, because
>>> drivers such as NovaCore must only bind to Physical Functions (PFs) or
>>> regular PCI devices. The VFs must be left unclaimed, so that a VFIO
>>> kernel module can claim them.
>>=20
>> Curiously based on a quick glance I didn't see any other drivers doing t=
his
>> which makes me wonder why we're different here. But it seems likely thei=
r
>> virtual functions are supported by the same driver rather than requiring=
 a
>> different VF specific driver (or I glanced too quickly!).
>
> I haven't checked into that, but it sounds reasonable.

There are multiple cases:

Some devices have different PCI device IDs for their physical and virtual
functions and different drivers handling then. One example for that is Inte=
l
IXGBE.

But there are also some drivers, which do a similar check and just stop pro=
bing
if they detect a virtual function.

So, this patch series does not do anything uncommon.

>> I'm guessing the proposal is to fail the probe() function in nova-core f=
or
>> the VFs - I'm not sure but does the driver core continue to try probing =
other
>> drivers if one fails probe()? It seems like this would be something best
>> filtered on in the device id table, although I understand that's not pos=
sible
>> today.

Yes, the driver core keeps going until it finds a driver that succeeds prob=
ing
or no driver is left to probe. (This behavior is also the reason for the na=
me
probe() in the first place.)

However, nowadays we ideally know whether a driver fits a device before pro=
be()
is called, but there are still exceptions; with PCI virtual functions we've=
 just
hit one of those.

Theoretically, we could also indicate whether a driver handles virtual func=
tions
through a boolean in struct pci_driver, which would be a bit more elegant.

If you want I can also pick this up with my SR-IOV RFC which will probably =
touch
the driver structure as well; I plan to send something in a few days.

