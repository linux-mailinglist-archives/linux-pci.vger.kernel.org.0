Return-Path: <linux-pci+bounces-41921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFCC7DF50
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 11:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053994E1998
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2122D7A9;
	Sun, 23 Nov 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzHh0TIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB22D7BF;
	Sun, 23 Nov 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763892479; cv=none; b=DznuAs0DNVdfJY4JU7VjoFuoVkhKaf4uzq6JKo0CkAA5NB64Dqd15gCBfReBhL16DdJT6Yofhiux17vqJrtTeVAJEV/tJIF7id/MP+Bs8WenELMcS7m9nRxzXS7Ql/ghbeBZbf6RKgxgiTLvO28zuo2MlPdk95PerRQ/BVlxOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763892479; c=relaxed/simple;
	bh=sKysgcg1ksXOu8+RiFuMB0K5EQ5NPOkU5B2TIfaJ7Hk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Kbg6/f6R9DGms8zyvNpGK9AGFGtNpF5wt+slZY6vV6dBcgJN2gVQy77vq46VjguH2BmG/tc6e4lAU6wRPggsIkxfpNn+5OKwAg6PROHlkBok+uPWk/yTHLcFOciVphX3ukuIJ3Z8doZmuKQ6c5qcPWpDACx5SqNscBpOxJKduk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzHh0TIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D818C113D0;
	Sun, 23 Nov 2025 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763892478;
	bh=sKysgcg1ksXOu8+RiFuMB0K5EQ5NPOkU5B2TIfaJ7Hk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WzHh0TItYnKR4YtbKN+4A+a57+06/kSS5LGbkSD1yGxPY8HAh7G27ONoO/QTFL3af
	 6p5C0uJeE2mGtmBPh06sh+DTVR2WdnbJD+v850LeJbFyhJkvDM0ydOEXJN/fP2BmgA
	 1L+mDeX3N709wDREj9ILjDdqo/+itzFsgYgHaLuKI9OvamSy5WZcZvaqEY7ETA15Qr
	 F0LqyL3Y95P80DaWTJ7epaNC4i0STZCqjPQP+0UKcsX1fyCdSpLDodisfPAbVQz8Wz
	 KN1XGxyqrOPXfh9OWrPC0/k0t7sg3bBajeofl74N0s6n7EaodrwG6AJ0626NknwAww
	 wLdZvAUubJLrA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Nov 2025 23:07:47 +1300
Message-Id: <DEFZP148A2NK.29G6N1V1SXT8T@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca> <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca> <20251122185701.GZ18335@unreal>
 <DEFKSDBXEQS0.3C79SP3HEG1OY@kernel.org> <20251123063456.GA18335@unreal>
In-Reply-To: <20251123063456.GA18335@unreal>

On Sun Nov 23, 2025 at 7:34 PM NZDT, Leon Romanovsky wrote:
> On Sun, Nov 23, 2025 at 11:26:52AM +1300, Danilo Krummrich wrote:
>> On Sun Nov 23, 2025 at 7:57 AM NZDT, Leon Romanovsky wrote:
>> > On Sat, Nov 22, 2025 at 12:16:15PM -0400, Jason Gunthorpe wrote:
>> >> On Sat, Nov 22, 2025 at 11:23:16PM +1300, Danilo Krummrich wrote:
>> >> > So far I haven't heard a convincing reason for not providing this g=
uarantee. The
>> >> > only reason not to guarantee this I have heard is that some PF driv=
ers only
>> >> > enable SR-IOV and hence could be unloaded afterwards. However, I th=
ink there is
>> >> > no strong reason to do so.
>> >>=20
>> >> I know some people have work flows around this. I think they are
>> >> wrong. When we "fixed" mlx5 a while back there was some pushback and
>> >> some weird things did stop working.
>> >
>> > I don't think that this is correct. The main use case for keeping VFs,
>> > while unloading PF driver is to allow reuse this PF for VFIO too. It i=
s
>> > very natural and common flow for "real" SR-IOV devices which present a=
ll
>> > PF/VFs as truly separate devices.
>>=20
>> That sounds a bit odd to me, what exactly do you mean with "reuse the PF=
 for
>> VFIO"? What do you do with the PF after driver unload instead? Load anot=
her
>> driver? If so, why separate ones?
>
> One of the main use cases for SR-IOV is to provide to VM users/customers
> devices with performance and security promises as physical ones. In this
> case, the VMs are created through PF and not bound to any driver. Once
> customer/user requests VM, that VF is bound to vfio-pci driver and
> attached to that VM.
>
> In many cases, PF is unbound too from its original driver and attached
> to some other VM. It allows for these VM providers to maximize
> utilization of their SR-IOV devices.
>
> At least in PCI spec 6.0.1, it stays clearly that PF can be attached to S=
I (VM in spec language).
> "Physical Function (PF) - A PF is a PCIe Function that supports the SR-IO=
V Extended Capability
> and is accessible to an SR-PCIM, a VI, or an SI."

