Return-Path: <linux-pci+bounces-41922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BFCC7DFFB
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 12:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32E884E1035
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E942D5950;
	Sun, 23 Nov 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj2/GOI/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244C2D543D;
	Sun, 23 Nov 2025 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763896709; cv=none; b=Dp9WbAga8frDM8G7OQpUqe9f+UDSjfgNuG80KIiFIORZdYQ6DvOTefVymeH+FRMmyffw+mFF6uSaLzVTwntJESDJ6i71rtH0zreRHTZ5h0W7gStdq/U8Mo3yHSVpQHr6FshTuG3MFxBiDrwv4Izi3C1AGs/y4HMJMGonc3rqnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763896709; c=relaxed/simple;
	bh=hydJ7VQx7H8SdGBM2N/7nznOiNuK9F/Hz3CWEYwfXJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9E9ctGhxARpKSIVjj4wy9xw++CDiU+IMT9iOohn5mSFUZzcOkJmoJB3A3bhduPt+Ig9XenzhvI7Y91eMayCh6+Vm1X8FVKYpcM5jQsb/XV4jPj5aDMe/t4xb8YcFbmBsD5NlVBADPCoWydS71UNt6gNZXIaC1lAUHD1Vzcuk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj2/GOI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7ACC113D0;
	Sun, 23 Nov 2025 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763896708;
	bh=hydJ7VQx7H8SdGBM2N/7nznOiNuK9F/Hz3CWEYwfXJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oj2/GOI/uMHwb4SrcSWWeEqS+GtHItTytPLyexYo3oyzsbIebAA3KCnQC46lJJVG6
	 5aNhQqJVOiVv1qdMHMFEJRml8fqlnDPT5VAUyboZWAq+Ug31TukShweqZOdsn2ri1P
	 7X+Fa9G+AXDwkH9mA6U7P1ZK6AWVUBk5qo2scs/ukl5S6s31i98STjPni1qE+gw9gU
	 im/+LgPlI2JGkKpLObc0B9JaD7ALkiMz5TMYl6MvXqSQpFB+u/j6CMo6I7XLAUzi9J
	 HAvNq+w4cIEol+KP9zZyuTOZ5uOuLVA/7w16en6wxXKKhu9ekKtVYwlFyuA0F5L7/f
	 18TYfarAxN1Lg==
Date: Sun, 23 Nov 2025 13:18:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Message-ID: <20251123111823.GD16619@unreal>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca>
 <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca>
 <20251122185701.GZ18335@unreal>
 <DEFKSDBXEQS0.3C79SP3HEG1OY@kernel.org>
 <20251123063456.GA18335@unreal>
 <DEFZP148A2NK.29G6N1V1SXT8T@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEFZP148A2NK.29G6N1V1SXT8T@kernel.org>

On Sun, Nov 23, 2025 at 11:07:47PM +1300, Danilo Krummrich wrote:
> On Sun Nov 23, 2025 at 7:34 PM NZDT, Leon Romanovsky wrote:
> > On Sun, Nov 23, 2025 at 11:26:52AM +1300, Danilo Krummrich wrote:
> >> On Sun Nov 23, 2025 at 7:57 AM NZDT, Leon Romanovsky wrote:
> >> > On Sat, Nov 22, 2025 at 12:16:15PM -0400, Jason Gunthorpe wrote:
> >> >> On Sat, Nov 22, 2025 at 11:23:16PM +1300, Danilo Krummrich wrote:
> >> >> > So far I haven't heard a convincing reason for not providing this guarantee. The
> >> >> > only reason not to guarantee this I have heard is that some PF drivers only
> >> >> > enable SR-IOV and hence could be unloaded afterwards. However, I think there is
> >> >> > no strong reason to do so.
> >> >> 
> >> >> I know some people have work flows around this. I think they are
> >> >> wrong. When we "fixed" mlx5 a while back there was some pushback and
> >> >> some weird things did stop working.
> >> >
> >> > I don't think that this is correct. The main use case for keeping VFs,
> >> > while unloading PF driver is to allow reuse this PF for VFIO too. It is
> >> > very natural and common flow for "real" SR-IOV devices which present all
> >> > PF/VFs as truly separate devices.
> >> 
> >> That sounds a bit odd to me, what exactly do you mean with "reuse the PF for
> >> VFIO"? What do you do with the PF after driver unload instead? Load another
> >> driver? If so, why separate ones?
> >
> > One of the main use cases for SR-IOV is to provide to VM users/customers
> > devices with performance and security promises as physical ones. In this
> > case, the VMs are created through PF and not bound to any driver. Once
> > customer/user requests VM, that VF is bound to vfio-pci driver and
> > attached to that VM.
> >
> > In many cases, PF is unbound too from its original driver and attached
> > to some other VM. It allows for these VM providers to maximize
> > utilization of their SR-IOV devices.
> >
> > At least in PCI spec 6.0.1, it stays clearly that PF can be attached to SI (VM in spec language).
> > "Physical Function (PF) - A PF is a PCIe Function that supports the SR-IOV Extended Capability
> > and is accessible to an SR-PCIM, a VI, or an SI."
> 
> Hm, that's possible, but do we have cases of this in practice where we bind and
> unbind the same PF multiple times, pass it to different VMs, etc.?

It is very common case, when the goal is to maximize hardware utilization.

