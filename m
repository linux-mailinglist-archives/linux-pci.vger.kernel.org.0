Return-Path: <linux-pci+bounces-24276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82CA6B1C5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 00:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372444A3B4E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E676222C336;
	Thu, 20 Mar 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IRNL8Fhh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1431224251;
	Thu, 20 Mar 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514259; cv=none; b=ngdGYbvupgSIQWH3X+E8xEsOdqKk3/CubRrM0eHYS4Fa4QmdgM/D5aZhxCc9dSee28WD1g/4VzYHUa55ne06wERUs+y9td5f2ycAFV2B2klYYS2ulYCJkGRLem0JwvUV4rpVouXj41EGBe58p7Q32te3Zl1bflMnRMWVrpBw2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514259; c=relaxed/simple;
	bh=Bg08hwoUReW52vaziORinJXS6O+KUquRWe5M+sADcGo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayhazSWf82ywzh5hceykWCM5A2+K4nhGPElIEPwAAo775HgBhSEt1sN41BUK7W7cCDw0kuWpl5Mx+ewL3ZeQEgWrUFkw5mDnzUx/QLTmS23T1G80YNlx33Xb+LiaBHbsq/2tA07YvsM3RryS/uKr5+zVQCs6dRwuqJzSE20KKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IRNL8Fhh; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742514247; x=1742773447;
	bh=VUqN+IP+y7JdfWhBmesM1Cx23jDtU1FYWcIG5o6G+4Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=IRNL8FhhuO7zn+uVKpaGxcVFVJX84/f7jrUJre5OR3oCw2IIq/QdGjOF+x57tzzm4
	 XeGZnLnjH7WLs3Igb/mPOl4DRDKWd4ctezBtyyS1mqGtYs9GcJUIo/uXCB+4fAMMxq
	 ic4eah1sSvKq23BV3FmBXUr6BKDaAvtGziHmSVoGtcCHKV0kLolfJEoxVafRJZG/nK
	 yKfMyYSHIfRTHl33c6p4fbVCkvhTK7FVsjg/5gXb5Kyto0W5EEqHFbpvm/aerAH5fr
	 NKq7d5Xar+ixhThGdBYmy5xtebluumfhm+ckuutklz3YR93rNIGjjwueCXPRvFkWzW
	 yTclZXfkmzHsw==
Date: Thu, 20 Mar 2025 23:44:01 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <D8LHQSKES3SR.2EW347ONXZ22H@proton.me>
In-Reply-To: <20250320222823.16509-4-dakr@kernel.org>
References: <20250320222823.16509-1-dakr@kernel.org> <20250320222823.16509-4-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 20827e8e42723db1bb567796c49c0a267182b5ed
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 11:27 PM CET, Danilo Krummrich wrote:
> @@ -466,6 +466,23 @@ fn as_ref(&self) -> &device::Device {
>      }
>  }
> =20
> +impl TryFrom<&device::Device> for &Device {
> +    type Error =3D kernel::error::Error;
> +
> +    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
> +        if dev.bus_type_raw() !=3D addr_of!(bindings::pci_bus_type) {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: We've just verified that the bus type of `dev` equals=
 `bindings::pci_bus_type`,
> +        // hence `dev` must be embedded in a valid `struct pci_dev`.

I think it'd be a good idea to mention that this is something guaranteed
by the C side. Something like "... must be embedded in a valid `struct
pci_dev` by the C side." or similar.

With that:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> +        let pdev =3D unsafe { container_of!(dev.as_raw(), bindings::pci_=
dev, dev) };
> +
> +        // SAFETY: `pdev` is a valid pointer to a `struct pci_dev`.
> +        Ok(unsafe { &*pdev.cast() })
> +    }
> +}
> +
>  // SAFETY: A `Device` is always reference-counted and can be released fr=
om any thread.
>  unsafe impl Send for Device {}
> =20