Hm, that's possible, but do we have cases of this in practice where we bind=
 and
unbind the same PF multiple times, pass it to different VMs, etc.?

In any case, what we can always do is what I propose in [1], i.e. add a boo=
l to
struct pci_driver that indicates whether the VFs should be unbound when the=
 PF
is unbound, such that we can uphold the guarantee of VF bound implies PF bo=
und
at least conditionally.

[1] https://lore.kernel.org/all/DEFL4TG0WX1C.2GLH4417EPU3V@kernel.org/

>> >> So while I support this goal, I don't know if enough people will
>> >> agree..
>> >
>> > I don't see that Bjorn is CCed here, so it is unclear to whom Danilo
>> > talked to get rationale for this new behaviour.
>>=20
>> Not sure what you mean, Bjorn is CC'd on the whole series and hence also=
 this
>> conversation.
>>=20
>> Otherwise, my proposal to guarantee that the PF is bound as long as the =
VF(s)
>> are bound stems from the corresponding beneficial lifecycle implications=
 for the
>> driver model (some more on this below).
>>=20
>> >> > With this, the above code will be correct and a driver can use the =
generic
>> >> > infrastructure to:
>> >> >=20
>> >> >   1) Call pci::Device<Bound>::physfn() returning a Result<pci::Devi=
ce<Bound>>
>> >> >   2) Grab the driver's device private data from the returned Device=
<Bound>
>> >> >=20
>> >> > Note that 2) (i.e. accessing the driver's device private data with
>> >> > Device::drvdata() [1]) ensures that the device is actually bound (d=
rvdata() is
>> >> > only implemented for Device<Bound>) and that the returned type actu=
ally matches
>> >> > the type of the object that has been stored.
>> >>=20
>> >> This is what the core helper does, with the twist that it "validates"
>> >> the PF driver is working right by checking its driver binding..
>> >>=20
>> >> > I suggest to have a look at [2] for an example with how this turns =
out with the
>> >> > auxiliary bus [2][3], since in the end it's the same problem, i.e. =
an auxiliary
>> >> > driver calling into its parent, except that the auxiliary bus alrea=
dy guarantees
>> >> > that the parent is bound when the child is bound.
>> >>=20
>> >> Aux bus is a little different because it should be used in a way wher=
e
>> >> there are stronger guarantees about what the parent is. Ie the aux bu=
s
>> >> names should be unique and limited to the type of parent.
>> >
>> > Right, aux bus is completely unrelated to real physical PCI bus.
>>=20
>> Of course the auxiliary and the PCI bus are fundamentally different buss=
es,
>> *but* they also have commonalities: the driver lifecycle requirements dr=
ivers
>> have to deal with are the same.
>>=20
>> For instance, if you call from an auxiliary driver into the parent drive=
r to let
>> the parent driver do some work on behalf, the auxiliary driver has to gu=
arantee
>> that the parent device is guranteed to remain bound for the duration of =
the
>> call, otherwise the parent driver can't call dev_get_drvdata() without r=
isking a
>> UAF, since a concurrent unbind might free the parent driver's device pri=
vate
>> data.
>>=20
>> The same is true for PCI when a VF driver calls into the PF driver to do=
 some
>> work on behalf. The VF driver has to make sure that the PF driver remain=
s bound
>> for the whole duration of the call for the exact same reasons.
>
> And this section is not entirely correct. It is one of the possible
> usages of PF. In many devices, PF and its VFs are independent and don't
> communicate through kernel at all. There is no need for VF to have PF be
> bounded to its original driver.

Of course -- similarly there might be cases where an auxiliary driver might=
 not
cummunicate with its parent, but that's not the case I'm referring to above=
.

>
>>=20
>> I.e. it is a common driver lifecycle pattern for interactions between dr=
ivers in
>> general.
>
> And it is not true as well. In case you need to interact between
> devices/drivers, it is up to the caller to ensure that this driver isn't
> unloaded.

You're mixing two things here. The driver model lifecycle requires that if
driver A calls into driver B - where B accesses its device private data - t=
hat B
is bound for the full duration of the call.

This is true for any such interaction, the question of who is responsible t=
o
uphold this guarantee, e.g. the bus layer or the driver itself is orthogona=
l.

Whenever possible, it's best to let the bus layer uphold the guarantee thou=
gh,
since it's one pitfall less a driver can fall into.

>>=20
>> As for Rust specifically, we can actually model such driver lifecycle pa=
tterns
>> with the type system and with that do a lot of the driver lifecycle chec=
ks (that
>> drivers love to ignore :) even at compile time, such that your code does=
n't even
>> compile when you violate the driver lifecycle rules.
>>=20
>> For the auxiliary bus that's already the case and I'd love to get to thi=
s point
>> with PF <-> VF interactions (in Rust) as well.
>
> It is absolutely correct thing to do for auxbus. It is very questionable =
for SR-IOV.

At least conditionally (as proposed above), it's an improvement for cases w=
here
there is PF <-> VF interactions, i.e. why let drivers take care if the bus =
can
already do it for them.

