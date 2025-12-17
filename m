Return-Path: <linux-pci+bounces-43222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8337CCC8D50
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDDF31C2459
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576E343210;
	Wed, 17 Dec 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGf27I/N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738D34250F;
	Wed, 17 Dec 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988620; cv=none; b=pR8xbTWkNI+mkW2jzmHlcevEWu+A/wgtcVOhhLQwce3X8Nlyr/l0ItpV4PpjdfBEFsg+IG3P6MjzEaNW2oxZ1DshA3MRPIYKeTSd97wMayWwIEUb20MLip/yA4i/MPQJzLugPxcCP329U1zlNwaIKH9X/bhxCD/vXWIbxVKV4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988620; c=relaxed/simple;
	bh=0ACIbvOwGY90mWtM3n4T4wXbZu7mM4RGRwgfAJdJo3I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aZWO4Ycm0mgDgxYKj4jXC+xrqgUwYBmj6uput/7SMGTXKtBf/S9T8gQhTbQxUdKxgr1JfWQvfuUwtaeaLyddNqEoomSx2xCJ2uBOJBhQSL4oMIUc4OmabZD3gvU0K+kAH80io/lgy9ZmyGYfCIN42zRsxlV2nkPUxYZAJp43BRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGf27I/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4556AC4CEF5;
	Wed, 17 Dec 2025 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765988619;
	bh=0ACIbvOwGY90mWtM3n4T4wXbZu7mM4RGRwgfAJdJo3I=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YGf27I/NCUOnzoLnFvhcs4gM8gvBM7lK++Wjs2cYD/nYehidLNKd07YvBqM6Fh+Oo
	 5GwoSdxfk/7nbevJnVcYX+v5TbPBtOZgpqRaWT8VunaGZbqVvBACkO3PTkUS/TS6Eo
	 8IQ/KfOAmVr5Gn0nO5Kio3k6Uxfx9Mr6th2dFmrPTok63h+wzulzZmzIPBDS8Egpce
	 ZZKrw7TVG8xEI6KmO1n8Du+3MZKxLhjYr4SOhZ0S/pUAhJASK5SI0OeOTSbDRi2iPe
	 3kpFOd9utUmkiq+p/bPeoZPlDv7bcjMfrULufcJOFn6kbVP3fLzi04W3La8nLjm9/j
	 TPQ5QRrSu6vAg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Dec 2025 17:23:36 +0100
Message-Id: <DF0MPUGED5JR.1JBLR4H5IF1TG@kernel.org>
Subject: Re: [PATCH 1/2] rust: pci: document Bar's endianness conversion
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <miguel.ojeda.sandonis@gmail.com>, <dirk.behme@de.bosch.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Marko Turk" <mt@markoturk.info>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251210112503.62925-1-mt@markoturk.info>
In-Reply-To: <20251210112503.62925-1-mt@markoturk.info>

On Wed Dec 10, 2025 at 12:25 PM CET, Marko Turk wrote:
> Document that the Bar's MMIO backend always assumes little-endian
> devices and that its operations automatically convert to CPU endianness.
>
> Signed-off-by: Marko Turk <mt@markoturk.info>
> Link: https://lore.kernel.org/lkml/DE7F6RR1NAKW.3DJYO44O73941@kernel.org/
> ---
>  rust/kernel/pci/io.rs | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 0d55c3139b6f..bfa9df9e9bb9 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -18,9 +18,12 @@
> =20
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
> +/// I/O backend assumes that the device is little-endian and will automa=
tically
> +/// convert from little-endian to CPU endianness.
> +///
>  /// # Invariants
>  ///
> -/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer =
to the start of the I/O
> +/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to=
 the start of the I/O

Can you please send this typo fix as a separate patch?

No need to resend this one though, I can change it up on my end.

- Danilo

