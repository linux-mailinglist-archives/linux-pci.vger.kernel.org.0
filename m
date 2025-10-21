Return-Path: <linux-pci+bounces-38852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80ABF4CFE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62D6A4FE279
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E835272E56;
	Tue, 21 Oct 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZNu8cu//"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705726FDBD;
	Tue, 21 Oct 2025 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030313; cv=none; b=SEY7h1Y3DEwZCrwQJ2aarJhxtVbCqS4VJGKIn91uVqBWaUvx3Bl4VMmZcWtyK6mdjmKxa/xIiV9/RcE3+Gtq1ZJqx/P7P/ZEBnfg6cHkKlWROE2GKnBekF3OmtztA/1pPi7tnHeAeQc9kVdaRWir+K2S0QLsi2LGXxG1Vj51wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030313; c=relaxed/simple;
	bh=EHsArdqsSEWKKduqFrtczKcUKMzzz51C1h76mpGhFlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yrl4KTm9CUm5bMqI/jnb8/VcWsgjFZcjb1LUtH9tPyvnwNz4qKYQ+x9gTVRNuYBo7JrzmfVgEVFZGJPOf0y2jGv2JyYMhtvglpqylXWwKnrZ+Y8Vh1iVla4Vj/yaMySMu0g3pZLHvLtXjrQM+yH2zaX70tTlLq9OMi1Tu9y1YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZNu8cu//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D37C4CEF1;
	Tue, 21 Oct 2025 07:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761030312;
	bh=EHsArdqsSEWKKduqFrtczKcUKMzzz51C1h76mpGhFlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNu8cu//JZ3YSlADe6H2B3e7usY12xgSqfAc3mg2b5zvqETI5nUwHrUobxPs7mXl3
	 45+TBlX7GQaS6dUndczNC7kpv1R2BdyQDQKVSM7Qeb6bFRBHRyM6JtsZFHSf1VNlTq
	 QuztdY+ldB1r4hU/DHMNlvjk0Ola2/kZ1++13Ydc=
Date: Tue, 21 Oct 2025 09:05:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, acourbot@nvidia.com,
	ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com,
	bhelgaas@google.com, kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
Message-ID: <2025102158-tissue-goal-77ba@gregkh>
References: <20251016125544.15559-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016125544.15559-1-dakr@kernel.org>

On Thu, Oct 16, 2025 at 02:55:28PM +0200, Danilo Krummrich wrote:
> The driver model defines the lifetime of the private data stored in (and
> owned by) a bus device to be valid from when the driver is bound to a
> device (i.e. from successful probe()) until the driver is unbound from
> the device.
> 
> This is already taken care of by the Rust implementation of the driver
> model. However, we still ask drivers to return a Result<Pin<KBox<Self>>>
> from probe().
> 
> Unlike in C, where we do not have the concept of initializers, but
> rather deal with uninitialized memory, drivers can just return an
> impl PinInit<Self, Error> instead.
> 
> This contributed to more clarity to the fact that a driver returns it's
> device private data in probe() and the Rust driver model owns the data,
> manages the lifetime and - considering the lifetime - provides (safe)
> accessors for the driver.
> 
> Hence, let probe() functions return an impl PinInit<Self, Error> instead
> of Result<Pin<KBox<Self>>>.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Depends on a minor pin-init patch [1] (Benno will send it to the list
> soon). A branch with this patch and the pin-init dependency is available
> in [2].
> 
> [1] https://github.com/Rust-for-Linux/pin-init/pull/86/commits
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=probe_return

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

