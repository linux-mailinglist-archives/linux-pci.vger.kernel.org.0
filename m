Return-Path: <linux-pci+bounces-31148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF3AEF33F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5442F4A20BE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE58239E77;
	Tue,  1 Jul 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Blfen4Bi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D726A1DE;
	Tue,  1 Jul 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362011; cv=none; b=GtizhHgyzo3BFoBDFKr/dO5vi7o5kp7vQk/yHA5tYB8BfSTUTlCDu8G1UXH2mEDR3Q3za5/q2S3rr5LAlWwOEaLllvYnsm1AK60R2C4YkfXH6tCg+h3+togQaeyeEIdj7qB05vdaW+VjhfLkg7Qr4mdexXl9qbrznLibL2sTGrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362011; c=relaxed/simple;
	bh=XVDtWrwGsRf2D1Pcn9zPRRPHJof0gGW1U59MqvgZPC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4nNW8t9xl7VTeTvZEulpGjmRk7OKzs6YP0kznThFCyUYqQ35h8vE76N5UL6LqFJVyuKO1XOOV4cyTX5zk8YD02qqJZC/1K1VjFtECcixiM3mrWg4ymdrDmtX5tHUJZT8171q//vuMwPsJcKhVzHxsG/w0Y0nqKwGfwSiVlfj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Blfen4Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A243C4CEEB;
	Tue,  1 Jul 2025 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751362010;
	bh=XVDtWrwGsRf2D1Pcn9zPRRPHJof0gGW1U59MqvgZPC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Blfen4Bi/UVNcXN99j+WsLB/rMmhPkM7aFloqLC0X4ytqLTnAvG+O6e9q004M/rs+
	 cx7QytKEZ3/8hkxA+sHq2zG8r46cA6niljd3lv85aEBzCX8RaqCaG89EPmtFslh9gq
	 kgQnCcdbQDmvIJ/byxKQ4smyVW01KC6QRAWdV2K0=
Date: Tue, 1 Jul 2025 11:26:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] rust: device: introduce device::Internal
Message-ID: <2025070110-renounce-blinks-b28f@gregkh>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621195118.124245-2-dakr@kernel.org>

On Sat, Jun 21, 2025 at 09:43:27PM +0200, Danilo Krummrich wrote:
> Introduce an internal device context, which is semantically equivalent
> to the Core device context, but reserved for bus abstractions.
> 
> This allows implementing methods for the Device type, which are limited
> to be used within the core context of bus abstractions, i.e. restrict
> the availability for drivers.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 665f5ceadecc..e9094d8322d5 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -261,6 +261,10 @@ pub trait DeviceContext: private::Sealed {}
>  /// any of the bus callbacks, such as `probe()`.
>  pub struct Core;
>  
> +/// Semantically the same as [`Core`] but reserved for internal usage of the corresponding bus
> +/// abstraction.
> +pub struct Internal;

Naming is hard :)

As this is ONLY for the bus code to touch, why not call it Bus_Internal?

And can a driver touch this, or only the bus owner?

thanks,

greg k-h

