Return-Path: <linux-pci+bounces-41916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04048C7D987
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 23:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D5355A76
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 22:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559B296BAA;
	Sat, 22 Nov 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lffIS5va"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33E265620;
	Sat, 22 Nov 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850422; cv=none; b=gBHhL3l1FPiKjQyp1AeRoEXJldDWJIzSWNAOL24kQtr96DqkXLGsGFdekk7p4fbNFt+oEz+h2k54YqX9XB6dBzDQ3IdFI7OJlHqwPAGYEBixhRtd9hWeO1mz9TJ75R+rG0iSRaZV1immSFePeG9wpiM9UdhjgbFeXHNy9r5XKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850422; c=relaxed/simple;
	bh=6apKD8oaFo0yzsXy5PouKPvtkg9frl30YJZu6K7T1sM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=F8/O8xdnhSGn554zGI/Q/W1C/O8LY4F624YaJF5hqlrE28DDwynzgV0cJFH+bToKs9lMqtMlTvWsTKYQ/Gm6PqFokBjnB9ibjLBpowqCM+IZ+Uq2jtxRt28uxyjm1wjVgOYi50cZ66x36EYLShC1jtpA8KMy4mb8nqZOyQz1gf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lffIS5va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A597DC2BCB1;
	Sat, 22 Nov 2025 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763850421;
	bh=6apKD8oaFo0yzsXy5PouKPvtkg9frl30YJZu6K7T1sM=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=lffIS5vaf9zCOBP6YsQbK3Qh4rl/ALYo0fBO4/vsHQOsa/dEzM4atF9dlsCrqYDa9
	 +h/48kBkOXjR9LXbqZOfh7wT6B/k4UpTfubJXgp0Mit50rfH3WpJEkG+N8mWQ96nYr
	 UKgj7zFVSa2zuVByRk36mDJckJDxhZQlnvIg1QIsTl/bn2zVAu0zWwXvz10e/1i/pJ
	 aRdbzG8srF4faUdhli9C4gNTz/OiZmBPPo8oAC3bXqq4asJ07qOQgpoq7zFj9+TYuZ
	 Hqz0utHX9Meldh8S4+XhaDSv/O+hkrjrw3OKKTkJg44SMlkdOdZn8/sUdFr4xEnxf5
	 wgn6A9FQ3DYWg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Nov 2025 11:26:52 +1300
Message-Id: <DEFKSDBXEQS0.3C79SP3HEG1OY@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Colberg" <pcolberg@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>
To: "Leon Romanovsky" <leon@kernel.org>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca> <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca> <20251122185701.GZ18335@unreal>
In-Reply-To: <20251122185701.GZ18335@unreal>

On Sun Nov 23, 2025 at 7:57 AM NZDT, Leon Romanovsky wrote:
> On Sat, Nov 22, 2025 at 12:16:15PM -0400, Jason Gunthorpe wrote:
>> On Sat, Nov 22, 2025 at 11:23:16PM +1300, Danilo Krummrich wrote:
>> > So far I haven't heard a convincing reason for not providing this guar=
antee. The
>> > only reason not to guarantee this I have heard is that some PF drivers=
 only
>> > enable SR-IOV and hence could be unloaded afterwards. However, I think=
 there is
>> > no strong reason to do so.
>>=20
>> I know some people have work flows around this. I think they are
>> wrong. When we "fixed" mlx5 a while back there was some pushback and
>> some weird things did stop working.
>
> I don't think that this is correct. The main use case for keeping VFs,
> while unloading PF driver is to allow reuse this PF for VFIO too. It is
> very natural and common flow for "real" SR-IOV devices which present all
> PF/VFs as truly separate devices.

That sounds a bit odd to me, what exactly do you mean with "reuse the PF fo=
r
VFIO"? What do you do with the PF after driver unload instead? Load another
driver? If so, why separate ones?

>> So while I support this goal, I don't know if enough people will
>> agree..
>
> I don't see that Bjorn is CCed here, so it is unclear to whom Danilo
> talked to get rationale for this new behaviour.

Not sure what you mean, Bjorn is CC'd on the whole series and hence also th=
is
conversation.

Otherwise, my proposal to guarantee that the PF is bound as long as the VF(=
s)
are bound stems from the corresponding beneficial lifecycle implications fo=
r the
driver model (some more on this below).

>> > With this, the above code will be correct and a driver can use the gen=
eric
>> > infrastructure to:
>> >=20
>> >   1) Call pci::Device<Bound>::physfn() returning a Result<pci::Device<=
Bound>>
>> >   2) Grab the driver's device private data from the returned Device<Bo=
und>
>> >=20
>> > Note that 2) (i.e. accessing the driver's device private data with
>> > Device::drvdata() [1]) ensures that the device is actually bound (drvd=
ata() is
>> > only implemented for Device<Bound>) and that the returned type actuall=
y matches
>> > the type of the object that has been stored.
>>=20
>> This is what the core helper does, with the twist that it "validates"
>> the PF driver is working right by checking its driver binding..
>>=20
>> > I suggest to have a look at [2] for an example with how this turns out=
 with the
>> > auxiliary bus [2][3], since in the end it's the same problem, i.e. an =
auxiliary
>> > driver calling into its parent, except that the auxiliary bus already =
guarantees
>> > that the parent is bound when the child is bound.
>>=20
>> Aux bus is a little different because it should be used in a way where
>> there are stronger guarantees about what the parent is. Ie the aux bus
>> names should be unique and limited to the type of parent.
>
> Right, aux bus is completely unrelated to real physical PCI bus.

Of course the auxiliary and the PCI bus are fundamentally different busses,
*but* they also have commonalities: the driver lifecycle requirements drive=
rs
have to deal with are the same.

For instance, if you call from an auxiliary driver into the parent driver t=
o let
the parent driver do some work on behalf, the auxiliary driver has to guara=
ntee
that the parent device is guranteed to remain bound for the duration of the
call, otherwise the parent driver can't call dev_get_drvdata() without risk=
ing a
UAF, since a concurrent unbind might free the parent driver's device privat=
e
data.

The same is true for PCI when a VF driver calls into the PF driver to do so=
me
work on behalf. The VF driver has to make sure that the PF driver remains b=
ound
for the whole duration of the call for the exact same reasons.

I.e. it is a common driver lifecycle pattern for interactions between drive=
rs in
general.

As for Rust specifically, we can actually model such driver lifecycle patte=
rns
with the type system and with that do a lot of the driver lifecycle checks =
(that
drivers love to ignore :) even at compile time, such that your code doesn't=
 even
compile when you violate the driver lifecycle rules.

For the auxiliary bus that's already the case and I'd love to get to this p=
oint
with PF <-> VF interactions (in Rust) as well.

I hope this helps.

- Danilo

