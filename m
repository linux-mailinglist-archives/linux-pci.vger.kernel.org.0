Return-Path: <linux-pci+bounces-32332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62CFB07F5C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 23:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D823A7B7F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9E27A123;
	Wed, 16 Jul 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5loxSoe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A13BBC9;
	Wed, 16 Jul 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700398; cv=none; b=fMRW2wrUrlr0NrRL1ucLCfPvB0fiUl8RopjuffWPeZPQ0bbWV9Oc9PszZ6qXEyhs8OaMUUeJaBHD8+ojOgrNIYgV9GMXWeMplfEv4N4iMQPE1Fm6r9iWeHA6wEtGTnxbE5Bf6ZarsnZozXFbpA8BH2BufRMGgZ1lQ5/kJxw0+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700398; c=relaxed/simple;
	bh=3+Nm+3rpJ9udGtGWhAgNxdDsrulyxyx4ntvdQn3/zX0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=A4FmWEfSlegGCrc8TbKdCaByTSw7dc0KNmC08Xk5eBVOnfKOgKlLI+swpAMmm7o3818ABaKTb/wXqnp6HRK12VwoIY//AAugDKu/m8Rt1NWoACnoSWvXecAFs+j//gnSGwU8oCPy680LskgceShCbMMPQWdWb/sg6VUffyAB9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5loxSoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DC4C4CEE7;
	Wed, 16 Jul 2025 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752700396;
	bh=3+Nm+3rpJ9udGtGWhAgNxdDsrulyxyx4ntvdQn3/zX0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=i5loxSoe2bYtjVhsajA/B4FKa7PItegKW0/7EwlOWDlMHUdRSPfAQXr+xBzOVjnBg
	 ijLMizD66mVRIxFCXDt1d0R8MY27ieCcP4qeZ4FO7AI+uaoeuznIUdFlHk6LgILYpD
	 rMFu7H8R/HwMWF8D/k2wV7eYfTkpdK6H7EbvnRLIQkOjYwyugYk4ICtt2VhZLSiMQ/
	 EpvBGALlzJOPJR0EHpszJJ8c4Pq9FjjiHIUcSi95rQ8nE0cVhnQwJlH/Jag2us/8V3
	 EbJ3fqWeST9ZeSye9vbD4enW6WH4xVm0LKbWRjLWsE113iR0tCMF/GrQrhVEHpKobS
	 F3xGbyS8fsFvQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 23:13:11 +0200
Message-Id: <DBDSFO1LGSYM.VFQKKLN6BX3H@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: dma: add DMA addressing capabilities
Cc: <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250716150354.51081-1-dakr@kernel.org>
 <20250716150354.51081-3-dakr@kernel.org>
 <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>
 <DBDO8FVL9NKE.201JEW4MRHS6F@kernel.org>
 <DBDP0BJW9VAZ.5KRU4V4288R8@kernel.org>
In-Reply-To: <DBDP0BJW9VAZ.5KRU4V4288R8@kernel.org>

