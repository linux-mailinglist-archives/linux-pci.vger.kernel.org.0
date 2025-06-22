Return-Path: <linux-pci+bounces-30325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA1AE3211
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 22:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811A2188DBD6
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B32AD04;
	Sun, 22 Jun 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP/qc13G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC93EED7;
	Sun, 22 Jun 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625281; cv=none; b=D880t6gzMENFqNrS/vCrMUy6NRtIa0Oi19mSqvHUGFRcsJenWsb7fd/kX+XR1p5vK1OVE7T9uBTWZqyKF2ejcWgn1gpxJIfbkj0QIaqziXf2S6UoAJYegUascRAH30PBOYvJnygie4sAuZfrcdg+OzvHsJEXdQzWHWMmDWj21Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625281; c=relaxed/simple;
	bh=1yzpw0aUJx2y0SjGulr7CeIflyI3UmgsKgd71+6sBYc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ea0FRx4vjDYIjpmC3ptahscbBM1CdqlJ/hXVkuis27fdrUwVBrRLKSDcglZqZkOULyYSkOJz1pNRsJ+FCl6yeuLeKMCoE5j9wM4MA2SaIySjCx07mCX/PkUWWRLfjRGSmWBFzgR1otclzUddWpgTGgiyWAJKYstIlS+Hyuha6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP/qc13G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC089C4CEE3;
	Sun, 22 Jun 2025 20:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750625280;
	bh=1yzpw0aUJx2y0SjGulr7CeIflyI3UmgsKgd71+6sBYc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oP/qc13GwziYzi4HK3bDWf6l9ZKRotOoHV3Dple7fZ26zmxRLWQLU4HOh8b11JfA1
	 nRNfMw42DZusrKt45ramcPB9dNRSJR0lsFPwJ0eQ7tUqoOhbFbt8mhNYYT/pPYsZyR
	 B8HxKI+d8XyBYZGTVoLySPENgIbEzY+yLR76fJ52eNlKwfh7ixG+Q2tIiMQzbx+4Ja
	 gRGeJ2tDGI52A8m7rYscsNQFzaqCOh9JTV5HzJ75qkCnVhFs0RcwLuiS3ALxBVwGzx
	 uPE/0CmVDNCz82cOgeUDlL3l9VQ2J8Z+Ytkd5yYEj7BcFoB18PDdWGAjPlnFmRNFeD
	 mX6ZOUsdZVEdA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Jun 2025 22:47:55 +0200
Message-Id: <DATCV8XFK7TO.2MYZKKA28JEQV@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
X-Mailer: aerc 0.20.1
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-5-dakr@kernel.org>
In-Reply-To: <20250622164050.20358-5-dakr@kernel.org>

On Sun Jun 22, 2025 at 6:40 PM CEST, Danilo Krummrich wrote:
> +impl<T: Release> Release for crate::sync::ArcBorrow<'_, T> {
> +    fn release(&self) {
> +        self.deref().release();
> +    }
> +}
> +
> +impl<T: Release> Release for Pin<&'_ T> {

You don't need the `'_` here.

> +    fn release(&self) {
> +        self.deref().release();
> +    }
> +}

I still think we're missing a `impl<T: Release> Release for &T`.

And maybe a closure design is better, depending on how much code is
usually run in `release`, if it's a lot, then we should use the trait
design. If it's only 1-5 lines, then a closure would also be fine. I
don't have a strong preference, but if it's mostly one liners, then
closures would be better.

If you keep the trait design & we resolve the `&T: Release` question:

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

