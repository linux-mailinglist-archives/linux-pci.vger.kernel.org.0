Return-Path: <linux-pci+bounces-32307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0135BB07BFD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB4A7B1448
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669582F5C4F;
	Wed, 16 Jul 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCFmwb9y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325F2F5C43;
	Wed, 16 Jul 2025 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686891; cv=none; b=P8EYASltxFkghhWeGzfLFn/95u7DIh7OPmeE/V0Z6JlVOq1gJTDilSypPhDS8G4Yvd2HnGRvYPbjHKGf0IJNUdpfJZX3CFS7zjkd/jYmTuNTiEKgH6EmPaPn6hpDfTamgS7lKSCjqJ/BOwCjXFwnDTfW/1uHTAhorbopjiuWyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686891; c=relaxed/simple;
	bh=7fa0uYdNMApfcLf1FOlEz+DkNjW/q/Z4QMKW0OGKukI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9V9DKA0LJGMwEAjBbv10THH3r4KYl1LQIG9Hzy4FW96tocs3bBNfmBC4MjvVNhRFn7P71AUWlR1dpkAohrHQYqXFxTsgimbAf+pa3BVNe/oBD2HE+lTjDpqkN2SvIzS5mmOqQDAxGUmwMJrZquNJmUxhBlXU9e9IFkXuUhSv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCFmwb9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A738C4CEF0;
	Wed, 16 Jul 2025 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752686890;
	bh=7fa0uYdNMApfcLf1FOlEz+DkNjW/q/Z4QMKW0OGKukI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCFmwb9ybcKO3i37EoZqCJaZqZ0/ldDTbbm1jXDx7eXTHE0Z4e8ofY1poq08kS20O
	 MujBhvdFddIJK71JNLrmW0jgKFDpZ1DwUh1Whd2VmmpqqlPIeDZDmwL5dZi3PWMIRS
	 VTpMBdRn/onSDcC+5AhZA2z8H045oO2XgYWnykIY=
Date: Wed, 16 Jul 2025 19:28:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
	robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, bhelgaas@google.com, kwilczynski@kernel.org,
	rafael@kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] dma::Device trait and DMA mask
Message-ID: <2025071648-aflutter-crinkle-729c@gregkh>
References: <20250716150354.51081-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716150354.51081-1-dakr@kernel.org>

On Wed, Jul 16, 2025 at 05:02:45PM +0200, Danilo Krummrich wrote:
> This patch series adds the dma::Device trait to be implemented by bus devices on
> DMA capable busses.
> 
> The dma::Device trait implements methods to set the DMA mask for for such
> devices.
> 
> The first two bus devices implementing the trait are PCI and platform.
> 
> Unfortunately, the DMA mask setters have to be unsafe for now, since, with
> reasonable effort, we can't prevent drivers from data races writing and reading
> the DMA mask fields concurrently (see also [1]).
> 
> Link: https://lore.kernel.org/lkml/DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org/ [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/dma-mask
> 
> Changes in v2:
>   - replace dma_bit_mask() with a new type DmaMask
>   - mention that DmaMask is the Rust equivalent of the C macro DMA_BIT_MASK()
>   - make DmaMask::new() fallible
>   - inline DmaMask methods

I like the DmaMask stuff, nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

