Return-Path: <linux-pci+bounces-41914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E7C7D616
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 19:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A18E3A7F63
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459842BEFEB;
	Sat, 22 Nov 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJdDlmWt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D682032D;
	Sat, 22 Nov 2025 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763837827; cv=none; b=ONrymS2bDX4+q97kky8cvxmOubF+ag5yN+N7T48gG7nNam69XLl9sPvh5qSZ0HER76K/XaqPkctjV5NbL9+sf/sqgjg2UlinhdY+GEAKx+ZD4GJca0s+0ocAS5Qk13OKCwnyvfKHcKDhSCh9MQ5V1Z24RFNcdvwTkMuAayy7kyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763837827; c=relaxed/simple;
	bh=oqdywxH2PSpQSz8SHOTzeR0PBfHZRenaahkNY4qCkc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWD/ayAMxI1gQvHx8RAXuvj4d7br9YU3FgmOWUq+wqaFKbdW+JATUZJEItTEaBNFIkPoQr9a8P4vFNUVP1JdezwgvGUqS9XjECzlRhoDLub321xxUnDi6w0UbZrD8RHWC49n6fDHyXa6aA4QKbkZd65q6ebq8HnrmKr8MJR9lxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJdDlmWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56DDC4CEF5;
	Sat, 22 Nov 2025 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763837825;
	bh=oqdywxH2PSpQSz8SHOTzeR0PBfHZRenaahkNY4qCkc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJdDlmWtIh/jMdxGjaoUm0N5IoZOPTIy/AuwWibX3sxUiSo//gYHrSNkQQVy9RqPG
	 fAvmLqi6/YbqeOLWapIJPVVjt0in1gxN7VchCcRDEa7qfIijgSF3id597hP54ewqjl
	 ifP2muwXCYq3I/D2dBFWPmXP6zcYMtU3p5w7mGFW9tQ8zdTYzRKdV57ZRTjGs6HXk7
	 4DhuBC6SFrIqTqzSW+a9O553rw4tHw0iPgh1E4g7Vto5A/Ie2+KpFvgplmEHJWsWrw
	 gBndbIudpA3ywEezUFttQYZvRfjddwmVrwhw5G8aqMZ3PSERvQnFlf2goU0i7kT1No
	 LzkajstZJYDJg==
Date: Sat, 22 Nov 2025 20:57:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Danilo Krummrich <dakr@kernel.org>
Cc: Peter Colberg <pcolberg@redhat.com>,
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
Message-ID: <20251122185701.GZ18335@unreal>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca>
 <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122161615.GN233636@ziepe.ca>

On Sat, Nov 22, 2025 at 12:16:15PM -0400, Jason Gunthorpe wrote:
> On Sat, Nov 22, 2025 at 11:23:16PM +1300, Danilo Krummrich wrote:
> > So far I haven't heard a convincing reason for not providing this guarantee. The
> > only reason not to guarantee this I have heard is that some PF drivers only
> > enable SR-IOV and hence could be unloaded afterwards. However, I think there is
> > no strong reason to do so.
> 
> I know some people have work flows around this. I think they are
> wrong. When we "fixed" mlx5 a while back there was some pushback and
> some weird things did stop working.

I don't think that this is correct. The main use case for keeping VFs,
while unloading PF driver is to allow reuse this PF for VFIO too. It is
very natural and common flow for "real" SR-IOV devices which present all
PF/VFs as truly separate devices.

The pushback for mlx5 was related to change in eswitch mode and not to
driver unload. In very corner case, mlx5 kept VFs to protect change in
netdevs.

> 
> So while I support this goal, I don't know if enough people will
> agree..

I don't see that Bjorn is CCed here, so it is unclear to whom Danilo
talked to get rationale for this new behaviour.

> 
> > With this, the above code will be correct and a driver can use the generic
> > infrastructure to:
> > 
> >   1) Call pci::Device<Bound>::physfn() returning a Result<pci::Device<Bound>>
> >   2) Grab the driver's device private data from the returned Device<Bound>
> > 
> > Note that 2) (i.e. accessing the driver's device private data with
> > Device::drvdata() [1]) ensures that the device is actually bound (drvdata() is
> > only implemented for Device<Bound>) and that the returned type actually matches
> > the type of the object that has been stored.
> 
> This is what the core helper does, with the twist that it "validates"
> the PF driver is working right by checking its driver binding..
> 
> > I suggest to have a look at [2] for an example with how this turns out with the
> > auxiliary bus [2][3], since in the end it's the same problem, i.e. an auxiliary
> > driver calling into its parent, except that the auxiliary bus already guarantees
> > that the parent is bound when the child is bound.
> 
> Aux bus is a little different because it should be used in a way where
> there are stronger guarantees about what the parent is. Ie the aux bus
> names should be unique and limited to the type of parent.

Right, aux bus is completely unrelated to real physical PCI bus.

Thanks

