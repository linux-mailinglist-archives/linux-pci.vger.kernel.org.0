Return-Path: <linux-pci+bounces-38507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7B9BEB397
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB071A637AD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC13126A0;
	Fri, 17 Oct 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3naJv87"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB52F260C;
	Fri, 17 Oct 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725770; cv=none; b=spnxI91XDePZ3ybiXuwPgrwfewoOlzJSMlAqJuxIDsOBsKw9QFpCC2PvU8lpsJL5vebWrN7s5iVt49NKdPhZPGzk9PWPROINfuB/ZRg57c/h87OOwhHQf9ZXQEKQW+QE5EVChcvwKohd+yuki/8/cSKgEKUcHLlFjGq514XLiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725770; c=relaxed/simple;
	bh=R22cE40QGrXnmRARyFiuKiJD1jh8qI6eDnspPf8uC4Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=f7JOQ7eatrtvZ7Pl7LMtAoHNaT2QVd/uxcfNWD42U0DWGYFYvlBNjbihbcvJLpOa18Mf5jdtU+mdG8bnLuGym8gg4GKv7p56btGX88Jg5L+kQrnNyo//WmnaEk1L0mnyk1Jb2+fQ0UBqfzM/hpKfH2Xyhf3lVoBmY6N3xTGw8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3naJv87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F28C4CEE7;
	Fri, 17 Oct 2025 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760725769;
	bh=R22cE40QGrXnmRARyFiuKiJD1jh8qI6eDnspPf8uC4Y=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=i3naJv87wXwVGZofd8TWaof7oD3yKRQsy66d1XT5kstuVgGKKYFTODlLYkSvctGHo
	 nRmthlPkaGokYECROcAWd4JbvkytA3dBDKjAZPPHG1W7ke8BeCC2axEzqTnEX/lIT7
	 9SggPHsKbVtIe+nWSYM5NGJuhrI4jAHT6/pV2vpmvAJ++dfSWBNWY+SzQRH5RbeIz9
	 C5JBwrlK1bKzldw+DGqadJUqpCAlv1B4004ki/I/+7PbOSkBPMM0qCos1RxUS0Yd3x
	 lp7uKorUZtc6W3bCEL/Za+M2y3afxxCF0/V7mO92eLSz6W4952nFcLmjv+Cz3kYuC2
	 tbAfQ1i7WLqaA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 20:29:22 +0200
Message-Id: <DDKT6WXI1S4I.30CBHFLJ9Q6CY@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <acourbot@nvidia.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20251016125544.15559-1-dakr@kernel.org>
 <aPI-9GoI7ZsNCpQr@google.com>
In-Reply-To: <aPI-9GoI7ZsNCpQr@google.com>

On Fri Oct 17, 2025 at 3:04 PM CEST, Alice Ryhl wrote:
> On Thu, Oct 16, 2025 at 02:55:28PM +0200, Danilo Krummrich wrote:
>> The driver model defines the lifetime of the private data stored in (and
>> owned by) a bus device to be valid from when the driver is bound to a
>> device (i.e. from successful probe()) until the driver is unbound from
>> the device.
>>=20
>> This is already taken care of by the Rust implementation of the driver
>> model. However, we still ask drivers to return a Result<Pin<KBox<Self>>>
>> from probe().
>>=20
>> Unlike in C, where we do not have the concept of initializers, but
>> rather deal with uninitialized memory, drivers can just return an
>> impl PinInit<Self, Error> instead.
>>=20
>> This contributed to more clarity to the fact that a driver returns it's
>> device private data in probe() and the Rust driver model owns the data,
>> manages the lifetime and - considering the lifetime - provides (safe)
>> accessors for the driver.
>>=20
>> Hence, let probe() functions return an impl PinInit<Self, Error> instead
>> of Result<Pin<KBox<Self>>>.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>> Depends on a minor pin-init patch [1] (Benno will send it to the list
>> soon). A branch with this patch and the pin-init dependency is available
>> in [2].
>>=20
>> [1] https://github.com/Rust-for-Linux/pin-init/pull/86/commits
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?=
h=3Dprobe_return
>
> Overall LGTM.
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks!

>>  impl Device<CoreInternal> {
>>      /// Store a pointer to the bound driver's private data.
>> -    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
>> +    pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>)=
 -> Result {
>> +        let data =3D KBox::pin_init(data, GFP_KERNEL)?;
>
> Perhaps the gfp flags should be an argument set_drvdata?

There shouldn't be a need, so I'd rather do that should we find a valid cas=
e.

