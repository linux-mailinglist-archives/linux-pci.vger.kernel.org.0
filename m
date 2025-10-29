Return-Path: <linux-pci+bounces-39690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB3C1C58D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA4B188EB15
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840433A036;
	Wed, 29 Oct 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sis5XiZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B923A994;
	Wed, 29 Oct 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757371; cv=none; b=fnfMYSn5xqaz2qoqbumG8gi0ufVEU9gk+mY0zyLhoCoLalLu1eJaCtXHs8ODSS7/UtMC2AEYYWvM5rA4ZIIJb7WVJAPr4zE3smkGzjO3ljP6VR5q1jqbVCzHD9KWe2NuKInULDslmi1oM9Cm92p3pxiZfSoG4D8SSPznqBpHlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757371; c=relaxed/simple;
	bh=UnDARnYIG3wueo5oOGgTK3bYf/ken2YDQuLHjxtY2Zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sR6rASFTVjqT2efml6YeoxKeKCmSv1Wgx0iIFA+RmHk3igejOucaXqBotKrBY7wHJnFxzR2TmmbMAAmiBZnGFz3cyn++xMJEZ0SThDxtI1KOA0eamkdzcfksupdVY0efNLsFno6bnXbzMXl1vd45Es/8lHEsI5dMZpMfBi3Aeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sis5XiZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF496C4CEF7;
	Wed, 29 Oct 2025 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757370;
	bh=UnDARnYIG3wueo5oOGgTK3bYf/ken2YDQuLHjxtY2Zc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=sis5XiZUF3cBmnMfqRMDyTQ8k+5kwHcKlIM8duFrUaVYVDRlZJr+YLBuEyK53AZbe
	 CeSpPbi7+GzarNtWHjmPymX8PgYJlbzXYD0eCPI7CUpZbmUpw6fVh6dmTAOSTdhfDh
	 OWW7HUczdIXyIjOHQBgPNqlilJcaot8nc992Un5cHpXUH2OtWrxWduWFkeJjG5K76R
	 CJJoTl/TA2d1MMdtwrVhG9YItTff39DlqMN9o7zdKvvXcldOd/SfBWI5Pnnf2g98i8
	 LIgjd/hNXuexhFOo/DtDI9rxiH1UZcJDtFeQRQGzWBnmz7c4Wks6zX1sAgqxUv+1QS
	 2fI510xQVnB1Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 18:02:45 +0100
Message-Id: <DDUYV4ETTD50.3UCGLW45AK740@kernel.org>
Subject: Re: [PATCH 2/8] rust: device: introduce Device::drvdata()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <pcolberg@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
 <20251020223516.241050-3-dakr@kernel.org> <aQIPvaFJIXySV-Q5@google.com>
 <DDUWW90NZIDY.2TVA8S0RDSXZJ@kernel.org>
In-Reply-To: <DDUWW90NZIDY.2TVA8S0RDSXZJ@kernel.org>

