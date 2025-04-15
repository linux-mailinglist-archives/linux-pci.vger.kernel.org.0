Return-Path: <linux-pci+bounces-25958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3EBA8A987
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 22:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E9F175CD0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A8D2550C2;
	Tue, 15 Apr 2025 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPsc8Lfh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D46253345;
	Tue, 15 Apr 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749878; cv=none; b=rDulNjTaqtR4lF6J0za6/+odwcfT8pQ6Gw8AnU8P+mWqmBsbFBhvEo37z1YvxDtSdlv0LBCHAfgUH2WmvoXF4GQmJk3CBh6qr+4+KWZ6YFK+JPAN5AVhZHcA+kUaiKsoTVE60zpSYxTnatFacBjRlzAM0stU90+G9xOniP2XNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749878; c=relaxed/simple;
	bh=SYCVZ5jNZO/onkmDY8uNkxGPskd/fCuKLzEqkOrgpYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R7f6cST3xP1DNp2Fw6fHN0WneFCQi/TKnEKWlRCFRf/5550iWPM6lnEKJw9iOrvRqq56+EpL37sT/i97SQO68HhjLm4gsQOZuobO1PAcFd4SfpTEmM77Su+NoeYgX85xHTS+gODiESVlB18ITxKenDRulayqxCKMfKOorv3IB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPsc8Lfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6B3C4CEE7;
	Tue, 15 Apr 2025 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749877;
	bh=SYCVZ5jNZO/onkmDY8uNkxGPskd/fCuKLzEqkOrgpYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MPsc8LfhaIu9c2EfngiVBmCw71aF8FF9ItvxkUYSV/18TweuQ5ysP5e71/1uy3dt8
	 G5hwXE/x0sOHW5qEw8WyMZHjKQoDrjkKqU5q5AUBIZQhXo05SKtdohjkR/XYJUAIeg
	 PQfrQZeoIADzNhf/MmH96EFAteniYaO/QdXs3GO7wjMbh8cAw9LLA20xuGNlCr1bI3
	 B66oOWPKYL3pLo/szuu1uOhchlwARoZ3Dp0T5mKNj0OVH+rcn8m84mnNRWdDCg2ra8
	 9ufkA7af58pdim7RqrLALfB9BLcgubm7wHE+zltXA7XnFLKsPgPcPWy10ajV6Z1o0m
	 2SDzHoNvSPt/w==
Date: Tue, 15 Apr 2025 15:44:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, robin.murphy@arm.com,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <20250415204436.GA34981@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413173758.12068-7-dakr@kernel.org>

On Sun, Apr 13, 2025 at 07:37:01PM +0200, Danilo Krummrich wrote:
> The Bound device context indicates that a device is bound to a driver.
> It must be used for APIs that require the device to be bound, such as
> Devres or dma::CoherentAllocation.
> 
> Implement Bound and add the corresponding Deref hierarchy, as well as the
> corresponding ARef conversion for this device context.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 487211842f77..585a3fcfeea3 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -232,13 +232,19 @@ pub trait DeviceContext: private::Sealed {}
>  /// any of the bus callbacks, such as `probe()`.
>  pub struct Core;
>  
> +/// The [`Bound`] context is the context of a bus specific device reference when it is guranteed to
> +/// be bound for the duration of its lifetime.

s/guranteed/guaranteed/

