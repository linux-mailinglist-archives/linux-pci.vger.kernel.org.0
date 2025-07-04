Return-Path: <linux-pci+bounces-31487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EEAAF84FF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 02:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840D217948F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 00:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440A3FB1B;
	Fri,  4 Jul 2025 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0jXZv/J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59B2AEFD;
	Fri,  4 Jul 2025 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589906; cv=none; b=k6zZRU28+miT/nEy1kD6zWvPavSdWP6opwURs3E9XxpJB/+Lf5UPkVpNKIPrj+o+a8/tFwhSU6Qrhis4l26t69XDE99OiicNcmbYFzuuZcDN05aEJEG1b2h0W6oDjL5DJsXoYUP0hfWCoZNHzpYKDBc2lv6xVy6dmAPkMWZZM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589906; c=relaxed/simple;
	bh=x4AmA2Vgk3IOJCey+Z/XynRFoRbv3YCP77LijBksTWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kySh/ovUa45b6pTKd4ellGptWUS3FZL2o/lSrDeps8VsfQR7Ok4M+bxcoKvOSGUmwf2mIBoaECxVQSGOA3U/5wi8Rp5tjFN4hEbW0O/r4RAbl1V2BDh3klCxfLqCtmuJmMCXFkcJCrVJYUofmJ6rObVPv6ij2rwR5qA6BkZjxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0jXZv/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46A7C4CEE3;
	Fri,  4 Jul 2025 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751589905;
	bh=x4AmA2Vgk3IOJCey+Z/XynRFoRbv3YCP77LijBksTWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0jXZv/JsSEoXrLgaZezrbAQfnqdDJ5hah0Dud1hK14CYyAUzjtHe/nnBhmLi5QOt
	 KZE8pmdg1araHaCN1EqnQSMpuE4NO0bxo5Mvxl5sDzkRHttvGCcOSJWbynfiSsPiWf
	 aXsnijRPX+el1D+mpyNLOh1oTl99K9G6/JzGtbJ6nJvvP/eb7fdMgrW86BljhR3JW/
	 kNq1sD56w6PLon5VNNxeFeb7x7TeXE/8lM8Fv0UyQ5jNr5FlQcBZFrtdeuwLaCZBWu
	 ipy0WVl9y7/cPnuWkoeH63AneG9p+dHz4+2TjH+r8JhdxxjlIag6FhFLAtsu/DR/gv
	 AzAbb3LNS9QBQ==
Date: Fri, 4 Jul 2025 02:44:57 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, gregkh@linuxfoundation.org, ojeda@kernel.org,
	rafael@kernel.org, robh@kernel.org, saravanak@google.com,
	a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
	david.m.ertman@intel.com, devicetree@vger.kernel.org,
	gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lossin@kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v2 1/3] rust: device_id: split out index support into a
 separate trait
Message-ID: <aGckCY3BiPRCPmS7@pollux>
References: <20250701141252.600113-1-fujita.tomonori@gmail.com>
 <20250701141252.600113-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701141252.600113-2-fujita.tomonori@gmail.com>

On Tue, Jul 01, 2025 at 11:12:50PM +0900, FUJITA Tomonori wrote:
> +// SAFETY:
> +// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.

Here and for a few other occurances, this doesn't need to be a list, since it's
just a single item.

> +/// Extension trait for [`RawDeviceId`] for devices that embed an index or context value.
> +///
> +/// This is typically used when the device ID struct includes a field like `driver_data`
> +/// that is used to store a pointer-sized value (e.g., an index or context pointer).
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +///   - `DRIVER_DATA_OFFSET` is the correct offset (in bytes) to the context/data field (e.g., the
> +///     `driver_data` field) within the raw device ID structure. This field must be correctly sized
> +///     to hold a `usize`.
> +///
> +///     Ideally, the data should ideally be added during `Self` to `RawType` conversion,

Remove one of the duplicate "ideally".

> +///     but there's currently no way to do it when using traits in const.
> +///
> +///   - The `index` method must return the value stored at the location specified
> +///     by `DRIVER_DATA_OFFSET`, assuming `self` is layout-compatible with `RawType`.

I think technically this safety requirement isn't needed.

With this:

	Acked-by: Danilo Krummrich <dakr@kernel.org>

