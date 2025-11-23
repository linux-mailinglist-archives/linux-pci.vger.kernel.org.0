Return-Path: <linux-pci+bounces-41920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77050C7DC3D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAAF3AB47F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586F272E51;
	Sun, 23 Nov 2025 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIagb/ca"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A4272811;
	Sun, 23 Nov 2025 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763879702; cv=none; b=lOjvyEoiK4/KdMDBLuo/P4C7frsBkp/MVvXyn/eoCSMJqf22MXAEMHJQ1BXJcVt1iLbEWlG3WGXyNMNmExR4j8VHSzH75lXhBNAm55gOU7swPQ1zDnscoAE/Mqj/ws9+0xT5JC3zaq5N31FuxQDyqVe7Om9ifwQ1aPmUpxRvlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763879702; c=relaxed/simple;
	bh=CaEAyvUeu3dFUX74QyIz4DM+s5BJN2ujoEPGufpaw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJIeujxTTsMw9lOrXJ3J61iG2M9p6uUkRoW/03A7t15XQJaooYTJhuZy8V71IGVfV4zxZ5DonPDOO5wrnTHL6VTYTYAHrniLCn9I4neMhOvO6R5n31Fj2eCKxBmXR70MvOPLYFsOQ8i0x8pvx6uIxZF7wKFxF6m5XbijbcfZDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIagb/ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7F8C116B1;
	Sun, 23 Nov 2025 06:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763879701;
	bh=CaEAyvUeu3dFUX74QyIz4DM+s5BJN2ujoEPGufpaw8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIagb/camwFx+KmZ/LZLbt92wJgJpVCV1itKy5GiPYIqxp3I/yErPVyyABl+H/wA2
	 YGs9n5tMzOiJUEy/9Ekr/zIzNg+22fEWCnpDw3hnM9Qu1sAEgOmxbl1VejcPzQJz5I
	 9/bANDpHAr5FVkwpDulFzgG+WcDuo8LwLiL5kH6SBIb5ZEk9Ufl2+D/fQMr546Fin+
	 flowO/pur24XGfmf8qJmZMz4x41tStCwp8JgulMMDgv+p7WW29xfSEgjItKay9VIrY
	 D6V542kutBFZnE6V9qX74Ey7lw0UlEsHrawykUwjY/bgBg0kbvCgKGjuXT40hwwPQN
	 FNbpb9dIyXCiw==
Date: Sun, 23 Nov 2025 08:34:56 +0200
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
Message-ID: <20251123063456.GA18335@unreal>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca>
 <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca>
 <20251122185701.GZ18335@unreal>
 <DEFKSDBXEQS0.3C79SP3HEG1OY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEFKSDBXEQS0.3C79SP3HEG1OY@kernel.org>

On Sun, Nov 23, 2025 at 11:26:52AM +1300, Danilo Krummrich wrote:
> On Sun Nov 23, 2025 at 7:57 AM NZDT, Leon Romanovsky wrote:
> > On Sat, Nov 22, 2025 at 12:16:15PM -0400, Jason Gunthorpe wrote:
> >> On Sat, Nov 22, 2025 at 11:23:16PM +1300, Danilo Krummrich wrote:
> >> > So far I haven't heard a convincing reason for not providing this guarantee. The
> >> > only reason not to guarantee this I have heard is that some PF drivers only
> >> > enable SR-IOV and hence could be unloaded afterwards. However, I think there is
> >> > no strong reason to do so.
> >> 
> >> I know some people have work flows around this. I think they are
> >> wrong. When we "fixed" mlx5 a while back there was some pushback and
> >> some weird things did stop working.
> >
> > I don't think that this is correct. The main use case for keeping VFs,
> > while unloading PF driver is to allow reuse this PF for VFIO too. It is
> > very natural and common flow for "real" SR-IOV devices which present all
> > PF/VFs as truly separate devices.
> 
> That sounds a bit odd to me, what exactly do you mean with "reuse the PF for
> VFIO"? What do you do with the PF after driver unload instead? Load another
> driver? If so, why separate ones?

