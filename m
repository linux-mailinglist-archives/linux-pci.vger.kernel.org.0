Return-Path: <linux-pci+bounces-30867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D1AEAA42
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BBB188ED79
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB3224B12;
	Thu, 26 Jun 2025 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQBZ7/Ak"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05145223322;
	Thu, 26 Jun 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979619; cv=none; b=ihYGT+nNrhGcCiSrF2eRtRoiHSVurYlggQpuKBndD/Vmbs2M7c4q3t4nBmj44WZgjzEAzJWoIZe/D4fiwpv7SHHVSOkbRvp81U7oz+ftKr+o0/TPcpmNUi1cEXHKD36nqeBL28HItrd2hMIsDahpipLtcmxJGt72UgflYhJujno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979619; c=relaxed/simple;
	bh=GAx4b9mdacpspxiFCpFqQmTBLm5dawbk6+z2lPMGQik=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pky7OhgKmidf3nXu8F/rRgiigaSRmd5obBr6TvotylYiaIlLnGyjXZ8G96fFPicQQkWurM65z8fG20QaVehrN8M6KO9j3M8l+ocL+iXpV7n7J2qHd+Y69MADROVafKYC7xQpt+1IioV+1DctP9l7LqYKvKTXNTGGZ/OvHCL1QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQBZ7/Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011AAC4CEEB;
	Thu, 26 Jun 2025 23:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750979616;
	bh=GAx4b9mdacpspxiFCpFqQmTBLm5dawbk6+z2lPMGQik=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KQBZ7/AkWQRwsBH6nyLtKh9lonpd2nNFUHBgpPsPA0mduz+FU1zhQ788a0P+4HAFQ
	 693yqbv5caw6sntzfUk8pRxY34t2zKDbbYe9hIWDfqOSphWqLKO1DFXmdT/h+BeUEh
	 WQXOKAyjiMz/0E4FCCsgOFZogPddNtIiEPpEjUZXzamEJyuJcoqGlwuPpUIILsWovc
	 VZZVroSgLWiHSkJ17Z4kIFrRXKhhOcDwvJq7i37QifcYRGcPI10R00ZXlNROIWQ6Lc
	 8/YzoKy+ixk5Co8YlCkw4j33kYo0nvWINHiu9xWEwC3FH+IBLJ2W2AOSrPrROIMSFU
	 TfRHWY8Wc6yPA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 01:13:30 +0200
Message-Id: <DAWUGWHZALC1.2FJDIDRG325F@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-5-dakr@kernel.org>
 <DAWED7BIC32G.338MXRHK4NSJG@kernel.org> <aF0rzzlKgwopOVHV@pollux>
 <aF1TEuotIIwcKODM@cassiopeiae> <DAWJL7B9577H.3HY4CULLAHGCU@kernel.org>
 <aF1oA8jYZGjTs9U4@cassiopeiae> <aF1sEnxdJaVeBZ3x@cassiopeiae>
In-Reply-To: <aF1sEnxdJaVeBZ3x@cassiopeiae>

On Thu Jun 26, 2025 at 5:49 PM CEST, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 05:32:25PM +0200, Danilo Krummrich wrote:
>> On Thu, Jun 26, 2025 at 04:41:55PM +0200, Benno Lossin wrote:
>> > On Thu Jun 26, 2025 at 4:02 PM CEST, Danilo Krummrich wrote:
>> > > On Thu, Jun 26, 2025 at 01:15:34PM +0200, Danilo Krummrich wrote:
>> > >> On Thu, Jun 26, 2025 at 12:36:23PM +0200, Benno Lossin wrote:
>> > >> > Or, we could change `Release` to be:
>> > >> >=20
>> > >> >     pub trait Release {
>> > >> >         type Ptr: ForeignOwnable;
>> > >> >=20
>> > >> >         fn release(this: Self::Ptr);
>> > >> >     }
>> > >> >=20
>> > >> > and then `register_release` is:
>> > >> >=20
>> > >> >     pub fn register_release<T: Release>(dev: &Device<Bound>, data=
: T::Ptr) -> Result
>> > >> >=20
>> > >> > This way, one can store a `Box<T>` and get access to the `T` at t=
he end.
>> > >>=20
>> > >> I think this was also the case before? Well, it was P::Borrowed ins=
tead.
>> > >>=20
>> > >> > Or if they store the value in an `Arc<T>`, they have the option t=
o clone
>> > >> > it and give it to somewhere else.
>> > >>=20
>> > >> Anyways, I really like this proposal of implementing the Release tr=
ait.
>> > >
>> > > One downside seems to be that the compiler cannot infer T anymore wi=
th this
>> > > function signature.
>> >=20
>> > Yeah... That's a bit annoying.
>> >=20
>> > We might be able to add an associated type to `ForeignOwnable` like
>> > `Target` or `Inner` or whatever.
>>=20
>> I think we already have `PointedTo` [1]? But I remember that I've seen a=
 patch
>> to remove it again [2].
>
> Well, not exactly, I think. Arc, for instance, defines PointedTo as ArcIn=
ner<T>.
> So, I think we indeed want something different.

Yeah `PointedTo` is used to specify the type of the foreign pointer and
should go away soon.

---
Cheers,
Benno

