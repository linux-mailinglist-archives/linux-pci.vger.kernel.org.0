Return-Path: <linux-pci+bounces-30996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A66AEC704
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 14:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389CE6E01B6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C05246775;
	Sat, 28 Jun 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4aGT9r+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788512F1FF1;
	Sat, 28 Jun 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751112796; cv=none; b=GeQcEyL6eAnZIG2zkYRCMAGHtEc8yfi/k605N3ow9mYgoby8d8gKiCLkRMT5GAs1o/kNliQlqAbpbwHnkoXOOwLXVaQU+4CSNe+c7PhDaeqsLL3MwlQ+YrAf8D1x/VUJSETdZR4y297g/zgCy7i9c8giK0PQn9a/0lmC8qzjWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751112796; c=relaxed/simple;
	bh=4hVx8Zebvf3phZoCLzuTJOPQggGs+Xb1sgBaGSs/HZQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fxreJyfIC+tCw+7P20jtf6CjyuDZ3a6yYyTp1eX3ExFiUIos9TaZUXYDe3fD8N/HS1IBc155VF6eODG4u0Bzhk8s2FjslH0uffasNdrdMPF9V67Y7g5RlpJkUsKSUwbcAaPXrLVvAFY8Ng+LIyictsMyqHUHFK+41YTHj6xexJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4aGT9r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECAEC4CEEA;
	Sat, 28 Jun 2025 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751112795;
	bh=4hVx8Zebvf3phZoCLzuTJOPQggGs+Xb1sgBaGSs/HZQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=T4aGT9r+49qyah52Rxu7BcYcFgiJHIidIZbDpuUl/6MxdiJW3k3/fYm1Aays1vZXB
	 aNWKutpFOuQ0x99lBfpu9FpyIxSCgrf9vDombqyvNGX0UHZICJnn4YXF1jxzc5tlyx
	 3FCZVA4o2s7Vsg6SLX2pebOHwCU1PQ+KDMqD6e8qYuFrqprxgJp6gjk0utzW/qYV0+
	 vUG+uD2QDqf3Sl9S9zDv+gwUonwIeKJ8E/z82jaaYIVC5rgXrT+eT7o0OTD5vm+a65
	 ot5qZivLPRZsVcIzd9ljaXK/FFCPi4WIXEtigjTYMCTmsMqsyiLU1B05jGE1We1lU+
	 /6Mw4UywH90KQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 14:13:08 +0200
Message-Id: <DAY5ODJ7ZPWY.24OXGYED4EAK9@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org> <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae> <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>
 <aF8V8hqUzjdZMZNe@tardis.local> <DAXXVXNTRLYH.1B8O2LKBF4EW1@kernel.org>
 <aF-N-luMxFTurl91@Mac.home> <DAY059Y669BX.2GVKH6RBG80B6@kernel.org>
 <aF-83Tb4-Sxz_KFk@pollux>
In-Reply-To: <aF-83Tb4-Sxz_KFk@pollux>

On Sat Jun 28, 2025 at 11:58 AM CEST, Danilo Krummrich wrote:
> On Sat, Jun 28, 2025 at 09:53:06AM +0200, Benno Lossin wrote:
>> Hmm @Danilo, do you have any use-cases in mind or already done?
>
> There may be other use-cases, but the one that I could forsee is very spe=
cific:
>
> A Registration type that carries additional reference-counted data, where=
 the
> Registration should be released exactly when the device is unbound, indep=
endent
> of the lifetime of the data.
>
> Obviously, this implies that the ForeignOwnable is an Arc.
>
> With KBox, Release and Drop are pretty much identical, so using
> devres::release() instead, is much simpler and hence what we do for all s=
imple
> class device registrations.
>
> Besides that, the use-case described above can also be covered by Devres =
with
> the pin-init rework, by having the Registration  embed a Devres<Inner>, w=
hich
> is what irq::Registration does and I also do in the MiscDeviceRegistratio=
n
> patches.
>
> Hence, I already considered dropping this patch -- and I think we should =
do this
> for now.

Sounds good! We can always pick it up again when needed.

---
Cheers,
Benno

