Return-Path: <linux-pci+bounces-32335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B84B0806B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565B21730F4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5E2857F1;
	Wed, 16 Jul 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZzZYHjdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F7B660;
	Wed, 16 Jul 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704425; cv=pass; b=jrTs0+QzaqnxxMnTZcoAmFdP3VfIJfcnzh9GS1Mngqnpe+nlEnpiBWGQ8cswwrbrGbJ6BFYA4amktNDeu990h3yTkRnrSs/EbwwEyo4UTbCw8sLEGYjxWWCCnViOSZ0D5R+ZkTwuFLvcfBuy6LsPSXHThVmYJ1w1IpKpYcZ8xBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704425; c=relaxed/simple;
	bh=XLAz10fJm0M2WDjFqjMuGQ0/jyAUWasEddiPnbaYKg0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Gll/CI8LYBFEJNlX67PXCCengKTt1NhuLx6A0gVGz03rvd0VlWIcDuyesqdPoAprko8Ha4UtLkjgDvPhw2TvwJO4GOzBzAIjevecZgeNiiybWO/TytkxnPNqAgfeoZAfcJpNwPUdbTTybG+XSK066VGIRhJRHN7+8oOY73OtxAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZzZYHjdR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752704408; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MCsOHQBqDmyB0xMdb5oIXHW5g6hEmP6OQbgfEcXy+z071Jr3JMada5HQqlsH7rW9Br1ugcjbwmy/+6PUNHM3ci10hWacUTLNmfuQACPinKVMkbSD7/6E9wLcxsv7HTBWcjLWvcM49ic8IRtvSTtddf22ZBc5Z6HVczWah9xn6/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752704408; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aNGlI5uY9iUI1y8ST+y6VyPUz18T05UXVF0sqQATIwc=; 
	b=YsSytnJTAXlZ0UFm8TfP6Re6/9XOi/AOez9xu474tZHzW/LDMVgT6E5atXLxcjNkxXcRrYLoHgZ9ZPnC7AN9muPGD7oF61RxXy0ouL5ITnoKHAx/CSco3vggbkv3SM1kl5lf1bLXpqmthZ/sLuuPx5XykXM9tqnT1CAjsKSzJ40=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752704408;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aNGlI5uY9iUI1y8ST+y6VyPUz18T05UXVF0sqQATIwc=;
	b=ZzZYHjdREvMTz6HNghNeUhAnOW0HsBstfXeFUMmFFo2vHqZuYHOcsvBKfA2/G7si
	cStXyfaF0fVs4loTNsgP7ZY4OVmXrbub8jA9HDRxziUhUOs8LLq0pLPnACB/SuXJCMm
	RrutFSGnwdui6Nx+8HUGnMYz0s/GvLAm3DgpCI9w=
Received: by mx.zohomail.com with SMTPS id 1752704406955709.8461993048116;
	Wed, 16 Jul 2025 15:20:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 2/5] rust: dma: add DMA addressing capabilities
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBDSFO1LGSYM.VFQKKLN6BX3H@kernel.org>
Date: Wed, 16 Jul 2025 19:19:49 -0300
Cc: abdiel.janulgue@gmail.com,
 robin.murphy@arm.com,
 a.hindborg@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 bhelgaas@google.com,
 kwilczynski@kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <442B2871-4512-4C5B-A394-C9CA14FF4C3C@collabora.com>
References: <20250716150354.51081-1-dakr@kernel.org>
 <20250716150354.51081-3-dakr@kernel.org>
 <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>
 <DBDO8FVL9NKE.201JEW4MRHS6F@kernel.org>
 <DBDP0BJW9VAZ.5KRU4V4288R8@kernel.org> <DBDSFO1LGSYM.VFQKKLN6BX3H@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

For some reason this diff did not apply on top of your latest commit =
(corrupt
patch on line 6)

