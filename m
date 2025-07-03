Return-Path: <linux-pci+bounces-31468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD0AF832A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 00:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C3F7AF6E9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47159233D9E;
	Thu,  3 Jul 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7wcnWH5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204F1DF985;
	Thu,  3 Jul 2025 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751580926; cv=none; b=ZaEq04Sx4+Zo9s60wXAoUJoKJghyzN1/ZnbW7lCnxTmjmkUke5ZDfd7FU9igNEkGp+3E486hu3qzUXDJxEa6GdgV+rV8lqQrV2tW1boHWdYh/ytxt+VazXw2W6uIKLtrC5EtKlJ65OwRfZ93EZKuDUSwB1WwSqS25SojlD4jLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751580926; c=relaxed/simple;
	bh=Eb+gDRBV8zsdTjqzbYxzjH0tSA1S2PkkmHytpR+om3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKy05fHrg63i63xC9sn93sOJIM3jtw+XkMJBnOkI8NlKeN0o65Ayf6cgfVkv8UrLJAgXwiyA+awEC8Hb3cIdm60htQDRIAOy7KNls6BMqwpxMGzMgsPNOiwFV4l2GOQN4A9HP0XZX6tm/kDcPL3ws6SHF1Zwm5Myt4gTEkxUFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7wcnWH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12209C4CEE3;
	Thu,  3 Jul 2025 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751580925;
	bh=Eb+gDRBV8zsdTjqzbYxzjH0tSA1S2PkkmHytpR+om3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G7wcnWH5lY1yLVBoOraujbdvWmpNx/kq6lUK26PpaPEAuS72Q9g0ZmNXkHWZCYKXW
	 uCDKdUaadPVTIUlre7QjVKIBfUlEQuXX2xpZUgXyVGqrtOVAogLXHTIaea8P2Ljwd4
	 VGaXSLtpsI8aCbPShZ/T7i78CSyklhjk2e7bqxKtx6zCKE8xqb/vmWrtiJZkgeF01/
	 byP5tr33R8UO+CVM1djDL5tQLAh/zz/msXqHc+gsY7LWlha9iNBTZse2R2toEhH9Sf
	 XXBYVJJkGlqAKWvokJz1iTRBu7JPYxIaa0y4p6UUtiBi/mJl7GdFtOZ0c7v6/2npz0
	 V5SYDno61XL1w==
Message-ID: <64cec618-b883-4330-b1ba-5172f7790fe3@kernel.org>
Date: Fri, 4 Jul 2025 00:15:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] rust: device_id: make DRIVER_DATA_OFFSET optional
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, gregkh@linuxfoundation.org, ojeda@kernel.org,
 rafael@kernel.org, robh@kernel.org, saravanak@google.com,
 a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
References: <20250623060951.118564-1-fujita.tomonori@gmail.com>
 <20250623060951.118564-2-fujita.tomonori@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250623060951.118564-2-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 8:09 AM, FUJITA Tomonori wrote:
> Enable support for device ID structures that do not contain
> context/data field (usually named `driver_data`), making the trait
> usable in a wider range of subsystems and buses.
> 
> Several such structures are defined in
> include/linux/mod_devicetable.h.
> 
> This refactoring is a preparation for enabling the PHY abstractions to
> use device_id trait.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

