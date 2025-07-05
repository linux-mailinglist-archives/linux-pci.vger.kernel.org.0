Return-Path: <linux-pci+bounces-31565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17422AF9FCB
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71401C24DCD
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A1251792;
	Sat,  5 Jul 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q21gvXSa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011F1A3142;
	Sat,  5 Jul 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714113; cv=none; b=kr17Vkln1ZK+RjQGJf4IqKFdxDVmduu1BQH0VkeTTEtBcZUlSkWntvbtHLq/um1VoQ6wp7/etpouJcLxKCy4+34ro1Uckn5voCDaA5GOYA+kEAswjdFbRyk+RyFbIQv4p9X4sDBjOSs5qIocwcmc+2ER+8s3UK2ckkjImtqBGnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714113; c=relaxed/simple;
	bh=dEZZnQARHSTgn80TB0LK1tcWHC0xm23y+GHQTFosXLU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tPdQDH7sqPHbkVCXaS9r1DX09ae67EjVzdWBeVrnzZsIrlzl5dYz+745gSvPWrcETsH5IqAjgZ5r2xnCmb0kjPjvt51q/ynH6sqaQZTRkwqv+6kIFitmnfln5UYGpaUFeWDpFDdmFsyHOzHCiyvcpkXlPD+eCHfuHriCAX8UtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q21gvXSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BD7C4CEE7;
	Sat,  5 Jul 2025 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751714112;
	bh=dEZZnQARHSTgn80TB0LK1tcWHC0xm23y+GHQTFosXLU=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=q21gvXSaakGcj/PSIM4jVpsq+FiyliL4ishKyGInpLXi7JOBjvTDiUDWydqk3Pnzb
	 B8dTOtiLzqNuM0EXBj9lb8jAonFpPKAY4IxSB+Iaq1NoO1ySTDjO7EMqYm5Augkoou
	 PDDFgdN1w64FRC5Unid3mAIfG+fwPRU2n211hVRM8i02/2490g5gqShqjaGOHxERer
	 fXwuLOqnXe66YyTtKhUSsbHKXQPbYP4m3mvV2Vg5/EqM7CwcjHu1yet71qQ9uGK8wh
	 YcBHTT1vL88QLqY2/1DAX//ved5/UbVfBLIaaWfHWkKj6aZ0pqxW1rVo6uRppukVQs
	 8PSJXfo+pwJ/A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 13:15:06 +0200
Message-Id: <DB42TQY2E57U.1PKC16LW38MH9@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: device: add drvdata accessors
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-3-dakr@kernel.org>
In-Reply-To: <20250621195118.124245-3-dakr@kernel.org>

On Sat Jun 21, 2025 at 9:43 PM CEST, Danilo Krummrich wrote:
> +impl Device<Internal> {
> +    /// Store a pointer to the bound driver's private data.
> +    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_fore=
ign().cast()) }
> +    }
> +
> +    /// Take ownership of the private data stored in this [`Device`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// - Must only be called once after a preceding call to [`Device::s=
et_drvdata`].
> +    /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
> +    ///   [`Device::set_drvdata`].
> +    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: By the safety requirements of this function, `ptr` co=
mes from a previous call to
> +        // `into_foreign()`.

Well, you're also relying on `dev_get_drvdata` to return the same
pointer that was given to `dev_set_drvdata`.

Otherwise the safety docs look fine.

---
Cheers,
Benno

> +        unsafe { T::from_foreign(ptr.cast()) }
> +    }
> +
> +    /// Borrow the driver's private data bound to this [`Device`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// - Must only be called after a preceding call to [`Device::set_dr=
vdata`] and before
> +    ///   [`Device::drvdata_obtain`].
> +    /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
> +    ///   [`Device::set_drvdata`].
> +    pub unsafe fn drvdata_borrow<T: ForeignOwnable>(&self) -> T::Borrowe=
d<'_> {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: By the safety requirements of this function, `ptr` co=
mes from a previous call to
> +        // `into_foreign()`.
> +        unsafe { T::borrow(ptr.cast()) }
> +    }
> +}
> +
>  impl<Ctx: DeviceContext> Device<Ctx> {
>      /// Obtain the raw `struct device *`.
>      pub(crate) fn as_raw(&self) -> *mut bindings::device {


