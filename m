Return-Path: <linux-pci+bounces-24141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96EA695DE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B572C1B62AE3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA671E51EA;
	Wed, 19 Mar 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtlfB8Ce"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DEF1E130F;
	Wed, 19 Mar 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403908; cv=none; b=bs2BqTXY0k7Rk6Jb3+9e4rjPC5XwQO1AucKY5uV4ySwFKrP/CXmh4eYOzGyGeJ97LOznHuhcLuvuAl4JNvif+TgY3GUI2hRfhkE6gIGwqIZod7JWJqe50V/jACmfu/ywWYlPj+jCG/rSUO5LgSdAVC4rL49OysASx2j8PdfYjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403908; c=relaxed/simple;
	bh=CLk2QeytvRvxLmAlgdUGm9/boDRRMkQXQb5zP3idkfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqlMrGUemjfwNobXYkpfp2sQt3szBsQTWkjD25mUL6qrDqKML5dPflZcCwRrHyy6IEGTpPjT+KJqJ8YOIGS5uKxAg+MWGhPL2OPFppTo2s6XhHRNU/VN356BPZBcULw2q7MyISgy6x6f412luRYzLeZnMXCO445QSC1iLWH8ME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtlfB8Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE1C4CEE8;
	Wed, 19 Mar 2025 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742403908;
	bh=CLk2QeytvRvxLmAlgdUGm9/boDRRMkQXQb5zP3idkfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtlfB8CeYKFpKxa3iGGh00QiEM2uV6uBehZDA9dU9dlwqamTw9jjWi2R5xSB12Nlr
	 vGfaceGHk/gRhoZDGip9HnIKYWO9b5gtIHl7EacM+fM9atSF9uOMndJ/rIt65BD7hf
	 TA5J1UbzzBR2Dx6MLLxjFaFfcro1gqkegWHPOf2o=
Date: Wed, 19 Mar 2025 10:03:49 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: require Send for Driver trait implementers
Message-ID: <2025031914-knelt-coffee-8821@gregkh>
References: <20250319145350.69543-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319145350.69543-1-dakr@kernel.org>

On Wed, Mar 19, 2025 at 03:52:55PM +0100, Danilo Krummrich wrote:
> The instance of Self, returned and created by Driver::probe() is
> dropped in the bus' remove() callback.
> 
> Request implementers of the Driver trait to implement Send, since the
> remove() callback is not guaranteed to run from the same thread as
> probe().
> 
> Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Closes: https://lore.kernel.org/lkml/Z9rDxOJ2V2bPjj5i@google.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As there's no in-kernel users of these, any objection for me to take
them for 6.15-rc1, or should they go now to Linus for 6.14-final?

thanks,

greg k-h

