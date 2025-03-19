Return-Path: <linux-pci+bounces-24066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2EA68171
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 01:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C61189C247
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 00:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C823AC1C;
	Wed, 19 Mar 2025 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YEMEirML"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C733985;
	Wed, 19 Mar 2025 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343843; cv=none; b=lPO7c6vn5MK7KLkAQS0dZK7/d/5WnIdXkGU1CDM0gHTk8pZyKjx9K2IwnqSK/NMfNd0RDTQONQY0ZmvF7p7zT99GuDoDXYZsAubVJ3d6u3ZVK5spbHBtK5GD9dN6WvBlBbeF13wQlp/wsMbEEXfqJEBpHOlayMKxMsRCUbaIXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343843; c=relaxed/simple;
	bh=kpwPorho5RAIlOTKwDI1K7TbUtmkZgLv9uf70GDbAzs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZGQAxIv+eYoX4+1n7FLD2cbFFMMIgH6QHbvCu/qOb7dD5vXizmFvZMppYXJ7wS2ASTYeMI4pLCmwRf5PGF296X28T5aJjjYIzpZ/njsbS0Z/798O6yWJ2XORJX3dj4g+aeetGM7COmOaaTVMr/38On2EVnNWXJJychXnSZHncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YEMEirML; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742343831; x=1742603031;
	bh=wo8sG357bqPQGvo1ptE/J2DUrCHu4PLnYcZXmvZkOVg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YEMEirML/9gSZoY4uHrogBNTNvxEpxE0nxlVpywtlo14E0NRo4sgzUeJN1ICHW9iO
	 Hs+62Ze9ETjQBTJTeuLI5K2hdmXC8SZpKd5BbjGLL6946MWSFePjzutamwGquo5qet
	 kM5QtFDwNf4PGYH1yp70Gmcz0yrnE7oE2IfwKBlovHoFVkizndoKrRkJMIzZz08SKV
	 6dV2+9PXQLkSRDJI7R1Td2XFN2wrvwQ1TY8VT+XnnuA+SE4kcXiQd9q9QSmfpA92bx
	 Msx0AQFyXojGx3yE4tSzDjoUxLfRmylGQ7lyudT44w8+wb4hMqwdyzddxqNdSFsmxt
	 HszvOGsn/Ha3Q==
Date: Wed, 19 Mar 2025 00:23:44 +0000
To: Alice Ryhl <aliceryhl@google.com>, Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
Message-ID: <D8JTC30W0NF6.17SR73Y9I99ZT@proton.me>
In-Reply-To: <Z9lnIJCcVSza6UVo@google.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <Z9lnIJCcVSza6UVo@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3ec742d730499fbb39dfc15a00acc0e43da941a3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 18, 2025 at 1:29 PM CET, Alice Ryhl wrote:
> On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
>> Throughout the tree, use the strict provenance APIs stabilized in Rust
>> 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
>> functions at the `kernel` crate root along with polyfills for rustc <
>> 1.84.0.
>>=20
>> Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
>> 1.84.0 as our MSRV is 1.78.0.
>>=20
>> In the `kernel` crate, enable the strict provenance lints on rustc >=3D
>> 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
>> compiler flags that are dependent on the rustc version in use.
>>=20
>> Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-prov=
enance-apis [1]
>> Suggested-by: Benno Lossin <benno.lossin@proton.me>
>> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
>> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> I'm not convinced that the pros of this change outweigh the cons. I
> think this is going to be too confusing for the C developers who look at
> this code.

1) I think we should eliminate all possible `as` conversions. They are
   non-descriptive (since they can do may *very* different things) and
   ptr2int conversions are part of that.
2) At some point we will have to move to the provenance API, since
   that's what Rust chose to do. I don't think that doing it at a later
   point is doing anyone a favor.
3) I don't understand the argument that this is confusing to C devs.
   They are just normal functions that are well-documented (and if
   that's not the case, we can just improve them upstream). And
   functions are much easier to learn about than `as` casts (those are
   IMO much more difficult to figure out than then strict provenance
   functions).

Thus I think we should keep this patch (with Boqun's improvement).

>> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> index 719b0a48ff55..96393bcf6bd7 100644
>> --- a/rust/kernel/uaccess.rs
>> +++ b/rust/kernel/uaccess.rs
>> @@ -226,7 +226,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8=
>]) -> Result {
>>          }
>>          // SAFETY: `out_ptr` points into a mutable slice of length `len=
`, so we may write
>>          // that many bytes to it.
>> -        let res =3D unsafe { bindings::copy_from_user(out_ptr, self.ptr=
 as *const c_void, len) };
>> +        let res =3D unsafe {
>> +            bindings::copy_from_user(out_ptr, crate::with_exposed_prove=
nance(self.ptr), len)
>> +        };
>>          if res !=3D 0 {
>>              return Err(EFAULT);
>>          }
>> @@ -264,7 +266,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
>>          let res =3D unsafe {
>>              bindings::_copy_from_user(
>>                  out.as_mut_ptr().cast::<c_void>(),
>> -                self.ptr as *const c_void,
>> +                crate::with_exposed_provenance(self.ptr),
>>                  len,
>>              )
>>          };
>
> That's especially true for cases like this. These are userspace pointers
> that are never dereferenced. It's not useful to care about provenance
> here.

I agree for this case, but I think we shouldn't be using raw pointers
for this to begin with. I'd think that a newtype wrapping `usize` is a
much better fit. It can then also back the `IoRaw` type. AFAIU user
space pointers don't have provenance, right? (if they do, then we should
use this API :)

---
Cheers,
Benno


