Return-Path: <linux-pci+bounces-9024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB59108AE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6802F1C21379
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EC81AE09D;
	Thu, 20 Jun 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C4ODGsL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461A1AE08E;
	Thu, 20 Jun 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894582; cv=none; b=BBYAEyDXgqdy/THhyV+khsL6UICt7aH9IqTn4q8G3jL5rwC+oR4ztOxJ5twdk7xNHQdA6PHxPG2RtPaQMjKYr369onJime7VhpEkdGSFU7ehFzwS73OZTb0YBWicHDny6yumLhNFmYnYf/wX1OA+5VsNL5elN+fkgpGc+gfNEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894582; c=relaxed/simple;
	bh=LB3eFZ3LD9tM/98Tylvu0XN9sQddU39XYStL0neHiwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo8SB5TOZ7w3XZIatCleTh3jatOXxypXxsMlR+Pcv5Q1Jdz24+k+yeVA4Xi01rjcZimcTv+eU544qkXseNywjI+SvLMkBJcmD+EuBN4Nwzr8X3ajLBIsc/pW5mWSV+twntduLPZsBTbS7SeNj5kMtC/1XWPfhgJq2VcrmuMJEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C4ODGsL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460B6C32786;
	Thu, 20 Jun 2024 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718894581;
	bh=LB3eFZ3LD9tM/98Tylvu0XN9sQddU39XYStL0neHiwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4ODGsL/Ef11xCq326gF8VzwNYux96j10sxORRX03a7v0QYRyFY9D7GVy/vHiNCNG
	 lVjILevGVjfbLKQMSK8iMFUE+K5h5ioXx4S8rnCZMoYY1lGSfRuHS6/j5mgCLbCXwo
	 bEtPuqSnV9/u16G4yr9PUjaFdHbe0UbdQrFvXHvU=
Date: Thu, 20 Jun 2024 16:42:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v2 06/10] rust: add `dev_*` print macros.
Message-ID: <2024062030-babble-financial-7043@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-7-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-7-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:52AM +0200, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> Implement `dev_*` print macros for `device::Device`.
> 
> They behave like the macros with the same names in C, i.e., they print
> messages to the kernel ring buffer with the given level, prefixing the
> messages with corresponding device information.

Nice, but one issue:

> +    /// Prints a debug-level message (level 7) prefixed with device information.
> +    ///
> +    /// More details are available from [`dev_dbg`].
> +    ///
> +    /// [`dev_dbg`]: crate::dev_dbg
> +    pub fn pr_dbg(&self, args: fmt::Arguments<'_>) {
> +        if cfg!(debug_assertions) {

That should not be an issue here.  debug_assertions is something
independent of dev_dbg() calls.  You made this a Rust-only thing, that
doesn't tie properly into the existing dynamic printk functionality by
having yet-another-way to turn this on/off, right?

So just remove the check please.

And if you want to send this as a single patch after fixing this, I'll
be glad to add it to the tree now, as it's "obviously" correct :)

thanks,

greg k-h

