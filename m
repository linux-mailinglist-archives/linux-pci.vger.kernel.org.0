Return-Path: <linux-pci+bounces-31936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A541B0200A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 17:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4475E54059A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76C2DCF76;
	Fri, 11 Jul 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc1SAK/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22A2D78A;
	Fri, 11 Jul 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246238; cv=none; b=Xl2J3m/ooN9tNx37Pv9ezsPAKYwWePgc5UeBvdRtJ46eMnhzf1HE7jK9a7PA7TMiFCm6gWYmAs6kC9C2eYZb3sGZSmG9Ye2u9E2sp75C3Vv5YRdrgovSZ5D977Ac2edI8ckrHMr0Q/x0l4dDd7EErFvEe+2oxXPNVPoOzPm6HQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246238; c=relaxed/simple;
	bh=cn9YT0hTSit/sXKh1ro5Ac5VGLhmBnv3EcIULHqVN7A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EzUVBZjsFZ73kPlnW+VMoIj85ql8Pl3LxG+kkgea3A8OzlNCvbjxiQcHVc3D/w6VwFF2PHPTSjig0UW7Zn+5Gguki3wK4Jqk2eecTlaq9WfoopZ+vJxnq4Ub/bW/1TzgUC8MQXOT7WU96IwJn5Vrxjh6wNqJglLHGexewPUtY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc1SAK/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E465C4CEED;
	Fri, 11 Jul 2025 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752246237;
	bh=cn9YT0hTSit/sXKh1ro5Ac5VGLhmBnv3EcIULHqVN7A=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=nc1SAK/zmVNe4YloJX4E/Ve2GrT2e1Z/Y+9f2NLe1yQDw+cUq7/P3lJANJG1tcbiZ
	 eGd0kvptqyGh69ky6amoWcDEbuuvBB607Ds/AWKFGQB444OlotoRF4GfpvghU06yZY
	 hBwp9WQVbD+vl7E0zo1+IY2Od+TAgZQI+WfyEiGsrLBFCaDURm7bIz8PY6eN1dix1c
	 t1nEtxx9JAhRlF/UwpUwaMpHAS9mMSc5sjV03HrMeBoQJGDxWL6QCPl0cy/alQCDCQ
	 TC6QXzawwyuBmk7xiHfpoMjcMlstsy8ndvNK3PrSfb8Lg2QM1Qj/Khz3fGvwDQMonS
	 XYijSGjQBsZJg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 17:03:52 +0200
Message-Id: <DB9BG6DSV693.39JY1VAOQSUMZ@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
Cc: "Benno Lossin" <lossin@kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <cgh5cj42vkxc66f2utpa3eznvqaqtdo3gszahfhempujj3kxdc@zaor2sx4cosp>
In-Reply-To: <cgh5cj42vkxc66f2utpa3eznvqaqtdo3gszahfhempujj3kxdc@zaor2sx4cosp>

On Fri Jul 11, 2025 at 1:22 AM CEST, Alistair Popple wrote:
> On Thu, Jul 10, 2025 at 10:01:05AM +0200, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
>> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> > index 8435f8132e38..5c35a66a5251 100644
>> > --- a/rust/kernel/pci.rs
>> > +++ b/rust/kernel/pci.rs
>> > @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>> > =20
>> >  impl Device {
>> >      /// Returns the PCI vendor ID.
>> > +    #[inline]
>> >      pub fn vendor_id(&self) -> u16 {
>> > -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_=
dev`.
>> > +        // SAFETY: by its type invariant `self.as_raw` is always a va=
lid pointer to a
>>=20
>> s/by its type invariant/by the type invariants of `Self`,/
>> s/always//
>>=20
>> Also, which invariant does this refer to? The only one that I can see
>> is:
>>=20
>>     /// A [`Device`] instance represents a valid `struct device` created=
 by the C portion of the kernel.
>
> Actually isn't that wrong? Shouldn't that read for "a valid `struct pci_d=
ev`"?

Yes, and it's fixed in the driver-core tree already. :)

