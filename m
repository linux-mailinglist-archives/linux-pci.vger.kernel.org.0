Return-Path: <linux-pci+bounces-43959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1189CF01B8
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7273E3004C83
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953E930DD08;
	Sat,  3 Jan 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfwf3+z4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FC26E6FB;
	Sat,  3 Jan 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453860; cv=none; b=DdcZ9ZArWfbsAdZUlCJHbWi3YajBA4bIZi5of37tLkMHn9nqneIiDifqSz6z5xkDUmHD6xVHeZL9oi+gsj+/fdIl/QGui74D/eDKBVIgyQ8Nt3hX2G/h2reBzjisaJMMH0NtOu+yFiPkvmx4/GFDYurYPEyhme9F8KbpbX8exAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453860; c=relaxed/simple;
	bh=OuLdgazopdGu5vkfIwznqVww+S2nJ8Zk/DDNB85t6GA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=bupS4suUUdQgLOIHWwcYvrAFRQaYB5DQCmlrurzhj5QDIeYckvMywJIz71hTEXxywlgCbCWod3ddvGrJ8xcBlQlxhkKHlQx2FL7aSDVpIWbzNJdxRL5bPrJtd9qy5CBvmSLXVoeHKQtGMdS8Q8J9nEwImKhjVdgkTQ3iRSCaOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfwf3+z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01F7C113D0;
	Sat,  3 Jan 2026 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767453860;
	bh=OuLdgazopdGu5vkfIwznqVww+S2nJ8Zk/DDNB85t6GA=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=hfwf3+z407HJqCUypOk6kQ++anUic9gNaajM0+hQN9Y13J/QxuTU50cAMx1dHIDv8
	 qez7TliulHpcPMDb+3ihH3RJxLhShhpMQYvVDOmvqlOpK5YoQJGqp7ueyhb2pLiO6T
	 mbI/2Ez3Zgf962W3fFGT1ADsY0HqKz8AweOed/0YL4Qxmvj018lskBKXfDlrF6f5p3
	 YrISR99V0ifS/ziXOPqFnjKpZT+xkpQXULfQPBBYA7J3807380d79s1UNEMpQCERhF
	 ppFhqQTFfc/XL5U3pxAQ9yhDNUdyMs73xTjgBb7jWWeD6HxuUFjsdgm5NJCCO8VST6
	 V6dtjITrYtTtg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Jan 2026 16:24:17 +0100
Message-Id: <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
Cc: <dirk.behme@de.bosch.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Marko Turk" <mt@markoturk.info>
References: <20260103143119.96095-1-mt@markoturk.info>
 <20260103143119.96095-2-mt@markoturk.info>
In-Reply-To: <20260103143119.96095-2-mt@markoturk.info>

On Sat Jan 3, 2026 at 3:31 PM CET, Marko Turk wrote:
> inststance -> instance

It's trivial in this case, but we usually write at least something along th=
e
lines of "Fix a typo in the doc-comment of the Bar structure: 'inststance -=
>
instance'."

Please also add a corresponding Fixes: tag.

> Signed-off-by: Marko Turk <mt@markoturk.info>
> ---
>  rust/kernel/pci/io.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 0d55c3139b6f..fba746c4dc5d 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -20,7 +20,7 @@
>  ///
>  /// # Invariants
>  ///
> -/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer =
to the start of the I/O
> +/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to=
 the start of the I/O
>  /// memory mapped PCI BAR and its size.
>  pub struct Bar<const SIZE: usize =3D 0> {
>      pdev: ARef<Device>,
> --=20
> 2.51.0