On Wed Jul 16, 2025 at 8:32 PM CEST, Danilo Krummrich wrote:
> On Wed Jul 16, 2025 at 7:55 PM CEST, Danilo Krummrich wrote:
>> On Wed Jul 16, 2025 at 7:32 PM CEST, Daniel Almeida wrote:
>>> Hi Danilo,
>>>
>>>> +    #[inline]
>>>> +    pub const fn new(n: usize) -> Result<Self> {
>>>> +        Ok(Self(match n {
>>>> +            0 =3D> 0,
>>>> +            1..=3D64 =3D> u64::MAX >> (64 - n),
>>>> +            _ =3D> return Err(EINVAL),
>>>> +        }))
>>>> +    }
>>>> +
>>>
>>> Isn=E2=80=99t this equivalent to genmask_u64(0..=3Dn) ? See [0].
>>
>> Instead of the match this can use genmask_checked_u64() and convert the =
Option
>> to a Result, once genmask is upstream.
>>
>>> You should also get a compile-time failure if n is out of bounds by def=
ault using
>>> genmask.
>>
>> No, we can't use genmask_u64(), `n` is not guaranteed to be known at com=
pile
>> time, so we'd need to use genmask_checked_u64().
>>
>> Of course, we could have a separate DmaMask constructor, e.g. with a con=
st
>> generic -- not sure that's worth though.
>
> On the other hand, it doesn't hurt. Guess I will add another constructor =
with a
> const generic. :)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index afd3ba538e3c..ad69ef316295 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -81,25 +81,6 @@ unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMask=
) -> Result {
 /// never exceed the bit width of `u64`.
 ///
 /// This is the Rust equivalent of the C macro `DMA_BIT_MASK()`.
-///
-/// # Examples
-///
-/// ```
-/// use kernel::dma::DmaMask;
-///
-/// let mask0 =3D DmaMask::new(0)?;
-/// assert_eq!(mask0.value(), 0);
-///
-/// let mask1 =3D DmaMask::new(1)?;
-/// assert_eq!(mask1.value(), 0b1);
-///
-/// let mask64 =3D DmaMask::new(64)?;
-/// assert_eq!(mask64.value(), u64::MAX);
-///
-/// let mask_overflow =3D DmaMask::new(100);
-/// assert!(mask_overflow.is_err());
-/// # Ok::<(), Error>(())
-/// ```
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 pub struct DmaMask(u64);

@@ -108,8 +89,27 @@ impl DmaMask {
     ///
     /// For `n <=3D 64`, sets exactly the lowest `n` bits.
     /// For `n > 64`, returns [`EINVAL`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::dma::DmaMask;
+    ///
+    /// let mask0 =3D DmaMask::try_new(0)?;
+    /// assert_eq!(mask0.value(), 0);
+    ///
+    /// let mask1 =3D DmaMask::try_new(1)?;
+    /// assert_eq!(mask1.value(), 0b1);
+    ///
+    /// let mask64 =3D DmaMask::try_new(64)?;
+    /// assert_eq!(mask64.value(), u64::MAX);
+    ///
+    /// let mask_overflow =3D DmaMask::try_new(100);
+    /// assert!(mask_overflow.is_err());
+    /// # Ok::<(), Error>(())
+    /// ```
     #[inline]
-    pub const fn new(n: usize) -> Result<Self> {
+    pub const fn try_new(n: u32) -> Result<Self> {
         Ok(Self(match n {
             0 =3D> 0,
             1..=3D64 =3D> u64::MAX >> (64 - n),
@@ -117,6 +117,38 @@ pub const fn new(n: usize) -> Result<Self> {
         }))
     }

+    /// Constructs a `DmaMask` with the lowest `n` bits set to `1`.
+    ///
+    /// For `n <=3D 64`, sets exactly the lowest `n` bits.
+    /// For `n > 64`, results in a build error.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::dma::DmaMask;
+    /// use kernel::bits::genmask_u64;
+    ///
+    /// let mask0 =3D DmaMask::new::<0>();
+    /// assert_eq!(mask0.value(), 0);
+    ///
+    /// let mask1 =3D DmaMask::new::<1>();
+    /// assert_eq!(mask1.value(), 0b1);
+    ///
+    /// let mask64 =3D DmaMask::new::<64>();
+    /// assert_eq!(mask64.value(), u64::MAX);
+    ///
+    /// // Build failure.
+    /// // let mask_overflow =3D DmaMask::new::<100>();
+    /// ```
+    #[inline(always)]
+    pub const fn new<const N: u32>() -> Self {
+        let Ok(mask) =3D Self::try_new(N) else {
+            build_error!("Invalid DMA Mask.");
+        };
+
+        mask
+    }
+
     /// Returns the underlying `u64` bitmask value.
     #[inline]
     pub const fn value(&self) -> u64 {
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9422ac68c139..c5e7cce68654 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -58,7 +58,7 @@ impl pci::Driver for DmaSampleDriver {
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin=
<KBox<Self>>> {
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");

-        let mask =3D DmaMask::new(64)?;
+        let mask =3D DmaMask::new::<64>();

         // SAFETY: There are no concurrent calls to DMA allocation and map=
ping primitives.
         unsafe { pdev.dma_set_mask_and_coherent(mask)? };