One of the main use cases for SR-IOV is to provide to VM users/customers
devices with performance and security promises as physical ones. In this
case, the VMs are created through PF and not bound to any driver. Once
customer/user requests VM, that VF is bound to vfio-pci driver and
attached to that VM.

In many cases, PF is unbound too from its original driver and attached
to some other VM. It allows for these VM providers to maximize
utilization of their SR-IOV devices.

At least in PCI spec 6.0.1, it stays clearly that PF can be attached to SI (VM in spec language).
"Physical Function (PF) - A PF is a PCIe Function that supports the SR-IOV Extended Capability
and is accessible to an SR-PCIM, a VI, or an SI."

> 
> >> So while I support this goal, I don't know if enough people will
> >> agree..
> >
> > I don't see that Bjorn is CCed here, so it is unclear to whom Danilo
> > talked to get rationale for this new behaviour.
> 
> Not sure what you mean, Bjorn is CC'd on the whole series and hence also this
> conversation.
> 
> Otherwise, my proposal to guarantee that the PF is bound as long as the VF(s)
> are bound stems from the corresponding beneficial lifecycle implications for the
> driver model (some more on this below).
> 
> >> > With this, the above code will be correct and a driver can use the generic
> >> > infrastructure to:
> >> > 
> >> >   1) Call pci::Device<Bound>::physfn() returning a Result<pci::Device<Bound>>
> >> >   2) Grab the driver's device private data from the returned Device<Bound>
> >> > 
> >> > Note that 2) (i.e. accessing the driver's device private data with
> >> > Device::drvdata() [1]) ensures that the device is actually bound (drvdata() is
> >> > only implemented for Device<Bound>) and that the returned type actually matches
> >> > the type of the object that has been stored.
> >> 
> >> This is what the core helper does, with the twist that it "validates"
> >> the PF driver is working right by checking its driver binding..
> >> 
> >> > I suggest to have a look at [2] for an example with how this turns out with the
> >> > auxiliary bus [2][3], since in the end it's the same problem, i.e. an auxiliary
> >> > driver calling into its parent, except that the auxiliary bus already guarantees
> >> > that the parent is bound when the child is bound.
> >> 
> >> Aux bus is a little different because it should be used in a way where
> >> there are stronger guarantees about what the parent is. Ie the aux bus
> >> names should be unique and limited to the type of parent.
> >
> > Right, aux bus is completely unrelated to real physical PCI bus.
> 
> Of course the auxiliary and the PCI bus are fundamentally different busses,
> *but* they also have commonalities: the driver lifecycle requirements drivers
> have to deal with are the same.
> 
> For instance, if you call from an auxiliary driver into the parent driver to let
> the parent driver do some work on behalf, the auxiliary driver has to guarantee
> that the parent device is guranteed to remain bound for the duration of the
> call, otherwise the parent driver can't call dev_get_drvdata() without risking a
> UAF, since a concurrent unbind might free the parent driver's device private
> data.
> 
> The same is true for PCI when a VF driver calls into the PF driver to do some
> work on behalf. The VF driver has to make sure that the PF driver remains bound
> for the whole duration of the call for the exact same reasons.

And this section is not entirely correct. It is one of the possible
usages of PF. In many devices, PF and its VFs are independent and don't
communicate through kernel at all. There is no need for VF to have PF be
bounded to its original driver.

> 
> I.e. it is a common driver lifecycle pattern for interactions between drivers in
> general.

And it is not true as well. In case you need to interact between
devices/drivers, it is up to the caller to ensure that this driver isn't
unloaded.

> 
> As for Rust specifically, we can actually model such driver lifecycle patterns
> with the type system and with that do a lot of the driver lifecycle checks (that
> drivers love to ignore :) even at compile time, such that your code doesn't even
> compile when you violate the driver lifecycle rules.
> 
> For the auxiliary bus that's already the case and I'd love to get to this point
> with PF <-> VF interactions (in Rust) as well.

It is absolutely correct thing to do for auxbus. It is very questionable for SR-IOV.


> 
> I hope this helps.

Thanks

> 
> - Danilo

