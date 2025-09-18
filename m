Return-Path: <linux-pci+bounces-36452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6579B87625
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 01:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665063A6D3C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE9A2FDC56;
	Thu, 18 Sep 2025 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3GRVP/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116962FD7BB;
	Thu, 18 Sep 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237996; cv=none; b=Ei18vWLWQFjMntLTLTBUODjceesCx6xQ/gmHkZJpbs37+UllbalqXLFmdd8TBSdcNW2KEVa9e2A25w/LsvgGUZeKWyPzvAvESbYdifBGdcrxaLZFyUd6z60FYpDBs6q9oC/nlPiyyxzH+CFjWzleDxbbjOGCOcYWvOxKvoVBn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237996; c=relaxed/simple;
	bh=7e0BmhQlax3vKHRMXklUXCvkMD5m+wcQAKtV8rFifNo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HcfkcNWpxQAxQhGC9BV9MaaWawbjxTfbqP+gz/YO74Qzd+5rMMe0/MpbjPL+/yCnL1y40cEWfORbrrnOCPW3BZM2jBGNQ74E0XvdFjK3aNVV+qenDXHtlduE5xla5uIWwiBJ/DUbCEHt6NQ+7fPGrMQ26FZS5SXPsdbL1+kYbLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3GRVP/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F31C4CEE7;
	Thu, 18 Sep 2025 23:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758237995;
	bh=7e0BmhQlax3vKHRMXklUXCvkMD5m+wcQAKtV8rFifNo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=g3GRVP/fMiDLs8SrgYZOhl9jy5t2pF8+CSN0OHLv61k8zVISrE5NITmZTjEt2lN5l
	 C7H5ZGrozptp778WXoDN11tQQ02hYNgAPqVSiIl9zCkNqzTWnih1XdqIQGyVHs15fW
	 in9mcaNgtvlyU8+F8JHZVFeiviE8dv+s1h9l2e1s8576JbWyR6RijXS2vNB6JBCzUl
	 lX8U32LF2gWo2WvW4NbP4j3cAnm6JaxuC3QlAklvERctRrjL7mjszXMRFLFlhPwIBO
	 04xA5nzrv1GM4I8CnXERlRwciVxcSIP0NXerY9eG6AdPvpDl7FGSOOJlWIKyf5ASSa
	 CIbUadpa7CweA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Sep 2025 01:26:28 +0200
Message-Id: <DCWBCL9U0IY4.NFNUMLRULAWM@kernel.org>
Subject: Re: [PATCH] rust: io: use const generics for read/write offsets
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250918-write-offset-const-v1-1-eb51120d4117@google.com>
 <20250918181357.GA1825487@joelbox2>
In-Reply-To: <20250918181357.GA1825487@joelbox2>

On Thu Sep 18, 2025 at 8:13 PM CEST, Joel Fernandes wrote:
> On Thu, Sep 18, 2025 at 03:02:11PM +0000, Alice Ryhl wrote:
>> Using build_assert! to assert that offsets are in bounds is really
>> fragile and likely to result in spurious and hard-to-debug build
>> failures. Therefore, build_assert! should be avoided for this case.
>> Thus, update the code to perform the check in const evaluation instead.
>
> I really don't think this patch is a good idea (and nobody I spoke to thi=
nks
> so). Not only does it mess up the user's caller syntax completely, it is =
also

I appreacite you raising the concern, but I rather have other people speak =
up
themselves.

> super confusing to pass both a generic and a function argument separately=
.

Why? We assert that the offset has to be const, whereas the value does not
have this requirement, so this makes perfect sense to me.

(I agree that it can look unfamiliar at the first glance though.)

> Sorry if I knew this would be the syntax, I would have objected even when=
 we
> spoke :)
>
> I think the best fix (from any I've seen so far), is to move the bindings
> calls of offending code into a closure and call the closure directly, as =
I
> posted in the other thread. I also passed the closure idea by Gary and he
> confirmed the compiler should behave correctly (I will check the code gen
> with/without later). Gary also provided a brilliant suggestion that we ca=
n
> call the closure directly instead of assigning it to a variable first. Th=
at
> fix is also smaller, and does not screw up the users. APIs should fix iss=
ues
> within them instead of relying on user to work around them.

This is not a workaround, this is an idiomatic solution (which I probably s=
hould
have been doing already when I introduced the I/O code).

We do exactly the same thing for DmaMask::new() [1] and we agreed on doing =
the
same thing for Alignment as well [2].

[1] https://rust.docs.kernel.org/kernel/dma/struct.DmaMask.html#method.new
[2] https://lore.kernel.org/rust-for-linux/20250908-num-v5-1-c0f2f681ea96@n=
vidia.com/

