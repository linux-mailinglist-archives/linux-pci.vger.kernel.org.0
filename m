Return-Path: <linux-pci+bounces-21691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BFA39438
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 08:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891F47A1259
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35811F2C5F;
	Tue, 18 Feb 2025 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfdLUURU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677B14A09E;
	Tue, 18 Feb 2025 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865426; cv=none; b=cA4orcIsJhZ185rc7S+07Tn+lTVyFrTWNWLotJ0j3Kh089zwpGSclryE7Qu8nlrMjEE3wYEvrg/25iMzMCEboMppQrlyhZLK/7KAmOvCJ2gGvPI/zYKG81NXlCtPCYqnGqfxrCDgVS+/n75R+Iv2GJJsvL7IYFXb8G8ySaSiZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865426; c=relaxed/simple;
	bh=PWXaRy3Kpn4O/7AGgg9asSH7PMFAQwYpAHo4UKMP4DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACtrbfJwT4jmgdnawMuJQmXMtDGexuBkgyHlyJspVNzELMFJ0WcB9aIWb1cV+1YRbSRQwV0s3NJNEHklTrFCdg72DPpxsgY3sxOQtR6apdajD+Ue4O/dEqVzC6DMzsZx2MWigHKqOMRaZ560zXLp7kCPz/RC+90FiG/VupiVCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfdLUURU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840E5C4CEE2;
	Tue, 18 Feb 2025 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739865426;
	bh=PWXaRy3Kpn4O/7AGgg9asSH7PMFAQwYpAHo4UKMP4DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfdLUURUDyNJptMiASFa3y9vKuEQwFBEmVLess4icBG1cyz3CZj9JrVNsDbAGqY5M
	 1/lXmimYgep/RTiBa8xiTOu/YFF0IpWMGwcf+kcjkv1oB50kqU6h7cYn9bsDmcCjsY
	 36OqAbjrwf/EX9jql6Z/HD+fCar4r6x2sZ5vxWbs=
Date: Tue, 18 Feb 2025 08:57:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fiona Behrens <me@kloenk.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: io: rename `io::Io` accessors
Message-ID: <2025021817-chirping-fencing-d991@gregkh>
References: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>

On Mon, Feb 17, 2025 at 09:58:14PM +0100, Fiona Behrens wrote:
> Rename the I/O accessors provided by `Io` to encode the type as
> number instead of letter. This is in preparation for Port I/O support
> to use a trait for generic accessors.
> 
> Add a `c_fn` argument to the accessor generation macro to translate
> between rust and C names.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/PIO.20support/near/499460541
> Signed-off-by: Fiona Behrens <me@kloenk.dev>
> ---
>  rust/kernel/io.rs               | 66 ++++++++++++++++++++---------------------
>  samples/rust/rust_driver_pci.rs | 12 ++++----
>  2 files changed, 39 insertions(+), 39 deletions(-)

This is good, thanks!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Want me to take this through my tree?

thanks,

greg k-h

