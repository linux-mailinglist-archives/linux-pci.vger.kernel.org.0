Return-Path: <linux-pci+bounces-23814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8237A62922
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 09:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D433BDFB4
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B267189BB5;
	Sat, 15 Mar 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aTj4j7Ci"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA563D;
	Sat, 15 Mar 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742027736; cv=none; b=P8Y0ZiimZ2ygrEqzMCJIL+ZW84fmeBhJTyjR1AdWw0OEcmLQZxm/jA7H0vBObXTwRkW3n25+KTy1TvAL8SeCVFzh6JYisM0KSosf3CkHkW/fE2ZUFO1PJe02QGWD9iJ2HsCIwqIAJhqEqGKrYNIdgVWHPNbA6CuQnQFodfhL5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742027736; c=relaxed/simple;
	bh=gGvj+RQikv/qve5a0SnbR24cW69tZEUx8IeMxKXguXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgDJSvZ4dHVZMPR86uVOKFmLpHzhbRd7dIZOF9qiahzlSSBGxRpE4OJtawAoPbsZXvJvkkIXlD3ZngeX/ygZMUAAZNIfQr2C7q9qZWRdSjDnrcLGxjx3gxzt6NZv8X+q+zwru9IuECV0TdheEUfRDYQjdorN+sqdmjZ0rMP47+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aTj4j7Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5C3C4CEE5;
	Sat, 15 Mar 2025 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742027735;
	bh=gGvj+RQikv/qve5a0SnbR24cW69tZEUx8IeMxKXguXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTj4j7Cisry+Rzb4/p0JV5+7AdBCFvOHHx1vLOHQFuA8nf4A4MpdkCvEZVUCYMr+X
	 +CPmjq9LkJ4U8pyGX6J5e0URJJ/bOrbFd6VFI09RVkXKflhabY/tW2bA32oJRX+8Sl
	 Sw6kdoVeIXwEYh9x5qzhBiGEFkLrewgkvj6GideU=
Date: Sat, 15 Mar 2025 09:34:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Improve soundness of bus device abstractions
Message-ID: <2025031542-starry-finally-1a2c@gregkh>
References: <20250314160932.100165-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314160932.100165-1-dakr@kernel.org>

On Fri, Mar 14, 2025 at 05:09:03PM +0100, Danilo Krummrich wrote:
> Currently, when sharing references of bus devices (e.g. ARef<pci::Device>), we
> do not have a way to restrict which functions of a bus device can be called.
> 
> Consequently, it is possible to call all bus device functions concurrently from
> any context. This includes functions, which access fields of the (bus) device,
> which are not protected against concurrent access.
> 
> This is improved by applying an execution context to the bus device in form of a
> generic type.
> 
> For instance, the PCI device reference that is passed to probe() has the type
> pci::Device<Core>, which implements all functions that are only allowed to be
> called from bus callbacks.
> 
> The implementation for the default context (pci::Device) contains all functions
> that are safe to call from any context concurrently.
> 
> The context types can be extended as required, e.g. to limit availability  of
> certain (bus) device functions to probe().
> 
> A branch containing the patches can be found in [1].
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
> 
> Changes in v2:
>   - make `DeviceContext` trait sealed
>   - impl From<&pci::Device<device::Core>> for ARef<pci::Device>
>   - impl From<&platform::Device<device::Core>> for ARef<platform::Device>
>   - rebase onto v6.14-rc6
>   - apply RBs
> 
> Danilo Krummrich (4):
>   rust: pci: use to_result() in enable_device_mem()
>   rust: device: implement device context marker
>   rust: pci: fix unrestricted &mut pci::Device
>   rust: platform: fix unrestricted &mut platform::Device
> 
>  rust/kernel/device.rs                |  26 +++++
>  rust/kernel/pci.rs                   | 137 +++++++++++++++++----------
>  rust/kernel/platform.rs              |  95 +++++++++++++------
>  samples/rust/rust_driver_pci.rs      |   8 +-
>  samples/rust/rust_driver_platform.rs |  11 ++-
>  5 files changed, 187 insertions(+), 90 deletions(-)

Thanks for doing this work, looks good to me.  Mind if I suck it into
the driver-core tree now?  Or do you want it to go through a different
tree?

thanks,

greg k-h

