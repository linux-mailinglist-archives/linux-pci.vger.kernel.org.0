Return-Path: <linux-pci+bounces-31676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52145AFC8DA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D17A79BE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347AD2D8DC3;
	Tue,  8 Jul 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOQyA5Yk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282C28506C;
	Tue,  8 Jul 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971794; cv=none; b=EVZjAOiTVxV7cwDi+GStnvWu1YZ77s6KgMVNrSttoUix3Az9jIMJmyYvPonhQzCdK8ERRrEhpY6t7NB6ayfEXt9okSM83L+CoCYt30ZI+5WrzgL9hLUUO8W1WqSb7LfZxMz7HJav7CPHVHZLR8qpppGRyRwxrDgQy73rZnPs5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971794; c=relaxed/simple;
	bh=37xDEW2cbwVOAhsd/ghW/u9fv5RoObesVX3ZY4J3Vhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDeMOpO+s62v3K1QNMW6U0tVEDn+h1et84/j+2uGE4gP4dtd5Xrx7tEIlEutr2XHAC6mHTHDOrdN0RWc0LHnUjvXHHhNLRwChJGjCClvRFe1e4sZ8A/lxUzOquIHiLpn4JwxCgJPI56OgBJX9wHyg8mwGMfernsP24jm0orA28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOQyA5Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495AEC4CEF6;
	Tue,  8 Jul 2025 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751971793;
	bh=37xDEW2cbwVOAhsd/ghW/u9fv5RoObesVX3ZY4J3Vhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bOQyA5YkR9QfY5ZHcG/6WeMPqLlrXgJxRxZIVszJ7aUrEiq+SNjLBOrNqzsrHBOu9
	 n0YB1tq16SL77F14wrV9ndk+pj7u9Uujiv2zEbBHUSIAdtSvvCm/88KxzevB37OtDa
	 6zz+wodMAyaVm4E6dbaOgBwEF7vZGi0GOe/fVfhNvNmD7cFcukBsQebALW50fHW/M6
	 mRWWcy5GtwwoJDtH8/OEL3u6o08vdz0inVHEknLLOHYHlKi43+6dw6MKje9XAPvCEa
	 mN210axmw+Nb4Q2PUoYnE2ILXGeMPZ9VubHOq5u5Wpoq44WbiX3cXGiYeLEbMtO0BZ
	 6qE3Nr7L+nouA==
Message-ID: <1b9754c7-b9ad-4b01-8476-3d8367a49635@kernel.org>
Date: Tue, 8 Jul 2025 12:49:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
To: Jakub Kicinski <kuba@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 gregkh@linuxfoundation.org, ojeda@kernel.org, rafael@kernel.org,
 robh@kernel.org, saravanak@google.com, a.hindborg@kernel.org,
 aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, david.m.ertman@intel.com, devicetree@vger.kernel.org,
 gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lossin@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 tmgross@umich.edu
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250707175350.1333bd59@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250707175350.1333bd59@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 2:53 AM, Jakub Kicinski wrote:
> On Fri,  4 Jul 2025 13:10:00 +0900 FUJITA Tomonori wrote:
>> The PHY abstractions have been generating their own device tables
>> manually instead of using the module_device_table macro provided by
>> the device_id crate. However, the format of device tables occasionally
>> changes [1] [2], requiring updates to both the device_id crate and the custom
>> format used by the PHY abstractions, which is cumbersome to maintain.
> 
> Does not apply to networking trees so I suspect someone else will take
> these:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

I gave an Acked-by: for patch 1, but can also take it through the driver-core
tree.

- Danilo

