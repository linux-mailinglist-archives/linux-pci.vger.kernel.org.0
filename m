Return-Path: <linux-pci+bounces-41954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93120C8141E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B962B3A2242
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2573128C7;
	Mon, 24 Nov 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmPbW03b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374330EF7F;
	Mon, 24 Nov 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997117; cv=none; b=CFyMHm+i5pPEhboY6dHoPNOP4IjSNH+/Rh8u9wN78dG5aouBWNFl+01dAl/J2O+eoA6kh4QSeuPS4h2/2hibTehkdwh3Pg7y33ektVGEV5LUExXr5HXDm/pOAArripiG3a2DLZGUhpx6c9tvCyDC3Y7gUggTvQ3rqz9WBzSTI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997117; c=relaxed/simple;
	bh=iYV3kHmwZG0OS+2IMGK7zneHde118X7fAdxK7JPNX8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAa3PnBD+eSeNdk/F3CdPu6o53vVDgsYy3JaVbRpcgjhTjQ37ikbClwORRpA06ryKfkWwxuczyCKgAeITvIQq/OjDUOLQ1j0iuGjuvdrLYzXQGLmBsgmD/aiPo8vgG5Ufp1Ba4hly8C5GtZZ5J16dBdpi7MXdst6o2JmVIiW8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmPbW03b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6F3C116C6;
	Mon, 24 Nov 2025 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763997116;
	bh=iYV3kHmwZG0OS+2IMGK7zneHde118X7fAdxK7JPNX8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmPbW03brJQ1cRaT0AkVIOdCJqtDCoQVGyi1jCtcbZfdIZwsNrNANBh3kv00jWtmk
	 9abW/kMdo0d+AMugud6EJWhw52EFaFk/svj3aDkdMN9YXf9n4DMggWZ2px30iun0w6
	 TuBfH//+JfiCPODK7pIGconcOCHiNUqI3JjoOONnPrfYseir39XtcwB1q7EYzmI2xY
	 g7cWsJMJcdnCZeR65MViHnTvoPHwWC4lDf8kbi4qJWL1uoFJW0g7BUd+FOYvCrQtlu
	 fKFdbsVVILO1E/xqI6MmD6k16Mt+Nt7qKFcAy2BHfDgj6wArt3b3Tr+ZCjAHmtTlub
	 as+cRcEa4bcXw==
Date: Mon, 24 Nov 2025 17:11:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Danilo Krummrich <dakr@kernel.org>, Peter Colberg <pcolberg@redhat.com>,
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
Message-ID: <20251124151152.GC12483@unreal>
References: <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca>
 <20251122185701.GZ18335@unreal>
 <DEFKSDBXEQS0.3C79SP3HEG1OY@kernel.org>
 <20251123063456.GA18335@unreal>
 <DEFZP148A2NK.29G6N1V1SXT8T@kernel.org>
 <20251123111823.GD16619@unreal>
 <20251124135725.GO233636@ziepe.ca>
 <20251124145332.GB12483@unreal>
 <20251124150450.GS233636@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124150450.GS233636@ziepe.ca>

On Mon, Nov 24, 2025 at 11:04:50AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 24, 2025 at 04:53:32PM +0200, Leon Romanovsky wrote:
> > On Mon, Nov 24, 2025 at 09:57:25AM -0400, Jason Gunthorpe wrote:
> > > On Sun, Nov 23, 2025 at 01:18:23PM +0200, Leon Romanovsky wrote:
> > > > > >> That sounds a bit odd to me, what exactly do you mean with "reuse the PF for
> > > > > >> VFIO"? What do you do with the PF after driver unload instead? Load another
> > > > > >> driver? If so, why separate ones?
> > > > > >
> > > > > > One of the main use cases for SR-IOV is to provide to VM users/customers
> > > > > > devices with performance and security promises as physical ones. In this
> > > > > > case, the VMs are created through PF and not bound to any driver. Once
> > > > > > customer/user requests VM, that VF is bound to vfio-pci driver and
> > > > > > attached to that VM.
> > > > > >
> > > > > > In many cases, PF is unbound too from its original driver and attached
> > > > > > to some other VM. It allows for these VM providers to maximize
> > > > > > utilization of their SR-IOV devices.
> > > > > >
> > > > > > At least in PCI spec 6.0.1, it stays clearly that PF can be attached to SI (VM in spec language).
> > > > > > "Physical Function (PF) - A PF is a PCIe Function that supports the SR-IOV Extended Capability
> > > > > > and is accessible to an SR-PCIM, a VI, or an SI."
> > > > > 
> > > > > Hm, that's possible, but do we have cases of this in practice where we bind and
> > > > > unbind the same PF multiple times, pass it to different VMs, etc.?
> > > > 
> > > > It is very common case, when the goal is to maximize hardware utilization.
> > > 
> > > It is a sort of common configuration, but VFIO should be driving the
> > > PF directly using its native SRIOV support. There is no need to rebind
> > > a driver while SRIOV is still enabled.
> > 
> > It depends on how you created these VFs. If you created them through
> > native driver, you will need to unbind and bind it to VFIO.
> 
> That should not be done or encouraged.

Maybe, but this is how it is done now.

Thanks

> 
> Jason

