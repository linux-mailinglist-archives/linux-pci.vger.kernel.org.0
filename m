Return-Path: <linux-pci+bounces-25809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B8A87DBC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5C57A1D8F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46C258CC6;
	Mon, 14 Apr 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XB1NRASc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845132B9CF;
	Mon, 14 Apr 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626789; cv=none; b=gFFEGiJUqIEBgxV7PY/AaPRn3oMskmf0J4cbbZhBfD84VnXGkaDatQMs1pJtBW0AqAAPqfr06gv0E4Oxfz0vl1rOUqbonb8zhSDwdMup3gQEdWCCTvw+Q/cWPSd6m7ygHDQjhsLvQ9nBfoAMGd8PXeFKuHygwD+MUYMZtJnTK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626789; c=relaxed/simple;
	bh=Kw8jpV6IRxqBGBcZ90/euFao+cEcpw3DZck/Xa74P/o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1dw8hEvJJpKt1wnHTQ3FR8NIc/zJCJTpxYAyMtGOqoY0eCK85pG3ujsI0Pzzv1Q0QIbeDNHmTNdrG5BItCujVQPyLX0hLJkGk/Z/TG5ADPGEzkGeplVw/QRDFBRe7IbdUbsS3sDP9nIWIkxTrCCoWoATdklrqDj5WPyZgY+M4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XB1NRASc; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744626777; x=1744885977;
	bh=Dw0L7/4fVZr0fCQUokQrvI3m/6IoM6FEP7/3ms86vh4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XB1NRASct+xNBhJ9K9tPHWLn8LM/TBVhlMAQNLIgiCAG5+Lbh8/+CLZskUarMAzy7
	 vDO2+eRWEWHI9dzQdPMq9tHSep7rwcx4PB21Yw2NIlUPPYCeuRqa5E56dEl/jB6zxT
	 82iSLuWxLd+fD5/ZTUtsUVUQcwxFNFg5hcjDKtKzSoPVNmDAJ86oHO1Hh2TShmBY7C
	 L7nNUsRFhuf1bF/ZjrWg0NjyKn322RTK817zXKe/a+UI+jTdNkA268wA+6GKssB6du
	 mtJxMqD0Lx8wS5gMP1R3xd4wlHkeANWeofeeudXMCzWKbVO/mq2ePIq0guNKK2V29I
	 vqlVwZouZJ5YQ==
Date: Mon, 14 Apr 2025 10:32:50 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] rust: platform: preserve device context in AsRef
Message-ID: <D96AKN93RVYO.3NPBP9PBHWSAK@proton.me>
In-Reply-To: <20250413173758.12068-5-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-5-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1e260e5a2ec6b3d63d90865304494162486d064c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 13, 2025 at 7:36 PM CEST, Danilo Krummrich wrote:
> Since device::Device has a generic over its context, preserve this
> device context in AsRef.
>
> For instance, when calling platform::Device<Core> the new AsRef
> implementation returns device::Device<Core>.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/platform.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


