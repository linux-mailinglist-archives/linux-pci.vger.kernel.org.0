Return-Path: <linux-pci+bounces-32250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06571B0715F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5099517FA6C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC83253356;
	Wed, 16 Jul 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnUBjipM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C7157493;
	Wed, 16 Jul 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657344; cv=none; b=cBTYHghUDzjW1qurX0lENqDzuDSRfoRHgCLbcJCur8OXYuEtYHzw5zzSWhuiXQSirOC47ILRh/sfJJ4KqcAGD+tl0wb/WLUz5fGPp55+R/waYTWhQ3DYacgKzAscB93JtSFnMWbLCh5dqWWSI06ObZmTUxlCHJAyBquaMuXpi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657344; c=relaxed/simple;
	bh=ONPNBASW2TlNyQh0oBZI7v9HNhfprjI2hTF1LVI4XTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnzLXLG2yUrZU3TkPlg24oHwwx4kfuf9BQHKPb89INkPxazbJs2YtdPMlPYWPx1g5ZCXffEYxyIVjc/XEboYWpamhNrRQgl+YVzvJC1O97UElVi4UmV7NHaptJPKYSd9f1onNc9O0koGuIVW1ADr4ixZ8mrVnIqyPu2QmposGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nnUBjipM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4243C4CEF1;
	Wed, 16 Jul 2025 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752657342;
	bh=ONPNBASW2TlNyQh0oBZI7v9HNhfprjI2hTF1LVI4XTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnUBjipMfPB2BJS84RlGSNZsB9Ay7VhRRQ32xD2SjO7iD2mOCg4UVNkCWF60AO6tK
	 P9PWMcw2UA1/H9AlpuU++Y3qv0I4DzrpkVQgheexwOv9KjL6KHd5OAdeuFzX4tHkbH
	 JMfcp2EGdO4c44eIJoMmu3ucEsk0nCqK14gtRdVg=
Date: Wed, 16 Jul 2025 11:15:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
	robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, bhelgaas@google.com, kwilczynski@kernel.org,
	rafael@kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
Message-ID: <2025071627-outlet-slacker-9382@gregkh>
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710194556.62605-3-dakr@kernel.org>

On Thu, Jul 10, 2025 at 09:45:44PM +0200, Danilo Krummrich wrote:
> +/// Returns a bitmask with the lowest `n` bits set to `1`.
> +///
> +/// For `n` in `0..=64`, returns a mask with the lowest `n` bits set.
> +/// For `n > 64`, returns `u64::MAX` (all bits set).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::dma::dma_bit_mask;
> +///
> +/// assert_eq!(dma_bit_mask(0), 0);
> +/// assert_eq!(dma_bit_mask(1), 0b1);
> +/// assert_eq!(dma_bit_mask(64), u64::MAX);
> +/// assert_eq!(dma_bit_mask(100), u64::MAX); // Saturates at all bits set.
> +/// ```
> +pub const fn dma_bit_mask(n: usize) -> u64 {
> +    match n {
> +        0 => 0,
> +        1..=64 => u64::MAX >> (64 - n),
> +        _ => u64::MAX,
> +    }
> +}

This is just the C macro DMA_BIT_MASK(), right?  If so, can that be said
here somewhere?  Or, how about turning DMA_BIT_MASK() into an inline
function which could then be just called by the rust code directly
instead?

Just a minor thing, but it stood out to me here.

thanks,

greg k-h