> 
> In any case, what we can always do is what I propose in [1], i.e. add a bool to
> struct pci_driver that indicates whether the VFs should be unbound when the PF
> is unbound, such that we can uphold the guarantee of VF bound implies PF bound
> at least conditionally.
> 
> [1] https://lore.kernel.org/all/DEFL4TG0WX1C.2GLH4417EPU3V@kernel.org/
> 
> >> >> So while I support this goal, I don't know if enough people will
> >> >> agree..
> >> >
> >> > I don't see that Bjorn is CCed here, so it is unclear to whom Danilo
> >> > talked to get rationale for this new behaviour.
> >> 
> >> Not sure what you mean, Bjorn is CC'd on the whole series and hence also this
> >> conversation.
> >> 
> >> Otherwise, my proposal to guarantee that the PF is bound as long as the VF(s)
> >> are bound stems from the corresponding beneficial lifecycle implications for the
> >> driver model (some more on this below).
> >> 
> >> >> > With this, the above code will be correct and a driver can use the generic
> >> >> > infrastructure to:
> >> >> > 
> >> >> >   1) Call pci::Device<Bound>::physfn() returning a Result<pci::Device<Bound>>
> >> >> >   2) Grab the driver's device private data from the returned Device<Bound>
> >> >> > 
> >> >> > Note that 2) (i.e. accessing the driver's device private data with
> >> >> > Device::drvdata() [1]) ensures that the device is actually bound (drvdata() is
> >> >> > only implemented for Device<Bound>) and that the returned type actually matches
> >> >> > the type of the object that has been stored.
> >> >> 
> >> >> This is what the core helper does, with the twist that it "validates"
> >> >> the PF driver is working right by checking its driver binding..
> >> >> 
> >> >> > I suggest to have a look at [2] for an example with how this turns out with the
> >> >> > auxiliary bus [2][3], since in the end it's the same problem, i.e. an auxiliary
> >> >> > driver calling into its parent, except that the auxiliary bus already guarantees
> >> >> > that the parent is bound when the child is bound.
> >> >> 
> >> >> Aux bus is a little different because it should be used in a way where
> >> >> there are stronger guarantees about what the parent is. Ie the aux bus
> >> >> names should be unique and limited to the type of parent.
> >> >
> >> > Right, aux bus is completely unrelated to real physical PCI bus.
> >> 
> >> Of course the auxiliary and the PCI bus are fundamentally different busses,
> >> *but* they also have commonalities: the driver lifecycle requirements drivers
> >> have to deal with are the same.
> >> 
> >> For instance, if you call from an auxiliary driver into the parent driver to let
> >> the parent driver do some work on behalf, the auxiliary driver has to guarantee
> >> that the parent device is guranteed to remain bound for the duration of the
> >> call, otherwise the parent driver can't call dev_get_drvdata() without risking a
> >> UAF, since a concurrent unbind might free the parent driver's device private
> >> data.
> >> 
> >> The same is true for PCI when a VF driver calls into the PF driver to do some
> >> work on behalf. The VF driver has to make sure that the PF driver remains bound
> >> for the whole duration of the call for the exact same reasons.
> >
> > And this section is not entirely correct. It is one of the possible
> > usages of PF. In many devices, PF and its VFs are independent and don't
> > communicate through kernel at all. There is no need for VF to have PF be
> > bounded to its original driver.
> 
> Of course -- similarly there might be cases where an auxiliary driver might not
> cummunicate with its parent, but that's not the case I'm referring to above.

Not really. Auxbus is a logical in-kernel separation of one physical device.
The promise is that parent auxdevice is tied to its children. It was done
intentionally to make sure that children don't outlive their parent.

It is not the case for SR-IOV.

> 
> >
> >> 
> >> I.e. it is a common driver lifecycle pattern for interactions between drivers in
> >> general.
> >
> > And it is not true as well. In case you need to interact between
> > devices/drivers, it is up to the caller to ensure that this driver isn't
> > unloaded.
> 
> You're mixing two things here. The driver model lifecycle requires that if
> driver A calls into driver B - where B accesses its device private data - that B
> is bound for the full duration of the call.

I'm aware of this, and we are not talking about driver model. Whole
discussion is "if PF can be unbound, while VFs exist". The answer is yes, it can,
both from PCI spec perspective and from operational one.

> 
> This is true for any such interaction, the question of who is responsible to
> uphold this guarantee, e.g. the bus layer or the driver itself is orthogonal.
> 
> Whenever possible, it's best to let the bus layer uphold the guarantee though,
> since it's one pitfall less a driver can fall into.
> 
> >> 
> >> As for Rust specifically, we can actually model such driver lifecycle patterns
> >> with the type system and with that do a lot of the driver lifecycle checks (that
> >> drivers love to ignore :) even at compile time, such that your code doesn't even
> >> compile when you violate the driver lifecycle rules.
> >> 
> >> For the auxiliary bus that's already the case and I'd love to get to this point
> >> with PF <-> VF interactions (in Rust) as well.
> >
> > It is absolutely correct thing to do for auxbus. It is very questionable for SR-IOV.
> 
> At least conditionally (as proposed above), it's an improvement for cases where
> there is PF <-> VF interactions, i.e. why let drivers take care if the bus can
> already do it for them.

I'm not against some opt-in/opt-out solution. I'm against "one size fits
all" proposal, where PF is tied to its original driver as long as VFs
exist.

Thanks

