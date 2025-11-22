Return-Path: <linux-pci+bounces-41917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F9C7D98D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 23:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFE4B4E225C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71325B1D2;
	Sat, 22 Nov 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piaH0agI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E536D4E6;
	Sat, 22 Nov 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763851397; cv=none; b=JhQ7zbPxFB30qqSd8ttR/YTono8eutTIXxi8gyZD7fViKr8Eb6LVODRk7gYUQmEjEj8aSVh3vPip+7KTT8Gtg+/jXEjNWzpvSOotqIky8KU5SGWWdqjl0XGxi/FisLuzzltXYGgpU3f1RHZCfxRM9pTPjzjinl2DUfxxV6H1Tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763851397; c=relaxed/simple;
	bh=paHOAJ6ecATAtdyavbLkTH42WlGJw2dQtjCLRfKd7lQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=m9yZMoP64FB00GSuMJJIYbCLlNMDgK1gCe1U/KhK2RHCYDbrCpml+H6MLw0ySWBDA8wLZNRSAQn//BqgaWLe9tGYDKjNE/2GZAIwVDSVnMgdKCzYHyykWe4Q7dpQwZjaSuziORDeuKBgs0y/r0ttymczLB2/1BBdmHnrjCu4FSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piaH0agI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1375DC4CEF5;
	Sat, 22 Nov 2025 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763851397;
	bh=paHOAJ6ecATAtdyavbLkTH42WlGJw2dQtjCLRfKd7lQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=piaH0agI7xsNXEqya7qJZjFSCCL8lHbytKNdcrxkIPdcyqyOvza6HrJv/mEpqWSs4
	 kZNvRoc2Ajwc7DOdsn9j78h2wddNySdBBp+ZqLNFoyRaUPfFOUiC0zpYC2tJJdYKhK
	 Nhm2EZbZdyKfBRqVJnlAuQUpEUD6CHmZQYSJqCiUfe0lPPeW44x/RbX7F13ZOGF6UO
	 DAnCFJ/REiKYc6tITcRdz8lmHC5DkMBI51xVGPja5HGcFy2ybtovhSaPehipb/LCxa
	 QkkfZUM3KPY+RniGt3rCI+M96mbGHqn4bRSH9ILwyPoFVZayLxQ+Lp5ovHZ+WnckAo
	 svS0ETVLgra0A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Nov 2025 11:43:08 +1300
Message-Id: <DEFL4TG0WX1C.2GLH4417EPU3V@kernel.org>
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
 <20251121232642.GG233636@ziepe.ca> <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca>
In-Reply-To: <20251122161615.GN233636@ziepe.ca>

On Sun Nov 23, 2025 at 5:16 AM NZDT, Jason Gunthorpe wrote:
> I think to make progress along this line you need to still somehow
> validate that the PF driver is working right, either by checking that
> the driver is bound to a rust driver somehow or using the same
> approach as the core helper.

Do you refer to the

	if (pf_dev->driver !=3D pf_driver)

check? If so, that's (in a slightly different form) already part of the gen=
eric
Device::drvdata() accessor.

> I'm not sure the idea to force all drivers to do disable sriov is
> going to be easy, and I'd rather see rust bindings progress without
> opening such a topic..

I'm sorry, I should have mentioned what I actually propose:

My idea would be to provide a bool in struct pci_driver, which, if set,
guarantees that all VFs are unbound when the PF is unbound.

With this bool being set, the PCI bus can provide the guarantee that VF bou=
nd
implies PF bound; the Rust accessor can then leverage this guarantee.

This can also be leveraged by the C code, where we could have a separate
accessor that checks the bool rather than askes the driver to promise that =
the
PF is bound, which pci_iov_get_pf_drvdata() does.

(Although I have to admit that without the additional type system capabilit=
ies
we have in Rust, it is not that big of an improvement.)

