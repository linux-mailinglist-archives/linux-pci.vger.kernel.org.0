Return-Path: <linux-pci+bounces-43958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F4CF01A9
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F178930057D2
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221121CC5C;
	Sat,  3 Jan 2026 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8/3E9ig"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77511373;
	Sat,  3 Jan 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453727; cv=none; b=EB3sxwnvRPeb3I+wUkkCT/YBv/iBh2Fsl0uHJ15d+eBWmOEGm87kevZe2v2VNdFVykDvNDrzMcA2tS+wRNoNzTlI+onyIOVC5Ors185a7yXiV83alOxTQvAVtPSqtRRvkoSgHCmIJT5Rkw8F+/wpTCz7He8ee9znwbYXKOUHuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453727; c=relaxed/simple;
	bh=cCxawRVpeFxZFT/wWBviR/FrfkNkMeMzdYaeYOUcOUg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ruq+gb9ijJOH4iyZve7G2mtqVFh1/b/JMRWz/PTOt1ckAuYBErqbDGjZ1BZTZkrEgWsfx0PaVC0BL6bRcdo+5ise+kFP72EY3njWporRGUDtsgRfW2rw3LIkJugHoWxmaPLFKlGcXgCrySrfaZM5VoFCuVsTLNaTaARchwiM0ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8/3E9ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED01C113D0;
	Sat,  3 Jan 2026 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767453726;
	bh=cCxawRVpeFxZFT/wWBviR/FrfkNkMeMzdYaeYOUcOUg=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=m8/3E9igxC88kBsJLonrouM0caIToZmGQOfOtPxpTDan66/2MrVGv9Zx1U0Cg5Lws
	 uvGT82uUjdoLXT+D2cC8usokUz6Aba4EVSZy79epkQwr1pe19XuUYAgvCMhsoJK9at
	 OXRJawUmQpRm7Sg58DUskWw7NuG+crb6O0qlcRsVNmJ5pcMpF+sw1jlkvrZrEmppQu
	 QqmYSmt+EiJMlKwPrJjku1o8Gvh1Ojbd3x0lnG2hnHsTyu4d8JKhVGV10BvoqeC4KU
	 Bc6cPUv+lNEYF8B3MZz6xPlN3E9Ux2+3KFTv9APK7bVBKr6zR23C0d+Oz8JNW9rk2d
	 P5pkpHVxj6n+w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Jan 2026 16:22:03 +0100
Message-Id: <DFF21ZKK0HMP.1EQOINQHK615O@kernel.org>
To: "Marko Turk" <mt@markoturk.info>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: io: fix Bar reference in Io struct's comment
Cc: <dirk.behme@de.bosch.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260103143119.96095-1-mt@markoturk.info>
In-Reply-To: <20260103143119.96095-1-mt@markoturk.info>

On Sat Jan 3, 2026 at 3:31 PM CET, Marko Turk wrote:
> Bar was moved to a separate pci::io module, update the reference to it.
>
> Signed-off-by: Marko Turk <mt@markoturk.info>
> ---
>  rust/kernel/io.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 98e8b84e68d1..08853f32dae6 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -87,7 +87,7 @@ pub fn maxsize(&self) -> usize {
>  /// };
>  /// use core::ops::Deref;
>  ///
> -/// // See also [`pci::Bar`] for a real example.
> +/// // See also [`pci::io::Bar`] for a real example.

pci::io::Bar is re-exported as pci::Bar [1], so this should be fine. Given =
that
it is not a doc-comment the reference also doesn't do anything. We could re=
move
the square brackets accordingly.

[1] https://rust.docs.kernel.org/src/kernel/pci.rs.html#43

