Return-Path: <linux-pci+bounces-24598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32047A6E6E5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 23:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20457A3777
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04F1F03DA;
	Mon, 24 Mar 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iE7qo37P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832951EDA1F
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856840; cv=none; b=TqH06hc+Hg7pyYYMVgJijnXGbPBZ2dBybsmlzeOtTv89MHldiNnrOf6g+cxorrBhIvmP9B3beEDfh+QVwaRscOhu3fRc/TqZfVPc4Sk/GwMeElcxiDvygR730ZjQ4lev6pWcKl4xnsxLlFZSxzwgqmsvxVBREQpjNWCzzzCihvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856840; c=relaxed/simple;
	bh=Pn0AGGzSeqNfWHLY8AhjCZdz1VG8MO6qul3p82EqjDs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0LMGoY6vigcb+UT777b3Gq2jKskJKBfB8uZTTPFEwJl8Vxret7KBiokbQuNXr0YDg3OirvZNJ1zInxVKh4GpJTy3HKDVAKdxKwcNNJzdLynCPyZiOoYrO1lp96ZDVN700Vu7pKjONhlTitff3P8LxQqTm4k7fuaX/mFcQlT82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iE7qo37P; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742856836; x=1743116036;
	bh=yaV/DCUdOc3Cm1Ubw865d7CG3nJIk8LhbWqXmh7MRvQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iE7qo37PSTN7YrlKH/VHM9g2A3kUW1FbYeA8aOnXAH5M8862tbYlp8wG345DUjhja
	 VpCSXt2tQ4GJXlqpY2I0GUhx5u6b74hmfDgCJqqSrI2hpVg5dLnxt3VLNZRaMAsZ/e
	 WnosEtRAX2p9rBWUkGrkYct7mXDbzypaowFvFL9h77KvzZWlbgDPW6clsiE5foahEP
	 r1BayvA+UerORyaYNC7he2j8D1yC8xKGvIymzZOFbw3gQSvPltHBqxjq9r4W8Glj3p
	 q7PS4icbbhGYGHQ5Ore4pTh/LOnZYsNGQFX62gE2K1sFAfm/VJcz3pM/im6Iu4JRAc
	 LUi2rulnj5FVw==
Date: Mon, 24 Mar 2025 22:53:49 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 07/10] rust: pci: fix docs related to missing Markdown code spans
Message-ID: <D8OV6JF1S63H.NG5CXUZDQQP6@proton.me>
In-Reply-To: <20250324210359.1199574-8-ojeda@kernel.org>
References: <20250324210359.1199574-1-ojeda@kernel.org> <20250324210359.1199574-8-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 88024eb59a9f355de344d17b88fd4fbc46014edb
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 10:03 PM CET, Miguel Ojeda wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index f7b2743828ae..99413607c2b6 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -115,7 +115,9 @@ macro_rules! module_pci_driver {
>  };
>  }
>
> -/// Abstraction for bindings::pci_device_id.
> +/// Abstraction for the PCI device ID structure ([`pci_device_id`]).

Wouldn't "([`struct pci_device_id`])" make more sense?

---
Cheers,
Benno

> +///
> +/// [`pci_device_id`]: https://docs.kernel.org/PCI/pci.html#c.pci_device=
_id
>  #[repr(transparent)]
>  #[derive(Clone, Copy)]
>  pub struct DeviceId(bindings::pci_device_id);


