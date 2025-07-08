Return-Path: <linux-pci+bounces-31677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80565AFC90C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 12:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE83AF105
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7172D8779;
	Tue,  8 Jul 2025 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuL/1M0y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1711F8725;
	Tue,  8 Jul 2025 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972349; cv=none; b=pq3EFtSUaSwE0PGxKk4gOyWaU2F7l3hzxwcXU8WilF8wwfGr1yOvmpTHyWNqNGVajYD7PJ/f97sSPH6kz3ZTIyThuog0aTTl1nJgR/0RIarddgJsp/mcUU92DHsGhZrAXiiNeHHRDAqNaxiEixvrrH70PNVSK6A9yc62sUFZqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972349; c=relaxed/simple;
	bh=qKCgCVY7kyXYk8jgYBoQ3UZJP+J9pPy5BMrmaW1763E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N86Qw7DUbayzl3Yd1/8QSVzaFC/hLLjSWx4vWhli4rkSGbLL+YwR61Sp/R9jvJKOoxRn4XmF2rq4bPb7wsIU5eoXuM+lV0f6XvoP0pxuBBgNP/kN002xeOXUZSsAT0Ozt/9zf7NUdy1PHWXRraLFkfjcTzX+JEFcN8xNQyw+y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuL/1M0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F60C4CEED;
	Tue,  8 Jul 2025 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751972348;
	bh=qKCgCVY7kyXYk8jgYBoQ3UZJP+J9pPy5BMrmaW1763E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QuL/1M0y63Iw+tmPG/Ziz2leHMcLeIcTw22m4Sy6+go/jxR62Q6Fn+lV10t3GdDRw
	 /zUgoHX1JWOMvsNef822McuXDjg4sjkMUErn3Y1I9Uy1xjbZ0VwBzk+zwoDUztkaPF
	 GEy9IcOlnRIRH2cbi4mvNElXSO8Er/CBfpV0gqExOzASAjDWxYAnaryp+Xwlc5/O6p
	 ooVz0uE2Zj8EC3hC/9LgDGzhb5NbSnLP6Oiuz+rOgx06WbvZomMLVbv+wJK+Gqy0Qk
	 5XNL+jHjjSErLpsmsFDvj5u9xItSNGoTAVv/Lq6jUSz1bUv2CKyMTvvDtzGaObtYHL
	 uWEEzbqnC6mbQ==
Message-ID: <fcfdf9c1-288c-40ce-a8cc-77f540b981b0@kernel.org>
Date: Tue, 8 Jul 2025 12:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, gregkh@linuxfoundation.org,
 robh@kernel.org, saravanak@google.com,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 ojeda@kernel.org, rafael@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, david.m.ertman@intel.com, devicetree@vger.kernel.org,
 gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lossin@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 tmgross@umich.edu
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250707175350.1333bd59@kernel.org>
 <CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/25 12:45 PM, Miguel Ojeda wrote:
> On Tue, Jul 8, 2025 at 2:53 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> Does not apply to networking trees so I suspect someone else will take
>> these:
>>
>> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks! Happy to take it through Rust tree if that is best.

Ah, didn't get this one before I replied in [1]. I gave an ACK because I thought 
it's going through the networking tree, but I can also take it through driver-core.

Taking it through the rust tree is fine for me too; just let me know. :)

[1] https://lore.kernel.org/lkml/1b9754c7-b9ad-4b01-8476-3d8367a49635@kernel.org/

