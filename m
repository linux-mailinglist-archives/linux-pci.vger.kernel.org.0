Return-Path: <linux-pci+bounces-31962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6DB026E0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E45419E0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B221FF4D;
	Fri, 11 Jul 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdQ+/TOl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36919995E;
	Fri, 11 Jul 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272401; cv=none; b=I/fzDRbs+Zm6Gjd1XUZEXq6pZOyxohslqjlu/Znjof9YW/wtQRbZWTK5MsFZCQy+IAHbnY0BL/dK1yjXcModNBfN2WIclhh2GYJx6FwGY/nbbACG8f9wlAdUTUPX/d31G8Uhr/lzwIk1dlim6P1u8SjJMGMmBBT0y+eKJWE4aNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272401; c=relaxed/simple;
	bh=ZNNcFzRipWqzofqATgYvWqb1uZJlEkUcE28AXULW/VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqHBYs1myz9lDNRjB2UVQBMg1e8tFvfqzeZRjsIsUZBdXGl7isDw/jRBhvdDimpy+VzMLzJ8Lj9LLwH/cm5Mr+8/A2JjvCfn9hDIIoIlrOcE2DKI5ZTnZc77nRWIh35tL0MggLzgScy/AkDaw3aZjab9TwyTpL0Gf3G8HTrJ2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdQ+/TOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3398C4CEED;
	Fri, 11 Jul 2025 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752272401;
	bh=ZNNcFzRipWqzofqATgYvWqb1uZJlEkUcE28AXULW/VE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HdQ+/TOlwSXvOEhWjv9PvM3sB5j6JEp0QzCwNaT0I11ryUIPdBxSWiH4YO2Glm2JN
	 OaZ5tK42tXau/wQZ9Ojtb3ak+fRKM9gUbGOhHVN027JqPmkElS6HyS+BaJyNdoN7b9
	 SZL6FUCVvBcipsAKQuCAOBmEge6Dip89zlkrysm2d9fx3JpNGY4D0TiRPRDzLc+xyC
	 SsqL0/GZxd9ZOeAG2CC0BGbVogzSWsAaKoG7Ci2vspZ7yXZu96xiGLtc2s76X6eKZm
	 la0JCtV5I7AIzDwzGgYujMy4R7FmbChGuCwxt5xCEo4QrXF36fyHJl/mWGTgGPOIRQ
	 G9OgoLll/xo/w==
Message-ID: <83b1b2f4-f87c-4b3f-ab4d-84ec429abd79@kernel.org>
Date: Sat, 12 Jul 2025 00:19:54 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] rust: Build PHY device tables by using
 module_device_table macro
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, gregkh@linuxfoundation.org, ojeda@kernel.org,
 rafael@kernel.org, robh@kernel.org, saravanak@google.com, tmgross@umich.edu,
 a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, lenb@kernel.org, leon@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 6:09 AM, FUJITA Tomonori wrote:
> Build PHY device tables by using module_device_table macro.
> 
> The PHY abstractions have been generating their own device tables
> manually instead of using the module_device_table macro provided by
> the device_id crate. However, the format of device tables occasionally
> changes [1] [2], requiring updates to both the device_id crate and the custom
> format used by the PHY abstractions, which is cumbersome to maintain.
> 
> [1]: https://lore.kernel.org/lkml/20241119235705.1576946-14-masahiroy@kernel.org/
> [2]: https://lore.kernel.org/lkml/6e2f70b07a710e761eb68d089d96cee7b27bb2d5.1750511018.git.legion@kernel.org/
> 
> Danilo, I incorporated your fixes into the first patch and mentioned
> them in the commit message. Let me know if you'd rather take a
> different approach.

Thanks FUJITA -- no need to mention it though. :)

Did you forget to pick up Jakub's ACK or was this intentional?

- Danilo

