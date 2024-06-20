Return-Path: <linux-pci+bounces-9017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F89107F8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B3C1C20849
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA921AD4AF;
	Thu, 20 Jun 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FtHLF3ZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04131E48B;
	Thu, 20 Jun 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893191; cv=none; b=ZAc/CSE5p7i5TfnLwBertnLWi5A6WyfNkZNRebjHiXvGvaLJJg3V/GXtXqA2KopAclUJs6S935QI6QQbzofm+13ehUDiHZWsgomhCSG5UJCGXDWXQDDbdz0G5fiDkWSghel1zRgmY4u0OaNGL+b5fb12gCjUkoYznjHaHmSmuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893191; c=relaxed/simple;
	bh=n4tUnj4Eac6aj+hWgpJmqPCrRk3ihP2085hGyDuOXuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWuXIXL0qn5QR9AFxj2bPOD1QRkMjDALC6UhiGgB9x9mheOVb1CV/F8rIu+PPseheWG+5eXcffqL059ToY8AQSZcqHHtt/pvH5IURNg9yBU+ymn9BqONUOLfG3eNIq76azROv6JBRfgckPn0xDxt4baU72OfagYGZhpX9fuxtic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FtHLF3ZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB58C2BD10;
	Thu, 20 Jun 2024 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718893191;
	bh=n4tUnj4Eac6aj+hWgpJmqPCrRk3ihP2085hGyDuOXuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtHLF3ZOVju0xqDIklse7AyPztxmeh4jWGWWcyzOZdGlNnvUTiyc+I5gKy4Abp5UR
	 kaKhrK179HE+JUq2gl2oPVKUC/+orvYots3AOmDrEEtVo9U9XAx8O+tH/xluQnOfGi
	 8Tgx9vAK5DCib4e5M2+7wDIazhSmCEczTNyTA7KY=
Date: Thu, 20 Jun 2024 16:19:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 01/10] rust: pass module name to `Module::init`
Message-ID: <2024062038-backroom-crunchy-d4c9@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-2-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:47AM +0200, Danilo Krummrich wrote:
> In a subsequent patch we introduce the `Registration` abstraction used
> to register driver structures. Some subsystems require the module name on
> driver registration (e.g. PCI in __pci_register_driver()), hence pass
> the module name to `Module::init`.

I understand the need/want here, but it feels odd that you have to
change anything to do it.

> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/lib.rs           | 14 ++++++++++----
>  rust/kernel/net/phy.rs       |  2 +-
>  rust/macros/module.rs        |  3 ++-
>  samples/rust/rust_minimal.rs |  2 +-
>  samples/rust/rust_print.rs   |  2 +-
>  5 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index a791702b4fee..5af00e072a58 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -71,7 +71,7 @@ pub trait Module: Sized + Sync + Send {
>      /// should do.
>      ///
>      /// Equivalent to the `module_init` macro in the C API.
> -    fn init(module: &'static ThisModule) -> error::Result<Self>;
> +    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;

Why can't the name come directly from the build system?  Why must it be
passed into the init function of the module "class"?  What is it going
to do with it?

A PCI, or other bus, driver "knows" it's name already by virtue of the
build system, so it can pass that string into whatever function needs
that, but the module init function itself does NOT need that.

So I fail to understand why we need to burden ALL module init functions
with this, when only a very very very tiny subset of all drivers will
ever need to know this, and even then, they don't need to know it at
init module time, they know it at build time and it will be a static
string at that point, it will not be coming in through an init call.

thanks,

greg k-h

