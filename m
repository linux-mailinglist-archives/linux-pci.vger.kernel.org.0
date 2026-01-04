Return-Path: <linux-pci+bounces-43972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D2CF1012
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 14:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C992730109A8
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556230DEC6;
	Sun,  4 Jan 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNHQGCY0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DF30DEA6;
	Sun,  4 Jan 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534019; cv=none; b=lQuJxEvDGxc7WwigPv+SkQvJD0lV/rzziH5RmxkQdlyB6CJk697oBlvFf2g/ZPE76ajGv3e6XSKxRVQ6RglXnV56K3N3pryna/6I+7bpLTjLCAuBsU++Ee5Vpk3zaAFWfIepbkp3sxdHvn8RHzKhQwrWpLB4fMdIvevkaFBvYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534019; c=relaxed/simple;
	bh=Z2VGlYyYUHFlKtSsJgRkEw0ceh6+lpLFEiUlqnaHrQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=t7i1rp4J8fY7u2W+fQpQPt1ITV2Fwmynkgv/pzCVidwKugLhIeSfx3iy5nWDXF/LBTlFpIRlhEbPZX83wY5asfOJDCLKoxE4n/NZ9o2Ma1qWImoTk3aXdoHgnW4c/T2MTOJCVDfTJeuOy1YSUHvbjF9hYltyEUE+yRIwuy0qC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNHQGCY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D60DC4CEF7;
	Sun,  4 Jan 2026 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534019;
	bh=Z2VGlYyYUHFlKtSsJgRkEw0ceh6+lpLFEiUlqnaHrQQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uNHQGCY0eZEX9iadyBv6v60xhqKRsxxo/YHkPsdMeCrL1xCRd4GnFQOQKH/Z8dKuw
	 jyQy6w50QzkZFVh2vz5xrQASJs7iDUpvtIAJFbTjOZV7EPpPYS2Zd7/RyajiLmUR0m
	 sIKJrGTxddBjrT28oTi9gOAOW+tC0KCSrojbTIz6vUy8HTQ/T0baSIed0T95zRFEjh
	 94rCkyFGMTcSVQwa10CoNiVS5mbuFltiCLMm7O2q6d6fwj//YACxnuGvbbSI7J9ySf
	 W49arSBTEqDsNxpnzU7zJF7OKiT/1yLcg8Un3k7LokBgXTG1TT4Pyh87LauQ9bSIsS
	 R7Sc2VgMZRMUA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Jan 2026 14:40:14 +0100
Message-Id: <DFFUIKLNVQB6.3UDMOX8TB5XDQ@kernel.org>
Subject: Re: [PATCH] rust: pci: add HeaderType enum and header_type() helper
Cc: "SeungJong Ha via B4 Relay"
 <devnull+engineer.jjhama.gmail.com@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: =?utf-8?q?=ED=95=98=EC=8A=B9=EC=A2=85?= <engineer.jjhama@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260103-add-rust-pci-header-type-v1-1-879b4d74b227@gmail.com>
 <DFF1Y5LEQ85Q.V2AC0R1EFXNZ@kernel.org>
 <CAGAB6648kOCF4GZV=wKUxEptzW_91BySPMqFSjE+L-TA3ufH-g@mail.gmail.com>
In-Reply-To: <CAGAB6648kOCF4GZV=wKUxEptzW_91BySPMqFSjE+L-TA3ufH-g@mail.gmail.com>

On Sat Jan 3, 2026 at 4:39 PM CET, =ED=95=98=EC=8A=B9=EC=A2=85 wrote:
> 2026=EB=85=84 1=EC=9B=94 4=EC=9D=BC (=EC=9D=BC) AM 12:17, Danilo Krummric=
h <dakr@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> On Sat Jan 3, 2026 at 3:38 PM CET, SeungJong Ha via B4 Relay wrote:
>> > This is my first patch to the Linux kernel, specifically targeting the
>> > Rust PCI subsystem.
>>
>> Thanks for your contribution!
>>
>> > This patch introduces the HeaderType enum to represent PCI configurati=
on
>> > space header types (Normal and Bridge) and implements the header_type(=
)
>> > method in the Device struct.
>>
>> We usually do not add dead code in the kernel. Do you work on a user for=
 this
>> API?
>
> Hi Danilo, Thanks for your feedback.
>
> Yes, I am currently developing a Rust-based driver for nvme and ixgbe dev=
ices,
> which requires identifying the header type to check compatibility on
> initialization.
> I sent this patch first as it provides a foundational API for the PCI
> abstraction.

As Miguel also pointed out in his reply, I'd like to see a patch series wit=
h the
driver as an RFC patch.

If it is working, not too far from an "upstreamable" state and the subsyste=
m
maintainers of the driver's target subsystem are indicating willingness to
eventually take the driver, I'm happy to go ahead and merge any dependencie=
s.

- Danilo

