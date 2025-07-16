Return-Path: <linux-pci+bounces-32252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BCB07176
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 11:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39F57AE369
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29C2EF9C8;
	Wed, 16 Jul 2025 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9udJBz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3E28A1C8;
	Wed, 16 Jul 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657559; cv=none; b=J9qF8wbTTATUEQatOdBw7eIJhTLyzio5dUeOd07CLD6CUIowv9FveVizeo4SXRa2x/VwkrEdSYMVmLbJtukSgUV55sJIar0xCXAwGJX5s+X2usomPI2xJvuD7GJAsU5BKTAPkp1Wp0AdIOvaGFwRXbhzQCBGyzSKcf+cAJICVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657559; c=relaxed/simple;
	bh=g5M4DpBVQH07/jGuPHNWNcGzZLf3cxeneqrXpulpu2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVlOtRI55IP1SuL3rsxEu3K13vfh152KLigFNnAnJJ1qMhnBAt4SkA8w5t4JL5/fcYJcafVDU3UYxSIKuHtDzT6Fs2jbm2YdJ9UAAuS0Es3t+5234qAcIdzI8W4kDzePLP15HGXYWltI67h4x1+52JHcwDXYuQbrofJk8UiD8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9udJBz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC09C4CEF0;
	Wed, 16 Jul 2025 09:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752657557;
	bh=g5M4DpBVQH07/jGuPHNWNcGzZLf3cxeneqrXpulpu2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9udJBz5nZcxDfwmUXs+fdNV+8yv55UAEnljdTtgpcm3HIpSkcNCQ/BHMyRqHQVDg
	 Fb73Ax+AWYbI2Z1cWc8TD/nPIvmQ4AaXkLWMvjjo75YB1WVqYgrlLKCHN82+buQhnz
	 WPQ50+L/T+7uc9ZR7tNamoSv11/VHYfBa09GSIC8=
Date: Wed, 16 Jul 2025 11:19:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, dakr@kernel.org, ojeda@kernel.org,
	rafael@kernel.org, robh@kernel.org, saravanak@google.com,
	tmgross@umich.edu, a.hindborg@kernel.org, aliceryhl@google.com,
	bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
	david.m.ertman@intel.com, devicetree@vger.kernel.org,
	gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org,
	lenb@kernel.org, leon@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lossin@kernel.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 1/3] rust: device_id: split out index support into a
 separate trait
Message-ID: <2025071607-theorize-charting-b29f@gregkh>
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
 <20250711040947.1252162-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711040947.1252162-2-fujita.tomonori@gmail.com>

On Fri, Jul 11, 2025 at 01:09:45PM +0900, FUJITA Tomonori wrote:
> Introduce a new trait `RawDeviceIdIndex`, which extends `RawDeviceId`
> to provide support for device ID types that include an index or
> context field (e.g., `driver_data`). This separates the concerns of
> layout compatibility and index-based data embedding, and allows
> `RawDeviceId` to be implemented for types that do not contain a
> `driver_data` field. Several such structures are defined in
> include/linux/mod_devicetable.h.
> 
> Refactor `IdArray::new()` into a generic `build()` function, which
> takes an optional offset. Based on the presence of `RawDeviceIdIndex`,
> index writing is conditionally enabled. A new `new_without_index()`
> constructor is also provided for use cases where no index should be
> written.
> 
> This refactoring is a preparation for enabling the PHY abstractions to
> use the RawDeviceId trait.
> 
> The changes to acpi.rs and driver.rs were made by Danilo.
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