On Wed Oct 29, 2025 at 4:30 PM CET, Danilo Krummrich wrote:
> On Wed Oct 29, 2025 at 1:59 PM CET, Alice Ryhl wrote:
>> Are you going to open that docs PR to the Rust compiler about the size
>> of TypeID that we talked about? :)
>
> Yes, I will -- thanks for the reminder.
>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>
>>> +// Compile-time checks.
>>> +const _: () =3D {
>>> +    // Assert that we can `read()` / `write()` a `TypeId` instance fro=
m / into `struct driver_type`.
>>> +    static_assert!(core::mem::size_of::<bindings::driver_type>() =3D=
=3D core::mem::size_of::<TypeId>());
>>> +};
>>
>> You don't need the "const _: ()" part. See the definition of
>> static_assert! to see why.
>
> Indeed, good catch -- same for the suggestions below.
>
>> Also, I would not require equality. The Rust team did not think that it
>> would ever increase in size, but it may decrease.
>>
>>>  /// The core representation of a device in the kernel's driver model.
>>>  ///
>>>  /// This structure represents the Rust abstraction for a C `struct dev=
ice`. A [`Device`] can either
>>> @@ -198,12 +204,29 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
>>>  }
>>> =20
>>>  impl Device<CoreInternal> {
>>> +    fn type_id_store<T: 'static>(&self) {
>>
>> This name isn't great. How about "set_type_id()" instead?

Here's the diff, including a missing check in case someone tries to call
Device::drvdata() from probe().

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 36c6eec0ceab..1a307be953c2 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -17,11 +17,8 @@

 pub mod property;

-// Compile-time checks.
-const _: () =3D {
-    // Assert that we can `read()` / `write()` a `TypeId` instance from / =
into `struct driver_type`.
-    static_assert!(core::mem::size_of::<bindings::driver_type>() =3D=3D co=
re::mem::size_of::<TypeId>());
-};
+// Assert that we can `read()` / `write()` a `TypeId` instance from / into=
 `struct driver_type`.
+static_assert!(core::mem::size_of::<bindings::driver_type>() >=3D core::me=
m::size_of::<TypeId>());

 /// The core representation of a device in the kernel's driver model.
 ///
@@ -204,7 +201,7 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
 }

 impl Device<CoreInternal> {
-    fn type_id_store<T: 'static>(&self) {
+    fn set_type_id<T: 'static>(&self) {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid poin=
ter to a `struct device`.
         let private =3D unsafe { (*self.as_raw()).p };

@@ -226,7 +223,7 @@ pub fn set_drvdata<T: 'static>(&self, data: impl PinIni=
t<T, Error>) -> Result {

         // SAFETY: By the type invariants, `self.as_raw()` is a valid poin=
ter to a `struct device`.
         unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreig=
n().cast()) };
-        self.type_id_store::<T>();
+        self.set_type_id::<T>();

         Ok(())
     }
@@ -242,6 +239,9 @@ pub unsafe fn drvdata_obtain<T: 'static>(&self) -> Pin<=
KBox<T>> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid poin=
ter to a `struct device`.
         let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };

+        // SAFETY: By the type invariants, `self.as_raw()` is a valid poin=
ter to a `struct device`.
+        unsafe { bindings::dev_set_drvdata(self.as_raw(), core::ptr::null_=
mut()) };
+
         // SAFETY:
         // - By the safety requirements of this function, `ptr` comes from=
 a previous call to
         //   `into_foreign()`.
@@ -286,7 +286,7 @@ unsafe fn drvdata_unchecked<T: 'static>(&self) -> Pin<&=
T> {
         unsafe { Pin::<KBox<T>>::borrow(ptr.cast()) }
     }

-    fn type_id_match<T: 'static>(&self) -> Result {
+    fn match_type_id<T: 'static>(&self) -> Result {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid poin=
ter to a `struct device`.
         let private =3D unsafe { (*self.as_raw()).p };

@@ -311,11 +311,16 @@ fn type_id_match<T: 'static>(&self) -> Result {
     /// Returns a pinned reference to the driver's private data or [`EINVA=
L`] if it doesn't match
     /// the asserted type `T`.
     pub fn drvdata<T: 'static>(&self) -> Result<Pin<&T>> {
-        self.type_id_match::<T>()?;
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid poin=
ter to a `struct device`.
+        if unsafe { bindings::dev_get_drvdata(self.as_raw()) }.is_null() {
+            return Err(ENOENT);
+        }
+
+        self.match_type_id::<T>()?;

         // SAFETY:
-        // - The `Bound` device context guarantees that this is only ever =
call after a call
-        //   to `set_drvdata()` and before `drvdata_obtain()`.
+        // - The above check of `dev_get_drvdata()` guarantees that we are=
 called after
+        //   `set_drvdata()` and before `drvdata_obtain()`.
         // - We've just checked that the type of the driver's private data=
 is in fact `T`.
         Ok(unsafe { self.drvdata_unchecked() })
     }


