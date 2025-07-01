Return-Path: <linux-pci+bounces-31147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C7AEF339
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474764A2167
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8B26C38E;
	Tue,  1 Jul 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hn3kyDj7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E77239E77;
	Tue,  1 Jul 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361945; cv=none; b=cjGhVnNHu0fEc4ktoct7QM6IrMq2HfozMGYWtea4vhsy7mtGiTVopQpqH2nTlj8SoG9eT+wgtFIkhjYUObn9HXf/VtsE/M+5J8+/NHXioFfvXCDJrhTHyBObQuzYvIDxrGRVpDj20Cg6TDok91/26Ze6La5ec1usxL8rfOsmL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361945; c=relaxed/simple;
	bh=z+KKExR9QZEfhPKWlMVU+GWF8CnujGHmvd5zsO/4khk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx0A5Qbgpw/R46/3K6plg/qVP+2lep81+hji2u7b5gMUstQJPUgjgE5AlWHQQSShYItRRewW4KIx/YlenFnNeSNaP+u/1zCE5SPDgoM21uN1tOo1dImxgOdfYVYjOlBArcAJwFi+1pprbPZbZEqYXwVHVzpjDD3kV1rYm0zAPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hn3kyDj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF24EC4CEEB;
	Tue,  1 Jul 2025 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751361944;
	bh=z+KKExR9QZEfhPKWlMVU+GWF8CnujGHmvd5zsO/4khk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hn3kyDj7CsezqKd1fMVEJDBwB1Dy0VOx4XEUakfIU6n7EDovnxCERFwBsFGOfNyZC
	 yR3c2tdhsEC1F80m/+tGCcclD6cRE2WRkGy14X25E9OyNCfi1tZLqeXVO7USHWcKxN
	 EhrGCePeDpb0RDe2kPM5pUm6sodKac+pAHNuDsQ0=
Date: Tue, 1 Jul 2025 11:25:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] Device: generic accessors for drvdata +
 Driver::unbind()
Message-ID: <2025070142-difficult-lucid-d949@gregkh>
References: <20250621195118.124245-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621195118.124245-1-dakr@kernel.org>

On Sat, Jun 21, 2025 at 09:43:26PM +0200, Danilo Krummrich wrote:
> This patch series consists of the following three parts.
> 
>   1. Introduce the 'Internal' device context (semantically identical to the
>      'Core' device context), but only accessible for bus abstractions.
> 
>   2. Introduce generic accessors for a device's driver_data  pointer. Those are
>      implemented for the 'Internal' device context only, in order to only enable
>      bus abstractions to mess with the driver_data pointer of struct device.
> 
>   3. Implement the Driver::unbind() callback (details below).
> 
> Driver::unbind()
> ----------------
> 
> Currently, there's really only one core callback for drivers, which is
> probe().
> 
> Now, this isn't entirely true, since there is also the drop() callback of
> the driver type (serving as the driver's private data), which is returned
> by probe() and is dropped in remove().
> 
> On the C side remove() mainly serves two purposes:
> 
>   (1) Tear down the device that is operated by the driver, e.g. call bus
>       specific functions, write I/O memory to reset the device, etc.
> 
>   (2) Release the resources that have been allocated by a driver for a
>       specific device.
> 
> The drop() callback mentioned above is intended to cover (2) as the Rust
> idiomatic way.
> 
> However, it is partially insufficient and inefficient to cover (1)
> properly, since drop() can't be called with additional arguments, such as
> the reference to the corresponding device that has the correct device
> context, i.e. the Core device context.

I'm missing something, why doesn't drop() have access to the device
itself, which has the Core device context?  It's the same "object",
right?

> This makes it inefficient (but not impossible) to access device
> resources, e.g. to write device registers, and impossible to call device
> methods, which are only accessible under the Core device context.
> 
> In order to solve this, add an additional callback for (1), which we
> call unbind().
> 
> The reason for calling it unbind() is that, unlike remove(), it is *only*
> meant to be used to perform teardown operations on the device (1), but
> *not* to release resources (2).

Ick.  I get the idea, but unbind() is going to get confusing fast.
Determining what is, and is not, a "resource" is going to be hard over
time.  In fact, how would you define it?  :)

Is "teardown" only allowed to write to resources, but not free them?  If
so, why can't that happen in drop() as the resources are available there.

I'm loath to have a 2-step destroy system here for rust only, and not
for C, as maintaining this over time is going to be rough.

thanks,

greg k-h

