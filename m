Return-Path: <linux-pci+bounces-39269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B261C06C5D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A993BB48B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A4238C23;
	Fri, 24 Oct 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry+1iy3O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241C225408;
	Fri, 24 Oct 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317310; cv=none; b=GgX04guSGj9MZtqd1M49OSEzmzadwKiyFRZmfv2zQ+ZCvSIA248+lyrjEW87m1d1Hmv4An+hOK5yupRmBSGhiBrcblTEw9kqsAEA1Fq2KEsfUkIpZl7nyMaG+OoNyMvdxNO2uRFJAFvBchbPEBog1WXGkx542rtEdIRTwrUfhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317310; c=relaxed/simple;
	bh=yucRPWpBAlIw6K56FcWbTwUYy1dZ38yWYpep+C7FIzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXNvvkJHhDSVEpuGyFWQ/TFJUWbFiUHcYMf0qmCZWFNW++pPoV/+b8UhBIfmqaBJmCwPRuFKLB/BAetS1LDqwnxZXvkaE0bAD5bNo6n+uVFsONcShARcriDc7/wQNc+aNSayiSI/Ceowvg1lVo1b+eF5zNUfdOFNvtTYCmYtZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry+1iy3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A6C4CEF5;
	Fri, 24 Oct 2025 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761317310;
	bh=yucRPWpBAlIw6K56FcWbTwUYy1dZ38yWYpep+C7FIzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ry+1iy3Ox8jeQMi1uEURaTgK+r191tZ80ALpEgM9G1mQ/eGlR8yJBslECtG5lV+J1
	 S3rXfE0BaHHAo56TE7p3HFYYHKNdC+cL9xTJYA/dCzOOXlrWG7PcYcrdQ+VTj9ysvW
	 6a5Z4eCk2TIwNXiZdU9Uz9Cu38F1q900W6fNX+2xXd/NnFrY46XxldkO71yQdbpydY
	 yRWS5K2/HUp0dm2Ap2y4iy+Y0lWC80oIPJXX/UkBfaenHYE+wTKd9oiRR3Ng+BnyAJ
	 iNFYoj4kEMnkB++r+McplCgmU6Q0hsCw0JqxhYOS3ssUFzC7h2Lungxhsb1og9d/qD
	 e5k4u7uRq70KQ==
Message-ID: <c2becbdf-1258-4a33-9fa9-3b63b53ad099@kernel.org>
Date: Fri, 24 Oct 2025 16:48:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] rust: Add trait to convert a device reference to a
 bus device reference
To: Markus Probst <markus.probst@posteo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251023172803.730677-1-markus.probst@posteo.de>
 <20251023172803.730677-2-markus.probst@posteo.de>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251023172803.730677-2-markus.probst@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 7:28 PM, Markus Probst wrote:
> +// SAFETY: `auxilary::Device` is a transparent wrapper of `struct auxiliary_device`.
> +// The offset is guaranteed to point to a valid device field inside `auxilary::Device`.

s/auxilary/auxiliary/

> +unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
> +    const OFFSET: usize = offset_of!(bindings::auxiliary_device, dev);
> +}

<snip>

> +/// Bus devices can implement this trait to allow abstractions to provide the bus device in
> +/// class device callbacks.

In the first line, please briefly mention what the trait represents.
Subsequently, you can mention the use-case below as a more general description.

> +///
> +/// This must not be used by drivers and is intended for bus and class device abstractions only.
> +///
> +/// # Safety
> +///
> +/// `AsBusDevice::OFFSET` must be a offset to a device field in the implemented struct.

"... the offset of the embedded base `struct device` field within a bus device
structure"

> +pub(crate) unsafe trait AsBusDevice<Ctx: DeviceContext>: AsRef<Device<Ctx>> {
> +    /// The relative offset to the device field.
> +    ///
> +    /// Use `offset_of!(bindings, field)` macro to avoid breakage.
> +    const OFFSET: usize;
> +
> +    /// Convert a reference to [`Device`] into `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `dev` must be contained in `Self`.
> +    unsafe fn from_device(dev: &Device<Ctx>) -> &Self
> +    where
> +        Self: Sized,
> +    {
> +        let raw = dev.as_raw();
> +        // SAFETY: `raw - Self::OFFSET` is guaranteed by the safety requirements
> +        // to be a valid pointer to `Self`.
> +        unsafe { &*raw.byte_sub(Self::OFFSET).cast::<Self>() }
> +    }
> +}


