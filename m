Return-Path: <linux-pci+bounces-31741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E8AFDDFB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DFB17E3C9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852A1F1317;
	Wed,  9 Jul 2025 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="crCUzkqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from lovable-gwydion.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.216.144.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A41F948;
	Wed,  9 Jul 2025 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.216.144.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030668; cv=none; b=foANLbep4ra9LRA+WfW7bFk8s6lS5XsspfFHNROduz0DVCLIe/o3+SgLcH1ndoaqZO6rWTZH7eYGYoak9wMhshCyWG6oZjN6Mnhp1fdpiiAX6mAtZgBSnj4QmIXNU2i6u/vC6ryADczFRshQwtdKgEsY43z4Xi0LYg/JWOo47Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030668; c=relaxed/simple;
	bh=lOrYDrryevsKziQEfPPl+YzMD+Y+PPiXdT68oDCLVnA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Zs05bLvds9t/XpNhrBNO21WdmyOfX4t4lEgPa9bb5OZgXmV4J9+Xw8g7/teFNsUJVQktGFrZRlPBwEzkDhecy7qwMdGFUhhGwse6o2z7Wo9okWNNePKCJH4PliIDT1sf1wNGuoYePuPsSTj921D7xoQ1NnE9dj2NDae35MfBnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=crCUzkqV; arc=none smtp.client-ip=18.216.144.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from inspiring-wechuge.authn-relay.a.mail.umich.edu (ip-10-0-74-32.us-east-2.compute.internal [10.0.74.32])
	by lovable-gwydion.relay-egress.a.mail.umich.edu with ESMTPS
	id 686DDDC2.31790818.2C2BE75F.1062603;
	Tue, 08 Jul 2025 23:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1752030653;
	bh=vtrpzROaGDdeJynSM//iohKXHoLDyWPERSk5DuwBFR0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=crCUzkqVzE22+L8+sli/J/nO12at9yJHYHXZ2pVNhIH3edsmo13o6dr2/ypyxTz3P
	 w5jHg8CFhQCHWXTSiqWpbaxJxth1Y+hYY6jtRMrStZwmiwFa5GGSf2VPleoK87NDvR
	 tHnUnryDPogsu0Tu/Qcm3G0DxTxgapjbTwnqmw9FdljwWqRetFZFqtmNfgMiJgZnqs
	 1t+NXKrUPo6wikLFTqxFIN70J0co0+MFwz3dX4P/0/RCfpY7so9lHabVevgu8Uz8A+
	 xDrMsKqiEPIGtDMqcoQL3yeVlnKVfxOlt8ceuwpY+FcXBKhzU7iukBAJqUNu5mYu8G
	 88/PgPPUHk8DA==
Authentication-Results: inspiring-wechuge.authn-relay.a.mail.umich.edu; 
	iprev=pass policy.iprev=185.104.139.75 (ip-185-104-139-75.ptr.icomera.net);
	auth=pass smtp.auth=tmgross
Received: from localhost (ip-185-104-139-75.ptr.icomera.net [185.104.139.75])
	by inspiring-wechuge.authn-relay.a.mail.umich.edu with ESMTPSA
	id 686DDDBA.2CB243D0.576BB681.1044590;
	Tue, 08 Jul 2025 23:10:53 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 23:10:48 -0400
Message-Id: <DB7714QEA9EO.XB7BKFDO74JE@umich.edu>
Cc: <a.hindborg@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
 <david.m.ertman@intel.com>, <devicetree@vger.kernel.org>,
 <gary@garyguo.net>, <ira.weiny@intel.com>, <kwilczynski@kernel.org>,
 <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <lossin@kernel.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] rust: device_id: split out index support into a
 separate trait
From: "Trevor Gross" <tmgross@umich.edu>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <alex.gaynor@gmail.com>,
 <dakr@kernel.org>, <gregkh@linuxfoundation.org>, <ojeda@kernel.org>,
 <rafael@kernel.org>, <robh@kernel.org>, <saravanak@google.com>
X-Mailer: aerc 0.20.1
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250704041003.734033-2-fujita.tomonori@gmail.com>
In-Reply-To: <20250704041003.734033-2-fujita.tomonori@gmail.com>

On Fri Jul 4, 2025 at 12:10 AM EDT, FUJITA Tomonori wrote:
> Introduce a new trait `RawDeviceIdIndex`, which extends `RawDeviceId`
> to provide support for device ID types that include an index or
> context field (e.g., `driver_data`). This separates the concerns of
> layout compatibility and index-based data embedding, and allows
> `RawDeviceId` to be implemented for types that do not contain a
> `driver_data` field. Several such structures are defined in
> include/linux/mod_devicetable.h.
>
> Refactor `IdArray::new()` into a generic `build()` function, which
> takes an optional offset. Based on the presence of `RawDeviceIdIndex`,
> index writing is conditionally enabled. A new `new_without_index()`
> constructor is also provided for use cases where no index should be
> written.
>
> This refactoring is a preparation for enabling the PHY abstractions to
> use device_id trait.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/auxiliary.rs | 11 ++---
>  rust/kernel/device_id.rs | 91 ++++++++++++++++++++++++++++------------
>  rust/kernel/of.rs        | 15 ++++---
>  rust/kernel/pci.rs       | 11 ++---
>  4 files changed, 87 insertions(+), 41 deletions(-)

Few small suggestions if you wind up spinning this again:

> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> [...]
> @@ -68,7 +77,14 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, =
N> {
>      /// Creates a new instance of the array.
>      ///
>      /// The contents are derived from the given identifiers and context =
information.
> -    pub const fn new(ids: [(T, U); N]) -> Self {
> +    ///
> +    /// # Safety
> +    ///
> +    /// If `offset` is `Some(offset)`, then:
> +    /// - `offset` must be the correct offset (in bytes) to the context/=
data field
> +    ///   (e.g., the `driver_data` field) within the raw device ID struc=
ture.
> +    /// - The field at `offset` must be correctly sized to hold a `usize=
`.
> +    const unsafe fn build(ids: [(T, U); N], offset: Option<usize>) -> Se=
lf {

Could you mention that calling with `offset` as `None` is always safe?
Also calling the arg `data_offset` might be more clear.

> @@ -92,7 +111,6 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, =
N> {
>              infos[i] =3D MaybeUninit::new(unsafe { core::ptr::read(&ids[=
i].1) });
>              i +=3D 1;
>          }
> -
>          core::mem::forget(ids);

This removes the space between a block and an expression, possibly
unintentional? :)

> @@ -109,12 +127,33 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, =
U, N> {
>          }
>      }
> =20
> +    /// Creates a new instance of the array without writing index values=
.
> +    ///
> +    /// The contents are derived from the given identifiers and context =
information.

Maybe the docs here should crosslink:

    If the device implements [`RawDeviceIdIndex`], consider using
    [`new`] instead.

> +    pub const fn new_without_index(ids: [(T, U); N]) -> Self {
> +        // SAFETY: Calling `Self::build` with `offset =3D None` is alway=
s safe,
> +        // because no raw memory writes are performed in this case.
> +        unsafe { Self::build(ids, None) }
> +    }
> +

With those changes, or as-is if there winds up not being another
version:

Reviewed-by: Trevor Gross <tmgross@umich.edu>