>=20
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index afd3ba538e3c..ad69ef316295 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -81,25 +81,6 @@ unsafe fn dma_set_mask_and_coherent(&self, mask: =
DmaMask) -> Result {
> /// never exceed the bit width of `u64`.
> ///
> /// This is the Rust equivalent of the C macro `DMA_BIT_MASK()`.
> -///
> -/// # Examples
> -///
> -/// ```
> -/// use kernel::dma::DmaMask;
> -///
> -/// let mask0 =3D DmaMask::new(0)?;
> -/// assert_eq!(mask0.value(), 0);
> -///
> -/// let mask1 =3D DmaMask::new(1)?;
> -/// assert_eq!(mask1.value(), 0b1);
> -///
> -/// let mask64 =3D DmaMask::new(64)?;
> -/// assert_eq!(mask64.value(), u64::MAX);
> -///
> -/// let mask_overflow =3D DmaMask::new(100);
> -/// assert!(mask_overflow.is_err());
> -/// # Ok::<(), Error>(())
> -/// ```
> #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> pub struct DmaMask(u64);
>=20
> @@ -108,8 +89,27 @@ impl DmaMask {
>     ///
>     /// For `n <=3D 64`, sets exactly the lowest `n` bits.
>     /// For `n > 64`, returns [`EINVAL`].
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::dma::DmaMask;
> +    ///
> +    /// let mask0 =3D DmaMask::try_new(0)?;
> +    /// assert_eq!(mask0.value(), 0);
> +    ///
> +    /// let mask1 =3D DmaMask::try_new(1)?;
> +    /// assert_eq!(mask1.value(), 0b1);
> +    ///
> +    /// let mask64 =3D DmaMask::try_new(64)?;
> +    /// assert_eq!(mask64.value(), u64::MAX);
> +    ///
> +    /// let mask_overflow =3D DmaMask::try_new(100);
> +    /// assert!(mask_overflow.is_err());
> +    /// # Ok::<(), Error>(())
> +    /// ```
>     #[inline]
> -    pub const fn new(n: usize) -> Result<Self> {
> +    pub const fn try_new(n: u32) -> Result<Self> {
>         Ok(Self(match n {
>             0 =3D> 0,
>             1..=3D64 =3D> u64::MAX >> (64 - n),
> @@ -117,6 +117,38 @@ pub const fn new(n: usize) -> Result<Self> {
>         }))
>     }
>=20
> +    /// Constructs a `DmaMask` with the lowest `n` bits set to `1`.
> +    ///
> +    /// For `n <=3D 64`, sets exactly the lowest `n` bits.
> +    /// For `n > 64`, results in a build error.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::dma::DmaMask;
> +    /// use kernel::bits::genmask_u64;

There is also this, which is not upstream (nor used in the patch)

> +    ///
> +    /// let mask0 =3D DmaMask::new::<0>();
> +    /// assert_eq!(mask0.value(), 0);
> +    ///
> +    /// let mask1 =3D DmaMask::new::<1>();
> +    /// assert_eq!(mask1.value(), 0b1);
> +    ///
> +    /// let mask64 =3D DmaMask::new::<64>();
> +    /// assert_eq!(mask64.value(), u64::MAX);
> +    ///
> +    /// // Build failure.
> +    /// // let mask_overflow =3D DmaMask::new::<100>();
> +    /// ```
> +    #[inline(always)]
> +    pub const fn new<const N: u32>() -> Self {
> +        let Ok(mask) =3D Self::try_new(N) else {
> +            build_error!("Invalid DMA Mask.");
> +        };
> +
> +        mask
> +    }
> +
>     /// Returns the underlying `u64` bitmask value.
>     #[inline]
>     pub const fn value(&self) -> u64 {
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 9422ac68c139..c5e7cce68654 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -58,7 +58,7 @@ impl pci::Driver for DmaSampleDriver {
>     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> =
Result<Pin<KBox<Self>>> {
>         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
>=20
> -        let mask =3D DmaMask::new(64)?;
> +        let mask =3D DmaMask::new::<64>();
>=20
>         // SAFETY: There are no concurrent calls to DMA allocation and =
mapping primitives.
>         unsafe { pdev.dma_set_mask_and_coherent(mask)? };
>=20
>=20

I hand-applied this and fixed the issue above. All doctests pass FYI.

=E2=80=94 Daniel



