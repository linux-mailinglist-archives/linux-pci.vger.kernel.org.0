Return-Path: <linux-pci+bounces-41905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54EBC7CC8B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 11:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6619A3A2867
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292EB2F9DAF;
	Sat, 22 Nov 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQFtcYB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCB2EA172;
	Sat, 22 Nov 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763807007; cv=none; b=u2kPVh107z8vQ0VT+jD3nfrbo8eUxi4DXI1rfHi0Y4mOFJ6iWHjIkZNsTvsQ5TPw5T4NebBbAqfG9bSXHClFxr2URX5UaU05vmlzoQHo0QzPg1vogDGIzrKMSZDHzRVqr6IyrVIXj1JOfDEgyTrJTceF7HmPaewZohUSlplvFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763807007; c=relaxed/simple;
	bh=8u7bqapio1JsmO1mK0MJ2m2eVnwuOTbL1W4K/3Yktbc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aKSoNcsvnKCb0VaDTI36z6yBNah0HfrIy/ZmksDgKoOfJ/AQuCinC6g19KkQsfphTFYr+7ZxspVMgkUvBa6dZcCXdtNi5ucKgstyTt82lkbhsazSgIEHlZtI6C77J9EQOQQXs+Y42CNInim5vF8Xz1tEarDIFBMFi9Lc60OrzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQFtcYB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4750C116C6;
	Sat, 22 Nov 2025 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763807006;
	bh=8u7bqapio1JsmO1mK0MJ2m2eVnwuOTbL1W4K/3Yktbc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tQFtcYB/+E2pIlLoeAI9xukS6zJRuZsQN8vTEZfZ8ZP6GG9rWp1lohqj5vop+GCgI
	 ZZ7eYKQrRGq2bGmRYYDhWUCrHIPQuw7gW6mSrOFk/TfbK6Y5LXTQwBoi5AYeYQf6Ff
	 0yDqja13uvU1VClOfdoweo+evAJYp5bo1k78DQKIUrqnNsWgBHAzTkpaPi185ZmPjw
	 00Lg+Dh+rK2p7Q9Tmaah3Et/LKmswGK7URYIL7RJolaSUO6Q8IWYgDeAgPKM4K1Yo/
	 9Xjnnx7PYJUE7lYBLQ5s4WkVYouriBWkM2QlT4+56nLgSuK6unUwjmIALxO0iFP8uy
	 hY1lYdqbnntBw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Nov 2025 23:23:16 +1300
Message-Id: <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Cc: "Peter Colberg" <pcolberg@redhat.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
To: "Jason Gunthorpe" <jgg@ziepe.ca>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca>
In-Reply-To: <20251121232642.GG233636@ziepe.ca>

On Sat Nov 22, 2025 at 12:26 PM NZDT, Jason Gunthorpe wrote:
> On Wed, Nov 19, 2025 at 05:19:11PM -0500, Peter Colberg wrote:
>> Add a method to return the Physical Function (PF) device for a Virtual
>> Function (VF) device in the bound device context.
>>=20
>> Unlike for a PCI driver written in C, guarantee that when a VF device is
>> bound to a driver, the underlying PF device is bound to a driver, too.
>
> You can't do this as an absolutely statement from rust code alone,
> this statement is confused.

Indeed! However, I'd like to see that we actually provide this guarantee fr=
om
the C PCI code.

So far I haven't heard a convincing reason for not providing this guarantee=
. The
only reason not to guarantee this I have heard is that some PF drivers only
enable SR-IOV and hence could be unloaded afterwards. However, I think ther=
e is
no strong reason to do so.

What I would like to see is that we unbind VF drivers when the PF driver is
unbound in general, analogous to what we are guaranteed by the auxiliary bu=
s.

>> +    #[cfg(CONFIG_PCI_IOV)]
>> +    pub fn physfn(&self) -> Result<&Device<device::Bound>> {
>> +        if !self.is_virtfn() {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
>> +        //
>> +        // `physfn` is a valid pointer to a `struct pci_dev` since self=
.is_virtfn() is `true`.
>> +        //
>> +        // `physfn` may be cast to a `Device<device::Bound>` since `pci=
::Driver::remove()` calls
>> +        // `disable_sriov()` to remove all VF devices, which guarantees=
 that the underlying
>> +        // PF device is always bound to a driver when the VF device is =
bound to a driver.
>
> Wrong safety statement. There are drivers that don't call
> disable_sriov(). You need to also check that the driver attached to
> the PF is actually working properly.

Indeed, with this patch, only Rust drivers provide this guarantee of the VF
being bound when the PF is bound.

> I do not like to see this attempt to open code the tricky login of
> pci_iov_get_pf_drvdata() in rust without understanding the issues :(

I discussed this with Peter in advance (thanks Peter for your work on this
topic!), and as mentioned above I'd like to see this series to propose that=
 we
always guarantee that a VF is bound when the corresponding PF is bound.

With this, the above code will be correct and a driver can use the generic
infrastructure to:

  1) Call pci::Device<Bound>::physfn() returning a Result<pci::Device<Bound=
>>
  2) Grab the driver's device private data from the returned Device<Bound>

Note that 2) (i.e. accessing the driver's device private data with
Device::drvdata() [1]) ensures that the device is actually bound (drvdata()=
 is
only implemented for Device<Bound>) and that the returned type actually mat=
ches
the type of the object that has been stored.

Since we always need those two checks when accessing a driver's device priv=
ate
data, it is already done in the generic drvdata() accessor.

Therefore the only additional guarantee we have to give is that VF bound im=
plies
PF bound. Otherwise physfn() would need to be unsafe and the driver would n=
eed
to promise that this is the case. From there on drvdata() already does the =
other
checks as mentioned.

I suggest to have a look at [2] for an example with how this turns out with=
 the
auxiliary bus [2][3], since in the end it's the same problem, i.e. an auxil=
iary
driver calling into its parent, except that the auxiliary bus already guara=
ntees
that the parent is bound when the child is bound.

Given that, there is no value in using pci_iov_get_pf_drvdata(), in Rust yo=
u'd
just call

	// `vfdev` must be a `pci::Device<Bound>` for `physfn()` to be
	// available; `pfdev` will therefore be a `pci::Device<Bound>` too
	// (assuming we provide the guarantee for this, otherwise this would
	// need to be unsafe).
	let pfdev =3D vfdev.phyfn();

	// `FooData` is the type of the PF drvier's device private data. The
	// call to `drvdata()` will fail with an error of the asserted type is
	// wrong.
	let drvdata =3D pfdev.drvdata::<FooData>()?;

So, if we'd provide a Rust accessor for the PF's device driver data, we'd
implement it like above, because Device::drvdata() is already safe. If we w=
ant
pci::Device::pf_drvdata() to be safe, we'd otherwise need to do all the che=
cks
Device::drvdata() already does again before we call into
pci_iov_get_pf_drvdata().

(Note that I'm currently travelling, hence I might not be as responsive as
usual. I'm travelling until after LPC; I plan to take a detailed look at th=
is
series in the week of the conference).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/tree/rust/kernel/device.rs?h=3Ddriver-core-next#n313
[2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/tree/samples/rust/rust_driver_auxiliary.rs?h=3Ddriver-core-next#n81
[3] https://lore.kernel.org/all/20251020223516.241050-1-dakr@kernel.org/

